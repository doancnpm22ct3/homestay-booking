<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('point_histories', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained()->onDelete('cascade');
            $table->integer('points')->comment('Số điểm thay đổi (dương = cộng, âm = trừ)');
            $table->enum('action', ['earn', 'redeem', 'spin'])->comment('earn=đặt phòng, redeem=đổi voucher, spin=vòng quay');
            $table->string('description')->nullable()->comment('Mô tả chi tiết');
            $table->timestamps();
        });

        // Thêm cột last_spin_at vào users để giới hạn quay 1 lần/ngày
        Schema::table('users', function (Blueprint $table) {
            $table->timestamp('last_spin_at')->nullable()->after('referral_code');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('point_histories');
        Schema::table('users', function (Blueprint $table) {
            $table->dropColumn('last_spin_at');
        });
    }
};
