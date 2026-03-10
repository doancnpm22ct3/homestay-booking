<template>
  <div class="flex flex-col min-h-screen">
    <!-- Hero Section -->
    <section class="relative h-[600px] flex items-center justify-center">
      <div class="absolute inset-0 z-0">
        <img
          src="https://picsum.photos/seed/hero/1920/1080"
          alt="Hero Background"
          class="w-full h-full object-cover"
          referrerpolicy="no-referrer"
        />
        <div class="absolute inset-0 bg-black/40"></div>
      </div>

      <div class="relative z-10 w-full max-w-5xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
        <h1 class="text-4xl md:text-6xl font-bold text-white mb-6 drop-shadow-lg">
          Kỳ nghỉ trong mơ - Giá bất ngờ
        </h1>
        <p class="text-xl text-white/90 mb-10 drop-shadow-md">
          Săn ngay ưu đãi giảm đến 30% cho các homestay view biển đẹp nhất tháng này.
        </p>

        <!-- Search Bar -->
        <div class="bg-white rounded-full shadow-xl p-2 md:p-4 flex flex-col md:flex-row items-center gap-4 max-w-4xl mx-auto">
          <div class="flex-1 flex items-center gap-3 px-4 py-2 border-b md:border-b-0 md:border-r border-gray-200 w-full">
            <MapPin class="text-gray-400 w-5 h-5 shrink-0" />
            <input
              type="text"
              placeholder="Địa điểm"
              class="w-full outline-none text-gray-700 placeholder-gray-400"
              v-model="location"
            />
          </div>
          <div class="flex-1 flex items-center gap-3 px-4 py-2 border-b md:border-b-0 md:border-r border-gray-200 w-full">
            <Calendar class="text-gray-400 w-5 h-5 shrink-0" />
            <input
              type="text"
              placeholder="Nhận phòng - Trả phòng"
              class="w-full outline-none text-gray-700 placeholder-gray-400"
              v-model="dates"
            />
          </div>
          <div class="flex-1 flex items-center gap-3 px-4 py-2 border-b md:border-b-0 md:border-r border-gray-200 w-full">
            <HomeIcon class="text-gray-400 w-5 h-5 shrink-0" />
            <select
              class="w-full outline-none text-gray-700 bg-transparent appearance-none"
              v-model="type"
            >
              <option value="" disabled>Loại hình thuê</option>
              <option value="room">Phòng</option>
              <option value="house">Nguyên căn</option>
            </select>
          </div>
          <div class="flex-1 flex items-center gap-3 px-4 py-2 w-full">
            <Users class="text-gray-400 w-5 h-5 shrink-0" />
            <input
              type="number"
              placeholder="Số lượng người"
              class="w-full outline-none text-gray-700 placeholder-gray-400"
              v-model="guests"
              min="1"
            />
          </div>
          <button
            @click="handleSearch"
            class="bg-emerald-600 hover:bg-emerald-700 text-white p-4 rounded-full transition-colors w-full md:w-auto flex justify-center items-center"
          >
            <Search class="w-5 h-5" />
            <span class="md:hidden ml-2 font-medium">Tìm kiếm</span>
          </button>
        </div>
      </div>
    </section>

    <!-- Most Searched Section -->
    <section class="py-16 bg-gray-50">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex justify-between items-end mb-8">
          <div>
            <h2 class="text-3xl font-bold text-gray-900 mb-2">Được tìm kiếm nhiều nhất</h2>
            <p class="text-gray-600">Khám phá những chỗ nghỉ phổ biến nhất hiện nay</p>
          </div>
          <router-link to="/listing" class="text-emerald-700 font-medium hover:text-emerald-800 hidden sm:block">
            Xem tất cả &rarr;
          </router-link>
        </div>
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-8">
          <RoomCard
            v-for="room in popularRooms"
            :key="room.id"
            :id="room.id"
            :title="room.title"
            :location="room.location"
            :type="room.type"
            :price="room.price"
            :imageUrl="room.imageUrl"
            :status="room.status" 
          />
        </div>
        <div class="mt-8 text-center sm:hidden">
          <router-link to="/listing" class="text-emerald-700 font-medium hover:text-emerald-800">
            Xem tất cả &rarr;
          </router-link>
        </div>
      </div>
    </section>

    <!-- Accommodation Type Section -->
    <section class="py-16 bg-white">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <h2 class="text-3xl font-bold text-gray-900 mb-8 text-center">Loại chỗ nghỉ của bạn</h2>
        <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
          <router-link to="/listing?type=house" class="group relative rounded-2xl overflow-hidden h-80">
            <img
              src="https://picsum.photos/seed/fullhouse/800/600"
              alt="Full House"
              class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"
              referrerpolicy="no-referrer"
            />
            <div class="absolute inset-0 bg-gradient-to-t from-black/80 via-black/20 to-transparent flex flex-col justify-end p-8">
              <h3 class="text-3xl font-bold text-white mb-2">Full House</h3>
              <p class="text-white/90">Trải nghiệm không gian riêng tư trọn vẹn</p>
            </div>
          </router-link>
          <router-link to="/listing?type=room" class="group relative rounded-2xl overflow-hidden h-80">
            <img
              src="https://picsum.photos/seed/roomtype/800/600"
              alt="Room"
              class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"
              referrerpolicy="no-referrer"
            />
            <div class="absolute inset-0 bg-gradient-to-t from-black/80 via-black/20 to-transparent flex flex-col justify-end p-8">
              <h3 class="text-3xl font-bold text-white mb-2">Phòng riêng</h3>
              <p class="text-white/90">Tiết kiệm chi phí, tiện nghi đầy đủ</p>
            </div>
          </router-link>
        </div>
      </div>
    </section>

    <!-- About Us Section -->
    <section class="py-20 bg-emerald-900 text-white">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="grid grid-cols-1 lg:grid-cols-2 gap-12 items-center">
          <div>
            <h2 class="text-4xl font-bold mb-6">Về chúng tôi</h2>
            <p class="text-emerald-100 text-lg mb-8 leading-relaxed">
              Luôn đảm bảo lịch trình của bạn sẽ được trọn vẹn. Sự riêng tư và thoải mái trong mỗi không gian chúng tôi mang lại cho bạn. Phương thức thanh toán nhanh chóng, an toàn, uy tín. Luôn nhận được sự yêu mến từ khách hàng.
            </p>
            <ul class="space-y-4 mb-8">
              <li class="flex items-center gap-3">
                <div class="w-8 h-8 rounded-full bg-emerald-800 flex items-center justify-center shrink-0">
                  <span class="text-emerald-300 font-bold">✓</span>
                </div>
                <span class="text-emerald-50">Đảm bảo lịch trình trọn vẹn</span>
              </li>
              <li class="flex items-center gap-3">
                <div class="w-8 h-8 rounded-full bg-emerald-800 flex items-center justify-center shrink-0">
                  <span class="text-emerald-300 font-bold">✓</span>
                </div>
                <span class="text-emerald-50">Không gian riêng tư & thoải mái</span>
              </li>
              <li class="flex items-center gap-3">
                <div class="w-8 h-8 rounded-full bg-emerald-800 flex items-center justify-center shrink-0">
                  <span class="text-emerald-300 font-bold">✓</span>
                </div>
                <span class="text-emerald-50">Thanh toán an toàn, uy tín</span>
              </li>
            </ul>
            <button class="bg-white text-emerald-900 px-8 py-3 rounded-full font-bold hover:bg-emerald-50 transition-colors">
              Tìm hiểu thêm
            </button>
          </div>
          <div class="relative">
            <div class="aspect-square rounded-3xl overflow-hidden">
              <img
                src="https://picsum.photos/seed/aboutus/800/800"
                alt="About Us"
                class="w-full h-full object-cover"
                referrerpolicy="no-referrer"
              />
            </div>
            <div class="absolute -bottom-6 -left-6 bg-emerald-800 p-6 rounded-2xl shadow-xl border border-emerald-700/50">
              <div class="text-4xl font-bold text-white mb-1">10k+</div>
              <div class="text-emerald-200 text-sm font-medium">Khách hàng hài lòng</div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Reviews Section -->
    <section class="py-16 bg-gray-50">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <h2 class="text-3xl font-bold text-gray-900 mb-12 text-center">Khách hàng nói gì về chúng tôi</h2>
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
          <div v-for="i in 4" :key="i" class="bg-white p-6 rounded-2xl shadow-sm border border-gray-100">
            <div class="flex gap-1 mb-4">
              <Star v-for="star in 5" :key="star" class="w-4 h-4 fill-amber-400 text-amber-400" />
            </div>
            <p class="text-gray-600 mb-6 text-sm italic">
              "Mình ở một tuần, trải nghiệm cực kì tốt, 100% sẽ giới thiệu cho bạn mình. Phòng đẹp hơn cả mình kỳ vọng mà giá cả phải chăng."
            </p>
            <div class="flex items-center gap-3">
              <div class="w-10 h-10 rounded-full bg-emerald-100 flex items-center justify-center text-emerald-700 font-bold">
                U
              </div>
              <div>
                <div class="font-semibold text-gray-900 text-sm">User {{ i }}</div>
                <div class="text-xs text-gray-500">Khách hàng</div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue';
import { useRouter } from 'vue-router';
import { Search, MapPin, Calendar, Users, Home as HomeIcon, Star } from 'lucide-vue-next';
import RoomCard from '../components/RoomCard.vue';

const router = useRouter();

const location = ref('');
const dates = ref('');
const guests = ref('');
const type = ref('');

const handleSearch = () => {
  router.push('/listing');
};

// Khởi tạo mảng rỗng chứa dữ liệu thật
const popularRooms = ref<any[]>([]);

// Gọi API lấy dữ liệu khi trang vừa mở
onMounted(async () => {
  try {
    const response = await fetch('/api/rooms');
    const data = await response.json();
    
    // BƯỚC 1: Lọc ra những phòng ĐANG HIỂN THỊ (is_visible == 1) hoặc trống/đang dùng
    const visibleRooms = data.filter((room: any) => room.status !== 'hidden'); 
    // (Ghi chú: Sếp tự điều chỉnh điều kiện lọc theo đúng DB của sếp nhé, ví dụ room.is_visible == 1)

    // BƯỚC 2: Xử lý dữ liệu từ mảng ĐÃ LỌC (visibleRooms) thay vì mảng gốc (data)
    popularRooms.value = visibleRooms.map((room: any) => ({
      id: String(room.id),
      title: room.title,
      location: room.location,
      type: room.type === 'house' ? 'Nguyên căn' : 'Phòng riêng',
      
      // FIX GIÁ TIỀN CHUẨN VIỆT NAM Ở ĐÂY NÈ SẾP:
      price: Number(room.price).toLocaleString('vi-VN') + ' VNĐ', 
      
      imageUrl: room.image, 
      status: room.status
    })).slice(0, 6); // Lấy 6 phòng mới nhất
    
  } catch (error) {
    console.error('Lỗi khi tải dữ liệu trang chủ:', error);
  }
});
</script>