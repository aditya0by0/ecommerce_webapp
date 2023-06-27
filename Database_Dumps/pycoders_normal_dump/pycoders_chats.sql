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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-06-27 21:46:10
