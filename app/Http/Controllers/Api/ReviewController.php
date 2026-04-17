<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Review;
use App\Models\Booking;

class ReviewController extends Controller
{
    /**
     * Lấy danh sách đánh giá công khai của 1 phòng
     */
    public function index($roomId)
    {
        $reviews = Review::with('user:id,name')
            ->where('room_id', $roomId)
            ->where('is_visible', true)
            ->latest()
            ->get()
            ->map(function ($review) {
                return [
                    'id'         => $review->id,
                    'rating'     => $review->rating,
                    'comment'    => $review->comment,
                    'created_at' => $review->created_at->format('d/m/Y'),
                    'user_name'  => $review->user->name ?? 'Khách ẩn danh',
                ];
            });

        $avg = $reviews->avg('rating') ?? 0;

        return response()->json([
            'reviews' => $reviews,
            'average' => round($avg, 1),
            'count'   => $reviews->count(),
        ]);
    }

    /**
     * Gửi đánh giá mới (yêu cầu đã đăng nhập + đã checkout)
     */
    public function store(Request $request)
    {
        $request->validate([
            'booking_id' => 'required|exists:bookings,id',
            'rating'     => 'required|integer|min:1|max:5',
            'comment'    => 'nullable|string|max:2000',
        ], [
            'rating.min' => 'Điểm đánh giá tối thiểu là 1 sao.',
            'rating.max' => 'Điểm đánh giá tối đa là 5 sao.',
        ]);

        $user = $request->user();
        $booking = Booking::findOrFail($request->booking_id);

        // Chỉ được đánh giá booking của chính mình
        if ($booking->customer_id !== $user->id) {
            return response()->json(['message' => 'Bạn không có quyền đánh giá booking này.'], 403);
        }

        // Chỉ được đánh giá sau khi đã checkout
        if ($booking->status !== 'checked_out') {
            return response()->json(['message' => 'Bạn chỉ có thể đánh giá sau khi đã trả phòng.'], 400);
        }

        // Kiểm tra đã đánh giá chưa (dùng unique constraint trong DB)
        if (Review::where('booking_id', $booking->id)->exists()) {
            return response()->json(['message' => 'Bạn đã đánh giá booking này rồi.'], 409);
        }

        $review = Review::create([
            'user_id'    => $user->id,
            'room_id'    => $booking->room_id,
            'booking_id' => $booking->id,
            'rating'     => $request->rating,
            'comment'    => $request->comment,
            'is_visible' => true,
        ]);

        return response()->json([
            'message' => 'Cảm ơn bạn đã đánh giá! Nhận xét của bạn giúp ích rất nhiều.',
            'review'  => $review,
        ], 201);
    }

    /**
     * Kiểm tra user có thể đánh giá phòng này không (đã từng ở và chưa đánh giá)
     */
    public function canReview(Request $request, $roomId)
    {
        $user = $request->user();

        // Tìm booking đã trả phòng của user này tại phòng này
        $booking = Booking::where('customer_id', $user->id)
            ->where('room_id', $roomId)
            ->where('status', 'checked_out')
            ->latest('check_out_date')
            ->first();

        if (!$booking) {
            return response()->json(['can_review' => false, 'message' => 'Bạn chưa từng nghỉ tại phòng này.']);
        }

        // Kiểm tra xem đã đánh giá booking này chưa
        $reviewed = Review::where('booking_id', $booking->id)->exists();

        if ($reviewed) {
            return response()->json(['can_review' => false, 'message' => 'Bạn đã đánh giá trải nghiệm này rồi.']);
        }

        return response()->json([
            'can_review' => true,
            'booking_id' => $booking->id,
        ]);
    }
}
