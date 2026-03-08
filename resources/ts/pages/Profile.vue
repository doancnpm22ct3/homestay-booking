<template>
  <div class="bg-gray-50 min-h-screen pb-20">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
      
      <!-- Profile Header -->
      <div class="flex items-center gap-6 mb-12">
        <div class="w-24 h-24 rounded-full bg-emerald-100 flex items-center justify-center text-emerald-700 font-bold text-3xl shadow-sm border border-emerald-200">
          D
        </div>
        <div>
          <h1 class="text-3xl font-bold text-gray-900 mb-2">Death Pool</h1>
          <p class="text-gray-600 flex items-center gap-2">
            <span class="w-2 h-2 rounded-full bg-emerald-500"></span>
            Đà Nẵng, Việt Nam
          </p>
        </div>
      </div>

      <!-- Tabs -->
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

      <!-- Tab Content -->
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
          <form class="space-y-6">
            <div>
              <label for="fullname" class="block text-sm font-medium text-gray-700 mb-1">Họ và Tên</label>
              <input type="text" id="fullname" value="Death Pool" class="w-full px-4 py-3 border border-gray-300 rounded-xl focus:ring-emerald-500 focus:border-emerald-500 bg-gray-50" />
            </div>
            <div>
              <label for="email" class="block text-sm font-medium text-gray-700 mb-1">Email</label>
              <input type="email" id="email" value="deathpool@example.com" class="w-full px-4 py-3 border border-gray-300 rounded-xl focus:ring-emerald-500 focus:border-emerald-500 bg-gray-50" />
            </div>
            <div>
              <label for="phone" class="block text-sm font-medium text-gray-700 mb-1">Số Điện Thoại</label>
              <input type="tel" id="phone" value="0123456789" class="w-full px-4 py-3 border border-gray-300 rounded-xl focus:ring-emerald-500 focus:border-emerald-500 bg-gray-50" />
            </div>
            <div>
              <label for="password" class="block text-sm font-medium text-gray-700 mb-1">Mật Khẩu</label>
              <input type="password" id="password" value="********" class="w-full px-4 py-3 border border-gray-300 rounded-xl focus:ring-emerald-500 focus:border-emerald-500 bg-gray-50" />
            </div>
            <div class="pt-4">
              <button type="button" class="bg-emerald-600 hover:bg-emerald-700 text-white px-8 py-3 rounded-xl font-medium transition-colors">
                Chỉnh sửa
              </button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import RoomCard from '../components/RoomCard.vue';

const activeTab = ref('saved');

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
