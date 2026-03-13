<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Booking;

class AdminBookingController extends Controller
{
    // 1. LẤY DANH SÁCH HÓA ĐƠN

    public function index()
    {
       
        $bookings = Booking::orderBy('id', 'desc')->get()->map(function ($booking) {

            $booking->time_vn = $booking->created_at->format('H:i - d/m/Y');
            return $booking;
        });

        return response()->json($bookings);
    }

    // 2. CHỐT CHECKOUT & THANH TOÁN TOÀN BỘ
    public function checkout($id)
    {
        $booking = Booking::find($id);
        if (!$booking) {
            return response()->json(['message' => 'Không tìm thấy hóa đơn!'], 404);
        }

        // Đổi trạng thái thành đã thanh toán toàn bộ
        $booking->payment_status = 'completed';
        $booking->status = 'confirmed'; // Tự động xác nhận booking
        $booking->paid_amount = $booking->total_amount; // Cập nhật payment amount
        $booking->save();

        // TẠM THỜI MÔ PHỎNG GỬI MAIL (Sau này sếp tích hợp gửi Gmail thật vào đây)
        // Mail::to($booking->customer_email)->send(new CheckoutInvoiceMail($booking));

        return response()->json([
            'message' => 'Checkout thành công! Đã ghi nhận thanh toán toàn bộ và (mô phỏng) gửi hóa đơn về mail khách.',
            'booking' => $booking
        ]);
    }

    // 3. XÓA HÓA ĐƠN (Nếu khách bùng cọc)
    public function destroy($id)
    {
        Booking::destroy($id);
        return response()->json(['message' => 'Đã xóa hóa đơn!']);
    }
}