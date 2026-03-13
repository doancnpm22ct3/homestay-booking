<template>
  <div class="flex flex-col min-h-screen bg-[#FAF9F5]">
    <div v-if="loading" class="flex-grow max-w-7xl mx-auto px-4 py-20 text-center text-[#4A7055]">
      <div class="animate-pulse flex flex-col items-center">
        <HomeIcon class="w-12 h-12 mb-4 opacity-50" />
        <p class="font-medium font-['Inter']">Đang tải thông tin phòng, vui lòng đợi...</p>
      </div>
    </div>

    <div v-else-if="room" class="flex-grow max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8 w-full">
      
      <div class="mb-6">
        <h1 class="text-3xl font-bold text-gray-900 mb-2 font-['Playfair_Display']">{{ room.title }} - {{ room.location }}</h1>
        <div class="flex items-center gap-4 text-sm text-gray-600 font-['Inter']">
          <div class="flex items-center gap-1">
            <Star class="w-4 h-4 fill-amber-400 text-amber-400" />
            <span class="font-bold text-gray-900">4.8</span>
            <span class="underline cursor-pointer hover:text-[#4A7055] transition-colors">(120 đánh giá)</span>
          </div>
          <div class="flex items-center gap-1">
            <MapPin class="w-4 h-4" />
            <span class="underline cursor-pointer hover:text-[#4A7055] transition-colors">{{ room.location }}</span>
          </div>
        </div>
      </div>

      <div class="grid grid-cols-1 md:grid-cols-4 gap-4 mb-12 h-[400px] md:h-[500px] rounded-2xl overflow-hidden shadow-sm">
        <div class="md:col-span-2 h-full">
          <img :src="mainImage" alt="Main" class="w-full h-full object-cover hover:opacity-95 transition-opacity cursor-pointer" referrerpolicy="no-referrer" />
        </div>
        <div class="hidden md:grid grid-rows-2 gap-4 h-full">
          <img :src="subImages[0] || 'https://picsum.photos/seed/room2/600/400'" alt="Room" class="w-full h-full object-cover hover:opacity-95 transition-opacity cursor-pointer" referrerpolicy="no-referrer" />
          <img :src="subImages[1] || 'https://picsum.photos/seed/room3/600/400'" alt="Room" class="w-full h-full object-cover hover:opacity-95 transition-opacity cursor-pointer" referrerpolicy="no-referrer" />
        </div>
        <div class="hidden md:grid grid-rows-2 gap-4 h-full">
          <img :src="subImages[2] || 'https://picsum.photos/seed/room4/600/400'" alt="Room" class="w-full h-full object-cover hover:opacity-95 transition-opacity cursor-pointer" referrerpolicy="no-referrer" />
          <div class="relative h-full">
            <img :src="subImages[3] || 'https://picsum.photos/seed/room5/600/400'" alt="Room" class="w-full h-full object-cover hover:opacity-95 transition-opacity cursor-pointer" referrerpolicy="no-referrer" />
            <div class="absolute inset-0 bg-black/40 flex items-center justify-center cursor-pointer hover:bg-black/50 transition-colors">
              <span class="text-white font-bold text-lg font-['Inter'] tracking-wide">Xem tất cả ảnh</span>
            </div>
          </div>
        </div>
      </div>

      <div class="grid grid-cols-1 lg:grid-cols-3 gap-12 pb-12">
        <div class="lg:col-span-2 space-y-12">
          
          <section>
            <h2 class="text-2xl font-bold text-gray-900 mb-4 font-['Playfair_Display']">Mô tả chi tiết phòng</h2>
            <div class="prose text-gray-600 font-['Inter'] leading-relaxed whitespace-pre-line">
              {{ room.description || 'Chủ nhà chưa cung cấp mô tả cho phòng này. Tuy nhiên, phòng được trang bị đầy đủ tiện nghi, view nhìn ra thành phố tuyệt đẹp, không gian yên tĩnh phù hợp cho cả kỳ nghỉ dưỡng lẫn chuyến công tác.' }}
            </div>
          </section>

          <section>
            <h2 class="text-2xl font-bold text-gray-900 mb-4 font-['Playfair_Display']">Tiện nghi</h2>
            <div class="grid grid-cols-2 md:grid-cols-3 gap-4">
              <template v-if="room.amenity_list && room.amenity_list.length > 0">
                <div v-for="amenity in room.amenity_list" :key="amenity.id" class="flex items-center gap-3 text-gray-700 font-['Inter']">
                  <div class="w-8 h-8 rounded-full bg-[#4A7055]/10 flex items-center justify-center text-[#4A7055]">
                    <Star class="w-4 h-4" />
                  </div>
                  <span class="font-medium">{{ amenity.name }}</span>
                </div>
              </template>
              <template v-else>
                 <div class="col-span-full text-gray-500 italic">Đang cập nhật danh sách tiện nghi.</div>
              </template>
            </div>
            <button v-if="room.amenity_list && room.amenity_list.length > 6" class="mt-6 text-[#4A7055] font-bold font-['Inter'] hover:text-[#3b5a44] underline transition-colors">
              Xem thêm tiện nghi
            </button>
          </section>

          <section>
            <h2 class="text-2xl font-bold text-gray-900 mb-4 font-['Playfair_Display']">Nội quy & Chính sách</h2>
            <div class="bg-white border border-gray-100 p-8 rounded-3xl space-y-8 font-['Inter'] shadow-sm">
              <div>
                <h3 class="font-bold text-gray-900 mb-3 text-lg flex items-center gap-2">
                  <Clock class="w-5 h-5 text-[#4A7055]" /> Giờ check in - check out
                </h3>
                <ul class="list-disc pl-5 text-gray-600 space-y-1.5 marker:text-[#4A7055]">
                  <li>Giờ check in: 14:00 (Đúng giờ có thể delay 10-15 phút)</li>
                  <li>Giờ check out: 12:00 (Đúng giờ có thể delay 10-15 phút)</li>
                  <li class="text-red-500 font-medium mt-2 list-none -ml-5 bg-red-50 p-2 rounded-md"><AlertTriangle class="w-4 h-4 inline-block mr-1 mb-1" />Khách có thể đến trễ tối đa 1 tiếng so với giờ Check-in. Quá 1 tiếng, hệ thống tự động hủy phòng và không hoàn cọc.</li>
                </ul>
              </div>
              
              <div>
                <h3 class="font-bold text-gray-900 mb-3 text-lg flex items-center gap-2">
                  <Users class="w-5 h-5 text-[#4A7055]" /> Quy định số lượng khách
                </h3>
                <div class="space-y-2 text-gray-600 text-sm">
                  <p>📍 <strong>Phòng 1-2 người:</strong> Tối đa 2 người lớn. Hỗ trợ ở ghép tối đa 1 trẻ em (dưới 10 tuổi).</p>
                  <p>📍 <strong>Phòng 1-4 người:</strong> Tối đa 4 người lớn. Hỗ trợ ở ghép tối đa 2 trẻ em (dưới 10 tuổi).</p>
                  <p>📍 <strong>Nguyên căn:</strong> Tối đa 20 người lớn. <strong class="text-[#4A7055]">Miễn phí và không giới hạn số lượng trẻ em đi kèm.</strong></p>
                  <p class="text-red-500 italic mt-2">* Khách đoàn từ 5 người lớn trở lên vui lòng thuê 2 phòng hoặc chọn Nguyên căn.</p>
                </div>
              </div>

              <div>
                <h3 class="font-bold text-gray-900 mb-3 text-lg flex items-center gap-2">
                  <CreditCard class="w-5 h-5 text-[#4A7055]" /> Chính sách thanh toán & hủy phòng
                </h3>
                <p class="text-[#4A7055] font-medium bg-[#4A7055]/10 p-2 rounded-lg text-center mb-3">
                    Khách đặt phòng vui lòng thanh toán cọc trước <span class="text-lg font-bold">30%</span> tổng tiền.
                </p>
                <ul class="list-disc pl-5 text-gray-600 space-y-1.5 marker:text-[#4A7055]">
                  <li>Hủy trong 30 phút đầu hoặc trước 3 ngày: Hoàn 100% cọc.</li>
                  <li>Hủy trước 1 - 3 ngày: Hoàn 50% cọc.</li>
                  <li>Hủy trong vòng 24h: Không hỗ trợ hoàn cọc.</li>
                  <li class="text-blue-600 font-medium list-none -ml-5 bg-blue-50 p-2 rounded-md mt-2">💡 Hỗ trợ dời lịch: Nếu quá hạn hủy nhưng muốn đổi ngày, vui lòng liên hệ sớm qua Hotline. KHÔNG hỗ trợ nếu báo sát giờ Check-in.</li>
                </ul>
              </div>
            </div>
          </section>

          <section>
            <h2 class="text-2xl font-bold text-gray-900 mb-6 font-['Playfair_Display']">Đánh giá</h2>
            <div class="space-y-6">
              <div v-for="i in 4" :key="i" class="pb-6 border-b border-gray-100 last:border-0">
                <div class="flex items-center gap-4 mb-4">
                  <div class="w-12 h-12 rounded-full bg-[#4A7055]/10 flex items-center justify-center text-[#4A7055] font-bold text-lg">
                    U
                  </div>
                  <div>
                    <div class="font-bold text-gray-900 font-['Inter']">User {{ i }}</div>
                    <div class="text-sm text-gray-500 font-['Inter']">Tháng 10 năm 2023</div>
                  </div>
                </div>
                <p class="text-gray-700 italic font-['Inter'] leading-relaxed">
                  "Mình ở một tuần, trải nghiệm cực kì tốt, 100% sẽ giới thiệu cho bạn mình. Phòng đẹp hơn cả mình kỳ vọng mà giá cả phải chăng."
                </p>
              </div>
            </div>
            <button class="mt-6 border-2 border-gray-900 text-gray-900 px-8 py-3 rounded-full font-bold font-['Inter'] hover:bg-gray-900 hover:text-white transition-colors">
              Hiển thị tất cả 120 đánh giá
            </button>
          </section>

        </div>

        <div class="lg:col-span-1">
          <div class="bg-white border border-gray-100 rounded-3xl p-6 shadow-2xl sticky top-28 font-['Inter']">
            <div class="flex items-baseline gap-1.5 mb-6">
              <span class="text-3xl font-extrabold text-[#4A7055]">{{ Number(room.price).toLocaleString('vi-VN') }}đ</span>
              <span class="text-gray-500 font-medium">/ đêm</span>
            </div>

            <div class="space-y-4 mb-6">
              <div class="border border-gray-200 rounded-xl overflow-hidden focus-within:border-[#4A7055] transition-colors">
                <div class="flex border-b border-gray-200">
                  <div class="flex-1 p-3 border-r border-gray-200">
                    <label class="block text-[10px] font-extrabold text-gray-900 uppercase mb-1">Nhận phòng</label>
                    <input type="date" v-model="checkIn" class="w-full outline-none text-sm text-gray-600 bg-transparent cursor-pointer" />
                  </div>
                  <div class="flex-1 p-3">
                    <label class="block text-[10px] font-extrabold text-gray-900 uppercase mb-1">Trả phòng</label>
                    <input type="date" v-model="checkOut" class="w-full outline-none text-sm text-gray-600 bg-transparent cursor-pointer" />
                  </div>
                </div>
                
                <div class="p-3 border-b border-gray-200 flex justify-between items-center">
                  <div>
                    <label class="block text-[10px] font-extrabold text-gray-900 uppercase mb-1">Người lớn</label>
                    <span class="text-[10px] text-gray-500">Từ 10 tuổi</span>
                  </div>
                  <div class="flex items-center gap-3">
                    <button @click="adults > 1 ? adults-- : null" class="w-7 h-7 rounded-full border border-gray-300 flex items-center justify-center hover:border-[#4A7055] transition-colors">-</button>
                    <span class="w-4 text-center text-sm font-medium">{{ adults }}</span>
                    <button @click="adults++" class="w-7 h-7 rounded-full border border-gray-300 flex items-center justify-center hover:border-[#4A7055] transition-colors">+</button>
                  </div>
                </div>

                <div class="p-3 flex justify-between items-center">
                  <div>
                    <label class="block text-[10px] font-extrabold text-gray-900 uppercase mb-1">Trẻ em</label>
                    <span class="text-[10px] text-gray-500">Dưới 10 tuổi</span>
                  </div>
                  <div class="flex items-center gap-3">
                    <button @click="children > 0 ? children-- : null" class="w-7 h-7 rounded-full border border-gray-300 flex items-center justify-center hover:border-[#4A7055] transition-colors">-</button>
                    <span class="w-4 text-center text-sm font-medium">{{ children }}</span>
                    <button @click="children++" class="w-7 h-7 rounded-full border border-gray-300 flex items-center justify-center hover:border-[#4A7055] transition-colors">+</button>
                  </div>
                </div>
              </div>
              
              <div v-if="errorMessage" class="text-red-500 text-xs font-medium bg-red-50 p-3 rounded-lg border border-red-100">
                {{ errorMessage }}
              </div>
            </div>

            <button 
              @click="handleBook"
              class="w-full bg-[#4A7055] hover:bg-[#3b5a44] text-white py-4 rounded-xl font-bold text-lg transition-colors shadow-md disabled:opacity-50 disabled:cursor-not-allowed"
              :disabled="!checkIn || !checkOut"
            >
              Đặt phòng ngay
            </button>

            <div class="mt-4 text-center text-sm font-medium text-gray-500">
              Bạn vẫn chưa bị trừ tiền
            </div>
          </div>
        </div>
      </div>
    </div>

    <div v-else class="flex-grow max-w-7xl mx-auto px-4 py-20 text-center flex flex-col items-center justify-center">
      <AlertTriangle class="w-16 h-16 text-gray-300 mb-4" />
      <h2 class="text-2xl font-bold text-gray-900 mb-4 font-['Playfair_Display']">Không tìm thấy phòng!</h2>
      <p class="text-gray-500 mb-6 font-['Inter']">Phòng này có thể đã bị xóa hoặc đường dẫn không chính xác.</p>
      <button @click="router.push('/listing')" class="bg-[#4A7055] text-white px-6 py-2.5 rounded-lg hover:bg-[#3b5a44] transition-colors font-medium">
        Quay lại danh sách phòng
      </button>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import { MapPin, Star, Clock, CreditCard, Users, AlertTriangle, Home as HomeIcon } from 'lucide-vue-next';

// 1. Định nghĩa Interface khớp chuẩn với dữ liệu API trả về
interface RoomData {
  id: number | string;
  title: string;
  location: string;
  type: string;
  price: string | number;
  description: string;
  max_guests: number;
  images?: any[];
  amenities?: any[]; // <--- Sửa ở đây để khớp với Backend
  amenity_list?: any[]; // Giữ lại để template không bị lỗi
}

const route = useRoute();
const router = useRouter();

const loading = ref(true);
const room = ref<RoomData | null>(null);
const mainImage = ref('');
const subImages = ref<string[]>([]);

const checkIn = ref('');
const checkOut = ref('');
const adults = ref(1);
const children = ref(0);
const errorMessage = ref('');

onMounted(async () => {
  try {
    const roomId = route.params.id;
    checkIn.value = (route.query.checkIn as string) || '';
    checkOut.value = (route.query.checkOut as string) || '';

    const response = await fetch(`/api/rooms/${roomId}`);
    if (!response.ok) throw new Error('Không tìm thấy phòng');
    
    const data = await response.json();
    
    // Đảm bảo template nhận được dữ liệu tiện nghi dù biến tên là gì
    data.amenity_list = data.amenities || [];
    room.value = data;

    // Handler format imageURL
    const formatImageUrl = (url: string) => {
      if (!url) return '';
      if (!url.startsWith('http') && !url.startsWith('/storage/') && !url.startsWith('data:')) {
        return url.startsWith('/') ? `/storage${url}` : `/storage/${url}`;
      }
      return url;
    };

    // Xử lý hình ảnh dự phòng cực kỳ chắc chắn
    if (data.images && data.images.length > 0) {
      const primaryImg = data.images.find((img: any) => img.is_primary);
      mainImage.value = formatImageUrl(primaryImg ? primaryImg.image_url : data.images[0].image_url);
      
      // Nếu chỉ có 1 ảnh thì dùng chung cho ảnh phụ để giao diện không bị thủng
      subImages.value = data.images
          .filter((img: any) => img.image_url !== (primaryImg ? primaryImg.image_url : data.images[0].image_url))
          .map((img: any) => formatImageUrl(img.image_url));
          
      // Lấp đầy mảng ảnh phụ nếu thiếu
      while (subImages.value.length < 4) {
          subImages.value.push('https://picsum.photos/seed/fallback' + subImages.value.length + '/600/400');
      }
    } else {
      mainImage.value = 'https://picsum.photos/seed/fallback/1200/800';
      subImages.value = [
        'https://picsum.photos/seed/fallback1/600/400',
        'https://picsum.photos/seed/fallback2/600/400',
        'https://picsum.photos/seed/fallback3/600/400',
        'https://picsum.photos/seed/fallback4/600/400'
      ];
    }
  } catch (error) {
    console.error(error);
  } finally {
    loading.value = false;
  }
});

// Logic kiểm tra đặt phòng của bạn được giữ nguyên, chỉ sửa lại điều kiện type
const validateCapacity = () => {
  errorMessage.value = ''; 
  if (!room.value) return false;

  const type = room.value.type;
  // Đảm bảo max_guests luôn có giá trị (mặc định là 2 nếu bị rỗng)
  const max = room.value.max_guests || 2; 

  if(!checkIn.value || !checkOut.value) {
    errorMessage.value = 'Vui lòng chọn ngày nhận và trả phòng.';
    return false;
  }

  const inDate = new Date(checkIn.value);
  const outDate = new Date(checkOut.value);
  if(outDate <= inDate) {
     errorMessage.value = 'Ngày trả phòng phải sau ngày nhận phòng.';
     return false;
  }

  if (type === 'house' || type === 'villa') { // <--- Xử lý thêm loại villa
    if (adults.value > 20) {
      errorMessage.value = 'Nguyên căn chỉ chứa tối đa 20 người lớn. Vui lòng liên hệ hotline để được hỗ trợ.';
      return false;
    }
  } else {
    if (adults.value > max) {
        errorMessage.value = `Phòng này chỉ chứa tối đa ${max} người lớn. Vui lòng chọn phòng lớn hơn.`;
        return false;
    }
    
    const maxChildrenAllowed = Math.ceil(max / 2);
    if (children.value > maxChildrenAllowed) {
        errorMessage.value = `Loại phòng này chỉ được kèm tối đa ${maxChildrenAllowed} trẻ em.`;
        return false;
    }
  }
  
  return true;
};

// HÀM XỬ LÝ KHI BẤM NÚT ĐẶT PHÒNG
const handleBook = () => {
  if (validateCapacity()) {
    router.push({
      path: '/payment',
      query: {
        roomId: room.value?.id,
        checkIn: checkIn.value,
        checkOut: checkOut.value,
        adults: adults.value,
        children: children.value
      }
    });
  }
};
</script>

<style scoped>
input[type="date"]::-webkit-calendar-picker-indicator {
  cursor: pointer;
  opacity: 0.6;
  margin-left: 0;
}
</style>