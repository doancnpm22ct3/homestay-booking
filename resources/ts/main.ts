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
    // LÍNH TUẦN TRA NGẦM: Hỏi server xem có bị khóa hay đổi quyền không
    fetch('/api/check-status', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ email: user.email })
    }).then(async (res) => {
      if (res.status === 401) { 
        // 1. Bị khóa -> Tước thẻ, đá ra Login
        localStorage.removeItem('auth_token');
        localStorage.removeItem('user_info');
        alert('Cảnh báo: Tài khoản của bạn đã bị khóa vĩnh viễn!');
        window.location.href = '/login'; 
      } else if (res.ok) {
        // 2. An toàn -> Rút thông tin mới nhất từ Server về
        const data = await res.json();
        
        // Kẻ hở ở đây: Nếu chức vụ bị Admin đổi (VD: admin bị giáng chức thành customer)
        if (data.user && data.user.role !== user.role) {
          // Cập nhật lại thẻ bài mới vào bộ nhớ
          localStorage.setItem('user_info', JSON.stringify(data.user));
          alert('Quyền truy cập của bạn vừa bị thay đổi. Hệ thống sẽ tải lại!');
          window.location.reload(); // Ép tải lại trang để ông Bảo vệ Router gõ đầu!
        }
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
  // Soi xem khách đang gọi API nào
  const url = typeof args[0] === 'string' ? args[0] : (args[0] && args[0].url ? args[0].url : '');
  
  const response = await originalFetch(...args);
  
  // CHỈ bắt lỗi 401 NẾU đường dẫn KHÔNG phải là đang Đăng nhập
  if (response.status === 401 && !url.includes('login')) {
    // 1. Tước thẻ, xóa sạch thông tin
    localStorage.removeItem('auth_token');
    localStorage.removeItem('user_info');
    
    // 2. Hiện cảnh báo
    alert('Tài khoản của bạn đã bị Admin khóa! Buộc phải đăng xuất ngay lập tức.');
    
    // 3. Đá văng ra trang Login
    window.location.href = '/login';
  }
  
  return response;
};
// --- KẾT THÚC LÍNH GÁC NGẦM ---
// ==========================

const app = createApp(App);
app.use(router);
app.mount('#root');