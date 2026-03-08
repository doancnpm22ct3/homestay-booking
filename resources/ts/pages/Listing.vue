<template>
  <div class="bg-gray-50 min-h-screen pb-20">
    <!-- Search Bar Section -->
    <div class="bg-white shadow-sm border-b border-gray-200 py-6 sticky top-16 z-40">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="bg-white border border-gray-200 rounded-full shadow-sm p-2 flex flex-col md:flex-row items-center gap-4 max-w-4xl mx-auto">
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
          <button class="bg-emerald-600 hover:bg-emerald-700 text-white p-3 rounded-full transition-colors w-full md:w-auto flex justify-center items-center">
            <Search class="w-5 h-5" />
          </button>
        </div>
      </div>
    </div>

    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
      <div class="mb-12">
        <h2 class="text-2xl font-bold text-gray-900 mb-6">Được tìm kiếm nhiều nhất</h2>
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-8">
          <RoomCard
            v-for="(room, index) in rooms"
            :key="index"
            :id="String(index)"
            :title="room.title"
            :location="room.location"
            :type="room.type"
            :price="room.price"
            :imageUrl="room.imageUrl"
          />
        </div>
      </div>

      <div class="mb-12">
        <h2 class="text-2xl font-bold text-gray-900 mb-6">Homestay nguyên căn</h2>
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-8">
          <RoomCard
            v-for="(room, index) in rooms"
            :key="`house-${index}`"
            :id="`house-${index}`"
            :title="room.title"
            :location="room.location"
            type="Nguyên căn"
            :price="room.price"
            :imageUrl="room.imageUrl"
          />
        </div>
      </div>

      <div>
        <h2 class="text-2xl font-bold text-gray-900 mb-6">Homestay phòng</h2>
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-8">
          <RoomCard
            v-for="(room, index) in rooms"
            :key="`room-${index}`"
            :id="`room-${index}`"
            :title="room.title"
            :location="room.location"
            :type="room.type"
            :price="room.price"
            :imageUrl="room.imageUrl"
          />
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { Search, MapPin, Calendar, Users, Home as HomeIcon } from 'lucide-vue-next';
import RoomCard from '../components/RoomCard.vue';

const location = ref('');
const dates = ref('');
const guests = ref('');
const type = ref('');

const rooms = Array(6).fill({
  title: 'Phòng Mơ Màng, Số 10 Núi Thành',
  location: 'Quận Cẩm Lệ, TP. Đà Nẵng',
  type: 'Phòng',
  price: '120.000đ',
  imageUrl: 'https://picsum.photos/seed/room/800/600',
});
</script>
