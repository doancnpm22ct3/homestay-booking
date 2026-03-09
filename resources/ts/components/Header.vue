<template>
  <header class="bg-white shadow-sm sticky top-0 z-50">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 h-16 flex items-center justify-between">
      
      <!-- Logo -->
      <div class="flex items-center">
        <router-link to="/" class="text-2xl font-bold text-emerald-700">
          LOGO
        </router-link>
      </div>

      <!-- Desktop Menu -->
      <div class="hidden md:flex items-center space-x-4">

        <!-- Nếu chưa đăng nhập -->
        <template v-if="!user">
          <router-link
            to="/login"
            class="text-gray-600 hover:text-emerald-700 font-medium"
          >
            Đăng nhập
          </router-link>

          <router-link
            to="/register"
            class="bg-emerald-700 text-white px-4 py-2 rounded-md font-medium hover:bg-emerald-800 transition-colors"
          >
            Đăng ký
          </router-link>
        </template>

        <!-- Nếu đã đăng nhập -->
        <div
          v-if="user"
          class="relative flex items-center gap-2 cursor-pointer"
          @click="isMenuOpen = !isMenuOpen"
        >
          <!-- Avatar -->
          <div class="w-8 h-8 bg-emerald-100 text-emerald-700 rounded-full flex items-center justify-center font-bold">
            {{ user.name ? user.name.charAt(0).toUpperCase() : 'U' }}
          </div>

          <!-- Name -->
          <span class="font-medium text-gray-700 hover:text-emerald-600">
            {{ user.name }}
          </span>

          <!-- Arrow -->
          <svg
            class="w-4 h-4 text-gray-500"
            fill="none"
            stroke="currentColor"
            viewBox="0 0 24 24"
          >
            <path
              stroke-linecap="round"
              stroke-linejoin="round"
              stroke-width="2"
              d="M19 9l-7 7-7-7"
            ></path>
          </svg>

          <!-- Dropdown -->
          <div
            v-if="isMenuOpen"
            class="absolute right-0 top-full mt-2 w-48 bg-white rounded-xl shadow-lg border border-gray-100 py-2 z-50"
          >
            <router-link
              to="/profile"
              class="block px-4 py-2 text-sm text-gray-700 hover:bg-emerald-50 hover:text-emerald-600"
            >
              Hồ sơ cá nhân
            </router-link>

            <button
              @click.stop="handleLogout"
              class="w-full text-left px-4 py-2 text-sm text-red-600 hover:bg-red-50 font-medium"
            >
              Đăng xuất
            </button>
          </div>
        </div>
      </div>

      <!-- Mobile Menu -->
      <div class="md:hidden flex items-center">
        <button class="text-gray-600 hover:text-emerald-700">
          <Menu class="w-6 h-6" />
        </button>
      </div>

    </div>
  </header>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { Menu } from 'lucide-vue-next'

const router = useRouter()

const user = ref<any>(null)
const isMenuOpen = ref(false)

onMounted(() => {
  checkLoginStatus()
})

const checkLoginStatus = () => {
  const userInfo = localStorage.getItem('user_info')
  if (userInfo) {
    user.value = JSON.parse(userInfo)
  }
}

const handleLogout = () => {
  localStorage.removeItem('auth_token')
  localStorage.removeItem('user_info')

  user.value = null
  isMenuOpen.value = false

  alert('Đã đăng xuất thành công!')
  router.push('/')
  window.location.reload()
}
</script>