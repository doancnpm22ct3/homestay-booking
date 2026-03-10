<?php

use App\Http\Controllers\ProfileController;
use Illuminate\Foundation\Application;
use Illuminate\Support\Facades\Route;
use Inertia\Inertia;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
*/

// 1. Trang chủ
Route::get('/', function () {
    return Inertia::render('Home');
});

// 2. Trang danh sách homestay
Route::get('/listing', function () {
    return Inertia::render('Listing');
});

// 3. Trang chi tiết một phòng
Route::get('/room/{id}', function () {
    return Inertia::render('RoomDetail');
});

// 4. Trang thanh toán
Route::get('/payment', function () {
    return Inertia::render('Payment');
});

// 5. Trang thanh toán thành công
Route::get('/payment-success', function () {
    return Inertia::render('PaymentSuccess');
});


// Các route hệ thống của Backend (Giữ nguyên)
Route::get('/dashboard', function () {
    return Inertia::render('Dashboard');
})->middleware(['auth', 'verified'])->name('dashboard');

Route::middleware('auth')->group(function () {
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');
});

// Route tạm thời để test giao diện Profile không cần đăng nhập
Route::get('/test-profile', function () {
    // Chỉ dùng Inertia::render thay vì Inertia\Inertia::render
    return Inertia::render('Profile', [
        'auth' => [
            'user' => [
                'name' => 'Duy Designer',
                'email' => 'duy@homestay.com'
            ]
        ]
    ]);
});

require __DIR__ . '/auth.php';