<template>
  <header class="bg-[#FAF9F5] shadow-sm sticky top-0 z-50 border-b border-[#4A7055]/30">
    <div class="max-w-[1440px] mx-auto px-10 h-20 flex items-center justify-between">
      
      <div class="flex items-center">
        <router-link to="/">
          <img src="/images/logohomebooking2.png" alt="Homestay Logo" class="h-55 w-auto object-contain" />
        </router-link>
      </div>

      <div v-if="!user" class="hidden md:flex items-center space-x-4">
        <router-link to="/register" class="bg-white text-[#4A7055] border border-[#4A7055] px-6 py-2.5 rounded-md font-medium text-sm hover:bg-gray-50 transition-colors shadow-sm">
          Đăng kí
        </router-link>
        
        <router-link to="/login" class="bg-[#4A7055] text-white px-6 py-2.5 rounded-md font-medium text-sm hover:bg-[#3b5a44] transition-colors shadow-sm">
          Đăng nhập
        </router-link>
      </div>

      <div v-else class="hidden md:flex items-center space-x-6 relative">
        <router-link to="/rewards" class="text-gray-700 hover:text-[#4A7055] font-medium transition-colors">
          Ưu đãi
        </router-link>
        
        <div @click="handleAvatarClick" class="flex items-center gap-3 cursor-pointer hover:opacity-80 transition-opacity">
          <div class="text-right">
            <div class="font-bold text-gray-900 text-sm">{{ user.name }}</div>
            <div class="text-xs text-gray-500">
              <span v-if="isAdmin" class="text-[#4A7055] font-semibold">Quản trị viên</span>
              <span v-else>Đà Nẵng, Việt Nam</span>
            </div>
          </div>
          <img src="https://i.pravatar.cc/150?img=11" alt="Avatar" class="w-10 h-10 rounded-full border border-[#4A7055] object-cover" />
        </div>
        
        <div class="relative">
          <button @click="showNotifications = !showNotifications" class="relative text-[#4A7055] hover:text-[#3b5a44] transition-colors flex items-center justify-center mt-1">
            <Bell class="w-6 h-6 fill-current" />
            <span class="absolute -top-0.5 -right-0.5 flex h-3 w-3">
              <span class="animate-ping absolute inline-flex h-full w-full rounded-full bg-red-400 opacity-75"></span>
              <span class="relative inline-flex rounded-full h-3 w-3 bg-red-500"></span>
            </span>
          </button>

          <div v-if="showNotifications" class="absolute right-0 mt-6 w-[450px] bg-white rounded-3xl shadow-xl border border-gray-100 overflow-hidden z-50">
            <div class="px-6 py-5 border-b border-gray-100 bg-white">
              <h3 class="text-lg font-bold text-center text-gray-900">Thông báo của bạn</h3>
            </div>
            <div class="p-5 flex gap-4 hover:bg-gray-50 transition-colors cursor-pointer">
              <p class="text-sm">Bạn chưa có thông báo mới.</p>
            </div>
          </div>
        </div>

        <button @click="handleLogout" class="text-gray-400 hover:text-red-500 transition-colors ml-2" title="Đăng xuất">
          <LogOut class="w-5 h-5" />
        </button>
      </div>

      <div class="md:hidden flex items-center">
        <button class="text-gray-600 hover:text-[#4A7055]">
          <Menu class="w-7 h-7" />
        </button>
      </div>
    </div>
  </header>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue';
import { useRouter } from 'vue-router';
// Mình đã bỏ import LayoutDashboard vì không dùng nút cũ nữa
import { Bell, LogOut, Menu } from 'lucide-vue-next';

const router = useRouter();

// Phục hồi lại các biến quan trọng của web
const user = ref<any>(null);
const showNotifications = ref(false);
const isAdmin = ref(false);

// Chạy hàm này khi load trang
onMounted(() => {
  try {
    const userInfoString = localStorage.getItem('user_info');
    if (userInfoString) {
      user.value = JSON.parse(userInfoString); // Lấy thông tin user để hiển thị Avatar
      
      // Bật cờ Admin nếu role là admin
      if (user.value && user.value.role === 'admin') {
        isAdmin.value = true;
      }
    }
  } catch (error) {
    console.error("Lỗi đọc dữ liệu user:", error);
  }
});

// Hàm xử lý luồng đi khi bấm vào Avatar
const handleAvatarClick = () => {
  if (isAdmin.value) {
    // Nếu là admin thì bay thẳng vào trang quản trị
    router.push('/admin/rooms'); 
  } else {
    // Khách bình thường thì vào trang thông tin cá nhân
    router.push('/profile');
  }
};

const handleLogout = async () => {
  try {
    const token = localStorage.getItem('auth_token');
    if (token) {
      // Gọi API logout để hủy token ở server
      await fetch('/api/logout', {
        method: 'POST',
        headers: {
          'Authorization': `Bearer ${token}`,
          'Accept': 'application/json'
        }
      });
    }
  } catch (error) {
    console.error('Lỗi link logout:', error);
  } finally {
    // Xóa token và thông tin user khỏi localStorage
    localStorage.removeItem('auth_token');
    localStorage.removeItem('user_info');

    // Reset state
    user.value = null;
    isAdmin.value = false; 
    showNotifications.value = false;

    alert('Đăng xuất thành công!');
    router.push('/');
    
    // Force reload để xóa triệt để cache/state cũ
    setTimeout(() => {
        window.location.reload();
    }, 100);
  }
};
</script>