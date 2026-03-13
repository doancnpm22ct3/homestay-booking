<template>
  <div class="bg-gray-50 min-h-screen pb-20">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
      <h1 class="text-3xl font-bold text-gray-900 mb-8">Xác nhận thông tin</h1>
      
      <div class="grid grid-cols-1 lg:grid-cols-3 gap-12">
        <div class="lg:col-span-2">
          <form @submit.prevent="handlePayment" class="space-y-8 bg-white p-8 rounded-2xl shadow-sm border border-gray-100">
            <div class="space-y-6">
              <h2 class="text-xl font-semibold text-gray-900">Thông tin liên hệ</h2>
              <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <div>
                  <label for="name" class="block text-sm font-medium text-gray-700 mb-1">Tên *</label>
                  <input v-model="form.name" type="text" id="name" required class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-emerald-500 focus:border-emerald-500" />
                </div>
                <div>
                  <label for="email" class="block text-sm font-medium text-gray-700 mb-1">Email *</label>
                  <input v-model="form.email" type="email" id="email" required class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-emerald-500 focus:border-emerald-500" />
                </div>
                <div class="md:col-span-2">
                  <label for="phone" class="block text-sm font-medium text-gray-700 mb-1">Số điện thoại *</label>
                  <input v-model="form.phone" type="tel" id="phone" required class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-emerald-500 focus:border-emerald-500" />
                </div>
                <div class="md:col-span-2">
                  <label for="note" class="block text-sm font-medium text-gray-700 mb-1">Ghi chú</label>
                  <textarea v-model="form.note" id="note" rows="4" class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-emerald-500 focus:border-emerald-500"></textarea>
                </div>
              </div>
            </div>

            <div class="pt-8 border-t border-gray-200">
              <h2 class="text-xl font-semibold text-gray-900 mb-6">Phương thức thanh toán</h2>
              <div class="space-y-4">
                <label :class="`flex items-center p-4 border rounded-xl cursor-pointer transition-colors ${paymentMethod === 'bank' ? 'border-emerald-600 bg-emerald-50' : 'border-gray-200 hover:bg-gray-50'}`">
                  <input 
                    type="radio" 
                    name="payment" 
                    value="bank" 
                    v-model="paymentMethod"
                    class="w-5 h-5 text-emerald-600 focus:ring-emerald-500"
                  />
                  <span class="ml-3 font-medium text-gray-900">Chuyển khoản ngân hàng</span>
                </label>
                <label :class="`flex items-center p-4 border rounded-xl cursor-pointer transition-colors ${paymentMethod === 'ewallet' ? 'border-emerald-600 bg-emerald-50' : 'border-gray-200 hover:bg-gray-50'}`">
                  <input 
                    type="radio" 
                    name="payment" 
                    value="ewallet" 
                    v-model="paymentMethod"
                    class="w-5 h-5 text-emerald-600 focus:ring-emerald-500"
                  />
                  <span class="ml-3 font-medium text-gray-900">Ví điện tử (Momo, ZaloPay, VNPay)</span>
                </label>
              </div>
            </div>

            <div class="pt-8 border-t border-gray-200">
              <button type="submit" class="w-full bg-emerald-600 hover:bg-emerald-700 text-white py-4 rounded-xl font-bold text-lg transition-colors">
                Xác nhận & Thanh toán cọc
              </button>
            </div>
          </form>
        </div>

        <div class="lg:col-span-1">
          <div v-if="draftBooking" class="bg-white border border-gray-200 rounded-2xl p-6 shadow-sm sticky top-24">
            <div class="flex gap-4 mb-6 pb-6 border-b border-gray-200">
              <img :src="draftBooking.roomImage" alt="Room" class="w-24 h-24 object-cover rounded-xl" referrerpolicy="no-referrer" />
              <div>
                <h3 class="font-semibold text-gray-900 line-clamp-2 mb-1">{{ draftBooking.roomName }}</h3>
                <div class="text-sm text-gray-500">Phòng Homestay</div>
              </div>
            </div>

            <h3 class="font-semibold text-gray-900 mb-4 text-lg">Chi tiết đặt phòng</h3>
            
            <div class="space-y-4 mb-6 pb-6 border-b border-gray-200">
              <div class="flex justify-between">
                <span class="text-gray-600">Ngày</span>
                <span class="font-medium text-gray-900 text-right">Sắp tới</span>
              </div>
              <div class="flex justify-between">
                <span class="text-gray-600">Số lượng</span>
                <span class="font-medium text-gray-900 text-right">{{ draftBooking.adults }} người lớn, {{ draftBooking.children }} trẻ em</span>
              </div>
            </div>

            <div class="space-y-4 mb-6 pb-6 border-b border-gray-200">
              <div class="flex justify-between">
                <span class="text-gray-600">Giá phòng (1 đêm)</span>
                <span class="font-medium text-gray-900">{{ Number(draftBooking.pricePerNight).toLocaleString('vi-VN') }}đ</span>
              </div>
              <div class="flex justify-between items-center pt-2">
                <span class="font-bold text-gray-900 text-lg">Tổng tiền</span>
                <span class="font-bold text-gray-900 text-xl">{{ Number(totalPrice).toLocaleString('vi-VN') }}đ</span>
              </div>
            </div>

            <div class="bg-emerald-50 p-4 rounded-xl border border-emerald-100 flex justify-between items-center">
              <div>
                <span class="font-bold text-emerald-800 block">Thanh toán cọc (30%)</span>
                <span class="text-xs text-emerald-600">Phần còn lại thu khi nhận phòng</span>
              </div>
              <span class="font-bold text-emerald-700 text-2xl">{{ Number(depositAmount).toLocaleString('vi-VN') }}đ</span>
            </div>

          </div>
          
          <div v-else class="bg-white border border-gray-200 rounded-2xl p-6 shadow-sm text-center text-gray-500">
            Đang tải thông tin phòng...
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue';
import { useRouter } from 'vue-router';

const router = useRouter();
const paymentMethod = ref('bank');
const draftBooking = ref<any>(null);

// Form thông tin
const form = ref({
  name: '',
  email: '',
  phone: '',
  note: ''
});

// Biến tính tiền
const totalPrice = ref(0);
const depositAmount = ref(0);

// CHẠY KHI TRANG VỪA LOAD
onMounted(() => {
  // 1. Mở balo (localStorage) lấy thông tin phòng khách vừa chọn
  const savedBooking = localStorage.getItem('draft_booking');
  if (savedBooking) {
    draftBooking.value = JSON.parse(savedBooking);
    
    // Tính tổng tiền (Tạm tính 1 đêm, sếp có thể nhân lên sau nếu có logic chọn số ngày)
    totalPrice.value = Number(draftBooking.value.pricePerNight);
    
    // TÍNH CỌC 30%
    depositAmount.value = totalPrice.value * 0.3; 
  } else {
    alert('Không tìm thấy thông tin đặt phòng!');
    router.push('/');
  }

  // 2. Tự động điền thông tin nếu khách đã đăng nhập
  const userInfo = localStorage.getItem('user_info');
  if (userInfo) {
    const user = JSON.parse(userInfo);
    form.value.name = user.name || '';
    form.value.email = user.email || '';
    form.value.phone = user.phone || '';
  }
});

// HÀM XỬ LÝ CHỐT ĐƠN VÀ BẮN API
const handlePayment = async () => {
  try {
    const response = await fetch('/api/bookings', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
      body: JSON.stringify({
        room_id: draftBooking.value.roomId,
        room_name: draftBooking.value.roomName,
        customer_name: form.value.name,
        customer_email: form.value.email,
        customer_phone: form.value.phone,
        total_price: totalPrice.value,
        deposit_amount: depositAmount.value
      })
    });

    if (response.ok) {
      alert('🎉 Đặt phòng thành công! (Giả lập thanh toán cọc)');
      localStorage.removeItem('draft_booking'); // Xóa bộ nhớ tạm
      
      // Chuyển sang trang Success của sếp
      router.push('/payment-success'); 
    } else {
      const data = await response.json();
      alert('Lỗi: ' + (data.message || 'Không thể đặt phòng lúc này.'));
    }
  } catch (error) {
    alert('Lỗi kết nối máy chủ!');
  }
};
</script>