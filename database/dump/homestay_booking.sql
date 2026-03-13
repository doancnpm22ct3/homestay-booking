SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

-- Xóa database cũ bị lỗi và tạo lại cái mới sạch sẽ
DROP DATABASE IF EXISTS `homestay_booking`;
CREATE DATABASE IF NOT EXISTS `homestay_booking` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `homestay_booking`;

-- Cấu trúc bảng cho bảng `amenities`
CREATE TABLE `amenities` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `icon` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `amenities` (`id`, `name`, `icon`) VALUES
(1, 'Wifi miễn phí', 'wifi'),
(2, 'Điều hòa', 'snowflake'),
(3, 'Máy chiếu', 'projector'),
(4, 'Tủ lạnh', 'refrigerator'),
(5, 'Bếp mini', 'utensils'),
(6, 'Máy sấy tóc', 'wind'),
(7, 'hieu', 'star');

-- Cấu trúc bảng cho bảng `bookings`
CREATE TABLE `bookings` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `room_id` int(11) NOT NULL,
  `check_in` date NOT NULL,
  `check_out` date NOT NULL,
  `guests_count` int(11) NOT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `status` enum('pending','confirmed','cancelled') DEFAULT 'pending',
  `note` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Cấu trúc bảng cho bảng `failed_jobs`
CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Cấu trúc bảng cho bảng `migrations`
CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_100000_create_password_resets_table', 1),
(2, '2019_08_19_000000_create_failed_jobs_table', 1),
(3, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(4, '2014_10_12_000000_create_users_table', 2),
(5, '2026_03_09_112907_add_role_to_users_table', 3),
(6, '2026_03_09_163919_add_status_to_users_table', 4);

-- Cấu trúc bảng cho bảng `password_resets`
CREATE TABLE `password_resets` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Cấu trúc bảng cho bảng `personal_access_tokens`
CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\User', 1, 'auth_token', '849a6eefd02fab9ec956e83d28d176ce39a7c8aadcd15a94fcaf2a33f7443250', '[\"*\"]', NULL, NULL, '2026-03-09 03:22:51', '2026-03-09 03:22:51'),
(2, 'App\\Models\\User', 2, 'auth_token', '34a359c2ed09b5919a2e38ff57259a345de2c3bbdf37168362175351d8b7c3cb', '[\"*\"]', NULL, NULL, '2026-03-09 03:31:32', '2026-03-09 03:31:32'),
(3, 'App\\Models\\User', 3, 'auth_token', 'ad52080aa98ba767f9979d2acaa39d6736d10d181432a5cc62d96819f6f3f5b2', '[\"*\"]', NULL, NULL, '2026-03-09 03:59:57', '2026-03-09 03:59:57'),
(4, 'App\\Models\\User', 3, 'auth_token', 'd2852d114f00c327b09aedb5ff740cf674c27729372edae1a953d73ce9cda8c6', '[\"*\"]', NULL, NULL, '2026-03-09 04:00:09', '2026-03-09 04:00:09'),
(5, 'App\\Models\\User', 6, 'auth_token', '5c20df4ad0fabbdb3e366cbc4cb2b2631bc265697413dea570d90c191863ee42', '[\"*\"]', NULL, NULL, '2026-03-09 04:03:29', '2026-03-09 04:03:29'),
(6, 'App\\Models\\User', 7, 'auth_token', '178b5a7f5a0a0eae08b57e9e59d0366bde5835d3135eee11cc991af1cb0c0bbc', '[\"*\"]', NULL, NULL, '2026-03-09 04:05:25', '2026-03-09 04:05:25'),
(7, 'App\\Models\\User', 8, 'auth_token', '4c59798945f419dbb4d8e11011a8eb33f9ac1c827afe4c1316facec97160a095', '[\"*\"]', NULL, NULL, '2026-03-09 04:10:45', '2026-03-09 04:10:45'),
(8, 'App\\Models\\User', 8, 'auth_token', 'ad15752f85881f4cbcfaf434470a8000ab2cd39ac71e1dece6080c7042e031d7', '[\"*\"]', NULL, NULL, '2026-03-09 04:19:44', '2026-03-09 04:19:44'),
(9, 'App\\Models\\User', 9, 'auth_token', 'cb5af11f1f348790a5fcaad35eb27c5055aff3fec0ad7df7a90939244af19dfb', '[\"*\"]', NULL, NULL, '2026-03-09 04:21:34', '2026-03-09 04:21:34'),
(10, 'App\\Models\\User', 11, 'auth_token', '314f100189dcfa0aa5fe9cccea1731889bd927340fee842faafad358c67b426f', '[\"*\"]', NULL, NULL, '2026-03-09 04:44:32', '2026-03-09 04:44:32'),
(11, 'App\\Models\\User', 12, 'auth_token', '59d30fb2ef80672093ea6f2f6d4ef6d6186adae27bc766740892853c9c658203', '[\"*\"]', NULL, NULL, '2026-03-09 04:46:45', '2026-03-09 04:46:45'),
(13, 'App\\Models\\User', 12, 'auth_token', '1f857df2b2cb87facb89a51529be58872cae574fca423f1c9dc0cb4c351ff910', '[\"*\"]', NULL, NULL, '2026-03-09 04:48:45', '2026-03-09 04:48:45'),
(14, 'App\\Models\\User', 9, 'auth_token', '2585dd2a166ae54f6aac730b995453fbc5562929d371b0e00e6f05c501e5de22', '[\"*\"]', NULL, NULL, '2026-03-09 09:27:55', '2026-03-09 09:27:55'),
(15, 'App\\Models\\User', 9, 'auth_token', 'f2fe305f537cbcae2add37bf3e8c531a9c2b08c08ca942def295e79980393fb4', '[\"*\"]', NULL, NULL, '2026-03-09 09:27:55', '2026-03-09 09:27:55'),
(16, 'App\\Models\\User', 9, 'auth_token', '01fd1c54787f51a7c0673be6f2b50ec5687bfab6779b3be9929779b682116542', '[\"*\"]', NULL, NULL, '2026-03-09 09:27:56', '2026-03-09 09:27:56'),
(17, 'App\\Models\\User', 12, 'auth_token', 'a0474979610b7db4e5955dd7373af3ae0146e82355c1a94a3fba4630b88b62e7', '[\"*\"]', NULL, NULL, '2026-03-09 09:40:55', '2026-03-09 09:40:55'),
(21, 'App\\Models\\User', 12, 'auth_token', '5f4fd72a988f42e34bda26b27bde42451f96190c2838db13da8a60664701f8b4', '[\"*\"]', NULL, NULL, '2026-03-09 10:01:10', '2026-03-09 10:01:10'),
(22, 'App\\Models\\User', 9, 'auth_token', 'ab96b85af60c08dd4b602bf085915cd781c5a3bfb1858ba84f35c535e37264bd', '[\"*\"]', NULL, NULL, '2026-03-09 10:01:36', '2026-03-09 10:01:36'),
(26, 'App\\Models\\User', 12, 'auth_token', '22532fc53a3e843dc6a4da38b5034b3f297905004d98e144cb47f1cefc87ca1e', '[\"*\"]', NULL, NULL, '2026-03-09 10:33:09', '2026-03-09 10:33:09'),
(27, 'App\\Models\\User', 12, 'auth_token', 'be24aaaa41a835e36dc3e9af018026a6c0ea1debb66e26b2fb2f78bceff69df5', '[\"*\"]', NULL, NULL, '2026-03-09 10:58:26', '2026-03-09 10:58:26'),
(30, 'App\\Models\\User', 12, 'auth_token', 'beca9878c6312bd246fa5ce5bb683dc0de3d1701b34c80cac690782331e872c2', '[\"*\"]', NULL, NULL, '2026-03-10 11:18:27', '2026-03-10 11:18:27'),
(31, 'App\\Models\\User', 12, 'auth_token', 'c449608f9cd18cf34e82968bf3018f78229d8f90201f7a46b6316df5580f7d11', '[\"*\"]', NULL, NULL, '2026-03-10 11:18:28', '2026-03-10 11:18:28'),
(32, 'App\\Models\\User', 12, 'auth_token', '262927989aed268e77cc6a1d3f36c212333427eb580278e1deab65f0dc311da1', '[\"*\"]', NULL, NULL, '2026-03-10 11:43:47', '2026-03-10 11:43:47'),
(33, 'App\\Models\\User', 12, 'auth_token', '30e707ec8c5f2ce2d8554ada94d0a1bb5e5ea2227197a5dd67454e8751a507a1', '[\"*\"]', NULL, NULL, '2026-03-10 11:48:10', '2026-03-10 11:48:10'),
(34, 'App\\Models\\User', 12, 'auth_token', '8ae6c3064798f497adbbffebbfc5dff156dba2d3e065eb2553af1e2d80097d89', '[\"*\"]', NULL, NULL, '2026-03-10 12:04:20', '2026-03-10 12:04:20');

-- Cấu trúc bảng cho bảng `reviews`
CREATE TABLE `reviews` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `room_id` int(11) NOT NULL,
  `rating` int(11) DEFAULT NULL CHECK (`rating` >= 1 and `rating` <= 5),
  `comment` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Cấu trúc bảng cho bảng `rooms`
CREATE TABLE `rooms` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `location` varchar(255) NOT NULL,
  `type` varchar(50) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `max_guests` int(11) DEFAULT 2,
  `description` text DEFAULT NULL,
  `status` varchar(20) DEFAULT 'available',
  `is_visible` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `rooms` (`id`, `title`, `location`, `type`, `price`, `max_guests`, `description`, `status`, `is_visible`, `created_at`) VALUES
(4, 'Phòng hạnh phúc', 'Đà Nẵng , Hải Châu', 'house', 0.00, 4, NULL, 'booked', 1, '2026-03-08 18:48:32'),
(5, 'phòng 1', 'Thanh Khê', 'house', 100000.00, 2, NULL, 'in_use', 0, '2026-03-08 18:57:03'),
(11, 'Homestay View Biển', 'Thanh Khê', 'house', 5000000.00, 2, NULL, 'available', 1, '2026-03-10 06:23:52');

-- Cấu trúc bảng cho bảng `room_amenities`
CREATE TABLE `room_amenities` (
  `room_id` int(11) NOT NULL,
  `amenity_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `room_amenities` (`room_id`, `amenity_id`) VALUES
(4, 2),
(4, 6),
(5, 1),
(5, 4),
(5, 5),
(10, 1),
(10, 4),
(11, 1),
(11, 2),
(11, 3),
(11, 4),
(11, 5),
(11, 6);

-- Cấu trúc bảng cho bảng `room_images`
CREATE TABLE `room_images` (
  `id` int(11) NOT NULL,
  `room_id` int(11) NOT NULL,
  `image_url` varchar(255) NOT NULL,
  `is_primary` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `room_images` (`id`, `room_id`, `image_url`, `is_primary`) VALUES
(5, 4, '/storage/rooms/H13FB0FYqkD6GRFsZKOlHB3wb0J4dJebbWd8KbV4.png', 1),
(6, 4, '/storage/rooms/Qw0TAlGnLhbxsJDccXCDRgYvaT0TG4DLwzt0ycrF.png', 0),
(7, 4, '/storage/rooms/iaBrvVcMOagOlQ02l47cclqNhX6ya4xFuoN4Kazh.png', 0),
(8, 4, '/storage/rooms/8UEguaiFrbIqIdiGjzm7SNHcBEx6e6QK0he5VX4i.png', 0),
(9, 5, '/storage/rooms/WcSlFsMSdJjhRjI751STciw8bw6N5EmaWZs7Crzd.png', 1),
(12, 10, '/storage/rooms/lLj7kp4T0O9tEC4ZktYpME68p8af1R0GBAuanvjZ.png', 1),
(13, 10, '/storage/rooms/ExAVn8hwmDZOSxBj3opntPzo87OUYHYKFDB1u916.png', 0),
(14, 10, '/storage/rooms/4OG3kK8brdrZT41kWRQouGJeIN2AFuNCkJV62DHV.png', 0),
(15, 10, '/storage/rooms/9aFAdqzpUt5lDGetoN3Ov7maDgfzkdGBv04FfyfU.png', 0),
(16, 10, '/storage/rooms/OjCDpyteIFrsYe3UkSVujf6QZMdeBcxX1YuuLLfN.png', 0),
(17, 11, '/storage/rooms/L1uII6qHGzM08mFvmlbwRQSSspJsWpBu4FKSD4hq.png', 1),
(18, 11, '/storage/rooms/RAnCR3bqdHA3vlN0Q3lF4ciShLpIbymSJcBmfUkI.png', 0),
(19, 11, '/storage/rooms/bbO48b7jkHJWjXGYOS2LcNqgfUNEQg5IrrVsBuxU.png', 0);

-- Cấu trúc bảng cho bảng `users`
CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `role` varchar(255) NOT NULL DEFAULT 'customer',
  `status` varchar(255) NOT NULL DEFAULT 'active',
  `phone` varchar(255) DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `users` (`id`, `name`, `email`, `role`, `status`, `phone`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(9, 'votronghieu1', 'tronghieuvo9@gmail.com', 'customer', 'active', '0906123931', NULL, '$2y$10$dJi7w3tzWfOIhT/U/kFjaeH35x.E1mBNt9696UisqLztctVQkfKx.', NULL, '2026-03-09 04:21:29', '2026-03-09 10:59:23'),
(12, 'admin', 'admin@gmail.com', 'admin', 'active', '1', NULL, '$2y$10$9VuzbFvDsHTLldawJA5SoucTImooB9VsjISTMpUmeyt/wYrQ/U0Z6', NULL, '2026-03-09 04:46:24', '2026-03-09 04:46:24'),
(13, 'votrong', 'tronghieuvo@gmail.com', 'customer', 'blocked', '0906123933', NULL, '$2y$10$lFOqdvuPcxxMfhziWSIqNOW40LcnaRb4GoOt6ggrCneK1wzUP6EOa', NULL, '2026-03-09 04:47:47', '2026-03-10 11:44:14'),
(14, 'votronghieu', 'tronghieuvo9@fd', 'customer', 'active', '09061239311232', NULL, '$2y$10$ZQkbxfC/g9qLWOjDvI58zOIOrXG7q4ilB2NMXNIJK6wS0LfxcU.k.', NULL, '2026-03-10 11:49:15', '2026-03-10 11:49:15'),
(15, 'votronghieu', 'tronghieuvo7@gmail.com', 'customer', 'active', '0333333333', NULL, '$2y$10$ugjQztr1BRPAxJHNN.FuQ.nGCpONLfVs5cA3tBmPwcJrXI0GniqSm', NULL, '2026-03-10 12:01:30', '2026-03-10 12:01:30');

-- Chỉ mục cho bảng `amenities`
ALTER TABLE `amenities`
  ADD PRIMARY KEY (`id`);

-- Chỉ mục cho bảng `bookings`
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `room_id` (`room_id`);

-- Chỉ mục cho bảng `failed_jobs`
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

-- Chỉ mục cho bảng `migrations`
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

-- Chỉ mục cho bảng `password_resets`
ALTER TABLE `password_resets`
  ADD PRIMARY KEY (`email`);

-- Chỉ mục cho bảng `personal_access_tokens`
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

-- Chỉ mục cho bảng `reviews`
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `room_id` (`room_id`);

-- Chỉ mục cho bảng `rooms`
ALTER TABLE `rooms`
  ADD PRIMARY KEY (`id`);

-- Chỉ mục cho bảng `room_amenities`
ALTER TABLE `room_amenities`
  ADD PRIMARY KEY (`room_id`,`amenity_id`),
  ADD KEY `amenity_id` (`amenity_id`);

-- Chỉ mục cho bảng `room_images`
ALTER TABLE `room_images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `room_id` (`room_id`);

-- Chỉ mục cho bảng `users`
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

-- AUTO_INCREMENT cho bảng `amenities`
ALTER TABLE `amenities`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

-- AUTO_INCREMENT cho bảng `bookings`
ALTER TABLE `bookings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- AUTO_INCREMENT cho bảng `failed_jobs`
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

-- AUTO_INCREMENT cho bảng `migrations`
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

-- AUTO_INCREMENT cho bảng `personal_access_tokens`
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

-- AUTO_INCREMENT cho bảng `reviews`
ALTER TABLE `reviews`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- AUTO_INCREMENT cho bảng `rooms`
ALTER TABLE `rooms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

-- AUTO_INCREMENT cho bảng `room_images`
ALTER TABLE `room_images`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

-- AUTO_INCREMENT cho bảng `users`
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

COMMIT;