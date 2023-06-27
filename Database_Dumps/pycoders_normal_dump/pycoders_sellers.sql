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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-06-27 21:46:10
