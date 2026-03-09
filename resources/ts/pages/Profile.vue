<template>
  <div class="bg-gray-50 min-h-screen pb-20">
    <div v-if="user" class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
      
      <div class="flex flex-col md:flex-row md:items-center justify-between gap-6 mb-12">
        <div class="flex items-center gap-6">
          <div class="w-24 h-24 rounded-full bg-emerald-100 flex items-center justify-center text-emerald-700 font-bold text-3xl shadow-sm border border-emerald-200">
            {{ user.name.charAt(0).toUpperCase() }}
          </div>
          <div>
            <h1 class="text-3xl font-bold text-gray-900 mb-2">{{ user.name }}</h1>
            <p class="text-gray-600 flex items-center gap-2">
              <span class="w-2 h-2 rounded-full bg-emerald-500"></span>
              Thành viên hệ thống
            </p>
          </div>
        </div>

        <button @click="handleLogout" class="text-red-600 font-medium px-6 py-2 border border-red-200 rounded-lg hover:bg-red-50 hover:border-red-300 transition-colors w-max">
          Đăng xuất tài khoản
        </button>
      </div>

      <div class="border-b border-gray-200 mb-8">
        <nav class="-mb-px flex space-x-8">
          <button
            @click="activeTab = 'saved'"
            :class="[
              activeTab === 'saved'
                ? 'border-emerald-500 text-emerald-600'
                : 'border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300',
              'whitespace-nowrap py-4 px-1 border-b-2 font-medium text-lg transition-colors'
            ]"
          >
            Đã lưu
          </button>
          <button
            @click="activeTab = 'history'"
            :class="[
              activeTab === 'history'
                ? 'border-emerald-500 text-emerald-600'
                : 'border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300',
              'whitespace-nowrap py-4 px-1 border-b-2 font-medium text-lg transition-colors'
            ]"
          >
            Lịch sử
          </button>
          <button
            @click="activeTab = 'account'"
            :class="[
              activeTab === 'account'
                ? 'border-emerald-500 text-emerald-600'
                : 'border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300',
              'whitespace-nowrap py-4 px-1 border-b-2 font-medium text-lg transition-colors'
            ]"
          >
            Thông tin tài khoản
          </button>
        </nav>
      </div>

      <div class="mt-8">
        
        <div v-if="activeTab === 'saved'" class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-8">
          <RoomCard
            v-for="(room, index) in savedRooms"
            :key="index"
            :id="String(index)"
            :title="room.title"
            :location="room.location"
            :type="room.type"
            :price="room.price"
            :imageUrl="room.imageUrl"
          />
        </div>

        <div v-if="activeTab === 'history'" class="space-y-6 max-w-4xl">
          <h2 class="text-2xl font-bold text-gray-900 mb-6">Thông báo của bạn</h2>
          <div v-for="(room, index) in historyRooms" :key="index" class="bg-white p-6 rounded-2xl shadow-sm border border-gray-100 flex flex-col md:flex-row gap-6 hover:shadow-md transition-shadow">
            <div class="w-full md:w-48 h-32 shrink-0">
              <img :src="room.imageUrl" :alt="room.title" class="w-full h-full object-cover rounded-xl" referrerpolicy="no-referrer" />
            </div>
            <div class="flex-1 flex flex-col justify-between">
              <div>
                <div class="flex justify-between items-start mb-2">
                  <h3 class="text-lg font-bold text-emerald-700">{{ room.status }}</h3>
                  <span class="text-sm text-gray-500 whitespace-nowrap ml-4">{{ room.time }}</span>
                </div>
                <p class="text-gray-600 text-sm leading-relaxed mb-4">
                  {{ room.message }}
                </p>
              </div>
              <button class="text-emerald-600 font-medium text-sm hover:text-emerald-700 self-start underline">
                Xem chi tiết
              </button>
            </div>
          </div>
        </div>

        <div v-if="activeTab === 'account'" class="max-w-2xl bg-white p-8 rounded-2xl shadow-sm border border-gray-100">
          <form class="space-y-6" @submit.prevent="updateProfile">
            <div>
              <label for="fullname" class="block text-sm font-medium text-gray-700 mb-1">Họ và Tên</label>
              <input type="text" id="fullname" v-model="editForm.name" class="w-full px-4 py-3 border border-gray-300 rounded-xl focus:ring-emerald-500 focus:border-emerald-500 bg-gray-50" />
            </div>
            <div>
              <label for="email" class="block text-sm font-medium text-gray-700 mb-1">Email</label>
              <input type="email" id="email" v-model="editForm.email" readonly class="w-full px-4 py-3 border border-gray-300 rounded-xl bg-gray-100 text-gray-500 cursor-not-allowed" title="Email không thể thay đổi" />
            </div>
            <div>
              <label for="phone" class="block text-sm font-medium text-gray-700 mb-1">Số Điện Thoại</label>
              <input type="tel" id="phone" v-model="editForm.phone" readonly class="w-full px-4 py-3 border border-gray-300 rounded-xl bg-gray-100 text-gray-500 cursor-not-allowed" title="Số điện thoại không thể thay đổi" />
            </div>
            
            <div class="pt-4">
              <button type="button" @click="updateProfile" class="bg-emerald-600 hover:bg-emerald-700 text-white px-8 py-3 rounded-xl font-medium transition-colors">
                Cập nhật thông tin
              </button>
            </div>
          </form>
        </div>

      </div>
    </div>

    <div v-else class="min-h-screen flex items-center justify-center">
      <p class="text-gray-500 text-lg">Đang tải thông tin...</p>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue';
import { useRouter } from 'vue-router';
import RoomCard from '../components/RoomCard.vue';

const router = useRouter();

// Biến lưu thông tin user thật
const user = ref<any>(null);

// Form để khách có thể sửa thông tin
const editForm = ref({
  name: '',
  email: '',
  phone: ''
});

const activeTab = ref('account'); // Mở sẵn tab Tài khoản cho khách dễ thấy

// KHI TRANG VỪA TẢI LÊN
onMounted(() => {
  const userInfo = localStorage.getItem('user_info');
  
  if (userInfo) {
    // Nếu có đăng nhập -> Đổ dữ liệu vào biến user và form
    user.value = JSON.parse(userInfo);
    editForm.value.name = user.value.name;
    editForm.value.email = user.value.email;
    editForm.value.phone = user.value.phone || '';
  } else {
    // Nếu chưa đăng nhập -> Đuổi về trang Đăng nhập
    router.push('/login');
  }
});

// Hàm xử lý khi bấm nút Đăng xuất
const handleLogout = () => {
  if(confirm('Bạn có chắc chắn muốn đăng xuất?')) {
    localStorage.removeItem('auth_token');
    localStorage.removeItem('user_info');
    window.location.href = '/'; // Reset toàn bộ và về Trang chủ
  }
};

// Hàm xử lý tạm khi bấm Cập nhật thông tin
const updateProfile = async () => {
  if (!editForm.value.name.trim()) {
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
        email: editForm.value.email, // Dùng email để làm chìa khóa tìm đúng người
        name: editForm.value.name    // Gửi tên mới xuống để lưu
      })
    });

    const data = await response.json();

    if (response.ok) {
      alert('Cập nhật tên thành công!');
      
      // Cập nhật lại thông tin mới vào bộ nhớ trình duyệt
      localStorage.setItem('user_info', JSON.stringify(data.user));
      user.value = data.user;
      
      // Tải lại trang để Header cập nhật tên mới
      window.location.reload();
    } else {
      alert('Lỗi: ' + data.message);
    }
  } catch (error) {
    console.error('Lỗi kết nối:', error);
    alert('Không thể kết nối đến máy chủ!');
  }
};
// DỮ LIỆU MẪU CỦA BẠN CHO TAB ĐÃ LƯU & LỊCH SỬ
const savedRooms = Array(6).fill({
  title: 'Phòng Mơ Màng, Số 10 Núi Thành',
  location: 'Quận Cẩm Lệ, TP. Đà Nẵng',
  type: 'Phòng',
  price: '120.000đ',
  imageUrl: 'https://picsum.photos/seed/room/800/600',
});

const historyRooms = Array(3).fill({
  title: 'Phòng Mơ Màng, Số 10 Núi Thành',
  location: 'Quận Cẩm Lệ, TP. Đà Nẵng',
  type: 'Phòng',
  price: '120.000đ',
  imageUrl: 'https://picsum.photos/seed/room/800/600',
  status: 'Bạn đã đặt phòng thành công',
  message: 'Bạn đã thanh toán thành công và phòng bạn đặt đã được chấp nhận. Hóa đơn chi tiết đã gửi về mail của bạn. Xem chi tiết tại đây',
  time: '1 ngày trước'
});
</script>