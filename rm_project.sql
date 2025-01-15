-- MySQL dump 10.13  Distrib 9.1.0, for Linux (x86_64)
--
-- Host: localhost    Database: rm_project
-- ------------------------------------------------------
-- Server version	9.1.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `ban`
--

DROP TABLE IF EXISTS `ban`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ban` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_phong` int NOT NULL,
  `ten_ban` varchar(50) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `status` varchar(255) COLLATE utf8mb4_vietnamese_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_phong` (`id_phong`),
  CONSTRAINT `ban_ibfk_1` FOREIGN KEY (`id_phong`) REFERENCES `phong` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ban`
--

LOCK TABLES `ban` WRITE;
/*!40000 ALTER TABLE `ban` DISABLE KEYS */;
INSERT INTO `ban` VALUES (1,1,'Bàn 1','Đã đặt món'),(2,1,'Bàn 2','Trống'),(3,2,'Bàn 1','Trống'),(4,2,'Bàn 2','Trống'),(5,3,'Bàn 1','Trống'),(6,3,'Bàn 2','Trống'),(7,4,'Bàn 1','Trống'),(8,4,'Bàn 2','Trống');
/*!40000 ALTER TABLE `ban` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chi_tiet_ban`
--

DROP TABLE IF EXISTS `chi_tiet_ban`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chi_tiet_ban` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_phong` int NOT NULL,
  `id_ban` int NOT NULL,
  `id_mon` int NOT NULL,
  `so_luong` int NOT NULL,
  `don_gia` decimal(10,2) NOT NULL,
  `thanh_tien` decimal(10,2) GENERATED ALWAYS AS ((`so_luong` * `don_gia`)) STORED,
  `status` varchar(255) COLLATE utf8mb4_vietnamese_ci NOT NULL DEFAULT 'Đang xử lý',
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_phong` (`id_phong`),
  KEY `id_ban` (`id_ban`),
  KEY `id_mon` (`id_mon`),
  CONSTRAINT `chi_tiet_ban_ibfk_1` FOREIGN KEY (`id_phong`) REFERENCES `phong` (`id`),
  CONSTRAINT `chi_tiet_ban_ibfk_2` FOREIGN KEY (`id_ban`) REFERENCES `ban` (`id`),
  CONSTRAINT `chi_tiet_ban_ibfk_3` FOREIGN KEY (`id_mon`) REFERENCES `menu` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chi_tiet_ban`
--

LOCK TABLES `chi_tiet_ban` WRITE;
/*!40000 ALTER TABLE `chi_tiet_ban` DISABLE KEYS */;
INSERT INTO `chi_tiet_ban` (`id`, `id_phong`, `id_ban`, `id_mon`, `so_luong`, `don_gia`, `status`, `created_at`) VALUES (31,1,1,1,1,65000.00,'Hoàn thành','2025-01-13 18:12:20'),(32,1,1,1,1,65000.00,'Hoàn thành','2025-01-14 07:08:17');
/*!40000 ALTER TABLE `chi_tiet_ban` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `hoTen` varchar(255) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `phone` varchar(20) COLLATE utf8mb4_vietnamese_ci DEFAULT NULL,
  `diaChi` varchar(255) COLLATE utf8mb4_vietnamese_ci DEFAULT NULL,
  `tinh` varchar(100) COLLATE utf8mb4_vietnamese_ci DEFAULT NULL,
  `huyen` varchar(100) COLLATE utf8mb4_vietnamese_ci DEFAULT NULL,
  `xa` varchar(100) COLLATE utf8mb4_vietnamese_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,'lan@gmail.com','Lan Nguyễn','032145565','01 Ngô Mây','Bình Định','Quy Nhơn','Ngô Mây');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kho`
--

DROP TABLE IF EXISTS `kho`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kho` (
  `id` int NOT NULL AUTO_INCREMENT,
  `Loai` enum('hai_san','thit_rung','gia_cam','rau_cu','trai_cay','gia_vi_nem','gv_dac_biet','do_uong') COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `ten` varchar(255) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `gia` decimal(10,2) NOT NULL,
  `soluong` int NOT NULL,
  `ngayNhap` date DEFAULT NULL,
  `trangThai` enum('con_hang','het_hang','sap_het') COLLATE utf8mb4_vietnamese_ci DEFAULT 'con_hang',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kho`
--

LOCK TABLES `kho` WRITE;
/*!40000 ALTER TABLE `kho` DISABLE KEYS */;
/*!40000 ALTER TABLE `kho` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `material`
--

DROP TABLE IF EXISTS `material`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `material` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `unit` varchar(50) NOT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `material`
--

LOCK TABLES `material` WRITE;
/*!40000 ALTER TABLE `material` DISABLE KEYS */;
INSERT INTO `material` VALUES (1,'Bánh phở','gam','Bánh phở tươi cao cấp'),(2,'Thịt bò tái','gam','Thịt bò úc tươi ngon'),(3,'Sườn heo','gam','Sườn heo non'),(4,'Bánh tráng','gói','Bánh tráng rice paper loại 1');
/*!40000 ALTER TABLE `material` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `material_batch`
--

DROP TABLE IF EXISTS `material_batch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `material_batch` (
  `id` int NOT NULL AUTO_INCREMENT,
  `material_id` int NOT NULL,
  `quantity` int NOT NULL,
  `expired_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `material_id` (`material_id`),
  CONSTRAINT `material_batch_ibfk_1` FOREIGN KEY (`material_id`) REFERENCES `material` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `material_batch`
--

LOCK TABLES `material_batch` WRITE;
/*!40000 ALTER TABLE `material_batch` DISABLE KEYS */;
INSERT INTO `material_batch` VALUES (1,1,0,'2025-02-01 00:00:00'),(2,2,29700,'2025-01-20 00:00:00'),(3,3,25000,'2025-01-18 00:00:00'),(4,4,100,'2025-06-30 00:00:00'),(5,1,101,'2025-02-05 00:00:00'),(6,1,500,'2025-01-05 00:00:00');
/*!40000 ALTER TABLE `material_batch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu`
--

DROP TABLE IF EXISTS `menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ten_mon` varchar(255) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `gia` decimal(10,2) NOT NULL,
  `mo_ta` text COLLATE utf8mb4_vietnamese_ci,
  `nguyen_lieu` text COLLATE utf8mb4_vietnamese_ci,
  `hinh_anh` varchar(255) COLLATE utf8mb4_vietnamese_ci DEFAULT NULL,
  `category` enum('mon_chinh','mon_phu','trang_mieng','do_uong','khai_vi','lau','combo','goi') COLLATE utf8mb4_vietnamese_ci NOT NULL DEFAULT 'mon_chinh',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu`
--

LOCK TABLES `menu` WRITE;
/*!40000 ALTER TABLE `menu` DISABLE KEYS */;
INSERT INTO `menu` VALUES (1,'Phở Bò Tái',65000.00,'Phở bò truyền thống với thịt bò tái, nước dùng đậm đà nấu từ xương bò và gia vị thơm ngon','Bánh phở, thịt bò, hành, gừng, gia vị','https://placewaifu.com/image/200/200','mon_chinh'),(2,'Cơm Sườn Nướng',55000.00,'Cơm trắng dẻo thơm kèm sườn nướng tẩm ướp đậm đà và rau xào','Gạo, sườn heo, gia vị ướp, rau củ','https://placewaifu.com/image/200/200','mon_chinh'),(3,'Gỏi Cuốn Tôm Thịt',45000.00,'Gỏi cuốn tươi mát với tôm, thịt heo, bún, rau sống và nước chấm đặc biệt','Bánh tráng, tôm, thịt heo, bún, rau sống','https://placewaifu.com/image/200/200','khai_vi'),(4,'Bún Bò Huế',70000.00,'Bún bò Huế cay nồng với nước dùng đặc trưng, giò heo và các loại gia vị truyền thống','Bún, thịt bò, giò heo, sả, ớt, gia vị Huế','https://placewaifu.com/image/200/200','mon_chinh');
/*!40000 ALTER TABLE `menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification`
--

DROP TABLE IF EXISTS `notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notification` (
  `id` int NOT NULL AUTO_INCREMENT,
  `message` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_read` tinyint(1) DEFAULT NULL,
  `navigation_link` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification`
--

LOCK TABLES `notification` WRITE;
/*!40000 ALTER TABLE `notification` DISABLE KEYS */;
/*!40000 ALTER TABLE `notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_items` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `product_id` int NOT NULL,
  `quantity` int NOT NULL,
  `price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `menu` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_items`
--

LOCK TABLES `order_items` WRITE;
/*!40000 ALTER TABLE `order_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(100) COLLATE utf8mb4_vietnamese_ci DEFAULT NULL,
  `full_name` varchar(100) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `phone` varchar(15) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `address` varchar(255) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `province` varchar(100) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `district` varchar(100) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `ward` varchar(100) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `notes` text COLLATE utf8mb4_vietnamese_ci,
  `payment_method` varchar(50) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `status` varchar(50) COLLATE utf8mb4_vietnamese_ci NOT NULL DEFAULT 'Pending',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `party`
--

DROP TABLE IF EXISTS `party`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `party` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ten` varchar(255) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `loai` enum('tiec_cuoi','khai_truong','sinh_nhat','hoi_thao','hen_ho') COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `hinh_anh` varchar(255) COLLATE utf8mb4_vietnamese_ci DEFAULT NULL,
  `so_luong` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `party`
--

LOCK TABLES `party` WRITE;
/*!40000 ALTER TABLE `party` DISABLE KEYS */;
INSERT INTO `party` VALUES (2,'Thiên đường mây','sinh_nhat','dattiecsinhnhat.jpg',100),(3,'Hoàng hôn biển','hen_ho','khonggianngoaitroi.jpg',10),(4,'Phong cách Nhật Bản','hen_ho','datbantrongnha.jpeg',10),(5,'Buổi tiệc truyền thống','tiec_cuoi','dattieccuoi.jpg',300);
/*!40000 ALTER TABLE `party` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phong`
--

DROP TABLE IF EXISTS `phong`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `phong` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ten_phong` varchar(50) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phong`
--

LOCK TABLES `phong` WRITE;
/*!40000 ALTER TABLE `phong` DISABLE KEYS */;
INSERT INTO `phong` VALUES (1,'Phòng 1'),(2,'Phòng 2'),(3,'Phòng 3(VIP)'),(4,'Phòng 4');
/*!40000 ALTER TABLE `phong` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recipe_detail`
--

DROP TABLE IF EXISTS `recipe_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recipe_detail` (
  `id` int NOT NULL AUTO_INCREMENT,
  `menu_item_id` int NOT NULL,
  `material_id` int NOT NULL,
  `quantity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `material_id` (`material_id`),
  KEY `menu_item_id` (`menu_item_id`),
  CONSTRAINT `recipe_detail_ibfk_1` FOREIGN KEY (`material_id`) REFERENCES `material` (`id`),
  CONSTRAINT `recipe_detail_ibfk_2` FOREIGN KEY (`menu_item_id`) REFERENCES `menu` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recipe_detail`
--

LOCK TABLES `recipe_detail` WRITE;
/*!40000 ALTER TABLE `recipe_detail` DISABLE KEYS */;
INSERT INTO `recipe_detail` VALUES (1,1,1,200),(2,1,2,150),(3,2,3,250),(4,3,4,2);
/*!40000 ALTER TABLE `recipe_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `last_name` varchar(50) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `user_name` varchar(50) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `password` varchar(50) COLLATE utf8mb4_vietnamese_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `quyen` enum('phuc_vu','quan_ly','bep','chu') COLLATE utf8mb4_vietnamese_ci DEFAULT 'phuc_vu',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `userName` (`user_name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'ha','linh','linh@gmail.com','1','1','2024-11-07 17:09:34','chu'),(2,'Hà','Linh','mylinh@gmail.com','123','123','2024-11-14 19:21:56','phuc_vu'),(3,'Linh','Mỹ','linh123@gmail.com','linh123','111','2024-11-21 20:37:31','phuc_vu'),(4,'Thắm','Hồ','tham@123.com','Thamho','111','2024-11-21 20:47:10','phuc_vu'),(5,'Nhân ','Nguyễn','nhan@gmail.com','Hanhan','111','2024-11-21 20:57:56','phuc_vu'),(6,'Nguyên','Hồ','nguyen@123.com','quangnguyen','111','2024-11-21 21:04:14','phuc_vu');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-01-15 12:19:42
