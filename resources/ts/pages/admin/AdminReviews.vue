<template>
  <div class="space-y-6">
    <div class="flex justify-between items-center bg-white p-6 rounded-2xl shadow-sm border border-gray-100">
      <div>
        <h1 class="text-2xl font-bold text-gray-900 font-['Playfair_Display']">Quản lý đánh giá</h1>
        <p class="text-sm text-gray-500 mt-1 font-['Inter']">Xem và kiểm duyệt các đánh giá từ khách hàng</p>
      </div>
    </div>

    <div class="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden">
      <div v-if="loading" class="p-12 text-center text-gray-500">Đang tải dữ liệu...</div>
      
      <div v-else-if="reviews.length === 0" class="p-12 text-center text-gray-500">
        Không có đánh giá nào.
      </div>
      
      <table v-else class="w-full text-left border-collapse">
        <thead>
          <tr class="bg-gray-50 border-b border-gray-100 text-sm font-bold text-gray-700 font-['Inter']">
            <th class="p-4">Khách & Phòng</th>
            <th class="p-4">Đánh giá</th>
            <th class="p-4">Nội dung</th>
            <th class="p-4">Ngày gửi</th>
            <th class="p-4">Trạng thái</th>
            <th class="p-4 text-center">Thao tác</th>
          </tr>
        </thead>
        <tbody class="text-sm font-['Inter'] divide-y divide-gray-100">
          <tr v-for="review in reviews" :key="review.id" class="hover:bg-gray-50 transition-colors">
            <td class="p-4">
              <div class="font-bold text-gray-900">{{ review.user_name }}</div>
              <div class="text-xs text-gray-500">{{ review.room_title }}</div>
              <div class="text-[10px] text-gray-400">HD: {{ review.booking_code }}</div>
            </td>
            <td class="p-4">
              <div class="flex text-amber-400">
                <span v-for="s in review.rating" :key="'s'+s">★</span>
                <span v-for="e in (5 - review.rating)" :key="'e'+e" class="text-gray-200">★</span>
              </div>
            </td>
            <td class="p-4 max-w-xs text-gray-700 truncate line-clamp-2" :title="review.comment">
              {{ review.comment || 'Không có nhận xét' }}
            </td>
            <td class="p-4 text-gray-500">{{ review.created_at }}</td>
            <td class="p-4">
              <span 
                class="px-2.5 py-1 rounded-full text-xs font-bold"
                :class="review.is_visible ? 'bg-emerald-100 text-emerald-800' : 'bg-red-100 text-red-800'"
              >
                {{ review.is_visible ? 'Hiển thị' : 'Đã ẩn' }}
              </span>
            </td>
            <td class="p-4 text-center space-x-2">
              <button 
                @click="toggleVisible(review)" 
                class="px-3 py-1 rounded bg-gray-100 hover:bg-gray-200 text-gray-700 text-xs font-bold transition-colors"
                :title="review.is_visible ? 'Ẩn đánh giá này' : 'Hiện đánh giá này'"
              >
                {{ review.is_visible ? 'Ẩn' : 'Hiện' }}
              </button>
              <button 
                @click="deleteReview(review.id)" 
                class="px-3 py-1 rounded bg-red-100 hover:bg-red-200 text-red-700 text-xs font-bold transition-colors"
              >
                Xóa
              </button>
            </td>
          </tr>
        </tbody>
      </table>

      <!-- Phân trang (Đơn giản) -->
      <div v-if="totalPages > 1" class="p-4 border-t border-gray-100 flex justify-center gap-2">
        <button 
          @click="changePage(currentPage - 1)" 
          :disabled="currentPage === 1"
          class="px-3 py-1 border rounded hover:bg-gray-50 disabled:opacity-50"
        >
          Trước
        </button>
        <span class="px-4 py-1 text-sm font-medium">Trang {{ currentPage }} / {{ totalPages }}</span>
        <button 
          @click="changePage(currentPage + 1)" 
          :disabled="currentPage === totalPages"
          class="px-3 py-1 border rounded hover:bg-gray-50 disabled:opacity-50"
        >
          Sau
        </button>
      </div>

    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue';

const reviews = ref<any[]>([]);
const loading = ref(false);
const currentPage = ref(1);
const totalPages = ref(1);

const fetchReviews = async (page = 1) => {
  loading.value = true;
  try {
    const token = localStorage.getItem('auth_token');
    const res = await fetch(`/api/admin/reviews?page=${page}`, {
      headers: { 'Authorization': `Bearer ${token}` }
    });
    const data = await res.json();
    reviews.value = data.data;
    currentPage.value = data.current_page;
    totalPages.value = data.last_page;
  } catch (error) {
    console.error(error);
  } finally {
    loading.value = false;
  }
};

const changePage = (page: number) => {
  if (page >= 1 && page <= totalPages.value) {
    fetchReviews(page);
  }
};

const toggleVisible = async (review: any) => {
  if (!confirm(`Bạn có chắc muốn ${review.is_visible ? 'ẩn' : 'hiện'} đánh giá này?`)) return;
  try {
    const token = localStorage.getItem('auth_token');
    const res = await fetch(`/api/admin/reviews/${review.id}/toggle-visible`, {
      method: 'PATCH',
      headers: { 'Authorization': `Bearer ${token}` }
    });
    if (res.ok) {
      review.is_visible = !review.is_visible;
    }
  } catch (err) {
    console.error(err);
  }
};

const deleteReview = async (id: number) => {
  if (!confirm('Bạn có chắc chắn muốn xóa vĩnh viễn đánh giá này?')) return;
  try {
    const token = localStorage.getItem('auth_token');
    const res = await fetch(`/api/admin/reviews/${id}`, {
      method: 'DELETE',
      headers: { 'Authorization': `Bearer ${token}` }
    });
    if (res.ok) {
      fetchReviews(currentPage.value);
    }
  } catch (err) {
    console.error(err);
  }
};

onMounted(() => {
  fetchReviews();
});
</script>
