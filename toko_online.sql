-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 18, 2025 at 01:17 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `toko_online`
--

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `id` int(11) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `alamat` varchar(255) NOT NULL,
  `no_telepon` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`id`, `nama`, `alamat`, `no_telepon`) VALUES
(1, 'Umum', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `kategori`
--

CREATE TABLE `kategori` (
  `id` int(11) NOT NULL,
  `slug` varchar(50) DEFAULT NULL,
  `nama` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `kategori`
--

INSERT INTO `kategori` (`id`, `slug`, `nama`) VALUES
(1, 'makanan', 'Makanan'),
(2, 'minuman', 'Minuman');

-- --------------------------------------------------------

--
-- Table structure for table `order`
--

CREATE TABLE `order` (
  `id` int(11) NOT NULL,
  `tanggal` datetime NOT NULL DEFAULT current_timestamp(),
  `customer` int(11) NOT NULL,
  `total` decimal(10,0) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order`
--

INSERT INTO `order` (`id`, `tanggal`, `customer`, `total`) VALUES
(1, '2025-10-07 19:06:39', 1, 20000),
(2, '2025-10-07 15:45:00', 0, 560000),
(3, '2025-10-07 15:45:00', 0, 560000),
(4, '2025-10-07 15:45:00', 2, 560000),
(5, '2025-10-07 15:45:00', 2, 560000),
(6, '2025-10-07 15:45:00', 5, 560000),
(7, '2025-10-07 15:45:00', 5, 560000),
(8, '2025-10-07 15:45:00', 5, 560000),
(9, '2025-10-07 15:45:00', 5, 560000),
(10, '2025-10-07 15:45:00', 5, 560000),
(11, '2025-10-07 15:45:00', 5, 560000),
(12, '2025-10-07 15:45:00', 5, 560000),
(13, '2025-10-07 15:45:00', 5, 560000),
(14, '2025-10-07 15:45:00', 5, 560000),
(15, '2025-10-07 15:45:00', 5, 560000),
(16, '2025-10-07 15:45:00', 5, 560000),
(17, '2025-10-07 15:45:00', 5, 560000),
(18, '2025-10-07 15:45:00', 5, 560000),
(19, '2025-10-07 15:45:00', 5, 560000),
(20, '2025-10-07 15:45:00', 5, 560000),
(21, '2025-10-07 15:45:00', 5, 560000),
(22, '2025-10-07 15:45:00', 9, 800000),
(23, '2025-10-07 15:45:00', 9, 800000),
(24, '2025-10-07 15:45:00', 10, 800000),
(25, '2025-10-07 15:45:00', 11, 800000),
(26, '2025-10-07 15:45:00', 12, 800000),
(27, '2025-10-07 15:45:00', 12, 800000);

-- --------------------------------------------------------

--
-- Table structure for table `order_details`
--

CREATE TABLE `order_details` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `produk_id` int(11) NOT NULL,
  `price` decimal(10,0) NOT NULL,
  `qty` int(11) NOT NULL,
  `diskon` decimal(10,0) NOT NULL DEFAULT 0,
  `sub_total` decimal(10,0) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_details`
--

INSERT INTO `order_details` (`id`, `order_id`, `produk_id`, `price`, `qty`, `diskon`, `sub_total`) VALUES
(2, 1, 1, 10000, 1, 0, 10000),
(3, 1, 2, 5000, 2, 0, 10000),
(4, 3, 0, 200000, 1, 0, 200000),
(5, 3, 0, 180000, 2, 0, 360000),
(6, 4, 0, 200000, 1, 0, 200000),
(7, 4, 0, 180000, 2, 0, 360000),
(8, 5, 0, 200000, 1, 0, 200000),
(9, 5, 0, 180000, 2, 0, 360000),
(10, 6, 0, 200000, 1, 0, 200000),
(11, 6, 0, 180000, 2, 0, 360000),
(12, 7, 0, 200000, 1, 0, 200000),
(13, 7, 0, 180000, 2, 0, 360000),
(14, 8, 0, 200000, 1, 0, 200000),
(15, 8, 0, 180000, 2, 0, 360000),
(16, 9, 0, 200000, 1, 0, 200000),
(17, 9, 0, 180000, 2, 0, 360000),
(18, 11, 5, 0, 1, 0, 0),
(19, 11, 6, 0, 2, 0, 0),
(20, 12, 5, 0, 1, 0, 0),
(21, 12, 6, 0, 2, 0, 0),
(22, 13, 5, 0, 1, 0, 0),
(23, 13, 6, 0, 2, 0, 0),
(24, 14, 5, 0, 1, 0, 0),
(25, 14, 6, 0, 2, 0, 0),
(26, 15, 5, 0, 1, 0, 0),
(27, 15, 6, 0, 2, 0, 0),
(28, 16, 5, 0, 1, 0, 0),
(29, 16, 6, 0, 2, 0, 0),
(30, 17, 5, 0, 1, 0, 0),
(31, 17, 6, 0, 2, 0, 0),
(32, 18, 5, 0, 1, 0, 0),
(33, 18, 6, 0, 2, 0, 0),
(34, 20, 5, 2500, 1, 0, 2500),
(35, 20, 6, 1500, 2, 0, 3000),
(36, 21, 5, 2500, 1, 0, 2500),
(37, 21, 6, 1500, 2, 0, 3000),
(38, 22, 0, 200000, 1, 0, 200000),
(39, 22, 0, 180000, 2, 0, 360000),
(40, 23, 7, 10000, 1, 0, 10000),
(41, 23, 7, 10000, 2, 0, 20000),
(42, 25, 7, 10000, 1, 0, 10000),
(43, 25, 6, 1500, 2, 0, 3000),
(44, 27, 5, 2500, 1, 0, 2500),
(45, 27, 6, 1500, 2, 0, 3000);

-- --------------------------------------------------------

--
-- Table structure for table `produk`
--

CREATE TABLE `produk` (
  `id` int(11) NOT NULL,
  `kategori_id` int(11) DEFAULT NULL,
  `nama` varchar(255) DEFAULT NULL,
  `harga` double DEFAULT NULL,
  `foto` varchar(255) DEFAULT NULL,
  `detail` text DEFAULT NULL,
  `ketersediaan_stok` enum('habis','tersedia') DEFAULT 'tersedia'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `produk`
--

INSERT INTO `produk` (`id`, `kategori_id`, `nama`, `harga`, `foto`, `detail`, `ketersediaan_stok`) VALUES
(5, 1, 'Indomie', 2500, 'foto1.jpg', 'mie instan........', 'tersedia'),
(6, 2, 'yakult', 1500, 'foto2.jpg', 'yakult.....', 'tersedia'),
(7, 1, 'Astor', 10000, 'foto3.jpg', 'AStor..........', 'tersedia'),
(8, 2, 'ABC Kopi SUSU', 5000, 'foto5.jpg', 'kopi..........', 'tersedia');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`) VALUES
(1, 'admin', 'admin'),
(2, 'admin', 'admin');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `kategori`
--
ALTER TABLE `kategori`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `order`
--
ALTER TABLE `order`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `order_details`
--
ALTER TABLE `order_details`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `produk`
--
ALTER TABLE `produk`
  ADD PRIMARY KEY (`id`),
  ADD KEY `nama` (`nama`),
  ADD KEY `kategori_produk` (`kategori_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `kategori`
--
ALTER TABLE `kategori`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `order`
--
ALTER TABLE `order`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `order_details`
--
ALTER TABLE `order_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `produk`
--
ALTER TABLE `produk`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `produk`
--
ALTER TABLE `produk`
  ADD CONSTRAINT `kategori_produk` FOREIGN KEY (`kategori_id`) REFERENCES `kategori` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
