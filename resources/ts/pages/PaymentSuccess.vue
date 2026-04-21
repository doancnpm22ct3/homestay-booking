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
          
          <!-- Nút In hóa đơn -->
          <div class="p-6 border-b border-gray-100 flex justify-between items-center print:hidden">
             <router-link to="/profile?tab=history" class="flex items-center gap-2 text-gray-500 hover:text-[#4A7055] transition-colors font-bold">
              <ChevronLeft class="w-5 h-5" />
              Quay lại lịch sử
            </router-link>
            <button @click="handlePrint" class="bg-[#4A7055] text-white px-6 py-2 rounded-xl font-bold flex items-center gap-2 hover:bg-[#3b5a44] transition-all shadow-md">
              <Printer class="w-5 h-5" />
              In hóa đơn
            </button>
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
                    <div class="text-gray-500 mb-1">Số đêm</div>
                    <div class="font-bold text-gray-900">{{ getNights(booking.check_in_date, booking.check_out_date) }} đêm</div>
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

            <!-- Bảng kê khai giá -->
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
                <tr>
                  <td class="py-4 text-gray-500">Phụ thu (nếu có)</td>
                  <td class="py-4 text-center">0</td>
                  <td class="py-4 text-right">0đ</td>
                  <td class="py-4 text-right">0đ</td>
                </tr>
              </tbody>
            </table>

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

      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, computed } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import { Printer, ChevronLeft, CheckCircle } from 'lucide-vue-next';

const route = useRoute();
const router = useRouter();
const booking = ref<any>(null);
const isLoading = ref(true);
const errorMessage = ref('');

const roomImage = computed(() => {
  if (!booking.value || !booking.value.room || !booking.value.room.images || booking.value.room.images.length === 0) {
    return 'https://picsum.photos/seed/room/800/600';
  }
  
  const images = booking.value.room.images;
  const pImg = images.find((img: any) => img.is_primary) || images[0];
  let url = pImg.image_url;
  
  if (url && !url.startsWith('http') && !url.startsWith('/storage/')) {
    url = url.startsWith('/') ? `/storage${url}` : `/storage/${url}`;
  }
  
  return url;
});

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
  // Lấy params từ VNPay trả về
  const status = route.query.status as string;
  const bookingId = route.query.booking_id || route.query.id;

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

    const data = await response.json();
    booking.value = data.data;
  } catch (error) {
    console.error("Lỗi fetch booking:", error);
    errorMessage.value = "Lỗi khi tải dữ liệu đơn hàng. Vui lòng kiểm tra lại trong mục Lịch sử đặt phòng.";
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
}
</style>