<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Room;
use App\Models\RoomImage;
use Illuminate\Support\Facades\DB;

class RoomController extends Controller
{
    public function index()
    {
        // Lấy tất cả phòng, sắp xếp mới nhất lên đầu, kèm theo hình ảnh
        $rooms = Room::with('images')->orderBy('id', 'desc')->get()->map(function($room) {
            
            // Tìm ảnh bìa (is_primary = 1), nếu không có thì lấy tạm ảnh đầu tiên
            $primaryImage = $room->images->where('is_primary', true)->first() 
                            ?? $room->images->first();

            // Trả về dữ liệu đúng chuẩn mà Vue đang cần
            return [
                'id' => $room->id,
                'title' => $room->title,
                'type' => $room->type,
                'price' => $room->price,
                'status' => $room->status,
                'is_visible' => $room->is_visible,
                'image' => $primaryImage ? $primaryImage->image_url : 'https://picsum.photos/seed/fallback/100/100'
            ];
        });

        return response()->json($rooms);
    }
    public function show($id)
    {
        $room = Room::with('images')->find($id);

        if (!$room) {
            return response()->json(['message' => 'Không tìm thấy phòng'], 404);
        }

        $amenities = DB::table('amenities')
            ->join('room_amenities', 'amenities.id', '=', 'room_amenities.amenity_id')
            ->where('room_amenities.room_id', $id)
            ->select('amenities.*')
            ->get();

        $room->amenity_list = $amenities;

        return response()->json($room);
    }
    public function update(Request $request, $id)
    {
        try {
            DB::beginTransaction();

            $room = Room::find($id);
            if (!$room) {
                return response()->json(['message' => 'Không tìm thấy phòng'], 404);
            }

            // 1. Cập nhật thông tin cơ bản (Đã bao gồm is_visible)
            $room->update([
                'title' => $request->title,
                'location' => $request->location,
                'type' => $request->type,
                'price' => $request->price,
                'max_guests' => $request->max_guests,
                'description' => $request->description,
                'status' => $request->status,
                'is_visible' => $request->is_visible === 'true' || $request->is_visible == 1 ? 1 : 0,
            ]);

            // 2. Cập nhật tiện nghi (Xóa sạch tiện nghi cũ của phòng này và lưu lại các tick mới)
            DB::table('room_amenities')->where('room_id', $id)->delete();
            if ($request->has('amenities')) {
                foreach ($request->amenities as $amenity_id) {
                    DB::table('room_amenities')->insert([
                        'room_id' => $id,
                        'amenity_id' => $amenity_id
                    ]);
                }
            }

            // 3. Upload thêm ảnh mới nếu admin có chọn thêm
            if ($request->hasFile('images')) {
                foreach ($request->file('images') as $key => $file) {
                    $path = $file->store('rooms', 'public');
                    RoomImage::create([
                        'room_id' => $room->id,
                        'image_url' => '/storage/' . $path,
                        'is_primary' => false
                    ]);
                }
            }

            DB::commit();
            return response()->json(['message' => 'Cập nhật phòng thành công!']);

        } catch (\Exception $e) {
            DB::rollBack();
            return response()->json(['error' => 'Lỗi khi cập nhật: ' . $e->getMessage()], 500);
        }
    }
    public function getAmenities()
    {
        // Kéo toàn bộ 7 tiện nghi từ DB lên
        $amenities = DB::table('amenities')->get();
        return response()->json($amenities);
    }
    // HÀM THỐNG KÊ SỐ LƯỢNG PHÒNG CHO ADMIN
    public function stats()
    {
        // Đếm tổng tất cả các phòng
        $total = \App\Models\Room::count();
        
        // Đếm theo từng trạng thái (Bạn có thể đổi chữ 'available', 'occupied'... cho khớp với Database của bạn)
        $available = \App\Models\Room::where('status', 'available')->count(); // Phòng trống
        $deposited = \App\Models\Room::where('status', 'deposited')->count(); // Đã đặt cọc
        $occupied = \App\Models\Room::where('status', 'occupied')->count();   // Đang sử dụng

        return response()->json([
            'total' => $total,
            'available' => $available,
            'deposited' => $deposited,
            'occupied' => $occupied
        ]);
    }
    public function store(Request $request)
    {
        try {
            DB::beginTransaction();

            // 1. Lưu thông tin phòng vào bảng rooms
            $room = Room::create([
                'title' => $request->title,
                'location' => $request->location,
                'type' => $request->type,
                'price' => $request->price,
                'max_guests' => $request->max_guests,
                'description' => $request->description,
                'status' => $request->status,
                'is_visible' => $request->is_visible === 'true' || $request->is_visible == 1 ? 1 : 0,
            ]);

            // 2. Lưu tiện nghi vào bảng trung gian room_amenities
            if ($request->has('amenities')) {
                // Laravel tự parse mảng gửi lên
                foreach ($request->amenities as $amenity_id) {
                    DB::table('room_amenities')->insert([
                        'room_id' => $room->id,
                        'amenity_id' => $amenity_id
                    ]);
                }
            }

            // 3. Upload ảnh và lưu vào bảng room_images
            if ($request->hasFile('images')) {
                foreach ($request->file('images') as $key => $file) {
                    // Lưu file vào thư mục storage/app/public/rooms
                    $path = $file->store('rooms', 'public');
                    
                    RoomImage::create([
                        'room_id' => $room->id,
                        'image_url' => '/storage/' . $path,
                        'is_primary' => $key === 0 ? true : false // Ảnh đầu tiên làm ảnh bìa
                    ]);
                }
            }

            DB::commit();
            return response()->json(['message' => 'Lưu phòng thành công!', 'room' => $room], 201);

        } catch (\Exception $e) {
            DB::rollBack();
            return response()->json(['error' => 'Lỗi khi lưu: ' . $e->getMessage()], 500);
        }
    }
}