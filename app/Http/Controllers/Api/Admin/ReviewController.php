<?php

namespace App\Http\Controllers\Api\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Review;

class ReviewController extends Controller
{
    /**
     * Admin: Lấy danh sách tất cả reviews (kể cả đã ẩn)
     */
    public function index(Request $request)
    {
        $query = Review::with(['user:id,name,email', 'room:id,title', 'booking:id,booking_code'])
            ->latest();

        // Filter theo trạng thái ẩn/hiện
        if ($request->has('visible')) {
            $query->where('is_visible', $request->boolean('visible'));
        }

        // Filter theo phòng
        if ($request->room_id) {
            $query->where('room_id', $request->room_id);
        }

        $reviews = $query->paginate(20)->through(function ($review) {
            return [
                'id'           => $review->id,
                'rating'       => $review->rating,
                'comment'      => $review->comment,
                'is_visible'   => $review->is_visible,
                'created_at'   => $review->created_at->format('d/m/Y H:i'),
                'user_name'    => $review->user?->name ?? 'N/A',
                'user_email'   => $review->user?->email ?? 'N/A',
                'room_title'   => $review->room?->title ?? 'N/A',
                'booking_code' => $review->booking?->booking_code ?? 'N/A',
            ];
        });

        return response()->json($reviews);
    }

    /**
     * Admin: Ẩn/hiện review vi phạm
     */
    public function toggleVisible($id)
    {
        $review = Review::findOrFail($id);
        $review->is_visible = !$review->is_visible;
        $review->save();

        $status = $review->is_visible ? 'hiện' : 'ẩn';
        return response()->json([
            'message'    => "Đã {$status} đánh giá thành công.",
            'is_visible' => $review->is_visible,
        ]);
    }

    /**
     * Admin: Xóa review
     */
    public function destroy($id)
    {
        $review = Review::findOrFail($id);
        $review->delete();

        return response()->json(['message' => 'Đã xóa đánh giá thành công.']);
    }
}
