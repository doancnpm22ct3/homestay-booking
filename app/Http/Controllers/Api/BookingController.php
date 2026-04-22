<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Booking;
use App\Models\Room;
use App\Http\Resources\BookingResource;
use Illuminate\Support\Facades\Mail;
use App\Mail\BookingConfirmed;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;
use Illuminate\Support\Facades\Notification;

class BookingController extends Controller
{
    // HÀM LƯU ĐƠN ĐẶT PHÒNG TỪ KHÁCH
    public function store(Request $request)
    {
        $request->validate([
            'customer_name' => 'required|string|max:255',
            'room_id' => 'required|exists:rooms,id',
            'check_in_date' => 'required|date|after_or_equal:today',
            'check_out_date' => 'required|date|after:check_in_date',
        ], [
            'check_in_date.after_or_equal' => 'Ngày nhận phòng không thể chọn ở trong quá khứ.',
            'check_out_date.after' => 'Ngày trả phòng phải sau ngày nhận phòng.'
        ]);

        $booking = Booking::create([
            'booking_code' => 'HD-' . strtoupper(uniqid()), // Tạo mã hóa đơn ngẫu nhiên (VD: HD-64A1B...)
            'customer_name' => $request->customer_name,
            'customer_email' => $request->customer_email,
            'customer_phone' => $request->customer_phone,
            'room_name' => $request->room_name,
            'total_price' => $request->total_price,
            'deposit_amount' => $request->deposit_amount,
            'payment_status' => 'deposited', // Mặc định là đã cọc
            // Dữ liệu cho Module Quản Lý Booking:
            'customer_id' => auth()->id() ?? null,
            'room_id' => $request->room_id,
            'voucher_id' => $request->voucher_id ?? null, // Thêm voucher_id
            'check_in_date' => $request->check_in_date,
            'check_out_date' => $request->check_out_date,
            'adults' => $request->adults ?? 1,
            'children' => $request->children ?? 0,
            'status' => 'pending', 
            'source' => 'website',
            'subtotal' => $request->subtotal ?? $request->total_price,
            'total_amount' => $request->total_price,
            'paid_amount' => $request->deposit_amount
        ]);

        // 2. Tự động đổi trạng thái phòng thành "Đã đặt cọc" (booked)
        $room = Room::find($request->room_id);
        if ($room) {
            $room->status = 'booked';
            $room->save();
        }

        // 3. Xử lý Voucher và Điểm thưởng nếu đã đăng nhập
        $user = auth()->user();
        if ($user) {
            // Đánh dấu voucher đã sử dụng trong bảng pivot
            if ($request->voucher_id) {
                $user->vouchers()->updateExistingPivot($request->voucher_id, [
                    'is_used' => true,
                    'used_at' => now()
                ]);
            }

            // Cộng điểm thưởng: 100.000 VNĐ = 1 điểm
            $earnedPoints = floor($request->total_price / 100000);
            if ($earnedPoints > 0) {
                $user->increment('points', $earnedPoints);
            }
        }

        // 4. Thông báo cho Admin (Database)
        try {
            $adminUsers = \App\Models\User::where('role', 'admin')->get();
            \Illuminate\Support\Facades\Notification::send($adminUsers, new \App\Notifications\NewBookingAdmin($booking));
        } catch (\Exception $e) {
            \Log::error("Thông báo Admin thất bại: " . $e->getMessage());
        }

        // 5. Gửi email xác nhận đặt phòng cho khách
        try {
            Mail::to($booking->customer_email)->send(new BookingConfirmed($booking));
        } catch (\Exception $e) {
            \Log::error("Gửi mail cho khách thất bại (Có thể do chưa cấu hình SMTP): " . $e->getMessage());
        }

        return response()->json([
            'message' => '🎉 Đặt phòng và thanh toán cọc thành công! Email xác nhận đã được gửi.',
            'booking' => new BookingResource($booking)
        ], 201);
    }

    // LẤY LỊCH SỬ ĐẶT PHÒNG CỦA USER
    public function myHistory()
    {
        $user = auth()->user();
        if (!$user) {
            return response()->json(['message' => 'Vui lòng đăng nhập'], 401);
        }

        $bookings = Booking::where('customer_id', $user->id)
            ->with(['room.images', 'payments'])
            ->latest()
            ->get();

        return BookingResource::collection($bookings);
    }

    // KHÁCH HÀNG TỰ HỦY ĐẶT PHÒNG
    public function cancel(Request $request, $id)
    {
        $user = auth()->user();
        $booking = Booking::where('id', $id)
            ->where('customer_id', $user->id)
            ->firstOrFail();

        // Chỉ cho hủy khi chưa check-in
        if (!in_array($booking->status, ['pending', 'confirmed', 'deposited', 'booked'])) {
            return response()->json(['message' => 'Đơn hàng hiện tại không thể hủy. Vui lòng liên hệ Admin.'], 422);
        }

        $now = Carbon::now();
        $checkInDate = Carbon::parse($booking->check_in_date);
        $createdAt = Carbon::parse($booking->created_at);
        $daysToCheckIn = $now->diffInDays($checkInDate, false);
        $minutesSinceBooking = $now->diffInMinutes($createdAt);

        $refundPercent = 0;

        // Chính sách hủy phòng
        if ($minutesSinceBooking <= 30 || $daysToCheckIn >= 3) {
            $refundPercent = 1; // Hoàn 100%
        } elseif ($daysToCheckIn >= 1) {
            $refundPercent = 0.5; // Hoàn 50%
        } else {
            $refundPercent = 0; // Không hoàn tiền
        }

        $paidAmount = (int)$booking->paid_amount;
        $refundAmount = (int)($paidAmount * $refundPercent);

        DB::beginTransaction();
        try {
            $booking->update([
                'status' => 'cancelled',
                'cancel_reason' => $request->reason ?? 'Khách hàng tự hủy trên hệ thống',
                'cancelled_at' => $now,
                'refund_amount' => $refundAmount
            ]);

            // Ghi nhận giao dịch hoàn tiền nếu có
            if ($refundAmount > 0) {
                $booking->payments()->create([
                    'amount' => $refundAmount,
                    'payment_method' => 'transfer',
                    'payment_type' => 'refund',
                    'note' => 'Hoàn tiền tự động (chính sách hủy phòng)',
                    'recorded_by' => null // Tự động hệ thống
                ]);
            }

            // Giải phóng trạng thái phòng
            if ($booking->room) {
                $booking->room->update([
                    'status' => 'available',
                    'room_status' => 'available'
                ]);
            }

            $booking->logActivity('cancelled', "Khách hàng tự hủy. Hoàn tiền: " . number_format($refundAmount) . "đ");

            // Thông báo cho Admin
            $adminUsers = \App\Models\User::where('role', 'admin')->get();
            Notification::send($adminUsers, new \App\Notifications\BookingCancelledAdmin($booking));

            DB::commit();
            return response()->json([
                'message' => 'Hủy đặt phòng thành công!',
                'refund_amount' => $refundAmount,
                'booking' => new BookingResource($booking)
            ]);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->json(['message' => 'Có lỗi xảy ra: ' . $e->getMessage()], 500);
        }
    }
}