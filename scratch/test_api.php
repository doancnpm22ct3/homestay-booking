<?php
require __DIR__ . '/../vendor/autoload.php';
$app = require_once __DIR__ . '/../bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

use App\Http\Controllers\Api\RoomController;
use Illuminate\Http\Request;

$request = Request::create('/api/admin/rooms', 'GET');
$controller = new RoomController();
$response = $controller->adminIndex($request);
echo json_encode($response->toResponse($request)->getData(), JSON_PRETTY_PRINT);
