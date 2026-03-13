<template>
  <div class="flex h-screen bg-gray-50 font-sans text-gray-900">
    <aside class="w-64 bg-emerald-900 text-white flex flex-col transition-all duration-300">
      <div class="h-16 flex items-center px-6 border-b border-emerald-800">
        <span class="text-xl font-bold tracking-wider">ADMIN PANEL</span>
      </div>
      <nav class="flex-1 py-4 space-y-1 overflow-y-auto">
        <router-link to="/admin/dashboard" class="flex items-center px-6 py-3 text-emerald-100 hover:bg-emerald-800 hover:text-white transition-colors" active-class="bg-emerald-800 text-white border-l-4 border-emerald-400">
          <LayoutDashboard class="w-5 h-5 mr-3" /> Dashboard
        </router-link>
        <router-link to="/admin/rooms" class="flex items-center px-6 py-3 text-emerald-100 hover:bg-emerald-800 hover:text-white transition-colors" active-class="bg-emerald-800 text-white border-l-4 border-emerald-400">
          <Home class="w-5 h-5 mr-3" /> Quản lý phòng
        </router-link>
        <router-link to="/admin/bookings" class="flex items-center px-6 py-3 text-emerald-100 hover:bg-emerald-800 hover:text-white transition-colors" active-class="bg-emerald-800 text-white border-l-4 border-emerald-400">
          <CalendarDays class="w-5 h-5 mr-3" /> Đơn đặt phòng
        </router-link>
        <router-link to="/admin/invoices" class="flex items-center px-6 py-3 text-emerald-100 hover:bg-emerald-800 hover:bg-emerald-800 hover:text-white transition-colors" active-class="bg-emerald-800 text-white border-l-4 border-emerald-400">
          <Receipt class="w-5 h-5 mr-3" />
          <span>Hóa đơn & Thanh toán</span>
        </router-link>
        <router-link to="/admin/users" class="flex items-center px-6 py-3 text-emerald-100 hover:bg-emerald-800 hover:text-white transition-colors" active-class="bg-emerald-800 text-white border-l-4 border-emerald-400">
          <Users class="w-5 h-5 mr-3" /> Người dùng
        </router-link>
      </nav>
      <div class="p-4 border-t border-emerald-800">
        <button class="flex items-center w-full px-4 py-2 text-sm text-emerald-100 hover:text-white hover:bg-emerald-800 rounded-lg transition-colors">
          <LogOut class="w-4 h-4 mr-2" /> Đăng xuất
        </button>
      </div>
    </aside>

    <main class="flex-1 flex flex-col overflow-hidden">
      <header class="h-16 bg-white border-b border-gray-200 flex items-center justify-between px-8 shrink-0">
        <h2 class="text-xl font-semibold text-gray-800">Hệ thống quản lý Homestay</h2>
        <div class="flex items-center gap-4">
          <div class="w-8 h-8 rounded-full bg-emerald-100 text-emerald-700 flex items-center justify-center font-bold">A</div>
        </div>
      </header>
      
      <div class="flex-1 overflow-y-auto p-8">
        <router-view></router-view>
      </div>
    </main>
  </div>
</template>

<script setup lang="ts">
import { LayoutDashboard, Home, CalendarDays, Users, LogOut, Receipt } from 'lucide-vue-next';
</script>