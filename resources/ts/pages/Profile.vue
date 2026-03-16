<template>
  <div class="min-h-[calc(100vh-4rem-20rem)] bg-[#FAF9F5] pb-20">
    
    <div v-if="user">
      <div class="bg-white border-b border-gray-100 shadow-sm pt-8 pb-6">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          
          <div class="flex flex-col md:flex-row md:items-center justify-between gap-6 mb-8">
            <div class="flex items-center gap-6">
              <div class="w-20 h-20 rounded-full bg-[#4A7055]/10 flex items-center justify-center text-[#4A7055] font-bold text-3xl shadow-sm border border-[#4A7055]/20">
                {{ user.name ? user.name.charAt(0).toUpperCase() : 'U' }}
              </div>
              <div>
                <h1 class="text-3xl font-bold text-gray-900 mb-1 font-['Playfair_Display']">{{ user.name }}</h1>
                <p class="text-gray-500 flex items-center gap-2 text-sm font-['Inter']">
                  <span class="w-2 h-2 rounded-full bg-[#4A7055]"></span>
                  Thành viên hệ thống
                </p>
              </div>
            </div>

            <button @click="handleLogout" class="text-red-500 font-medium px-6 py-2.5 border border-red-100 rounded-lg hover:bg-red-50 hover:border-red-200 transition-colors w-max font-['Inter'] shadow-sm">
              Đăng xuất tài khoản
            </button>
          </div>

          <div class="flex space-x-12 text-lg font-bold font-['Playfair_Display']">
            <button 
              @click="activeTab = 'saved'"
              :class="['pb-4 border-b-2 transition-colors', activeTab === 'saved' ? 'border-[#4A7055] text-[#4A7055]' : 'border-transparent text-gray-400 hover:text-[#4A7055]']"
            >
              Đã thích
            </button>
            <button 
              @click="activeTab = 'history'"
              :class="['pb-4 border-b-2 transition-colors', activeTab === 'history' ? 'border-[#4A7055] text-[#4A7055]' : 'border-transparent text-gray-400 hover:text-[#4A7055]']"
            >
              Lịch sử
            </button>
            <button 
              @click="activeTab = 'account'"
              :class="['pb-4 border-b-2 transition-colors', activeTab === 'account' ? 'border-[#4A7055] text-[#4A7055]' : 'border-transparent text-gray-400 hover:text-[#4A7055]']"
            >
              Thông tin tài khoản
            </button>
          </div>
        </div>
      </div>

      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 mt-12">
        
        <div v-if="activeTab === 'account'" class="max-w-3xl">
          <form class="space-y-8 bg-white p-10 rounded-3xl shadow-sm border border-gray-100 font-['Inter']" @submit.prevent="handleUpdateAccount">
            <div class="space-y-6">
              <div class="relative">
                <input type="text" id="fullname" v-model="accountInfo.name" class="peer w-full py-3 border-b border-gray-200 focus:outline-none focus:border-[#4A7055] text-gray-900 placeholder-transparent" placeholder="Họ và Tên" />
                <label for="fullname" class="absolute left-0 -top-3.5 text-sm text-gray-400 transition-all peer-placeholder-shown:text-base peer-placeholder-shown:top-3 peer-focus:-top-3.5 peer-focus:text-sm peer-focus:text-[#4A7055]">Họ và Tên</label>
              </div>
              
              <div class="relative">
                <input type="email" id="email" v-model="accountInfo.email" readonly title="Email không thể thay đổi" class="peer w-full py-3 border-b border-gray-200 focus:outline-none text-gray-500 bg-gray-50 cursor-not-allowed placeholder-transparent" placeholder="Email" />
                <label for="email" class="absolute left-0 -top-3.5 text-sm text-gray-400 transition-all peer-placeholder-shown:text-base peer-placeholder-shown:top-3 peer-focus:-top-3.5 peer-focus:text-sm peer-focus:text-[#4A7055]">Email (Không thể thay đổi)</label>
              </div>

              <div class="relative">
                <input type="tel" id="phone" v-model="accountInfo.phone" readonly title="Số điện thoại không thể thay đổi" class="peer w-full py-3 border-b border-gray-200 focus:outline-none text-gray-500 bg-gray-50 cursor-not-allowed placeholder-transparent" placeholder="Số Điện Thoại" />
                <label for="phone" class="absolute left-0 -top-3.5 text-sm text-gray-400 transition-all peer-placeholder-shown:text-base peer-placeholder-shown:top-3 peer-focus:-top-3.5 peer-focus:text-sm peer-focus:text-[#4A7055]">Số Điện Thoại (Không thể thay đổi)</label>
              </div>

              <div class="relative">
                <input type="password" id="password" v-model="accountInfo.password" class="peer w-full py-3 border-b border-gray-200 focus:outline-none focus:border-[#4A7055] text-gray-900 placeholder-transparent" placeholder="Mật Khẩu" />
                <label for="password" class="absolute left-0 -top-3.5 text-sm text-gray-400 transition-all peer-placeholder-shown:text-base peer-placeholder-shown:top-3 peer-focus:-top-3.5 peer-focus:text-sm peer-focus:text-[#4A7055]">Mật Khẩu (Để trống nếu không đổi)</label>
              </div>
            </div>

            <div class="pt-4">
              <button type="submit" class="bg-[#4A7055] hover:bg-[#3b5a44] text-white px-10 py-3 rounded-xl font-bold transition-colors shadow-md">
                Cập nhật thông tin
              </button>
            </div>
          </form>
        </div>

        <div v-if="activeTab === 'saved'">
          <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-8">
            <RoomCard
              v-for="(room, index) in savedRooms"
              :key="'saved-'+index"
              :id="room.id"
              :title="room.title"
              :location="room.location"
              :type="room.type"
              :price="room.price"
              :imageUrl="room.imageUrl"
            />
          </div>
        </div>

        <div v-if="activeTab === 'history'">
          <div class="space-y-6 max-w-4xl font-['Inter']">
            <div v-for="(room, index) in historyRooms" :key="'history-'+index" class="bg-white p-6 rounded-3xl shadow-sm border border-gray-100 flex flex-col md:flex-row gap-6 hover:shadow-md transition-shadow">
              <div class="w-full md:w-56 h-36 shrink-0">
                <img :src="room.imageUrl" :alt="room.title" class="w-full h-full object-cover rounded-2xl" referrerpolicy="no-referrer" />
              </div>
              <div class="flex-1 flex flex-col justify-between">
                <div>
                  <div class="flex justify-between items-start mb-2">
                    <h3 class="text-lg font-bold text-[#4A7055]">{{ room.status }}</h3>
                    <span class="text-sm text-gray-400 font-medium whitespace-nowrap ml-4">{{ room.time }}</span>
                  </div>
                  <h4 class="font-bold text-gray-900 mb-1 line-clamp-1">{{ room.title }}</h4>
                  <p class="text-gray-600 text-sm leading-relaxed mb-4">
                    {{ room.message }}
                  </p>
                </div>
                <button class="text-[#4A7055] font-bold text-sm hover:text-[#3b5a44] self-start underline transition-colors">
                  Xem hóa đơn chi tiết
                </button>
              </div>
            </div>
          </div>
        </div>

      </div>
    </div>

    <div v-else class="min-h-screen flex items-center justify-center">
      <div class="animate-pulse flex flex-col items-center text-[#4A7055]">
        <div class="w-12 h-12 border-4 border-[#4A7055] border-t-transparent rounded-full animate-spin mb-4"></div>
        <p class="font-medium font-['Inter']">Đang tải thông tin...</p>
      </div>
    </div>

  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, watch } from 'vue';
import { useRouter } from 'vue-router';
import RoomCard from '../components/RoomCard.vue';


// Khai báo Interface cho User
interface User {
  id: number;
  name: string;
  email: string;
  phone?: string | null;
  role?: string;
  status?: string;
}

const router = useRouter();

// State
const activeTab = ref('account');
const user = ref<User | null>(null);

// Form thông tin (Đồng bộ tên biến với data của User)
const accountInfo = ref({
  name: '',
  email: '',
  phone: '',
  password: ''
});

// KHI TRANG VỪA TẢI LÊN
onMounted(() => {
  const userInfo = localStorage.getItem('user_info');
  
  if (userInfo) {
    user.value = JSON.parse(userInfo) as User;
    // Đổ dữ liệu vào form
    accountInfo.value.name = user.value.name;
    accountInfo.value.email = user.value.email;
    accountInfo.value.phone = user.value.phone || '';
  } else {
    // Chưa đăng nhập -> Đuổi về Login
    router.push('/login');
  }
});

// Hàm Đăng xuất
const handleLogout = () => {
  if(confirm('Bạn có chắc chắn muốn đăng xuất khỏi tài khoản này?')) {
    localStorage.removeItem('auth_token');
    localStorage.removeItem('user_info');
    window.location.href = '/'; 
  }
};

// Cập nhật thông tin (Chỉ cho sửa tên theo logic của Hiếu)
const handleUpdateAccount = async () => {
  if (!accountInfo.value.name.trim()) {
    alert('Tên không được để trống!');
    return;
  }

  try {
    const response = await fetch('/api/profile/update', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
      body: JSON.stringify({
        email: accountInfo.value.email, // Dùng email để làm chìa khóa
        name: accountInfo.value.name    // Gửi tên mới
        // Password sẽ được xử lý riêng nếu cần
      })
    });

    const data = await response.json();

    if (response.ok) {
      alert('Cập nhật thông tin thành công!');
      
      // Cập nhật lại localStorage
      localStorage.setItem('user_info', JSON.stringify(data.user));
      user.value = data.user as User;
      
      // Reload để Header ăn theo
      window.location.reload();
    } else {
      alert('Lỗi: ' + data.message);
    }
  } catch (error) {
    console.error('Lỗi kết nối:', error);
    alert('Không thể kết nối đến máy chủ!');
  }
};

// DỮ LIỆU MẪU CỦA BẠN (Mình dùng lại component RoomCard để code ngắn gọn)
// 1. Biến cục gạch thành đồ "sống" (reactive) và để trống ban đầu
const savedRooms = ref<any[]>([]);

// 2. Viết một hàm chuyên đi lục lọi bộ nhớ xem có lưu phòng nào không
const loadSavedRooms = () => {
  const data = localStorage.getItem('saved_rooms');
  if (data) {
    savedRooms.value = JSON.parse(data);
  } else {
    savedRooms.value = []; // Nếu chưa lưu gì thì trả về mảng rỗng
  }
};

// 3. Chạy hàm này ngay khi vừa vào trang Profile
onMounted(() => {
  // ... (Đoạn check user cũ của bạn ở trên cứ giữ nguyên nhé) ...
  
  // Gọi hàm lấy phòng đã lưu
  loadSavedRooms();
});

watch(activeTab, (newTab) => {
  if (newTab === 'saved') {
    loadSavedRooms();
  }
});

const historyRooms = Array(3).fill({
  id: '1',
  title: 'Phòng Mơ Màng, Số 10 Núi Thành - Cẩm Lệ',
  imageUrl: 'https://picsum.photos/seed/room/800/600',
  status: 'Đặt phòng thành công',
  message: 'Bạn đã thanh toán thành công 30% tiền cọc và phòng bạn đặt đã được chấp nhận. Hóa đơn chi tiết đã gửi về mail của bạn.',
  time: '1 ngày trước'
});
</script>