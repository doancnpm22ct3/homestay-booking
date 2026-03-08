<template>
  <router-link :to="`/room/${id}`" class="group block h-full">
    <div class="bg-white rounded-2xl overflow-hidden shadow-sm hover:shadow-md transition-shadow duration-300 h-full flex flex-col border border-gray-100">
      <div class="relative aspect-[4/3] overflow-hidden">
        <img
          :src="imageUrl"
          :alt="title"
          class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"
          referrerpolicy="no-referrer"
        />
        <div class="absolute top-3 right-3 bg-white/90 backdrop-blur-sm px-2 py-1 rounded-full flex items-center gap-1 text-sm font-medium">
          <Star class="w-4 h-4 fill-amber-400 text-amber-400" />
          <span>4.8</span>
        </div>
      </div>
      <div class="p-4 flex flex-col flex-grow">
        <h3 class="text-lg font-semibold text-gray-900 mb-1 line-clamp-1 group-hover:text-emerald-700 transition-colors">
          {{ title }}
        </h3>
        <div class="flex items-start gap-1.5 text-gray-500 text-sm mb-3">
          <MapPin class="w-4 h-4 shrink-0 mt-0.5" />
          <span class="line-clamp-2">{{ location }}</span>
        </div>
        <div class="mt-auto flex items-center justify-between">
          <div class="text-sm text-gray-600">
            Loại chỗ nghỉ: <span class="font-medium text-gray-900">{{ type }}</span>
          </div>
          <div class="text-right">
            <div class="text-lg font-bold text-emerald-700">{{ price }}</div>
            <div class="text-xs text-gray-500">/ đêm</div>
          </div>
        </div>
      </div>
    </div>
  </router-link>
</template>

<script setup lang="ts">
import { MapPin, Star } from 'lucide-vue-next';

defineProps<{
  id: string;
  title: string;
  location: string;
  type: string;
  price: string;
  imageUrl: string;
}>();
</script>
