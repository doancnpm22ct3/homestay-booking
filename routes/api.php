<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\DB; // BẮT BUỘC PHẢI CÓ DÒNG NÀY
use App\Http\Controllers\Api\RoomController;
use App\Http\Controllers\Api\AdminUserController;

// --- GHI ĐÈ API LẤY DANH SÁCH PHÒNG (TRẢ VỀ KÈM ẢNH) ---
Route::get('/rooms', function (Request $request) {
    $rooms = DB::table('rooms')
                ->where('is_visible', 1)
                ->where('status', '!=', 'hidden')
                ->get();

    foreach ($rooms as $room) {
        $room->images = DB::table('room_images')->where('room_id', $room->id)->get();
    }

    return response()->json($rooms);
});

// --- GHI ĐÈ API LẤY CHI TIẾT 1 PHÒNG (ĐỂ XEM CHI TIẾT KHÔNG BỊ LỖI) ---
Route::get('/rooms/{id}', function ($id) {
    $room = DB::table('rooms')->where('id', $id)->first();

    if (!$room) {
        return response()->json(['message' => 'Không tìm thấy phòng'], 404);
    }

    // Lấy ảnh
    $room->images = DB::table('room_images')->where('room_id', $id)->get();

    // Lấy tiện nghi
    $room->amenities = DB::table('room_amenities')
        ->join('amenities', 'room_amenities.amenity_id', '=', 'amenities.id')
        ->where('room_amenities.room_id', $id)
        ->select('amenities.*')
        ->get();

    return response()->json($room);
});

// --- QUẢN LÝ PHÒNG ---
Route::post('/rooms', [RoomController::class, 'store']); // Thêm phòng
Route::put('/rooms/{id}', [RoomController::class, 'update']); // Cập nhật phòng
Route::delete('/admin/rooms/{id}', [RoomController::class, 'destroy']); // Xóa phòng

// --- AUTH & PROFILE ---
Route::post('/register', [App\Http\Controllers\Api\AuthController::class, 'register']);
Route::post('/login', [App\Http\Controllers\Api\AuthController::class, 'login']);
Route::post('/profile/update', [App\Http\Controllers\Api\AuthController::class, 'updateProfile']);
Route::post('/check-status', [App\Http\Controllers\Api\AuthController::class, 'checkStatus']);

// --- QUẢN LÝ TIỆN NGHI ---
Route::get('/amenities', [App\Http\Controllers\Api\RoomController::class, 'getAmenities']);
Route::post('/amenities', [App\Http\Controllers\Api\RoomController::class, 'storeAmenity']);
Route::delete('/amenities/{id}', [App\Http\Controllers\Api\RoomController::class, 'deleteAmenity']);

// --- ĐẶT PHÒNG & HÓA ĐƠN ---
Route::post('/bookings', [App\Http\Controllers\Api\BookingController::class, 'store']);
Route::get('/admin/bookings', [App\Http\Controllers\Api\AdminBookingController::class, 'index']);
Route::put('/admin/bookings/{id}/checkout', [App\Http\Controllers\Api\AdminBookingController::class, 'checkout']);
Route::delete('/admin/bookings/{id}', [App\Http\Controllers\Api\AdminBookingController::class, 'destroy']);

// --- QUẢN LÝ NGƯỜI DÙNG (ADMIN) ---
Route::get('/admin/users', [AdminUserController::class, 'index']);
Route::post('/admin/users', [AdminUserController::class, 'store']);
Route::put('/admin/users/{id}', [AdminUserController::class, 'update']);
Route::delete('/admin/users/{id}', [AdminUserController::class, 'destroy']);
Route::put('/admin/users/{id}/status', [AdminUserController::class, 'toggleStatus']);

// --- QUẢN LÝ THỐNG KÊ ---
Route::get('/admin/rooms/stats', [App\Http\Controllers\Api\RoomController::class, 'stats']);

// --- USER HIỆN TẠI ---
Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});