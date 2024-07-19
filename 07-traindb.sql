-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: traindb
-- ------------------------------------------------------
-- Server version	8.0.37

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
-- Table structure for table `administers`
--

DROP TABLE IF EXISTS `administers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `administers` (
  `admin_id` int NOT NULL,
  `customer_rep_id` int NOT NULL,
  PRIMARY KEY (`admin_id`,`customer_rep_id`),
  KEY `customer_rep_id` (`customer_rep_id`),
  CONSTRAINT `administers_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `employee` (`ssn`),
  CONSTRAINT `administers_ibfk_2` FOREIGN KEY (`customer_rep_id`) REFERENCES `employee` (`ssn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `administers`
--

LOCK TABLES `administers` WRITE;
/*!40000 ALTER TABLE `administers` DISABLE KEYS */;
/*!40000 ALTER TABLE `administers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `answer_question`
--

DROP TABLE IF EXISTS `answer_question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `answer_question` (
  `title` varchar(100) NOT NULL,
  `cid` int NOT NULL,
  `ssn` int NOT NULL,
  `reply` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`title`,`cid`,`ssn`),
  KEY `ssn` (`ssn`),
  CONSTRAINT `answer_question_ibfk_1` FOREIGN KEY (`title`, `cid`) REFERENCES `ask_question` (`title`, `cid`),
  CONSTRAINT `answer_question_ibfk_2` FOREIGN KEY (`ssn`) REFERENCES `employee` (`ssn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `answer_question`
--

LOCK TABLES `answer_question` WRITE;
/*!40000 ALTER TABLE `answer_question` DISABLE KEYS */;
INSERT INTO `answer_question` VALUES ('Reservation for Train',2,123456789,'Hello! Once you login click \"reservation\" and it will take you to the portal.');
/*!40000 ALTER TABLE `answer_question` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ask_question`
--

DROP TABLE IF EXISTS `ask_question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ask_question` (
  `title` varchar(100) NOT NULL,
  `cid` int NOT NULL,
  `content` varchar(500) DEFAULT NULL,
  `answered` int DEFAULT NULL,
  PRIMARY KEY (`title`,`cid`),
  KEY `cid` (`cid`),
  CONSTRAINT `ask_question_ibfk_1` FOREIGN KEY (`cid`) REFERENCES `customer` (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ask_question`
--

LOCK TABLES `ask_question` WRITE;
/*!40000 ALTER TABLE `ask_question` DISABLE KEYS */;
INSERT INTO `ask_question` VALUES ('Forgot Password',1,'How do I retrieve password for account if I forget it?',0),('Reservation for Train',2,'How Do I make a reservation?',1);
/*!40000 ALTER TABLE `ask_question` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `cid` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(200) DEFAULT NULL,
  `last_name` varchar(200) DEFAULT NULL,
  `username` varchar(200) NOT NULL,
  `password` varchar(200) NOT NULL,
  `email` varchar(200) NOT NULL,
  PRIMARY KEY (`cid`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,'Henry','Nguyen','apple','apple','henrygl450@yahoo.com'),(2,'Jayman','Rana','customer','customer','jaymanrana@gmail.com');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee` (
  `ssn` int NOT NULL,
  `first_name` varchar(200) NOT NULL,
  `last_name` varchar(200) NOT NULL,
  `username` varchar(200) NOT NULL,
  `password` varchar(200) NOT NULL,
  `isAdmin` tinyint(1) NOT NULL,
  PRIMARY KEY (`ssn`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES (123456789,'Robin','Gold','cherry','cherry',0);
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `isfortrainreservation`
--

DROP TABLE IF EXISTS `isfortrainreservation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `isfortrainreservation` (
  `reservation_number` int NOT NULL,
  `train_id` int NOT NULL,
  PRIMARY KEY (`reservation_number`,`train_id`),
  KEY `train_id` (`train_id`),
  CONSTRAINT `isfortrainreservation_ibfk_1` FOREIGN KEY (`reservation_number`) REFERENCES `reservation` (`reservation_number`),
  CONSTRAINT `isfortrainreservation_ibfk_2` FOREIGN KEY (`train_id`) REFERENCES `train` (`train_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `isfortrainreservation`
--

LOCK TABLES `isfortrainreservation` WRITE;
/*!40000 ALTER TABLE `isfortrainreservation` DISABLE KEYS */;
/*!40000 ALTER TABLE `isfortrainreservation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `manages`
--

DROP TABLE IF EXISTS `manages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `manages` (
  `ssn` int NOT NULL,
  `reservation` int NOT NULL,
  `transit_name` varchar(200) NOT NULL,
  PRIMARY KEY (`ssn`,`reservation`,`transit_name`),
  KEY `reservation` (`reservation`),
  KEY `transit_name` (`transit_name`),
  CONSTRAINT `manages_ibfk_1` FOREIGN KEY (`ssn`) REFERENCES `employee` (`ssn`),
  CONSTRAINT `manages_ibfk_2` FOREIGN KEY (`reservation`) REFERENCES `reservation` (`reservation_number`),
  CONSTRAINT `manages_ibfk_3` FOREIGN KEY (`transit_name`) REFERENCES `trainschedule` (`transit_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manages`
--

LOCK TABLES `manages` WRITE;
/*!40000 ALTER TABLE `manages` DISABLE KEYS */;
/*!40000 ALTER TABLE `manages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservation`
--

DROP TABLE IF EXISTS `reservation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservation` (
  `reservation_number` int NOT NULL,
  `rdate` date NOT NULL,
  `total_fare` float NOT NULL,
  `cid` int NOT NULL,
  PRIMARY KEY (`reservation_number`),
  KEY `cid` (`cid`),
  CONSTRAINT `reservation_ibfk_1` FOREIGN KEY (`cid`) REFERENCES `customer` (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservation`
--

LOCK TABLES `reservation` WRITE;
/*!40000 ALTER TABLE `reservation` DISABLE KEYS */;
/*!40000 ALTER TABLE `reservation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `station`
--

DROP TABLE IF EXISTS `station`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `station` (
  `station_id` int NOT NULL,
  `state` char(2) NOT NULL,
  `city` varchar(200) NOT NULL,
  `name` varchar(200) NOT NULL,
  PRIMARY KEY (`station_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `station`
--

LOCK TABLES `station` WRITE;
/*!40000 ALTER TABLE `station` DISABLE KEYS */;
INSERT INTO `station` VALUES (1,'CA','San Francisco','San Francisco Station'),(2,'CA','Los Angeles','Los Angeles Station'),(3,'CA','San Jose','San Jose Station'),(4,'CA','Fresno','Fresno Station'),(5,'CA','Sacramento','Sacramento Station');
/*!40000 ALTER TABLE `station` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stops`
--

DROP TABLE IF EXISTS `stops`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stops` (
  `train_id` int NOT NULL,
  `station_id` int NOT NULL,
  `arrival` datetime NOT NULL,
  `depart` datetime NOT NULL,
  PRIMARY KEY (`train_id`,`station_id`),
  KEY `station_id` (`station_id`),
  CONSTRAINT `stops_ibfk_1` FOREIGN KEY (`train_id`) REFERENCES `train` (`train_id`),
  CONSTRAINT `stops_ibfk_2` FOREIGN KEY (`station_id`) REFERENCES `station` (`station_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stops`
--

LOCK TABLES `stops` WRITE;
/*!40000 ALTER TABLE `stops` DISABLE KEYS */;
INSERT INTO `stops` VALUES (1,1,'2024-07-15 08:00:00','2024-07-15 08:10:00'),(1,2,'2024-07-15 14:00:00','2024-07-15 14:10:00'),(1,4,'2024-07-15 10:00:00','2024-07-15 10:10:00'),(2,1,'2024-07-15 09:00:00','2024-07-15 09:10:00'),(2,3,'2024-07-15 17:00:00','2024-07-15 17:10:00'),(2,4,'2024-07-15 13:00:00','2024-07-15 13:10:00'),(2,5,'2024-07-15 11:00:00','2024-07-15 11:10:00');
/*!40000 ALTER TABLE `stops` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `train`
--

DROP TABLE IF EXISTS `train`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `train` (
  `train_id` int NOT NULL,
  PRIMARY KEY (`train_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `train`
--

LOCK TABLES `train` WRITE;
/*!40000 ALTER TABLE `train` DISABLE KEYS */;
INSERT INTO `train` VALUES (1),(2),(3),(4);
/*!40000 ALTER TABLE `train` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `train_has_schedule`
--

DROP TABLE IF EXISTS `train_has_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `train_has_schedule` (
  `train_id` int NOT NULL,
  `transit_name` varchar(200) NOT NULL,
  PRIMARY KEY (`train_id`,`transit_name`),
  KEY `transit_name` (`transit_name`),
  CONSTRAINT `train_has_schedule_ibfk_1` FOREIGN KEY (`train_id`) REFERENCES `train` (`train_id`),
  CONSTRAINT `train_has_schedule_ibfk_2` FOREIGN KEY (`transit_name`) REFERENCES `trainschedule` (`transit_name`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `train_has_schedule`
--

LOCK TABLES `train_has_schedule` WRITE;
/*!40000 ALTER TABLE `train_has_schedule` DISABLE KEYS */;
INSERT INTO `train_has_schedule` VALUES (2,'Coastal Line'),(1,'Express Line');
/*!40000 ALTER TABLE `train_has_schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trainschedule`
--

DROP TABLE IF EXISTS `trainschedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trainschedule` (
  `transit_name` varchar(200) NOT NULL,
  `stops` int NOT NULL,
  `fare` int NOT NULL,
  `travel_time` int NOT NULL,
  `dep_time` datetime NOT NULL,
  `arr_time` datetime NOT NULL,
  `origin_station_id` int NOT NULL,
  `destination_station_id` int NOT NULL,
  PRIMARY KEY (`transit_name`),
  KEY `origin_station_id` (`origin_station_id`),
  KEY `destination_station_id` (`destination_station_id`),
  CONSTRAINT `trainschedule_ibfk_1` FOREIGN KEY (`origin_station_id`) REFERENCES `station` (`station_id`),
  CONSTRAINT `trainschedule_ibfk_2` FOREIGN KEY (`destination_station_id`) REFERENCES `station` (`station_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trainschedule`
--

LOCK TABLES `trainschedule` WRITE;
/*!40000 ALTER TABLE `trainschedule` DISABLE KEYS */;
INSERT INTO `trainschedule` VALUES ('Coastal Line',4,120,480,'2024-07-15 09:00:00','2024-07-15 17:00:00',1,3),('Express Line',3,100,360,'2024-07-15 08:00:00','2024-07-15 14:00:00',1,2);
/*!40000 ALTER TABLE `trainschedule` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-07-18 22:54:02
