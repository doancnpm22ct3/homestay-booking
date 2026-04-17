# 🏡 Homestay Booking

Ứng dụng đặt phòng homestay xây dựng bằng **Laravel** + **Vue 3** + **Tailwind CSS v4** + **Vite 6**.

---

## ⚙️ Yêu cầu cài đặt

Trước khi bắt đầu, đảm bảo máy bạn đã cài:

| Công cụ | Phiên bản tối thiểu | Link tải |
|---------|---------------------|----------|
| PHP | >= 8.1 | https://www.php.net/downloads |
| Composer | >= 2.x | https://getcomposer.org |
| Node.js | >= 18.x | https://nodejs.org |
| MySQL | >= 8.0 | https://dev.mysql.com/downloads |
| Git | Bất kỳ | https://git-scm.com |

---

## 🚀 Hướng dẫn setup

### 1. Clone repository

```bash
git clone https://github.com/doancnpm22ct3/homestay-booking.git
cd homestay-booking
```

### 2. Cài đặt PHP dependencies

```bash
composer install
```

### 3. Tạo file cấu hình môi trường

```bash
cp .env.example .env
php artisan key:generate
```

### 4. Cấu hình database

Mở file `.env` và chỉnh sửa thông tin database:

```env
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=homestay_booking   # Tên database bạn tạo
DB_USERNAME=root                # Username MySQL của bạn
DB_PASSWORD=                    # Password MySQL của bạn
```

> ⚠️ Tạo database trước trong MySQL: `CREATE DATABASE homestay_booking;`

### 5. Chạy migration

```bash
php artisan migrate
```

> Nếu có seeder: `php artisan migrate --seed`

### 6. Cài đặt Node.js dependencies

```bash
npm install
```

### 7. Chạy ứng dụng

Mở **2 terminal** và chạy song song:

**Terminal 1 – Backend (Laravel):**
```bash
php artisan serve
```

**Terminal 2 – Frontend (Vite):**
```bash
npm run dev
```

### 8. Truy cập

Mở trình duyệt và vào: **http://localhost:8000**

---

## 📁 Cấu trúc thư mục chính

```
homestay-booking/
├── app/                # Logic backend (Controllers, Models...)
├── resources/
│   ├── ts/             # Source frontend Vue 3 + TypeScript
│   │   ├── main.ts     # Entry point
│   │   └── index.css   # Global CSS (Tailwind)
│   └── views/
│       └── welcome.blade.php  # HTML shell cho Vue app
├── routes/
│   └── web.php         # Định nghĩa routes
├── vite.config.js      # Cấu hình Vite
└── .env                # Biến môi trường (KHÔNG commit file này)
```

---

## 🌿 Quy trình làm việc với Git

```bash
# Tạo branch mới cho tính năng của bạn
git checkout -b feature/ten-tinh-nang

# Sau khi code xong, commit
git add .
git commit -m "feat: mô tả tính năng"

# Push lên GitHub
git push origin feature/ten-tinh-nang
```

> Tạo **Pull Request** để merge vào `develop`, không push thẳng vào `main`.

---

## ❓ Gặp lỗi?

- **`php artisan` không chạy** → Kiểm tra PHP đã cài và thêm vào PATH
- **Lỗi database** → Kiểm tra thông tin `.env` và đảm bảo MySQL đang chạy
- **`npm install` lỗi** → Thử `npm install --legacy-peer-deps`
- **Vite không start** → Kiểm tra Node.js phiên bản >= 18
