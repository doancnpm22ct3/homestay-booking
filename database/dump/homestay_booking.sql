-- phpMyAdmin SQL Dump
-- version 6.0.0-dev+20260305.a34bb65806
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Mar 19, 2026 at 10:03 AM
-- Server version: 8.4.3
-- PHP Version: 8.4.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `homestay_booking`
--

-- --------------------------------------------------------

--
-- Table structure for table `amenities`
--

CREATE TABLE `amenities` (
  `id` int NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `icon` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `amenities`
--

INSERT INTO `amenities` (`id`, `name`, `icon`) VALUES
(1, 'Wifi tốc độ cao', 'wifi'),
(2, 'Điều hòa', 'snowflake'),
(3, 'Tivi màn hình phẳng', 'tv'),
(4, 'Nhà bếp', 'utensils'),
(5, 'Hồ bơi', 'waves'),
(6, 'Bãi đậu xe', 'car'),
(7, 'Khác(Khăn tắm, bàn chải...)', 'star'),
(9, 'Máy Điều hòa', 'star'),
(10, 'Máy Chiếu', 'star');

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

CREATE TABLE `bookings` (
  `id` bigint UNSIGNED NOT NULL,
  `booking_code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `customer_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `customer_email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `customer_phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `room_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_price` decimal(15,2) NOT NULL,
  `deposit_amount` decimal(15,2) NOT NULL,
  `payment_status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'deposited',
  `paid_at` timestamp NULL DEFAULT NULL,
  `payment_method` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'bank',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `customer_id` bigint UNSIGNED DEFAULT NULL,
  `room_id` bigint UNSIGNED DEFAULT NULL,
  `check_in_date` date DEFAULT NULL,
  `check_out_date` date DEFAULT NULL,
  `check_in_time` time NOT NULL DEFAULT '14:00:00',
  `check_out_time` time NOT NULL DEFAULT '12:00:00',
  `adults` tinyint UNSIGNED NOT NULL DEFAULT '1',
  `children` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `status` enum('pending','confirmed','checked_in','checked_out','cancelled','no_show') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `source` enum('website','booking_com','agoda','walkin','phone','other') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'website',
  `subtotal` decimal(15,0) NOT NULL DEFAULT '0',
  `discount_amount` decimal(15,0) NOT NULL DEFAULT '0',
  `discount_type` enum('percent','fixed') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `discount_reason` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_amount` decimal(15,0) NOT NULL DEFAULT '0',
  `paid_amount` decimal(15,0) NOT NULL DEFAULT '0',
  `guest_note` text COLLATE utf8mb4_unicode_ci,
  `internal_note` text COLLATE utf8mb4_unicode_ci,
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `confirmed_by` bigint UNSIGNED DEFAULT NULL,
  `checked_in_by` bigint UNSIGNED DEFAULT NULL,
  `checked_out_by` bigint UNSIGNED DEFAULT NULL,
  `cancelled_at` timestamp NULL DEFAULT NULL,
  `cancel_reason` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `refund_amount` decimal(15,0) NOT NULL DEFAULT '0',
  `additional_fee` decimal(12,2) NOT NULL DEFAULT '0.00',
  `additional_note` text COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`id`, `booking_code`, `customer_name`, `customer_email`, `customer_phone`, `room_name`, `total_price`, `deposit_amount`, `payment_status`, `paid_at`, `payment_method`, `created_at`, `updated_at`, `customer_id`, `room_id`, `check_in_date`, `check_out_date`, `check_in_time`, `check_out_time`, `adults`, `children`, `status`, `source`, `subtotal`, `discount_amount`, `discount_type`, `discount_reason`, `total_amount`, `paid_amount`, `guest_note`, `internal_note`, `created_by`, `confirmed_by`, `checked_in_by`, `checked_out_by`, `cancelled_at`, `cancel_reason`, `refund_amount`, `additional_fee`, `additional_note`) VALUES
(1, 'HD-69BA991447A97', 'Lan Anh', 'volananh2k4@gmail.com', '0945999305', 'Mơ Màng Room', 160000.00, 48000.00, 'completed', NULL, 'bank', '2026-03-13 03:53:30', '2026-03-19 03:54:04', NULL, NULL, NULL, NULL, '14:00:00', '12:00:00', 1, 0, 'pending', 'website', 7000000, 0, NULL, NULL, 7000000, 7000000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0.00, NULL),
(2, 'HD-69BAC70157928', 'Lan Anh', 'volananh2k4@gmail.com', '0945999305', 'Bình Yên Room', 170000.00, 51000.00, 'completed', NULL, 'bank', '2026-03-13 03:59:32', '2026-03-19 03:54:04', NULL, NULL, NULL, NULL, '14:00:00', '12:00:00', 1, 0, 'pending', 'website', 7000000, 0, NULL, NULL, 7000000, 7000000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0.00, NULL),
(3, 'HD-69BAC8A4AE80E', 'Lan Anh', 'volananh2k4@gmail.com', '0945999305', 'Đông Chí Room', 160000.00, 48000.00, 'completed', NULL, 'bank', '2026-03-13 04:00:56', '2026-03-19 03:54:04', NULL, NULL, NULL, NULL, '14:00:00', '12:00:00', 1, 0, 'pending', 'website', 7000000, 0, NULL, NULL, 7000000, 7000000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0.00, NULL),
(4, 'HD-69B41A9313088', 'admin', 'admin@gmail.com', '1', 'nhan', 200000.00, 60000.00, 'completed', NULL, 'bank', '2026-03-13 14:09:23', '2026-03-13 14:36:15', NULL, 10, '2026-03-14', '2026-03-15', '14:00:00', '12:00:00', 2, 1, 'confirmed', 'website', 200000, 0, NULL, NULL, 200000, 200000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0.00, NULL),
(5, 'HD-69B42D9658AE6', 'admin', 'admin@gmail.com', '1', 'nhan', 200000.00, 60000.00, 'completed', NULL, 'bank', '2026-03-13 15:30:30', '2026-03-15 09:26:48', NULL, 10, '2026-03-15', '2026-03-16', '14:00:00', '12:00:00', 2, 1, 'confirmed', 'website', 200000, 0, NULL, NULL, 200000, 200000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0.00, NULL),
(6, 'HD-69B67BC4C4771', 'pham duy', 'duy@gmail.com', '0935824455', 'Phòng hạnh phúc', 500000.00, 150000.00, 'completed', NULL, 'bank', '2026-03-15 09:28:36', '2026-03-15 09:57:03', NULL, 4, '2026-03-01', '2026-03-02', '14:00:00', '12:00:00', 2, 2, 'confirmed', 'website', 500000, 0, NULL, NULL, 500000, 500000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0.00, NULL),
(7, 'HD-69B68203CAE7E', 'pham duy', 'duy@gmail.com', '0935824455', 'Phòng hạnh phúc', 6500000.00, 1950000.00, 'completed', NULL, 'bank', '2026-03-15 09:55:15', '2026-03-15 10:26:59', NULL, 4, '2026-03-09', '2026-03-22', '14:00:00', '12:00:00', 2, 2, 'confirmed', 'website', 6500000, 0, NULL, NULL, 6500000, 6500000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0.00, NULL),
(8, 'HD-69B688AA9C05C', 'pham duy', 'duy@gmail.com', '0935824455', 'nhan', 800000.00, 240000.00, 'completed', NULL, 'bank', '2026-03-15 10:23:38', '2026-03-15 11:04:30', NULL, 10, '2026-03-01', '2026-03-05', '14:00:00', '12:00:00', 2, 2, 'confirmed', 'website', 800000, 0, NULL, NULL, 800000, 700000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0.00, NULL),
(9, 'HD-69B68D81B5B2D', 'pham duy', 'duy@gmail.com', '0935824455', 'nhan', 400000.00, 120000.00, 'completed', NULL, 'bank', '2026-03-15 10:44:17', '2026-03-15 17:05:14', NULL, 10, '2026-03-01', '2026-03-03', '14:00:00', '12:00:00', 5, 5, 'confirmed', 'website', 400000, 0, NULL, NULL, 400000, 400000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0.00, NULL),
(10, 'HD-69B68E60ADE6F', 'pham duy', 'duy@gmail.com', '0935824455', '2', 28000000.00, 8400000.00, 'completed', NULL, 'bank', '2026-03-15 10:48:00', '2026-03-15 17:05:07', NULL, 12, '2026-03-01', '2026-03-05', '14:00:00', '12:00:00', 2, 1, 'confirmed', 'website', 28000000, 0, NULL, NULL, 28000000, 28000000, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-15 10:56:05', 'Khách yêu cầu hủy', 8400000, 0.00, NULL),
(11, 'HD-69B6F6FB60B27', 'pham duy', 'duy@gmail.com', '0935824455', 'Phòng hạnh phúc', 1500000.00, 450000.00, 'deposited', NULL, 'bank', '2026-03-15 18:14:19', '2026-03-15 18:20:20', NULL, 4, '2026-03-01', '2026-03-04', '14:00:00', '12:00:00', 2, 1, 'checked_out', 'website', 1500000, 0, NULL, NULL, 1500000, 1500000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0.00, NULL),
(12, 'HD-69B6F74B9CA72', 'admin', 'admin@gmail.com', '1', 'nhan', 400000.00, 120000.00, 'completed', NULL, 'bank', '2026-03-15 18:15:39', '2026-03-15 18:25:16', NULL, 12, '2026-03-01', '2026-03-03', '14:00:00', '12:00:00', 2, 1, 'checked_in', 'website', 400000, 0, NULL, NULL, 400000, 400000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0.00, NULL),
(13, 'HD-69B6F903A6EC0', 'pham duy', 'duy@gmail.com', '0935824455', 'nhan', 600000.00, 180000.00, 'deposited', NULL, 'bank', '2026-03-15 18:22:59', '2026-03-15 18:41:11', NULL, 10, '2026-03-01', '2026-03-04', '14:00:00', '12:00:00', 2, 0, 'cancelled', 'website', 600000, 0, NULL, NULL, 600000, 600000, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-15 18:24:17', 'Khách yêu cầu hủy', 180000, 0.00, NULL),
(14, 'HD-69B6FB399BD38', 'admin', 'admin@gmail.com', '1', 'Phòng hạnh phúc', 5500000.00, 1650000.00, 'deposited', NULL, 'bank', '2026-03-15 18:32:25', '2026-03-19 10:01:37', NULL, 4, '2026-03-01', '2026-03-12', '14:00:00', '12:00:00', 2, 2, 'cancelled', 'website', 5500000, 0, NULL, NULL, 5500000, 1650000, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-19 10:01:37', 'Overbooking', 0, 0.00, NULL),
(15, 'HD-69B6FB9A3038A', 'admin', 'admin@gmail.com', '1', '2', 84000000.00, 25200000.00, 'deposited', NULL, 'bank', '2026-03-15 18:34:02', '2026-03-15 18:41:24', NULL, 12, '2026-02-28', '2026-03-12', '14:00:00', '12:00:00', 2, 1, 'checked_in', 'website', 84000000, 0, NULL, NULL, 84000000, 25200000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0.00, NULL),
(17, 'HD-69BB9FE308076', 'admin', 'admin@gmail.com', '1', 'NC Haven Homestay', 2000000.00, 600000.00, 'completed', NULL, 'bank', '2026-03-19 07:04:03', '2026-03-19 07:05:39', NULL, 35, '2026-03-02', '2026-03-03', '14:00:00', '12:00:00', 3, 1, 'confirmed', 'website', 2000000, 0, NULL, NULL, 2000000, 2000000, NULL, NULL, NULL, NULL, 12, 12, NULL, NULL, 0, 0.00, NULL),
(18, 'HD-69BBAF8B65041', 'Lan Anh', 'volananh2k4@gmail.com', '0945999305', 'Phòng 103', 350000.00, 105000.00, 'deposited', NULL, 'bank', '2026-03-19 08:10:51', '2026-03-19 08:12:05', NULL, 34, '2026-03-20', '2026-03-21', '14:00:00', '12:00:00', 2, 0, 'checked_out', 'website', 350000, 0, NULL, NULL, 350000, 350000, NULL, NULL, NULL, 12, 12, 12, NULL, NULL, 0, 0.00, NULL),
(19, 'HD-69BBB39D5FCFE', 'admin', 'admin@gmail.com', '1', 'Mộng Mơ Room', 150000.00, 45000.00, 'deposited', NULL, 'bank', '2026-03-19 08:28:13', '2026-03-19 10:00:47', NULL, 6, '2026-03-03', '2026-03-04', '14:00:00', '12:00:00', 2, 1, 'cancelled', 'website', 150000, 0, NULL, NULL, 150000, 45000, NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-19 10:00:47', 'Khách yêu cầu hủy', 45000, 0.00, NULL),
(20, 'HD-69BBB4FF8563F', 'admin', 'admin@gmail.com', '1', 'NC Haven Homestay', 26000000.00, 7800000.00, 'deposited', NULL, 'bank', '2026-03-19 08:34:07', '2026-03-19 08:56:50', NULL, 35, '2026-03-19', '2026-04-01', '14:00:00', '12:00:00', 6, 4, 'checked_out', 'website', 26400000, 0, NULL, NULL, 26400000, 26400000, NULL, NULL, NULL, NULL, 12, 12, NULL, NULL, 0, 0.00, NULL),
(21, 'HD-69BBC28237062', 'admin', 'admin@gmail.com', '1', 'Phòng 102', 6000000.00, 1800000.00, 'deposited', NULL, 'bank', '2026-03-19 09:31:46', '2026-03-19 09:48:31', NULL, 33, '2026-03-19', '2026-03-31', '14:00:00', '12:00:00', 4, 1, 'checked_in', 'website', 6000000, 0, NULL, NULL, 6000000, 1800000, NULL, NULL, NULL, NULL, 12, NULL, NULL, NULL, 0, 0.00, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `booking_activities`
--

CREATE TABLE `booking_activities` (
  `id` bigint UNSIGNED NOT NULL,
  `booking_id` bigint UNSIGNED NOT NULL,
  `actor_id` bigint UNSIGNED DEFAULT NULL,
  `actor_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `action_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `old_value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `new_value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ;

--
-- Dumping data for table `booking_activities`
--

INSERT INTO `booking_activities` (`id`, `booking_id`, `actor_id`, `actor_name`, `action_type`, `old_value`, `new_value`, `description`, `created_at`) VALUES
(1, 5, NULL, 'System', 'checkin', NULL, NULL, 'Khách đã check-in thành công', '2026-03-13 15:31:25'),
(2, 7, NULL, 'System', 'checkin', NULL, NULL, 'Khách đã check-in thành công', '2026-03-15 10:00:38'),
(3, 8, NULL, 'System', 'checkin', NULL, NULL, 'Khách đã check-in thành công', '2026-03-15 10:25:51'),
(4, 8, NULL, 'System', 'checkin', NULL, NULL, 'Khách đã check-in thành công', '2026-03-15 10:27:16'),
(5, 8, NULL, 'System', 'status_changed', '{\"status\":\"checked_in\"}', '{\"status\":\"confirmed\"}', 'Trạng thái: Đã check-in → Đã xác nhận', '2026-03-15 10:27:49'),
(6, 8, NULL, 'System', 'status_changed', '{\"status\":\"confirmed\"}', '{\"status\":\"pending\"}', 'Trạng thái: Đã xác nhận → Chờ xác nhận', '2026-03-15 10:27:53'),
(7, 8, NULL, 'System', 'status_changed', '{\"status\":\"pending\"}', '{\"status\":\"no_show\"}', 'Trạng thái: Chờ xác nhận → No-show', '2026-03-15 10:27:55'),
(8, 8, NULL, 'System', 'status_changed', '{\"status\":\"no_show\"}', '{\"status\":\"confirmed\"}', 'Trạng thái: No-show → Đã xác nhận', '2026-03-15 10:28:38'),
(9, 9, NULL, 'System', 'checkin', NULL, NULL, 'Khách đã check-in thành công', '2026-03-15 10:45:24'),
(10, 10, NULL, 'System', 'cancelled', NULL, NULL, 'Booking hủy: Khách yêu cầu hủy', '2026-03-15 10:56:05'),
(11, 8, NULL, 'System', 'status_changed', '{\"status\":\"confirmed\"}', '{\"status\":\"pending\"}', 'Trạng thái: Đã xác nhận → Chờ xác nhận', '2026-03-15 10:57:55'),
(12, 8, NULL, 'System', 'status_changed', '{\"status\":\"pending\"}', '{\"status\":\"confirmed\"}', 'Trạng thái: Chờ xác nhận → Đã xác nhận', '2026-03-15 10:58:01'),
(13, 9, NULL, 'System', 'checkout', NULL, NULL, 'Khách đã check-out. Phòng chuyển sang bảo trì/dọn dẹp.', '2026-03-15 11:00:02'),
(14, 8, NULL, 'System', 'payment_added', NULL, NULL, 'Hoàn tiền 100,000đ qua Tiền mặt', '2026-03-15 11:04:30'),
(15, 11, NULL, 'System', 'checkin', NULL, NULL, 'Khách đã check-in thành công', '2026-03-15 18:18:11'),
(16, 11, NULL, 'System', 'checkout', NULL, NULL, 'Khách đã check-out. Phòng chuyển sang bảo trì/dọn dẹp.', '2026-03-15 18:20:24'),
(17, 13, NULL, 'System', 'status_changed', '{\"status\":\"pending\"}', '{\"status\":\"confirmed\"}', 'Trạng thái: Chờ xác nhận → Đã xác nhận', '2026-03-15 18:24:04'),
(18, 13, NULL, 'System', 'cancelled', NULL, NULL, 'Booking hủy: Khách yêu cầu hủy', '2026-03-15 18:24:17'),
(19, 12, NULL, 'System', 'checkin', NULL, NULL, 'Khách đã check-in thành công', '2026-03-15 18:24:39'),
(20, 12, NULL, 'System', 'room_transferred', '{\"room_id\":10}', '{\"room_id\":12}', 'Đổi phòng: #10 → #12. Lý do: Không rõ', '2026-03-15 18:25:16'),
(21, 13, NULL, 'System', 'payment_added', NULL, NULL, 'Thanh toán 420,000đ qua Tiền mặt', '2026-03-15 18:41:11'),
(22, 15, NULL, 'System', 'checkin', NULL, NULL, 'Khách đã check-in thành công', '2026-03-15 18:41:24'),
(23, 17, 12, 'admin', 'checkin', NULL, NULL, 'Khách đã check-in thành công', '2026-03-19 07:05:11'),
(24, 17, 12, 'admin', 'checkout', NULL, NULL, 'Khách đã check-out. Phòng chuyển sang bảo trì/dọn dẹp.', '2026-03-19 07:05:21'),
(25, 18, 12, 'admin', 'status_changed', '{\"status\":\"pending\"}', '{\"status\":\"confirmed\"}', 'Trạng thái: Chờ xác nhận → Đã xác nhận', '2026-03-19 08:11:52'),
(26, 18, 12, 'admin', 'checkin', NULL, NULL, 'Khách đã check-in thành công', '2026-03-19 08:11:59'),
(27, 18, 12, 'admin', 'checkout', NULL, NULL, 'Khách đã check-out. Phòng chuyển sang bảo trì/dọn dẹp.', '2026-03-19 08:12:06'),
(28, 20, 12, 'admin', 'checkin', NULL, NULL, 'Khách đã check-in thành công', '2026-03-19 08:48:47'),
(29, 20, 12, 'admin', 'checkout', NULL, NULL, 'Khách đã check-out. Phòng chuyển sang bảo trì/dọn dẹp.', '2026-03-19 08:56:53'),
(30, 21, 12, 'admin', 'checkin', NULL, NULL, 'Khách đã check-in thành công', '2026-03-19 09:48:31'),
(31, 19, 12, 'admin', 'cancelled', NULL, NULL, 'Booking hủy: Khách yêu cầu hủy', '2026-03-19 10:00:47'),
(33, 14, 12, 'admin', 'cancelled', NULL, NULL, 'Booking hủy: Overbooking', '2026-03-19 10:01:37');

-- --------------------------------------------------------

--
-- Table structure for table `booking_payments`
--

CREATE TABLE `booking_payments` (
  `id` bigint UNSIGNED NOT NULL,
  `booking_id` bigint UNSIGNED NOT NULL,
  `amount` decimal(15,0) NOT NULL,
  `payment_method` enum('cash','transfer','card') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'cash',
  `payment_type` enum('deposit','balance','refund') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'balance',
  `reference_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `note` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `recorded_by` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `booking_payments`
--

INSERT INTO `booking_payments` (`id`, `booking_id`, `amount`, `payment_method`, `payment_type`, `reference_code`, `note`, `recorded_by`, `created_at`, `updated_at`) VALUES
(9, 10, 8400000, 'transfer', 'refund', NULL, 'Hoàn tiền: Khách yêu cầu hủy', NULL, '2026-03-15 10:56:05', '2026-03-15 10:56:05'),
(12, 9, 280000, 'cash', 'balance', NULL, 'Thanh toán khi check-out', NULL, '2026-03-15 11:00:02', '2026-03-15 11:00:02'),
(13, 8, 100000, 'cash', 'refund', NULL, NULL, NULL, '2026-03-15 11:04:30', '2026-03-15 11:04:30'),
(14, 11, 1050000, 'cash', 'balance', NULL, 'Thanh toán khi check-out', NULL, '2026-03-15 18:20:20', '2026-03-15 18:20:20'),
(15, 13, 180000, 'transfer', 'refund', NULL, 'Hoàn tiền: Khách yêu cầu hủy', NULL, '2026-03-15 18:24:17', '2026-03-15 18:24:17'),
(16, 13, 420000, 'cash', 'balance', NULL, NULL, NULL, '2026-03-15 18:41:11', '2026-03-15 18:41:11'),
(17, 17, 1400000, 'cash', 'balance', NULL, 'Thanh toán khi check-out', 12, '2026-03-19 07:05:17', '2026-03-19 07:05:17'),
(18, 18, 245000, 'cash', 'balance', NULL, 'Thanh toán khi check-out', 12, '2026-03-19 08:12:05', '2026-03-19 08:12:05'),
(19, 20, 18600000, 'card', 'balance', NULL, 'Thanh toán khi check-out', 12, '2026-03-19 08:56:50', '2026-03-19 08:56:50'),
(20, 19, 45000, 'transfer', 'refund', NULL, 'Hoàn tiền: Khách yêu cầu hủy', 12, '2026-03-19 10:00:47', '2026-03-19 10:00:47');

-- --------------------------------------------------------

--
-- Table structure for table `booking_services`
--

CREATE TABLE `booking_services` (
  `id` bigint UNSIGNED NOT NULL,
  `booking_id` bigint UNSIGNED NOT NULL,
  `service_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `unit_price` decimal(15,0) NOT NULL DEFAULT '0',
  `quantity` smallint UNSIGNED NOT NULL DEFAULT '1',
  `total_price` decimal(15,0) NOT NULL DEFAULT '0',
  `note` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `jobs`
--

INSERT INTO `jobs` (`id`, `queue`, `payload`, `attempts`, `reserved_at`, `available_at`, `created_at`) VALUES
(1, 'default', '{\"uuid\":\"e1d72814-3c06-4b66-9b01-e51bb30dd7d9\",\"displayName\":\"App\\\\Jobs\\\\CleanRoomJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\CleanRoomJob\",\"command\":\"O:21:\\\"App\\\\Jobs\\\\CleanRoomJob\\\":2:{s:9:\\\"\\u0000*\\u0000roomId\\\";i:10;s:5:\\\"delay\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2026-03-15 19:00:02.731976\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:16:\\\"Asia\\/Ho_Chi_Minh\\\";}}\"}}', 0, NULL, 1773576002, 1773572402),
(2, 'default', '{\"uuid\":\"b53e8971-9f0e-4379-98d5-d7c7b346cd16\",\"displayName\":\"App\\\\Jobs\\\\CleanRoomJob\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Jobs\\\\CleanRoomJob\",\"command\":\"O:21:\\\"App\\\\Jobs\\\\CleanRoomJob\\\":2:{s:9:\\\"\\u0000*\\u0000roomId\\\";i:4;s:5:\\\"delay\\\";O:25:\\\"Illuminate\\\\Support\\\\Carbon\\\":3:{s:4:\\\"date\\\";s:26:\\\"2026-03-16 02:20:20.552933\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:16:\\\"Asia\\/Ho_Chi_Minh\\\";}}\"}}', 0, NULL, 1773602420, 1773598824);

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_100000_create_password_resets_table', 1),
(2, '2019_08_19_000000_create_failed_jobs_table', 1),
(3, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(4, '2014_10_12_000000_create_users_table', 2),
(5, '2026_03_09_112907_add_role_to_users_table', 3),
(7, '2026_03_09_163919_add_status_to_users_table', 4),
(9, '2026_03_11_143215_create_bookings_table', 5),
(10, '2026_03_13_030243_add_paid_at_to_bookings_table', 5),
(11, '2026_03_13_000001_create_bookings_table', 6),
(12, '2026_03_13_000002_create_booking_services_table', 6),
(13, '2026_03_13_000003_create_booking_payments_table', 6),
(14, '2026_03_13_000004_create_booking_activities_table', 6),
(15, '2026_03_13_000005_add_room_number_status_to_rooms_table', 6),
(16, '2026_03_15_164557_add_additional_fee_to_bookings_table', 7),
(17, '2026_03_15_165837_create_jobs_table', 8),
(18, '2026_03_16_150203_add_max_children_to_rooms_table', 9),
(19, '2026_03_16_151602_restructure_rooms_table', 10),
(20, '2026_03_16_225516_add_home_to_rent_type_enum', 11);

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

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
(59, 'App\\Models\\User', 15, 'auth_token', '5ae447b3f59abb4d60b4139c2c97807527aac7519441953887d5db3c885aa3b0', '[\"*\"]', NULL, NULL, '2026-03-13 04:00:41', '2026-03-13 04:00:41'),
(61, 'App\\Models\\User', 16, 'auth_token', '1979ddce9cf18b967c5bac476f5bd10ae7a44cfa016c5ee128cb9c372b700844', '[\"*\"]', NULL, NULL, '2026-03-15 09:27:31', '2026-03-15 09:27:31'),
(62, 'App\\Models\\User', 12, 'auth_token', 'cc77183d134b985abe3aadbfd94bf1854026994ae2f2e773e1abf24a5bdb7f6d', '[\"*\"]', NULL, NULL, '2026-03-16 10:20:24', '2026-03-16 10:20:24'),
(63, 'App\\Models\\User', 12, 'auth_token', 'd997207693f8d8544069edb076509747e71bdeede9a1f835b2e203dc46b1ee05', '[\"*\"]', NULL, NULL, '2026-03-18 12:30:17', '2026-03-18 12:30:17'),
(64, 'App\\Models\\User', 9, 'auth_token', '02fc82664114ef21c6e03759523489ce0a64585bb207374282404e03e318b4d3', '[\"*\"]', NULL, NULL, '2026-03-18 12:30:38', '2026-03-18 12:30:38'),
(66, 'App\\Models\\User', 12, 'auth_token', 'dae391bccc9a5168a9817a8782a5eca67b19dd85c0802e18cbdc7cf941cee99b', '[\"*\"]', NULL, NULL, '2026-03-18 18:14:42', '2026-03-18 18:14:42'),
(68, 'App\\Models\\User', 15, 'auth_token', 'c385dd6f74d5138c63765a65609dd72baccaaa1b38b09dff7860f702bb37cac6', '[\"*\"]', NULL, NULL, '2026-03-19 08:10:24', '2026-03-19 08:10:24'),
(69, 'App\\Models\\User', 12, 'auth_token', '8676b490205d480a186acec8f635b60b589687d4f65a86bfbc507a69e3481528', '[\"*\"]', '2026-03-19 10:01:37', NULL, '2026-03-19 08:11:13', '2026-03-19 10:01:37');

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

CREATE TABLE `reviews` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `room_id` int NOT NULL,
  `rating` int DEFAULT NULL,
  `comment` text COLLATE utf8mb4_general_ci,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rooms`
--

CREATE TABLE `rooms` (
  `id` int NOT NULL,
  `parent_id` bigint UNSIGNED DEFAULT NULL,
  `room_number` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `floor` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `location` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `type` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `rent_type` enum('whole_house','room_based','private_room','home') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'whole_house',
  `price` decimal(10,2) NOT NULL,
  `max_guests` int DEFAULT '2',
  `max_children` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `description` text COLLATE utf8mb4_general_ci,
  `status` varchar(20) COLLATE utf8mb4_general_ci DEFAULT 'available',
  `room_status` enum('available','occupied','dirty','out_of_order') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'available',
  `is_visible` tinyint(1) DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `room_status_updated_by` bigint UNSIGNED DEFAULT NULL,
  `out_of_order_reason` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `estimated_fix_date` date DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rooms`
--

INSERT INTO `rooms` (`id`, `parent_id`, `room_number`, `floor`, `title`, `location`, `type`, `rent_type`, `price`, `max_guests`, `max_children`, `description`, `status`, `room_status`, `is_visible`, `created_at`, `room_status_updated_by`, `out_of_order_reason`, `estimated_fix_date`, `updated_at`) VALUES
(1, NULL, NULL, NULL, 'Bình Minh Home', 'Quận Hải Châu, Đà Nẵng', 'house', 'whole_house', 1500000.00, 20, 99, NULL, 'available', 'available', 1, '2026-03-19 04:03:14', NULL, NULL, NULL, NULL),
(2, NULL, NULL, NULL, 'Hoàng Hôn Home', 'Quận Sơn Trà, Đà Nẵng', 'house', 'whole_house', 2000000.00, 20, 0, NULL, 'available', 'available', 1, '2026-03-19 04:03:14', NULL, NULL, NULL, NULL),
(3, NULL, NULL, NULL, 'Nhẹ Nhàng Home', 'Quận Thanh Khê, Đà Nẵng', 'house', 'whole_house', 1700000.00, 20, 0, NULL, 'available', 'available', 1, '2026-03-19 04:03:14', NULL, NULL, NULL, NULL),
(4, NULL, NULL, NULL, 'Yên Tĩnh Home', 'Quận Cẩm Lệ, Đà Nẵng', 'house', 'room_based', 2500000.00, 20, 0, NULL, 'available', 'available', 1, '2026-03-19 04:03:14', NULL, NULL, NULL, NULL),
(5, 5, NULL, NULL, 'Nhật Thực', 'Quận Liên Chiểu, Đà Nẵng', 'room', 'private_room', 120000.00, 2, 1, NULL, 'available', 'available', 1, '2026-03-19 04:03:14', NULL, NULL, NULL, NULL),
(6, 4, NULL, NULL, 'Mộng Mơ Room', 'Quận Cẩm Lệ, Đà Nẵng', 'room', 'private_room', 150000.00, 2, 1, NULL, 'available', 'available', 1, '2026-03-19 04:03:14', NULL, NULL, NULL, NULL),
(7, NULL, NULL, NULL, 'Mơ Màng Room', 'Quận Thanh Khê, Đà Nẵng', 'room', 'home', 150000.00, 2, 1, NULL, 'available', 'available', 1, '2026-03-19 04:03:14', NULL, NULL, NULL, NULL),
(8, NULL, NULL, NULL, 'Mộng Mị Room', 'Quận Hải Châu, Đà Nẵng', 'room', 'home', 200000.00, 2, 1, NULL, 'available', 'available', 1, '2026-03-19 04:03:14', NULL, NULL, NULL, NULL),
(9, NULL, NULL, NULL, 'Yên Tĩnh Room', 'Quận Sơn Trà, Đà Nẵng', 'room', 'home', 170000.00, 2, 1, NULL, 'available', 'available', 1, '2026-03-19 04:03:14', NULL, NULL, NULL, NULL),
(11, NULL, NULL, NULL, 'Mùa Thu Room', 'Quận Hải Châu, Đà Nẵng', 'room', 'home', 200000.00, 2, 1, NULL, 'available', 'available', 1, '2026-03-19 04:03:14', NULL, NULL, NULL, NULL),
(12, NULL, NULL, NULL, 'Đông Chí Room', 'Quận Liên Chiểu, Đà Nẵng', 'room', 'home', 160000.00, 2, 1, NULL, 'booked', 'available', 1, '2026-03-19 04:03:14', NULL, NULL, NULL, NULL),
(13, NULL, NULL, NULL, 'Bình Yên Room', 'Quận Ngũ Hành Sơn, Đà Nẵng', 'room', 'home', 170000.00, 2, 1, NULL, 'booked', 'available', 1, '2026-03-19 04:03:14', NULL, NULL, NULL, NULL),
(23, NULL, NULL, NULL, 'The Coastal Sanctuary', '93 Võ Nguyên Giáp , Mân Thái , Sơn Trà, Đà Nẵng', 'house', 'whole_house', 3500000.00, 15, 5, 'Chỗ ở\r\n🌿 Kết nối lại, thư giãn và trẻ hóa – Một hơi thở không khí trong lành\r\n\r\n★ Tại sao nên chọn khu nghỉ dưỡng riêng của chúng tôi thay vì một khu nghỉ dưỡng đông đúc?\r\nHãy tưởng tượng bạn thức dậy với âm thanh nhẹ nhàng của đại dương, bước ra ngoài để tập yoga riêng bên hồ bơi và biết rằng con bạn đang chơi an toàn chỉ cách đó vài bước chân. Tại một khu nghỉ dưỡng lớn, bạn chia sẻ những khoảnh khắc này với hàng trăm người lạ. Ở đây, nép mình tuyệt đẹp giữa bãi biển Cửa Đại và sông Thu Bồn, toàn bộ khu bảo tồn hiện đại này là của bạn 100%.\r\nChúng tôi hiểu rằng việc tìm kiếm một không gian vừa phục vụ cho sự nghỉ ngơi yên tĩnh của ông bà vừa phù hợp với năng lượng vui tươi của trẻ em là điều hiếm có. Đó là lý do tại sao chúng tôi tuyển chọn biệt thự này như một trải nghiệm được quản lý toàn diện, dễ dàng.', 'available', 'available', 1, '2026-03-18 16:27:58', NULL, NULL, NULL, NULL),
(24, NULL, NULL, NULL, 'Furama', 'Furama Resort Danang,105 Võ Nguyên Giáp, Mỹ An, Ngũ Hành Sơn, Đà Nẵng', 'house', 'whole_house', 4000000.00, 10, 2, 'Homestay thuộc khu nghỉ dưỡng Furama Resort 5 sao, ở trung tâm thành phố Đà Nẵng và có bãi biển riêng, tầm nhìn ra biển, yên tĩnh và công viên.\r\n* Khanh Villa nằm trong chuỗi Furama Villas Đà Nẵng - một khu phức hợp nghỉ dưỡng với các Homestay riêng 5 sao, đẳng cấp, mang đến những khoảnh khắc tuyệt vời.', 'available', 'available', 1, '2026-03-18 16:41:34', NULL, NULL, NULL, NULL),
(25, NULL, NULL, NULL, 'SONG CAT', '26 Nước Mặn 1 ,Khuê Mỹ, Ngũ Hành Sơn, Đà Nẵng', 'house', 'whole_house', 2800000.00, 10, 6, 'SONG CAT Homestay nằm ở khu vực Ngũ Hành Sơn của Đà Nẵng, cách Bãi biển Mỹ An 1,9 km, cách Bãi biển Mỹ Khê 1,9 km và cách Công viên Châu Á Đà Nẵng 3,4 km. Homestay này cách Ngũ Hành Sơn 5,1 km và cầu Sông Hàn 6 km.\r\n\r\nCầu Love Lock Đà Nẵng cách biệt thự 4,2 km, trong khi Bảo tàng Chăm cách 4,8 km. Sân bay gần nhất là Sân bay Quốc tế Đà Nẵng, cách Homestay SONG CAT 8 km.', 'available', 'available', 1, '2026-03-18 16:52:42', NULL, NULL, NULL, NULL),
(26, NULL, NULL, NULL, 'Hiếu Homestay', 'Phước Trường 7, An Hải, Sơn Trà, Đà Nẵng', 'house', 'room_based', 0.00, 20, 0, NULL, 'available', 'available', 1, '2026-03-18 16:58:18', NULL, NULL, NULL, NULL),
(27, 26, NULL, NULL, 'Phòng 101', 'Phước Trường 7, An Hải, Sơn Trà, Đà Nẵng', 'room', 'private_room', 350000.00, 2, 1, 'Vị trí lý tưởng – Gần biển, gần thiên nhiên\r\nHomestay toạ lạc trong một khu phố yên tĩnh – nơi bạn có thể tận hưởng không khí trong lành, cảnh quan xanh mát và chỉ mất vài phút đi bộ để đến bãi biển thơ mộng. Hãy bắt đầu buổi sáng bằng cách dạo biển, tham gia phiên chợ hải sản địa phương, hoặc đơn giản là thả mình trên cát và nghe tiếng sóng vỗ.', 'available', 'available', 1, '2026-03-18 17:02:26', NULL, NULL, NULL, NULL),
(28, 26, NULL, NULL, 'Phòng 102', 'Phước Trường 7, An Hải, Sơn Trà, Đà Nẵng', 'room', 'private_room', 350000.00, 2, 1, 'Vị trí lý tưởng – Gần biển, gần thiên nhiên\r\nHomestay toạ lạc trong một khu phố yên tĩnh – nơi bạn có thể tận hưởng không khí trong lành, cảnh quan xanh mát và chỉ mất vài phút đi bộ để đến bãi biển thơ mộng. Hãy bắt đầu buổi sáng bằng cách dạo biển, tham gia phiên chợ hải sản địa phương, hoặc đơn giản là thả mình trên cát và nghe tiếng sóng vỗ.', 'available', 'available', 1, '2026-03-18 17:05:14', NULL, NULL, NULL, NULL),
(29, 26, NULL, NULL, 'Phòng 103', 'Phước Trường 7, An Hải, Sơn Trà, Đà Nẵng', 'room', 'private_room', 450000.00, 4, 2, 'Vị trí lý tưởng – Gần biển, gần thiên nhiên\r\nHomestay toạ lạc trong một khu phố yên tĩnh – nơi bạn có thể tận hưởng không khí trong lành, cảnh quan xanh mát và chỉ mất vài phút đi bộ để đến bãi biển thơ mộng. Hãy bắt đầu buổi sáng bằng cách dạo biển, tham gia phiên chợ hải sản địa phương, hoặc đơn giản là thả mình trên cát và nghe tiếng sóng vỗ.', 'available', 'available', 1, '2026-03-18 17:07:20', NULL, NULL, NULL, NULL),
(30, NULL, NULL, NULL, 'Oristay', 'Oristay House Đà Nẵng, Hoàng Văn Thụ, Phước Ninh, Hải Châu, Đà Nẵng', 'room', 'home', 3000000.00, 4, 4, 'Homestay 🌿 này có 02 tầng riêng biệt. thiết kế đơn giản, ấm cúng. Khu vực xung quanh yên tĩnh, ngay trung tâm thành phố mang đến bầu không khí yên bình và dễ chịu. Tôi tin rằng khi bạn mới đến, bạn sẽ cảm thấy như đây thực sự là một nơi thoải mái và nhẹ nhàng để thư giãn.\r\n\r\n👨‍👩‍👦‍👦 Đó là một lựa chọn lý tưởng cho một nhóm bạn thân hoặc một gia đình nhỏ đang tìm kiếm một không gian riêng tư, thoải mái và ấm cúng để nghỉ ngơi, tụ tập hoặc chỉ đơn giản là tận hưởng thời gian chất lượng bên nhau. Với bố cục các phòng ngủ riêng biệt và khu vực chung rộng rãi, mọi người đều có thể tận hưởng cả sự riêng tư và kết nối.', 'available', 'available', 1, '2026-03-18 17:23:10', NULL, NULL, NULL, NULL),
(31, NULL, NULL, NULL, 'A Little Hoi An Homestay', 'Furama Resort Danang,50 Võ Nguyên Giáp, Mỹ An, Ngũ Hành Sơn, Đà Nẵng', 'house', 'room_based', 0.00, 20, 0, NULL, 'available', 'available', 1, '2026-03-18 17:36:54', NULL, NULL, NULL, NULL),
(32, 31, NULL, NULL, 'Phòng 101', 'Furama Resort Danang,50 Võ Nguyên Giáp, Mỹ An, Ngũ Hành Sơn, Đà Nẵng', 'room', 'private_room', 450000.00, 2, 1, 'Nằm trên bờ Sông Hoài, Little Hoi An Boutique Hotel & Spa cách Bãi biển Cửa Đại 4 km. Với Wi-Fi miễn phí, khách sạn này còn có hồ bơi ngoài trời cũng như tiệm làm tóc và làm đẹp cung cấp đầy đủ các liệu pháp spa.\r\n\r\nKhách có thể sử dụng đàn piano ở sảnh đợi. Ngoài ra, khách cũng có thể thư giãn cạnh quầy bar bên hồ bơi, tập thể dục tại trung tâm thể dục hay học cách nấu các món ăn Việt Nam chính thống. Nhân viên tại lễ tân 24 giờ có thể hỗ trợ khách các dịch vụ giặt là/ủi và dịch vụ phòng.\r\n\r\nCác phòng gắn máy điều hòa có sàn gỗ và được trang bị TV màn hình phẳng, bàn làm việc, minibar cũng như tiện nghi pha trà/cà phê. Phòng tắm riêng đi kèm góc tắm vòi sen mở và đồ vệ sinh cá nhân miễn phí.', 'available', 'available', 1, '2026-03-18 17:40:09', NULL, NULL, NULL, NULL),
(33, 31, NULL, NULL, 'Phòng 102', 'Furama Resort Danang,50 Võ Nguyên Giáp, Mỹ An, Ngũ Hành Sơn, Đà Nẵng', 'room', 'private_room', 500000.00, 4, 2, 'Nằm trên bờ Sông Hoài, Little Hoi An Boutique Hotel & Spa cách Bãi biển Cửa Đại 4 km. Với Wi-Fi miễn phí, khách sạn này còn có hồ bơi ngoài trời cũng như tiệm làm tóc và làm đẹp cung cấp đầy đủ các liệu pháp spa.\r\n\r\nKhách có thể sử dụng đàn piano ở sảnh đợi. Ngoài ra, khách cũng có thể thư giãn cạnh quầy bar bên hồ bơi, tập thể dục tại trung tâm thể dục hay học cách nấu các món ăn Việt Nam chính thống. Nhân viên tại lễ tân 24 giờ có thể hỗ trợ khách các dịch vụ giặt là/ủi và dịch vụ phòng.\r\n\r\nCác phòng gắn máy điều hòa có sàn gỗ và được trang bị TV màn hình phẳng, bàn làm việc, minibar cũng như tiện nghi pha trà/cà phê. Phòng tắm riêng đi kèm góc tắm vòi sen mở và đồ vệ sinh cá nhân miễn phí.', 'in_use', 'occupied', 1, '2026-03-18 17:41:11', 12, NULL, NULL, NULL),
(34, 31, NULL, NULL, 'Phòng 103', 'Furama Resort Danang,50 Võ Nguyên Giáp, Mỹ An, Ngũ Hành Sơn, Đà Nẵng', 'room', 'private_room', 350000.00, 2, 1, 'Nằm trên bờ Sông Hoài, Little Hoi An Boutique Hotel & Spa cách Bãi biển Cửa Đại 4 km. Với Wi-Fi miễn phí, khách sạn này còn có hồ bơi ngoài trời cũng như tiệm làm tóc và làm đẹp cung cấp đầy đủ các liệu pháp spa.\r\n\r\nKhách có thể sử dụng đàn piano ở sảnh đợi. Ngoài ra, khách cũng có thể thư giãn cạnh quầy bar bên hồ bơi, tập thể dục tại trung tâm thể dục hay học cách nấu các món ăn Việt Nam chính thống. Nhân viên tại lễ tân 24 giờ có thể hỗ trợ khách các dịch vụ giặt là/ủi và dịch vụ phòng.\r\n\r\nCác phòng gắn máy điều hòa có sàn gỗ và được trang bị TV màn hình phẳng, bàn làm việc, minibar cũng như tiện nghi pha trà/cà phê. Phòng tắm riêng đi kèm góc tắm vòi sen mở và đồ vệ sinh cá nhân miễn phí.', 'available', 'dirty', 1, '2026-03-18 17:42:42', 12, NULL, NULL, NULL),
(35, NULL, NULL, NULL, 'NC Haven Homestay', '21/6/5 Trần Đình Đàn, An Hải, Sơn Trà, Đà Nẵng', 'room', 'home', 2000000.00, 6, 4, '✨Đây không chỉ là một Homestay cho thuê, đây là \"ngôi nhà thứ hai\" của bạn được kiến tạo từ sự tận tâm, nơi mỗi góc nhỏ đều kể một câu chuyện về sự thư giãn và phong cách sống hiện đại. NC Haven Homestay là sự kết hợp hoàn hảo giữa thiết kế sang trọng và cảm giác ấm cúng như gia đình.✨\r\nChỗ ở\r\n🏡 NC Haven Homestay: Homestay 4 Tầng, Nâng Tầm Kỳ Nghỉ Đà Nẵng Của Bạn 💎\r\n\r\n🪴 Với phong cách Wabi-Sabi là triết lý thẩm mỹ tôn vinh vẻ đẹp của sự không hoàn hảo, tính vô thường và sự khiêm nhường. Phong cách này tập trung vào tính chân thật, đơn giản và dấu vết của thời gian.\r\n\r\nĐặc trưng là sử dụng màu sắc đất, trung tính, các vật liệu thô mộc tự nhiên (gỗ chưa xử lý, đất sét, vải lanh), cùng đổ vật có khiếm khuyết. Mục đích là tạo nên không gian yên bình, tối giản, và sâu lắng, chấp nhận sự không hoàn chỉnh.\r\n\r\n🍃 NC Haven Homestay – chốn nghỉ dưỡng lý tưởng, nơi kiến trúc hiện đại, sang trọng hòa quyện cùng sự tiện nghi tuyệt đối, được thổi hồn bởi đội ngũ kiến trúc sư uy tín hàng đầu Đà Nẵng.', 'available', 'dirty', 1, '2026-03-18 17:53:11', 12, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `room_amenities`
--

CREATE TABLE `room_amenities` (
  `room_id` int NOT NULL,
  `amenity_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `room_amenities`
--

INSERT INTO `room_amenities` (`room_id`, `amenity_id`) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 1),
(6, 1),
(7, 1),
(8, 1),
(9, 1),
(10, 1),
(11, 1),
(12, 1),
(13, 1),
(23, 1),
(4, 2),
(13, 2),
(18, 2),
(23, 2),
(1, 3),
(2, 3),
(3, 3),
(4, 3),
(5, 3),
(6, 3),
(7, 3),
(8, 3),
(9, 3),
(11, 3),
(12, 3),
(13, 3),
(23, 3),
(1, 4),
(2, 4),
(3, 4),
(4, 4),
(5, 4),
(8, 4),
(9, 4),
(10, 4),
(12, 4),
(13, 4),
(23, 4),
(1, 5),
(2, 5),
(3, 5),
(4, 5),
(5, 5),
(12, 5),
(13, 5),
(18, 5),
(23, 5),
(1, 6),
(2, 6),
(3, 6),
(4, 6),
(12, 6),
(23, 6),
(1, 7),
(2, 7),
(3, 7),
(4, 7),
(6, 7),
(11, 7),
(13, 7),
(1, 9),
(2, 9),
(3, 9),
(4, 9),
(5, 9),
(6, 9),
(7, 9),
(8, 9),
(9, 9),
(11, 9),
(12, 9),
(13, 9),
(1, 10),
(2, 10),
(3, 10),
(4, 10),
(5, 10),
(6, 10),
(7, 10),
(8, 10),
(11, 10),
(12, 10),
(13, 10);

-- --------------------------------------------------------

--
-- Table structure for table `room_images`
--

CREATE TABLE `room_images` (
  `id` int NOT NULL,
  `room_id` int NOT NULL,
  `image_url` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `is_primary` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `room_images`
--

INSERT INTO `room_images` (`id`, `room_id`, `image_url`, `is_primary`, `created_at`, `updated_at`) VALUES
(1, 1, '/storage/rooms/rAczJ9Bi1CuyQfSYNpZ6rtXefwmGAQYGT495auaZ.jpg', 1, NULL, '2026-03-19 04:13:31'),
(2, 2, '/storage/rooms/a49UGucMPLsKycZXnmnr6USlfyJOVsNfQYA38Lrb.jpg', 0, NULL, '2026-03-19 04:13:31'),
(3, 3, '/storage/rooms/qJq8BbKD0PXqxpD6vJjcIiWL9gmpuDcIxXHwxdDI.jpg', 1, NULL, '2026-03-19 04:13:31'),
(4, 6, '/storage/rooms/W2fDF1uBqddXy4AV2HPCqoCsSjWPhweZ5r9l9BBs.jpg', 0, NULL, '2026-03-19 04:13:31'),
(5, 6, '/storage/rooms/QTUiUEfgSUW02U3e8Rpdx4nbNifFCwZ5I0NaFCs4.jpg', 0, NULL, '2026-03-19 04:13:31'),
(6, 6, '/storage/rooms/ar7KCyyk6d3zKt6wc8kzRbOZmtD7YxOBOk2EawBR.jpg', 0, NULL, '2026-03-19 04:13:31'),
(7, 6, '/storage/rooms/7Q0wUufagjgJPdgaIuz6C5X9t3hmSJyWvswhWcBh.jpg', 0, NULL, '2026-03-19 04:13:31'),
(8, 6, '/storage/rooms/qbxqdi7gHut3Or4KnepN5BRqXxq12rRSGuou4qoR.jpg', 0, NULL, '2026-03-19 04:13:31'),
(9, 5, '/storage/rooms/nmUNFWoB3JWiGiZeQjM7Dg3tX5vUMvX1DCYb0V4R.jpg', 0, NULL, '2026-03-19 04:13:31'),
(10, 5, '/storage/rooms/swKwq0odtvTDPP6Jugflg5nR7eNNShohten0XMvY.jpg', 0, NULL, '2026-03-19 04:13:31'),
(11, 5, '/storage/rooms/X0ORAiyH8ly8HK0ulfT3XRMQ2aQj7riWB6S6Ukrp.jpg', 0, NULL, '2026-03-19 04:13:31'),
(12, 5, '/storage/rooms/bUAXKfi0MGqXBL5kCb4D7im11GViDcgHxLrOqPiT.jpg', 0, NULL, '2026-03-19 04:13:31'),
(13, 5, '/storage/rooms/HlnQdf4Njx60oDyWFbfDGZx9bDP0h5UlS4iSP7nj.jpg', 0, NULL, '2026-03-19 04:13:31'),
(14, 4, '/storage/rooms/EbU8zM57kWF3NYtwGXqUPL1uMUgx99UYYX1kdO5d.jpg', 0, NULL, '2026-03-19 04:13:31'),
(15, 4, '/storage/rooms/RiqGYOI5gQt7cx5DuVncQcSqKOIdt6NaVACrKvC2.jpg', 0, NULL, '2026-03-19 04:13:31'),
(16, 4, '/storage/rooms/DIXqJ3NJbpkkBsxngGY8KpqhB2qEy0tUHzLM5PpE.jpg', 0, NULL, '2026-03-19 04:13:31'),
(17, 4, '/storage/rooms/8W266cRutODVn6OLtEGJw5cKirfA5p8PqxqJGiYa.jpg', 0, NULL, '2026-03-19 04:13:31'),
(18, 4, '/storage/rooms/JosZ7WCMnCjsgpoGoFUb2NYMVVdfY73oDpvKswFI.jpg', 0, NULL, '2026-03-19 04:13:31'),
(19, 4, '/storage/rooms/ZzsDE8c99CXvWHJKRfPWOnLfJM1UzdBF9g2htrrr.jpg', 0, NULL, '2026-03-19 04:13:31'),
(20, 1, '/storage/rooms/87M6ACvv0WGKLuOdgPzMb1FjWxl3huWAMpBYIsDa.jpg', 0, NULL, '2026-03-19 04:13:31'),
(21, 1, '/storage/rooms/Zo2AYj8OjUFlTheO6j9jaDyPIq4sDzBGDrly5QmR.jpg', 0, NULL, '2026-03-19 04:13:31'),
(22, 1, '/storage/rooms/J5OncUO53E1YvaIuprltlGgUUlAWHsBYhnWG1DMz.jpg', 0, NULL, '2026-03-19 04:13:31'),
(23, 2, '/storage/rooms/R6wHUULqemsaqmueMhltjsax6dcsrIROPRepndlB.jpg', 0, NULL, '2026-03-19 04:13:31'),
(24, 2, '/storage/rooms/ojDr83WekgRoe49uLOBWjdF4bPMuaAOYbQUVhLVg.jpg', 0, NULL, '2026-03-19 04:13:31'),
(25, 2, '/storage/rooms/uC9F13LhL3EGU3GUlxH2GYfcVk3IrWlqw9sD8WGO.jpg', 0, NULL, '2026-03-19 04:13:31'),
(26, 2, '/storage/rooms/nV92asongYEyAa8QQS0Al2MddJxXouLjw00asGly.jpg', 0, NULL, '2026-03-19 04:13:31'),
(27, 13, '/storage/rooms/nRnU61VccNn4QdxtE3vp5CW4IEZXJ76Lev5lIABP.jpg', 0, NULL, '2026-03-19 04:13:31'),
(28, 12, '/storage/rooms/mVc4SBmArKowpoPFIw5ckSpta84cHswftvIayV1p.jpg', 0, NULL, '2026-03-19 04:13:31'),
(29, 11, '/storage/rooms/LZWdPRxbRC2083HWk03YhbURIfb0SVzjzSAgpXww.jpg', 0, NULL, '2026-03-19 04:13:31'),
(30, 9, '/storage/rooms/zMMHHeOz2kr7BhwdUNbarbPLcTMvoGQo6SGdyTyg.jpg', 0, NULL, '2026-03-19 04:13:31'),
(31, 8, '/storage/rooms/Osym9YGlca5FA0mWLq8u5JFgvSk0YXS5UZNV9Y6D.jpg', 0, NULL, '2026-03-19 04:13:31'),
(32, 23, '/storage/rooms/FGWmhU2LyPjHyjAtUyVi0NSYZtkCSGKaNKp9BZBS.avif', 0, NULL, NULL),
(33, 13, '/storage/rooms/KuUdReVlsbuv5teXSoFYhchiSaOuOoIdsvidxKmJ.jpg', 0, NULL, '2026-03-19 04:13:31'),
(34, 13, '/storage/rooms/ahAdCd6bSAvETnTO9HIILJcT5h3kGtvlN3rFjQM1.jpg', 0, NULL, '2026-03-19 04:13:31'),
(35, 12, '/storage/rooms/FY7WQQOm4l90j7fGNQ3pmhjMhDdNeoijsG0eUqfa.jpg', 0, NULL, '2026-03-19 04:13:31'),
(36, 12, '/storage/rooms/N3udTtUEzrIdGNu3tPj9eQanGKuG2O4OWghAw6HD.jpg', 0, NULL, '2026-03-19 04:13:31'),
(37, 11, '/storage/rooms/1JatbPRHfK6w3k7ilvkJFUkMdArbIjInuUTnoFgb.jpg', 0, NULL, '2026-03-19 04:13:31'),
(38, 11, '/storage/rooms/ZXMB4Vm4oH2rHU0KMCAoQF1RmJpeFwLOyaUS1oC2.jpg', 0, NULL, '2026-03-19 04:13:31'),
(39, 7, '/storage/rooms/dBHuJ3gAM1NaFJA40WdtS7Km1IyLIPUtfjzgmSlz.jpg', 0, NULL, '2026-03-19 04:13:31'),
(40, 7, '/storage/rooms/fHiuSSo4mrsiSRcpaTyl7dxhlYvrHJs9YQwLyacn.jpg', 0, NULL, '2026-03-19 04:13:31'),
(41, 7, '/storage/rooms/R46pBipBHisuPw0yCQm0UgsxplVQDEdTttsuNGZg.jpg', 0, NULL, '2026-03-19 04:13:31'),
(42, 8, '/storage/rooms/iPbGIxHS6Ocoz7lGltGgfbHC1cYaV5urojxxzE6n.jpg', 0, NULL, '2026-03-19 04:13:31'),
(43, 8, '/storage/rooms/XHjObHENAH7BdLzYcAWdLXHWpQ9volVHNyzSfWAw.jpg', 0, NULL, '2026-03-19 04:13:31'),
(44, 8, '/storage/rooms/PUHIYNL0GITk7PSA67pMtfUVsRXUY0rgd9DLYM4T.jpg', 0, NULL, '2026-03-19 04:13:31'),
(45, 9, '/storage/rooms/wNuMXT6lomQZ69DjyePQLwRWEZG32sYs4nQly3Vc.jpg', 0, NULL, '2026-03-19 04:13:31'),
(46, 9, '/storage/rooms/bWTUC1HRIoNDT3Qs25ZioUpxnzkN6USadK7QpuUF.jpg', 0, NULL, '2026-03-19 04:13:31'),
(47, 24, '/storage/rooms/JOB2PDTipeqp2S7SNCNcVKWhr2G47o14OkN02w5U.avif', 0, NULL, NULL),
(48, 24, '/storage/rooms/BgRv25RHH7QjhgwpuD0j2OV9wKYP5ZVpqLLUXy5K.avif', 0, NULL, NULL),
(49, 24, '/storage/rooms/z4Zzt2vVXF5s2P6QhmJEla5MIYfivSNDCuMLRrv2.avif', 0, NULL, NULL),
(50, 25, '/storage/rooms/OflC8UxrjTtTJIESvmaIcncKOBAuWSxVgRZj0Nly.avif', 1, NULL, NULL),
(51, 25, '/storage/rooms/AN8fJ5CbegkahhAdaJYvEnCKDFpxj9ifLPBLBBiG.avif', 0, NULL, NULL),
(52, 25, '/storage/rooms/V5drjTxjJAP1gjHZeif4sGrHWA80HqNY9saBJDjy.avif', 0, NULL, NULL),
(53, 25, '/storage/rooms/HbIuTNU4TfZU8BOajf0in1Fem60ZzBSbsekcEEXU.avif', 0, NULL, NULL),
(54, 25, '/storage/rooms/JZh3i7qpLYboHEmFOJdtkVWjfNDgBZkyHtl4IST0.avif', 0, NULL, NULL),
(55, 25, '/storage/rooms/h04pqFc4tnJcsf1kdEbDwz0Xt6puyvu0BcX67xCS.avif', 0, NULL, NULL),
(56, 25, '/storage/rooms/6KZb0BWvHjD2flVyU1MV0ZA6JEn0FTdhJmq6lZ6a.avif', 0, NULL, NULL),
(57, 25, '/storage/rooms/iLmEnZsFdPELmUh9qEZoGp0eGzzwsdjJ3WFGCDIe.avif', 0, NULL, NULL),
(58, 25, '/storage/rooms/Va6dJfs5KqQyfxAuLUWN1w4MRFYbSKp5caPRLteV.avif', 0, NULL, NULL),
(59, 25, '/storage/rooms/vB4ZwtvRHgTAAgOwGX6iUcw3y3APJOKJ7eeKHlma.avif', 0, NULL, NULL),
(60, 25, '/storage/rooms/eW8i5uVimmLrlpQMnPjUJOL0h00x7YiZTXUVbxep.avif', 0, NULL, NULL),
(62, 27, '/storage/rooms/OOyoFgiaSry0K9zLCFm0jnzil1sD7Jb1AZDcJdOp.avif', 0, NULL, NULL),
(63, 27, '/storage/rooms/8ou3zjAoLQ9CWHeNlQfVyn3BjlIUG5X9u8HlZyQQ.avif', 0, NULL, NULL),
(64, 27, '/storage/rooms/Y9Dzj0PIMNQBMFxJ8aqqKMxegMefbpiDfUtxhJjR.avif', 0, NULL, NULL),
(65, 27, '/storage/rooms/yDSXuHiUNq0F63T3d6BRltkaElOOAQgNPOF2GQ67.avif', 0, NULL, NULL),
(66, 27, '/storage/rooms/oiBc5G2lcQSzBPV0FpuXJtuMoYKmqhcmCpjMVq0l.avif', 0, NULL, NULL),
(67, 28, '/storage/rooms/baoqUXos31KurZXOFcvMCKrhxuqmMJXlkWfkK7le.avif', 1, NULL, NULL),
(68, 28, '/storage/rooms/rgC0lpURs86XpMHfQM3oIHFSW7mm1ZUZIfBGTnDZ.avif', 0, NULL, NULL),
(69, 28, '/storage/rooms/3rkUOCNAC20M2j8GQgqjbsL8y79pzrCSl296gL0W.avif', 0, NULL, NULL),
(70, 28, '/storage/rooms/swr7tcj4jzexi9g0khKhL0Y4nHSWhnhelS3Ebs9Z.avif', 0, NULL, NULL),
(71, 28, '/storage/rooms/Adc6ky35rDg0s9ku19e9cQ9o0Y2MrS4FIpqdIbd7.avif', 0, NULL, NULL),
(72, 28, '/storage/rooms/82VtnZQY3Vze9CqEBOLau4moNzcE5toqS93a4FXp.avif', 0, NULL, NULL),
(75, 29, '/storage/rooms/TWjdSKZU8lzqfjbCmCiBwbqkbWmU1YxD3qztI2uy.avif', 0, NULL, NULL),
(76, 29, '/storage/rooms/y2NTyEQH1YVJbVk4MDxT2g8OPZfYGvCSIcNnLVet.avif', 0, NULL, NULL),
(77, 29, '/storage/rooms/YqSVv3d49IUkbgn4aTpjnwTMotkz5vaoK6WXBwnx.avif', 0, NULL, NULL),
(78, 29, '/storage/rooms/tZ9iaFsvL6YFwazpdwH973hrrCbLQ5og4XVQuExQ.avif', 0, NULL, NULL),
(79, 30, '/storage/rooms/ZWZcBhTufbL0681kESD2cZasxMwBymqeOvAJeonQ.avif', 1, NULL, NULL),
(80, 30, '/storage/rooms/aYRM9gYkzdFQdTJE7gbZn6cQFJavUHjsLkQ1vxvc.avif', 0, NULL, NULL),
(81, 30, '/storage/rooms/KtAUQVHn2Cr4X69F0jbvJF5oyEsegp7eQ9BuiGhl.avif', 0, NULL, NULL),
(82, 30, '/storage/rooms/K4ZAUEAauOZAdYjehrl9TIYINSSa2OkpMU44pmsR.avif', 0, NULL, NULL),
(83, 30, '/storage/rooms/LNeamqatsXY3xEUobmFFbnwPnGUmXP6czlw6QZnb.avif', 0, NULL, NULL),
(84, 30, '/storage/rooms/0jbYCFK1VtitXbXYYXvUa9AsRMOCSgIw9tByBikY.avif', 0, NULL, NULL),
(85, 30, '/storage/rooms/qGw8E5THwUOPy6WbZDTwG0cDSo1JLOUNcUA1LrwP.avif', 0, NULL, NULL),
(87, 30, '/storage/rooms/9Vc9S7kaVu7U6vxykrt8MxnPF776m6EmSysC8xgX.avif', 0, NULL, NULL),
(88, 30, '/storage/rooms/jSb0anJAW562SJgMSXPz37FIH2HEsUcqRPGspPUt.avif', 0, NULL, NULL),
(89, 32, '/storage/rooms/K4AqBhsyJ5rWlonkrxJSP5KeFrighUuvF1GJ8K4B.jpg', 1, NULL, NULL),
(90, 32, '/storage/rooms/WHxtIeFfQkzTTaRsXNrMSqDsFpnPZwyI0oCocLhH.jpg', 0, NULL, NULL),
(91, 32, '/storage/rooms/MEtjYQbOhtWgnJr6QGXaLFNQYvRI1gp8uuCXwLCH.jpg', 0, NULL, NULL),
(92, 32, '/storage/rooms/6O8s1qBDI8pPkkc8wlDCwV5o93xJqk0tI93N0V3G.jpg', 0, NULL, NULL),
(93, 33, '/storage/rooms/5TpW7mKG7h4sgtL5xNiFjUKEgbnQlG0T0g3N5fw7.jpg', 1, NULL, NULL),
(94, 33, '/storage/rooms/nU4qtI9QDFSNQqSyUVCdhUveo3JAQO2T38g5XXN4.jpg', 0, NULL, NULL),
(95, 33, '/storage/rooms/ZuMFSY68aKucOxWYZAM8RLTTCuBNL7zeVIFInbrS.jpg', 0, NULL, NULL),
(97, 34, '/storage/rooms/yXfclzMnLrXDjuLZ9on3S3yIvnc9wjTDdeBezDy3.jpg', 0, NULL, NULL),
(98, 34, '/storage/rooms/NVia7nAi9i5dz6C4PPscLjGx3ZAg4ZNeVNeH45zx.jpg', 0, NULL, NULL),
(99, 34, '/storage/rooms/1Q0e0xDO1Dkq6SIYugeh21ZloQpXdbAYmakyjOm6.jpg', 0, NULL, NULL),
(100, 35, '/storage/rooms/HZUHTGVrvpk1igZlRPk6RSbyByaqDLHZ3c6HMBjy.avif', 1, NULL, NULL),
(101, 35, '/storage/rooms/S7W6o8ffVwTV0gpDnNBRJrGL4g0kvgDHiRvJycmA.avif', 0, NULL, NULL),
(102, 35, '/storage/rooms/SseKfv8LKVbQmuUOUD4WgS0UJMNF1MTrXENorNEc.avif', 0, NULL, NULL),
(103, 35, '/storage/rooms/TBjtUZOsXMRCAAPc5FVv2xP0GCmIuv7l9QK44ic8.avif', 0, NULL, NULL),
(104, 35, '/storage/rooms/TeBTD4MXAIinfGeKDqgWrPpBsFZ00T7rRMRp47IK.avif', 0, NULL, NULL),
(105, 35, '/storage/rooms/wqvRM6KNwCtKuB5CoJOEL5B7Ky7RbWfDiB0zfbB6.avif', 0, NULL, NULL),
(106, 35, '/storage/rooms/yHfmlIM9VSG0tXq6ZTOvhQzZvGvbkXSuwXH7VZ03.avif', 0, NULL, NULL),
(107, 35, '/storage/rooms/9KUhRhihAqgjoDT6dfEUbIgXytLtPronweSDiws3.avif', 0, NULL, NULL),
(108, 35, '/storage/rooms/A6nBhRV3fwejD48ZufLIVKlR0s9i3yuRbU27WMBe.avif', 0, NULL, NULL),
(109, 35, '/storage/rooms/tq0qoZTbIyrS5avk8VQgEEOyleTAOvCvHNHCjMnl.avif', 0, NULL, NULL),
(110, 35, '/storage/rooms/oE0QlVvip2AT2MBT8sI2PBuVFnE6PNsOh7pu87H0.avif', 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'customer',
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `role`, `status`, `phone`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(9, 'votronghieu1', 'tronghieuvo9@gmail.com', 'customer', 'active', '0906123931', NULL, '$2y$10$dJi7w3tzWfOIhT/U/kFjaeH35x.E1mBNt9696UisqLztctVQkfKx.', NULL, '2026-03-09 04:21:29', '2026-03-09 10:35:00'),
(12, 'admin', 'admin@gmail.com', 'admin', 'active', '1', NULL, '$2y$10$9VuzbFvDsHTLldawJA5SoucTImooB9VsjISTMpUmeyt/wYrQ/U0Z6', NULL, '2026-03-09 04:46:24', '2026-03-09 04:46:24'),
(13, 'votrong', 'tronghieuvo@gmail.com', 'customer', 'active', '0906123933', NULL, '$2y$10$lFOqdvuPcxxMfhziWSIqNOW40LcnaRb4GoOt6ggrCneK1wzUP6EOa', NULL, '2026-03-09 04:47:47', '2026-03-09 10:34:16'),
(14, 'anh ngu', 'anh@gmail.com', 'customer', 'active', '0906123333', NULL, '$2y$10$.VidHnEsUZhC4LiuP7qFcO3rWYBjYjjooNxF85AUYJ02m2kw9Rs0C', NULL, '2026-03-11 06:13:35', '2026-03-11 06:14:01'),
(15, 'Lan Anh', 'volananh2k4@gmail.com', 'customer', 'active', '0945999305', NULL, '$2y$10$OP9qeiy8GykRTZj8PUs4YevbDc6otBLYZauesw3sLl.VqTkNRMDOq', NULL, '2026-03-11 07:55:59', '2026-03-11 08:23:00'),
(16, 'pham duy', 'duy@gmail.com', 'customer', 'active', '0935824455', NULL, '$2y$10$F4auRGeC/e4IWKaMNkVCWut5b2C/.JqJPfhoL1J0fiZAuEiiD6dBO', NULL, '2026-03-15 09:27:20', '2026-03-15 09:27:20');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `amenities`
--
ALTER TABLE `amenities`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `bookings_booking_code_unique` (`booking_code`),
  ADD KEY `bookings_customer_id_foreign` (`customer_id`);

--
-- Indexes for table `booking_activities`
--
ALTER TABLE `booking_activities`
  ADD PRIMARY KEY (`id`),
  ADD KEY `booking_activities_booking_id_foreign` (`booking_id`),
  ADD KEY `booking_activities_actor_id_foreign` (`actor_id`);

--
-- Indexes for table `booking_payments`
--
ALTER TABLE `booking_payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `booking_payments_booking_id_foreign` (`booking_id`),
  ADD KEY `booking_payments_recorded_by_foreign` (`recorded_by`);

--
-- Indexes for table `booking_services`
--
ALTER TABLE `booking_services`
  ADD PRIMARY KEY (`id`),
  ADD KEY `booking_services_booking_id_foreign` (`booking_id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `room_id` (`room_id`);

--
-- Indexes for table `rooms`
--
ALTER TABLE `rooms`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `room_amenities`
--
ALTER TABLE `room_amenities`
  ADD PRIMARY KEY (`room_id`,`amenity_id`),
  ADD KEY `amenity_id` (`amenity_id`);

--
-- Indexes for table `room_images`
--
ALTER TABLE `room_images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `room_id` (`room_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `amenities`
--
ALTER TABLE `amenities`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `bookings`
--
ALTER TABLE `bookings`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `booking_activities`
--
ALTER TABLE `booking_activities`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `booking_payments`
--
ALTER TABLE `booking_payments`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `booking_services`
--
ALTER TABLE `booking_services`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=70;

--
-- AUTO_INCREMENT for table `reviews`
--
ALTER TABLE `reviews`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rooms`
--
ALTER TABLE `rooms`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `room_images`
--
ALTER TABLE `room_images`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=111;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bookings`
--
ALTER TABLE `bookings`
  ADD CONSTRAINT `bookings_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `booking_activities`
--
ALTER TABLE `booking_activities`
  ADD CONSTRAINT `booking_activities_actor_id_foreign` FOREIGN KEY (`actor_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `booking_activities_booking_id_foreign` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `booking_payments`
--
ALTER TABLE `booking_payments`
  ADD CONSTRAINT `booking_payments_booking_id_foreign` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `booking_payments_recorded_by_foreign` FOREIGN KEY (`recorded_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `booking_services`
--
ALTER TABLE `booking_services`
  ADD CONSTRAINT `booking_services_booking_id_foreign` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
