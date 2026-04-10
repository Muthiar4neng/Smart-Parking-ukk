-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 10 Apr 2026 pada 07.45
-- Versi server: 10.4.28-MariaDB
-- Versi PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_parkir_ukk`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `logs`
--

CREATE TABLE `logs` (
  `id` int(11) NOT NULL,
  `transaksi_id` int(11) DEFAULT NULL,
  `action` varchar(100) NOT NULL,
  `message` text DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `logs`
--

INSERT INTO `logs` (`id`, `transaksi_id`, `action`, `message`, `user_id`, `created_at`) VALUES
(1, NULL, 'CHECKIN', 'Check-in untuk kartu TAG001', 6, '2026-02-09 22:18:41'),
(2, NULL, 'CHECKOUT', 'Check-out untuk kartu TAG001, Durasi: 0 menit, Biaya: Rp0', 6, '2026-02-09 22:19:02'),
(3, NULL, 'CHECKIN', 'Check-in untuk kartu TAG002', 6, '2026-02-09 22:20:45'),
(4, NULL, 'CHECKOUT', 'Check-out untuk kartu TAG002, Durasi: 367 menit, Biaya: Rp14000', 6, '2026-02-09 22:27:49'),
(5, NULL, 'CHECKIN', 'Check-in untuk kartu TAG004', 6, '2026-02-09 22:29:01'),
(6, NULL, 'PAYMENT', 'Pembayaran diterima. Amount: Rp14000, Fee: Rp14000, Kembalian: Rp0', 6, '2026-02-09 23:25:56'),
(7, NULL, 'GATE_OPEN', 'Gerbang dibuka oleh petugas. Kendaraan: TAG002', 6, '2026-02-09 23:25:56'),
(8, NULL, 'CHECKIN', 'Check-in untuk kartu 00543', 6, '2026-02-10 09:01:09'),
(9, NULL, 'CHECKOUT', 'Check-out untuk kartu TAG004, Durasi: 633 menit, Biaya: Rp22000', 6, '2026-02-10 09:02:43'),
(10, NULL, 'PAYMENT', 'Pembayaran diterima. Amount: Rp22000, Fee: Rp22000, Kembalian: Rp0', 6, '2026-02-10 09:03:09'),
(11, NULL, 'GATE_OPEN', 'Gerbang dibuka oleh petugas. Kendaraan: TAG004', 6, '2026-02-10 09:03:09'),
(12, NULL, 'CHECKOUT', 'Check-out untuk kartu 00543, Durasi: 423 menit, Biaya: Rp16000', 6, '2026-02-10 16:04:24'),
(13, NULL, 'CHECKIN', 'Check-in untuk kartu TAG003', 6, '2026-02-11 08:07:01'),
(14, NULL, 'PAYMENT', 'Pembayaran diterima. Amount: Rp16000, Fee: Rp16000, Kembalian: Rp0', 6, '2026-02-11 08:07:20'),
(15, NULL, 'GATE_OPEN', 'Gerbang dibuka oleh petugas. Kendaraan: 00543', 6, '2026-02-11 08:07:20'),
(16, NULL, 'CHECKIN', 'Check-in untuk kartu TAG007', 6, '2026-02-11 08:38:16'),
(17, NULL, 'CHECKOUT', 'Check-out untuk kartu TAG007, Durasi: 1 menit, Biaya: Rp2000', 6, '2026-02-11 08:40:09'),
(18, NULL, 'PAYMENT', 'Pembayaran diterima. Amount: Rp2000, Fee: Rp2000, Kembalian: Rp0', 6, '2026-02-11 08:40:30'),
(19, NULL, 'GATE_OPEN', 'Gerbang dibuka oleh petugas. Kendaraan: TAG007', 6, '2026-02-11 08:40:30'),
(20, NULL, 'CHECKIN', 'Check-in untuk kartu TAG009', 6, '2026-02-11 22:38:15'),
(21, NULL, 'CHECKOUT', 'Check-out untuk kartu TAG003, Durasi: 871 menit, Biaya: Rp30000', 6, '2026-02-11 22:38:38'),
(22, NULL, 'PAYMENT', 'Pembayaran diterima. Amount: Rp0, Fee: Rp0, Kembalian: Rp0', 6, '2026-02-11 22:38:57'),
(23, NULL, 'GATE_OPEN', 'Gerbang dibuka oleh petugas. Kendaraan: TAG001', 6, '2026-02-11 22:38:57'),
(24, NULL, 'CHECKIN', 'Check-in untuk kartu TAG0010', 6, '2026-02-12 10:03:47'),
(25, NULL, 'CHECKOUT', 'Check-out untuk kartu TAG009, Durasi: 12615 menit, Biaya: Rp422000', 6, '2026-02-20 16:54:08'),
(26, NULL, 'CHECKIN', 'Check-in untuk kartu TEST123', 6, '2026-02-22 17:15:36'),
(27, NULL, 'CHECKIN', 'Check-in untuk kartu TEST001', 6, '2026-02-22 20:53:48'),
(28, NULL, 'CHECKOUT', 'Check-out untuk kartu TEST001, Durasi: 48 menit, Biaya: Rp10000', 6, '2026-02-22 21:42:31'),
(29, NULL, 'PAYMENT', 'Pembayaran Rp10000, Fee Rp10000, Kembalian Rp0', 6, '2026-02-22 21:44:28'),
(30, NULL, 'GATE_OPEN', 'Gerbang dibuka untuk kartu TEST001', 6, '2026-02-22 21:44:28'),
(31, NULL, 'CHECKIN', 'Check-in untuk kartu SLAY001', 6, '2026-02-22 22:48:53'),
(32, NULL, 'PAYMENT', 'Pembayaran Rp422000, Fee Rp422000, Kembalian Rp0', 6, '2026-02-22 22:49:27'),
(33, NULL, 'GATE_OPEN', 'Gerbang dibuka untuk kartu TAG009', 6, '2026-02-22 22:49:27'),
(34, NULL, 'CHECKIN', 'Check-in untuk kartu SLAY067', 6, '2026-02-22 22:53:37'),
(35, NULL, 'CHECKOUT', 'Check-out untuk kartu TAG0010, Durasi: 15170 menit, Biaya: Rp3034000', 6, '2026-02-22 22:54:30'),
(36, NULL, 'PAYMENT', 'Pembayaran Rp3034000, Fee Rp3034000, Kembalian Rp0', 6, '2026-02-22 22:56:39'),
(37, NULL, 'GATE_OPEN', 'Gerbang dibuka untuk kartu TAG0010', 6, '2026-02-22 22:56:39'),
(38, NULL, 'CHECKIN', 'Check-in untuk kartu TEST999', 6, '2026-02-23 22:54:42'),
(39, NULL, 'CHECKOUT', 'Check-out untuk kartu TEST999, Durasi: 318 menit, Biaya: Rp64000', 6, '2026-02-24 04:12:59'),
(40, NULL, 'CHECKOUT', 'Check-out untuk kartu TEST123, Durasi: 2098 menit, Biaya: Rp420000', 6, '2026-02-24 04:14:15'),
(41, NULL, 'PAYMENT', 'Pembayaran Rp420000, Fee Rp420000, Kembalian Rp0', 6, '2026-02-24 04:14:29'),
(42, NULL, 'GATE_OPEN', 'Gerbang dibuka untuk kartu TEST123', 6, '2026-02-24 04:14:29'),
(43, NULL, 'CHECKIN', 'Check-in untuk kartu TEST08007', 6, '2026-02-24 10:51:53'),
(44, NULL, 'CHECKIN', 'Check-in untuk kartu TEST004', 6, '2026-02-24 10:52:17'),
(45, NULL, 'CHECKOUT', 'Check-out untuk kartu SLAY001, Durasi: 2164 menit, Biaya: Rp434000', 6, '2026-02-24 10:52:54'),
(46, NULL, 'PAYMENT', 'Pembayaran Rp64000, Fee Rp64000, Kembalian Rp0', 6, '2026-02-24 10:53:08'),
(47, NULL, 'GATE_OPEN', 'Gerbang dibuka untuk kartu TEST999', 6, '2026-02-24 10:53:08'),
(48, NULL, 'PAYMENT', 'Pembayaran Rp30000, Fee Rp30000, Kembalian Rp0', 6, '2026-02-25 21:35:17'),
(49, NULL, 'GATE_OPEN', 'Gerbang dibuka untuk kartu TAG003', 6, '2026-02-25 21:35:17'),
(50, NULL, 'CHECKOUT', 'Check-out untuk kartu SLAY067, Durasi: 4243 menit, Biaya: Rp850000', 6, '2026-02-25 21:37:29'),
(51, NULL, 'PAYMENT', 'Pembayaran Rp434000, Fee Rp434000, Kembalian Rp0', 6, '2026-02-25 21:37:45'),
(52, NULL, 'GATE_OPEN', 'Gerbang dibuka untuk kartu SLAY001', 6, '2026-02-25 21:37:45'),
(53, NULL, 'CHECKOUT', 'Check-out untuk kartu TEST004, Durasi: 2088 menit, Biaya: Rp418000', 6, '2026-02-25 21:40:59'),
(54, NULL, 'PAYMENT', 'Pembayaran Rp418000, Fee Rp418000, Kembalian Rp0', 6, '2026-02-25 21:41:39'),
(55, NULL, 'GATE_OPEN', 'Gerbang dibuka untuk kartu TEST004', 6, '2026-02-25 21:41:39'),
(56, NULL, 'PAYMENT', 'Pembayaran Rp180500, Fee Rp180000, Kembalian Rp500', 6, '2026-03-09 20:20:07'),
(57, NULL, 'GATE_OPEN', 'Gerbang dibuka untuk kartu TEST08007', 6, '2026-03-09 20:20:07'),
(58, NULL, 'PAYMENT', 'Pembayaran Rp3000, Fee Rp3000, Kembalian Rp0', 6, '2026-03-10 09:31:09'),
(59, NULL, 'GATE_OPEN', 'Gerbang dibuka untuk kartu TAG1024', 6, '2026-03-10 09:31:09'),
(60, NULL, 'PAYMENT', 'Pembayaran Rp3000, Fee Rp3000, Kembalian Rp0', 6, '2026-03-13 16:02:51'),
(61, NULL, 'GATE_OPEN', 'Gerbang dibuka untuk kartu 1234', 6, '2026-03-13 16:02:51'),
(62, NULL, 'PAYMENT', 'Pembayaran Rp723000, Fee Rp723000, Kembalian Rp0', 6, '2026-03-23 21:45:43'),
(63, NULL, 'GATE_OPEN', 'Gerbang dibuka untuk kartu 11223344', 6, '2026-03-23 21:45:43'),
(64, NULL, 'PAYMENT', 'Pembayaran Rp3000, Fee Rp3000, Kembalian Rp0', 6, '2026-03-23 21:46:02'),
(65, NULL, 'GATE_OPEN', 'Gerbang dibuka untuk kartu 1234', 6, '2026-03-23 21:46:02'),
(66, NULL, 'PAYMENT', 'Pembayaran Rp3000, Fee Rp3000, Kembalian Rp0', 6, '2026-03-23 21:46:14'),
(67, NULL, 'GATE_OPEN', 'Gerbang dibuka untuk kartu TAG1117', 6, '2026-03-23 21:46:14'),
(68, NULL, 'PAYMENT', 'Pembayaran Rp726000, Fee Rp726000, Kembalian Rp0', 6, '2026-03-25 12:13:49'),
(69, NULL, 'GATE_OPEN', 'Gerbang dibuka untuk kartu 4112233', 6, '2026-03-25 12:13:49'),
(70, NULL, 'PAYMENT', 'Pembayaran Rp7899000, Fee Rp7899000, Kembalian Rp0', 6, '2026-03-25 17:45:00'),
(71, NULL, 'GATE_OPEN', 'Gerbang dibuka untuk kartu 1234', 6, '2026-03-25 17:45:00'),
(72, NULL, 'PAYMENT', 'Pembayaran Rp7851000, Fee Rp7851000, Kembalian Rp0', 6, '2026-03-27 21:40:54'),
(73, NULL, 'GATE_OPEN', 'Gerbang dibuka untuk kartu C0FFEE99', 6, '2026-03-27 21:40:54'),
(74, NULL, 'PAYMENT', 'Pembayaran Rp7902000, Fee Rp7902000, Kembalian Rp0', 6, '2026-04-01 12:27:03'),
(75, NULL, 'GATE_OPEN', 'Gerbang dibuka untuk kartu 55667788', 6, '2026-04-01 12:27:03'),
(76, NULL, 'PAYMENT', 'Pembayaran Rp726000, Fee Rp726000, Kembalian Rp0', 6, '2026-04-01 12:28:27'),
(77, NULL, 'GATE_OPEN', 'Gerbang dibuka untuk kartu 55667788', 6, '2026-04-01 12:28:27'),
(78, NULL, 'PAYMENT', 'Pembayaran Rp117000, Fee Rp117000, Kembalian Rp0', 6, '2026-04-01 12:29:50'),
(79, NULL, 'GATE_OPEN', 'Gerbang dibuka untuk kartu AABBCCDD', 6, '2026-04-01 12:29:50'),
(80, NULL, 'PAYMENT', 'Pembayaran Rp6000, Fee Rp6000, Kembalian Rp0', 6, '2026-04-03 10:04:59'),
(81, NULL, 'GATE_OPEN', 'Gerbang dibuka untuk kartu E9BF686', 6, '2026-04-03 10:04:59'),
(82, NULL, 'PAYMENT', 'Pembayaran Rp3000, Fee Rp3000, Kembalian Rp0', 6, '2026-04-03 10:08:16'),
(83, NULL, 'GATE_OPEN', 'Gerbang dibuka untuk kartu E7DD6A6', 6, '2026-04-03 10:08:16'),
(84, NULL, 'PAYMENT', 'Pembayaran Rp48000, Fee Rp48000, Kembalian Rp0', 6, '2026-04-03 10:20:40'),
(85, NULL, 'GATE_OPEN', 'Gerbang dibuka untuk kartu E9BF686', 6, '2026-04-03 10:20:40'),
(86, NULL, 'PAYMENT', 'Pembayaran Rp3000, Fee Rp3000, Kembalian Rp0', 6, '2026-04-03 10:46:00'),
(87, NULL, 'GATE_OPEN', 'Gerbang dibuka untuk kartu E9BF686', 6, '2026-04-03 10:46:00'),
(88, NULL, 'PAYMENT', 'Pembayaran Rp3000, Fee Rp3000, Kembalian Rp0', 6, '2026-04-03 11:09:44'),
(89, NULL, 'GATE_OPEN', 'Gerbang dibuka untuk kartu E9BF686', 6, '2026-04-03 11:09:44'),
(90, NULL, 'PAYMENT', 'Pembayaran Rp6000, Fee Rp6000, Kembalian Rp0', 6, '2026-04-03 11:29:11'),
(91, NULL, 'GATE_OPEN', 'Gerbang dibuka untuk kartu E9BF686', 6, '2026-04-03 11:29:11'),
(92, NULL, 'PAYMENT', 'Pembayaran Rp3000, Fee Rp3000, Kembalian Rp0', 6, '2026-04-03 11:35:45'),
(93, NULL, 'GATE_OPEN', 'Gerbang dibuka untuk kartu E9BF686', 6, '2026-04-03 11:35:45'),
(94, NULL, 'PAYMENT', 'Pembayaran Rp3000, Fee Rp3000, Kembalian Rp0', 6, '2026-04-03 11:36:31'),
(95, NULL, 'GATE_OPEN', 'Gerbang dibuka untuk kartu E9BF686', 6, '2026-04-03 11:36:31'),
(96, NULL, 'PAYMENT', 'Pembayaran Rp3000, Fee Rp3000, Kembalian Rp0', 6, '2026-04-03 11:53:18'),
(97, NULL, 'GATE_OPEN', 'Gerbang dibuka untuk kartu E9BF686', 6, '2026-04-03 11:53:18'),
(98, NULL, 'PAYMENT', 'Pembayaran Rp3000, Fee Rp3000, Kembalian Rp0', 6, '2026-04-03 12:05:25'),
(99, NULL, 'GATE_OPEN', 'Gerbang dibuka untuk kartu 4756F06', 6, '2026-04-03 12:05:25'),
(100, NULL, 'PAYMENT', 'Pembayaran Rp723000, Fee Rp723000, Kembalian Rp0', 6, '2026-04-03 12:09:45'),
(101, NULL, 'GATE_OPEN', 'Gerbang dibuka untuk kartu AABBCCDD', 6, '2026-04-03 12:09:45'),
(102, NULL, 'PAYMENT', 'Pembayaran Rp3000, Fee Rp3000, Kembalian Rp0', 6, '2026-04-03 12:10:33'),
(103, NULL, 'GATE_OPEN', 'Gerbang dibuka untuk kartu 4756F06', 6, '2026-04-03 12:10:33'),
(104, NULL, 'PAYMENT', 'Pembayaran Rp3000, Fee Rp3000, Kembalian Rp0', 6, '2026-04-07 13:09:03'),
(105, NULL, 'GATE_OPEN', 'Gerbang dibuka untuk kartu E2537', 6, '2026-04-07 13:09:03'),
(106, NULL, 'PAYMENT', 'Pembayaran Rp12000, Fee Rp12000, Kembalian Rp0', 6, '2026-04-07 13:36:47'),
(107, NULL, 'GATE_OPEN', 'Gerbang dibuka untuk kartu E2537', 6, '2026-04-07 13:36:47'),
(108, NULL, 'PAYMENT', 'Pembayaran Rp3000, Fee Rp3000, Kembalian Rp0', 6, '2026-04-07 13:39:52'),
(109, NULL, 'GATE_OPEN', 'Gerbang dibuka untuk kartu E2537', 6, '2026-04-07 13:39:52'),
(110, NULL, 'PAYMENT', 'Pembayaran Rp3000, Fee Rp3000, Kembalian Rp0', 6, '2026-04-07 13:43:28'),
(111, NULL, 'GATE_OPEN', 'Gerbang dibuka untuk kartu E2537', 6, '2026-04-07 13:43:28'),
(112, NULL, 'PAYMENT', 'Pembayaran Rp111000, Fee Rp111000, Kembalian Rp0', 6, '2026-04-07 14:13:55'),
(113, NULL, 'GATE_OPEN', 'Gerbang dibuka untuk kartu E2537', 6, '2026-04-07 14:13:55'),
(114, NULL, 'PAYMENT', 'Pembayaran Rp33000, Fee Rp33000, Kembalian Rp0', 6, '2026-04-07 14:23:37'),
(115, NULL, 'GATE_OPEN', 'Gerbang dibuka untuk kartu E2537', 6, '2026-04-07 14:23:37'),
(116, NULL, 'PAYMENT', 'Pembayaran Rp6000, Fee Rp6000, Kembalian Rp0', 6, '2026-04-07 14:30:09'),
(117, NULL, 'GATE_OPEN', 'Gerbang dibuka untuk kartu 77EA136', 6, '2026-04-07 14:30:09'),
(118, NULL, 'PAYMENT', 'Pembayaran Rp18063000, Fee Rp18063000, Kembalian Rp0', 6, '2026-04-07 14:45:45'),
(119, NULL, 'GATE_OPEN', 'Gerbang dibuka untuk kartu E7DD6A6', 6, '2026-04-07 14:45:45'),
(120, NULL, 'PAYMENT', 'Pembayaran Rp78000, Fee Rp78000, Kembalian Rp0', 6, '2026-04-07 15:04:07'),
(121, NULL, 'GATE_OPEN', 'Gerbang dibuka untuk kartu E9BF686', 6, '2026-04-07 15:04:07'),
(122, NULL, 'PAYMENT', 'Pembayaran Rp3000, Fee Rp3000, Kembalian Rp0', 6, '2026-04-07 15:04:46'),
(123, NULL, 'GATE_OPEN', 'Gerbang dibuka untuk kartu E2537', 6, '2026-04-07 15:04:46'),
(124, NULL, 'PAYMENT', 'Pembayaran Rp3000, Fee Rp3000, Kembalian Rp0', 6, '2026-04-07 15:05:38'),
(125, NULL, 'GATE_OPEN', 'Gerbang dibuka untuk kartu E9BF686', 6, '2026-04-07 15:05:38'),
(126, NULL, 'PAYMENT', 'Pembayaran Rp3000, Fee Rp3000, Kembalian Rp0', 6, '2026-04-08 09:52:06'),
(127, NULL, 'GATE_OPEN', 'Gerbang dibuka untuk kartu E2537', 6, '2026-04-08 09:52:06'),
(128, NULL, 'PAYMENT', 'Pembayaran Rp102000, Fee Rp102000, Kembalian Rp0', 6, '2026-04-08 11:37:23'),
(129, NULL, 'GATE_OPEN', 'Gerbang dibuka untuk kartu 4756F06', 6, '2026-04-08 11:37:23'),
(130, NULL, 'PAYMENT', 'Pembayaran Rp6000, Fee Rp6000, Kembalian Rp0', 6, '2026-04-08 12:46:49'),
(131, NULL, 'GATE_OPEN', 'Gerbang dibuka untuk kartu FEA66A6', 6, '2026-04-08 12:46:49'),
(132, 77, 'PAYMENT', 'Pembayaran Rp3000, Fee Rp3000, Kembalian Rp0', 6, '2026-04-08 13:18:40'),
(133, 77, 'GATE_OPEN', 'Gerbang dibuka untuk kartu 77EA136', 6, '2026-04-08 13:18:40'),
(134, 80, 'PAYMENT', 'Pembayaran Rp6000, Fee Rp2000 (1 jam), Kembalian Rp4000', 6, '2026-04-08 13:44:45'),
(135, 80, 'GATE_OPEN', 'Gerbang dibuka untuk kartu 4756F06', 6, '2026-04-08 13:44:45'),
(136, NULL, 'PAYMENT', 'Pembayaran Rp678000, Fee Rp678000, Kembalian Rp0', 6, '2026-04-08 13:51:16'),
(137, NULL, 'GATE_OPEN', 'Gerbang dibuka untuk kartu E9BF686', 6, '2026-04-08 13:51:16'),
(138, NULL, 'PAYMENT', 'Pembayaran Rp369000, Fee Rp369000, Kembalian Rp0', 6, '2026-04-08 13:53:46'),
(139, NULL, 'GATE_OPEN', 'Gerbang dibuka untuk kartu E2537', 6, '2026-04-08 13:53:46'),
(140, NULL, 'PAYMENT', 'Pembayaran Rp471000, Fee Rp471000, Kembalian Rp0', 6, '2026-04-08 14:16:34'),
(141, NULL, 'GATE_OPEN', 'Gerbang dibuka untuk kartu DB06C6', 6, '2026-04-08 14:16:34'),
(142, 83, 'PAYMENT', 'Pembayaran Rp42000, Fee Rp42000, Kembalian Rp0', 6, '2026-04-08 14:29:14'),
(143, 83, 'GATE_OPEN', 'Gerbang dibuka untuk kartu EAE227', 6, '2026-04-08 14:29:14'),
(144, 79, 'PAYMENT', 'Pembayaran Rp6000, Fee Rp6000, Kembalian Rp0', 6, '2026-04-08 14:32:51'),
(145, 79, 'GATE_OPEN', 'Gerbang dibuka untuk kartu E9BF686', 6, '2026-04-08 14:32:51'),
(146, NULL, 'PAYMENT', 'Pembayaran Rp9000, Fee Rp9000, Kembalian Rp0', 6, '2026-04-08 14:36:03'),
(147, NULL, 'GATE_OPEN', 'Gerbang dibuka untuk kartu E9BF686', 6, '2026-04-08 14:36:03'),
(148, NULL, 'PAYMENT', 'Pembayaran Rp861000, Fee Rp861000, Kembalian Rp0', 6, '2026-04-08 14:41:00'),
(149, NULL, 'GATE_OPEN', 'Gerbang dibuka untuk kartu E7DD6A6', 6, '2026-04-08 14:41:00'),
(150, 90, 'PAYMENT', 'Pembayaran Rp3000, Fee Rp3000, Kembalian Rp0', 6, '2026-04-09 13:08:56'),
(151, 90, 'GATE_OPEN', 'Gerbang dibuka untuk kartu 2DBB686', 6, '2026-04-09 13:08:56'),
(152, 91, 'PAYMENT', 'Pembayaran Rp108000, Fee Rp108000, Kembalian Rp0', 6, '2026-04-09 13:53:55'),
(153, 91, 'GATE_OPEN', 'Gerbang dibuka untuk kartu 2DBB686', 6, '2026-04-09 13:53:55'),
(154, 86, 'PAYMENT', 'Pembayaran Rp3000, Fee Rp3000, Kembalian Rp0', 6, '2026-04-09 13:56:30'),
(155, 86, 'GATE_OPEN', 'Gerbang dibuka untuk kartu EAE227', 6, '2026-04-09 13:56:30'),
(156, 92, 'PAYMENT', 'Durasi 1 jam | Bayar Rp18000 | Fee Rp2000 | Kembalian Rp16000', 6, '2026-04-09 15:47:39'),
(157, 92, 'GATE_OPEN', 'Gerbang dibuka untuk kartu 6980136', 6, '2026-04-09 15:47:39'),
(158, 89, 'PAYMENT', 'Durasi 1 jam | Bayar Rp72000 | Fee Rp2000 | Kembalian Rp70000', 6, '2026-04-10 09:01:03'),
(159, 89, 'GATE_OPEN', 'Gerbang dibuka untuk kartu 6980136', 6, '2026-04-10 09:01:03'),
(160, 97, 'PAYMENT', 'Durasi 1 jam | Bayar Rp2000 | Fee Rp2000 | Kembalian Rp0', 6, '2026-04-10 09:47:53'),
(161, 97, 'GATE_OPEN', 'Gerbang dibuka untuk kartu E7DD6A6', 6, '2026-04-10 09:47:53'),
(162, 96, 'PAYMENT', 'Durasi 1 jam | Bayar Rp2000 | Fee Rp2000 | Kembalian Rp0', 6, '2026-04-10 09:51:01'),
(163, 96, 'GATE_OPEN', 'Gerbang dibuka untuk kartu 4756F06', 6, '2026-04-10 09:51:01'),
(164, 95, 'PAYMENT', 'Durasi 3 jam | Bayar Rp6000 | Fee Rp6000 | Kembalian Rp0', 6, '2026-04-10 11:55:31'),
(165, 95, 'GATE_OPEN', 'Gerbang dibuka untuk kartu E9BF686', 6, '2026-04-10 11:55:31'),
(166, 100, 'PAYMENT', 'Durasi 1 jam | Bayar Rp2000 | Fee Rp2000 | Kembalian Rp0', 6, '2026-04-10 12:10:37'),
(167, 100, 'GATE_OPEN', 'Gerbang dibuka untuk kartu 2628F36', 6, '2026-04-10 12:10:37'),
(168, 102, 'PAYMENT', 'Durasi 1 jam | Bayar Rp2000 | Fee Rp2000 | Kembalian Rp0', 6, '2026-04-10 12:11:21'),
(169, 102, 'GATE_OPEN', 'Gerbang dibuka untuk kartu 2628F36', 6, '2026-04-10 12:11:21');

-- --------------------------------------------------------

--
-- Struktur dari tabel `transaksi`
--

CREATE TABLE `transaksi` (
  `id` int(11) NOT NULL,
  `card_id` varchar(100) NOT NULL,
  `nopol` varchar(15) DEFAULT NULL,
  `checkin_time` datetime DEFAULT NULL,
  `checkout_time` datetime DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  `fee` int(11) DEFAULT NULL,
  `status` enum('IN','OUT','DONE') NOT NULL DEFAULT 'IN',
  `created_at` datetime DEFAULT current_timestamp(),
  `paid_amount` int(11) DEFAULT NULL,
  `change_amount` int(11) DEFAULT NULL,
  `paid_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `transaksi`
--

INSERT INTO `transaksi` (`id`, `card_id`, `nopol`, `checkin_time`, `checkout_time`, `duration`, `fee`, `status`, `created_at`, `paid_amount`, `change_amount`, `paid_at`) VALUES
(77, '77EA136', 'B 7500 PBV', '2026-04-08 13:18:23', '2026-04-08 13:18:29', 1, 3000, 'DONE', '2026-04-08 13:18:23', 3000, 0, '2026-04-08 13:18:40'),
(79, 'E9BF686', 'B 8494 FOJ', '2026-04-08 13:36:56', '2026-04-08 13:38:03', 2, 6000, 'DONE', '2026-04-08 13:36:56', 6000, 0, '2026-04-08 14:32:51'),
(80, '4756F06', 'B 8295 QVW', '2026-04-08 13:37:35', '2026-04-08 13:39:27', 2, 2000, 'DONE', '2026-04-08 13:37:35', 6000, 4000, '2026-04-08 13:44:45'),
(83, 'EAE227', 'B 6087 JET', '2026-04-08 14:15:29', '2026-04-08 14:28:57', 14, 42000, 'DONE', '2026-04-08 14:15:29', 42000, 0, '2026-04-08 14:29:14'),
(85, 'EAE227', 'B 7995 WRA', '2026-04-08 14:32:02', '2026-04-08 14:32:32', 1, 3000, 'OUT', '2026-04-08 14:32:02', NULL, NULL, NULL),
(86, 'EAE227', 'B 1239 YFC', '2026-04-08 14:36:48', '2026-04-08 14:37:45', 1, 3000, 'DONE', '2026-04-08 14:36:48', 3000, 0, '2026-04-09 13:56:30'),
(87, 'E2537', 'B 7507 IHC', '2026-04-08 14:37:28', '2026-04-09 14:42:47', 1446, 4338000, 'OUT', '2026-04-08 14:37:28', NULL, NULL, NULL),
(89, '6980136', 'B 5760 FPG', '2026-04-09 12:59:57', '2026-04-09 13:23:35', 24, 72000, 'DONE', '2026-04-09 12:59:57', 72000, 70000, '2026-04-10 09:01:03'),
(90, '2DBB686', 'B 2486 RQI', '2026-04-09 13:08:14', '2026-04-09 13:08:35', 1, 3000, 'DONE', '2026-04-09 13:08:14', 3000, 0, '2026-04-09 13:08:56'),
(91, '2DBB686', 'B 1182 MKR', '2026-04-09 13:17:43', '2026-04-09 13:53:37', 36, 108000, 'DONE', '2026-04-09 13:17:43', 108000, 0, '2026-04-09 13:53:55'),
(92, '6980136', 'B 4405 DTR', '2026-04-09 13:50:44', '2026-04-09 13:55:53', 6, 18000, 'DONE', '2026-04-09 13:50:44', 18000, 16000, '2026-04-09 15:47:39'),
(94, '2DBB686', 'B 7021 MQL', '2026-04-09 14:42:34', '2026-04-09 14:44:02', 2, 6000, 'OUT', '2026-04-09 14:42:34', NULL, NULL, NULL),
(95, 'E9BF686', 'B 1094 QWB', '2026-04-10 09:21:58', '2026-04-10 11:55:14', 154, 6000, 'DONE', '2026-04-10 09:21:58', 6000, 0, '2026-04-10 11:55:31'),
(96, '4756F06', 'B 6081 LHF', '2026-04-10 09:22:10', '2026-04-10 09:46:58', 25, 2000, 'DONE', '2026-04-10 09:22:10', 2000, 0, '2026-04-10 09:51:01'),
(97, 'E7DD6A6', 'B 8846 MLT', '2026-04-10 09:30:59', '2026-04-10 09:47:36', 17, 2000, 'DONE', '2026-04-10 09:30:59', 2000, 0, '2026-04-10 09:47:53'),
(98, 'E7DD6A6', 'B 9233 GCF', '2026-04-10 09:48:43', NULL, NULL, NULL, 'IN', '2026-04-10 09:48:43', NULL, NULL, NULL),
(99, '4756F06', 'B 6298 NUN', '2026-04-10 10:29:50', NULL, NULL, NULL, 'IN', '2026-04-10 10:29:50', NULL, NULL, NULL),
(100, '2628F36', 'B 2797 XZQ', '2026-04-10 11:54:43', '2026-04-10 12:10:25', 16, 2000, 'DONE', '2026-04-10 11:54:43', 2000, 0, '2026-04-10 12:10:37'),
(101, 'FEA66A6', 'B 7155 GHA', '2026-04-10 12:10:10', NULL, NULL, NULL, 'IN', '2026-04-10 12:10:10', NULL, NULL, NULL),
(102, '2628F36', 'B 3375 AZB', '2026-04-10 12:11:05', '2026-04-10 12:11:14', 1, 2000, 'DONE', '2026-04-10 12:11:05', 2000, 0, '2026-04-10 12:11:21');

-- --------------------------------------------------------

--
-- Struktur dari tabel `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `level` varchar(20) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `user`
--

INSERT INTO `user` (`id`, `nama`, `username`, `password`, `level`, `created_at`) VALUES
(5, '1', '1', '1', 'admin', '2026-02-08 20:43:00'),
(6, '2', '2', '2', 'pegawai', '2026-02-08 20:43:00'),
(7, '3', '3', '3', 'pengurus', '2026-02-08 20:43:00'),
(9, 'nichole', 'zefanya', '1', 'pengurus', '2026-02-09 23:33:31'),
(10, 'muthiara', 'muthiwa', '123', 'pengurus', '2026-02-11 22:34:32'),
(11, 'zippu', 'piwa', '123', 'admin', '2026-02-25 18:22:14'),
(13, 'ten', 'chitapon', '238', 'admin', '2026-03-25 13:26:26'),
(14, 'teezu', 'tiny', '1024', 'pegawai', '2026-03-26 23:38:15');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `logs`
--
ALTER TABLE `logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `transaksi_id` (`transaksi_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indeks untuk tabel `transaksi`
--
ALTER TABLE `transaksi`
  ADD PRIMARY KEY (`id`),
  ADD KEY `status` (`status`),
  ADD KEY `card_id` (`card_id`);

--
-- Indeks untuk tabel `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `logs`
--
ALTER TABLE `logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=170;

--
-- AUTO_INCREMENT untuk tabel `transaksi`
--
ALTER TABLE `transaksi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=103;

--
-- AUTO_INCREMENT untuk tabel `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `logs`
--
ALTER TABLE `logs`
  ADD CONSTRAINT `logs_ibfk_1` FOREIGN KEY (`transaksi_id`) REFERENCES `transaksi` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `logs_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
