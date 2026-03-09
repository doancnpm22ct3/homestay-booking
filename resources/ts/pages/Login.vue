<template>
  <div class="min-h-[calc(100vh-4rem-20rem)] flex items-center justify-center py-12 px-4 sm:px-6 lg:px-8 bg-gray-50">
    <div class="max-w-md w-full space-y-8 bg-white p-8 rounded-2xl shadow-sm border border-gray-100">
      <div>
        <h2 class="mt-6 text-center text-3xl font-extrabold text-gray-900">
          Đăng Nhập
        </h2>
      </div>

      <!-- Thông báo lỗi -->
      <div v-if="errorMessage" class="bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded-lg text-sm">
        {{ errorMessage }}
      </div>

      <form class="mt-8 space-y-6" @submit.prevent="handleLogin">
        <div class="rounded-md shadow-sm space-y-4">
          <div>
            <label for="email" class="block text-sm font-medium text-gray-700 mb-1">Email</label>
            <input
              id="email"
              v-model="form.email"
              name="email"
              type="email"
              autocomplete="email"
              required
              :class="[
                'appearance-none rounded-lg relative block w-full px-3 py-3 border placeholder-gray-500 text-gray-900 focus:outline-none focus:ring-emerald-500 focus:z-10 sm:text-sm',
                errors.email ? 'border-red-400 focus:border-red-400' : 'border-gray-300 focus:border-emerald-500'
              ]"
              placeholder="email@example.com"
            />
            <p v-if="errors.email" class="mt-1 text-xs text-red-600">{{ errors.email }}</p>
          </div>
          <div>
            <label for="password" class="block text-sm font-medium text-gray-700 mb-1">Mật khẩu</label>
            <div class="relative">
              <input
                id="password"
                v-model="form.password"
                name="password"
                :type="showPassword ? 'text' : 'password'"
                autocomplete="current-password"
                required
                :class="[
                  'appearance-none rounded-lg relative block w-full px-3 py-3 pr-10 border placeholder-gray-500 text-gray-900 focus:outline-none focus:ring-emerald-500 focus:z-10 sm:text-sm',
                  errors.password ? 'border-red-400 focus:border-red-400' : 'border-gray-300 focus:border-emerald-500'
                ]"
                placeholder="Nhập mật khẩu"
              />
              <button
                type="button"
                class="absolute inset-y-0 right-3 flex items-center text-gray-400 hover:text-gray-600"
                @click="showPassword = !showPassword"
              >
                <EyeOff v-if="showPassword" class="w-4 h-4" />
                <Eye v-else class="w-4 h-4" />
              </button>
            </div>
            <p v-if="errors.password" class="mt-1 text-xs text-red-600">{{ errors.password }}</p>
          </div>
        </div>

        <div class="flex items-center justify-between">
          <label class="flex items-center gap-2 cursor-pointer">
            <input v-model="form.remember" type="checkbox" class="rounded border-gray-300 text-emerald-600 focus:ring-emerald-500" />
            <span class="text-sm text-gray-600">Ghi nhớ đăng nhập</span>
          </label>
          <div class="text-sm">
            <router-link to="/forgot-password" class="font-medium text-emerald-600 hover:text-emerald-500">
              Quên mật khẩu?
            </router-link>
          </div>
        </div>

        <div>
          <button
            type="submit"
            :disabled="loading"
            class="group relative w-full flex justify-center items-center gap-2 py-3 px-4 border border-transparent text-sm font-medium rounded-lg text-white bg-emerald-700 hover:bg-emerald-800 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-emerald-500 transition-colors disabled:opacity-60 disabled:cursor-not-allowed"
          >
            <Loader2 v-if="loading" class="w-4 h-4 animate-spin" />
            {{ loading ? 'Đang đăng nhập...' : 'Đăng nhập' }}
          </button>
        </div>

        <div class="relative">
          <div class="absolute inset-0 flex items-center">
            <div class="w-full border-t border-gray-300" />
          </div>
          <div class="relative flex justify-center text-sm">
            <span class="px-2 bg-white text-gray-500">Hoặc</span>
          </div>
        </div>

        <div>
          <button
            type="button"
            class="w-full flex justify-center items-center gap-2 py-3 px-4 border border-gray-300 rounded-lg shadow-sm bg-white text-sm font-medium text-gray-700 hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-emerald-500 transition-colors"
          >
            Đăng nhập bằng Google
          </button>
        </div>
      </form>

      <div class="text-center mt-4">
        <p class="text-sm text-gray-600">
          Tôi chưa có tài khoản?
          <router-link to="/register" class="font-medium text-emerald-600 hover:text-emerald-500">
            Đăng Ký
          </router-link>
        </p>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive } from 'vue';
import { useRouter } from 'vue-router';
import axios from 'axios';
import { Eye, EyeOff, Loader2 } from 'lucide-vue-next';
import { useAuth } from '@/composables/useAuth';

const router = useRouter();
const { fetchUser } = useAuth();

const form = reactive({
  email: '',
  password: '',
  remember: false,
});

const loading = ref(false);
const showPassword = ref(false);
const errorMessage = ref('');
const errors = reactive<{ email?: string; password?: string }>({});

async function handleLogin() {
  loading.value = true;
  errorMessage.value = '';
  errors.email = '';
  errors.password = '';

  try {
    // Lấy CSRF token trước khi đăng nhập (bắt buộc với Laravel session)
    await axios.get('/sanctum/csrf-cookie');

    await axios.post('/login', {
      email: form.email,
      password: form.password,
      remember: form.remember,
    });

    // Cập nhật auth state và chuyển về trang chủ
    await fetchUser();
    router.push('/');
  } catch (error: any) {
    if (error.response?.status === 422) {
      const validationErrors = error.response.data?.errors || {};
      errors.email = validationErrors.email?.[0] || '';
      errors.password = validationErrors.password?.[0] || '';
      errorMessage.value = error.response.data?.message || 'Thông tin đăng nhập không hợp lệ.';
    } else if (error.response?.status === 419) {
      errorMessage.value = 'Phiên làm việc đã hết hạn. Vui lòng thử lại.';
    } else {
      errorMessage.value = 'Đã xảy ra lỗi. Vui lòng thử lại sau.';
    }
  } finally {
    loading.value = false;
  }
}
</script>

