<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\RoomController;

Route::post('/rooms', [RoomController::class, 'store']);// Lấy danh sách
Route::get('/rooms', [RoomController::class, 'index']);// Thêm phòng
Route::get('/rooms/{id}', [RoomController::class, 'show']);// Lấy chi tiết 1 phòng theo ID
Route::put('/rooms/{id}', [RoomController::class, 'update']);// Lệnh cập nhật phòng
// --- QUẢN LÝ TIỆN NGHI ---
Route::get('/amenities', [App\Http\Controllers\Api\RoomController::class, 'getAmenities']); // Lấy danh sách
Route::post('/amenities', [App\Http\Controllers\Api\RoomController::class, 'storeAmenity']); // Thêm mới
Route::delete('/amenities/{id}', [App\Http\Controllers\Api\RoomController::class, 'deleteAmenity']); // Xóa vĩnh viễn
Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});
