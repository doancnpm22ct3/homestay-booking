<template>
  <div class="bg-gray-50 min-h-screen pb-20">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
      
      <div class="mb-12" v-if="rooms.length > 0">
        <h2 class="text-2xl font-bold text-gray-900 mb-6">Tất cả chỗ nghỉ</h2>
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-8">
          <RoomCard
            v-for="room in rooms"
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
      </div>

      <div class="mb-12" v-if="houseRooms.length > 0">
        <h2 class="text-2xl font-bold text-gray-900 mb-6">Homestay nguyên căn</h2>
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-8">
          <RoomCard
            v-for="room in houseRooms"
            :key="'house-' + room.id"
            :id="room.id"
            :title="room.title"
            :location="room.location"
            :type="room.type"
            :price="room.price"
            :imageUrl="room.imageUrl"
          />
        </div>
      </div>

      <div v-if="privateRooms.length > 0">
        <h2 class="text-2xl font-bold text-gray-900 mb-6">Homestay dạng phòng</h2>
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-8">
          <RoomCard
            v-for="room in privateRooms"
            :key="'room-' + room.id"
            :id="room.id"
            :title="room.title"
            :location="room.location"
            :type="room.type"
            :price="room.price"
            :imageUrl="room.imageUrl"
          />
        </div>
      </div>
      
      <div v-if="rooms.length === 0" class="text-center py-20 text-gray-500">
        Hiện chưa có phòng nào trong danh sách.
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted } from 'vue';
import { Search, MapPin, Calendar, Users, Home as HomeIcon } from 'lucide-vue-next';
import RoomCard from '../components/RoomCard.vue';

const rooms = ref<any[]>([]);

// Sử dụng Computed để tự động lọc dữ liệu khi mảng rooms thay đổi
const houseRooms = computed(() => {
  return rooms.value.filter(room => room.rawType === 'house');
});

const privateRooms = computed(() => {
  return rooms.value.filter(room => room.rawType === 'room');
});

onMounted(async () => {
  try {
    const response = await fetch('/api/rooms');
    const data = await response.json();
    const visibleRooms = data.filter((room: any) => room.is_visible == 1);
    rooms.value = data.map((room: any) => ({
      id: String(room.id),
      title: room.title,
      location: room.location,
      rawType: room.type, // Lưu lại giá trị 'house' hoặc 'room' gốc để lọc
      type: room.type === 'house' ? 'Nguyên căn' : 'Phòng riêng',
      price: room.price.toLocaleString() + 'đ',
      imageUrl: room.image,
      status: room.status
    }));
  } catch (error) {
    console.error('Lỗi khi tải danh sách phòng:', error);
  }
});
</script>