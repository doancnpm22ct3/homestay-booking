<template>
  <header class="bg-white shadow-sm sticky top-0 z-50">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 h-16 flex items-center justify-between">
      <div class="flex items-center">
        <router-link to="/" class="text-2xl font-bold text-emerald-700">
          LOGO
        </router-link>
      </div>
      <div class="hidden md:flex items-center space-x-4">
        <router-link to="/login" class="text-gray-600 hover:text-emerald-700 font-medium">
          Đăng nhập
        </router-link>
        <router-link
          to="/register"
          class="bg-emerald-700 text-white px-4 py-2 rounded-md font-medium hover:bg-emerald-800 transition-colors"
        >
          Đăng ký
        </router-link>
      </div>
      <div class="md:hidden flex items-center">
        <button class="text-gray-600 hover:text-emerald-700">
          <Menu class="w-6 h-6" />
        </button>
      </div>
    </div>
  </header>
</template>

<script setup lang="ts">
import { Menu } from 'lucide-vue-next';
</script>
