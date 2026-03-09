import { createApp } from 'vue';
import { createRouter, createWebHistory } from 'vue-router';
import App from './App.vue';
import './index.css';

// --- CÁC TRANG CỦA KHÁCH ---
import Home from './pages/Home.vue';
import Login from './pages/Login.vue';
import Register from './pages/Register.vue';
import ForgotPassword from './pages/ForgotPassword.vue';
import Listing from './pages/Listing.vue';
import RoomDetail from './pages/RoomDetail.vue';
import Payment from './pages/Payment.vue';
import PaymentSuccess from './pages/PaymentSuccess.vue';
import Profile from './pages/Profile.vue';

// --- CÁC TRANG CỦA ADMIN ---
import AdminLayout from './pages/admin/AdminLayout.vue';
import AdminRooms from './pages/admin/AdminRooms.vue';
import AdminRoomForm from './pages/admin/AdminRoomForm.vue';

const router = createRouter({
  history: createWebHistory(),
  routes: [
    { path: '/', component: Home },
    { path: '/login', component: Login },
    { path: '/register', component: Register },
    { path: '/forgot-password', component: ForgotPassword },
    { path: '/listing', component: Listing },
    { path: '/room/:id', component: RoomDetail },
    { path: '/payment', component: Payment },
    { path: '/payment-success', component: PaymentSuccess },
    { path: '/profile', component: Profile },

    // Route Admin
    { 
      path: '/admin', 
      component: AdminLayout,
      children: [
        { path: 'rooms', component: AdminRooms },
        { path: 'rooms/create', component: AdminRoomForm },
        { path: 'rooms/edit/:id', component: AdminRoomForm }
      ]
    }
  ]
});

const app = createApp(App);
app.use(router);
app.mount('#root');