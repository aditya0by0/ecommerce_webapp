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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-06-27 21:46:09
