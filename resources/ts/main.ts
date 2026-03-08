import { createApp } from 'vue';
import { createRouter, createWebHistory } from 'vue-router';
import App from './App.vue';
import './index.css';

import Home from './pages/Home.vue';
import Login from './pages/Login.vue';
import Register from './pages/Register.vue';
import ForgotPassword from './pages/ForgotPassword.vue';
import Listing from './pages/Listing.vue';
import RoomDetail from './pages/RoomDetail.vue';
import Payment from './pages/Payment.vue';
import PaymentSuccess from './pages/PaymentSuccess.vue';
import Profile from './pages/Profile.vue';

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
  ]
});

const app = createApp(App);
app.use(router);
app.mount('#root');
