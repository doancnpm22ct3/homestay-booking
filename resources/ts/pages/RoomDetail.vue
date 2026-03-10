<template>
  <div class="bg-white min-h-screen pb-20">
    <div v-if="loading" class="max-w-7xl mx-auto px-4 py-20 text-center text-gray-500">
      Đang tải thông tin phòng...
    </div>

    <div v-else-if="room" class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
      
      <div class="mb-6">
        <h1 class="text-3xl font-bold text-gray-900 mb-2">{{ room.title }}</h1>
        <div class="flex items-center gap-4 text-sm text-gray-600">
          <div class="flex items-center gap-1">
            <Star class="w-4 h-4 fill-amber-400 text-amber-400" />
            <span class="font-medium text-gray-900">4.8</span>
            <span class="underline cursor-pointer">(Chưa có đánh giá)</span>
          </div>
          <div class="flex items-center gap-1">
            <MapPin class="w-4 h-4" />
            <span class="underline cursor-pointer">{{ room.location }}</span>
          </div>
        </div>
      </div>

      <div class="grid grid-cols-1 md:grid-cols-4 gap-4 mb-12 h-[400px] md:h-[500px] rounded-2xl overflow-hidden">
        <div class="md:col-span-2 h-full">
          <img :src="mainImage" alt="Main" class="w-full h-full object-cover hover:opacity-90 transition-opacity cursor-pointer" referrerpolicy="no-referrer" />
        </div>
        <div class="hidden md:grid grid-rows-2 gap-4 h-full">
          <img :src="subImages[0] || 'https://picsum.photos/seed/fallback/600/400'" alt="Room" class="w-full h-full object-cover hover:opacity-90 transition-opacity cursor-pointer" referrerpolicy="no-referrer" />
          <img :src="subImages[1] || 'https://picsum.photos/seed/fallback/600/400'" alt="Room" class="w-full h-full object-cover hover:opacity-90 transition-opacity cursor-pointer" referrerpolicy="no-referrer" />
        </div>
        <div class="hidden md:grid grid-rows-2 gap-4 h-full">
          <img :src="subImages[2] || 'https://picsum.photos/seed/fallback/600/400'" alt="Room" class="w-full h-full object-cover hover:opacity-90 transition-opacity cursor-pointer" referrerpolicy="no-referrer" />
          <div class="relative h-full">
            <img :src="subImages[3] || 'https://picsum.photos/seed/fallback/600/400'" alt="Room" class="w-full h-full object-cover hover:opacity-90 transition-opacity cursor-pointer" referrerpolicy="no-referrer" />
            <div class="absolute inset-0 bg-black/40 flex items-center justify-center cursor-pointer hover:bg-black/50 transition-colors">
              <span class="text-white font-medium text-lg">Xem tất cả ảnh</span>
            </div>
          </div>
        </div>
      </div>

      <div class="grid grid-cols-1 lg:grid-cols-3 gap-12">
        <div class="lg:col-span-2 space-y-12">
          
          <section>
            <h2 class="text-2xl font-bold text-gray-900 mb-4">Mô tả chi tiết phòng</h2>
            <div class="prose text-gray-600 whitespace-pre-line">{{ room.description }}</div>
          </section>

          <section>
            <h2 class="text-2xl font-bold text-gray-900 mb-4">Tiện nghi</h2>
            <div v-if="room.amenity_list && room.amenity_list.length > 0" class="grid grid-cols-2 md:grid-cols-3 gap-4">
              <div v-for="amenity in room.amenity_list" :key="amenity.id" class="flex items-center gap-3 text-gray-600">
                <div class="w-8 h-8 rounded-full bg-emerald-50 flex items-center justify-center text-emerald-600">
                  <Star class="w-4 h-4" />
                </div>
                <span>{{ amenity.name }}</span>
              </div>
            </div>
          </section>

          <section>
            <h2 class="text-2xl font-bold text-gray-900 mb-6">Nội quy & Chính sách</h2>
            
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
              <div class="bg-gray-50 p-6 rounded-2xl border border-gray-100">
                <h3 class="font-semibold text-gray-900 mb-4 flex items-center gap-2">
                  <Clock class="w-5 h-5 text-emerald-600" /> Thời gian nhận/trả phòng
                </h3>
                <div class="space-y-3 text-gray-600">
                  <div class="flex justify-between border-b border-gray-200 pb-2">
                    <span>Nhận phòng (Check-in)</span>
                    <span class="font-bold text-gray-900">14:00</span>
                  </div>
                  <div class="flex justify-between border-b border-gray-200 pb-2">
                    <span>Trả phòng (Check-out)</span>
                    <span class="font-bold text-gray-900">12:00</span>
                  </div>
                  <div class="bg-red-50 text-red-600 p-3 rounded-lg text-sm font-medium mt-2">
                    <AlertTriangle class="w-4 h-4 inline-block mr-1 mb-1" />
                    Khách có thể đến trễ tối đa 1 tiếng so với giờ Check-in. Quá 1 tiếng, hệ thống tự động hủy phòng và không hoàn cọc.
                  </div>
                </div>
              </div>

              <div class="bg-gray-50 p-6 rounded-2xl border border-gray-100">
                <h3 class="font-semibold text-gray-900 mb-4 flex items-center gap-2">
                  <CreditCard class="w-5 h-5 text-emerald-600" /> Thanh toán & Hủy phòng
                </h3>
                <div class="space-y-3 text-gray-600 text-sm">
                  <p class="text-emerald-800 font-medium bg-emerald-100 p-2 rounded-lg text-center">
                    Khách đặt phòng vui lòng thanh toán cọc trước <br> <span class="text-lg font-bold">30%</span> tổng tiền.
                  </p>
                  <ul class="space-y-2 mt-3 border-b border-gray-200 pb-3">
                    <li class="flex justify-between items-center"><span class="text-gray-600">Hủy trong 30 phút đầu:</span> <span class="font-bold text-emerald-600">Hoàn 100% cọc</span></li>
                    <li class="flex justify-between items-center"><span class="text-gray-600">Hủy trước 3 ngày:</span> <span class="font-bold text-emerald-600">Hoàn 100% cọc</span></li>
                    <li class="flex justify-between items-center"><span class="text-gray-600">Hủy trước 1 - 3 ngày:</span> <span class="font-bold text-amber-600">Hoàn 50% cọc</span></li>
                    <li class="flex justify-between items-center"><span class="text-gray-600">Hủy trong vòng 24h:</span> <span class="font-bold text-red-500">Không hoàn cọc</span></li>
                  </ul>
                  
                  <div class="bg-blue-50 text-blue-800 p-3 rounded-lg text-sm mt-2">
                    <strong>💡 Hỗ trợ dời lịch:</strong> Nếu quá hạn hủy nhưng muốn đổi ngày, vui lòng liên hệ sớm qua Hotline để được hỗ trợ. <br><br>
                    <span class="text-red-600 font-semibold">TUYỆT ĐỐI KHÔNG</span> hỗ trợ dời ngày/hủy phòng nếu báo sát giờ Check-in (khách sẽ mất 100% cọc). Lý do: Sát giờ Homestay không thể bán lại phòng cho khách khác.
                  </div>
                </div>
              </div>
            </div>

            <div class="bg-gray-50 p-6 rounded-2xl mt-6 border border-gray-100">
              <h3 class="font-semibold text-gray-900 mb-3 flex items-center gap-2">
                <Users class="w-5 h-5 text-emerald-600" /> Quy định số lượng khách
              </h3>
              <div class="space-y-2 text-gray-600 text-sm">
                <p>📍 <strong>Phòng 1-2 người:</strong> Tối đa 2 người lớn. Hỗ trợ ở ghép tối đa 1 trẻ em (dưới 10 tuổi).</p>
                <p>📍 <strong>Phòng 1-4 người:</strong> Tối đa 4 người lớn. Hỗ trợ ở ghép tối đa 2 trẻ em (dưới 10 tuổi).</p>
                <p>📍 <strong>Nguyên căn:</strong> Tối đa 20 người lớn. <strong class="text-emerald-600">Miễn phí và không giới hạn số lượng trẻ em đi kèm.</strong></p>
                <p class="text-red-500 italic mt-2">* Khách đoàn từ 5 người lớn trở lên vui lòng thuê 2 phòng hoặc chọn Nguyên căn.</p>
              </div>
            </div>

            <div class="bg-gray-50 p-6 rounded-2xl mt-6 border border-gray-100">
              <h3 class="font-semibold text-gray-900 mb-3 flex items-center gap-2">
                <AlertTriangle class="w-5 h-5 text-emerald-600" /> Nội quy lưu trú
              </h3>
              <ul class="list-disc pl-5 space-y-2 text-gray-600 text-sm">
                <li>Nghiêm cấm sử dụng chất kích thích, các chất gây nghiện, các chất cấm trong danh mục của nhà nước.</li>
                <li>Không tự ý cho người lạ vào khi chưa đăng kí trước.</li>
                <li>Không tự ý di chuyển, làm bẩn hoặc làm hỏng nội thất, thiết bị, đồ đạc.</li>
                <li>Vui lòng làm sạch bếp sau khi sử dụng.</li>
                <li class="text-red-500 font-bold">Lưu ý đặc biệt: Không hút thuốc trong phòng.</li>
              </ul>
            </div>
          </section>

        </div>

        <div class="lg:col-span-1">
          <div class="bg-white border border-gray-200 rounded-2xl p-6 shadow-xl sticky top-24">
            <div class="flex items-baseline gap-1 mb-6">
              <span class="text-2xl font-bold text-emerald-700">{{ Number(room.price).toLocaleString() }}đ</span>
              <span class="text-gray-500">/ đêm</span>
            </div>

            <div class="space-y-4 mb-6">
              <div class="border border-gray-300 rounded-lg overflow-hidden">
                <div class="flex border-b border-gray-300">
                  <div class="flex-1 p-3 border-r border-gray-300">
                    <label class="block text-xs font-bold text-gray-700 uppercase mb-1">Nhận phòng</label>
                    <input type="date" class="w-full outline-none text-sm text-gray-900 bg-transparent" />
                  </div>
                  <div class="flex-1 p-3">
                    <label class="block text-xs font-bold text-gray-700 uppercase mb-1">Trả phòng</label>
                    <input type="date" class="w-full outline-none text-sm text-gray-900 bg-transparent" />
                  </div>
                </div>
                
                <div class="p-3 border-b border-gray-300 flex justify-between items-center">
                  <div>
                    <label class="block text-sm font-bold text-gray-700">Người lớn</label>
                    <span class="text-xs text-gray-500">Từ 10 tuổi trở lên</span>
                  </div>
                  <div class="flex items-center gap-3">
                    <button @click="adults > 1 ? adults-- : null" class="w-8 h-8 rounded-full border border-gray-300 flex items-center justify-center hover:border-gray-800">-</button>
                    <span class="w-4 text-center">{{ adults }}</span>
                    <button @click="adults++" class="w-8 h-8 rounded-full border border-gray-300 flex items-center justify-center hover:border-gray-800">+</button>
                  </div>
                </div>

                <div class="p-3 flex justify-between items-center">
                  <div>
                    <label class="block text-sm font-bold text-gray-700">Trẻ em</label>
                    <span class="text-xs text-gray-500">Dưới 10 tuổi</span>
                  </div>
                  <div class="flex items-center gap-3">
                    <button @click="children > 0 ? children-- : null" class="w-8 h-8 rounded-full border border-gray-300 flex items-center justify-center hover:border-gray-800">-</button>
                    <span class="w-4 text-center">{{ children }}</span>
                    <button @click="children++" class="w-8 h-8 rounded-full border border-gray-300 flex items-center justify-center hover:border-gray-800">+</button>
                  </div>
                </div>
              </div>
              
              <div v-if="errorMessage" class="text-red-500 text-sm font-medium bg-red-50 p-3 rounded-lg">
                {{ errorMessage }}
              </div>
            </div>

            <button 
              @click="handleBook"
              class="w-full bg-emerald-600 hover:bg-emerald-700 text-white py-3 rounded-lg font-bold text-lg transition-colors"
            >
              Đặt phòng ngay
            </button>
          </div>
        </div>
      </div>
    </div>

    <div v-else class="max-w-7xl mx-auto px-4 py-20 text-center">
      <h2 class="text-2xl font-bold text-gray-900 mb-4">Không tìm thấy phòng!</h2>
      <button @click="router.push('/listing')" class="text-emerald-600 hover:underline">Quay lại danh sách phòng</button>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import { MapPin, Star, Clock, CreditCard, Users, AlertTriangle } from 'lucide-vue-next';

const route = useRoute();
const router = useRouter();

const loading = ref(true);
const room = ref<any>(null);
const mainImage = ref('');
const subImages = ref<string[]>([]);

const adults = ref(1);
const children = ref(0);
const errorMessage = ref('');

onMounted(async () => {
  try {
    const roomId = route.params.id;
    const response = await fetch(`/api/rooms/${roomId}`);
    if (!response.ok) throw new Error('Không tìm thấy phòng');
    
    const data = await response.json();
    room.value = data;

    if (data.images && data.images.length > 0) {
      const primaryImg = data.images.find((img: any) => img.is_primary);
      mainImage.value = primaryImg ? primaryImg.image_url : data.images[0].image_url;
      subImages.value = data.images.filter((img: any) => img.image_url !== mainImage.value).map((img: any) => img.image_url).slice(0, 4);
    } else {
      mainImage.value = 'https://picsum.photos/seed/fallback/1200/800';
    }
  } catch (error) {
    console.error(error);
  } finally {
    loading.value = false;
  }
});

const validateCapacity = () => {
  errorMessage.value = ''; 
  const type = room.value.type;
  const max = room.value.max_guests;

  if (type === 'house') {
    // SỬA LOGIC: Kiểm tra tối đa 20 người lớn cho Nguyên Căn
    if (adults.value > 20) {
      errorMessage.value = 'Nguyên căn chỉ chứa tối đa 20 người lớn. Vui lòng liên hệ hotline để được hỗ trợ.';
      return false;
    }
  } else {
    if (max <= 2) {
      if (adults.value > 2) {
        errorMessage.value = 'Phòng này chỉ chứa tối đa 2 người lớn. Vui lòng chọn loại phòng lớn hơn.';
        return false;
      }
      if (children.value > 1) {
        errorMessage.value = 'Phòng 1-2 người chỉ được kèm tối đa 1 trẻ em dưới 10 tuổi.';
        return false;
      }
    } 
    else if (max >= 4) {
      if (adults.value > 4) {
        errorMessage.value = 'Nhóm từ 5 người lớn trở lên vui lòng đặt 2 phòng hoặc chọn Nguyên căn.';
        return false;
      }
      if (children.value > 2) {
        errorMessage.value = 'Phòng 1-4 người chỉ được kèm tối đa 2 trẻ em dưới 10 tuổi.';
        return false;
      }
    }
  }
  
  return true;
};

const handleBook = () => {
  if (validateCapacity()) {
    alert(`Đã duyệt! Bạn đặt phòng cho ${adults.value} người lớn và ${children.value} trẻ em hợp lệ.`);
    // Chuẩn bị cho trang thanh toán
    // router.push('/payment');
  }
};
</script>