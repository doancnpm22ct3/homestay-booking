<template>
  <div class="min-h-[calc(100vh-4rem-20rem)] flex items-center justify-center py-12 px-4 sm:px-6 lg:px-8 bg-gray-50">
    <div class="max-w-md w-full space-y-8 bg-white p-8 rounded-2xl shadow-sm border border-gray-100">
      <div>
        <h2 class="mt-6 text-center text-3xl font-extrabold text-gray-900">Tạo Tài Khoản</h2>
      </div>
      <form class="mt-8 space-y-6" @submit.prevent="handleRegister">
        <div class="rounded-md shadow-sm space-y-4">
          <div>
            <label for="fullname" class="sr-only">Họ và Tên</label>
            <input id="fullname" v-model="form.name" type="text" required class="appearance-none rounded-lg relative block w-full px-3 py-3 border border-gray-300 placeholder-gray-500 text-gray-900 focus:outline-none focus:ring-emerald-500 focus:border-emerald-500 focus:z-10 sm:text-sm" placeholder="Họ và Tên" />
          </div>
          <div>
            <label for="email-address" class="sr-only">Email</label>
            <input id="email-address" v-model="form.email" type="email" autocomplete="email" required class="appearance-none rounded-lg relative block w-full px-3 py-3 border border-gray-300 placeholder-gray-500 text-gray-900 focus:outline-none focus:ring-emerald-500 focus:border-emerald-500 focus:z-10 sm:text-sm" placeholder="Email" />
          </div>
          <div>
            <label for="phone" class="sr-only">Số Điện Thoại</label>
            <input id="phone" v-model="form.phone" type="tel" required class="appearance-none rounded-lg relative block w-full px-3 py-3 border border-gray-300 placeholder-gray-500 text-gray-900 focus:outline-none focus:ring-emerald-500 focus:border-emerald-500 focus:z-10 sm:text-sm" placeholder="Số Điện Thoại" />
          </div>
          <div>
            <label for="password" class="sr-only">Mật Khẩu</label>
            <input id="password" v-model="form.password" type="password" minlength="6" required class="appearance-none rounded-lg relative block w-full px-3 py-3 border border-gray-300 placeholder-gray-500 text-gray-900 focus:outline-none focus:ring-emerald-500 focus:border-emerald-500 focus:z-10 sm:text-sm" placeholder="Mật Khẩu (Tối thiểu 6 ký tự)" />
          </div>
        </div>

        <div class="flex items-center">
          <input id="terms" v-model="form.terms" type="checkbox" required class="h-4 w-4 text-emerald-600 focus:ring-emerald-500 border-gray-300 rounded" />
          <label for="terms" class="ml-2 block text-sm text-gray-900">Tôi đồng ý với tất cả điều khoản trên</label>
        </div>

        <div>
          <button type="submit" class="group relative w-full flex justify-center py-3 px-4 border border-transparent text-sm font-medium rounded-lg text-white bg-emerald-700 hover:bg-emerald-800 transition-colors">Đăng ký</button>
        </div>
        
        <div class="relative">
          <div class="absolute inset-0 flex items-center">
            <div class="w-full border-t border-gray-300"></div>
          </div>
          <div class="relative flex justify-center text-sm">
            <span class="px-2 bg-white text-gray-500">Hoặc</span>
          </div>
        </div>

        <div>
          <button type="button" class="w-full flex justify-center py-3 px-4 border border-gray-300 rounded-lg shadow-sm bg-white text-sm font-medium text-gray-700 hover:bg-gray-50 transition-colors">Đăng nhập bằng cách khác</button>
        </div>
      </form>
      <div class="text-center mt-4">
        <p class="text-sm text-gray-600">
          Đã có tài khoản?
          <router-link to="/login" class="font-medium text-emerald-600 hover:text-emerald-500">Đăng nhập</router-link>
        </p>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { useRouter } from 'vue-router';

const router = useRouter();

const form = ref({
  name: '',
  email: '',
  phone: '',
  password: '',
  terms: false
});

const handleRegister = async () => {
  if (!form.value.terms) {
    alert('Vui lòng đồng ý với các điều khoản!');
    return;
  }

  // Chặn đăng ký nếu mật khẩu dưới 6 ký tự
  if (form.value.password.length < 6) {
    alert('Lỗi: Mật khẩu phải có ít nhất 6 ký tự!');
    return;
  }

  try {
    const response = await fetch('/api/register', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
      body: JSON.stringify({
        name: form.value.name,
        email: form.value.email,
        phone: form.value.phone,
        password: form.value.password
      })
    });

    const data = await response.json();

    // Dịch lỗi của Laravel sang tiếng Việt
// NẾU CÓ LỖI TỪ LARAVEL GỬI LÊN
    if (!response.ok) {
      if (data.errors) {
        // Lấy TÊN CỘT bị lỗi đầu tiên (email, phone, hoặc password)
        const firstErrorKey = Object.keys(data.errors)[0];
        let errorMessage = '';

        // Dịch chính xác 100% theo tên cột
        if (firstErrorKey === 'email') {
          errorMessage = 'Email này đã được sử dụng. Vui lòng dùng Email khác!';
        } else if (firstErrorKey === 'phone') {
          errorMessage = 'Số điện thoại này đã được sử dụng. Vui lòng dùng số khác!';
        } else if (firstErrorKey === 'password') {
          errorMessage = 'Mật khẩu chưa đủ an toàn (ít nhất 6 ký tự)!';
        } else {
          // Nếu có lỗi lạ khác thì in thẳng ra
          errorMessage = data.errors[firstErrorKey][0]; 
        }

        alert('Lỗi: ' + errorMessage);
      } else {
        alert(data.message || 'Lỗi: Không thể đăng ký tài khoản!');
      }
      return;
    }

    alert('Đăng ký thành công! Mời bạn đăng nhập.');
    router.push('/login');

  } catch (error) {
    console.error('Lỗi kết nối:', error);
    alert('Không thể kết nối đến máy chủ!');
  }
};
</script>