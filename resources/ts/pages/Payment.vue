<template>
  <div class="bg-[#FAF9F5] flex flex-col min-h-screen">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12 flex-grow w-full font-['Inter']">
      <h1 class="text-3xl font-bold text-gray-900 mb-8 font-['Playfair_Display']">Xác nhận thông tin</h1>
      
<<<<<<< HEAD
      <div class="grid grid-cols-1 lg:grid-cols-3 gap-12">
=======
      <div v-if="loading" class="text-center py-20 text-[#4A7055] font-medium animate-pulse">
        Đang tải thông tin thanh toán...
      </div>

      <div v-else class="grid grid-cols-1 lg:grid-cols-3 gap-12">
>>>>>>> 5c00cb4170f0acfca4924e1975a0a699ee2fffe2
        <div class="lg:col-span-2">
          <form @submit.prevent="handlePayment" class="space-y-8 bg-white p-8 rounded-3xl shadow-sm border border-gray-100">
            <div class="space-y-6">
              <h2 class="text-xl font-bold text-gray-900">Thông tin liên hệ</h2>
              <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <div>
<<<<<<< HEAD
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
=======
                  <label for="name" class="block text-sm font-bold text-gray-700 mb-2">Tên *</label>
                  <input type="text" id="name" v-model="customerInfo.name" required class="w-full px-4 py-3 border border-gray-200 rounded-xl focus:ring-[#4A7055] focus:border-[#4A7055] outline-none transition-colors" />
                </div>
                <div>
                  <label for="email" class="block text-sm font-bold text-gray-700 mb-2">Email *</label>
                  <input type="email" id="email" v-model="customerInfo.email" required class="w-full px-4 py-3 border border-gray-200 rounded-xl focus:ring-[#4A7055] focus:border-[#4A7055] outline-none transition-colors" />
                </div>
                <div class="md:col-span-2">
                  <label for="phone" class="block text-sm font-bold text-gray-700 mb-2">Số điện thoại *</label>
                  <input type="tel" id="phone" v-model="customerInfo.phone" required class="w-full px-4 py-3 border border-gray-200 rounded-xl focus:ring-[#4A7055] focus:border-[#4A7055] outline-none transition-colors" />
                </div>
                <div class="md:col-span-2">
                  <label for="note" class="block text-sm font-bold text-gray-700 mb-2">Ghi chú</label>
                  <textarea id="note" v-model="customerInfo.note" rows="4" class="w-full px-4 py-3 border border-gray-200 rounded-xl focus:ring-[#4A7055] focus:border-[#4A7055] outline-none transition-colors"></textarea>
>>>>>>> 5c00cb4170f0acfca4924e1975a0a699ee2fffe2
                </div>
              </div>
            </div>

            <div class="pt-8 border-t border-gray-100">
              <h2 class="text-xl font-bold text-gray-900 mb-6">Phương thức thanh toán</h2>
              <div class="space-y-4">
                <label :class="`flex items-center p-4 border-2 rounded-xl cursor-pointer transition-colors ${paymentMethod === 'bank' ? 'border-[#4A7055] bg-[#4A7055]/5' : 'border-gray-100 hover:bg-gray-50'}`">
                  <input 
                    type="radio" 
                    name="payment" 
                    value="bank" 
                    v-model="paymentMethod"
                    class="w-5 h-5 text-[#4A7055] focus:ring-[#4A7055]"
                  />
                  <span class="ml-3 font-medium text-gray-900">Chuyển khoản ngân hàng</span>
                </label>
                <label :class="`flex items-center p-4 border-2 rounded-xl cursor-pointer transition-colors ${paymentMethod === 'ewallet' ? 'border-[#4A7055] bg-[#4A7055]/5' : 'border-gray-100 hover:bg-gray-50'}`">
                  <input 
                    type="radio" 
                    name="payment" 
                    value="ewallet" 
                    v-model="paymentMethod"
                    class="w-5 h-5 text-[#4A7055] focus:ring-[#4A7055]"
                  />
                  <span class="ml-3 font-medium text-gray-900">Ví điện tử (Momo, ZaloPay, VNPay)</span>
                </label>
              </div>
            </div>

<<<<<<< HEAD
            <div class="pt-8 border-t border-gray-200">
              <button type="submit" class="w-full bg-emerald-600 hover:bg-emerald-700 text-white py-4 rounded-xl font-bold text-lg transition-colors">
                Xác nhận & Thanh toán cọc
=======
            <div class="pt-8 border-t border-gray-100">
              <button type="submit" class="w-full bg-[#4A7055] hover:bg-[#3b5a44] text-white py-4 rounded-xl font-bold text-lg transition-colors shadow-md">
                Thanh toán
>>>>>>> 5c00cb4170f0acfca4924e1975a0a699ee2fffe2
              </button>
            </div>
          </form>
        </div>

        <div class="lg:col-span-1">
<<<<<<< HEAD
          <div v-if="draftBooking" class="bg-white border border-gray-200 rounded-2xl p-6 shadow-sm sticky top-24">
            <div class="flex gap-4 mb-6 pb-6 border-b border-gray-200">
              <img :src="draftBooking.roomImage" alt="Room" class="w-24 h-24 object-cover rounded-xl" referrerpolicy="no-referrer" />
              <div>
                <h3 class="font-semibold text-gray-900 line-clamp-2 mb-1">{{ draftBooking.roomName }}</h3>
                <div class="text-sm text-gray-500">Phòng Homestay</div>
=======
          <div v-if="room" class="bg-white border border-gray-100 rounded-3xl p-6 shadow-sm sticky top-24">
            <div class="flex gap-4 mb-6 pb-6 border-b border-gray-100">
              <img :src="primaryImage" alt="Room" class="w-24 h-24 object-cover rounded-xl shadow-sm" referrerpolicy="no-referrer" />
              <div>
                <h3 class="font-bold text-gray-900 line-clamp-2 mb-1">{{ room.title }}</h3>
                <div class="text-sm text-[#4A7055] font-medium">{{ room.type === 'house' ? 'Nguyên căn' : 'Phòng riêng' }}</div>
>>>>>>> 5c00cb4170f0acfca4924e1975a0a699ee2fffe2
              </div>
            </div>

            <h3 class="font-bold text-gray-900 mb-4 text-lg">Chi tiết đặt phòng</h3>
            
            <div class="space-y-4 mb-6 pb-6 border-b border-gray-100 text-sm">
              <div class="flex justify-between">
<<<<<<< HEAD
                <span class="text-gray-600">Ngày</span>
                <span class="font-medium text-gray-900 text-right">Sắp tới</span>
              </div>
              <div class="flex justify-between">
                <span class="text-gray-600">Số lượng</span>
                <span class="font-medium text-gray-900 text-right">{{ draftBooking.adults }} người lớn, {{ draftBooking.children }} trẻ em</span>
=======
                <span class="text-gray-500">Ngày nhận - trả</span>
                <span class="font-bold text-gray-900 text-right">{{ formatDate(checkIn) }} - {{ formatDate(checkOut) }}</span>
              </div>
              <div class="flex justify-between">
                <span class="text-gray-500">Số lượng</span>
                <span class="font-bold text-gray-900 text-right">
                  {{ adults }} người lớn<span v-if="children > 0">, {{ children }} trẻ em</span>
                </span>
              </div>
              <div class="flex justify-between">
                <span class="text-gray-500">Thời gian lưu trú</span>
                <span class="font-bold text-[#4A7055] text-right">{{ numberOfNights }} đêm</span>
>>>>>>> 5c00cb4170f0acfca4924e1975a0a699ee2fffe2
              </div>
            </div>

            <div class="space-y-4 mb-6 pb-6 border-b border-gray-100">
              <div class="flex justify-between">
<<<<<<< HEAD
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
=======
                <span class="text-gray-500 underline">{{ formatPrice(room.price) }} x {{ numberOfNights }} đêm</span>
                <span class="font-medium text-gray-900">{{ formatPrice(room.price * numberOfNights) }}</span>
              </div>
              <div class="flex justify-between">
                <span class="text-gray-500 underline">Phí dịch vụ</span>
                <span class="font-medium text-gray-900">0đ</span>
              </div>
            </div>

            <div class="flex justify-between items-center">
              <span class="font-bold text-gray-900 text-xl">Tổng tiền</span>
              <span class="font-extrabold text-[#4A7055] text-2xl">{{ formatPrice(totalPrice) }}</span>
            </div>
            
            <div class="mt-4 bg-[#4A7055]/10 rounded-xl p-4 text-center">
              <p class="text-sm text-gray-600 mb-1">Cọc trước (30%)</p>
              <p class="font-bold text-lg text-gray-900">{{ formatPrice(totalPrice * 0.3) }}</p>
            </div>

>>>>>>> 5c00cb4170f0acfca4924e1975a0a699ee2fffe2
          </div>
        </div>
      </div>
    </div>
    
  </div>
</template>

<script setup lang="ts">
<<<<<<< HEAD
import { ref, onMounted } from 'vue';
import { useRouter } from 'vue-router';
=======
import { ref, onMounted, computed } from 'vue';
import { useRoute, useRouter } from 'vue-router';
>>>>>>> 5c00cb4170f0acfca4924e1975a0a699ee2fffe2

// Định nghĩa Interface
interface RoomData {
  id: number | string;
  title: string;
  type: string;
  price: number;
  images?: any[];
}

const route = useRoute();
const router = useRouter();
<<<<<<< HEAD
const paymentMethod = ref('bank');
const draftBooking = ref<any>(null);

// Form thông tin
const form = ref({
=======

// State
const loading = ref(true);
const room = ref<RoomData | null>(null);
const primaryImage = ref('https://picsum.photos/seed/roommain/200/200');

// Lấy thông tin từ URL Query
const roomId = route.query.roomId as string;
const checkIn = ref(route.query.checkIn as string);
const checkOut = ref(route.query.checkOut as string);
const adults = ref(Number(route.query.adults) || 1);
const children = ref(Number(route.query.children) || 0);

const paymentMethod = ref('bank');
const customerInfo = ref({
>>>>>>> 5c00cb4170f0acfca4924e1975a0a699ee2fffe2
  name: '',
  email: '',
  phone: '',
  note: ''
});

<<<<<<< HEAD
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
=======
// Tính số đêm
const numberOfNights = computed(() => {
  if (!checkIn.value || !checkOut.value) return 1;
  const start = new Date(checkIn.value);
  const end = new Date(checkOut.value);
  const diffTime = Math.abs(end.getTime() - start.getTime());
  const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24)); 
  return diffDays > 0 ? diffDays : 1;
});

// Tính tổng tiền
const totalPrice = computed(() => {
  if (!room.value) return 0;
  return room.value.price * numberOfNights.value;
});

// Load Data
onMounted(async () => {
  // Nếu không có roomId, văng về trang chủ hoặc listing
  if (!roomId) {
    router.push('/listing');
    return;
  }

  try {
    const response = await fetch(`/api/rooms/${roomId}`);
    if (!response.ok) throw new Error('Không tìm thấy phòng');
    
    const data = await response.json();
    room.value = data;

    if (data.images && data.images.length > 0) {
      const pImg = data.images.find((img: any) => img.is_primary);
      primaryImage.value = pImg ? pImg.image_url : data.images[0].image_url;
    }
  } catch (error) {
    console.error('Lỗi lấy thông tin phòng thanh toán:', error);
    alert('Không thể tải thông tin phòng, vui lòng thử lại.');
    router.push('/listing');
  } finally {
    loading.value = false;
  }
});

// Helper Functions
const formatDate = (dateStr: string) => {
  if (!dateStr) return '';
  const [year, month, day] = dateStr.split('-');
  return `${day}/${month}/${year}`;
};

const formatPrice = (price: number) => {
  return price.toLocaleString('vi-VN') + 'đ';
};

// Gửi thanh toán
const handlePayment = async () => {
  // Ở đây sau này Hiếu sẽ viết API gọi xuống backend để lưu Booking
  // Hiện tại ta chuyển luôn sang trang Success
  
  // router.push({
  //   path: '/payment-success',
  //   query: { bookingId: 'TEMP123' }
  // });
  
  router.push('/payment-success');
>>>>>>> 5c00cb4170f0acfca4924e1975a0a699ee2fffe2
};
</script>