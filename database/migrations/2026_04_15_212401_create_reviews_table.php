<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::dropIfExists('reviews');
        Schema::create('reviews', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('user_id');
            $table->integer('room_id');       // rooms.id là int(11) signed trong CSDL 
            $table->unsignedBigInteger('booking_id');
            $table->tinyInteger('rating')->unsigned()->comment('1-5 sao');
            $table->text('comment')->nullable();
            $table->boolean('is_visible')->default(true)->comment('Admin có thể ẩn review vi phạm');
            $table->timestamps();

            $table->foreign('user_id')->references('id')->on('users')->onDelete('cascade');
            $table->foreign('room_id')->references('id')->on('rooms')->onDelete('cascade');
            $table->foreign('booking_id')->references('id')->on('bookings')->onDelete('cascade');

            // 1 booking chỉ được đánh giá 1 lần
            $table->unique('booking_id');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('reviews');
    }
};
