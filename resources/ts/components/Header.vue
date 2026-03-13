<template>
  <header class="bg-[#FAF9F5] shadow-sm sticky top-0 z-50 border-b border-[#4A7055]/30">
    <div class="max-w-[1440px] mx-auto px-10 h-20 flex items-center justify-between">
      
      <div class="flex items-center">
        <router-link to="/" class="text-4xl font-extrabold text-black font-['Playfair_Display'] tracking-widest">
          LOGO
        </router-link>
      </div>

      <div v-if="!user" class="hidden md:flex items-center space-x-4">
        <router-link 
          to="/register" 
          class="bg-[#4A7055] text-white px-6 py-2.5 rounded-md font-medium font-['Inter'] text-sm hover:bg-[#3b5a44] transition-colors shadow-sm"
        >
          Đăng kí
        </router-link>
        
        <router-link
          to="/login"
          class="bg-[#4A7055] text-white px-6 py-2.5 rounded-md font-medium font-['Inter'] text-sm hover:bg-[#3b5a44] transition-colors shadow-sm"
        >
          Đăng nhập
        </router-link>
      </div>

      <div v-else class="hidden md:flex items-center space-x-6 relative">
        
        <div @click="router.push('/profile')" class="flex items-center gap-3 cursor-pointer hover:opacity-80 transition-opacity">
          <div class="text-right">
            <div class="font-bold text-gray-900 font-['Inter'] text-sm">{{ user.name }}</div>
            <div class="text-xs text-gray-500 font-['Inter']">Đà Nẵng, Việt Nam</div>
          </div>
          <img src="https://i.pravatar.cc/150?img=11" alt="Avatar" class="w-10 h-10 rounded-full border border-[#4A7055] object-cover" />
        </div>
        
        <div class="relative">
          <button 
            @click="showNotifications = !showNotifications" 
            class="relative text-[#4A7055] hover:text-[#3b5a44] transition-colors flex items-center justify-center mt-1"
          >
            <Bell class="w-6 h-6 fill-current" />
            <span class="absolute -top-0.5 -right-0.5 flex h-3 w-3">
              <span class="animate-ping absolute inline-flex h-full w-full rounded-full bg-red-400 opacity-75"></span>
              <span class="relative inline-flex rounded-full h-3 w-3 bg-red-500"></span>
            </span>
          </button>

          <div 
            v-if="showNotifications" 
            class="absolute right-0 mt-6 w-[450px] bg-white rounded-3xl shadow-[0_10px_40px_-10px_rgba(0,0,0,0.15)] border border-gray-100 overflow-hidden z-50 transform origin-top-right transition-all"
          >
            <div class="px-6 py-5 border-b border-gray-100 bg-white">
              <h3 class="text-lg font-bold text-center text-gray-900 font-['Inter']">
                Thông báo của bạn
              </h3>
            </div>

            <div class="max-h-[420px] overflow-y-auto divide-y divide-gray-50 bg-white">
              <div v-for="i in 3" :key="i" class="p-5 flex gap-4 hover:bg-gray-50 transition-colors cursor-pointer">
                <div class="flex-shrink-0">
                  <img src="https://i.pravatar.cc/150?img=11" alt="Avatar" class="w-12 h-12 rounded-full object-cover border border-gray-100 shadow-sm" />
                </div>
                
                <div class="flex-1">
                  <h4 class="text-sm font-bold text-gray-900 mb-1 font-['Inter']">
                    Bạn đã đặt phòng thành công
                  </h4>
                  <p class="text-xs text-gray-600 mb-1.5 leading-relaxed font-['Inter']">
                    Bạn đã thanh toán thành công và phòng bạn đặt đã được chấp thuận. 
                    Hóa đơn chi tiết đã gửi về mail của bạn. <span class="text-blue-600 hover:underline">Xem chi tiết tại đây</span>
                  </p>
                  <p class="text-[10px] text-gray-400 font-medium">1 ngày trước</p>
                </div>
              </div>
            </div>
            <div class="h-6 bg-white"></div>
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
import { Menu, Bell, LogOut } from 'lucide-vue-next';

// 1. Định nghĩa Interface cho User để Typescript hiểu cấu trúc dữ liệu
interface User {
  id: number;
  name: string;
  email: string;
  role?: string;
  status?: string;
  phone?: string | null;
}

const router = useRouter();

// 2. Khai báo biến user sử dụng Interface đã định nghĩa
const user = ref<User | null>(null);
const showNotifications = ref(false);

onMounted(() => {
  checkLoginStatus();
});

const checkLoginStatus = () => {
  const userInfo = localStorage.getItem('user_info');
  if (userInfo) {
    user.value = JSON.parse(userInfo) as User; // Ép kiểu dữ liệu khi parse JSON
  }
};

const handleLogout = () => {
  // Xóa token và thông tin user khỏi localStorage
  localStorage.removeItem('auth_token');
  localStorage.removeItem('user_info');

  // Reset state
  user.value = null;
  showNotifications.value = false;

  alert('Đã đăng xuất thành công!');
  router.push('/login');
  
  // Force reload để xóa triệt để cache/state cũ nếu cần thiết
  window.location.reload();
};
</script>