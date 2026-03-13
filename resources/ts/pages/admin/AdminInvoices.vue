<template>
  <div class="p-6 relative">
    <div class="flex justify-between items-center mb-6">
      <div>
        <h1 class="text-2xl font-bold text-gray-900">Quản lý Thanh toán & Hóa đơn</h1>
        <p class="text-gray-500 text-sm mt-1">Kiểm soát dòng tiền cọc và lịch sử checkout</p>
      </div>
    </div>

    <div class="bg-white rounded-xl shadow-sm border border-gray-200 overflow-x-auto">
      <table class="w-full text-left border-collapse min-w-[1000px]">
        <thead>
          <tr class="bg-gray-50 border-b border-gray-200 text-gray-600 text-sm">
            <th class="p-4 font-semibold whitespace-nowrap">Mã HĐ</th>
            <th class="p-4 font-semibold min-w-[150px]">Khách hàng</th>
            <th class="p-4 font-semibold min-w-[150px]">Phòng</th>
            <th class="p-4 font-semibold whitespace-nowrap">Tổng tiền</th>
            <th class="p-4 font-semibold whitespace-nowrap">Tiền cọc (30%)</th>
            <th class="p-4 font-semibold whitespace-nowrap text-center">Trạng thái</th>
            <th class="p-4 font-semibold whitespace-nowrap text-center">Thao tác</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="booking in bookings" :key="booking.id" class="border-b border-gray-100 hover:bg-gray-50 text-sm transition-colors">
            
            <td class="p-4 font-bold text-emerald-700 whitespace-nowrap">{{ booking.booking_code }}</td>
            
            <td class="p-4">
              <div class="font-medium text-gray-900 truncate max-w-[150px]" :title="booking.customer_name">{{ booking.customer_name }}</div>
              <div class="text-xs text-gray-500 truncate max-w-[150px]" :title="booking.customer_email">{{ booking.customer_email }}</div>
            </td>
            
            <td class="p-4 font-medium text-gray-700">
              <div class="truncate max-w-[150px]" :title="booking.room_name">{{ booking.room_name }}</div>
            </td>
            
            <td class="p-4 font-semibold text-gray-900 whitespace-nowrap">{{ Number(booking.total_price).toLocaleString('vi-VN') }}đ</td>
            <td class="p-4 font-semibold text-orange-600 whitespace-nowrap">{{ Number(booking.deposit_amount).toLocaleString('vi-VN') }}đ</td>
            
            <td class="p-4 text-center whitespace-nowrap">
              <span v-if="booking.payment_status === 'deposited'" class="bg-amber-100 text-amber-700 px-3 py-1 rounded-full text-xs font-bold border border-amber-200 inline-block">
                Đã đặt cọc
              </span>
              <span v-else-if="booking.payment_status === 'completed'" class="bg-emerald-100 text-emerald-700 px-3 py-1 rounded-full text-xs font-bold border border-emerald-200 inline-block">
                Đã thanh toán đủ
              </span>
            </td>
            
            <td class="p-4 text-center whitespace-nowrap">
              <div class="flex items-center justify-center gap-2">
                <button 
                  @click="openInvoiceModal(booking)" 
                  class="bg-blue-50 text-blue-600 px-3 py-1.5 rounded-lg text-xs font-medium hover:bg-blue-100 transition-colors whitespace-nowrap"
                >
                  {{ booking.payment_status === 'deposited' ? 'Xem Phiếu Cọc' : 'Xem Hóa Đơn' }}
                </button>

                <button 
                  v-if="booking.payment_status === 'deposited'" 
                  @click="handleCheckout(booking.id)" 
                  class="bg-emerald-600 text-white px-3 py-1.5 rounded-lg text-xs font-medium hover:bg-emerald-700 transition-colors shadow-sm whitespace-nowrap"
                >
                  Checkout
                </button>
                
                <button 
                  @click="deleteBooking(booking.id)" 
                  class="bg-red-50 text-red-600 px-3 py-1.5 rounded-lg text-xs font-medium hover:bg-red-100 transition-colors whitespace-nowrap"
                >
                  Xóa
                </button>
              </div>
            </td>
          </tr>
          <tr v-if="bookings.length === 0">
            <td colspan="7" class="p-8 text-center text-gray-500">Chưa có hóa đơn nào trong hệ thống.</td>
          </tr>
        </tbody>
      </table>
    </div>

    <div v-if="isModalOpen && selectedBooking" class="fixed inset-0 z-50 flex items-center justify-center bg-black/60 backdrop-blur-sm p-4">
      <div class="bg-white rounded-2xl shadow-2xl w-full max-w-lg overflow-hidden border border-gray-100">
        
        <div :class="selectedBooking.payment_status === 'deposited' ? 'bg-amber-600' : 'bg-emerald-800'" class="p-6 text-white flex justify-between items-start">
          <div>
            <h2 class="text-xl font-bold mb-1">
              {{ selectedBooking.payment_status === 'deposited' ? 'BIÊN LAI THU TIỀN CỌC' : 'HÓA ĐƠN THANH TOÁN CHI TIẾT' }}
            </h2>
            <p class="text-white/80 text-sm font-mono">Mã số: {{ selectedBooking.booking_code }}</p>
          </div>
          <button @click="closeInvoiceModal" class="text-white/80 hover:text-white transition-colors">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
            </svg>
          </button>
        </div>

        <div class="p-6 space-y-6">
          <div class="grid grid-cols-2 gap-4 text-sm">
            <div>
              <p class="text-gray-500 mb-1">Khách hàng</p>
              <p class="font-bold text-gray-900">{{ selectedBooking.customer_name }}</p>
            </div>
            <div>
              <p class="text-gray-500 mb-1">Số điện thoại</p>
              <p class="font-bold text-gray-900">{{ selectedBooking.customer_phone }}</p>
            </div>
            <div>
              <p class="text-gray-500 mb-1">Thời gian tạo</p>
              <p class="font-bold text-gray-900">{{ selectedBooking.time_vn }}</p>
            </div>
            
            <div>
              <p class="text-gray-500 mb-1">Thanh toán qua</p>
              <p class="font-bold text-blue-700 bg-blue-50 inline-block px-2 py-0.5 rounded border border-blue-100">
                {{ selectedBooking.payment_method === 'ewallet' ? '📱 Ví điện tử' : '🏦 Chuyển khoản' }}
              </p>
            </div>
          </div>

          <div class="border-t border-dashed border-gray-300 pt-6">
            <div class="flex justify-between items-center mb-4">
              <p class="text-gray-500 text-sm">Phòng đã đặt</p>
              <p class="font-bold text-gray-900">{{ selectedBooking.room_name }}</p>
            </div>
          </div>

          <div class="bg-gray-50 rounded-xl p-4 space-y-3 border border-gray-100">
            <template v-if="selectedBooking.payment_status === 'deposited'">
              <div class="flex justify-between text-sm">
                <span class="text-gray-600">Tổng giá trị đơn phòng:</span>
                <span class="font-medium text-gray-900">{{ Number(selectedBooking.total_price).toLocaleString('vi-VN') }}đ</span>
              </div>
              <div class="flex justify-between text-sm pt-3 border-t border-gray-200">
                <span class="font-bold text-gray-900">SỐ TIỀN ĐÃ THU (CỌC 30%):</span>
                <span class="font-extrabold text-amber-600 text-lg">
                  {{ Number(selectedBooking.deposit_amount).toLocaleString('vi-VN') }}đ
                </span>
              </div>
              <p class="text-xs text-center text-amber-600 mt-2 italic">Khách hàng sẽ thanh toán phần còn lại khi nhận phòng.</p>
            </template>

            <template v-else>
              <div class="flex justify-between text-sm">
                <span class="text-gray-600">Tổng tiền phòng:</span>
                <span class="font-semibold text-gray-900">{{ Number(selectedBooking.total_price).toLocaleString('vi-VN') }}đ</span>
              </div>
              <div class="flex justify-between text-sm">
                <span class="text-gray-600">Đã trừ tiền cọc:</span>
                <span class="font-medium text-gray-500">- {{ Number(selectedBooking.deposit_amount).toLocaleString('vi-VN') }}đ</span>
              </div>
              <div class="flex justify-between text-sm pt-3 border-t border-gray-200">
                <span class="font-bold text-gray-900">SỐ TIỀN ĐÃ THANH TOÁN THÊM:</span>
                <span class="font-extrabold text-emerald-600 text-lg">
                  {{ Number(selectedBooking.total_price - selectedBooking.deposit_amount).toLocaleString('vi-VN') }}đ
                </span>
              </div>
              <p class="text-xs text-center text-emerald-600 mt-2 font-bold">✓ Khách đã thanh toán đủ 100% hóa đơn.</p>
            </template>
          </div>
        </div>

        <div class="p-6 bg-gray-50 border-t border-gray-100 flex gap-3">
          <button @click="closeInvoiceModal" class="flex-1 py-2.5 px-4 bg-white border border-gray-300 rounded-xl text-gray-700 font-medium hover:bg-gray-50 transition-colors">
            Đóng
          </button>
          <button class="flex-1 py-2.5 px-4 bg-gray-800 text-white rounded-xl font-medium hover:bg-gray-900 transition-colors">
            In {{ selectedBooking.payment_status === 'deposited' ? 'Phiếu Cọc' : 'Hóa Đơn' }}
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue';

const bookings = ref<any[]>([]);
const isModalOpen = ref(false);
const selectedBooking = ref<any>(null);

const openInvoiceModal = (booking: any) => {
  selectedBooking.value = booking;
  isModalOpen.value = true;
};

const closeInvoiceModal = () => {
  isModalOpen.value = false;
  selectedBooking.value = null;
};

const fetchBookings = async () => {
  try {
    const response = await fetch('/api/admin/invoices');
    if (response.ok) {
      bookings.value = await response.json();
    }
  } catch (error) {
    console.error('Lỗi tải hóa đơn:', error);
  }
};

const handleCheckout = async (id: number) => {
  if (confirm('Khách đã thanh toán phần còn lại? Bấm OK để chốt Checkout và gửi hóa đơn cho khách!')) {
    try {
      const response = await fetch(`/api/admin/invoices/${id}/checkout`, { method: 'PUT' });
      const data = await response.json();
      
      if (response.ok) {
        alert(data.message); 
        fetchBookings(); 
      } else {
        alert('Lỗi: ' + data.message);
      }
    } catch (error) {
      alert('Lỗi kết nối đến máy chủ!');
    }
  }
};

const deleteBooking = async (id: number) => {
  if (confirm('Xóa hóa đơn này vĩnh viễn?')) {
    try {
      const response = await fetch(`/api/admin/invoices/${id}`, { method: 'DELETE' });
      if (response.ok) {
        fetchBookings();
      }
    } catch (error) {
      alert('Lỗi thao tác!');
    }
  }
};

onMounted(() => {
  fetchBookings();
});
</script>