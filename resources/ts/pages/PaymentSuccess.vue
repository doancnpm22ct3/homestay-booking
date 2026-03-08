<template>
  <div class="bg-gray-50 min-h-screen pb-20 flex items-center justify-center">
    <div class="max-w-3xl w-full mx-auto px-4 sm:px-6 lg:px-8 py-12">
      <div class="bg-white rounded-3xl shadow-sm border border-gray-100 overflow-hidden">
        <div class="bg-emerald-50 p-8 text-center border-b border-emerald-100">
          <div class="w-20 h-20 bg-emerald-100 rounded-full flex items-center justify-center mx-auto mb-6">
            <CheckCircle class="w-10 h-10 text-emerald-600" />
          </div>
          <h1 class="text-3xl font-bold text-gray-900 mb-2">Thanh toán thành công</h1>
          <p class="text-emerald-800">Hóa đơn đã được gửi đến email của bạn</p>
        </div>
        
        <div class="p-8 md:p-12">
          <div class="flex flex-col md:flex-row gap-8 mb-12 pb-12 border-b border-gray-200">
            <img src="https://picsum.photos/seed/roommain/400/300" alt="Room" class="w-full md:w-1/3 h-48 object-cover rounded-2xl shadow-sm" referrerpolicy="no-referrer" />
            <div class="flex-1">
              <h3 class="text-xl font-bold text-gray-900 mb-2">Phòng Mơ Màng - Số 10 Núi Thành - Quận Cẩm Lệ - TP. Đà Nẵng</h3>
              <div class="text-emerald-700 font-medium mb-6">120.000đ / đêm</div>
              
              <div class="grid grid-cols-2 gap-y-4 gap-x-8 text-sm">
                <div>
                  <div class="text-gray-500 mb-1">Ngày</div>
                  <div class="font-medium text-gray-900">15/1 - 17/1/2026</div>
                </div>
                <div>
                  <div class="text-gray-500 mb-1">Số lượng</div>
                  <div class="font-medium text-gray-900">2 người lớn</div>
                </div>
                <div>
                  <div class="text-gray-500 mb-1">Loại hình thuê</div>
                  <div class="font-medium text-gray-900">Thuê dạng phòng</div>
                </div>
                <div>
                  <div class="text-gray-500 mb-1">Tổng tiền</div>
                  <div class="font-bold text-emerald-700 text-lg">240.000đ</div>
                </div>
              </div>
            </div>
          </div>

          <div class="flex flex-col sm:flex-row gap-4 justify-center">
            <router-link to="/profile" class="bg-emerald-600 hover:bg-emerald-700 text-white px-8 py-3 rounded-xl font-medium text-center transition-colors">
              Xem hóa đơn
            </router-link>
            <router-link to="/" class="bg-white border border-gray-300 hover:bg-gray-50 text-gray-700 px-8 py-3 rounded-xl font-medium text-center transition-colors">
              Trang chủ
            </router-link>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { CheckCircle } from 'lucide-vue-next';
</script>
