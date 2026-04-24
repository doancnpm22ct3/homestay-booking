<?php

use Illuminate\Support\Facades\DB;

require __DIR__ . '/../vendor/autoload.php';
$app = require_once __DIR__ . '/../bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

$tables = ['rooms', 'bookings', 'vouchers', 'reviews'];

foreach ($tables as $table) {
    echo "--- Table: $table ---\n";
    $indexes = DB::select("SHOW INDEX FROM $table");
    foreach ($indexes as $idx) {
        echo "- " . $idx->Key_name . " (" . $idx->Column_name . ")\n";
    }
}
