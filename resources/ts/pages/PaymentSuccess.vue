<template>
  <div class="bg-[#FAF9F5] min-h-screen py-10 print:bg-white print:py-0">
    <div class="max-w-4xl mx-auto px-4 print:px-0">
      
      <!-- Nút điều khiển (Ẩn khi in) -->
      <div class="mb-6 flex justify-between items-center print:hidden">
        <router-link to="/profile" class="flex items-center gap-2 text-gray-500 hover:text-[#4A7055] transition-colors font-bold">
          <ChevronLeft class="w-5 h-5" />
          Quay lại lịch sử
        </router-link>
        <button @click="handlePrint" class="bg-[#4A7055] text-white px-6 py-2 rounded-xl font-bold flex items-center gap-2 hover:bg-[#3b5a44] transition-all shadow-md">
          <Printer class="w-5 h-5" />
          In hóa đơn
        </button>
      </div>

      <div v-if="isLoading" class="bg-white rounded-3xl p-20 text-center shadow-sm">
        <div class="animate-spin rounded-full h-12 w-12 border-4 border-[#4A7055] border-t-transparent mx-auto mb-4"></div>
        <p class="text-gray-500">Đang tải hóa đơn...</p>
      </div>

      <div v-else-if="booking" id="invoice-content" class="bg-white rounded-3xl shadow-xl overflow-hidden print:shadow-none print:rounded-none border border-gray-100 print:border-0 font-['Inter']">
        <!-- Header Hóa đơn -->
        <div class="bg-[#4A7055] text-white p-10 flex flex-col md:flex-row justify-between items-start md:items-center gap-6">
          <div>
            <h1 class="text-4xl font-black uppercase tracking-tighter mb-2">HÓA ĐƠN</h1>
            <p class="opacity-80 font-medium">Mã booking: #{{ booking.booking_code }}</p>
          </div>
          <div class="text-right md:text-right text-left">
            <h2 class="text-xl font-bold">Duy Homestay</h2>
            <p class="text-sm opacity-80">Số 10 Núi Thành, Cẩm Lệ, Đà Nẵng</p>
            <p class="text-sm opacity-80">Hotline: 090 123 4567</p>
          </div>
        </div>

        <div class="p-10 space-y-10">
          <!-- Thông tin khách hàng & Homestay -->
          <div class="grid grid-cols-1 md:grid-cols-2 gap-10 border-b border-gray-100 pb-10">
            <div>
              <h3 class="text-[11px] font-black uppercase tracking-[0.2em] text-[#4A7055] mb-4">KHÁCH HÀNG</h3>
              <div class="space-y-1">
                <p class="font-bold text-gray-900 text-lg">{{ booking.customer_name }}</p>
                <p class="text-gray-500">{{ booking.customer_email }}</p>
                <p class="text-gray-500">{{ booking.customer_phone }}</p>
              </div>
            </div>
            <div>
              <h3 class="text-[11px] font-black uppercase tracking-[0.2em] text-[#4A7055] mb-4">CHI TIẾT CHỖ NGHỈ</h3>
              <div class="space-y-1">
                <p class="font-bold text-gray-900 text-lg">{{ booking.room_name }}</p>
                <p class="text-gray-500">{{ booking.room?.location || 'Đà Nẵng' }}</p>
                <p class="text-gray-500">Check-in: {{ formatDate(booking.check_in_date) }} | Check-out: {{ formatDate(booking.check_out_date) }}</p>
              </div>
            </div>
          </div>

          <!-- Bảng kê khai giá -->
          <div>
            <table class="w-full text-left">
              <thead>
                <tr class="text-[11px] font-black uppercase tracking-[0.2em] text-gray-400 border-b border-gray-100">
                  <th class="py-4">Mô tả dịch vụ</th>
                  <th class="py-4 text-center">Số lượng</th>
                  <th class="py-4 text-right">Đơn giá</th>
                  <th class="py-4 text-right">Thành tiền</th>
                </tr>
              </thead>
              <tbody class="divide-y divide-gray-50">
                <tr>
                  <td class="py-6">
                    <p class="font-bold text-gray-900">Tiền thuê phòng</p>
                    <p class="text-sm text-gray-500">Lưu trú {{ getNights(booking.check_in_date, booking.check_out_date) }} đêm</p>
                  </td>
                  <td class="py-6 text-center text-gray-900 font-medium">1</td>
                  <td class="py-6 text-right text-gray-900">{{ formatMoney(booking.total_amount) }}</td>
                  <td class="py-6 text-right text-gray-900 font-bold">{{ formatMoney(booking.total_amount) }}</td>
                </tr>
                <!-- Các phụ phí nếu có -->
                <tr>
                  <td class="py-4 text-gray-500">Phụ thu (nếu có)</td>
                  <td class="py-4 text-center">0</td>
                  <td class="py-4 text-right">0đ</td>
                  <td class="py-4 text-right">0đ</td>
                </tr>
              </tbody>
            </table>
          </div>

          <!-- Tổng cộng -->
          <div class="flex justify-end pt-6">
            <div class="w-full md:w-80 space-y-3">
              <div class="flex justify-between text-gray-500">
                <span>Tạm tính</span>
                <span>{{ formatMoney(booking.total_amount) }}</span>
              </div>
              <div class="flex justify-between text-[#4A7055] font-bold">
                <span>Đã cọc trước (30%)</span>
                <span>- {{ formatMoney(booking.deposit_amount) }}</span>
              </div>
              <div class="flex justify-between pt-3 border-t-2 border-[#4A7055] text-xl font-black text-gray-900">
                <span>CÒN LẠI</span>
                <span>{{ formatMoney(booking.total_amount - booking.deposit_amount) }}</span>
              </div>
            </div>
          </div>
        </div>

        <!-- Footer Hóa đơn -->
        <div class="p-10 bg-gray-50 text-center text-sm text-gray-400 border-t border-gray-100">
          <p class="mb-1">Cảm ơn bạn đã tin tưởng Duy Homestay!</p>
          <p>Hóa đơn này được tạo tự động và có giá trị thanh toán tại quầy khi nhận phòng.</p>
        </div>
      </div>

      <div v-else-if="errorMessage" class="bg-white rounded-3xl p-12 text-center shadow-sm border border-red-50">
        <p class="text-red-500 font-medium">{{ errorMessage }}</p>
        <button @click="window.location.reload()" class="mt-4 text-[#4A7055] font-bold underline">Thử lại</button>
      </div>

    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, computed } from 'vue';
import { useRoute } from 'vue-router';
import { Printer, ChevronLeft, CheckCircle } from 'lucide-vue-next';

const route = useRoute();
const booking = ref<any>(null);
const isLoading = ref(true);
const errorMessage = ref('');

const formatMoney = (amount: number | string) => {
  if (!amount) return '0đ';
  return Number(amount).toLocaleString('vi-VN') + 'đ';
};

const formatDate = (dateString: string) => {
  if (!dateString) return '';
  const date = new Date(dateString);
  return date.toLocaleDateString('vi-VN');
};

const getNights = (start: string, end: string) => {
  if (!start || !end) return 1;
  const s = new Date(start);
  const e = new Date(end);
  const diff = Math.abs(e.getTime() - s.getTime());
  return Math.ceil(diff / (1000 * 60 * 60 * 24));
};

const handlePrint = () => {
  window.print();
};

onMounted(async () => {
  const bookingId = route.query.id;
  if (!bookingId) {
    errorMessage.value = "Không tìm thấy thông tin đơn hàng.";
    isLoading.value = false;
    return;
  }

  try {
    const token = localStorage.getItem('auth_token');
    // Vì /api/admin/bookings yêu cầu quyền admin, ta nên tạo route riêng hoặc dùng logic fetch phù hợp
    // Tuy nhiên theo code cũ của bạn đang gọi vào đây. Mình sẽ giữ nguyên và mong là Backend đã phân quyền.
    const response = await fetch(`/api/admin/bookings/${bookingId}`, {
      headers: {
        'Authorization': `Bearer ${token}`,
        'Accept': 'application/json'
      }
    });

    if (!response.ok) {
      throw new Error('Không thể tải thông tin đặt phòng');
    }

    booking.value = await response.json();
  } catch (error) {
    console.error("Lỗi fetch booking:", error);
    errorMessage.value = "Hết phiên đăng nhập hoặc không có quyền xem hóa đơn này.";
  } finally {
    isLoading.value = false;
  }
});
</script>

<style scoped>
@media print {
  @page {
    margin: 0;
    size: A4;
  }
  body {
    background: white !important;
  }
  #invoice-content {
    border: none !important;
    box-shadow: none !important;
    width: 100% !important;
    margin: 0 !important;
  }
}
</style>