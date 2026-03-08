<template>
  <div class="min-h-[calc(100vh-4rem-20rem)] flex items-center justify-center py-12 px-4 sm:px-6 lg:px-8 bg-gray-50">
    <div class="max-w-md w-full space-y-8 bg-white p-8 rounded-2xl shadow-sm border border-gray-100">
      <div>
        <h2 class="mt-6 text-center text-3xl font-extrabold text-gray-900">
          Tạo Tài Khoản
        </h2>
      </div>
      <form class="mt-8 space-y-6" @submit.prevent="handleRegister">
        <div class="rounded-md shadow-sm space-y-4">
          <div>
            <label for="fullname" class="sr-only">Họ và Tên</label>
            <input
              id="fullname"
              name="fullname"
              type="text"
              required
              class="appearance-none rounded-lg relative block w-full px-3 py-3 border border-gray-300 placeholder-gray-500 text-gray-900 focus:outline-none focus:ring-emerald-500 focus:border-emerald-500 focus:z-10 sm:text-sm"
              placeholder="Họ và Tên"
            />
          </div>
          <div>
            <label for="email-address" class="sr-only">Email</label>
            <input
              id="email-address"
              name="email"
              type="email"
              autocomplete="email"
              required
              class="appearance-none rounded-lg relative block w-full px-3 py-3 border border-gray-300 placeholder-gray-500 text-gray-900 focus:outline-none focus:ring-emerald-500 focus:border-emerald-500 focus:z-10 sm:text-sm"
              placeholder="Email"
            />
          </div>
          <div>
            <label for="phone" class="sr-only">Số Điện Thoại</label>
            <input
              id="phone"
              name="phone"
              type="tel"
              required
              class="appearance-none rounded-lg relative block w-full px-3 py-3 border border-gray-300 placeholder-gray-500 text-gray-900 focus:outline-none focus:ring-emerald-500 focus:border-emerald-500 focus:z-10 sm:text-sm"
              placeholder="Số Điện Thoại"
            />
          </div>
          <div>
            <label for="password" class="sr-only">Mật Khẩu</label>
            <input
              id="password"
              name="password"
              type="password"
              required
              class="appearance-none rounded-lg relative block w-full px-3 py-3 border border-gray-300 placeholder-gray-500 text-gray-900 focus:outline-none focus:ring-emerald-500 focus:border-emerald-500 focus:z-10 sm:text-sm"
              placeholder="Mật Khẩu"
            />
          </div>
        </div>

        <div class="flex items-center">
          <input
            id="terms"
            name="terms"
            type="checkbox"
            class="h-4 w-4 text-emerald-600 focus:ring-emerald-500 border-gray-300 rounded"
          />
          <label for="terms" class="ml-2 block text-sm text-gray-900">
            Tôi đồng ý với tất cả điều khoản trên
          </label>
        </div>

        <div>
          <button
            type="submit"
            class="group relative w-full flex justify-center py-3 px-4 border border-transparent text-sm font-medium rounded-lg text-white bg-emerald-700 hover:bg-emerald-800 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-emerald-500 transition-colors"
          >
            Đăng ký
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
          Đã có tài khoản?
          <router-link to="/login" class="font-medium text-emerald-600 hover:text-emerald-500">
            Đăng nhập
          </router-link>
        </p>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
const handleRegister = () => {
  // Handle register
};
</script>
