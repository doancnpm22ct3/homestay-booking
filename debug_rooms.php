<?php
require __DIR__ . '/vendor/autoload.php';
$app = require_once __DIR__ . '/bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

$rooms = \App\Models\Room::all(['id', 'title', 'rent_type', 'type', 'parent_id']);
foreach($rooms as $r) {
    echo "ID: {$r->id} | Title: {$r->title} | RentType: {$r->rent_type} | Type: {$r->type} | Parent: {$r->parent_id}\n";
}
