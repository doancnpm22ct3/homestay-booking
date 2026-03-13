<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Room extends Model
{
    // Tắt timestamps nếu trong DB bạn tự set DEFAULT CURRENT_TIMESTAMP chứ không dùng created_at/updated_at chuẩn của Laravel
    public $timestamps = false;

    protected $fillable = [
        'title',
        'location',
        'type',
        'price',
        'max_guests',
        'description',
        'status',
        'is_visible',
        // Booking management fields
        'room_number',
        'floor',
        'room_status',
        'room_status_updated_by',
        'out_of_order_reason',
        'estimated_fix_date',
    ];

    // Khai báo mối quan hệ 1 Phòng có nhiều Ảnh
    public function images()
    {
        return $this->hasMany(RoomImage::class);
    }

    // Một phòng có nhiều booking
    public function bookings()
    {
        return $this->hasMany(Booking::class);
    }

    // Scope: tìm phòng trống trong khoảng ngày
    public function scopeAvailable($query, $checkIn, $checkOut)
    {
        return $query->where('room_status', '!=', 'out_of_order')
            ->whereNotIn('id', function ($sub) use ($checkIn, $checkOut) {
                $sub->select('room_id')->from('bookings')
                    ->whereNotIn('status', ['cancelled', 'no_show'])
                    ->where('check_in_date', '<', $checkOut)
                    ->where('check_out_date', '>', $checkIn);
            });
    }
}