<template>
  <div class="bg-white min-h-screen pb-20">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
      
      <!-- Title and Location -->
      <div class="mb-6">
        <h1 class="text-3xl font-bold text-gray-900 mb-2">Phòng Mơ Màng - Số 10 Núi Thành - Quận Cẩm Lệ - TP. Đà Nẵng</h1>
        <div class="flex items-center gap-4 text-sm text-gray-600">
          <div class="flex items-center gap-1">
            <Star class="w-4 h-4 fill-amber-400 text-amber-400" />
            <span class="font-medium text-gray-900">4.8</span>
            <span class="underline cursor-pointer">(120 đánh giá)</span>
          </div>
          <div class="flex items-center gap-1">
            <MapPin class="w-4 h-4" />
            <span class="underline cursor-pointer">Quận Cẩm Lệ, TP. Đà Nẵng</span>
          </div>
        </div>
      </div>

      <!-- Image Gallery -->
      <div class="grid grid-cols-1 md:grid-cols-4 gap-4 mb-12 h-[400px] md:h-[500px] rounded-2xl overflow-hidden">
        <div class="md:col-span-2 h-full">
          <img src="https://picsum.photos/seed/roommain/1200/800" alt="Main" class="w-full h-full object-cover hover:opacity-90 transition-opacity cursor-pointer" referrerpolicy="no-referrer" />
        </div>
        <div class="hidden md:grid grid-rows-2 gap-4 h-full">
          <img src="https://picsum.photos/seed/room2/600/400" alt="Room 2" class="w-full h-full object-cover hover:opacity-90 transition-opacity cursor-pointer" referrerpolicy="no-referrer" />
          <img src="https://picsum.photos/seed/room3/600/400" alt="Room 3" class="w-full h-full object-cover hover:opacity-90 transition-opacity cursor-pointer" referrerpolicy="no-referrer" />
        </div>
        <div class="hidden md:grid grid-rows-2 gap-4 h-full">
          <img src="https://picsum.photos/seed/room4/600/400" alt="Room 4" class="w-full h-full object-cover hover:opacity-90 transition-opacity cursor-pointer" referrerpolicy="no-referrer" />
          <div class="relative h-full">
            <img src="https://picsum.photos/seed/room5/600/400" alt="Room 5" class="w-full h-full object-cover hover:opacity-90 transition-opacity cursor-pointer" referrerpolicy="no-referrer" />
            <div class="absolute inset-0 bg-black/40 flex items-center justify-center cursor-pointer hover:bg-black/50 transition-colors">
              <span class="text-white font-medium text-lg">Xem tất cả ảnh</span>
            </div>
          </div>
        </div>
      </div>

      <div class="grid grid-cols-1 lg:grid-cols-3 gap-12">
        <!-- Left Content -->
        <div class="lg:col-span-2 space-y-12">
          
          <!-- Description -->
          <section>
            <h2 class="text-2xl font-bold text-gray-900 mb-4">Mô tả chi tiết phòng</h2>
            <div class="prose text-gray-600">
              <p>
                Phòng Mơ Màng mang đến không gian nghỉ ngơi lý tưởng với thiết kế hiện đại, ấm cúng. Nằm ngay trung tâm quận Cẩm Lệ, thuận tiện di chuyển đến các điểm tham quan nổi tiếng của Đà Nẵng.
              </p>
              <p class="mt-4">
                Phòng được trang bị đầy đủ tiện nghi, view nhìn ra thành phố tuyệt đẹp, không gian yên tĩnh phù hợp cho cả kỳ nghỉ dưỡng lẫn chuyến công tác.
              </p>
            </div>
          </section>

          <!-- Amenities -->
          <section>
            <h2 class="text-2xl font-bold text-gray-900 mb-4">Tiện nghi</h2>
            <div class="grid grid-cols-2 md:grid-cols-3 gap-4">
              <div v-for="(item, i) in ['Máy chiếu', 'Wifi miễn phí', 'Điều hòa', 'Bếp mini', 'Tủ lạnh', 'Máy sấy tóc']" :key="i" class="flex items-center gap-3 text-gray-600">
                <div class="w-8 h-8 rounded-full bg-emerald-50 flex items-center justify-center text-emerald-600">
                  <Star class="w-4 h-4" />
                </div>
                <span>{{ item }}</span>
              </div>
            </div>
            <button class="mt-6 text-emerald-700 font-medium hover:text-emerald-800 underline">
              Xem thêm tiện nghi
            </button>
          </section>

          <!-- Rules -->
          <section>
            <h2 class="text-2xl font-bold text-gray-900 mb-4">Nội quy & Chính sách</h2>
            <div class="bg-gray-50 p-6 rounded-2xl space-y-6">
              <div>
                <h3 class="font-semibold text-gray-900 mb-2">Giờ check in - check out</h3>
                <ul class="list-disc pl-5 text-gray-600 space-y-1">
                  <li>Giờ check in: 14:00 (Đúng giờ có thể delay 10-15 phút)</li>
                  <li>Giờ check out: 12:00 (Đúng giờ có thể delay 10-15 phút)</li>
                </ul>
              </div>
              <div>
                <h3 class="font-semibold text-gray-900 mb-2">Nội quy căn hộ</h3>
                <ul class="list-disc pl-5 text-gray-600 space-y-1">
                  <li>Nghiêm cấm sử dụng chất kích thích, các chất gây nghiện, các chất cấm trong danh mục của nhà nước.</li>
                  <li>Không tự ý cho người lạ vào khi chưa đăng kí trước.</li>
                  <li>Không tự ý di chuyển nội thất, thiết bị, đồ đạc.</li>
                  <li>Không làm bẩn/hỏng nội thất, thiết bị, đồ đạc.</li>
                  <li>Vui lòng làm sạch bếp sau khi sử dụng.</li>
                </ul>
              </div>
              <div>
                <h3 class="font-semibold text-gray-900 mb-2">Lưu ý đặc biệt</h3>
                <ul class="list-disc pl-5 text-gray-600 space-y-1">
                  <li>Vui lòng mang theo nước lọc và bàn chải đánh răng.</li>
                  <li>Không hút thuốc.</li>
                  <li>Không làm ồn sau 11 giờ tối.</li>
                </ul>
              </div>
              <div>
                <h3 class="font-semibold text-gray-900 mb-2">Chính sách hủy phòng</h3>
                <ul class="list-disc pl-5 text-gray-600 space-y-1">
                  <li>Hủy phòng một tuần trước ngày nhận phòng: Hoàn 100%.</li>
                  <li>Các trường hợp còn lại không hỗ trợ hoàn/hủy phòng. Chỉ hỗ trợ dời lịch đặt hoặc bảo lưu theo yêu cầu của khách hàng.</li>
                </ul>
              </div>
            </div>
          </section>

          <!-- Reviews -->
          <section>
            <h2 class="text-2xl font-bold text-gray-900 mb-6">Đánh giá</h2>
            <div class="space-y-6">
              <div v-for="i in 4" :key="i" class="pb-6 border-b border-gray-100 last:border-0">
                <div class="flex items-center gap-4 mb-4">
                  <div class="w-12 h-12 rounded-full bg-emerald-100 flex items-center justify-center text-emerald-700 font-bold text-lg">
                    U
                  </div>
                  <div>
                    <div class="font-semibold text-gray-900">User {{ i }}</div>
                    <div class="text-sm text-gray-500">Tháng 10 năm 2023</div>
                  </div>
                </div>
                <p class="text-gray-600">
                  "Mình ở một tuần, trải nghiệm cực kì tốt, 100% sẽ giới thiệu cho bạn mình. Phòng đẹp hơn cả mình kỳ vọng mà giá cả phải chăng."
                </p>
              </div>
            </div>
            <button class="mt-6 border border-gray-900 text-gray-900 px-6 py-2 rounded-lg font-medium hover:bg-gray-50 transition-colors">
              Hiển thị tất cả 120 đánh giá
            </button>
          </section>

        </div>

        <!-- Right Content - Booking Form -->
        <div class="lg:col-span-1">
          <div class="bg-white border border-gray-200 rounded-2xl p-6 shadow-xl sticky top-24">
            <div class="flex items-baseline gap-1 mb-6">
              <span class="text-2xl font-bold text-emerald-700">120.000đ</span>
              <span class="text-gray-500">/ đêm</span>
            </div>

            <div class="space-y-4 mb-6">
              <div class="border border-gray-300 rounded-lg overflow-hidden">
                <div class="flex border-b border-gray-300">
                  <div class="flex-1 p-3 border-r border-gray-300">
                    <label class="block text-xs font-bold text-gray-700 uppercase mb-1">Nhận phòng</label>
                    <input type="text" placeholder="Thêm ngày" class="w-full outline-none text-sm text-gray-900" />
                  </div>
                  <div class="flex-1 p-3">
                    <label class="block text-xs font-bold text-gray-700 uppercase mb-1">Trả phòng</label>
                    <input type="text" placeholder="Thêm ngày" class="w-full outline-none text-sm text-gray-900" />
                  </div>
                </div>
                <div class="p-3 border-b border-gray-300">
                  <label class="block text-xs font-bold text-gray-700 uppercase mb-1">Số lượng người</label>
                  <select class="w-full outline-none text-sm text-gray-900 bg-transparent">
                    <option>1 khách</option>
                    <option>2 khách</option>
                    <option>3 khách</option>
                  </select>
                </div>
                <div class="p-3">
                  <label class="block text-xs font-bold text-gray-700 uppercase mb-1">Loại hình thuê</label>
                  <select class="w-full outline-none text-sm text-gray-900 bg-transparent">
                    <option>Phòng</option>
                    <option>Nguyên căn</option>
                  </select>
                </div>
              </div>
            </div>

            <button 
              @click="handleBook"
              class="w-full bg-emerald-600 hover:bg-emerald-700 text-white py-3 rounded-lg font-bold text-lg transition-colors"
            >
              Đặt phòng ngay
            </button>

            <div class="mt-4 text-center text-sm text-gray-500">
              Bạn vẫn chưa bị trừ tiền
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
import { MapPin, Star } from 'lucide-vue-next';

const router = useRouter();

const dates = ref('');
const guests = ref('');
const type = ref('');

const handleBook = () => {
  router.push('/payment');
};
</script>
