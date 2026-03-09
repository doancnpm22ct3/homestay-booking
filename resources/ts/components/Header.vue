<template>
  <header class="bg-white shadow-sm sticky top-0 z-50">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 h-16 flex items-center justify-between">
      <!-- Logo -->
      <div class="flex items-center">
        <router-link to="/" class="text-2xl font-bold text-emerald-700">
          🏡 Homestay
        </router-link>
      </div>

      <!-- Desktop nav -->
      <div class="hidden md:flex items-center space-x-4">
        <template v-if="!authLoading">
          <!-- Chưa đăng nhập -->
          <template v-if="!isLoggedIn">
            <router-link to="/login" class="text-gray-600 hover:text-emerald-700 font-medium transition-colors">
              Đăng nhập
            </router-link>
            <router-link
              to="/register"
              class="bg-emerald-700 text-white px-4 py-2 rounded-md font-medium hover:bg-emerald-800 transition-colors"
            >
              Đăng ký
            </router-link>
          </template>

          <!-- Đã đăng nhập -->
          <template v-else>
            <div class="relative" @click.outside="dropdownOpen = false">
              <button
                class="flex items-center gap-2 text-gray-700 hover:text-emerald-700 font-medium transition-colors"
                @click="dropdownOpen = !dropdownOpen"
              >
                <div class="w-8 h-8 bg-emerald-100 text-emerald-700 rounded-full flex items-center justify-center font-bold text-sm">
                  {{ user?.name?.charAt(0).toUpperCase() }}
                </div>
                <span>{{ user?.name }}</span>
                <ChevronDown class="w-4 h-4" :class="{ 'rotate-180': dropdownOpen }" />
              </button>

              <!-- Dropdown menu -->
              <div
                v-if="dropdownOpen"
                class="absolute right-0 mt-2 w-48 bg-white border border-gray-100 rounded-xl shadow-lg py-1 z-50"
              >
                <router-link
                  to="/profile"
                  class="flex items-center gap-2 px-4 py-2 text-sm text-gray-700 hover:bg-gray-50"
                  @click="dropdownOpen = false"
                >
                  <User class="w-4 h-4" />
                  Hồ sơ
                </router-link>
                <hr class="my-1 border-gray-100" />
                <button
                  class="flex items-center gap-2 w-full px-4 py-2 text-sm text-red-600 hover:bg-red-50"
                  @click="handleLogout"
                >
                  <LogOut class="w-4 h-4" />
                  Đăng xuất
                </button>
              </div>
            </div>
          </template>
        </template>
      </div>

      <!-- Mobile menu button -->
      <div class="md:hidden flex items-center">
        <button class="text-gray-600 hover:text-emerald-700">
          <Menu class="w-6 h-6" />
        </button>
      </div>
    </div>
  </header>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { useRouter } from 'vue-router';
import { Menu, ChevronDown, User, LogOut } from 'lucide-vue-next';
import { useAuth } from '@/composables/useAuth';

const router = useRouter();
const { user, isLoggedIn, authLoading, logout } = useAuth();
const dropdownOpen = ref(false);

async function handleLogout() {
  dropdownOpen.value = false;
  await logout();
  router.push('/login');
}
</script>
