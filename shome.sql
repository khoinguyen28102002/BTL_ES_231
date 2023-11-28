-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th10 28, 2023 lúc 04:58 PM
-- Phiên bản máy phục vụ: 10.4.27-MariaDB
-- Phiên bản PHP: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `shome`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `fan_status`
--

CREATE TABLE `fan_status` (
  `F_ID` int(10) NOT NULL,
  `Status` enum('Đang tắt','Đang hoạt động') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `fan_status`
--

INSERT INTO `fan_status` (`F_ID`, `Status`) VALUES
(1, 'Đang tắt');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `light_record`
--

CREATE TABLE `light_record` (
  `L_ID` int(10) NOT NULL,
  `Date` date NOT NULL,
  `Time` time NOT NULL,
  `LightData` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `light_status`
--

CREATE TABLE `light_status` (
  `L_ID` int(10) NOT NULL DEFAULT 0,
  `Status` enum('Đang tắt','Đang hoạt động') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `light_status`
--

INSERT INTO `light_status` (`L_ID`, `Status`) VALUES
(1, 'Đang tắt');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `movement_rc`
--

CREATE TABLE `movement_rc` (
  `M_ID` int(10) NOT NULL DEFAULT 0,
  `Date` int(11) NOT NULL,
  `Time` int(11) NOT NULL,
  `MoveData` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `temp_record`
--

CREATE TABLE `temp_record` (
  `T_ID` int(10) NOT NULL,
  `Date` int(11) NOT NULL,
  `Time` int(11) NOT NULL,
  `TempData` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `user`
--

CREATE TABLE `user` (
  `U_ID` int(10) NOT NULL,
  `UserName` varchar(50) NOT NULL,
  `PassWord` varchar(50) NOT NULL,
  `Name` varchar(50) DEFAULT NULL,
  `Birthday` date DEFAULT NULL,
  `Address` varchar(255) DEFAULT NULL,
  `Email` varchar(225) DEFAULT NULL,
  `Phone` varchar(11) DEFAULT NULL,
  `Image` varchar(225) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `user`
--

INSERT INTO `user` (`U_ID`, `UserName`, `PassWord`, `Name`, `Birthday`, `Address`, `Email`, `Phone`, `Image`) VALUES
(1, 'Quynh', '2014334', NULL, NULL, NULL, NULL, NULL, NULL),
(2, 'Nguyen', '2013923', NULL, NULL, NULL, NULL, NULL, NULL),
(3, 'Hoang', '2013231', NULL, NULL, NULL, NULL, NULL, NULL),
(4, 'Huy', '2013332', NULL, NULL, NULL, NULL, NULL, NULL),
(5, 'Tuan', '2012348', NULL, NULL, NULL, NULL, NULL, NULL),
(6, 'Vinh', '2015081', NULL, NULL, NULL, NULL, NULL, NULL);

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `light_record`
--
ALTER TABLE `light_record`
  ADD PRIMARY KEY (`L_ID`);

--
-- Chỉ mục cho bảng `temp_record`
--
ALTER TABLE `temp_record`
  ADD PRIMARY KEY (`T_ID`);

--
-- Chỉ mục cho bảng `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`U_ID`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `light_record`
--
ALTER TABLE `light_record`
  MODIFY `L_ID` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `temp_record`
--
ALTER TABLE `temp_record`
  MODIFY `T_ID` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `user`
--
ALTER TABLE `user`
  MODIFY `U_ID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
