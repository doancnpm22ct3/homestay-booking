<?php

use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
| Dự án dùng Vue SPA + Vue Router.
| Tất cả route frontend đều trả về view('welcome').
| Vue Router tự xử lý điều hướng phía client.
*/

// Bắt tất cả URL và trả về Vue SPA shell
// Vue Router sẽ tự render đúng component tương ứng
Route::get('/{any}', function () {
    return view('welcome');
})->where('any', '.*');

require __DIR__ . '/auth.php';
