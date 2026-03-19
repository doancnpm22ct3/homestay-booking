<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Booking;
use App\Models\Room;

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
            'check_in_date' => $request->check_in_date,
            'check_out_date' => $request->check_out_date,
            'adults' => $request->adults ?? 1,
            'children' => $request->children ?? 0,
            'status' => 'pending', 
            'source' => 'website',
            'subtotal' => $request->total_price,
            'total_amount' => $request->total_price,
            'paid_amount' => $request->deposit_amount
        ]);

        // 2. Tự động đổi trạng thái phòng thành "Đã đặt cọc" (booked)
        $room = Room::find($request->room_id);
        if ($room) {
            $room->status = 'booked';
            $room->save();
        }

        return response()->json([
            'message' => '🎉 Đặt phòng và thanh toán cọc thành công!',
            'booking' => $booking
        ], 201);
    }
}