CREATE DATABASE  IF NOT EXISTS `energycrm` /*!40100 DEFAULT CHARACTER SET latin1 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `energycrm`;
-- MySQL dump 10.13  Distrib 8.0.18, for Win64 (x86_64)
--
-- Host: infoman.cqswvskegglr.eu-west-1.rds.amazonaws.com    Database: energycrm
-- ------------------------------------------------------
-- Server version	8.0.16

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
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '';

--
-- Table structure for table `Address`
--

DROP TABLE IF EXISTS `Address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Address` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `IsMeter` tinyint(1) NOT NULL,
  `AddressLine1` varchar(255) NOT NULL,
  `AddressLine2` varchar(255) DEFAULT NULL,
  `Eircode` varchar(7) DEFAULT NULL,
  `CountyId` int(11) DEFAULT NULL,
  `DateCreated` timestamp NOT NULL,
  `DateModified` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `FK_Address_County` (`CountyId`),
  CONSTRAINT `FK_Address_County` FOREIGN KEY (`CountyId`) REFERENCES `County` (`Id`),
  CONSTRAINT `CR_Address_Eircode` CHECK ((isnull(`Eircode`) or regexp_like(`Eircode`,_utf8mb4'^([AC-FHKNPRTV-Y][0-9]{2}|D6W)[0-9AC-FHKNPRTV-Y]{4}$')))
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Address`
--

LOCK TABLES `Address` WRITE;
/*!40000 ALTER TABLE `Address` DISABLE KEYS */;
INSERT INTO `Address` VALUES (1,0,'123 ABC Street',NULL,'A00AAAA',1,'2019-11-24 22:41:30',NULL),(2,0,'456 DEF Street',NULL,'A00AAAC',1,'2019-11-24 22:41:30',NULL),(3,0,'789 GHI Street',NULL,'A00AAAD',1,'2019-11-24 22:41:30',NULL),(4,0,'Big Business','Industrial Center','A00AAAE',1,'2019-11-24 22:41:30',NULL),(5,0,'House',NULL,'A00AAAF',1,'2019-11-24 22:41:30',NULL),(6,1,'123 ABC Street',NULL,'A00AAAA',1,'2019-11-24 22:41:30',NULL),(7,1,'456 DEF Street',NULL,'A00AAAC',1,'2019-11-24 22:41:30',NULL),(8,1,'987 IHG Street',NULL,'A00AACD',1,'2019-11-24 22:41:30',NULL),(9,1,'Big Business','Industrial Center','A00AAAE',1,'2019-11-24 22:41:30',NULL),(10,1,'House',NULL,'A00AAAF',1,'2019-11-24 22:41:30',NULL);
/*!40000 ALTER TABLE `Address` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`admin`@`%`*/ /*!50003 TRIGGER `TR_Address_DC` BEFORE INSERT ON `Address` FOR EACH ROW set new.DateCreated = now() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`admin`@`%`*/ /*!50003 TRIGGER `TR_Address_DM` BEFORE UPDATE ON `Address` FOR EACH ROW set new.DateModified = now() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `BillingRun`
--

DROP TABLE IF EXISTS `BillingRun`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `BillingRun` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `BillingRunStatusId` int(11) DEFAULT NULL,
  `Name` varchar(255) NOT NULL,
  `StartDate` timestamp NOT NULL,
  `EndDate` timestamp NOT NULL,
  `DateCreated` timestamp NOT NULL,
  `DateModified` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `FK_BillingRun_BillingRunStatus` (`BillingRunStatusId`),
  CONSTRAINT `FK_BillingRun_BillingRunStatus` FOREIGN KEY (`BillingRunStatusId`) REFERENCES `BillingRunStatus` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `BillingRun`
--

LOCK TABLES `BillingRun` WRITE;
/*!40000 ALTER TABLE `BillingRun` DISABLE KEYS */;
INSERT INTO `BillingRun` VALUES (1,3,'Sample Billing Run 1','2019-11-20 23:05:31','2019-11-28 23:05:31','2019-11-24 23:09:54',NULL);
/*!40000 ALTER TABLE `BillingRun` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`admin`@`%`*/ /*!50003 TRIGGER `TR_BillingRun_DC` BEFORE INSERT ON `BillingRun` FOR EACH ROW set new.DateCreated = now() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`admin`@`%`*/ /*!50003 TRIGGER `TR_BillingRun_DM` BEFORE UPDATE ON `BillingRun` FOR EACH ROW set new.DateModified = now() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `BillingRunStatus`
--

DROP TABLE IF EXISTS `BillingRunStatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `BillingRunStatus` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `DateCreated` timestamp NOT NULL,
  `DateModified` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `Name` (`Name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `BillingRunStatus`
--

LOCK TABLES `BillingRunStatus` WRITE;
/*!40000 ALTER TABLE `BillingRunStatus` DISABLE KEYS */;
INSERT INTO `BillingRunStatus` VALUES (1,'Completed','2019-11-24 22:35:48',NULL),(2,'In progress','2019-11-24 22:35:48',NULL),(3,'Not started','2019-11-24 22:35:48',NULL),(4,'Cancelled','2019-11-24 22:35:48',NULL),(5,'Deleted','2019-11-24 22:35:48',NULL);
/*!40000 ALTER TABLE `BillingRunStatus` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`admin`@`%`*/ /*!50003 TRIGGER `TR_BillingRunStatus_DC` BEFORE INSERT ON `BillingRunStatus` FOR EACH ROW set new.DateCreated = now() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`admin`@`%`*/ /*!50003 TRIGGER `TR_BillingRunStatus_DM` BEFORE UPDATE ON `BillingRunStatus` FOR EACH ROW set new.DateModified = now() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Contact`
--

DROP TABLE IF EXISTS `Contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Contact` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `CustomerId` int(11) DEFAULT NULL,
  `IsPrimaryContact` tinyint(1) DEFAULT NULL,
  `Email` varchar(255) NOT NULL,
  `FirstName` varchar(255) NOT NULL,
  `LastName` varchar(255) NOT NULL,
  `Phone` varchar(20) NOT NULL,
  `AddressId` int(11) DEFAULT NULL,
  `DateCreated` timestamp NOT NULL,
  `DateModified` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `Email` (`Email`),
  KEY `FK_Contact_Customer` (`CustomerId`),
  KEY `FK_Contact_Address` (`AddressId`),
  CONSTRAINT `FK_Contact_Address` FOREIGN KEY (`AddressId`) REFERENCES `Address` (`Id`),
  CONSTRAINT `FK_Contact_Customer` FOREIGN KEY (`CustomerId`) REFERENCES `Customer` (`Id`),
  CONSTRAINT `CR_Contact_Email` CHECK ((`Email` like _utf8mb4'_%@_%.__%')),
  CONSTRAINT `CR_Contact_Phone` CHECK (regexp_like(`Phone`,_utf8mb4'^[0-9]{10}$'))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Contact`
--

LOCK TABLES `Contact` WRITE;
/*!40000 ALTER TABLE `Contact` DISABLE KEYS */;
INSERT INTO `Contact` VALUES (1,1,1,'jsmith@notarealemail.com','John','Smith','0123456789',1,'2019-11-24 22:48:03',NULL),(2,2,1,'cshop@notarealemail.com','Mr','Manager','1234567890',2,'2019-11-24 22:48:03',NULL),(3,3,1,'jdoe@notarealemail.com','Jane','Doe','2345678901',3,'2019-11-24 22:48:03',NULL),(4,4,1,'conormccauley1999@gmail.com','Mr','CEO','3456789012',4,'2019-11-24 22:48:03','2019-11-25 19:40:19'),(5,5,1,'someguy@notarealemail.com','Some','Guy','4567890123',5,'2019-11-24 22:48:03',NULL);
/*!40000 ALTER TABLE `Contact` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`admin`@`%`*/ /*!50003 TRIGGER `TR_Contact_DC` BEFORE INSERT ON `Contact` FOR EACH ROW set new.DateCreated = now() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`admin`@`%`*/ /*!50003 TRIGGER `TR_Contact_DM` BEFORE UPDATE ON `Contact` FOR EACH ROW set new.DateModified = now() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `ConvertedMeterReadingValue`
--

DROP TABLE IF EXISTS `ConvertedMeterReadingValue`;
/*!50001 DROP VIEW IF EXISTS `ConvertedMeterReadingValue`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `ConvertedMeterReadingValue` AS SELECT 
 1 AS `MeterReadingId`,
 1 AS `Timestamp`,
 1 AS `ConvertedValue`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `County`
--

DROP TABLE IF EXISTS `County`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `County` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `DateCreated` timestamp NOT NULL,
  `DateModified` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `Name` (`Name`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `County`
--

LOCK TABLES `County` WRITE;
/*!40000 ALTER TABLE `County` DISABLE KEYS */;
INSERT INTO `County` VALUES (1,'Antrim','2019-11-24 22:36:10',NULL),(2,'Armagh','2019-11-24 22:36:10',NULL),(3,'Carlow','2019-11-24 22:36:10',NULL),(4,'Cavan','2019-11-24 22:36:10',NULL),(5,'Clare','2019-11-24 22:36:10',NULL),(6,'Cork','2019-11-24 22:36:10',NULL),(7,'Derry','2019-11-24 22:36:10',NULL),(8,'Donegal','2019-11-24 22:36:10',NULL),(9,'Down','2019-11-24 22:36:10',NULL),(10,'Dublin','2019-11-24 22:36:10',NULL),(11,'Fermanagh','2019-11-24 22:36:10',NULL),(12,'Galway','2019-11-24 22:36:10',NULL),(13,'Kerry','2019-11-24 22:36:10',NULL),(14,'Kildare','2019-11-24 22:36:10',NULL),(15,'Kilkenny','2019-11-24 22:36:10',NULL),(16,'Laois','2019-11-24 22:36:10',NULL),(17,'Leitrim','2019-11-24 22:36:10',NULL),(18,'Limerick','2019-11-24 22:36:10',NULL),(19,'Longford','2019-11-24 22:36:10',NULL),(20,'Louth','2019-11-24 22:36:10',NULL),(21,'Mayo','2019-11-24 22:36:10',NULL),(22,'Meath','2019-11-24 22:36:10',NULL),(23,'Monaghan','2019-11-24 22:36:10',NULL),(24,'Offaly','2019-11-24 22:36:10',NULL),(25,'Roscommon','2019-11-24 22:36:10',NULL),(26,'Sligo','2019-11-24 22:36:10',NULL),(27,'Tipperary','2019-11-24 22:36:10',NULL),(28,'Tyrone','2019-11-24 22:36:10',NULL),(29,'Waterford','2019-11-24 22:36:10',NULL),(30,'Westmeath','2019-11-24 22:36:10',NULL),(31,'Wexford','2019-11-24 22:36:10',NULL),(32,'Wicklow','2019-11-24 22:36:10',NULL);
/*!40000 ALTER TABLE `County` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`admin`@`%`*/ /*!50003 TRIGGER `TR_County_DC` BEFORE INSERT ON `County` FOR EACH ROW set new.DateCreated = now() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`admin`@`%`*/ /*!50003 TRIGGER `TR_County_DM` BEFORE UPDATE ON `County` FOR EACH ROW set new.DateModified = now() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Customer`
--

DROP TABLE IF EXISTS `Customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Customer` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `CustomerStatusId` int(11) DEFAULT NULL,
  `Name` varchar(255) NOT NULL,
  `DateCreated` timestamp NOT NULL,
  `DateModified` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `FK_Customer_CustomerStatus` (`CustomerStatusId`),
  CONSTRAINT `FK_Customer_CustomerStatus` FOREIGN KEY (`CustomerStatusId`) REFERENCES `CustomerStatus` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Customer`
--

LOCK TABLES `Customer` WRITE;
/*!40000 ALTER TABLE `Customer` DISABLE KEYS */;
INSERT INTO `Customer` VALUES (1,1,'John Smith Household','2019-11-24 22:45:03',NULL),(2,1,'Corner Shop','2019-11-24 22:45:03',NULL),(3,1,'Jane Doe Household','2019-11-24 22:45:03',NULL),(4,1,'Important Business','2019-11-24 22:45:03',NULL),(5,1,'Some House','2019-11-24 22:45:03',NULL);
/*!40000 ALTER TABLE `Customer` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`admin`@`%`*/ /*!50003 TRIGGER `TR_Customer_DC` BEFORE INSERT ON `Customer` FOR EACH ROW set new.DateCreated = now() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`admin`@`%`*/ /*!50003 TRIGGER `TR_Customer_DM` BEFORE UPDATE ON `Customer` FOR EACH ROW set new.DateModified = now() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `CustomerStatus`
--

DROP TABLE IF EXISTS `CustomerStatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CustomerStatus` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `DateCreated` timestamp NOT NULL,
  `DateModified` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `Name` (`Name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CustomerStatus`
--

LOCK TABLES `CustomerStatus` WRITE;
/*!40000 ALTER TABLE `CustomerStatus` DISABLE KEYS */;
INSERT INTO `CustomerStatus` VALUES (1,'Active','2019-11-24 22:35:48',NULL),(2,'Inactive','2019-11-24 22:35:48',NULL),(3,'Deleted','2019-11-24 22:35:48',NULL);
/*!40000 ALTER TABLE `CustomerStatus` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`admin`@`%`*/ /*!50003 TRIGGER `TR_CustomerStatus_DC` BEFORE INSERT ON `CustomerStatus` FOR EACH ROW set new.DateCreated = now() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`admin`@`%`*/ /*!50003 TRIGGER `TR_CustomerStatus_DM` BEFORE UPDATE ON `CustomerStatus` FOR EACH ROW set new.DateModified = now() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `EmailQueue`
--

DROP TABLE IF EXISTS `EmailQueue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `EmailQueue` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `IsSent` tinyint(1) DEFAULT NULL,
  `Recipient` varchar(255) NOT NULL,
  `Subject` varchar(255) NOT NULL,
  `Body` text NOT NULL,
  `DateCreated` timestamp NOT NULL,
  `DateModified` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `CR_EmailQueue_Recipient` CHECK ((`Recipient` like _utf8mb4'_%@_%.__%'))
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `EmailQueue`
--

LOCK TABLES `EmailQueue` WRITE;
/*!40000 ALTER TABLE `EmailQueue` DISABLE KEYS */;
INSERT INTO `EmailQueue` VALUES (9,0,'jsmith@notarealemail.com','Invoice for John Smith Household (28/11/2019)','Dear John Smith Household,\nYou are being charged €0.65 for energy used from 20/11/2019 to 28/11/2019.\n\n10000000001 (Electricity): 9 (kWh) => 9 (kWh) => €1.3059 (at 0.1451 € per kWh)\n','2019-11-28 17:36:09',NULL);
/*!40000 ALTER TABLE `EmailQueue` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`admin`@`%`*/ /*!50003 TRIGGER `TR_EmailQueue_DC` BEFORE INSERT ON `EmailQueue` FOR EACH ROW set new.DateCreated = now() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`admin`@`%`*/ /*!50003 TRIGGER `TR_EmailQueue_DM` BEFORE UPDATE ON `EmailQueue` FOR EACH ROW set new.DateModified = now() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Invoice`
--

DROP TABLE IF EXISTS `Invoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Invoice` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `InvoiceStatusId` int(11) DEFAULT NULL,
  `BillingRunId` int(11) DEFAULT NULL,
  `CustomerId` int(11) DEFAULT NULL,
  `Amount` double NOT NULL,
  `DateCreated` timestamp NOT NULL,
  `DateModified` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `FK_Invoice_InvoiceStatus` (`InvoiceStatusId`),
  KEY `FK_Invoice_BillingRun` (`BillingRunId`),
  KEY `FK_Invoice_Customer` (`CustomerId`),
  CONSTRAINT `FK_Invoice_BillingRun` FOREIGN KEY (`BillingRunId`) REFERENCES `BillingRun` (`Id`),
  CONSTRAINT `FK_Invoice_Customer` FOREIGN KEY (`CustomerId`) REFERENCES `Customer` (`Id`),
  CONSTRAINT `FK_Invoice_InvoiceStatus` FOREIGN KEY (`InvoiceStatusId`) REFERENCES `InvoiceStatus` (`Id`),
  CONSTRAINT `CR_Invoice_Amount` CHECK ((`Amount` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Invoice`
--

LOCK TABLES `Invoice` WRITE;
/*!40000 ALTER TABLE `Invoice` DISABLE KEYS */;
INSERT INTO `Invoice` VALUES (41,1,1,1,0.65,'2019-11-25 19:24:06','2019-11-28 17:36:09'),(42,4,1,2,0.61,'2019-11-25 19:24:06',NULL),(43,4,1,3,1.74,'2019-11-25 19:24:06',NULL),(44,1,1,4,32.1,'2019-11-25 19:24:06','2019-11-25 22:47:04'),(45,4,1,5,1,'2019-11-25 19:24:06',NULL),(48,4,1,1,0.65,'2019-11-28 17:34:17',NULL),(49,4,1,2,0.61,'2019-11-28 17:34:17',NULL),(50,4,1,3,1.74,'2019-11-28 17:34:17',NULL),(51,4,1,4,32.1,'2019-11-28 17:34:17',NULL),(52,4,1,5,1,'2019-11-28 17:34:17',NULL);
/*!40000 ALTER TABLE `Invoice` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`admin`@`%`*/ /*!50003 TRIGGER `TR_Invoice_DC` BEFORE INSERT ON `Invoice` FOR EACH ROW set new.DateCreated = now() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`admin`@`%`*/ /*!50003 TRIGGER `TR_Invoice_DM` BEFORE UPDATE ON `Invoice` FOR EACH ROW set new.DateModified = now() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`admin`@`%`*/ /*!50003 TRIGGER `TR_Invoice_Approved` AFTER UPDATE ON `Invoice` FOR EACH ROW begin
	if new.InvoiceStatusId = 2 then call SendInvoiceEmail(new.Id);
	end if;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `InvoiceEmailContent`
--

DROP TABLE IF EXISTS `InvoiceEmailContent`;
/*!50001 DROP VIEW IF EXISTS `InvoiceEmailContent`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `InvoiceEmailContent` AS SELECT 
 1 AS `InvoiceId`,
 1 AS `BillingRunId`,
 1 AS `Customer`,
 1 AS `ExternalIdentifier`,
 1 AS `MeterType`,
 1 AS `UnitSymbol`,
 1 AS `InvoiceAmount`,
 1 AS `MarketPrice`,
 1 AS `OriginalValue`,
 1 AS `ConvertedValue`,
 1 AS `MeterAmount`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `InvoiceMeter`
--

DROP TABLE IF EXISTS `InvoiceMeter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `InvoiceMeter` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `InvoiceId` int(11) DEFAULT NULL,
  `MeterId` int(11) DEFAULT NULL,
  `DateCreated` timestamp NOT NULL,
  `DateModified` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `FK_InvoiceMeter_Invoice` (`InvoiceId`),
  KEY `FK_InvoiceMeter_Meter` (`MeterId`),
  CONSTRAINT `FK_InvoiceMeter_Invoice` FOREIGN KEY (`InvoiceId`) REFERENCES `Invoice` (`Id`),
  CONSTRAINT `FK_InvoiceMeter_Meter` FOREIGN KEY (`MeterId`) REFERENCES `Meter` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=113 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `InvoiceMeter`
--

LOCK TABLES `InvoiceMeter` WRITE;
/*!40000 ALTER TABLE `InvoiceMeter` DISABLE KEYS */;
INSERT INTO `InvoiceMeter` VALUES (91,41,7,'2019-11-25 19:24:06',NULL),(92,42,8,'2019-11-25 19:24:06',NULL),(93,43,9,'2019-11-25 19:24:06',NULL),(94,44,10,'2019-11-25 19:24:06',NULL),(95,44,11,'2019-11-25 19:24:06',NULL),(96,45,12,'2019-11-25 19:24:06',NULL),(98,41,7,'2019-11-28 17:34:17',NULL),(99,48,7,'2019-11-28 17:34:17',NULL),(100,42,8,'2019-11-28 17:34:17',NULL),(101,49,8,'2019-11-28 17:34:17',NULL),(102,43,9,'2019-11-28 17:34:17',NULL),(103,50,9,'2019-11-28 17:34:17',NULL),(104,51,10,'2019-11-28 17:34:17',NULL),(105,51,11,'2019-11-28 17:34:17',NULL),(106,45,12,'2019-11-28 17:34:17',NULL),(107,52,12,'2019-11-28 17:34:17',NULL);
/*!40000 ALTER TABLE `InvoiceMeter` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`admin`@`%`*/ /*!50003 TRIGGER `TR_InvoiceMeter_DC` BEFORE INSERT ON `InvoiceMeter` FOR EACH ROW set new.DateCreated = now() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`admin`@`%`*/ /*!50003 TRIGGER `TR_InvoiceMeter_DM` BEFORE UPDATE ON `InvoiceMeter` FOR EACH ROW set new.DateModified = now() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `InvoiceStatus`
--

DROP TABLE IF EXISTS `InvoiceStatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `InvoiceStatus` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `DateCreated` timestamp NOT NULL,
  `DateModified` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `Name` (`Name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `InvoiceStatus`
--

LOCK TABLES `InvoiceStatus` WRITE;
/*!40000 ALTER TABLE `InvoiceStatus` DISABLE KEYS */;
INSERT INTO `InvoiceStatus` VALUES (1,'Sent','2019-11-24 22:35:48',NULL),(2,'Approved','2019-11-24 22:35:48',NULL),(3,'Rejected','2019-11-24 22:35:48',NULL),(4,'Awaiting approval','2019-11-24 22:35:48',NULL),(5,'Cancelled','2019-11-24 22:35:48',NULL),(6,'Deleted','2019-11-24 22:35:48',NULL);
/*!40000 ALTER TABLE `InvoiceStatus` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`admin`@`%`*/ /*!50003 TRIGGER `TR_InvoiceStatus_DC` BEFORE INSERT ON `InvoiceStatus` FOR EACH ROW set new.DateCreated = now() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`admin`@`%`*/ /*!50003 TRIGGER `TR_InvoiceStatus_DM` BEFORE UPDATE ON `InvoiceStatus` FOR EACH ROW set new.DateModified = now() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `MarketPrice`
--

DROP TABLE IF EXISTS `MarketPrice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MarketPrice` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `MarketPriceTypeId` int(11) DEFAULT NULL,
  `Timestamp` timestamp NOT NULL,
  `Value` double NOT NULL,
  `DateCreated` timestamp NOT NULL,
  `DateModified` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `FK_MarketPrice_MarketPriceType` (`MarketPriceTypeId`),
  CONSTRAINT `FK_MarketPrice_MarketPriceType` FOREIGN KEY (`MarketPriceTypeId`) REFERENCES `MarketPriceType` (`Id`),
  CONSTRAINT `CR_MarketPrice_Value` CHECK ((`Value` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MarketPrice`
--

LOCK TABLES `MarketPrice` WRITE;
/*!40000 ALTER TABLE `MarketPrice` DISABLE KEYS */;
INSERT INTO `MarketPrice` VALUES (1,3,'2019-11-25 15:53:27',0.1451,'2019-11-25 15:53:27',NULL);
/*!40000 ALTER TABLE `MarketPrice` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`admin`@`%`*/ /*!50003 TRIGGER `TR_MarketPrice_DC` BEFORE INSERT ON `MarketPrice` FOR EACH ROW set new.DateCreated = now() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`admin`@`%`*/ /*!50003 TRIGGER `TR_MarketPrice_DM` BEFORE UPDATE ON `MarketPrice` FOR EACH ROW set new.DateModified = now() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `MarketPriceType`
--

DROP TABLE IF EXISTS `MarketPriceType`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MarketPriceType` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `DateCreated` timestamp NOT NULL,
  `DateModified` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `Name` (`Name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MarketPriceType`
--

LOCK TABLES `MarketPriceType` WRITE;
/*!40000 ALTER TABLE `MarketPriceType` DISABLE KEYS */;
INSERT INTO `MarketPriceType` VALUES (3,'Cost per kWh in Euros','2019-11-25 15:51:34',NULL);
/*!40000 ALTER TABLE `MarketPriceType` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`admin`@`%`*/ /*!50003 TRIGGER `TR_MarketPriceType_DC` BEFORE INSERT ON `MarketPriceType` FOR EACH ROW set new.DateCreated = now() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`admin`@`%`*/ /*!50003 TRIGGER `TR_MarketPriceType_DM` BEFORE UPDATE ON `MarketPriceType` FOR EACH ROW set new.DateModified = now() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Meter`
--

DROP TABLE IF EXISTS `Meter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Meter` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `MeterTypeId` int(11) DEFAULT NULL,
  `MeterStatusId` int(11) DEFAULT NULL,
  `CustomerId` int(11) DEFAULT NULL,
  `ExternalIdentifier` varchar(20) NOT NULL,
  `AddressId` int(11) DEFAULT NULL,
  `DateCreated` timestamp NOT NULL,
  `DateModified` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `ExternalIdentifier` (`ExternalIdentifier`),
  KEY `FK_Meter_MeterType` (`MeterTypeId`),
  KEY `FK_Meter_MeterStatus` (`MeterStatusId`),
  KEY `FK_Meter_Customer` (`CustomerId`),
  KEY `FK_Meter_Address` (`AddressId`),
  CONSTRAINT `FK_Meter_Address` FOREIGN KEY (`AddressId`) REFERENCES `Address` (`Id`),
  CONSTRAINT `FK_Meter_Customer` FOREIGN KEY (`CustomerId`) REFERENCES `Customer` (`Id`),
  CONSTRAINT `FK_Meter_MeterStatus` FOREIGN KEY (`MeterStatusId`) REFERENCES `MeterStatus` (`Id`),
  CONSTRAINT `FK_Meter_MeterType` FOREIGN KEY (`MeterTypeId`) REFERENCES `MeterType` (`Id`),
  CONSTRAINT `CR_Meter_ExternalIdentifier` CHECK ((((`MeterTypeId` = 1) and regexp_like(`ExternalIdentifier`,_utf8mb4'^10[0-9]{9}$')) or ((`MeterTypeId` = 2) and regexp_like(`ExternalIdentifier`,_utf8mb4'^[0-9]{7}$'))))
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Meter`
--

LOCK TABLES `Meter` WRITE;
/*!40000 ALTER TABLE `Meter` DISABLE KEYS */;
INSERT INTO `Meter` VALUES (7,1,1,1,'10000000001',6,'2019-11-24 23:01:55',NULL),(8,1,1,2,'10000000002',7,'2019-11-24 23:01:55',NULL),(9,1,1,3,'10000000003',8,'2019-11-24 23:01:55',NULL),(10,1,1,4,'10000000004',9,'2019-11-24 23:01:55',NULL),(11,2,1,4,'1234567',9,'2019-11-24 23:01:55',NULL),(12,1,1,5,'10000000005',10,'2019-11-24 23:01:55',NULL);
/*!40000 ALTER TABLE `Meter` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`admin`@`%`*/ /*!50003 TRIGGER `TR_Meter_DC` BEFORE INSERT ON `Meter` FOR EACH ROW set new.DateCreated = now() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`admin`@`%`*/ /*!50003 TRIGGER `TR_Meter_DM` BEFORE UPDATE ON `Meter` FOR EACH ROW set new.DateModified = now() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `MeterInvoiceIdPairs`
--

DROP TABLE IF EXISTS `MeterInvoiceIdPairs`;
/*!50001 DROP VIEW IF EXISTS `MeterInvoiceIdPairs`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `MeterInvoiceIdPairs` AS SELECT 
 1 AS `BillingRunId`,
 1 AS `MeterId`,
 1 AS `InvoiceId`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `MeterReading`
--

DROP TABLE IF EXISTS `MeterReading`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MeterReading` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `MeterId` int(11) DEFAULT NULL,
  `Timestamp` timestamp NOT NULL,
  `Value` double NOT NULL,
  `DateCreated` timestamp NOT NULL,
  `DateModified` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `FK_MeterReading_Meter` (`MeterId`),
  CONSTRAINT `FK_MeterReading_Meter` FOREIGN KEY (`MeterId`) REFERENCES `Meter` (`Id`),
  CONSTRAINT `CR_MeterReading_Value` CHECK ((`Value` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MeterReading`
--

LOCK TABLES `MeterReading` WRITE;
/*!40000 ALTER TABLE `MeterReading` DISABLE KEYS */;
INSERT INTO `MeterReading` VALUES (1,7,'2019-11-24 23:05:31',4.5,'2019-11-24 23:05:31',NULL),(2,8,'2019-11-24 23:05:31',4.2,'2019-11-24 23:05:31',NULL),(3,9,'2019-11-24 23:05:31',12,'2019-11-24 23:05:31',NULL),(4,10,'2019-11-24 23:05:31',101.1,'2019-11-24 23:05:31',NULL),(5,11,'2019-11-24 23:05:31',1234.5,'2019-11-24 23:05:31',NULL),(6,12,'2019-11-24 23:05:31',6.9,'2019-11-24 23:05:31',NULL);
/*!40000 ALTER TABLE `MeterReading` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`admin`@`%`*/ /*!50003 TRIGGER `TR_MeterReading_DC` BEFORE INSERT ON `MeterReading` FOR EACH ROW set new.DateCreated = now() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`admin`@`%`*/ /*!50003 TRIGGER `TR_MeterReading_DM` BEFORE UPDATE ON `MeterReading` FOR EACH ROW set new.DateModified = now() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `MeterStatus`
--

DROP TABLE IF EXISTS `MeterStatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MeterStatus` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `DateCreated` timestamp NOT NULL,
  `DateModified` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `Name` (`Name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MeterStatus`
--

LOCK TABLES `MeterStatus` WRITE;
/*!40000 ALTER TABLE `MeterStatus` DISABLE KEYS */;
INSERT INTO `MeterStatus` VALUES (1,'Active','2019-11-24 22:35:48',NULL),(2,'Inactive','2019-11-24 22:35:48',NULL),(3,'Deleted','2019-11-24 22:35:48',NULL),(4,'Awaiting approval','2019-11-24 22:35:48',NULL);
/*!40000 ALTER TABLE `MeterStatus` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`admin`@`%`*/ /*!50003 TRIGGER `TR_MeterStatus_DC` BEFORE INSERT ON `MeterStatus` FOR EACH ROW set new.DateCreated = now() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`admin`@`%`*/ /*!50003 TRIGGER `TR_MeterStatus_DM` BEFORE UPDATE ON `MeterStatus` FOR EACH ROW set new.DateModified = now() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `MeterType`
--

DROP TABLE IF EXISTS `MeterType`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MeterType` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `UnitId` int(11) DEFAULT NULL,
  `Name` varchar(255) NOT NULL,
  `DateCreated` timestamp NOT NULL,
  `DateModified` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `Name` (`Name`),
  KEY `FK_MeterType_Unit` (`UnitId`),
  CONSTRAINT `FK_MeterType_Unit` FOREIGN KEY (`UnitId`) REFERENCES `Unit` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MeterType`
--

LOCK TABLES `MeterType` WRITE;
/*!40000 ALTER TABLE `MeterType` DISABLE KEYS */;
INSERT INTO `MeterType` VALUES (1,1,'Electricity','2019-11-24 22:36:08','2019-11-24 23:01:24'),(2,2,'Gas','2019-11-24 22:36:08','2019-11-24 23:01:29');
/*!40000 ALTER TABLE `MeterType` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`admin`@`%`*/ /*!50003 TRIGGER `TR_MeterType_DC` BEFORE INSERT ON `MeterType` FOR EACH ROW set new.DateCreated = now() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`admin`@`%`*/ /*!50003 TRIGGER `TR_MeterType_DM` BEFORE UPDATE ON `MeterType` FOR EACH ROW set new.DateModified = now() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `MeterUsageOverview`
--

DROP TABLE IF EXISTS `MeterUsageOverview`;
/*!50001 DROP VIEW IF EXISTS `MeterUsageOverview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `MeterUsageOverview` AS SELECT 
 1 AS `CustomerId`,
 1 AS `MeterId`,
 1 AS `MeterReadingId`,
 1 AS `ExternalIdentifier`,
 1 AS `Customer`,
 1 AS `MeterType`,
 1 AS `Unit`,
 1 AS `UnitSymbol`,
 1 AS `OriginalValue`,
 1 AS `ConvertedValue`,
 1 AS `Timestamp`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `Unit`
--

DROP TABLE IF EXISTS `Unit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Unit` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Symbol` varchar(255) NOT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `ConversionFactor` double NOT NULL,
  `DateCreated` timestamp NOT NULL,
  `DateModified` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `Symbol` (`Symbol`,`Name`),
  CONSTRAINT `CR_Unit_ConversionFactor` CHECK ((`ConversionFactor` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Unit`
--

LOCK TABLES `Unit` WRITE;
/*!40000 ALTER TABLE `Unit` DISABLE KEYS */;
INSERT INTO `Unit` VALUES (1,'kWh','Kilowatt hour',1,'2019-11-24 22:36:06',NULL),(2,'m3','Cubic metres',0.09729,'2019-11-24 22:36:06',NULL);
/*!40000 ALTER TABLE `Unit` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`admin`@`%`*/ /*!50003 TRIGGER `TR_Unit_DC` BEFORE INSERT ON `Unit` FOR EACH ROW set new.DateCreated = now() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`admin`@`%`*/ /*!50003 TRIGGER `TR_Unit_DM` BEFORE UPDATE ON `Unit` FOR EACH ROW set new.DateModified = now() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `User`
--

DROP TABLE IF EXISTS `User`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `User` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `UserTypeId` int(11) DEFAULT NULL,
  `UserStatusId` int(11) DEFAULT NULL,
  `Email` varchar(255) NOT NULL,
  `Username` varchar(255) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `PasswordSalt` varchar(255) NOT NULL,
  `DateCreated` timestamp NOT NULL,
  `DateModified` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `Email` (`Email`),
  UNIQUE KEY `Username` (`Username`),
  KEY `FK_User_UserType` (`UserTypeId`),
  KEY `FK_User_UserStatus` (`UserStatusId`),
  CONSTRAINT `FK_User_UserStatus` FOREIGN KEY (`UserStatusId`) REFERENCES `UserStatus` (`Id`),
  CONSTRAINT `FK_User_UserType` FOREIGN KEY (`UserTypeId`) REFERENCES `UserType` (`Id`),
  CONSTRAINT `CR_User_Email` CHECK ((`Email` like _utf8mb4'_%@_%.__%'))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User`
--

LOCK TABLES `User` WRITE;
/*!40000 ALTER TABLE `User` DISABLE KEYS */;
INSERT INTO `User` VALUES (1,1,1,'conormccauley1999@gmail.com','admin','1a792317d4afb889b4175b49235b754b24fd157df4d4049a0875a04a17ab825c','QWERTYUI','2019-11-24 22:35:55',NULL),(2,2,1,'power@notanemail.com','powerUser1','98ef744681a79df309cfdc7b4f5867b7a8415b27a90c6e6f901734b42aaa9a99','ASDFGHJK','2019-11-24 22:35:55',NULL),(3,3,1,'general@notanemail.com','generalUser1','d3d5520aefa07cf6817e3c80ea61f16a8135703cff7e2797591c29c8dee231ff','ZXCVBNMZ','2019-11-24 22:35:55',NULL),(4,4,1,'tester@notanemail.com','tester1','72676277c4af9d6c3c5f457f89b4d8b6b92b3f9618a9ee37224272efaae29a31','1QAZ2WSX','2019-11-24 22:35:55',NULL),(5,5,1,'demo@notanemail.com','demo1','a5e1f6dd34ed3e928ca0b9912a84755b3dd11b4d1d9c0f6e7d915012d0938801','3EDC4RFV','2019-11-24 22:35:55',NULL);
/*!40000 ALTER TABLE `User` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`admin`@`%`*/ /*!50003 TRIGGER `TR_User_DC` BEFORE INSERT ON `User` FOR EACH ROW set new.DateCreated = now() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`admin`@`%`*/ /*!50003 TRIGGER `TR_User_DM` BEFORE UPDATE ON `User` FOR EACH ROW set new.DateModified = now() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `UserStatus`
--

DROP TABLE IF EXISTS `UserStatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UserStatus` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `DateCreated` timestamp NOT NULL,
  `DateModified` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `Name` (`Name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `UserStatus`
--

LOCK TABLES `UserStatus` WRITE;
/*!40000 ALTER TABLE `UserStatus` DISABLE KEYS */;
INSERT INTO `UserStatus` VALUES (1,'Active','2019-11-24 22:35:48',NULL),(2,'Inactive','2019-11-24 22:35:48',NULL),(3,'Deleted','2019-11-24 22:35:48',NULL);
/*!40000 ALTER TABLE `UserStatus` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`admin`@`%`*/ /*!50003 TRIGGER `TR_UserStatus_DC` BEFORE INSERT ON `UserStatus` FOR EACH ROW set new.DateCreated = now() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`admin`@`%`*/ /*!50003 TRIGGER `TR_UserStatus_DM` BEFORE UPDATE ON `UserStatus` FOR EACH ROW set new.DateModified = now() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `UserType`
--

DROP TABLE IF EXISTS `UserType`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UserType` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `DateCreated` timestamp NOT NULL,
  `DateModified` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `Name` (`Name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `UserType`
--

LOCK TABLES `UserType` WRITE;
/*!40000 ALTER TABLE `UserType` DISABLE KEYS */;
INSERT INTO `UserType` VALUES (1,'Administrator','2019-11-24 22:35:53',NULL),(2,'Power User','2019-11-24 22:35:53',NULL),(3,'General Worker','2019-11-24 22:35:53',NULL),(4,'Demonstrator','2019-11-24 22:35:53',NULL),(5,'Tester','2019-11-24 22:35:53',NULL);
/*!40000 ALTER TABLE `UserType` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`admin`@`%`*/ /*!50003 TRIGGER `TR_UserType_DC` BEFORE INSERT ON `UserType` FOR EACH ROW set new.DateCreated = now() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`admin`@`%`*/ /*!50003 TRIGGER `TR_UserType_DM` BEFORE UPDATE ON `UserType` FOR EACH ROW set new.DateModified = now() */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping events for database 'energycrm'
--

--
-- Dumping routines for database 'energycrm'
--
/*!50003 DROP FUNCTION IF EXISTS `GetMarketPrice` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` FUNCTION `GetMarketPrice`(MarketPriceTypeId int) RETURNS double
begin
    return (select `Value` from MarketPrice mp where mp.MarketPriceTypeId = MarketPriceTypeId order by mp.`Timestamp` desc limit 1);
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GenerateBillingRunInvoices` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `GenerateBillingRunInvoices`(in BillingRunId int)
begin

    # Get the start and end dates of the billing run:
    call GetBillingRunDates(BillingRunId, @startDate, @endDate);
    # Get the latest market price (€ per kWh)
    set @marketPrice = GetMarketPrice(3);
    
    # Insert data into the Invoice table
    insert into Invoice (InvoiceStatusId, BillingRunId, CustomerId, Amount)
    select 4, BillingRunId, mu.CustomerId, round(sum(mu.ConvertedValue) * @marketPrice, 2)
    from MeterUsageOverview mu
    where mu.`Timestamp` between @startDate and @endDate
    group by mu.CustomerId;
    
    # Insert data into the InvoiceMeter table
    insert into InvoiceMeter (MeterId, InvoiceId)
    select MeterId, InvoiceId
    from MeterInvoiceIdPairs mi
    where mi.BillingRunId = BillingRunId;
    
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetBillingRunDates` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `GetBillingRunDates`(
	in BillingRunId int,
    out StartDate timestamp,
    out EndDate timestamp
)
begin
    select br.StartDate into StartDate from BillingRun br where br.Id = BillingRunId;
    select br.EndDate into EndDate from BillingRun br where br.Id = BillingRunId;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SendInvoiceEmail` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`%` PROCEDURE `SendInvoiceEmail`(in InvoiceId int)
begin
	
    # Variables we'll fetch from the cursor
    declare externalId varchar(20);
    declare meterType, unitSymbol varchar(255);
    declare originalValue, convertedValue, meterAmount, marketPrice real;
    
    # Meter cursor and flag
    declare done bool default false;
	declare meterCursor cursor for (
		select ic.ExternalIdentifier, ic.MeterType, ic.OriginalValue, ic.UnitSymbol, ic.ConvertedValue, ic.MeterAmount, ic.MarketPrice
        from InvoiceEmailContent ic
        where ic.InvoiceId = InvoiceId
	);
    declare continue handler for not found set done = true;
    
	# Get some key information:
	set @customerName = (select Customer from InvoiceEmailContent ic where ic.InvoiceId = InvoiceId limit 1);
	set @invoiceAmount = (select InvoiceAmount from InvoiceEmailContent ic where ic.InvoiceId = InvoiceId limit 1);
    set @billingRunId = (select BillingRunId from InvoiceEmailContent ic where ic.InvoiceId = InvoiceId limit 1);
    set @emailRecipient = (select co.Email from Contact co join Customer c on c.Id = co.CustomerId where c.`Name` = @customerName and co.IsPrimaryContact);
    call GetBillingRunDates(@billingRunId, @startDate, @endDate);
    
    # Format some important dates
    set @invoiceDate = date_format(current_date(), '%d/%m/%Y');
    set @formatStartDate = date_format(@startDate, '%d/%m/%Y');
    set @formatEndDate = date_format(@endDate, '%d/%m/%Y');
    
    # Generate email subject
    set @emailSubject = concat('Invoice for ', @customerName, ' (', @invoiceDate, ')');
    
    # Generate start of email body
    set @emailBody = concat(
		'Dear ', @customerName, ',\n',
        'You are being charged €', @invoiceAmount, ' for energy used from ', @formatStartDate, ' to ', @formatEndDate, '.\n\n'
	);
    
    # Generate invoice breakdown for email body
    open meterCursor;
    meterLoop: loop
		fetch meterCursor into externalId, meterType, originalValue, unitSymbol, convertedValue, meterAmount, marketPrice;
        if done then leave meterLoop; end if;
        set @emailBody = concat(
			@emailBody,
            externalId, ' (', meterType, '): ', originalValue, ' (', unitSymbol, ') => ', convertedValue, ' (kWh) => €', meterAmount, ' (at ', marketPrice, ' € per kWh)\n'
		);
    end loop;
    close meterCursor;
    
    # Insert the email into the queue
    insert into EmailQueue (IsSent, Recipient, `Subject`, Body)
    select 0, @emailRecipient, @emailSubject, @emailBody;
    
    # Set the invoice to sent
    update Invoice set InvoiceStatusId = 1 where Id = InvoiceId;
    
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `ConvertedMeterReadingValue`
--

/*!50001 DROP VIEW IF EXISTS `ConvertedMeterReadingValue`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`admin`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `ConvertedMeterReadingValue` AS select `r`.`Id` AS `MeterReadingId`,`r`.`Timestamp` AS `Timestamp`,(`u`.`ConversionFactor` * `r`.`Value`) AS `ConvertedValue` from (((`MeterReading` `r` join `Meter` `m` on((`m`.`Id` = `r`.`MeterId`))) join `MeterType` `t` on((`t`.`Id` = `m`.`MeterTypeId`))) join `Unit` `u` on((`u`.`Id` = `t`.`UnitId`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `InvoiceEmailContent`
--

/*!50001 DROP VIEW IF EXISTS `InvoiceEmailContent`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`admin`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `InvoiceEmailContent` AS select `i`.`Id` AS `InvoiceId`,`i`.`BillingRunId` AS `BillingRunId`,`mu`.`Customer` AS `Customer`,`mu`.`ExternalIdentifier` AS `ExternalIdentifier`,`mu`.`MeterType` AS `MeterType`,`mu`.`UnitSymbol` AS `UnitSymbol`,`i`.`Amount` AS `InvoiceAmount`,round(`GetMarketPrice`(3),4) AS `MarketPrice`,round(sum(`mu`.`OriginalValue`),4) AS `OriginalValue`,round(sum(`mu`.`ConvertedValue`),4) AS `ConvertedValue`,round((sum(`mu`.`ConvertedValue`) * `GetMarketPrice`(3)),4) AS `MeterAmount` from (((`MeterUsageOverview` `mu` join `InvoiceMeter` `im` on((`im`.`MeterId` = `mu`.`MeterId`))) join `Invoice` `i` on((`i`.`Id` = `im`.`InvoiceId`))) join `BillingRun` `b` on((`b`.`Id` = `i`.`BillingRunId`))) where (`mu`.`Timestamp` between `b`.`StartDate` and `b`.`EndDate`) group by `i`.`Id`,`i`.`BillingRunId`,`mu`.`Customer`,`mu`.`ExternalIdentifier`,`mu`.`MeterType`,`mu`.`UnitSymbol`,`i`.`Amount` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `MeterInvoiceIdPairs`
--

/*!50001 DROP VIEW IF EXISTS `MeterInvoiceIdPairs`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`admin`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `MeterInvoiceIdPairs` AS select distinct `b`.`Id` AS `BillingRunId`,`m`.`Id` AS `MeterId`,`i`.`Id` AS `InvoiceId` from (((((`MeterReading` `mr` join `Meter` `m` on((`m`.`Id` = `mr`.`MeterId`))) join `MeterReading`) join `Customer` `c` on((`c`.`Id` = `m`.`CustomerId`))) join `Invoice` `i` on((`i`.`CustomerId` = `c`.`Id`))) join `BillingRun` `b` on((`b`.`Id` = `i`.`BillingRunId`))) where ((`mr`.`Timestamp` between `b`.`StartDate` and `b`.`EndDate`) and (`i`.`InvoiceStatusId` = 4) and (`c`.`CustomerStatusId` = 1) and (`m`.`MeterStatusId` = 1)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `MeterUsageOverview`
--

/*!50001 DROP VIEW IF EXISTS `MeterUsageOverview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`admin`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `MeterUsageOverview` AS select `c`.`Id` AS `CustomerId`,`m`.`Id` AS `MeterId`,`mr`.`Id` AS `MeterReadingId`,`m`.`ExternalIdentifier` AS `ExternalIdentifier`,`c`.`Name` AS `Customer`,`mt`.`Name` AS `MeterType`,`u`.`Name` AS `Unit`,`u`.`Symbol` AS `UnitSymbol`,`mr`.`Value` AS `OriginalValue`,`cr`.`ConvertedValue` AS `ConvertedValue`,`cr`.`Timestamp` AS `Timestamp` from (((((`Meter` `m` join `Customer` `c` on((`c`.`Id` = `m`.`CustomerId`))) join `MeterReading` `mr` on((`mr`.`MeterId` = `m`.`Id`))) join `ConvertedMeterReadingValue` `cr` on((`cr`.`MeterReadingId` = `mr`.`Id`))) join `MeterType` `mt` on((`mt`.`Id` = `m`.`MeterTypeId`))) join `Unit` `u` on((`u`.`Id` = `mt`.`UnitId`))) where ((`c`.`CustomerStatusId` = 1) and (`m`.`MeterStatusId` = 1)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-11-28 19:18:24
