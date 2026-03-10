<template>
  <div class="flex flex-col min-h-screen">
    
    <section class="relative pt-16 pb-24 bg-[#FAF9F5]">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex flex-col md:flex-row items-center justify-between gap-12">
          
          <div class="flex-1 md:pr-10">
            <h1 class="text-4xl md:text-5xl font-bold text-[#4A7055] mb-4 font-['Playfair_Display'] leading-tight">
              Kỳ nghỉ trong mơ – Giá bất ngờ
            </h1>
            <p class="text-lg text-gray-700 mb-8 font-['Inter']">
              Săn ngay ưu đãi giảm đến 30% cho các homestay view biển đẹp nhất tháng này.
            </p>
            <button class="bg-[#4A7055] hover:bg-[#3b5a44] text-white px-6 py-3 rounded-lg font-medium transition-colors shadow-md">
              Đặt phòng ngay
            </button>
          </div>

          <div class="flex-1 w-full relative group">
            <img
              src="https://picsum.photos/seed/homestay/800/600"
              alt="Homestay Image"
              class="w-full h-[400px] object-cover rounded-tl-[100px] rounded-br-[100px] shadow-xl"
            />
            
            <button class="absolute left-4 top-1/2 -translate-y-1/2 bg-white/20 hover:bg-white/40 backdrop-blur-md text-white p-2 rounded-full transition-all">
              <ChevronLeft class="w-6 h-6" />
            </button>

            <button class="absolute right-4 top-1/2 -translate-y-1/2 bg-white/20 hover:bg-white/40 backdrop-blur-md text-white p-2 rounded-full transition-all">
              <ChevronRight class="w-6 h-6" />
            </button>
          </div>
        </div>
      </div>

      <div class="relative mt-16 w-full">
        <div class="absolute top-1/2 -translate-y-1/2 left-0 right-0 h-[1px] bg-[#4A7055]/30 z-0"></div>

        <div class="relative z-10 bg-white rounded-full shadow-[0_8px_30px_rgb(0,0,0,0.08)] p-2 flex flex-col md:flex-row items-center max-w-5xl mx-auto border border-[#4A7055]/10">
          
          <div class="flex-1 w-full relative">
            <button 
              @click="toggleDropdown('location')"
              class="flex items-center justify-between px-6 py-3 w-full hover:bg-gray-50 rounded-full transition-colors border-b md:border-b-0 md:border-r border-gray-100"
            >
              <div class="flex items-center gap-3">
                <MapPin class="text-[#4A7055] opacity-60 w-5 h-5 shrink-0" />
                <div class="text-left">
                  <div class="text-sm font-medium text-gray-700">Địa điểm</div>
                  <div class="text-xs" :class="location ? 'text-[#4A7055] font-bold' : 'text-gray-400'">
                    {{ location || 'Bạn muốn đi đâu?' }}
                  </div>
                </div>
              </div>
              <ChevronDown class="text-gray-400 w-4 h-4 hidden lg:block" />
            </button>
            
            <div v-if="activeDropdown === 'location'" class="absolute top-full left-0 mt-4 w-72 bg-white rounded-2xl shadow-xl border border-gray-100 z-50 overflow-hidden">
              <div class="p-2 max-h-60 overflow-y-auto">
                <button v-for="loc in daNangDistricts" :key="loc" @click="selectLocation(loc)" class="w-full text-left px-4 py-3 hover:bg-gray-50 rounded-xl text-sm font-medium text-gray-700 transition-colors">
                  <MapPin class="inline-block w-4 h-4 mr-2 text-gray-400" />
                  {{ loc }}
                </button>
              </div>
            </div>
          </div>

          <div class="flex-1 w-full relative">
            <div class="flex items-center justify-between px-6 py-3 w-full rounded-full border-b md:border-b-0 md:border-r border-gray-100">
              <div class="flex items-center gap-3 w-full">
                <Calendar class="text-[#4A7055] opacity-60 w-5 h-5 shrink-0" />
                <div class="flex flex-col w-full">
                  <div class="text-sm font-medium text-gray-700 mb-0.5">Nhận - Trả phòng</div>
                  <div class="flex items-center gap-1 w-full">
                    <input type="date" v-model="checkIn" class="date-input text-xs text-gray-500 bg-transparent outline-none cursor-pointer w-full" />
                    <span class="text-xs text-gray-400">-</span>
                    <input type="date" v-model="checkOut" class="date-input text-xs text-gray-500 bg-transparent outline-none cursor-pointer w-full" />
                  </div>
                </div>
              </div>
              <ChevronDown class="text-gray-400 w-4 h-4 hidden lg:block ml-2 shrink-0" />
            </div>
          </div>

          <div class="flex-1 w-full relative">
            <button 
              @click="toggleDropdown('type')"
              class="flex items-center justify-between px-6 py-3 w-full hover:bg-gray-50 rounded-full transition-colors border-b md:border-b-0 md:border-r border-gray-100"
            >
              <div class="flex items-center gap-3">
                <HomeIcon class="text-[#4A7055] opacity-60 w-5 h-5 shrink-0" />
                <div class="text-left">
                  <div class="text-sm font-medium text-gray-700">Loại hình thuê</div>
                  <div class="text-xs" :class="type ? 'text-[#4A7055] font-bold' : 'text-gray-400'">
                    {{ type || 'Phòng / Nguyên căn' }}
                  </div>
                </div>
              </div>
              <ChevronDown class="text-gray-400 w-4 h-4 hidden lg:block" />
            </button>

            <div v-if="activeDropdown === 'type'" class="absolute top-full left-0 mt-4 w-48 bg-white rounded-xl shadow-xl border border-gray-100 z-50 overflow-hidden">
              <div class="flex flex-col">
                <button @click="selectType('Phòng')" class="text-left px-5 py-3 hover:bg-gray-50 text-sm font-medium text-gray-700 transition-colors border-b border-gray-50">
                  Phòng
                </button>
                <button @click="selectType('Nguyên căn')" class="text-left px-5 py-3 hover:bg-gray-50 text-sm font-medium text-gray-700 transition-colors">
                  Nguyên căn
                </button>
              </div>
            </div>
          </div>

          <div class="flex-1 w-full relative">
            <div class="flex items-center justify-between px-6 py-3 w-full rounded-full transition-colors">
              <div class="flex items-center gap-3 w-full">
                <Users class="text-[#4A7055] opacity-60 w-5 h-5 shrink-0" />
                <div class="flex flex-col w-full">
                  <div class="text-sm font-medium text-gray-700">Số lượng người</div>
                  <input 
                    type="number" 
                    v-model="guests" 
                    min="1" 
                    placeholder="Thêm khách" 
                    class="hide-arrows text-xs text-gray-500 bg-transparent outline-none w-full mt-0.5" 
                  />
                </div>
              </div>
              <ChevronDown class="text-gray-400 w-4 h-4 hidden lg:block ml-2 shrink-0" />
            </div>
          </div>

          <button
            @click="handleSearch"
            class="bg-[#4A7055] hover:bg-[#3b5a44] text-white p-4 rounded-full transition-colors w-full md:w-14 md:h-14 flex justify-center items-center shrink-0 ml-2 shadow-md"
          >
            <Search class="w-5 h-5" />
            <span class="md:hidden ml-2 font-medium">Tìm kiếm</span>
          </button>
        </div>
      </div>
    </section>

    <section class="py-20 bg-white">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex justify-between items-end mb-10">
          <div>
            <h2 class="text-3xl font-bold text-gray-900 mb-2 font-['Playfair_Display']">Được tìm kiếm nhiều nhất</h2>
            <p class="text-gray-600">Khám phá những chỗ nghỉ phổ biến nhất hiện nay</p>
          </div>
          <Link href="/listing" class="text-[#4A7055] font-medium hover:text-[#3b5a44] hidden sm:block">
            Xem tất cả &rarr;
          </Link>
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
          />
        </div>
        <div class="mt-8 text-center sm:hidden">
          <Link href="/listing" class="text-[#4A7055] font-medium hover:text-[#3b5a44]">
            Xem tất cả &rarr;
          </Link>
        </div>
      </div>
    </section>

    <section class="py-20 bg-[#FAF9F5]">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <h2 class="text-3xl font-bold text-gray-900 mb-10 text-center font-['Playfair_Display']">Loại chỗ nghỉ của bạn</h2>
        <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
          <Link href="/listing?type=house" class="group relative rounded-2xl overflow-hidden h-80 shadow-md">
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
          </Link>
          <Link href="/listing?type=room" class="group relative rounded-2xl overflow-hidden h-80 shadow-md">
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
          </Link>
        </div>
      </div>
    </section>

    <section class="py-24 bg-[#F2F6F3]">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="grid grid-cols-1 lg:grid-cols-2 gap-12 items-center">
          <div>
            <h2 class="text-4xl font-bold mb-6 text-[#4A7055] font-['Playfair_Display']">Về chúng tôi</h2>
            <p class="text-gray-700 text-lg mb-8 leading-relaxed">
              Luôn đảm bảo lịch trình của bạn sẽ được trọn vẹn. Sự riêng tư và thoải mái trong mỗi không gian chúng tôi mang lại cho bạn. Phương thức thanh toán nhanh chóng, an toàn, uy tín. Luôn nhận được sự yêu mến từ khách hàng.
            </p>
            <ul class="space-y-4 mb-8">
              <li class="flex items-center gap-3">
                <div class="w-8 h-8 rounded-full bg-[#4A7055] flex items-center justify-center shrink-0 shadow-sm">
                  <span class="text-white font-bold">✓</span>
                </div>
                <span class="text-gray-800 font-medium">Đảm bảo lịch trình trọn vẹn</span>
              </li>
              <li class="flex items-center gap-3">
                <div class="w-8 h-8 rounded-full bg-[#4A7055] flex items-center justify-center shrink-0 shadow-sm">
                  <span class="text-white font-bold">✓</span>
                </div>
                <span class="text-gray-800 font-medium">Không gian riêng tư & thoải mái</span>
              </li>
              <li class="flex items-center gap-3">
                <div class="w-8 h-8 rounded-full bg-[#4A7055] flex items-center justify-center shrink-0 shadow-sm">
                  <span class="text-white font-bold">✓</span>
                </div>
                <span class="text-gray-800 font-medium">Thanh toán an toàn, uy tín</span>
              </li>
            </ul>
            <button class="bg-[#4A7055] text-white px-8 py-3 rounded-full font-bold hover:bg-[#3b5a44] transition-colors shadow-md">
              Tìm hiểu thêm
            </button>
          </div>
          <div class="relative">
            <div class="aspect-square rounded-3xl overflow-hidden shadow-xl border-4 border-white">
              <img
                src="https://picsum.photos/seed/aboutus/800/800"
                alt="About Us"
                class="w-full h-full object-cover"
                referrerpolicy="no-referrer"
              />
            </div>
            <div class="absolute -bottom-6 -left-6 bg-[#4A7055] p-6 rounded-2xl shadow-xl border border-[#4A7055]/50">
              <div class="text-4xl font-bold text-white mb-1">10k+</div>
              <div class="text-white/80 text-sm font-medium">Khách hàng hài lòng</div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <section class="py-20 bg-white">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <h2 class="text-3xl font-bold text-gray-900 mb-12 text-center font-['Playfair_Display']">Khách hàng nói gì về chúng tôi</h2>
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
          <div v-for="i in 4" :key="i" class="bg-white p-6 rounded-2xl shadow-sm border border-gray-100 hover:shadow-lg transition-shadow duration-300">
            <div class="flex gap-1 mb-4">
              <Star v-for="star in 5" :key="star" class="w-4 h-4 fill-amber-400 text-amber-400" />
            </div>
            <p class="text-gray-600 mb-6 text-sm italic">
              "Mình ở một tuần, trải nghiệm cực kì tốt, 100% sẽ giới thiệu cho bạn mình. Phòng đẹp hơn cả mình kỳ vọng mà giá cả phải chăng."
            </p>
            <div class="flex items-center gap-3">
              <div class="w-10 h-10 rounded-full bg-[#4A7055]/10 flex items-center justify-center text-[#4A7055] font-bold">
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
import { ref } from 'vue';
import { Link, router } from '@inertiajs/vue3';
import { Search, MapPin, Calendar, Users, Home as HomeIcon, Star, ChevronDown, ChevronLeft, ChevronRight } from 'lucide-vue-next';
import RoomCard from '../Components/RoomCard.vue'; 

// State quản lý tìm kiếm
const location = ref('');
const checkIn = ref('');
const checkOut = ref('');
const guests = ref('');
const type = ref('');

// State quản lý Dropdown
const activeDropdown = ref<string | null>(null);

const daNangDistricts = [
  'Quận Hải Châu, Đà Nẵng',
  'Quận Sơn Trà, Đà Nẵng',
  'Quận Ngũ Hành Sơn, Đà Nẵng',
  'Quận Cẩm Lệ, Đà Nẵng',
  'Quận Thanh Khê, Đà Nẵng',
  'Quận Liên Chiểu, Đà Nẵng',
  'Huyện Hòa Vang, Đà Nẵng'
];

const toggleDropdown = (menuName: string) => {
  activeDropdown.value = activeDropdown.value === menuName ? null : menuName;
};

const selectLocation = (loc: string) => {
  location.value = loc;
  activeDropdown.value = null;
};

const selectType = (selectedType: string) => {
  type.value = selectedType;
  activeDropdown.value = null;
};

const handleSearch = () => {
  // Chuyển sang trang Listing sử dụng Inertia
  router.get('/listing');
};

const popularRooms = [
  { id: '1', title: 'Phòng Mơ Màng, Số 10 Núi Thành', location: 'Quận Cẩm Lệ, TP. Đà Nẵng', type: 'Phòng', price: '120.000đ', imageUrl: 'https://picsum.photos/seed/room1/800/600' },
  { id: '2', title: 'Phòng Mơ Màng, Số 10 Núi Thành', location: 'Quận Cẩm Lệ, TP. Đà Nẵng', type: 'Phòng', price: '120.000đ', imageUrl: 'https://picsum.photos/seed/room2/800/600' },
  { id: '3', title: 'Phòng Mơ Màng, Số 10 Núi Thành', location: 'Quận Cẩm Lệ, TP. Đà Nẵng', type: 'Phòng', price: '120.000đ', imageUrl: 'https://picsum.photos/seed/room3/800/600' },
  { id: '4', title: 'Phòng Mơ Màng, Số 10 Núi Thành', location: 'Quận Cẩm Lệ, TP. Đà Nẵng', type: 'Phòng', price: '120.000đ', imageUrl: 'https://picsum.photos/seed/room4/800/600' },
  { id: '5', title: 'Phòng Mơ Màng, Số 10 Núi Thành', location: 'Quận Cẩm Lệ, TP. Đà Nẵng', type: 'Phòng', price: '120.000đ', imageUrl: 'https://picsum.photos/seed/room5/800/600' },
  { id: '6', title: 'Phòng Mơ Màng, Số 10 Núi Thành', location: 'Quận Cẩm Lệ, TP. Đà Nẵng', type: 'Phòng', price: '120.000đ', imageUrl: 'https://picsum.photos/seed/room6/800/600' },
];
</script>

<style scoped>
.hide-arrows::-webkit-outer-spin-button,
.hide-arrows::-webkit-inner-spin-button {
  -webkit-appearance: none;
  margin: 0;
}
.hide-arrows {
  -moz-appearance: textfield;
}

.date-input {
  position: relative;
}

.date-input::-webkit-calendar-picker-indicator {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  width: 100%;
  height: 100%;
  opacity: 0; 
  cursor: pointer;
}
</style>