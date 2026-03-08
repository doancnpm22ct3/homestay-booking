<template>
  <div class="min-h-[calc(100vh-4rem-20rem)] flex items-center justify-center py-12 px-4 sm:px-6 lg:px-8 bg-gray-50">
    <div class="max-w-md w-full space-y-8 bg-white p-8 rounded-2xl shadow-sm border border-gray-100">
      <div>
        <h2 class="mt-6 text-center text-3xl font-extrabold text-gray-900">
          Quên Mật Khẩu
        </h2>
      </div>
      <form class="mt-8 space-y-6" @submit.prevent="handleForgot">
        <div class="rounded-md shadow-sm space-y-4">
          <div>
            <label for="email-phone" class="sr-only">Số điện thoại hoặc gmail</label>
            <input
              id="email-phone"
              name="email-phone"
              type="text"
              required
              class="appearance-none rounded-lg relative block w-full px-3 py-3 border border-gray-300 placeholder-gray-500 text-gray-900 focus:outline-none focus:ring-emerald-500 focus:border-emerald-500 focus:z-10 sm:text-sm"
              placeholder="Số điện thoại hoặc gmail"
            />
          </div>
        </div>

        <div>
          <button
            type="submit"
            class="group relative w-full flex justify-center py-3 px-4 border border-transparent text-sm font-medium rounded-lg text-white bg-emerald-700 hover:bg-emerald-800 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-emerald-500 transition-colors"
          >
            Xác nhận
          </button>
        </div>
        
        <div class="relative">
          <div class="absolute inset-0 flex items-center">
            <div class="w-full border-t border-gray-300" />
          </div>
          <div class="relative flex justify-center text-sm">
            <span class="px-2 bg-white text-gray-500">Hoặc</span>
          </div>
        </div>

        <div>
          <button
            type="button"
            class="w-full flex justify-center py-3 px-4 border border-gray-300 rounded-lg shadow-sm bg-white text-sm font-medium text-gray-700 hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-emerald-500 transition-colors"
          >
            Đăng nhập bằng cách khác
          </button>
        </div>
      </form>
      <div class="text-center mt-4">
        <p class="text-sm text-gray-600">
          Tôi chưa có tài khoản?
          <router-link to="/register" class="font-medium text-emerald-600 hover:text-emerald-500">
            Đăng Ký
          </router-link>
        </p>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
const handleForgot = () => {
  // Handle forgot password
};
</script>
