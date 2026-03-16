<template>
  <div class="flex flex-col min-h-screen bg-[#FAF9F5]">
    
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
            <router-link 
              to="/listing#room-list-section"
              class="inline-block bg-[#4A7055] hover:bg-[#3b5a44] text-white px-8 py-3.5 rounded-lg font-semibold transition-colors shadow-md"
            >
              Đặt phòng ngay
            </router-link>
          </div>

          <div class="flex-1 w-full relative group overflow-hidden rounded-tl-[100px] rounded-br-[100px] shadow-xl h-[400px]">
            <transition name="fade" mode="out-in">
              <img
                :key="currentSlide"
                :src="bannerImages[currentSlide]"
                alt="Homestay Banner"
                class="w-full h-full object-cover"
              />
            </transition>
            
            <button 
              @click="prevSlide" 
              class="absolute left-4 top-1/2 -translate-y-1/2 bg-white/20 hover:bg-white/40 backdrop-blur-md text-white p-2 rounded-full transition-all"
            >
              <ChevronLeft class="w-6 h-6" />
            </button>

            <button 
              @click="nextSlide" 
              class="absolute right-4 top-1/2 -translate-y-1/2 bg-white/20 hover:bg-white/40 backdrop-blur-md text-white p-2 rounded-full transition-all"
            >
              <ChevronRight class="w-6 h-6" />
            </button>

            <div class="absolute bottom-4 left-1/2 -translate-x-1/2 flex gap-2">
              <button 
                v-for="(img, index) in bannerImages" 
                :key="index"
                @click="goToSlide(index)"
                :class="['w-2.5 h-2.5 rounded-full transition-all', currentSlide === index ? 'bg-white w-6' : 'bg-white/50']"
              ></button>
            </div>
          </div>

        </div>
      </div>

      <div class="relative mt-16 w-full">
        <div class="absolute top-1/2 -translate-y-1/2 left-0 right-0 h-[1px] bg-[#4A7055]/30 z-0"></div>
        <div class="relative z-10 bg-white rounded-full shadow-[0_8px_30px_rgb(0,0,0,0.08)] p-2 flex flex-col md:flex-row items-center max-w-5xl mx-auto border border-[#4A7055]/10">
          
          <div class="flex-1 w-full relative">
            <button @click="toggleDropdown('location')" class="flex items-center justify-between px-6 py-3 w-full hover:bg-gray-50 rounded-full transition-colors border-b md:border-b-0 md:border-r border-gray-100">
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
                <button v-for="loc in daNangDistricts" :key="loc" @click="selectLocation(loc)" class="w-full text-left px-2 py-3 hover:bg-gray-50 rounded-xl text-sm font-medium text-gray-700 transition-colors">
                  <MapPin class="inline-block w-4 h-4 mr-2 text-gray-400" />
                  {{ loc }}
                </button>
              </div>
            </div>
          </div>

          <div class="flex-1 w-full relative">
            <div class="flex items-center justify-between px-6 py-3 w-full rounded-full border-b md:border-b-0 md:border-r border-gray-100 hover:bg-gray-50 transition-colors">
              <div class="flex items-center gap-3 w-full">
                <Calendar class="text-[#4A7055] opacity-60 w-5 h-5 shrink-0" />
                <div class="flex flex-col w-full">
                  <div class="text-sm font-medium text-gray-700 mb-0.5">Nhận - Trả phòng</div>

                  <div class="flex items-center gap-1 w-full mt-0.25">
                    <div class="relative flex-1 cursor-pointer group">
                      <div class="text-xs group-hover:text-[#4A7055] transition-colors" :class="checkIn ? 'text-[#4A7055] font-bold' : 'text-gray-400'">
                        {{ checkIn ? formatDate(checkIn) : 'Ngày nhận' }}
                      </div>
                      <input type="date" v-model="checkIn" class="absolute inset-0 w-full h-full opacity-0 cursor-pointer date-overlay" />
                    </div>
                    <span class="text-xs text-gray-300">-</span>
                    <div class="relative flex-1 cursor-pointer group">
                      <div class="text-xs group-hover:text-[#4A7055] transition-colors" :class="checkOut ? 'text-[#4A7055] font-bold' : 'text-gray-400'">
                        {{ checkOut ? formatDate(checkOut) : 'Ngày trả' }}
                      </div>
                      <input type="date" v-model="checkOut" class="absolute inset-0 w-full h-full opacity-0 cursor-pointer date-overlay" />
                    </div>
                  </div>
                </div>
              </div>
              <ChevronDown class="text-gray-400 w-4 h-4 hidden lg:block ml-2 shrink-0 pointer-events-none" />
            </div>
          </div>

          <div class="flex-1 w-full relative">
            <button @click="toggleDropdown('type')" class="flex items-center justify-between px-6 py-3 w-full hover:bg-gray-50 rounded-full transition-colors border-b md:border-b-0 md:border-r border-gray-100">
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
                <button @click="selectType('Phòng')" class="text-left px-5 py-3 hover:bg-gray-50 text-sm font-medium text-gray-700 transition-colors border-b border-gray-50">Phòng</button>
                <button @click="selectType('Nguyên căn')" class="text-left px-5 py-3 hover:bg-gray-50 text-sm font-medium text-gray-700 transition-colors">Nguyên căn</button>
              </div>
            </div>
          </div>

          <div class="flex-1 w-full relative">
            <div class="flex items-center justify-between px-6 py-3 w-full rounded-full transition-colors">
              <div class="flex items-center gap-3 w-full">
                <Users class="text-[#4A7055] opacity-60 w-5 h-5 shrink-0" />
                <div class="flex flex-col w-full">
                  <div class="text-sm font-medium text-gray-700">Số lượng người</div>
                  <input type="number" v-model="guests" min="1" placeholder="Thêm khách" class="hide-arrows text-xs text-gray-500 bg-transparent outline-none w-full mt-0.5" />
                </div>
              </div>
              <ChevronDown class="text-gray-400 w-4 h-4 hidden lg:block ml-2 shrink-0" />
            </div>
          </div>

          <button @click="handleSearch" class="bg-[#4A7055] hover:bg-[#3b5a44] text-white p-4 rounded-full transition-colors w-full md:w-14 md:h-14 flex justify-center items-center shrink-0 ml-2 shadow-md">
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
          <router-link to="/listing" class="text-[#4A7055] font-medium hover:text-[#3b5a44] hidden sm:block">
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
            :parentTitle="room.parentTitle"
            :parentId="room.parentId"
          />
        </div>
        <div class="mt-8 text-center sm:hidden">
          <router-link to="/listing" class="text-[#4A7055] font-medium hover:text-[#3b5a44]">
            Xem tất cả &rarr;
          </router-link>
        </div>
      </div>
    </section>

    <section class="py-20 bg-[#FAF9F5]">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <h2 class="text-3xl font-bold text-gray-900 mb-10 text-center font-['Playfair_Display']">Loại chỗ nghỉ của bạn</h2>
        <div class="grid grid-cols-1 md:grid-cols-2 gap-8">

          <router-link to="/listing?type=house" class="group relative rounded-2xl overflow-hidden h-80 shadow-md">
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

          <router-link to="/listing?type=room" class="group relative rounded-2xl overflow-hidden h-80 shadow-md">
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
            <router-link 
              to="/about" 
              class="inline-block bg-[#4A7055] text-white px-8 py-3 rounded-full font-bold hover:bg-[#3b5a44] transition-colors shadow-md"
            >
              Tìm hiểu thêm
            </router-link>
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
import { ref, onMounted, onUnmounted } from 'vue';
import { useRouter } from 'vue-router';
import { Search, MapPin, Calendar, Users, Home as HomeIcon, Star, ChevronDown, ChevronLeft, ChevronRight } from 'lucide-vue-next';
import RoomCard from '../components/RoomCard.vue'; 

const router = useRouter();

interface Room {
  id: string;
  title: string;
  location: string;
  type: string;
  price: string;
  imageUrl: string;
  status: string;
  parentTitle?: string;
  parentId?: number | string;
}

const bannerImages = [
  'https://images.unsplash.com/photo-1499793983690-e29da59ef1c2?q=80&w=2070&auto=format&fit=crop',
  'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?q=80&w=2070&auto=format&fit=crop',
  'https://images.unsplash.com/photo-1502672260266-1c1de2d9d0cb?q=80&w=2080&auto=format&fit=crop'
];
const currentSlide = ref(0);
let slideInterval: ReturnType<typeof setInterval> | null = null;

const nextSlide = () => {
  currentSlide.value = (currentSlide.value + 1) % bannerImages.length;
  resetInterval();
};

const prevSlide = () => {
  currentSlide.value = (currentSlide.value - 1 + bannerImages.length) % bannerImages.length;
  resetInterval();
};

const goToSlide = (index: number) => {
  currentSlide.value = index;
  resetInterval();
};

const startInterval = () => {
  slideInterval = setInterval(() => {
    currentSlide.value = (currentSlide.value + 1) % bannerImages.length;
  }, 4000);
};

const resetInterval = () => {
  if (slideInterval) clearInterval(slideInterval);
  startInterval();
};

onUnmounted(() => {
  if (slideInterval) clearInterval(slideInterval);
});

const location = ref('');
const checkIn = ref('');
const checkOut = ref('');
const guests = ref<string | number>('');
const type = ref('');
const activeDropdown = ref<string | null>(null);

const formatDate = (dateStr: string) => {
  if (!dateStr) return '';
  const [year, month, day] = dateStr.split('-');
  return `${day}/${month}/${year}`;
};

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
  router.push({
    path: '/listing',
    query: {
      location: location.value,
      type: type.value,
      guests: guests.value,
      checkIn: checkIn.value,
      checkOut: checkOut.value
    }
  });
};

const popularRooms = ref<Room[]>([]);

onMounted(async () => {
  startInterval(); 

  try {
    const response = await fetch('/api/rooms');
    const data = await response.json();
    
    // Lọc an toàn: Kiểm tra is_visible (có thể là số 1, chuỗi "1" hoặc true)
    const visibleRooms = data.filter((room: any) => 
        room.status !== 'hidden' && 
        (room.is_visible == 1 || room.is_visible === true)
    ); 

    popularRooms.value = visibleRooms.map((room: any) => {
      let thumb = room.image || 'https://picsum.photos/seed/room/800/600';
      
      if (thumb && !thumb.startsWith('http') && !thumb.startsWith('/storage/') && !thumb.startsWith('data:')) {
          thumb = thumb.startsWith('/') ? `/storage${thumb}` : `/storage/${thumb}`;
      }

      return {
        id: String(room.id),
        title: room.title,
        location: room.location,
        type: room.rent_type === 'private_room' ? 'Phòng riêng' : 'Nguyên căn',
        price: Number(room.price).toLocaleString('vi-VN') + ' VNĐ/đêm', 
        imageUrl: thumb, 
        status: room.status,
        parentTitle: room.parent_title,
        parentId: room.parent_id
      };
    }).slice(0, 6); 
    
  } catch (error) {
    console.error('Lỗi khi tải dữ liệu trang chủ:', error);
  }
});
</script>

<style scoped>
/* CSS cho hiệu ứng mờ dần (Fade) khi đổi ảnh banner */
.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.5s ease;
}
.fade-enter-from,
.fade-leave-to {
  opacity: 0.5;
}

/* CSS cho thanh tìm kiếm */
.hide-arrows::-webkit-outer-spin-button,
.hide-arrows::-webkit-inner-spin-button {
  -webkit-appearance: none;
  appearance: none;
  margin: 0;
}
.hide-arrows {
  -moz-appearance: textfield;
  appearance: textfield;
}

.date-overlay::-webkit-calendar-picker-indicator {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  margin: 0;
  padding: 0;
  cursor: pointer;
  opacity: 0; 
}
</style>