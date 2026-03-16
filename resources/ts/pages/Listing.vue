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
            <button class="bg-[#4A7055] hover:bg-[#3b5a44] text-white px-8 py-3.5 rounded-lg font-medium transition-colors shadow-md">
              Đặt phòng ngay
            </button>
          </div>

          <div class="flex-1 w-full relative group overflow-hidden rounded-tl-[100px] rounded-br-[100px] shadow-xl h-[400px]">
            <transition name="fade" mode="out-in">
              <img 
                :key="currentSlide"
                :src="bannerImages[currentSlide]" 
                alt="Homestay"
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
                <button v-for="loc in daNangDistricts" :key="loc" @click="selectLocation(loc)" class="w-full text-left px-4 py-3 hover:bg-gray-50 rounded-xl text-sm font-medium text-gray-700 transition-colors">
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
                        {{ checkIn ? formatDate(checkIn) : 'ngày nhận' }}
                      </div>
                      <input type="date" v-model="checkIn" class="absolute inset-0 w-full h-full opacity-0 cursor-pointer date-overlay" />
                    </div>
                    <span class="text-xs text-gray-300">-</span>
                    <div class="relative flex-1 cursor-pointer group">
                      <div class="text-xs group-hover:text-[#4A7055] transition-colors" :class="checkOut ? 'text-[#4A7055] font-bold' : 'text-gray-400'">
                        {{ checkOut ? formatDate(checkOut) : 'ngày trả' }}
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
                <button @click="selectType('Phòng riêng')" class="text-left px-5 py-3 hover:bg-gray-50 text-sm font-medium text-gray-700 transition-colors border-b border-gray-50">Phòng riêng</button>
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

          <button @click="executeSearch" class="bg-[#4A7055] hover:bg-[#3b5a44] text-white p-4 rounded-full transition-colors w-full md:w-14 md:h-14 flex justify-center items-center shrink-0 ml-2 shadow-md">
            <Search class="w-5 h-5" />
            <span class="md:hidden ml-2 font-medium">Tìm kiếm</span>
          </button>
        </div>
      </div>
    </section>

    <div id="room-list-section" class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12 flex-grow scroll-mt-32">
      
      <!-- Banner lọc theo Homestay -->
      <div v-if="filterByParentId" class="mb-10 bg-[#4A7055]/10 border border-[#4A7055]/20 p-6 rounded-3xl flex flex-col md:flex-row items-center justify-between gap-4">
        <div class="flex items-center gap-4 text-[#4A7055]">
          <div class="bg-[#4A7055] text-white p-3 rounded-2xl shadow-md">
            <HomeIcon class="w-6 h-6" />
          </div>
          <div>
            <h3 class="text-xl font-bold">Bạn đang xem phòng của Homestay</h3>
            <p class="text-sm font-medium opacity-80">{{ selectedParentTitle }}</p>
          </div>
        </div>
        <button @click="clearParentFilter" class="bg-[#4A7055] text-white px-6 py-2.5 rounded-full font-bold hover:bg-[#3b5a44] transition-all shadow-sm">
          Xem tất cả homestay
        </button>
      </div>
      
      <div v-if="isSearching" class="mb-16">
        <div class="flex justify-between items-end mb-8">
          <div>
            <h2 class="text-3xl font-bold text-gray-900 font-['Playfair_Display']">
              Kết quả tìm kiếm ({{ filteredRooms.length }})
            </h2>
            <p class="text-sm text-[#4A7055] mt-1 font-medium">
              {{ location || 'Mọi nơi' }} <span v-if="type">• {{ type }}</span> <span v-if="guests">• {{ guests }} khách</span>
            </p>
          </div>
          <button @click="resetSearch" class="text-sm text-gray-500 hover:text-[#4A7055] font-medium underline">
            Xóa bộ lọc
          </button>
        </div>

        <div v-if="filteredRooms.length === 0" class="text-center py-20 bg-white rounded-3xl border border-gray-100 shadow-sm">
          <MapPin class="w-12 h-12 text-gray-300 mx-auto mb-4" />
          <h3 class="text-lg font-bold text-gray-900">Không tìm thấy homestay phù hợp</h3>
          <p class="text-gray-500">Thử thay đổi địa điểm hoặc loại hình thuê nhé.</p>
        </div>

        <div v-else class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-8">
          <RoomCard 
            v-for="room in filteredRooms" 
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
            @filterByParent="setParentFilter"
          />
        </div>
      </div>

      <div v-else>
        
        <div class="mb-20" v-if="houseRooms.length > 0">
          <div class="flex justify-between items-end mb-8">
            <div>
              <h2 class="text-3xl font-bold text-gray-900 font-['Playfair_Display'] mb-2">Homestay Nguyên căn</h2>
              <p class="text-gray-600 font-medium">Không gian riêng tư, thoải mái trọn vẹn cho cả gia đình</p>
            </div>
          </div>
          <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-8">
            <RoomCard 
              v-for="(room, index) in houseRooms" 
              :key="'house-'+index" 
              :id="room.id" 
              :title="room.title" 
              :location="room.location" 
              :type="room.type" 
              :price="room.price" 
              :imageUrl="room.imageUrl" 
              :status="room.status"
              :parentTitle="room.parentTitle"
              :parentId="room.parentId"
              @filterByParent="setParentFilter"
            />
          </div>
        </div>

        <div class="mb-16" v-if="privateRooms.length > 0">
          <div class="flex justify-between items-end mb-8">
            <div>
              <h2 class="text-3xl font-bold text-gray-900 font-['Playfair_Display'] mb-2">Homestay Phòng riêng</h2>
              <p class="text-gray-600 font-medium">Tiết kiệm chi phí, lý tưởng cho cặp đôi hoặc du lịch một mình</p>
            </div>
          </div>
          <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-8">
            <RoomCard 
              v-for="(room, index) in privateRooms" 
              :key="'room-'+index" 
              :id="room.id" 
              :title="room.title" 
              :location="room.location" 
              :type="room.type" 
              :price="room.price" 
              :imageUrl="room.imageUrl" 
              :status="room.status"
              :parentTitle="room.parentTitle"
              :parentId="room.parentId"
              @filterByParent="setParentFilter"
            />
          </div>
        </div>

      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted, onUnmounted } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import { Search, MapPin, Calendar, Users, Home as HomeIcon, ChevronDown, ChevronLeft, ChevronRight } from 'lucide-vue-next';
import RoomCard from '../components/RoomCard.vue';

interface Room {
  id: string;
  title: string;
  location: string;
  rawType: string;
  type: string;
  price: string;
  imageUrl: string;
  status: string;
  parentTitle?: string;
  parentId?: number | string;
}

const route = useRoute();
const router = useRouter();

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

const location = ref('');
const checkIn = ref('');
const checkOut = ref('');
const guests = ref<string | number>('');
const type = ref('');
const isSearching = ref(false);
const activeDropdown = ref<string | null>(null);
const filterByParentId = ref<number | string | null>(null);

const selectedParentTitle = computed(() => {
  if (!filterByParentId.value) return '';
  const room = allRooms.value.find(r => r.parentId == filterByParentId.value || r.id == filterByParentId.value);
  return room ? (room.parentTitle || room.title) : 'Homestay';
});

const setParentFilter = (parentId: number | string) => {
  filterByParentId.value = parentId;
  executeSearch();
  // Scroll to list
  const section = document.getElementById('room-list-section');
  if (section) section.scrollIntoView({ behavior: 'smooth' });
};

const clearParentFilter = () => {
  filterByParentId.value = null;
  executeSearch();
};

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

const allRooms = ref<Room[]>([]);
const filteredRooms = ref<Room[]>([]); 

// --- 3 MỤC DANH SÁCH (Không duplication nữa) ---
const popularRooms = computed(() => {
  return allRooms.value.slice(0, 6);
});

const houseRooms = computed(() => {
  return allRooms.value.filter(room => room.rawType === 'whole_house' || room.rawType === 'home');
});

const privateRooms = computed(() => {
  return allRooms.value.filter(room => room.rawType === 'private_room');
});

onMounted(async () => {
  startInterval();

  try {
    const response = await fetch('/api/rooms');
    const data = await response.json();
    
    const visibleRooms = data.filter((room: any) => 
        room.status !== 'hidden' && 
        (room.is_visible == 1 || room.is_visible === true)
    );
    
    allRooms.value = visibleRooms.map((room: any) => {
      let thumb = room.image || 'https://picsum.photos/seed/room/800/600';

      if (thumb && !thumb.startsWith('http') && !thumb.startsWith('/storage/') && !thumb.startsWith('data:')) {
          thumb = thumb.startsWith('/') ? `/storage${thumb}` : `/storage/${thumb}`;
      }

      let rawType = room.rent_type;

      return {
        id: String(room.id),
        title: room.title,
        location: room.location,
        rawType: rawType, 
        type: rawType === 'whole_house' ? 'Nguyên căn' : 'Phòng riêng',
        price: Number(room.price).toLocaleString('vi-VN') + ' VNĐ/đêm',
        imageUrl: thumb,
        status: room.status,
        parentTitle: room.parent_title,
        parentId: room.parent_id
      };
    });

    if (route.query.location || route.query.type || route.query.guests) {
      location.value = (route.query.location as string) || '';
      
      if (route.query.type === 'house') type.value = 'Nguyên căn';
      else if (route.query.type === 'room') type.value = 'Phòng riêng';
      else type.value = (route.query.type as string) || '';

      guests.value = (route.query.guests as string) || '';
      checkIn.value = (route.query.checkIn as string) || '';
      checkOut.value = (route.query.checkOut as string) || '';
      
      executeSearch();
    } else {
      filteredRooms.value = [...allRooms.value];
    }

  } catch (error) {
    console.error('Lỗi khi tải danh sách phòng:', error);
  }

  if (route.hash === '#room-list-section') {
    setTimeout(() => {
      const section = document.getElementById('room-list-section');
      if (section) {
        section.scrollIntoView({ behavior: 'smooth' });
      }
    }, 300); 
  }
});

onUnmounted(() => {
  if (slideInterval) clearInterval(slideInterval);
});

const executeSearch = () => {
  isSearching.value = true;
  activeDropdown.value = null; 

  filteredRooms.value = allRooms.value.filter(room => {
    const matchLocation = location.value === '' || room.location.includes(location.value);
    const matchType = type.value === '' || room.type === type.value;
    const matchParent = !filterByParentId.value || room.parentId == filterByParentId.value || room.id == filterByParentId.value;
    return matchLocation && matchType && matchParent;
  });

  router.replace({
    query: {
      location: location.value || undefined,
      type: type.value === 'Nguyên căn' ? ['whole_house', 'home'] : (type.value === 'Phòng riêng' ? 'private_room' : undefined),
      guests: guests.value ? String(guests.value) : undefined
    }
  });
};

const resetSearch = () => {
  location.value = '';
  checkIn.value = '';
  checkOut.value = '';
  guests.value = '';
  type.value = '';
  filterByParentId.value = null;
  isSearching.value = false;
  filteredRooms.value = [...allRooms.value];
  
  router.replace({ query: {} }); 
};
</script>

<style scoped>
.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.5s ease;
}
.fade-enter-from,
.fade-leave-to {
  opacity: 0;
}

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