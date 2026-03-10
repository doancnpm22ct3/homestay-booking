<template>
  <div class="p-6">
    <div class="flex justify-between items-center mb-6">
      <div>
        <h1 class="text-2xl font-bold text-gray-900">Danh sách phòng</h1>
        <p class="text-gray-500 text-sm mt-1">Quản lý toàn bộ homestay và phòng nghỉ</p>
      </div>
      <router-link to="/admin/rooms/create" class="bg-emerald-600 hover:bg-emerald-700 text-white px-4 py-2 rounded-lg font-medium transition-colors flex items-center gap-2">
        <Plus class="w-5 h-5" /> Thêm phòng mới
      </router-link>
    </div>

    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
      <div class="bg-white rounded-2xl p-6 shadow-sm border border-blue-100 flex items-center gap-4 hover:shadow-md transition-shadow">
        <div class="w-14 h-14 rounded-full bg-blue-50 flex items-center justify-center text-blue-600 font-bold text-2xl">
          🏢
        </div>
        <div>
          <p class="text-sm font-medium text-gray-500 mb-1">Tổng số phòng</p>
          <h3 class="text-3xl font-bold text-gray-900">{{ stats.total }}</h3>
        </div>
      </div>

      <div class="bg-white rounded-2xl p-6 shadow-sm border border-emerald-100 flex items-center gap-4 hover:shadow-md transition-shadow">
        <div class="w-14 h-14 rounded-full bg-emerald-50 flex items-center justify-center text-emerald-600 font-bold text-2xl">
          ✨
        </div>
        <div>
          <p class="text-sm font-medium text-gray-500 mb-1">Phòng trống</p>
          <h3 class="text-3xl font-bold text-gray-900">{{ stats.available }}</h3>
        </div>
      </div>

      <div class="bg-white rounded-2xl p-6 shadow-sm border border-amber-100 flex items-center gap-4 hover:shadow-md transition-shadow">
        <div class="w-14 h-14 rounded-full bg-amber-50 flex items-center justify-center text-amber-600 font-bold text-2xl">
          💳
        </div>
        <div>
          <p class="text-sm font-medium text-gray-500 mb-1">Đã đặt cọc</p>
          <h3 class="text-3xl font-bold text-gray-900">{{ stats.deposited }}</h3>
        </div>
      </div>

      <div class="bg-white rounded-2xl p-6 shadow-sm border border-purple-100 flex items-center gap-4 hover:shadow-md transition-shadow">
        <div class="w-14 h-14 rounded-full bg-purple-50 flex items-center justify-center text-purple-600 font-bold text-2xl">
          🔑
        </div>
        <div>
          <p class="text-sm font-medium text-gray-500 mb-1">Đang sử dụng</p>
          <h3 class="text-3xl font-bold text-gray-900">{{ stats.occupied }}</h3>
        </div>
      </div>
    </div>
    <div class="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden">
      <table class="w-full text-left border-collapse">
        <thead>
          <tr class="bg-gray-50 border-b border-gray-200 text-gray-600 text-sm">
            <th class="p-4 font-semibold w-24">Hình ảnh</th>
            <th class="p-4 font-semibold">Tên phòng</th>
            <th class="p-4 font-semibold">Loại</th>
            <th class="p-4 font-semibold">Giá / đêm</th>
            <th class="p-4 font-semibold">Trạng thái phòng</th>
            <th class="p-4 font-semibold text-center w-32">Thao tác</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="room in rooms" :key="room.id" class="border-b border-gray-100 hover:bg-gray-50 transition-colors text-sm">
            <td class="p-4">
              <img :src="room.image" alt="Room" class="w-16 h-12 object-cover rounded-md border border-gray-200" referrerpolicy="no-referrer" />
            </td>
            <td class="p-4 font-medium text-gray-900">{{ room.title }}</td>
            <td class="p-4 text-gray-600">{{ room.type === 'house' ? 'Nguyên căn' : 'Phòng riêng' }}</td>
            <td class="p-4 text-emerald-600 font-semibold">{{ Number(room.price).toLocaleString('vi-VN') }} VNĐ</td>
            <td class="p-4">
              <span v-if="room.status === 'available'" class="bg-emerald-100 text-emerald-700 px-2 py-1 rounded-full text-xs font-medium">Trống / Sẵn sàng</span>
              <span v-else-if="room.status === 'booked'" class="bg-amber-100 text-amber-700 px-2 py-1 rounded-full text-xs font-medium">Đã đặt cọc</span>
              <span v-else-if="room.status === 'in_use'" class="bg-blue-100 text-blue-700 px-2 py-1 rounded-full text-xs font-medium">Đang sử dụng</span>
              <span v-else-if="room.status === 'maintenance'" class="bg-orange-100 text-orange-700 px-2 py-1 rounded-full text-xs font-medium">Đang dọn dẹp/Bảo trì</span>
              <span v-else class="bg-gray-100 text-gray-700 px-2 py-1 rounded-full text-xs font-medium">Tạm ẩn</span>
            </td>
            <td class="p-4 text-center">
              <div class="flex items-center justify-center gap-3">
                <button @click="editRoom(room.id)" class="text-blue-600 hover:text-blue-800" title="Sửa">
                  <Edit class="w-4 h-4" />
                </button>
                <button @click="deleteRoom(room.id)" class="text-red-600 hover:text-red-800" title="Xóa">
                  <Trash2 class="w-4 h-4" />
                </button>
              </div>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue';
import { useRouter } from 'vue-router';
import { Plus, Edit, Trash2 } from 'lucide-vue-next';

const router = useRouter();

// Khởi tạo mảng chứa dữ liệu danh sách phòng
const rooms = ref<any[]>([]);

// Khởi tạo mảng chứa dữ liệu thống kê
const stats = ref({
  total: 0,
  available: 0,
  deposited: 0,
  occupied: 0
});

// Hàm lấy dữ liệu danh sách phòng
const fetchRooms = async () => {
  try {
    const response = await fetch('/api/rooms');
    const data = await response.json();
    rooms.value = data;
  } catch (error) {
    console.error('Lỗi khi tải danh sách phòng:', error);
  }
};

// Hàm lấy dữ liệu thống kê
const fetchStats = async () => {
  try {
    const response = await fetch('/api/admin/rooms/stats');
    if (response.ok) {
      stats.value = await response.json();
    }
  } catch (error) {
    console.error('Lỗi khi lấy dữ liệu thống kê:', error);
  }
};

// Tự động chạy cả 2 hàm khi mở trang
onMounted(() => {
  fetchRooms();
  fetchStats();
});

const editRoom = (id: number) => {
  router.push(`/admin/rooms/edit/${id}`);
};

const deleteRoom = (id: number) => {
  if (confirm('Bạn có chắc chắn muốn xóa phòng này?')) {
    // Tạm thời xóa trên giao diện
    rooms.value = rooms.value.filter(r => r.id !== id);
    // (Ghi chú: Cần phải viết thêm code gọi API xóa trong DB nếu muốn xóa thật sự)
  }
};
</script>