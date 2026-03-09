<template>
  <div class="bg-white rounded-2xl shadow-sm hover:shadow-md transition-shadow overflow-hidden border border-gray-100 cursor-pointer group" @click="goToDetail">
    <div class="relative aspect-[4/3] overflow-hidden">
      <img :src="imageUrl" :alt="title" class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-300" referrerpolicy="no-referrer" />
      
      <div v-if="status && status !== 'available'" 
           class="absolute top-3 left-3 px-3 py-1 rounded-full text-xs font-bold text-white shadow-md z-10" 
           :class="statusClass">
        {{ statusText }}
      </div>

      <div class="absolute top-3 right-3 bg-white/90 backdrop-blur-sm px-2 py-1 rounded-lg flex items-center gap-1">
        <Star class="w-3 h-3 fill-amber-400 text-amber-400" />
        <span class="text-xs font-bold text-gray-900">4.8</span>
      </div>
    </div>
    
    <div class="p-4">
      <h3 class="font-bold text-gray-900 text-lg mb-1 truncate">{{ title }}</h3>
      <div class="flex items-center gap-1 text-gray-500 text-sm mb-3">
        <MapPin class="w-4 h-4" />
        <span class="truncate">{{ location }}</span>
      </div>
      
      <div class="flex items-center justify-between mt-4 pt-4 border-t border-gray-100">
        <div class="text-sm text-gray-500">
          Loại chỗ nghỉ: <span class="font-medium text-gray-900">{{ type }}</span>
        </div>
        <div class="text-right">
          <div class="font-bold text-emerald-600 text-lg">{{ price }}</div>
          <div class="text-xs text-gray-500">/ đêm</div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue';
import { useRouter } from 'vue-router';
import { MapPin, Star } from 'lucide-vue-next';

const router = useRouter();

const props = defineProps({
  id: String,
  title: String,
  location: String,
  type: String,
  price: String,
  imageUrl: String,
  status: String // Khai báo thêm prop status để nhận dữ liệu
});

const goToDetail = () => {
  router.push(`/room/${props.id}`);
};

// Logic chuyển đổi chữ tiếng Anh sang tiếng Việt cho nhãn
const statusText = computed(() => {
  switch (props.status) {
    case 'booked': return 'Đã đặt cọc';
    case 'in_use': return 'Đang có khách';
    case 'maintenance': return 'Bảo trì';
    default: return '';
  }
});

// Logic đổi màu nhãn tùy theo trạng thái
const statusClass = computed(() => {
  switch (props.status) {
    case 'booked': return 'bg-amber-500'; // Màu cam
    case 'in_use': return 'bg-red-500'; // Màu đỏ
    case 'maintenance': return 'bg-gray-500'; // Màu xám
    default: return 'bg-emerald-500';
  }
});
</script>