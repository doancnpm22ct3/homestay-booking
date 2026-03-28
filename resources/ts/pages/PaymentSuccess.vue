<template>
  <div class="bg-[#FAF9F5] min-h-screen flex flex-col font-['Inter']">
    <div class="flex-grow flex items-center justify-center py-12">
      <div class="max-w-3xl w-full mx-auto px-4 sm:px-6 lg:px-8">
        
        <div v-if="isLoading" class="bg-white rounded-3xl shadow-sm border border-gray-100 p-12 text-center">
          <div class="animate-spin rounded-full h-12 w-12 border-b-2 border-[#4A7055] mx-auto mb-4"></div>
          <p class="text-gray-500 font-medium">Đang xử lý kết quả thanh toán...</p>
        </div>

        <div v-else-if="errorMessage" class="bg-white rounded-3xl shadow-sm border border-red-100 p-12 text-center">
          <div class="w-20 h-20 bg-red-50 rounded-full flex items-center justify-center mx-auto mb-6">
            <span class="text-red-500 text-4xl font-bold">!</span>
          </div>
          <h1 class="text-3xl font-bold text-gray-900 mb-2 font-['Playfair_Display']">Giao dịch không thành công</h1>
          <p class="text-red-500 font-medium mb-8">{{ errorMessage }}</p>
          <button @click="$router.push('/')" class="bg-gray-100 hover:bg-gray-200 text-gray-700 px-8 py-3 rounded-xl font-bold transition-colors">
            Về trang chủ
          </button>
        </div>

        <div v-else-if="booking" class="bg-white rounded-3xl shadow-sm border border-gray-100 overflow-hidden">
          
          <div class="bg-[#4A7055]/5 p-8 text-center border-b border-[#4A7055]/10">
            <div class="w-20 h-20 bg-[#4A7055]/10 rounded-full flex items-center justify-center mx-auto mb-6">
              <CheckCircle class="w-10 h-10 text-[#4A7055]" />
            </div>
            <h1 class="text-3xl font-bold text-gray-900 mb-2 font-['Playfair_Display']">Thanh toán thành công</h1>
            <p class="text-[#3b5a44] font-medium">Mã đặt phòng: <span class="font-bold">{{ booking.booking_code || booking.id }}</span></p>
          </div>
          
          <div class="p-8 md:p-12">
            <div class="flex flex-col md:flex-row gap-8 mb-12 pb-12 border-b border-gray-100">
              <img :src="roomImage" alt="Room" class="w-full md:w-1/3 h-48 object-cover rounded-2xl shadow-sm border border-gray-100" referrerpolicy="no-referrer" />
              
              <div class="flex-1">
                <h3 class="text-xl font-bold text-gray-900 mb-2 leading-tight">Phòng {{ booking.room_name }}</h3>
                <div class="text-[#4A7055] font-bold mb-6 text-sm">
                  Cọc trước: {{ formatMoney(booking.deposit_amount) }}
                </div>
                
                <div class="grid grid-cols-2 gap-y-5 gap-x-8 text-sm">
                  <div>
                    <div class="text-gray-500 mb-1">Thời gian</div>
                    <div class="font-bold text-gray-900">{{ formatDate(booking.check_in_date) }} - {{ formatDate(booking.check_out_date) }}</div>
                  </div>
                  <div>
                    <div class="text-gray-500 mb-1">Khách</div>
                    <div class="font-bold text-gray-900">
                      {{ booking.adults }} Lớn <span v-if="booking.children > 0">, {{ booking.children }} Trẻ em</span>
                    </div>
                  </div>
                  <div>
                    <div class="text-gray-500 mb-1">Người đặt</div>
                    <div class="font-bold text-gray-900">{{ booking.customer_name }}</div>
                  </div>
                  <div>
                    <div class="text-gray-500 mb-1">Tổng thanh toán</div>
                    <div class="font-extrabold text-[#4A7055] text-lg">{{ formatMoney(booking.total_amount) }}</div>
                  </div>
                </div>
              </div>
            </div>

            <div class="flex flex-col sm:flex-row gap-4 justify-center">
              <router-link to="/profile" class="bg-[#4A7055] hover:bg-[#3b5a44] text-white px-8 py-3.5 rounded-xl font-bold text-center transition-colors shadow-sm">
                Quản lý đặt phòng
              </router-link>
              <router-link to="/" class="bg-white border-2 border-gray-200 hover:bg-gray-50 hover:border-gray-300 text-gray-700 px-8 py-3.5 rounded-xl font-bold text-center transition-colors">
                Trang chủ
              </router-link>
            </div>
          </div>

        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, computed } from 'vue';
import { useRoute } from 'vue-router';
import { CheckCircle } from 'lucide-vue-next';

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

const roomImage = computed(() => {
  return 'https://picsum.photos/seed/room/800/600';
});

onMounted(async () => {
  // Lấy params từ VNPay trả về
  const status = route.query.status as string;
  const bookingId = route.query.booking_id || route.query.id; // Hỗ trợ cả 2 tên biến

  // KIỂM TRA TRẠNG THÁI VNPAY TRƯỚC
  if (status === 'failed') {
    errorMessage.value = "Thanh toán bị hủy hoặc không thành công. Vui lòng thử lại.";
    isLoading.value = false;
    return;
  }
  if (status === 'invalid_signature') {
    errorMessage.value = "Dữ liệu thanh toán không hợp lệ (Lỗi bảo mật).";
    isLoading.value = false;
    return;
  }

  // NẾU THÀNH CÔNG THÌ MỚI ĐI GỌI API LẤY DATA
  if (!bookingId) {
    errorMessage.value = "Không tìm thấy mã đơn hàng.";
    isLoading.value = false;
    return;
  }

  try {
    const token = localStorage.getItem('auth_token');
    
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
    errorMessage.value = "Lỗi khi tải dữ liệu đơn hàng. Vui lòng kiểm tra lại trong mục Quản lý đặt phòng.";
  } finally {
    isLoading.value = false;
  }
});
</script>