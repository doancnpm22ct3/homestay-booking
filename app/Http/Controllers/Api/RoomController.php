<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Room;
use App\Models\RoomImage;
use Illuminate\Support\Facades\DB;

class RoomController extends Controller
{
    public function adminIndex()
    {
        // CHỈ LẤY CÁC PHÒNG CHA (Nguyên căn hoặc Tòa nhà)
        $rooms = Room::withCount('childRooms')
            ->with(['images', 'childRooms.images'])
            ->whereIn('rent_type', ['whole_house', 'room_based'])
            ->orderBy('id', 'desc')
            ->get()
            ->map(function($room) {
                // Formatting for admin list
                $primaryImage = $room->images->where('is_primary', true)->first() 
                                ?? $room->images->first();
                
                $room->image = $primaryImage ? $primaryImage->image_url : 'https://picsum.photos/seed/fallback/100/100';

                // Format child rooms if any (for room_based)
                if ($room->childRooms) {
                    $room->child_rooms = $room->childRooms->map(function($child) {
                        $pImg = $child->images->where('is_primary', true)->first() 
                                ?? $child->images->first();
                        $child->image = $pImg ? $pImg->image_url : null;
                        return $child;
                    });
                }
                
                return $room;
            });

        return response()->json($rooms);
    }

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
        $room = Room::with(['images', 'childRooms.images'])->find($id);

        if ($room && $room->rent_type === 'room_based') {
            // Include formatted child rooms for homestay
            $room->child_rooms = $room->childRooms->map(function($child) {
                $primaryImage = $child->images->where('is_primary', true)->first() 
                                ?? $child->images->first();
                $child->image = $primaryImage ? $primaryImage->image_url : null;
                return $child;
            });
        }

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

            // Nếu là phòng riêng, tự động lấy location từ cha
            $location = $request->location;
            if ($request->rent_type === 'private_room' && $request->parent_id) {
                $parent = Room::find($request->parent_id);
                if ($parent) {
                    $location = $parent->location;
                }
            }

            // 1. Cập nhật thông tin cơ bản
            $room->update([
                'title' => $request->title,
                'location' => $location,
                'rent_type' => $request->rent_type,
                'parent_id' => $request->parent_id,
                'type' => $request->type,
                'price' => $request->price,
                'max_guests' => $request->max_guests,
                'max_children' => $request->max_children,
                'description' => $request->description,
                'status' => $request->status,
                'is_visible' => $request->is_visible === 'true' || $request->is_visible == 1 ? 1 : 0,
            ]);

            // 2. Cập nhật tiện nghi (Xóa sạch tiện nghi cũ của phòng này và lưu lại các tick mới)
            DB::table('room_amenities')->where('room_id', $id)->delete();
            $amenities = $request->input('amenities', []);
            // Đảm bảo amenities là mảng (form data có thể gửi lên chuỗi 'null' hoặc chuỗi json)
            if (is_string($amenities)) {
                $amenities = json_decode($amenities, true) ?? [];
            }
            if (!empty($amenities) && is_array($amenities)) {
                foreach ($amenities as $amenity_id) {
                    if ($amenity_id && $amenity_id !== 'null') {
                        DB::table('room_amenities')->insert([
                            'room_id' => $id,
                            'amenity_id' => $amenity_id
                        ]);
                    }
                }
            }

            // 3. Xử lý ảnh cũ (xóa những ảnh không còn trong retained_images)
            $retainedUrls = $request->input('retained_images', []);
            $oldImages = RoomImage::where('room_id', $room->id)->get();
            foreach ($oldImages as $oldImg) {
                if (!in_array($oldImg->image_url, $retainedUrls)) {
                    // Xóa file vật lý trong storage (Lấy path tương đối sau /storage/)
                    $filePath = str_replace('/storage/', '', $oldImg->image_url);
                    \Illuminate\Support\Facades\Storage::disk('public')->delete($filePath);
                    // Xóa record trong DB
                    $oldImg->delete();
                }
            }

            // 4. Upload thêm ảnh mới nếu admin có chọn thêm
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
// HÀM THỐNG KÊ SỐ LƯỢNG PHÒNG CHO ADMIN
    public function stats()
    {
        // Đếm tổng tất cả các phòng
        $total = \App\Models\Room::count();
        
        // ĐẾM ĐÚNG TỪ KHÓA TRONG DATABASE CỦA BẠN NÈ:
        $available = \App\Models\Room::where('status', 'available')->count(); // Phòng trống
        $deposited = \App\Models\Room::where('status', 'booked')->count();    // Đã đặt cọc (chữ 'booked')
        $occupied = \App\Models\Room::where('status', 'in_use')->count();     // Đang sử dụng (chữ 'in_use')
        $maintenance = \App\Models\Room::where('status', 'maintenance')->count();

        // Trả về cho Vue hiển thị
        return response()->json([
            'total' => $total,
            'available' => $available,
            'deposited' => $deposited,
            'occupied' => $occupied,
            'maintenance' => $maintenance
        ]);
    }
    // HÀM XÓA PHÒNG
    public function destroy($id)
    {
        $room = \App\Models\Room::find($id);
        
        if (!$room) {
            return response()->json(['message' => 'Không tìm thấy phòng này!'], 404);
        }

        // Xóa phòng khỏi Database
        $room->delete();

        return response()->json(['message' => 'Xóa phòng thành công!']);
    }
    public function store(Request $request)
    {
        try {
            DB::beginTransaction();

            // Nếu là phòng riêng, tự động lấy location từ cha
            $location = $request->location;
            if ($request->rent_type === 'private_room' && $request->parent_id) {
                $parent = Room::find($request->parent_id);
                if ($parent) {
                    $location = $parent->location;
                }
            }

            // 1. Lưu thông tin phòng vào bảng rooms
            $room = Room::create([
                'title' => $request->title,
                'location' => $location,
                'rent_type' => $request->rent_type,
                'parent_id' => $request->parent_id,
                'type' => $request->type,
                'price' => $request->price,
                'max_guests' => $request->max_guests,
                'max_children' => $request->max_children,
                'description' => $request->description,
                'status' => $request->status,
                'is_visible' => $request->is_visible === 'true' || $request->is_visible == 1 ? 1 : 0,
            ]);

            // 2. Lưu tiện nghi vào bảng trung gian room_amenities
            $amenities = $request->input('amenities', []);
            if (is_string($amenities)) {
                $amenities = json_decode($amenities, true) ?? [];
            }
            if (!empty($amenities) && is_array($amenities)) {
                foreach ($amenities as $amenity_id) {
                    if ($amenity_id && $amenity_id !== 'null') {
                        DB::table('room_amenities')->insert([
                            'room_id' => $room->id,
                            'amenity_id' => $amenity_id
                        ]);
                    }
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

    public function storeAmenity(Request $request)
    {
        $request->validate(['name' => 'required|string']);
        
        $id = DB::table('amenities')->insertGetId([
            'name' => $request->name,
            'icon' => $request->icon ?? 'star'
        ]);
        
        $amenity = DB::table('amenities')->where('id', $id)->first();
        return response()->json($amenity, 201);
    }

    public function deleteAmenity($id)
    {
        DB::table('amenities')->where('id', $id)->delete();
        DB::table('room_amenities')->where('amenity_id', $id)->delete();
        return response()->json(['message' => 'Đã xóa tiện nghi']);
    }

    public function getHomestays()
    {
        // Lấy các homestay đang cho thuê phòng lẻ
        $homestays = \App\Models\Room::where('rent_type', 'room_based')->get();
        return response()->json($homestays);
    }

    public function convertToRoomBased($id)
    {
        $room = \App\Models\Room::find($id);
        if (!$room) {
            return response()->json(['message' => 'Không tìm thấy homestay'], 404);
        }

        $room->update(['rent_type' => 'room_based']);
        return response()->json(['message' => 'Đã chuyển đổi sang mô hình cho thuê phòng lẻ thành công!', 'room' => $room]);
    }
}