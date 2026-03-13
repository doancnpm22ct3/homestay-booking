<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\RoomController;
use App\Http\Controllers\Api\AdminUserController;

Route::post('/rooms', [RoomController::class, 'store']);// Lấy danh sách
Route::get('/rooms', [RoomController::class, 'index']);// Thêm phòng
Route::get('/rooms/{id}', [RoomController::class, 'show']);// Lấy chi tiết 1 phòng theo ID
Route::put('/rooms/{id}', [RoomController::class, 'update']);// Lệnh cập nhật phòng
Route::post('/profile/update', [App\Http\Controllers\Api\AuthController::class, 'updateProfile']);
Route::post('/check-status', [App\Http\Controllers\Api\AuthController::class, 'checkStatus']);
Route::get('/admin/rooms/stats', [App\Http\Controllers\Api\RoomController::class, 'stats']);
// --- QUẢN LÝ TIỆN NGHI ---
Route::get('/amenities', [App\Http\Controllers\Api\RoomController::class, 'getAmenities']); // Lấy danh sách
Route::post('/amenities', [App\Http\Controllers\Api\RoomController::class, 'storeAmenity']); // Thêm mới
Route::delete('/amenities/{id}', [App\Http\Controllers\Api\RoomController::class, 'deleteAmenity']); // Xóa vĩnh viễn
Route::post('/register', [App\Http\Controllers\Api\AuthController::class, 'register']);
Route::post('/login', [App\Http\Controllers\Api\AuthController::class, 'login']);

// Khách đặt phòng

Route::post('/bookings', [App\Http\Controllers\Api\BookingController::class, 'store']);
Route::get('/admin/bookings', [App\Http\Controllers\Api\AdminBookingController::class, 'index']);
Route::put('/admin/bookings/{id}/checkout', [App\Http\Controllers\Api\AdminBookingController::class, 'checkout']);
Route::delete('/admin/bookings/{id}', [App\Http\Controllers\Api\AdminBookingController::class, 'destroy']);
// Route xóa phòng
Route::delete('/admin/rooms/{id}', [App\Http\Controllers\Api\RoomController::class, 'destroy']);
// -- quản lý người dùng ---
Route::get('/admin/users', [AdminUserController::class, 'index']);
Route::post('/admin/users', [AdminUserController::class, 'store']);
Route::put('/admin/users/{id}', [AdminUserController::class, 'update']);
Route::delete('/admin/users/{id}', [AdminUserController::class, 'destroy']);
Route::put('/admin/users/{id}/status', [AdminUserController::class, 'toggleStatus']);
Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});
