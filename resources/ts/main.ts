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
import AdminUsers from './pages/admin/AdminUsers.vue';
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

    // --- Route Admin ---
    { 
      path: '/admin', 
      component: AdminLayout,
      children: [
        { path: 'rooms', component: AdminRooms },
        { path: 'users', component: AdminUsers },
        { path: 'rooms/create', component: AdminRoomForm },
        { path: 'rooms/edit/:id', component: AdminRoomForm }
      ]
    }
  ]
});


// ==========================
// NAVIGATION GUARD BẢO VỆ ADMIN
// ==========================

// --- BẮT ĐẦU ĐOẠN CODE BẢO VỆ VÀ TUẦN TRA ---
router.beforeEach((to, from, next) => {
  const userInfo = localStorage.getItem('user_info');
  let user = null;
  
  if (userInfo) {
    user = JSON.parse(userInfo);
    
    // LÍNH TUẦN TRA NGẦM: Hỏi server xem tài khoản có đang bị khóa không
    fetch('/api/check-status', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ email: user.email })
    }).then(res => {
      if (res.status === 401) { // Nếu Server báo lỗi 401 (Bị khóa)
        localStorage.removeItem('auth_token');
        localStorage.removeItem('user_info');
        alert('Cảnh báo: Tài khoản của bạn đã bị Admin khóa vĩnh viễn!');
        window.location.href = '/login'; // Đá văng ra chuồng gà
      }
    }).catch(() => {});
  }

  // Khối phân quyền Admin cũ giữ nguyên
  if (to.path.startsWith('/admin')) {
    if (!user) {
      alert('Vui lòng đăng nhập tài khoản Quản trị viên!');
      return next('/login');
    } 
    if (user.role !== 'admin') {
      alert('Cảnh báo: Bạn không có quyền truy cập khu vực này!');
      return next('/');
    }
  }

  next(); // Cho phép đi tiếp
});
// --- KẾT THÚC ĐOẠN CODE BẢO VỆ ---

// --- BẮT ĐẦU: LÍNH GÁC NGẦM BẮT LỖI 401 ---
const originalFetch = window.fetch;
window.fetch = async (...args) => {
  const response = await originalFetch(...args);
  
  // Nếu Server Laravel chửi 401 (Nghĩa là Token đã bị Admin đốt, hoặc bị khóa)
  if (response.status === 401) {
    // 1. Tước thẻ, xóa sạch thông tin trong máy
    localStorage.removeItem('auth_token');
    localStorage.removeItem('user_info');
    
    // 2. Chửi thẳng mặt
    alert('Tài khoản của bạn đã bị Admin khóa! Buộc phải đăng xuất ngay lập tức.');
    
    // 3. Đá văng ra chuồng gà (Trang Login)
    window.location.href = '/login';
  }
  
  return response;
};
// --- KẾT THÚC LÍNH GÁC NGẦM ---
// ==========================

const app = createApp(App);
app.use(router);
app.mount('#root');