<template>
  <div class="min-h-[calc(100vh-4rem-20rem)] flex items-center justify-center py-12 px-4 sm:px-6 lg:px-8 bg-gray-50">
    <div class="max-w-md w-full space-y-8 bg-white p-8 rounded-2xl shadow-sm border border-gray-100">
      <div>
        <h2 class="mt-6 text-center text-3xl font-extrabold text-gray-900">Đăng Nhập</h2>
      </div>
      <form class="mt-8 space-y-6" @submit.prevent="handleLogin">
        <div class="rounded-md shadow-sm space-y-4">
          <div>
            <label for="email" class="sr-only">Email</label>
            <input id="email" v-model="form.email" type="email" required class="appearance-none rounded-lg relative block w-full px-3 py-3 border border-gray-300 placeholder-gray-500 text-gray-900 focus:outline-none focus:ring-emerald-500 focus:border-emerald-500 focus:z-10 sm:text-sm" placeholder="Địa chỉ Email" />
          </div>
          <div>
            <label for="password" class="sr-only">Mật khẩu</label>
            <input id="password" v-model="form.password" type="password" required class="appearance-none rounded-lg relative block w-full px-3 py-3 border border-gray-300 placeholder-gray-500 text-gray-900 focus:outline-none focus:ring-emerald-500 focus:border-emerald-500 focus:z-10 sm:text-sm" placeholder="Mật khẩu" />
          </div>
        </div>

        <div class="flex items-center justify-between">
          <div class="text-sm">
            <router-link to="/forgot-password" class="font-medium text-emerald-600 hover:text-emerald-500">Quên mật khẩu?</router-link>
          </div>
        </div>

        <div>
          <button type="submit" class="group relative w-full flex justify-center py-3 px-4 border border-transparent text-sm font-medium rounded-lg text-white bg-emerald-700 hover:bg-emerald-800 transition-colors">Đăng nhập</button>
        </div>
      </form>
      <div class="text-center mt-4">
        <p class="text-sm text-gray-600">
          Tôi chưa có tài khoản?
          <router-link to="/register" class="font-medium text-emerald-600 hover:text-emerald-500">Đăng Ký</router-link>
        </p>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { useRouter } from 'vue-router';

const router = useRouter();

const form = ref({
  email: '',
  password: ''
});

const handleLogin = async () => {
  try {
    const response = await fetch('/api/login', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
      body: JSON.stringify({
        email: form.value.email,
        password: form.value.password
      })
    });

    const data = await response.json();

    if (!response.ok) {
      alert(data.message || 'Sai email hoặc mật khẩu!');
      return;
    }

    // Lưu Token và thông tin user vào LocalStorage
    localStorage.setItem('auth_token', data.access_token);
    localStorage.setItem('user_info', JSON.stringify(data.user));

    alert('Đăng nhập thành công!');

    // ===== PHÂN LUỒNG ROLE =====
    if (data.user.role === 'admin') {
      // Admin -> vào trang quản lý
      window.location.href = '/admin/rooms';
    } else {
      // Customer -> về trang chủ
      window.location.href = '/';
    }

  } catch (error) {
    console.error('Lỗi kết nối:', error);
    alert('Không thể kết nối đến máy chủ!');
  }
};
</script>