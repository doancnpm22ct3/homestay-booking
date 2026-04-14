<?php
require 'vendor/autoload.php';
$app = require_once 'bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
try {
    $status = $kernel->call('migrate', ['--path' => 'database/migrations/2026_04_14_220705_create_reviews_table.php']);
    echo "Status: $status\n";
    echo $kernel->output();
} catch (\Exception $e) {
    echo "Error: " . $e->getMessage() . "\n";
    echo $e->getTraceAsString();
}
