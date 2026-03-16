<template>
  <div @click="goToDetail" class="group block h-full cursor-pointer">
    <div class="bg-white rounded-2xl overflow-hidden shadow-sm hover:shadow-xl hover:-translate-y-1 transition-all duration-300 h-full flex flex-col border border-gray-100/50">
      
      <div class="relative aspect-[16/10] overflow-hidden">
        <img
          :src="imageUrl"
          :alt="title"
          class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-500"
          referrerpolicy="no-referrer"
        />
        
        <div 
          v-if="status && status !== 'available'" 
          class="absolute top-4 left-4 px-3 py-1.5 rounded-full text-xs font-bold text-white shadow-md z-10 font-['Inter'] tracking-wide" 
          :class="statusClass"
        >
          {{ statusText }}
        </div>

        <div class="absolute top-4 right-4 bg-white/95 backdrop-blur-sm px-3 py-1.5 rounded-full flex items-center gap-1.5 text-xs font-bold text-gray-800 shadow-sm border border-gray-100 z-10">
          <Star class="w-3.5 h-3.5 fill-amber-400 text-amber-400" />
          <span>4.8</span>
        </div>
      </div>

      <div class="flex-grow flex flex-col p-6">
        
        <h3 class="text-xl font-extrabold text-gray-950 mb-1.5 font-['Playfair_Display'] line-clamp-1 group-hover:text-[#4A7055] transition-colors leading-tight">
          {{ title }}
        </h3>
        
        <div class="flex items-center gap-1.5 text-gray-600 text-sm mb-1 font-['Inter']">
          <MapPin class="w-4 h-4 shrink-0 text-[#4A7055] opacity-80" />
          <span class="line-clamp-1">{{ location }}</span>
        </div>

        <div v-if="parentTitle" 
             @click.stop="$emit('filterByParent', parentId)"
             class="flex items-center gap-1.5 text-[#4A7055] hover:bg-emerald-100 cursor-pointer text-xs mb-4 font-bold font-['Inter'] bg-emerald-50 px-2 py-1 rounded-md w-fit transition-colors shadow-sm"
             title="Xem tất cả phòng thuộc homestay này"
        >
          <HomeIcon class="w-3 h-3 shrink-0" />
          <span class="line-clamp-1">Thuộc: {{ parentTitle }}</span>
        </div>
        <div v-else class="mb-5"></div>
        
        <div class="mt-auto pt-4 border-t border-gray-100/70 flex items-center justify-between">
          
          <div class="flex items-center gap-2">
            <div class="bg-gray-100 text-[#4A7055] p-2 rounded-full shadow-inner border border-gray-100">
              <HomeIcon class="w-4 h-4" />
            </div>
            <div class="text-sm text-gray-500 font-['Inter']">
              <span class="font-medium text-gray-900">{{ type }}</span>
            </div>
          </div>
          
          <div class="text-right">
            <div class="text-1.5xl font-extrabold text-[#4A7055] font-['Inter']">{{ price }}</div>
          </div>

        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue';
import { useRouter } from 'vue-router';
import { MapPin, Star, Home as HomeIcon } from 'lucide-vue-next';

const router = useRouter();

// Define emits
defineEmits(['filterByParent']);

// Sử dụng cú pháp Type-only props declaration của Vue 3 + TypeScript
const props = defineProps<{
  id: string;
  title: string;
  location: string;
  type: string;
  price: string;
  imageUrl: string;
  status?: string; 
  parentTitle?: string;
  parentId?: number | string;
}>();

const goToDetail = () => {
  router.push(`/room/${props.id}`);
};

// Logic chuyển đổi chữ tiếng Anh sang tiếng Việt cho nhãn (Từ code của Hiếu)
const statusText = computed(() => {
  switch (props.status) {
    case 'booked': return 'Đã đặt cọc';
    case 'in_use': return 'Đang có khách';
    case 'maintenance': return 'Bảo trì';
    default: return '';
  }
});

// Logic đổi màu nhãn tùy theo trạng thái (Từ code của Hiếu)
const statusClass = computed(() => {
  switch (props.status) {
    case 'booked': return 'bg-amber-500'; // Màu cam
    case 'in_use': return 'bg-red-500'; // Màu đỏ
    case 'maintenance': return 'bg-gray-500'; // Màu xám
    default: return 'bg-[#4A7055]'; // Màu xanh chủ đạo của bạn
  }
});
</script>