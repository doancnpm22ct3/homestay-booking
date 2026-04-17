<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Voucher;
use App\Models\User;
use App\Models\PointHistory;

class VoucherController extends Controller
{
    // Lấy danh sách Voucher của User (dành cho Payment.vue và Rewards.vue)
    public function myVouchers(Request $request)
    {
        $user = $request->user();
        
        // Lấy tất cả voucher chưa sử dụng và còn hạn hoặc không có hạn
        $vouchers = $user->vouchers()
            ->wherePivot('is_used', false)
            ->where(function($query) {
                $query->whereNull('expires_at')
                      ->orWhere('expires_at', '>', now());
            })
            ->where('is_active', true)
            ->get()
            ->map(function($voucher) {
                return [
                    'id' => $voucher->id,
                    'code' => $voucher->code,
                    'title' => $voucher->title,
                    'description' => $voucher->description,
                    'discount_type' => $voucher->discount_type,
                    'discount_value' => $voucher->discount_value,
                    'expires_at' => $voucher->expires_at ? $voucher->expires_at->format('d/m/Y') : 'Vĩnh viễn',
                ];
            });

        return response()->json($vouchers);
    }

    // Lấy danh sách tất cả Voucher có thể đổi bằng Điểm
    public function redeemable(Request $request)
    {
        $vouchers = Voucher::whereNotNull('points_required')
            ->where('is_active', true)
            ->where(function($q) {
                $q->whereNull('expires_at')->orWhere('expires_at', '>', now());
            })
            ->get();
            
        return response()->json([
            'points' => $request->user()->points,
            'vouchers' => $vouchers
        ]);
    }

    // Đổi điểm lấy Voucher
    public function redeem(Request $request, $id)
    {
        $user = $request->user();
        $voucher = Voucher::findOrFail($id);

        if (!$voucher->points_required) {
            return response()->json(['message' => 'Voucher này không thể đổi bằng điểm.'], 400);
        }

        if ($user->points < $voucher->points_required) {
            return response()->json(['message' => 'Bạn không đủ điểm để đổi mã này.'], 400);
        }

        // Kiểm tra xem đã sở hữu chưa
        if ($user->vouchers()->where('voucher_id', $voucher->id)->exists()) {
            return response()->json(['message' => 'Bạn đã quy đổi mã này rồi (mỗi mã chỉ được quy đổi 1 lần).'], 400);
        }

        // Trừ điểm và thêm voucher
        $user->decrement('points', $voucher->points_required);
        $user->vouchers()->attach($voucher->id);

        // Ghi lịch sử điểm
        PointHistory::create([
            'user_id'     => $user->id,
            'points'      => -$voucher->points_required,
            'action'      => 'redeem',
            'description' => 'Đổi ' . $voucher->points_required . ' điểm lấy voucher ' . $voucher->code,
        ]);

        return response()->json(['message' => 'Đổi điểm thành công! Mã đã được lưu vào ví.']);
    }

    // Lưu mã từ Banner (Claim)
    public function claim(Request $request)
    {
        $request->validate(['code' => 'required|string']);
        
        $user = $request->user();
        $voucher = Voucher::where('code', $request->code)
            ->where('is_active', true)
            ->first();

        if (!$voucher) {
            return response()->json(['message' => 'Mã không tồn tại hoặc đã hết hạn.'], 404);
        }

        // Kiểm tra xem đã sở hữu chưa
        if ($user->vouchers()->where('voucher_id', $voucher->id)->exists()) {
            return response()->json(['message' => 'Bạn đã lưu mã này rồi!'], 400);
        }

        $user->vouchers()->attach($voucher->id);

        return response()->json(['message' => 'Lưu mã thành công!']);
    }

    // API Vòng quay may mắn
    public function spin(Request $request)
    {
        $user = $request->user();

        // Giới hạn quay 1 lần / ngày
        if ($user->last_spin_at && $user->last_spin_at->isToday()) {
            return response()->json(['message' => 'Bạn đã quay hôm nay rồi. Hãy quay lại vào ngày mai nhé! 🌙'], 400);
        }

        $vouchers = Voucher::where('is_active', true)
            ->inRandomOrder()
            ->take(3)
            ->get();

        if ($vouchers->isEmpty()) {
            return response()->json(['message' => 'Chưa có giải thưởng. Cứ thử lại sau nhé!'], 400);
        }

        $wonVoucher = $vouchers->first();

        // Cập nhật thời gian quay gần nhất
        $user->last_spin_at = now();
        $user->save();

        // Ghi lịch sử điểm (quay không trừ điểm)
        PointHistory::create([
            'user_id'     => $user->id,
            'points'      => 0,
            'action'      => 'spin',
            'description' => 'Vòng quay may mắn — trúng voucher: ' . $wonVoucher->code,
        ]);

        // Kiểm tra xem đã có chưa (dù dùng hay chưa)
        if (!$user->vouchers()->where('voucher_id', $wonVoucher->id)->exists()) {
            $user->vouchers()->attach($wonVoucher->id);
            return response()->json([
                'message' => 'Chúc mừng! Bạn quay trúng mã: ' . $wonVoucher->code,
                'voucher' => $wonVoucher
            ]);
        }

        return response()->json([
            'message' => 'Bạn trúng ' . $wonVoucher->code . ' nhưng bạn đã sở hữu mã này rồi. Lần sau may mắn nhé!'
        ]);
    }
}
