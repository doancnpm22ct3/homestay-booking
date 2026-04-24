<?php

use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;

require __DIR__ . '/../vendor/autoload.php';
$app = require_once __DIR__ . '/../bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

$cleaning = [
    'rooms' => ['status', 'rent_type', 'parent_id'],
    'bookings' => ['status', 'check_in_date', 'booking_code', 'customer_id'],
    'vouchers' => ['code'],
    'reviews' => ['room_id']
];

foreach ($cleaning as $table => $cols) {
    echo "Processing $table...\n";
    foreach ($cols as $col) {
        $indexName = $table . '_' . $col . '_index';
        try {
            Schema::table($table, function (Blueprint $table) use ($indexName) {
                $table->dropIndex($indexName);
            });
            echo "Dropped $indexName\n";
        } catch (\Exception $e) {
            echo "Skipped $indexName (Not found or error)\n";
        }
    }
}
