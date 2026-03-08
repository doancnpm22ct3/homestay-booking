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
import Header from './components/Header.vue';
import Footer from './components/Footer.vue';
</script>
