<<<<<<< HEAD
-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th3 13, 2026 lúc 11:09 AM
-- Phiên bản máy phục vụ: 10.4.32-MariaDB
-- Phiên bản PHP: 8.2.12

=======
>>>>>>> 5c00cb4170f0acfca4924e1975a0a699ee2fffe2
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

<<<<<<< HEAD

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `homestay_booking`
--
=======
-- Xóa database cũ bị lỗi và tạo lại cái mới sạch sẽ
DROP DATABASE IF EXISTS `homestay_booking`;
CREATE DATABASE IF NOT EXISTS `homestay_booking` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `homestay_booking`;
>>>>>>> 5c00cb4170f0acfca4924e1975a0a699ee2fffe2

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
  `id` bigint(20) UNSIGNED NOT NULL,
  `booking_code` varchar(255) NOT NULL,
  `customer_name` varchar(255) NOT NULL,
  `customer_email` varchar(255) NOT NULL,
  `customer_phone` varchar(255) NOT NULL,
  `room_name` varchar(255) NOT NULL,
  `total_price` decimal(15,2) NOT NULL,
  `deposit_amount` decimal(15,2) NOT NULL,
  `payment_status` varchar(255) NOT NULL DEFAULT 'deposited',
  `paid_at` timestamp NULL DEFAULT NULL,
  `payment_method` varchar(255) NOT NULL DEFAULT 'bank',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `bookings`
--

INSERT INTO `bookings` (`id`, `booking_code`, `customer_name`, `customer_email`, `customer_phone`, `room_name`, `total_price`, `deposit_amount`, `payment_status`, `paid_at`, `payment_method`, `created_at`, `updated_at`) VALUES
(1, 'HD-69B38A3A48612', 'Lan Anh', 'volananh2k4@gmail.com', '0945999305', '2', 7000000.00, 2100000.00, 'completed', NULL, 'bank', '2026-03-13 03:53:30', '2026-03-13 03:54:19'),
(2, 'HD-69B38BA4645A8', 'Lan Anh', 'volananh2k4@gmail.com', '0945999305', '2', 7000000.00, 2100000.00, 'completed', NULL, 'bank', '2026-03-13 03:59:32', '2026-03-13 04:00:01'),
(3, 'HD-69B38BF8ED5AB', 'Lan Anh', 'volananh2k4@gmail.com', '0945999305', '2', 7000000.00, 2100000.00, 'completed', NULL, 'bank', '2026-03-13 04:00:56', '2026-03-13 04:01:34');

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
(7, '2026_03_09_163919_add_status_to_users_table', 4),
(9, '2026_03_11_143215_create_bookings_table', 5),
(10, '2026_03_13_030243_add_paid_at_to_bookings_table', 5);

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
(27, 'App\\Models\\User', 12, 'auth_token', 'f5ff00a1455591aec944808ccdc74d66722c832f326e38ffedb166cc257bb94f', '[\"*\"]', NULL, NULL, '2026-03-10 10:49:13', '2026-03-10 10:49:13'),
(28, 'App\\Models\\User', 12, 'auth_token', '6ff2a41a54ceaddfe407726112d63b790c078273657926480d4ca0e35654aafc', '[\"*\"]', NULL, NULL, '2026-03-11 06:43:57', '2026-03-11 06:43:57'),
(29, 'App\\Models\\User', 15, 'auth_token', 'cfe99e7485cf0573ffadcf9b66f89222230198ffa9688985d5942575d568420c', '[\"*\"]', NULL, NULL, '2026-03-11 07:56:13', '2026-03-11 07:56:13'),
(30, 'App\\Models\\User', 12, 'auth_token', '365d450f20201945ab6bc807068f0e84d8e7f142afd5b6a526b606d146037943', '[\"*\"]', NULL, NULL, '2026-03-11 07:57:15', '2026-03-11 07:57:15'),
(31, 'App\\Models\\User', 15, 'auth_token', '7a215260221c31b4a79df5bb3cef23a33c1561f48a117fc15204e41c7dd4c9fb', '[\"*\"]', NULL, NULL, '2026-03-11 08:08:48', '2026-03-11 08:08:48'),
(32, 'App\\Models\\User', 12, 'auth_token', '5e5ec418b5927cea4f9f3d3de38a96e771fd4788319ff0d9a91df1a7d05f0765', '[\"*\"]', NULL, NULL, '2026-03-11 08:15:06', '2026-03-11 08:15:06'),
(33, 'App\\Models\\User', 15, 'auth_token', 'a7832353c3627287068b3650b61d5991e22a4862cb15d28ba5317b71d31e67f7', '[\"*\"]', NULL, NULL, '2026-03-11 08:19:51', '2026-03-11 08:19:51'),
(34, 'App\\Models\\User', 15, 'auth_token', 'a1e5c326bce8dff7c217ad4bddd7223926b8bf4473d2a020b41f0b5dd0701f6c', '[\"*\"]', NULL, NULL, '2026-03-11 08:20:45', '2026-03-11 08:20:45'),
(35, 'App\\Models\\User', 12, 'auth_token', '0e28761b0961affafc92072f64402a7c8012b419c67cfa2421b4dfc7af4cb53d', '[\"*\"]', NULL, NULL, '2026-03-11 08:21:11', '2026-03-11 08:21:11'),
(36, 'App\\Models\\User', 15, 'auth_token', '275fba587490922cf261aec2f1ec4f78d27daa30ce3b2c095e594b3fb2c049a6', '[\"*\"]', NULL, NULL, '2026-03-11 08:23:07', '2026-03-11 08:23:07'),
(37, 'App\\Models\\User', 15, 'auth_token', '68d4a2e58b45ce5da9cac100cf76b96047a798a911b705819b66cd2acf64bd92', '[\"*\"]', NULL, NULL, '2026-03-11 08:43:10', '2026-03-11 08:43:10'),
(38, 'App\\Models\\User', 12, 'auth_token', '4559ebf511a415ef94b4ac1d89c8cc5d27784de55c6998d10fecbf2dff8d8f08', '[\"*\"]', NULL, NULL, '2026-03-11 08:56:22', '2026-03-11 08:56:22'),
(39, 'App\\Models\\User', 15, 'auth_token', '7b3bae911e0fa8e9cf452fd56c22ef0a35d38b1d26175a4365de55b99456fb46', '[\"*\"]', NULL, NULL, '2026-03-11 09:01:21', '2026-03-11 09:01:21'),
(40, 'App\\Models\\User', 12, 'auth_token', 'f2965f6b5178ef9b463702d3471f4afb371c7784cca8c68b69f11581d61919cb', '[\"*\"]', NULL, NULL, '2026-03-11 09:03:15', '2026-03-11 09:03:15'),
(41, 'App\\Models\\User', 15, 'auth_token', '2f131d6fae128f3367ff364dada9da4bc877862419996524042fa64cd29efe20', '[\"*\"]', NULL, NULL, '2026-03-12 00:47:32', '2026-03-12 00:47:32'),
(42, 'App\\Models\\User', 15, 'auth_token', '26e11aab45d407173a9aeb5d4ddc05d15d8790df884a6157e57be8792d3041fb', '[\"*\"]', NULL, NULL, '2026-03-12 00:50:03', '2026-03-12 00:50:03'),
(43, 'App\\Models\\User', 12, 'auth_token', '82e9dce905a00df67b77bdbd0e9ede5b8725afb3d1f847f359ab67969da13224', '[\"*\"]', NULL, NULL, '2026-03-12 00:51:43', '2026-03-12 00:51:43'),
(44, 'App\\Models\\User', 15, 'auth_token', '95572be263e2edb63a43fe54909f18d4164ca03fe0b05f18f13bcaddd54fb0ea', '[\"*\"]', NULL, NULL, '2026-03-12 19:44:21', '2026-03-12 19:44:21'),
(45, 'App\\Models\\User', 12, 'auth_token', '0b31843cfcdad95a1a0b2c99aa1bc6bf72cbe14b9a8475b07655171bf906d594', '[\"*\"]', NULL, NULL, '2026-03-12 19:53:59', '2026-03-12 19:53:59'),
(46, 'App\\Models\\User', 15, 'auth_token', '08a71bf61443fc01d63b91e4437ee2305d6115a95454bfbbae1126f9ad44e1d9', '[\"*\"]', NULL, NULL, '2026-03-13 03:14:40', '2026-03-13 03:14:40'),
(47, 'App\\Models\\User', 12, 'auth_token', '6c100d30a1d3b38233bb5fcd5425d2361b4c8e2fac2f3fef68890a9ede868f4e', '[\"*\"]', NULL, NULL, '2026-03-13 03:15:24', '2026-03-13 03:15:24'),
(48, 'App\\Models\\User', 15, 'auth_token', '3dddceb7902b6c44f0e41d4c7bcec3698f759edc0cfa06d50618619b3af72d07', '[\"*\"]', NULL, NULL, '2026-03-13 03:19:32', '2026-03-13 03:19:32'),
(49, 'App\\Models\\User', 12, 'auth_token', '93b8833da834364c5f8c153493be3d2590d1670f3d28e6f995387857d80a0096', '[\"*\"]', NULL, NULL, '2026-03-13 03:19:56', '2026-03-13 03:19:56'),
(50, 'App\\Models\\User', 15, 'auth_token', '0688988b752522073fee9f6b144a61bb5b2a700ebbe7fd55a8107d4bc493cc60', '[\"*\"]', NULL, NULL, '2026-03-13 03:36:47', '2026-03-13 03:36:47'),
(51, 'App\\Models\\User', 12, 'auth_token', 'ca89c4c8f36057cd439b7637d01952c39a5cf5e84dfd9a886f651e4aea2b0e41', '[\"*\"]', NULL, NULL, '2026-03-13 03:37:11', '2026-03-13 03:37:11'),
(52, 'App\\Models\\User', 12, 'auth_token', 'e49aea76cadae4f6f213bfa613091c05996babb159f3aaf836778ff83a7c9d86', '[\"*\"]', NULL, NULL, '2026-03-13 03:42:44', '2026-03-13 03:42:44'),
(53, 'App\\Models\\User', 15, 'auth_token', '864db1eb992059997061fc278ca8f4a086fb5c85726e16721b99a6f157caf866', '[\"*\"]', NULL, NULL, '2026-03-13 03:43:17', '2026-03-13 03:43:17'),
(54, 'App\\Models\\User', 12, 'auth_token', '3c47bf61b3ecc143b33ecdf2fb14807d2c65346194434bd1e8a69c212a6effa9', '[\"*\"]', NULL, NULL, '2026-03-13 03:52:11', '2026-03-13 03:52:11'),
(55, 'App\\Models\\User', 15, 'auth_token', 'c68116fb61d6939fd238d88dbf5937c841213a768d455af0e02dccf5e0b7bbe3', '[\"*\"]', NULL, NULL, '2026-03-13 03:53:23', '2026-03-13 03:53:23'),
(56, 'App\\Models\\User', 12, 'auth_token', 'f30041d7cbd9f01a5395814467a4e60e146cc2cb1ddc2da417b930e327a863d4', '[\"*\"]', NULL, NULL, '2026-03-13 03:53:58', '2026-03-13 03:53:58'),
(57, 'App\\Models\\User', 15, 'auth_token', 'b9abefff86907e1131a05f8be2fe377c2d97f9ce28d6dece06e5631298f91281', '[\"*\"]', NULL, NULL, '2026-03-13 03:59:25', '2026-03-13 03:59:25'),
(58, 'App\\Models\\User', 12, 'auth_token', '6e8f358d12debeff910f7b29701a3636cc3113e904f7e5c49c2e50ce58de391e', '[\"*\"]', NULL, NULL, '2026-03-13 03:59:45', '2026-03-13 03:59:45'),
(59, 'App\\Models\\User', 15, 'auth_token', '5ae447b3f59abb4d60b4139c2c97807527aac7519441953887d5db3c885aa3b0', '[\"*\"]', NULL, NULL, '2026-03-13 04:00:41', '2026-03-13 04:00:41');

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
(5, 'phòng 1', 'Thanh Khê', 'house', 100000.00, 2, NULL, 'booked', 0, '2026-03-08 18:57:03'),
(10, 'nhan', '1', 'room', 200000.00, 20, NULL, 'booked', 1, '2026-03-09 08:01:06'),
(11, '1', '1', 'room', 100000.00, 2, NULL, 'booked', 1, '2026-03-10 17:52:30'),
(12, '2', 'dsd', 'room', 7000000.00, 2, 'sach dep', 'booked', 1, '2026-03-11 13:45:48');

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
(12, 4),
(12, 5),
(12, 6);

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
(17, 11, '/storage/rooms/tPvbyK9p2a2Jzc8xiVrEZL5iNn3vGl43GzVWa3Wi.png', 1),
(20, 12, '/storage/rooms/uSiTxpZLTOzhjikRQnYLb33Cu18VHkTPQf1NTglm.jpg', 1);

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
(9, 'votronghieu1', 'tronghieuvo9@gmail.com', 'customer', 'active', '0906123931', NULL, '$2y$10$dJi7w3tzWfOIhT/U/kFjaeH35x.E1mBNt9696UisqLztctVQkfKx.', NULL, '2026-03-09 04:21:29', '2026-03-09 10:35:00'),
(12, 'admin', 'admin@gmail.com', 'admin', 'active', '1', NULL, '$2y$10$9VuzbFvDsHTLldawJA5SoucTImooB9VsjISTMpUmeyt/wYrQ/U0Z6', NULL, '2026-03-09 04:46:24', '2026-03-09 04:46:24'),
(13, 'votrong', 'tronghieuvo@gmail.com', 'customer', 'active', '0906123933', NULL, '$2y$10$lFOqdvuPcxxMfhziWSIqNOW40LcnaRb4GoOt6ggrCneK1wzUP6EOa', NULL, '2026-03-09 04:47:47', '2026-03-09 10:34:16'),
(14, 'anh ngu', 'anh@gmail.com', 'customer', 'active', '0906123333', NULL, '$2y$10$.VidHnEsUZhC4LiuP7qFcO3rWYBjYjjooNxF85AUYJ02m2kw9Rs0C', NULL, '2026-03-11 06:13:35', '2026-03-11 06:14:01'),
(15, 'Lan Anh', 'volananh2k4@gmail.com', 'customer', 'active', '0945999305', NULL, '$2y$10$OP9qeiy8GykRTZj8PUs4YevbDc6otBLYZauesw3sLl.VqTkNRMDOq', NULL, '2026-03-11 07:55:59', '2026-03-11 08:23:00');

-- Chỉ mục cho bảng `amenities`
ALTER TABLE `amenities`
  ADD PRIMARY KEY (`id`);

-- Chỉ mục cho bảng `bookings`
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `bookings_booking_code_unique` (`booking_code`);

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

-- AUTO_INCREMENT cho bảng `failed_jobs`
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

-- AUTO_INCREMENT cho bảng `migrations`
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

-- AUTO_INCREMENT cho bảng `personal_access_tokens`
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;

-- AUTO_INCREMENT cho bảng `reviews`
ALTER TABLE `reviews`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- AUTO_INCREMENT cho bảng `rooms`
ALTER TABLE `rooms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

-- AUTO_INCREMENT cho bảng `room_images`
ALTER TABLE `room_images`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

-- AUTO_INCREMENT cho bảng `users`
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
<<<<<<< HEAD
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
=======

COMMIT;
>>>>>>> 5c00cb4170f0acfca4924e1975a0a699ee2fffe2
