<?php

use Illuminate\Support\Facades\Route;

// Bắt tất cả các đường dẫn (bất kể là /login, /admin hay /profile) 
// và luôn trả về giao diện chính. Vue Router sẽ tự biết phải hiển thị component nào.
Route::get('/{any}', function () {
    return view('welcome');
})->where('any', '.*');