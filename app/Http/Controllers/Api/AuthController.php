<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\User;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;

class AuthController extends Controller
{
    // HÀM ĐĂNG KÝ
    public function register(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'name' => 'required|string|max:255',
            'email' => 'required|string|email|max:255|unique:users',
            'phone' => 'required|string|max:20|unique:users',
            'password' => 'required|string|min:6',
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $user = User::create([
            'name' => $request->name,
            'email' => $request->email,
            'phone' => $request->phone,
            'password' => Hash::make($request->password),
        ]);

        return response()->json(['message' => 'Đăng ký thành công!'], 201);
    }

    // HÀM ĐĂNG NHẬP
    public function login(Request $request)
    {
        $request->validate([
            'email' => 'required|email',
            'password' => 'required',
        ]);

        $user = User::where('email', $request->email)->first();

        // Kiểm tra xem email có tồn tại và mật khẩu có khớp không
        if (!$user || !Hash::check($request->password, $user->password)) {
            return response()->json(['message' => 'Email hoặc mật khẩu không chính xác!'], 401);
        }

        // KIỂM TRA XEM TÀI KHOẢN CÓ BỊ ADMIN KHÓA KHÔNG
        if ($user->status === 'blocked') {
            return response()->json(['message' => 'Tài khoản của bạn đã bị khóa. Vui lòng liên hệ Admin!'], 403);
        }

        // Tạo mã Token (vé thông hành) cho khách
        $token = $user->createToken('auth_token')->plainTextToken;

        return response()->json([
            'message' => 'Đăng nhập thành công',
            'access_token' => $token,
            'user' => $user
        ]);
    }
    // HÀM KIỂM TRA TRẠNG THÁI NGẦM
    public function checkStatus(Request $request)
    {
        $user = User::where('email', $request->email)->first();
        
        // Nếu không tìm thấy user hoặc user đã bị khóa
        if (!$user || $user->status === 'blocked') {
            return response()->json(['message' => 'Bị khóa'], 401);
        }
        
        // TRẢ VỀ THÊM THÔNG TIN USER MỚI NHẤT ĐỂ VUE ĐỐI CHIẾU
        return response()->json([
            'message' => 'An toàn',
            'user' => $user
        ]);
    }
    // HÀM CẬP NHẬT PROFILE
    public function updateProfile(Request $request)
    {
        $request->validate([
            'email' => 'required|email',
            'name' => 'required|string|max:255',
        ]);

        $user = User::where('email', $request->email)->first();

        if (!$user) {
            return response()->json(['message' => 'Không tìm thấy người dùng!'], 404);
        }

        // Kiểm tra nếu tài khoản bị khóa
        if ($user->status === 'blocked') {
            return response()->json([
                'message' => 'Tài khoản của bạn đã bị khóa!'
            ], 401);
        }

        // Cập nhật tên
        $user->name = $request->name;
        $user->save();

        return response()->json([
            'message' => 'Cập nhật tên thành công!',
            'user' => $user
        ]);
    }
}