<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\PointHistory;

class RewardController extends Controller
{
    /**
     * Lấy lịch sử điểm thưởng của user (có phân trang)
     */
    public function history(Request $request)
    {
        $user = $request->user();

        $histories = PointHistory::where('user_id', $user->id)
            ->latest()
            ->paginate(15)
            ->through(function ($h) {
                return [
                    'id'          => $h->id,
                    'points'      => $h->points,
                    'action'      => $h->action,
                    'description' => $h->description,
                    'created_at'  => $h->created_at->format('d/m/Y H:i'),
                    'action_label' => match($h->action) {
                        'earn'   => 'Tích điểm đặt phòng',
                        'redeem' => 'Đổi điểm lấy voucher',
                        'spin'   => 'Vòng quay may mắn',
                        default  => $h->action,
                    },
                ];
            });

        return response()->json([
            'points'    => $user->points,
            'histories' => $histories,
        ]);
    }
}
