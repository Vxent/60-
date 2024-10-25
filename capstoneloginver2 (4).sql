-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 25, 2024 at 11:55 AM
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
-- Database: `capstoneloginver2`
--

-- --------------------------------------------------------

--
-- Table structure for table `audit_log`
--

CREATE TABLE `audit_log` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `action` varchar(255) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `audit_log`
--

INSERT INTO `audit_log` (`id`, `user_id`, `action`, `timestamp`) VALUES
(1, 2, 'User registered', '2024-10-03 07:24:02'),
(2, 3, 'User registered', '2024-10-04 05:29:24'),
(3, 4, 'User registered', '2024-10-04 22:02:43'),
(4, 5, 'User registered', '2024-10-04 22:27:30'),
(5, 6, 'User registered', '2024-10-04 22:41:03'),
(6, 7, 'User registered', '2024-10-04 22:45:27'),
(7, 8, 'User registered', '2024-10-07 06:26:47'),
(8, 9, 'User registered', '2024-10-10 13:20:05'),
(9, 10, 'User registered', '2024-10-11 12:03:10'),
(10, 11, 'User registered', '2024-10-11 12:12:36'),
(11, 12, 'User registered', '2024-10-22 07:33:34'),
(12, 13, 'User registered', '2024-10-25 07:17:14'),
(13, 14, 'User registered', '2024-10-25 07:18:47'),
(14, 15, 'User registered', '2024-10-25 09:44:03');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `order_date` datetime DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `facebook_account` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `product_id`, `order_date`, `status`, `facebook_account`) VALUES
(13, 14, 5, '2024-10-25 17:14:32', 'Pending', 'xent lee'),
(14, 2, 11, '2024-10-25 17:16:16', 'Pending', 'lester'),
(15, 15, 13, '2024-10-25 17:46:07', 'Delivery', 'Vincent Lee Tiongco');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `date_created` datetime DEFAULT current_timestamp(),
  `date_updated` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `size` enum('S','M','L','XL','XXL') DEFAULT NULL,
  `stock` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `description`, `price`, `image_url`, `date_created`, `date_updated`, `size`, `stock`) VALUES
(5, 'random', 'random', 200.00, 'uploads/vector-creative-login-ui-template-form-design-with-technology-style-bac.jpg', '2024-10-07 17:48:11', '2024-10-25 17:14:22', 'L', 0),
(6, 'Boston Jersey Cool', 'Best For Basketball', 500.00, 'uploads/vector-creative-login-ui-template-form-design-with-technology-style-bac.jpg', '2024-10-07 19:33:32', '2024-10-25 17:18:16', 'XXL', 0),
(7, 'golden state jersey', 'steph curry', 500.00, 'uploads/Group 34.png', '2024-10-08 14:10:38', '2024-10-11 22:11:07', 'S', 1),
(8, 'vasdas', 'ASDAS', 500.00, 'uploads/3d.png', '2024-10-08 14:14:43', '2024-10-25 17:19:16', NULL, 0),
(9, 'BABABABA', 'BABA', 50.00, 'uploads/vector-creative-login-ui-template-form-design-with-technology-style-bac.jpg', '2024-10-08 15:40:19', '2024-10-11 22:10:53', 'L', 1),
(10, 'New JErsey 2025', 'Nba legend', 250.00, 'uploads/download 7.png', '2024-10-10 22:51:32', '2024-10-10 22:51:32', NULL, 1),
(11, 'LEster kabiling', 'fannuy noob', 10.00, 'uploads/download 7.png', '2024-10-10 23:05:58', '2024-10-25 17:15:58', NULL, 0),
(12, 'lester mang iinom', 'kabiling', 10.00, 'uploads/download 8.png', '2024-10-10 23:07:16', '2024-10-10 23:07:16', NULL, 1),
(13, 'jbrian jersey', 'asdb', 123.00, 'uploads/download 8.png', '2024-10-11 00:27:45', '2024-10-25 17:45:54', NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `contact_no` varchar(15) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `role` enum('user','admin') DEFAULT 'user',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `contact_no`, `address`, `role`, `created_at`) VALUES
(1, 'admin', 'admin@example.com', '$2y$10$Ybf2sYi4/zrWBpqAJZ5Bne666NBwFJqgnPHoTiJk/Mx4Dso5.s.4q', NULL, NULL, 'admin', '2024-10-03 06:56:10'),
(2, 'UserCent', 'UserCent@gmail.com', '$2y$10$ScQLAyRo0/iqKjFMzsrRPecPR1b9sU34dfLurTeS2o3hcy403uhLi', '12345678912', 'Lubao', 'user', '2024-10-03 07:24:02'),
(3, 'adsasd', 'asdn@gmail.com', '$2y$10$l4RTS2patHBpcVSG.4Mf2OOPyg8CjKRWEGATon/0J.6yBPd2UceG6', '12345678912', '123123', 'user', '2024-10-04 05:29:24'),
(4, 'UserRamJay', 'UserRamJay@gmail.com', '$2y$10$.KbUKG32IZTk47lHVEyTuug3UdP3IXfBxlivYv2S.CVS6aezIRueK', '12345678913', 'FloridaBlanca', 'user', '2024-10-04 22:02:43'),
(5, 'UchihaTom', 'UchihaTom@yahoo.com', '$2y$10$HZ9DhJ4D8pd/Im/aqseWZuZNl9Z.YVdZK4basmk1OVfIhatGLdfaC', '09194399821', 'Konohagakure', 'user', '2024-10-04 22:27:30'),
(6, 'SenjuJerry', 'SenjuJerry@yahoo.com', '$2y$10$vVOu9mmNEquGced.PFHUqOTg5hxYjUua3QIF2EN.ZmhmrPWEKi/z6', '09856643781', 'Konohagakure', 'user', '2024-10-04 22:41:03'),
(7, 'AngryBird', 'AngryBird@yahoo.com', '$2y$10$Mzqqk0SLbw9BW/kicT29FuOzSPQ/ZslUiAwSCgNN/BzRd6Lk26iFW', '1234565432', 'Bird Island', 'user', '2024-10-04 22:45:27'),
(8, 'lee', 'lee@gmail.com', '$2y$10$HzrcdBNLmigyBocz.Dlkh.EcDgHIDojSxQeFyjvK9sM2GBtlGVRk.', '091123124324', 'aweqw', 'user', '2024-10-07 06:26:47'),
(9, 'lester', 'lester.kabilng@gmail.com', '$2y$10$0pr67fUtv3Q6m.PwvNLl3exkQLj0u3/pxP/U7HXOF0lPNSYFyGg3C', '', '', 'user', '2024-10-10 13:20:05'),
(10, 'kweenp', 'qwe@gmail.com', '$2y$10$ArLOGvTc4.9Zw9jIoWSkj.C1eKHjiOC.WNMSvIVHRax8boTH/PdNi', '091232312312', 'sp12', 'user', '2024-10-11 12:03:10'),
(11, 'jbrian', 'jb@gmail.com', '$2y$10$hpBWbnk8vzSpsyhGl8eli.urLfDsz.ZMaBZzkZoZMJ.sFw1sFU5Hu', '091123124324', 'asdasewq', 'user', '2024-10-11 12:12:36'),
(12, 'luffy05g0', 'asd@gmail.com', '$2y$10$/mUQasd6nmftYDqEakuwdOHc2r.qU.nR6yrz91ZHKU2nize3NMgNa', '12345678912', 'qweqwe', 'user', '2024-10-22 07:33:34'),
(13, 'kristinabagyo', 'kristinabagyo@email.com', '$2y$10$Rwg7dBHOqrVA7DGyVd2CM.J2KMbjLVtIy9bXlaSC0k23EMa8x/dLm', '12345678912', 'Sea', 'user', '2024-10-25 07:17:14'),
(14, 'saber', 'layla@gmail.com', '$2y$10$fC5xkjwEO8MG/FSXr6Y37.rtZenLRxDXRdXaxRYG7ZDGnGA1Gtw9O', '1234214324', 'sp1', 'user', '2024-10-25 07:18:47'),
(15, 'newuser', 'newuser@gmail.com', '$2y$10$4N6VXLlkZ21HPuy5SMezeOajBbpYKS1vP3eI4SByRw1GtGNlNJqGO', '0923232323', 'Lubao Pampanga ', 'user', '2024-10-25 09:44:03');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `audit_log`
--
ALTER TABLE `audit_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `audit_log`
--
ALTER TABLE `audit_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `audit_log`
--
ALTER TABLE `audit_log`
  ADD CONSTRAINT `audit_log_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
