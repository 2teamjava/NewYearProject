-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- 主機： 127.0.0.1
-- 產生時間： 2023-01-29 13:47:42
-- 伺服器版本： 10.4.27-MariaDB
-- PHP 版本： 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 資料庫： `newyear`
--

-- --------------------------------------------------------

--
-- 資料表結構 `commodity`
--

CREATE TABLE `commodity` (
  `item_index` int(10) NOT NULL,
  `type` varchar(100) NOT NULL,
  `brand` varchar(100) NOT NULL,
  `location` varchar(100) NOT NULL,
  `cost` int(10) NOT NULL,
  `purchasetime` varchar(10) NOT NULL,
  `life_month` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 傾印資料表的資料 `commodity`
--

INSERT INTO `commodity` (`item_index`, `type`, `brand`, `location`, `cost`, `purchasetime`, `life_month`) VALUES
(1, 'bed', 'A', '南', 10000, '2020-02-02', 60),
(2, 'bed', 'B', '中', 20000, '2021-05-05', 60),
(3, 'bed', 'C', '北', 30000, '2022-08-08', 60),
(4, 'table', 'A', '南', 3000, '2018-09-09', 50),
(5, 'table', 'B', '中', 5000, '2019-06-22', 50),
(6, 'table', 'C', '北', 7000, '2020-01-01', 50),
(7, 'refrigerator', 'A', '南', 30000, '2018-10-10', 100),
(8, 'refrigerator', 'B', '中', 50000, '2019-12-12', 100),
(9, 'refrigerator', 'C', '北', 70000, '2022-11-11', 100),
(10, 'television', 'A', '南', 20000, '2021-02-01', 80),
(11, 'television', 'B', '中', 40000, '2019-01-09', 80),
(12, 'television', 'C', '北', 60000, '2022-12-12', 80),
(13, 'air_conditioner', 'A', '南', 20000, '2018-07-07', 100),
(14, 'air_conditioner', 'B', '中', 30000, '2019-09-09', 100),
(15, 'air_conditioner', 'C', '北', 40000, '2021-06-06', 100),
(16, 'laundry_machine', 'A', '南', 50000, '2020-07-07', 90),
(17, 'laundry_machine', 'B', '中', 60000, '2021-08-08', 90),
(18, 'laundry_machine', 'C', '北', 70000, '2022-10-10', 90);

-- --------------------------------------------------------

--
-- 資料表結構 `member`
--

CREATE TABLE `member` (
  `member_index` int(10) NOT NULL,
  `name` varchar(100) NOT NULL,
  `phone` varchar(10) NOT NULL,
  `address` varchar(100) NOT NULL,
  `account` varchar(100) NOT NULL,
  `password` varchar(10) NOT NULL,
  `order_id` mediumtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 傾印資料表的資料 `member`
--

INSERT INTO `member` (`member_index`, `name`, `phone`, `address`, `account`, `password`, `order_id`) VALUES
(0, 'admin', '0123456789', '台灣', 'admin', 'S123456789', NULL),
(1, '阿賢', '0987654321', '高雄市', 'Homology1996', 'S987654321', 'order1'),
(2, '海夢', '5268752687', '日本', 'marin', 'S520520520', 'order2'),
(3, '小孤獨', '3333333333', '下北澤', 'BOCCHI', 'S333333333', ''),
(4, '安妮亞', '4444444444', '某個國家', 'Anya', 'Anya', ''),
(5, '千花醬', '8787878787', '秀知院', 'chika', 'chika', '');

-- --------------------------------------------------------

--
-- 資料表結構 `orderlist`
--

CREATE TABLE `orderlist` (
  `order_index` int(10) NOT NULL,
  `account` varchar(100) NOT NULL,
  `address` varchar(100) NOT NULL,
  `order_name` varchar(100) CHARACTER SET utf32 COLLATE utf32_unicode_ci NOT NULL,
  `item_index` int(10) NOT NULL,
  `item_rent_time` int(10) NOT NULL,
  `start` varchar(10) NOT NULL,
  `end` varchar(10) NOT NULL,
  `price` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 傾印資料表的資料 `orderlist`
--

INSERT INTO `orderlist` (`order_index`, `account`, `address`, `order_name`, `item_index`, `item_rent_time`, `start`, `end`, `price`) VALUES
(1, 'Homology1996', '高雄市', 'order1', 1, 1, '2022-02-02', '2022-03-04', 167),
(2, 'marin', '日本', 'order2', 12, 12, '2020-12-12', '2021-12-07', 9000);

--
-- 已傾印資料表的索引
--

--
-- 資料表索引 `commodity`
--
ALTER TABLE `commodity`
  ADD PRIMARY KEY (`item_index`);

--
-- 資料表索引 `member`
--
ALTER TABLE `member`
  ADD PRIMARY KEY (`member_index`);

--
-- 資料表索引 `orderlist`
--
ALTER TABLE `orderlist`
  ADD PRIMARY KEY (`order_index`);

--
-- 在傾印的資料表使用自動遞增(AUTO_INCREMENT)
--

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `commodity`
--
ALTER TABLE `commodity`
  MODIFY `item_index` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
