CREATE DATABASE  IF NOT EXISTS `pycoders` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `pycoders`;
-- MySQL dump 10.13  Distrib 8.0.33, for Win64 (x86_64)
--
-- Host: localhost    Database: pycoders
-- ------------------------------------------------------
-- Server version	8.0.33

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `best_seller`
--

DROP TABLE IF EXISTS `best_seller`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `best_seller` (
  `seller_id` int NOT NULL,
  `seller_name` varchar(45) NOT NULL,
  PRIMARY KEY (`seller_id`),
  KEY `seller_id_idx` (`seller_id`,`seller_name`),
  CONSTRAINT `seller_id` FOREIGN KEY (`seller_id`) REFERENCES `sellers` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `best_seller`
--

LOCK TABLES `best_seller` WRITE;
/*!40000 ALTER TABLE `best_seller` DISABLE KEYS */;
/*!40000 ALTER TABLE `best_seller` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `id` int NOT NULL,
  `pid` int NOT NULL,
  `p_quantity` int NOT NULL,
  PRIMARY KEY (`id`,`pid`),
  KEY `pid` (`pid`),
  CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`pid`) REFERENCES `products` (`pid`),
  CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` VALUES (38,12,1);
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chats`
--

DROP TABLE IF EXISTS `chats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chats` (
  `chat_id` int NOT NULL AUTO_INCREMENT,
  `sender_id` int DEFAULT NULL,
  `recipient_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `message` text,
  `timestamp` datetime DEFAULT CURRENT_TIMESTAMP,
  `is_read` int DEFAULT '0',
  `is_user_d_sender` int DEFAULT NULL,
  PRIMARY KEY (`chat_id`),
  KEY `sender_id` (`sender_id`),
  KEY `recipient_id` (`recipient_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `chats_ibfk_3` FOREIGN KEY (`product_id`) REFERENCES `products` (`pid`),
  CONSTRAINT `check_is_user` CHECK (((`is_user_d_sender` = 1) or (`is_user_d_sender` = 0)))
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chats`
--

LOCK TABLES `chats` WRITE;
/*!40000 ALTER TABLE `chats` DISABLE KEYS */;
INSERT INTO `chats` VALUES (1,38,1,1,'Hi, I would like to know more about product','2023-06-26 15:58:35',0,1),(2,38,1,1,'Is the shirt made of cotton or wool ?','2023-06-26 16:10:48',0,1),(9,1,38,1,'Hi, sure will answer your queriess','2023-06-27 01:22:33',0,0),(10,1,38,1,'it is made out of cotton and not wool','2023-06-27 01:24:38',0,0),(11,38,1,2,'Hi, when will the product be available again?','2023-06-27 01:26:25',0,1),(12,1,38,2,'very soon! stay tuned :)','2023-06-27 01:27:13',0,0),(13,38,1,2,'Sure. Thanks','2023-06-27 16:58:59',0,1),(14,1,38,1,'Please feel free to contact me for any more info needed','2023-06-27 18:24:26',0,0),(15,1,38,1,'Thanks','2023-06-27 18:28:00',0,0),(16,1,38,1,'bye','2023-06-27 18:28:37',0,0),(17,1,38,2,'welcome','2023-06-27 18:28:50',0,0);
/*!40000 ALTER TABLE `chats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `offer_history`
--

DROP TABLE IF EXISTS `offer_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `offer_history` (
  `id` int NOT NULL AUTO_INCREMENT,
  `pid` int NOT NULL,
  `sid` int NOT NULL,
  `editor` varchar(45) DEFAULT NULL,
  `offerPrice` float DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offer_history`
--

LOCK TABLES `offer_history` WRITE;
/*!40000 ALTER TABLE `offer_history` DISABLE KEYS */;
INSERT INTO `offer_history` VALUES (10,6,1,'Seller',1),(11,6,1,'Seller',1),(12,6,1,'Seller',1),(13,6,1,'Seller',7),(14,1,1,'Seller',10),(15,6,1,'Seller',6),(16,6,1,'Seller',1),(17,6,1,'Seller',2),(18,6,1,'Seller',4.5),(19,6,1,'Seller',2),(20,7,1,'Seller',7);
/*!40000 ALTER TABLE `offer_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `pid` int NOT NULL AUTO_INCREMENT,
  `pName` text NOT NULL,
  `price` float NOT NULL,
  `offerPrice` float NOT NULL DEFAULT '0',
  `sold` enum('1','0') NOT NULL,
  `category` varchar(25) NOT NULL,
  `pCode` text NOT NULL,
  `pdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `quantity` int NOT NULL DEFAULT '1',
  `pdescription` text NOT NULL,
  PRIMARY KEY (`pid`),
  CONSTRAINT `check_qty` CHECK ((`quantity` >= 0)),
  CONSTRAINT `check_qty_sold` CHECK ((((`quantity` > 0) and (`sold` = _utf8mb4'0')) or ((`quantity` = 0) and (`sold` = _utf8mb4'1'))))
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'Red T-shirt : Clipart',2.1,1.8,'0','tshirt','apparel-162192.png','2018-09-20 05:10:40',5,'Care Instructions: Machine Wash\nFit Type: Regular Fit\nOccasion : Casual\nFit : Regular Fit\nMaterial : 60% Cotton and 40% Polyester\nNeck : Crew Neck\nPattern : Solid'),(2,'Blue T-shirt : Clipart',2.3,1,'1','tshirt','apparel-162180.png','2018-10-20 05:10:40',0,'Care Instructions: Machine Wash\nFit Type: Regular Fit\nOccasion : Casual\nFit : Regular Fit\nMaterial : 60% Cotton and 40% Polyester\nNeck : Crew Neck\nPattern : Solid'),(3,'Plain Black T-shirt : Homemade',1.99,0.5,'0','tshirt','blank-g1c2f06939_1920.png','2020-03-10 06:10:40',2,'Fit Type: Regular Fit\nFabric: Cotton\nStyle: Regular\nNeck Style: Round Neck\nPattern: Striped\nSleeve Type: Half Sleeve'),(4,'Plain White T-shirt : Homemade',2,1.5,'0','tshirt','blank-g5a8301ddd_1920.png','2020-03-10 07:50:30',64,'Super combed Cotton Rich fabric\nRibbed round neck to prevent sagging\nRegular fit\nLabel free for all day comfort'),(5,'Plain Red T-shirt : Homemade',1.5,0,'0','tshirt','blank-gc67a9941c_1920.png','2019-07-10 05:10:40',1,'Care Instructions: Machine Wash\nFit Type: Regular Fit\nColor Name: Red\n100% Cotton\nMachine wash\nPlain\nHalf sleeve\nRound neck'),(6,'NIVIA Air Strike Football',10,2,'0','football','alphabet-word-images-1295331_1280.png','2019-07-10 05:10:40',49,'Foamed PVC Stitched\nBUTYL BLADDER\n32 Panel Universal Design\nHobby Playing Ball\nSuitable For Grassy Grounds\nRecommended For Under 12 Years Age Group'),(7,'Nivia Trainer Synthetic Football',20.28,7,'1','football','ball-306073_1280.png','2021-07-10 05:10:40',0,'Included Components : 1 Football | Color : White/Blue | Size : 5\nSuitable For: All Conditions | Ideal For: Training/Match\nMaterial : Rubber | Core/Bladder Material : Butyl | Construction Type: Hand Stitched | Number of Panel : 32| Waterproof: Yes\nSuitable for: Hard Ground without Grass, Wet & Grassy Ground, Artificail Turf\nMaterial: Rubberized Hand Stitched.'),(8,'Volatility Russia Hand Stich Football Size-05 (2022 New Multicolour A)',50.25,27.3,'1','football','football-157930.png','2023-05-10 05:10:40',0,'2022 Football with Pump Outdoor Football - Size: 5 2022 Trending Football\nStitching Type Hand Stitched\nThe Football Is Good For Training And Recreational Purposes. With High-Resolution Graphics. Suitable For All Age Groups.\nfootball full size-5'),(9,'Vector X Street Soccer Rubber Moulded Football, Size 5',35.25,0,'1','football','football-157931_1280.png','2022-05-10 05:10:40',0,'Rubberized moulded ball, Texture surface single piece rubber moulded 32 panel ball.\nExcellent for hard & rough surface\nHigh durability.\nExcels in all weather conditions.\nWeight – 400 – 450 gms, Circumference – 69.00 – 70.00 CM, Diameter – 22.00 Cm'),(10,'Vector X NEO Rubber Moulded Football, Size 5 (White-Red-Black)',30.25,0,'0','football','soccer-25768.png','2022-05-10 05:10:40',9,'Suitable for Hard Ground without Grass, Wet & Grassy Ground & Artificial Turf.\nSize- 5 Diameter : 219mm and Synthetic Rubber\nRubber Moulded with Weight : 410-450g\nSuperior thread hand Stitched ball Specially engineered shiny Surface .\nBalanced configuration for total ball control, low water uptake\nIdeal for : Training & Recreation use or specially for children under 16 Yrs age.'),(11,'ZAFEX Hand Stiched Multicolour Football Size 5 (White Russi)',25.13,0,'0','football','soccer-7647528_1280.png','2016-05-10 05:10:40',8,'Fine & Furnished Quality.\nPackage Content :1 Piece Football with 1 pump\nEnsures Good Performance.\nOur Moto Is Provide Better Quality To Our Customers.\nThe Ball Is Meant For Very Light Play And Not For Playing On Rough Ground.'),(12,'Lenovo E41-55',200.13,0,'1','laptop','laptop-1836990_1920.jpg','2020-12-10 06:10:40',0,'Lenovo E41-55 AMD 14-inch (35.56cm) HD Thin and Light Laptop\nProcessor:- AMD Athlon Pro A3050U\nConfiguration:- 8GB RAM/ 256 SSD\nOs:- Windows 11 HSL With Lifetime Validity\nIntegrated AMD Radeon Graphics'),(13,'HP 15s',333,0,'0','laptop','laptop-5673901_1920.jpg','2023-06-10 05:10:40',2,'Processor:Intel Core i3-1115G4(up to 4.1 GHz with Intel Turbo Boost Technology(2g), 6 MB L3 cache, 2 cores)|Memory: 8 GB DDR4-3200 MHz RAM (1 x 8 GB) Upto 16 GB DDR4-3200 MHz RAM (2 x 8 GB)| Storage: 1 TB 5400 rpm SATA HDD, 256 GB PCIe NVMe TLC M.2 SSD\nDisplay & Graphics : 39.6 cm (15.6\") diagonal, FHD, 250 nits, 141 ppi, 45%NTSC, Screen Resolution: 1920 x 1080|Graphics: Intel UHD Graphics\nOperating System & Preinstalled Software: Windows 11 Home 64 Plus Single Language | Microsoft Office Home & Student 2021| McAfee LiveSafe (30 days free trial as default) |Pre-installed Alexa built-in- Your life simplified with Alexa. Just ask Alexa to check your calendar, create to-do lists, shopping lists, play music, set reminders, get latest news and control smart home.\nPorts & Networking: 1 SuperSpeed USB Type-C 5Gbps signaling rate, 2 SuperSpeed USB Type-A 5Gbps signaling rate, 1 headphone/microphone combo, 1 AC smart pin, 1 HDMI 1.4b| Networking: Integrated 10/100/1000 GbE LAN, Realtek RTL8822CE 802.11a/b/g/n/ac (2x2) Wi-Fi and Bluetooth 5 combo\nOther Features: Webcam: HP TrueVision 720p HD Camera with Integrated dual array digital Microphones|Audio: Dual speakers|Keyboard: Full-size,jet black keyboard with numeric keypad,Touchpad with multi-touch gesture support| Battery: Support battery fast charge|'),(14,'Apple 2020 MacBook Air Laptop',500,0,'0','laptop','macbook-562499.png','2021-06-10 05:10:40',4,'All-Day Battery Life – Go longer than ever with up to 18 hours of battery life.\nPowerful Performance – Take on everything from professional-quality editing to action-packed gaming with ease. The Apple M1 chip with an 8-core CPU delivers up to 3.5x faster performance than the previous generation while using way less power.\nSuperfast Memory – 8GB of unified memory makes your entire system speedy and responsive. That way it can support tasks like memory-hogging multitab browsing and opening a huge graphic file quickly and easily.\nStunning Display – With a 13.3-inch/33.74 cm Retina display, images come alive with new levels of realism. Text is sharp and clear, and colors are more vibrant.\nWhy Mac – Easy to learn. Easy to set up. Astoundingly'),(15,'Apple 2023 MacBook Pro Laptop',800,0,'1','laptop','macbook-1999639_1920.png','2023-04-10 05:10:40',0,'Brand Apple\nModel Name MacBook Pro\nScreen Size  16 Inches\nColour Silver\nHard Disk Size  1000 GB\nCPU Model  Unknown\nRAM Memory Installed Size  32 GB\nOperating System Mac OS\nGraphics Card Description Integrated\nGraphics Coprocessor  Apple M2 Max');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products_sellers`
--

DROP TABLE IF EXISTS `products_sellers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products_sellers` (
  `pid` int NOT NULL,
  `sid` int NOT NULL,
  PRIMARY KEY (`pid`,`sid`),
  KEY `sid` (`sid`),
  CONSTRAINT `products_sellers_ibfk_1` FOREIGN KEY (`pid`) REFERENCES `products` (`pid`),
  CONSTRAINT `products_sellers_ibfk_2` FOREIGN KEY (`sid`) REFERENCES `sellers` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products_sellers`
--

LOCK TABLES `products_sellers` WRITE;
/*!40000 ALTER TABLE `products_sellers` DISABLE KEYS */;
INSERT INTO `products_sellers` VALUES (1,1),(2,1),(3,1),(4,1),(5,1),(6,1),(7,1),(8,2),(9,2),(10,2),(11,2),(12,2),(13,2),(14,2),(15,2);
/*!40000 ALTER TABLE `products_sellers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ratings`
--

DROP TABLE IF EXISTS `ratings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ratings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `rating` varchar(45) DEFAULT NULL,
  `pid` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ratings`
--

LOCK TABLES `ratings` WRITE;
/*!40000 ALTER TABLE `ratings` DISABLE KEYS */;
/*!40000 ALTER TABLE `ratings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sellers`
--

DROP TABLE IF EXISTS `sellers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sellers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `username` varchar(15) NOT NULL,
  `password` text NOT NULL,
  `email` varchar(100) NOT NULL,
  `address` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sellers`
--

LOCK TABLES `sellers` WRITE;
/*!40000 ALTER TABLE `sellers` DISABLE KEYS */;
INSERT INTO `sellers` VALUES (1,'Aditya Ganesh Khedekar','aditya0by0','pbkdf2:sha256:260000$h1njionAXn3Za6Sa$102867e072e2333ca230e3e50bebe4ff6a0ebe4172ff6f51de05495e0bcfb2ea','aditya0by0@gmail.com','Ernst-Lehmann-Straße 2,'),(2,'testuser','testuser','pbkdf2:sha256:260000$9cIC0swNKCIzaFQh$c8e80d9fd9f026240c8db13f47b8a8283b9fc8bbebbbf00f63b5c31c5b6349cc','testuser@gmail.com','Test address 123, 123456\', \'test country'),(18,'testseller','testseller','pbkdf2:sha256:260000$5QLbgsMSvFRzCuEZ$d7552f1ef70576aa154cab6f75e8dbcf5950bc815205a580c72abadb84ea4a0a','testseller@gmail.com','test ');
/*!40000 ALTER TABLE `sellers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_history`
--

DROP TABLE IF EXISTS `user_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_history` (
  `id` int NOT NULL,
  `pid` int NOT NULL,
  `date_` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `p_quantity` int NOT NULL,
  `sid` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`,`pid`,`date_`),
  KEY `pid` (`pid`,`sid`),
  KEY `sid_idx` (`sid`),
  CONSTRAINT `seller_id_fk1` FOREIGN KEY (`sid`) REFERENCES `sellers` (`id`),
  CONSTRAINT `user_history_ibfk_2` FOREIGN KEY (`id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_history`
--

LOCK TABLES `user_history` WRITE;
/*!40000 ALTER TABLE `user_history` DISABLE KEYS */;
INSERT INTO `user_history` VALUES (38,1,'2023-06-24 21:28:14',5,1),(38,6,'2023-06-24 21:20:51',1,1),(38,8,'2023-06-01 21:26:04',1,1),(38,8,'2023-06-02 15:09:41',4,1),(38,9,'2023-06-02 15:11:23',13,1),(38,12,'2023-06-24 21:28:14',2,1),(38,12,'2023-06-24 21:33:05',1,1),(38,13,'2023-06-24 21:31:33',2,1),(38,14,'2023-06-01 21:30:36',1,1),(39,15,'2023-06-01 21:30:36',1,2);
/*!40000 ALTER TABLE `user_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `username` varchar(15) NOT NULL,
  `password` text NOT NULL,
  `email` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (38,'Aditya Ganesh Khedekar','aditya0by0','pbkdf2:sha256:260000$bQFaflDmQ4IEE0MG$cdb4382b625b6a26f718b5e84704e05ac4a90b38dbd51ce3554b22e105870689','aditya0by0@gmail.com'),(39,'aditya ','aditya0by0123','pbkdf2:sha256:260000$VnLhLfT4PUC0fKK1$8e643d7b029937ca1c092af237c2635a095e7d79ca4899cb71bf60954932db29','aditya0by0123@gmail.com');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'pycoders'
--

--
-- Dumping routines for database 'pycoders'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-06-27 21:47:03
