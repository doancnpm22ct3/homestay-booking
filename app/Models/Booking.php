<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Booking extends Model
{
    use HasFactory;

    // Khai báo các cột được phép thêm dữ liệu
    protected $fillable = [
        'booking_code', 
        'customer_name', 
        'customer_email', 
        'customer_phone', 
        'room_name', 
        'total_price', 
        'deposit_amount', 
        'payment_status'
    ];
}