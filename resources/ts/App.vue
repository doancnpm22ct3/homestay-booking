<template>
  <div class="min-h-screen flex flex-col font-sans text-gray-800 bg-gray-50">
    <Header />
    <main class="flex-grow">
      <router-view></router-view>
    </main>
    <Footer />
  </div>
</template>

<script setup lang="ts">
import { onMounted } from 'vue';
import Header from './components/Header.vue';
import Footer from './components/Footer.vue';
import { useAuth } from './composables/useAuth';
import axios from 'axios';

// Cấu hình axios gửi cookie trong mọi request (bắt buộc với Laravel session)
axios.defaults.withCredentials = true;
axios.defaults.headers.common['X-Requested-With'] = 'XMLHttpRequest';

const { fetchUser } = useAuth();

// Khi app load, kiểm tra session hiện tại
onMounted(() => {
  fetchUser();
});
</script>
