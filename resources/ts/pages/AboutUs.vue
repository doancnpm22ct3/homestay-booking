<template>
  <div class="bg-white text-gray-800 font-sans min-h-screen">
    
    <header class="pt-28 pb-12 px-6 text-center max-w-4xl mx-auto">
      <h1 class="text-5xl md:text-6xl lg:text-7xl font-bold tracking-tight text-gray-900 mb-6 font-serif leading-[1.1]">
        Hơn cả một <br/> điểm dừng chân.
      </h1>
      <p class="text-lg md:text-xl text-gray-500 mb-10 max-w-2xl mx-auto leading-relaxed">
        Chúng tôi tin rằng mỗi chuyến đi không chỉ để đến một vùng đất mới, mà là để tìm thấy cảm giác "thuộc về" ở bất cứ đâu.
      </p>
    </header>

    <div class="px-4 md:px-8 max-w-7xl mx-auto mb-20">
      <div class="w-full h-[400px] md:h-[600px] rounded-[2.5rem] overflow-hidden shadow-2xl relative group">
        <img src="https://images.unsplash.com/photo-1499793983690-e29da59ef1c2?q=80&w=2070&auto=format&fit=crop" 
             class="w-full h-full object-cover transform group-hover:scale-105 transition-transform duration-1000" 
             alt="Our story">
        <div class="absolute inset-0 bg-black/10"></div>
      </div>
    </div>

    <section class="max-w-7xl mx-auto px-6 mb-24">
      <div class="grid grid-cols-2 md:grid-cols-4 gap-8 divide-x divide-gray-100 text-center">
        <div class="p-4">
          <p class="text-4xl lg:text-5xl font-bold text-[#4A7055] mb-2 font-serif">500+</p>
          <p class="text-sm text-gray-500 uppercase tracking-widest font-semibold">Homestay</p>
        </div>
        <div class="p-4">
          <p class="text-4xl lg:text-5xl font-bold text-[#4A7055] mb-2 font-serif">50+</p>
          <p class="text-sm text-gray-500 uppercase tracking-widest font-semibold">Tỉnh thành</p>
        </div>
        <div class="p-4">
          <p class="text-4xl lg:text-5xl font-bold text-[#4A7055] mb-2 font-serif">10k+</p>
          <p class="text-sm text-gray-500 uppercase tracking-widest font-semibold">Khách hàng</p>
        </div>
        <div class="p-4">
          <p class="text-4xl lg:text-5xl font-bold text-[#4A7055] mb-2 font-serif">4.9</p>
          <p class="text-sm text-gray-500 uppercase tracking-widest font-semibold">Đánh giá sao</p>
        </div>
      </div>
    </section>

    <section class="max-w-7xl mx-auto px-4 md:px-6 pb-32">
      <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
        
        <div class="md:col-span-2 bg-[#F4F7F5] rounded-[2.5rem] p-10 lg:p-16 flex flex-col justify-center relative overflow-hidden group hover:bg-[#ebf1ed] transition-colors">
          <div class="relative z-10">
            <span class="text-[#4A7055] font-bold tracking-widest uppercase text-sm mb-6 block flex items-center gap-2">
              <div class="w-2 h-2 rounded-full bg-[#4A7055]"></div> Sứ mệnh
            </span>
            <h2 class="text-3xl md:text-4xl lg:text-5xl font-serif font-bold text-gray-900 mb-6 leading-tight">
              Xóa nhòa khoảng cách <br class="hidden lg:block"/> giữa khách và chủ nhà.
            </h2>
            <p class="text-gray-600 text-lg max-w-lg">
              Mang đến nền tảng minh bạch, kết nối trực tiếp những trái tim yêu xê dịch với những không gian đậm chất bản địa, an toàn và dễ dàng nhất.
            </p>
          </div>
        </div>

        <div class="bg-gray-100 rounded-[2.5rem] h-[300px] md:h-auto overflow-hidden group">
          <img src="https://images.unsplash.com/photo-1510798831971-661eb04b3739?q=80&w=1974&auto=format&fit=crop" 
               class="w-full h-full object-cover transform group-hover:scale-110 transition-transform duration-700" 
               alt="Travel">
        </div>

        <div class="md:col-span-3 bg-[#4A7055] text-white rounded-[2.5rem] p-10 lg:p-16 flex flex-col md:flex-row items-center justify-between gap-10 mt-2">
           <div class="flex-1">
             <span class="text-white/70 font-bold tracking-widest uppercase text-sm mb-6 block flex items-center gap-2">
               <div class="w-2 h-2 rounded-full bg-white/70"></div> Tầm nhìn 2030
             </span>
             <h2 class="text-3xl md:text-4xl lg:text-5xl font-serif font-bold mb-6 leading-tight">
               Biểu tượng của sự tin cậy <br class="hidden lg:block"/> trong du lịch tự túc.
             </h2>
             <p class="text-white/80 text-lg max-w-2xl">
               Không chỉ dừng lại ở Việt Nam, chúng tôi khát vọng đưa nền tảng này vươn tầm khu vực, khẳng định bản sắc hiếu khách của người Việt.
             </p>
           </div>
           
           <div class="w-full md:w-auto shrink-0 mt-6 md:mt-0">
             <router-link to="/rooms" class="inline-flex items-center justify-center bg-white text-[#4A7055] px-8 py-4 rounded-full font-bold w-full md:w-auto hover:bg-[#FAF9F5] hover:scale-105 transition-all duration-300 shadow-xl">
               Trải nghiệm ngay
               <svg class="w-5 h-5 ml-2" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M14 5l7 7m0 0l-7 7m7-7H3"></path></svg>
             </router-link>
           </div>
        </div>

      </div>
    </section>
    
  </div>
</template>

<script setup lang="ts">
// Logic trang
</script>

<style scoped>
/* Import font chữ */
@import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Playfair+Display:ital,wght@0,600;0,700;1,600&display=swap');

.font-sans {
  font-family: 'Inter', sans-serif;
}
.font-serif {
  font-family: 'Playfair Display', serif;
}
</style>