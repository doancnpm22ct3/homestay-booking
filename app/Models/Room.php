<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Room extends Model
{
    // Tắt timestamps nếu trong DB bạn tự set DEFAULT CURRENT_TIMESTAMP chứ không dùng created_at/updated_at chuẩn của Laravel
    public $timestamps = false; 
    
    protected $fillable = [
        'title', 'location', 'type', 'price', 'max_guests', 'description', 'status','is_visible'
    ];

    // Khai báo mối quan hệ 1 Phòng có nhiều Ảnh
    public function images()
    {
        return $this->hasMany(RoomImage::class);
    }
}