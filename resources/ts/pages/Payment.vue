<template>
  <div class="bg-gray-50 min-h-screen pb-20">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
      <h1 class="text-3xl font-bold text-gray-900 mb-8">Xác nhận thông tin</h1>
      
      <div class="grid grid-cols-1 lg:grid-cols-3 gap-12">
        <!-- Left Content - Form -->
        <div class="lg:col-span-2">
          <form @submit.prevent="handlePayment" class="space-y-8 bg-white p-8 rounded-2xl shadow-sm border border-gray-100">
            <div class="space-y-6">
              <h2 class="text-xl font-semibold text-gray-900">Thông tin liên hệ</h2>
              <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <div>
                  <label for="name" class="block text-sm font-medium text-gray-700 mb-1">Tên *</label>
                  <input type="text" id="name" required class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-emerald-500 focus:border-emerald-500" />
                </div>
                <div>
                  <label for="email" class="block text-sm font-medium text-gray-700 mb-1">Email *</label>
                  <input type="email" id="email" required class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-emerald-500 focus:border-emerald-500" />
                </div>
                <div class="md:col-span-2">
                  <label for="phone" class="block text-sm font-medium text-gray-700 mb-1">Số điện thoại *</label>
                  <input type="tel" id="phone" required class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-emerald-500 focus:border-emerald-500" />
                </div>
                <div class="md:col-span-2">
                  <label for="note" class="block text-sm font-medium text-gray-700 mb-1">Ghi chú</label>
                  <textarea id="note" rows="4" class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-emerald-500 focus:border-emerald-500"></textarea>
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
                Thanh toán
              </button>
            </div>
          </form>
        </div>

        <!-- Right Content - Summary -->
        <div class="lg:col-span-1">
          <div class="bg-white border border-gray-200 rounded-2xl p-6 shadow-sm sticky top-24">
            <div class="flex gap-4 mb-6 pb-6 border-b border-gray-200">
              <img src="https://picsum.photos/seed/roommain/200/200" alt="Room" class="w-24 h-24 object-cover rounded-xl" referrerpolicy="no-referrer" />
              <div>
                <h3 class="font-semibold text-gray-900 line-clamp-2 mb-1">Phòng Mơ Màng - Số 10 Núi Thành - Quận Cẩm Lệ - TP. Đà Nẵng</h3>
                <div class="text-sm text-gray-500">Phòng</div>
              </div>
            </div>

            <h3 class="font-semibold text-gray-900 mb-4 text-lg">Chi tiết đặt phòng</h3>
            
            <div class="space-y-4 mb-6 pb-6 border-b border-gray-200">
              <div class="flex justify-between">
                <span class="text-gray-600">Ngày</span>
                <span class="font-medium text-gray-900 text-right">15/1 - 17/1/2026</span>
              </div>
              <div class="flex justify-between">
                <span class="text-gray-600">Số lượng</span>
                <span class="font-medium text-gray-900 text-right">2 người lớn</span>
              </div>
              <div class="flex justify-between">
                <span class="text-gray-600">Loại hình thuê</span>
                <span class="font-medium text-gray-900 text-right">Thuê dạng phòng</span>
              </div>
            </div>

            <div class="space-y-4 mb-6 pb-6 border-b border-gray-200">
              <div class="flex justify-between">
                <span class="text-gray-600 underline">120.000đ x 2 đêm</span>
                <span class="font-medium text-gray-900">240.000đ</span>
              </div>
              <div class="flex justify-between">
                <span class="text-gray-600 underline">Phí dịch vụ</span>
                <span class="font-medium text-gray-900">0đ</span>
              </div>
            </div>

            <div class="flex justify-between items-center">
              <span class="font-bold text-gray-900 text-lg">Tổng tiền</span>
              <span class="font-bold text-emerald-700 text-2xl">240.000đ</span>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { useRouter } from 'vue-router';

const router = useRouter();
const paymentMethod = ref('bank');

const handlePayment = () => {
  router.push('/payment-success');
};
</script>
