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
        // 1. Lưu hóa đơn vào DB
        $booking = Booking::create([
            'booking_code' => 'HD-' . strtoupper(uniqid()), // Tạo mã hóa đơn ngẫu nhiên (VD: HD-64A1B...)
            'customer_name' => $request->customer_name,
            'customer_email' => $request->customer_email,
            'customer_phone' => $request->customer_phone,
            'room_name' => $request->room_name,
            'total_price' => $request->total_price,
            'deposit_amount' => $request->deposit_amount,
            'payment_status' => 'deposited' // Mặc định là đã cọc
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