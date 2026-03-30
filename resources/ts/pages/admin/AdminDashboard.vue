<template>
  <div class="p-8 bg-gray-50 min-h-screen">
    <h1 class="text-3xl font-bold text-gray-900 mb-8 font-['Playfair_Display']">Báo Cáo Thống Kê</h1>

    <div v-if="isLoading" class="text-center py-10">
      <div class="animate-spin rounded-full h-10 w-10 border-b-2 border-[#4A7055] mx-auto"></div>
    </div>

    <div v-else>
      <div class="mb-8 flex items-center gap-4">
        <label class="font-bold text-gray-700">Chọn năm:</label>
        <select v-model="selectedYear" @change="fetchStatistics" class="border border-gray-300 rounded-lg px-4 py-2 focus:ring-[#4A7055] outline-none">
          <option value="2025">2025</option>
          <option value="2026">2026</option>
          <option value="2027">2027</option>
        </select>
      </div>

      <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-10">
        <div class="bg-white p-6 rounded-2xl shadow-sm border border-gray-100 border-l-4 border-l-blue-500">
          <p class="text-gray-500 font-medium mb-1">Tổng Booking</p>
          <h3 class="text-3xl font-bold text-gray-900">{{ overview.total_bookings }} <span class="text-sm font-normal text-gray-500">đơn</span></h3>
        </div>
        
        <div class="bg-white p-6 rounded-2xl shadow-sm border border-gray-100 border-l-4 border-l-green-500">
          <p class="text-gray-500 font-medium mb-1">Tổng Doanh Thu</p>
          <h3 class="text-3xl font-bold text-green-600">{{ formatMoney(overview.total_revenue) }}</h3>
        </div>

        <div class="bg-white p-6 rounded-2xl shadow-sm border border-gray-100 border-l-4 border-l-orange-500">
          <p class="text-gray-500 font-medium mb-1">Tỷ Lệ Phòng Trống</p>
          <h3 class="text-3xl font-bold text-orange-500">{{ overview.vacancy_rate }}</h3>
        </div>
      </div>

      <div class="bg-white p-6 rounded-2xl shadow-sm border border-gray-100">
        <h2 class="text-xl font-bold text-gray-900 mb-6">Doanh Thu Các Tháng Trong Năm</h2>
        <div class="h-[400px]">
          <Bar v-if="chartDataLoaded" :data="chartData" :options="chartOptions" />
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import { Bar } from 'vue-chartjs';
import { Chart as ChartJS, Title, Tooltip, Legend, BarElement, CategoryScale, LinearScale } from 'chart.js';

// Đăng ký các thành phần của ChartJS
ChartJS.register(Title, Tooltip, Legend, BarElement, CategoryScale, LinearScale);

const isLoading = ref(true);
const chartDataLoaded = ref(false);
const selectedYear = ref(new Date().getFullYear().toString());

const overview = ref({
  total_bookings: 0,
  total_revenue: 0,
  vacancy_rate: '0%'
});

const chartData = ref({
  labels: [],
  datasets: [{ label: 'Doanh thu (VNĐ)', backgroundColor: '#4A7055', data: [] }]
});

const chartOptions = {
  responsive: true,
  maintainAspectRatio: false,
};

const formatMoney = (amount) => {
  return Number(amount).toLocaleString('vi-VN') + 'đ';
};

const fetchStatistics = async () => {
  isLoading.value = true;
  chartDataLoaded.value = false;
  
  try {
    // Đừng quên truyền Token nếu API yêu cầu auth
    const token = localStorage.getItem('auth_token');
    const response = await fetch(`/api/admin/dashboard/statistics?year=${selectedYear.value}`, {
      headers: {
        'Authorization': `Bearer ${token}`,
        'Accept': 'application/json'
      }
    });

    if (response.ok) {
      const resData = await response.json();
      
      // Cập nhật Overview
      overview.value = resData.data.overview;
      
      // Cập nhật Biểu đồ
      chartData.value = {
        labels: resData.data.chart.labels,
        datasets: [
          {
            label: 'Doanh thu (VNĐ)',
            backgroundColor: '#4A7055',
            borderRadius: 6,
            data: resData.data.chart.data
          }
        ]
      };
      
      chartDataLoaded.value = true;
    }
  } catch (error) {
    console.error("Lỗi tải thống kê:", error);
    alert('Không thể tải dữ liệu thống kê');
  } finally {
    isLoading.value = false;
  }
};

onMounted(() => {
  fetchStatistics();
});
</script>