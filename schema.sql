/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.11.11-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: ES1DEV
-- ------------------------------------------------------
-- Server version	10.11.11-MariaDB-0ubuntu0.24.04.2

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `ACCESS_PROFILES`
--

DROP TABLE IF EXISTS `ACCESS_PROFILES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ACCESS_PROFILES` (
  `accessProfileID` int(11) NOT NULL AUTO_INCREMENT,
  `profileDescription` varchar(30) DEFAULT NULL,
  `userID` varchar(30) DEFAULT NULL,
  `password` varchar(30) DEFAULT NULL,
  `addedBy` varchar(30) DEFAULT NULL,
  `addedDt` timestamp NULL DEFAULT NULL,
  `updateBy` varchar(30) DEFAULT NULL,
  `updateDt` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`accessProfileID`),
  UNIQUE KEY `profileDescription` (`profileDescription`),
  KEY `addedBy` (`addedBy`),
  KEY `updateBy` (`updateBy`),
  CONSTRAINT `ACCESS_PROFILES_ibfk_1` FOREIGN KEY (`addedBy`) REFERENCES `OPERATORS` (`operatorID`),
  CONSTRAINT `ACCESS_PROFILES_ibfk_2` FOREIGN KEY (`updateBy`) REFERENCES `OPERATORS` (`operatorID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ASSIGNED_ROOM_FEATURES`
--

DROP TABLE IF EXISTS `ASSIGNED_ROOM_FEATURES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ASSIGNED_ROOM_FEATURES` (
  `assignedRoomFeatureID` int(11) NOT NULL AUTO_INCREMENT,
  `roomFeatureID` int(11) NOT NULL,
  `roomID` int(11) NOT NULL,
  `addedBy` varchar(30) DEFAULT NULL,
  `addedDt` timestamp NULL DEFAULT NULL,
  `updateBy` varchar(30) DEFAULT NULL,
  `updateDt` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`assignedRoomFeatureID`),
  KEY `roomFeatureID` (`roomFeatureID`),
  KEY `roomID` (`roomID`),
  KEY `addedBy` (`addedBy`),
  KEY `updateBy` (`updateBy`),
  CONSTRAINT `ASSIGNED_ROOM_FEATURES_ibfk_1` FOREIGN KEY (`roomFeatureID`) REFERENCES `ROOM_FEATURES` (`roomFeatureID`),
  CONSTRAINT `ASSIGNED_ROOM_FEATURES_ibfk_2` FOREIGN KEY (`roomID`) REFERENCES `ROOMS` (`roomID`),
  CONSTRAINT `ASSIGNED_ROOM_FEATURES_ibfk_3` FOREIGN KEY (`addedBy`) REFERENCES `OPERATORS` (`operatorID`),
  CONSTRAINT `ASSIGNED_ROOM_FEATURES_ibfk_4` FOREIGN KEY (`updateBy`) REFERENCES `OPERATORS` (`operatorID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `BOOKINGS`
--

DROP TABLE IF EXISTS `BOOKINGS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `BOOKINGS` (
  `bookingID` int(11) NOT NULL AUTO_INCREMENT,
  `reservationID` int(11) NOT NULL,
  `bookingName` varchar(100) DEFAULT NULL,
  `bookingStatusID` int(11) DEFAULT NULL,
  `reserveStart` datetime NOT NULL,
  `eventStart` datetime NOT NULL,
  `eventEnd` datetime NOT NULL,
  `reserveEnd` datetime NOT NULL,
  `addedBy` varchar(30) DEFAULT NULL,
  `addedDt` timestamp NULL DEFAULT NULL,
  `updateBy` varchar(30) DEFAULT NULL,
  `updateDt` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`bookingID`),
  KEY `reservationID` (`reservationID`),
  KEY `bookingStatusID` (`bookingStatusID`),
  KEY `addedBy` (`addedBy`),
  KEY `updateBy` (`updateBy`),
  CONSTRAINT `BOOKINGS_ibfk_1` FOREIGN KEY (`reservationID`) REFERENCES `RESERVATIONS` (`reservationID`),
  CONSTRAINT `BOOKINGS_ibfk_2` FOREIGN KEY (`bookingStatusID`) REFERENCES `STATUSES` (`statusID`),
  CONSTRAINT `BOOKINGS_ibfk_3` FOREIGN KEY (`addedBy`) REFERENCES `OPERATORS` (`operatorID`),
  CONSTRAINT `BOOKINGS_ibfk_4` FOREIGN KEY (`updateBy`) REFERENCES `OPERATORS` (`operatorID`),
  CONSTRAINT `eventStartChecks` CHECK (`eventStart` between `reserveStart` and `reserveEnd` and `eventStart` < `eventEnd`),
  CONSTRAINT `eventEndChecks` CHECK (`eventEnd` between `reserveStart` and `reserveEnd` and `eventStart` < `eventEnd`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `BUILDINGS`
--

DROP TABLE IF EXISTS `BUILDINGS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `BUILDINGS` (
  `buildingID` int(11) NOT NULL AUTO_INCREMENT,
  `buildingName` varchar(50) DEFAULT NULL,
  `buildingCode` varchar(10) DEFAULT NULL,
  `buildingNotes` text DEFAULT NULL,
  `buildingURL` varchar(100) DEFAULT NULL,
  `buildingAddress` text DEFAULT NULL,
  `buildingLat` double DEFAULT NULL,
  `buildingLong` double DEFAULT NULL,
  `buildingTimezone` varchar(50) DEFAULT NULL,
  `active` tinyint(1) DEFAULT 1,
  `addedBy` varchar(30) DEFAULT NULL,
  `addedDt` timestamp NULL DEFAULT NULL,
  `updateBy` varchar(30) DEFAULT NULL,
  `updateDt` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`buildingID`),
  KEY `addedBy` (`addedBy`),
  KEY `updateBy` (`updateBy`),
  CONSTRAINT `BUILDINGS_ibfk_1` FOREIGN KEY (`addedBy`) REFERENCES `OPERATORS` (`operatorID`),
  CONSTRAINT `BUILDINGS_ibfk_2` FOREIGN KEY (`updateBy`) REFERENCES `OPERATORS` (`operatorID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `BUILDING_HOUR_EXCEPTIONS`
--

DROP TABLE IF EXISTS `BUILDING_HOUR_EXCEPTIONS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `BUILDING_HOUR_EXCEPTIONS` (
  `buildingHourExceptionID` int(11) NOT NULL AUTO_INCREMENT,
  `buildingID` int(11) NOT NULL,
  `effDate` date NOT NULL,
  `openTime` time DEFAULT NULL,
  `closeTime` time DEFAULT NULL,
  PRIMARY KEY (`buildingHourExceptionID`),
  UNIQUE KEY `buildingID` (`buildingID`,`effDate`),
  CONSTRAINT `BUILDING_HOUR_EXCEPTIONS_ibfk_1` FOREIGN KEY (`buildingID`) REFERENCES `BUILDINGS` (`buildingID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `BUILDING_HOUR_RULES`
--

DROP TABLE IF EXISTS `BUILDING_HOUR_RULES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `BUILDING_HOUR_RULES` (
  `buildingHourRuleID` int(11) NOT NULL AUTO_INCREMENT,
  `buildingID` int(11) NOT NULL,
  `effDate` date NOT NULL,
  `openM` time DEFAULT NULL,
  `closeM` time DEFAULT NULL,
  `openT` time DEFAULT NULL,
  `closeT` time DEFAULT NULL,
  `openW` time DEFAULT NULL,
  `closeW` time DEFAULT NULL,
  `openR` time DEFAULT NULL,
  `closeR` time DEFAULT NULL,
  `openF` time DEFAULT NULL,
  `closeF` time DEFAULT NULL,
  `openA` time DEFAULT NULL,
  `closeA` time DEFAULT NULL,
  `openS` time DEFAULT NULL,
  `closeS` time DEFAULT NULL,
  PRIMARY KEY (`buildingHourRuleID`),
  UNIQUE KEY `buildingID` (`buildingID`,`effDate`),
  CONSTRAINT `BUILDING_HOUR_RULES_ibfk_1` FOREIGN KEY (`buildingID`) REFERENCES `BUILDINGS` (`buildingID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `COMBINATION_ROOM_LINK`
--

DROP TABLE IF EXISTS `COMBINATION_ROOM_LINK`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `COMBINATION_ROOM_LINK` (
  `combinationRoomID` int(11) NOT NULL AUTO_INCREMENT,
  `parentRoomID` int(11) NOT NULL,
  `componentRoomID` int(11) NOT NULL,
  `addedBy` varchar(30) DEFAULT NULL,
  `addedDt` timestamp NULL DEFAULT NULL,
  `updateBy` varchar(30) DEFAULT NULL,
  `updateDt` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`combinationRoomID`),
  UNIQUE KEY `parentRoomID` (`parentRoomID`,`componentRoomID`),
  KEY `componentRoomID` (`componentRoomID`),
  KEY `addedBy` (`addedBy`),
  KEY `updateBy` (`updateBy`),
  CONSTRAINT `COMBINATION_ROOM_LINK_ibfk_1` FOREIGN KEY (`parentRoomID`) REFERENCES `ROOMS` (`roomID`),
  CONSTRAINT `COMBINATION_ROOM_LINK_ibfk_2` FOREIGN KEY (`componentRoomID`) REFERENCES `ROOMS` (`roomID`),
  CONSTRAINT `COMBINATION_ROOM_LINK_ibfk_3` FOREIGN KEY (`addedBy`) REFERENCES `OPERATORS` (`operatorID`),
  CONSTRAINT `COMBINATION_ROOM_LINK_ibfk_4` FOREIGN KEY (`updateBy`) REFERENCES `OPERATORS` (`operatorID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `DEPARTMENTS`
--

DROP TABLE IF EXISTS `DEPARTMENTS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `DEPARTMENTS` (
  `departmentID` int(11) NOT NULL AUTO_INCREMENT,
  `departmentName` varchar(30) DEFAULT NULL,
  `addedBy` varchar(30) DEFAULT NULL,
  `addedDt` timestamp NULL DEFAULT NULL,
  `updateBy` varchar(30) DEFAULT NULL,
  `updateDt` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`departmentID`),
  KEY `addedBy` (`addedBy`),
  KEY `updateBy` (`updateBy`),
  CONSTRAINT `DEPARTMENTS_ibfk_1` FOREIGN KEY (`addedBy`) REFERENCES `OPERATORS` (`operatorID`),
  CONSTRAINT `DEPARTMENTS_ibfk_2` FOREIGN KEY (`updateBy`) REFERENCES `OPERATORS` (`operatorID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `MENU_ITEMS`
--

DROP TABLE IF EXISTS `MENU_ITEMS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `MENU_ITEMS` (
  `menuItemID` int(11) NOT NULL AUTO_INCREMENT,
  `menuText` varchar(30) DEFAULT NULL,
  `parentItemID` int(11) DEFAULT NULL,
  `showInSubmenu` tinyint(1) DEFAULT 0,
  `sortOrder` int(11) DEFAULT NULL,
  `pluginID` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`menuItemID`),
  UNIQUE KEY `parentItemID` (`parentItemID`,`sortOrder`),
  KEY `MENU_ITEMS_PLUGINS_pluginID_fk` (`pluginID`),
  CONSTRAINT `MENU_ITEMS_PLUGINS_pluginID_fk` FOREIGN KEY (`pluginID`) REFERENCES `PLUGINS` (`pluginID`) ON DELETE SET NULL,
  CONSTRAINT `MENU_ITEMS_ibfk_1` FOREIGN KEY (`parentItemID`) REFERENCES `MENU_ITEMS` (`menuItemID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `MENU_ITEM_ACCESS`
--

DROP TABLE IF EXISTS `MENU_ITEM_ACCESS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `MENU_ITEM_ACCESS` (
  `menuItemAccessID` int(11) NOT NULL AUTO_INCREMENT,
  `menuItemID` int(11) NOT NULL,
  `operatorClassID` varchar(30) NOT NULL,
  `addedBy` varchar(30) DEFAULT NULL,
  `addedDt` timestamp NULL DEFAULT NULL,
  `updateBy` varchar(30) DEFAULT NULL,
  `updateDt` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`menuItemAccessID`),
  KEY `operatorClassID` (`operatorClassID`),
  KEY `addedBy` (`addedBy`),
  KEY `updateBy` (`updateBy`),
  KEY `MENU_ITEM_ACCESS_ibfk_1` (`menuItemID`),
  CONSTRAINT `MENU_ITEM_ACCESS_ibfk_1` FOREIGN KEY (`menuItemID`) REFERENCES `MENU_ITEMS` (`menuItemID`) ON DELETE CASCADE,
  CONSTRAINT `MENU_ITEM_ACCESS_ibfk_2` FOREIGN KEY (`operatorClassID`) REFERENCES `OPERATOR_CLASS` (`operatorClassID`),
  CONSTRAINT `MENU_ITEM_ACCESS_ibfk_3` FOREIGN KEY (`addedBy`) REFERENCES `OPERATORS` (`operatorID`),
  CONSTRAINT `MENU_ITEM_ACCESS_ibfk_4` FOREIGN KEY (`updateBy`) REFERENCES `OPERATORS` (`operatorID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `OPERATORS`
--

DROP TABLE IF EXISTS `OPERATORS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `OPERATORS` (
  `operatorID` varchar(30) NOT NULL,
  `firstName` varchar(30) DEFAULT NULL,
  `lastName` varchar(30) DEFAULT NULL,
  `emailID` varchar(200) DEFAULT NULL,
  `phoneNumber` varchar(30) DEFAULT NULL,
  `isManager` tinyint(1) NOT NULL DEFAULT 0,
  `manager` varchar(30) DEFAULT NULL,
  `password` varchar(120) DEFAULT NULL,
  `accessProfileID` int(11) DEFAULT NULL,
  `departmentID` int(11) DEFAULT NULL,
  `addedBy` varchar(30) DEFAULT NULL,
  `addedDt` timestamp NULL DEFAULT NULL,
  `updateBy` varchar(30) DEFAULT NULL,
  `updateDt` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`operatorID`),
  KEY `addedBy` (`addedBy`),
  KEY `updateBy` (`updateBy`),
  KEY `accessProfileID` (`accessProfileID`),
  KEY `departmentID` (`departmentID`),
  KEY `manager` (`manager`),
  CONSTRAINT `OPERATORS_ibfk_1` FOREIGN KEY (`addedBy`) REFERENCES `OPERATORS` (`operatorID`),
  CONSTRAINT `OPERATORS_ibfk_2` FOREIGN KEY (`updateBy`) REFERENCES `OPERATORS` (`operatorID`),
  CONSTRAINT `OPERATORS_ibfk_3` FOREIGN KEY (`accessProfileID`) REFERENCES `ACCESS_PROFILES` (`accessProfileID`),
  CONSTRAINT `OPERATORS_ibfk_4` FOREIGN KEY (`departmentID`) REFERENCES `DEPARTMENTS` (`departmentID`),
  CONSTRAINT `OPERATORS_ibfk_5` FOREIGN KEY (`manager`) REFERENCES `OPERATORS` (`operatorID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `OPERATOR_CLASS`
--

DROP TABLE IF EXISTS `OPERATOR_CLASS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `OPERATOR_CLASS` (
  `operatorClassID` varchar(8) NOT NULL,
  `classDescr` varchar(30) DEFAULT NULL,
  `addedBy` varchar(30) DEFAULT NULL,
  `addedDt` timestamp NULL DEFAULT NULL,
  `updateBy` varchar(30) DEFAULT NULL,
  `updateDt` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`operatorClassID`),
  KEY `addedBy` (`addedBy`),
  KEY `updateBy` (`updateBy`),
  CONSTRAINT `OPERATOR_CLASS_ibfk_1` FOREIGN KEY (`addedBy`) REFERENCES `OPERATORS` (`operatorID`),
  CONSTRAINT `OPERATOR_CLASS_ibfk_2` FOREIGN KEY (`updateBy`) REFERENCES `OPERATORS` (`operatorID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `OPERATOR_CLASS_LINK`
--

DROP TABLE IF EXISTS `OPERATOR_CLASS_LINK`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `OPERATOR_CLASS_LINK` (
  `classLinkID` int(11) NOT NULL AUTO_INCREMENT,
  `operatorID` varchar(30) DEFAULT NULL,
  `operatorClassID` varchar(8) NOT NULL,
  `isPrimary` tinyint(1) DEFAULT 0,
  `addedBy` varchar(30) DEFAULT NULL,
  `addedDt` timestamp NULL DEFAULT NULL,
  `updateBy` varchar(30) DEFAULT NULL,
  `updateDt` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`classLinkID`),
  KEY `operatorID` (`operatorID`),
  KEY `addedBy` (`addedBy`),
  KEY `updateBy` (`updateBy`),
  KEY `OPERATOR_CLASS_LINK_OPERATOR_CLASS_operatorClassID_fk` (`operatorClassID`),
  CONSTRAINT `OPERATOR_CLASS_LINK_OPERATOR_CLASS_operatorClassID_fk` FOREIGN KEY (`operatorClassID`) REFERENCES `OPERATOR_CLASS` (`operatorClassID`),
  CONSTRAINT `OPERATOR_CLASS_LINK_ibfk_1` FOREIGN KEY (`operatorID`) REFERENCES `OPERATORS` (`operatorID`),
  CONSTRAINT `OPERATOR_CLASS_LINK_ibfk_2` FOREIGN KEY (`addedBy`) REFERENCES `OPERATORS` (`operatorID`),
  CONSTRAINT `OPERATOR_CLASS_LINK_ibfk_3` FOREIGN KEY (`updateBy`) REFERENCES `OPERATORS` (`operatorID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `OPERATOR_CLASS_OVERRIDES`
--

DROP TABLE IF EXISTS `OPERATOR_CLASS_OVERRIDES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `OPERATOR_CLASS_OVERRIDES` (
  `operatorClassOverrideID` int(11) NOT NULL AUTO_INCREMENT,
  `operatorID` varchar(30) NOT NULL,
  `operatorClassOverrideTypeID` int(11) NOT NULL,
  `addedBy` varchar(30) DEFAULT NULL,
  `addedDt` timestamp NULL DEFAULT NULL,
  `updateBy` varchar(30) DEFAULT NULL,
  `updateDt` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`operatorClassOverrideID`),
  KEY `operatorID` (`operatorID`),
  KEY `operatorClassOverrideTypeID` (`operatorClassOverrideTypeID`),
  KEY `addedBy` (`addedBy`),
  KEY `updateBy` (`updateBy`),
  CONSTRAINT `OPERATOR_CLASS_OVERRIDES_ibfk_1` FOREIGN KEY (`operatorID`) REFERENCES `OPERATORS` (`operatorID`),
  CONSTRAINT `OPERATOR_CLASS_OVERRIDES_ibfk_2` FOREIGN KEY (`operatorClassOverrideTypeID`) REFERENCES `OPERATOR_CLASS_OVERRIDE_TYPES` (`operatorClassOverrideTypeID`),
  CONSTRAINT `OPERATOR_CLASS_OVERRIDES_ibfk_3` FOREIGN KEY (`addedBy`) REFERENCES `OPERATORS` (`operatorID`),
  CONSTRAINT `OPERATOR_CLASS_OVERRIDES_ibfk_4` FOREIGN KEY (`updateBy`) REFERENCES `OPERATORS` (`operatorID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `OPERATOR_CLASS_OVERRIDE_TYPES`
--

DROP TABLE IF EXISTS `OPERATOR_CLASS_OVERRIDE_TYPES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `OPERATOR_CLASS_OVERRIDE_TYPES` (
  `operatorClassOverrideTypeID` int(11) NOT NULL AUTO_INCREMENT,
  `overrideDescription` varchar(30) DEFAULT NULL,
  `addedBy` varchar(30) DEFAULT NULL,
  `addedDt` timestamp NULL DEFAULT NULL,
  `updateBy` varchar(30) DEFAULT NULL,
  `updateDt` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`operatorClassOverrideTypeID`),
  KEY `addedBy` (`addedBy`),
  KEY `updateBy` (`updateBy`),
  CONSTRAINT `OPERATOR_CLASS_OVERRIDE_TYPES_ibfk_1` FOREIGN KEY (`addedBy`) REFERENCES `OPERATORS` (`operatorID`),
  CONSTRAINT `OPERATOR_CLASS_OVERRIDE_TYPES_ibfk_2` FOREIGN KEY (`updateBy`) REFERENCES `OPERATORS` (`operatorID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `PLUGINS`
--

DROP TABLE IF EXISTS `PLUGINS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `PLUGINS` (
  `pluginID` varchar(30) NOT NULL,
  `pluginData` longblob DEFAULT NULL,
  PRIMARY KEY (`pluginID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `RESERVATIONS`
--

DROP TABLE IF EXISTS `RESERVATIONS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `RESERVATIONS` (
  `reservationID` int(11) NOT NULL AUTO_INCREMENT,
  `reservationName` varchar(100) DEFAULT NULL,
  `reservationStatusID` int(11) DEFAULT NULL,
  `addedBy` varchar(30) DEFAULT NULL,
  `addedDt` timestamp NULL DEFAULT NULL,
  `updateBy` varchar(30) DEFAULT NULL,
  `updateDt` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`reservationID`),
  KEY `reservationStatusID` (`reservationStatusID`),
  KEY `addedBy` (`addedBy`),
  KEY `updateBy` (`updateBy`),
  CONSTRAINT `RESERVATIONS_ibfk_1` FOREIGN KEY (`reservationStatusID`) REFERENCES `STATUSES` (`statusID`),
  CONSTRAINT `RESERVATIONS_ibfk_2` FOREIGN KEY (`addedBy`) REFERENCES `OPERATORS` (`operatorID`),
  CONSTRAINT `RESERVATIONS_ibfk_3` FOREIGN KEY (`updateBy`) REFERENCES `OPERATORS` (`operatorID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ROOMS`
--

DROP TABLE IF EXISTS `ROOMS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ROOMS` (
  `roomID` int(11) NOT NULL AUTO_INCREMENT,
  `buildingID` int(11) NOT NULL,
  `roomCode` varchar(20) DEFAULT NULL,
  `roomName` varchar(100) DEFAULT NULL,
  `roomType` enum('Combination','Standard') NOT NULL DEFAULT 'Standard',
  `allowAlternateName` tinyint(1) DEFAULT 0,
  `isAcademic` tinyint(1) DEFAULT 0,
  `active` tinyint(1) DEFAULT 1,
  `addedBy` varchar(30) DEFAULT NULL,
  `addedDt` timestamp NULL DEFAULT NULL,
  `updateBy` varchar(30) DEFAULT NULL,
  `updateDt` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`roomID`),
  KEY `addedBy` (`addedBy`),
  KEY `updateBy` (`updateBy`),
  KEY `buildingID` (`buildingID`),
  CONSTRAINT `ROOMS_ibfk_1` FOREIGN KEY (`addedBy`) REFERENCES `OPERATORS` (`operatorID`),
  CONSTRAINT `ROOMS_ibfk_2` FOREIGN KEY (`updateBy`) REFERENCES `OPERATORS` (`operatorID`),
  CONSTRAINT `ROOMS_ibfk_3` FOREIGN KEY (`buildingID`) REFERENCES `BUILDINGS` (`buildingID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ROOM_FEATURES`
--

DROP TABLE IF EXISTS `ROOM_FEATURES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ROOM_FEATURES` (
  `roomFeatureID` int(11) NOT NULL AUTO_INCREMENT,
  `roomFeatureText` varchar(80) NOT NULL,
  `addedBy` varchar(30) DEFAULT NULL,
  `addedDt` timestamp NULL DEFAULT NULL,
  `updateBy` varchar(30) DEFAULT NULL,
  `updateDt` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`roomFeatureID`),
  UNIQUE KEY `roomFeatureText` (`roomFeatureText`),
  KEY `addedBy` (`addedBy`),
  KEY `updateBy` (`updateBy`),
  CONSTRAINT `ROOM_FEATURES_ibfk_1` FOREIGN KEY (`addedBy`) REFERENCES `OPERATORS` (`operatorID`),
  CONSTRAINT `ROOM_FEATURES_ibfk_2` FOREIGN KEY (`updateBy`) REFERENCES `OPERATORS` (`operatorID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ROOM_NOTES`
--

DROP TABLE IF EXISTS `ROOM_NOTES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ROOM_NOTES` (
  `roomNoteID` int(11) NOT NULL AUTO_INCREMENT,
  `roomID` int(11) NOT NULL,
  `noteText` text DEFAULT '',
  `noteProtectionLevel` enum('Public','Internal','Private') NOT NULL DEFAULT 'Private',
  `addedBy` varchar(30) DEFAULT NULL,
  `addedDt` timestamp NULL DEFAULT NULL,
  `updateBy` varchar(30) DEFAULT NULL,
  `updateDt` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`roomNoteID`),
  KEY `roomID` (`roomID`),
  KEY `addedBy` (`addedBy`),
  KEY `updateBy` (`updateBy`),
  CONSTRAINT `ROOM_NOTES_ibfk_1` FOREIGN KEY (`roomID`) REFERENCES `ROOMS` (`roomID`),
  CONSTRAINT `ROOM_NOTES_ibfk_2` FOREIGN KEY (`addedBy`) REFERENCES `OPERATORS` (`operatorID`),
  CONSTRAINT `ROOM_NOTES_ibfk_3` FOREIGN KEY (`updateBy`) REFERENCES `OPERATORS` (`operatorID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `SESSIONS`
--

DROP TABLE IF EXISTS `SESSIONS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `SESSIONS` (
  `sessionID` int(11) NOT NULL AUTO_INCREMENT,
  `operatorID` varchar(30) NOT NULL,
  `clientID` varchar(40) DEFAULT NULL,
  `sessionOpenTime` datetime DEFAULT current_timestamp(),
  `sessionCloseTime` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `ipAddress` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`sessionID`),
  KEY `operatorID` (`operatorID`),
  CONSTRAINT `SESSIONS_ibfk_1` FOREIGN KEY (`operatorID`) REFERENCES `OPERATORS` (`operatorID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `STATUSES`
--

DROP TABLE IF EXISTS `STATUSES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `STATUSES` (
  `statusID` int(11) NOT NULL AUTO_INCREMENT,
  `statusDescription` varchar(50) DEFAULT NULL,
  `addedBy` varchar(30) DEFAULT NULL,
  `addedDt` timestamp NULL DEFAULT NULL,
  `updateBy` varchar(30) DEFAULT NULL,
  `updateDt` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`statusID`),
  KEY `addedBy` (`addedBy`),
  KEY `updateBy` (`updateBy`),
  CONSTRAINT `STATUSES_ibfk_1` FOREIGN KEY (`addedBy`) REFERENCES `OPERATORS` (`operatorID`),
  CONSTRAINT `STATUSES_ibfk_2` FOREIGN KEY (`updateBy`) REFERENCES `OPERATORS` (`operatorID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- Create a default account (No Username, No Password)
INSERT INTO OPERATORS (operatorID, firstName, lastName, emailID, phoneNumber, isManager, manager, password, accessProfileID, departmentID, addedBy, addedDt, updateBy, updateDt) VALUES ('', 'Developer', 'Account', '', '   .   .', 0, null, '$argon2id$v=19$m=65536,t=3,p=4$eWlGRVRnaU9JR3hxZENXbw$y8MTnGO7QIzJtg2/OA8baQ', 1, 1, '', '2025-04-22 10:22:00', '', '2025-05-01 10:28:45');
-- Create a default "All Panels" class
INSERT INTO OPERATOR_CLASS (operatorClassID, classDescr, addedBy, addedDt, updateBy, updateDt) VALUES ('ALLPNLS', 'Developer', '', '2025-03-29 13:48:38', '', '2025-03-29 13:48:38');
-- Create a link between default account and default class.
INSERT INTO OPERATOR_CLASS_LINK (operatorID, operatorClassID, isPrimary, addedBy, addedDt, updateBy, updateDt) VALUES ('', 'ALLPNLS', 1, '', '2025-03-29 14:07:00', '', '2025-03-29 14:07:00');
-- Create a default Department
INSERT INTO DEPARTMENTS (departmentName, addedBy, addedDt, updateBy, updateDt) VALUES ('Chronicle Solutions', '', '2025-04-25 09:41:00', '', '2025-04-25 09:41:00');

-- Create Access Information

  -- Create Plugins
INSERT INTO ES1DEV.PLUGINS (pluginID, pluginData) VALUES ('About Chronicle', null);
INSERT INTO ES1DEV.PLUGINS (pluginID, pluginData) VALUES ('Chronicle Building Management', null);
INSERT INTO ES1DEV.PLUGINS (pluginID, pluginData) VALUES ('Class Management', null);
INSERT INTO ES1DEV.PLUGINS (pluginID, pluginData) VALUES ('Manage Rooms', null);
INSERT INTO ES1DEV.PLUGINS (pluginID, pluginData) VALUES ('Menu Manager', null);
INSERT INTO ES1DEV.PLUGINS (pluginID, pluginData) VALUES ('Operator Management', null);

-- Create Menu Objects

INSERT INTO ES1DEV.MENU_ITEMS (menuItemID, menuText, parentItemID, showInSubmenu, sortOrder, pluginID) VALUES (1, 'File', null, 0, 1000, null);
INSERT INTO ES1DEV.MENU_ITEMS (menuItemID, menuText, parentItemID, showInSubmenu, sortOrder, pluginID) VALUES (3, 'Reservations', null, 1, 998, null);
INSERT INTO ES1DEV.MENU_ITEMS (menuItemID, menuText, parentItemID, showInSubmenu, sortOrder, pluginID) VALUES (4, 'Reports', null, 1, 997, null);
INSERT INTO ES1DEV.MENU_ITEMS (menuItemID, menuText, parentItemID, showInSubmenu, sortOrder, pluginID) VALUES (5, 'Billing', null, 1, 996, null);
INSERT INTO ES1DEV.MENU_ITEMS (menuItemID, menuText, parentItemID, showInSubmenu, sortOrder, pluginID) VALUES (6, 'Configuration', null, 1, 995, null);
INSERT INTO ES1DEV.MENU_ITEMS (menuItemID, menuText, parentItemID, showInSubmenu, sortOrder, pluginID) VALUES (7, 'Academic Planning', null, 1, 994, null);
INSERT INTO ES1DEV.MENU_ITEMS (menuItemID, menuText, parentItemID, showInSubmenu, sortOrder, pluginID) VALUES (8, 'System Administration', null, 1, 993, null);
INSERT INTO ES1DEV.MENU_ITEMS (menuItemID, menuText, parentItemID, showInSubmenu, sortOrder, pluginID) VALUES (9, 'Window', null, 1, 992, null);
INSERT INTO ES1DEV.MENU_ITEMS (menuItemID, menuText, parentItemID, showInSubmenu, sortOrder, pluginID) VALUES (10, 'Help', null, 1, 991, null);
INSERT INTO ES1DEV.MENU_ITEMS (menuItemID, menuText, parentItemID, showInSubmenu, sortOrder, pluginID) VALUES (11, 'Change Database', 1, 1, 1000, null);
INSERT INTO ES1DEV.MENU_ITEMS (menuItemID, menuText, parentItemID, showInSubmenu, sortOrder, pluginID) VALUES (12, 'Exit', 1, 1, 999, null);
INSERT INTO ES1DEV.MENU_ITEMS (menuItemID, menuText, parentItemID, showInSubmenu, sortOrder, pluginID) VALUES (13, 'Create', 3, 1, 1000, null);
INSERT INTO ES1DEV.MENU_ITEMS (menuItemID, menuText, parentItemID, showInSubmenu, sortOrder, pluginID) VALUES (14, 'Search', 3, 1, 999, null);
INSERT INTO ES1DEV.MENU_ITEMS (menuItemID, menuText, parentItemID, showInSubmenu, sortOrder, pluginID) VALUES (15, 'Navigator', 14, 1, 1000, null);
INSERT INTO ES1DEV.MENU_ITEMS (menuItemID, menuText, parentItemID, showInSubmenu, sortOrder, pluginID) VALUES (16, 'Browser', 14, 1, 999, null);
INSERT INTO ES1DEV.MENU_ITEMS (menuItemID, menuText, parentItemID, showInSubmenu, sortOrder, pluginID) VALUES (17, 'Calendar', 14, 1, 998, null);
INSERT INTO ES1DEV.MENU_ITEMS (menuItemID, menuText, parentItemID, showInSubmenu, sortOrder, pluginID) VALUES (18, 'Facilities', 6, 1, 1000, null);
INSERT INTO ES1DEV.MENU_ITEMS (menuItemID, menuText, parentItemID, showInSubmenu, sortOrder, pluginID) VALUES (19, 'Buildings', 18, 1, 1000, 'Chronicle Building Management');
INSERT INTO ES1DEV.MENU_ITEMS (menuItemID, menuText, parentItemID, showInSubmenu, sortOrder, pluginID) VALUES (21, 'Rooms', 18, 1, 999, 'Manage Rooms');
INSERT INTO ES1DEV.MENU_ITEMS (menuItemID, menuText, parentItemID, showInSubmenu, sortOrder, pluginID) VALUES (22, 'Other', 3, 1, 997, null);
INSERT INTO ES1DEV.MENU_ITEMS (menuItemID, menuText, parentItemID, showInSubmenu, sortOrder, pluginID) VALUES (23, 'Sponsors', 22, 1, 1000, null);
INSERT INTO ES1DEV.MENU_ITEMS (menuItemID, menuText, parentItemID, showInSubmenu, sortOrder, pluginID) VALUES (25, 'About', 10, 1, 1000, 'About Chronicle');
INSERT INTO ES1DEV.MENU_ITEMS (menuItemID, menuText, parentItemID, showInSubmenu, sortOrder, pluginID) VALUES (26, 'Security', 8, 1, 990, null);
INSERT INTO ES1DEV.MENU_ITEMS (menuItemID, menuText, parentItemID, showInSubmenu, sortOrder, pluginID) VALUES (27, 'Operators', 26, 1, 990, 'Operator Management');
INSERT INTO ES1DEV.MENU_ITEMS (menuItemID, menuText, parentItemID, showInSubmenu, sortOrder, pluginID) VALUES (29, 'Menu Item Management', 26, 1, 989, 'Menu Manager');
INSERT INTO ES1DEV.MENU_ITEMS (menuItemID, menuText, parentItemID, showInSubmenu, sortOrder, pluginID) VALUES (30, 'Operator Classes', 26, 1, 997, 'Class Management');

  -- Create Access Rules
INSERT INTO ES1DEV.MENU_ITEM_ACCESS (menuItemAccessID, menuItemID, operatorClassID, addedBy, addedDt, updateBy, updateDt) VALUES (1, 1, 'ALLPNLS', 'adasneves', '2025-04-22 09:15:00', 'adasneves', '2025-04-22 09:15:00');
INSERT INTO ES1DEV.MENU_ITEM_ACCESS (menuItemAccessID, menuItemID, operatorClassID, addedBy, addedDt, updateBy, updateDt) VALUES (3, 3, 'ALLPNLS', 'adasneves', '2025-04-22 09:15:00', 'adasneves', '2025-04-22 09:15:00');
INSERT INTO ES1DEV.MENU_ITEM_ACCESS (menuItemAccessID, menuItemID, operatorClassID, addedBy, addedDt, updateBy, updateDt) VALUES (4, 4, 'ALLPNLS', 'adasneves', '2025-04-22 09:15:00', 'adasneves', '2025-04-22 09:15:00');
INSERT INTO ES1DEV.MENU_ITEM_ACCESS (menuItemAccessID, menuItemID, operatorClassID, addedBy, addedDt, updateBy, updateDt) VALUES (5, 5, 'ALLPNLS', 'adasneves', '2025-04-22 09:15:00', 'adasneves', '2025-04-22 09:15:00');
INSERT INTO ES1DEV.MENU_ITEM_ACCESS (menuItemAccessID, menuItemID, operatorClassID, addedBy, addedDt, updateBy, updateDt) VALUES (6, 6, 'ALLPNLS', 'adasneves', '2025-04-22 09:15:00', 'adasneves', '2025-04-22 09:15:00');
INSERT INTO ES1DEV.MENU_ITEM_ACCESS (menuItemAccessID, menuItemID, operatorClassID, addedBy, addedDt, updateBy, updateDt) VALUES (7, 7, 'ALLPNLS', 'adasneves', '2025-04-22 09:15:00', 'adasneves', '2025-04-22 09:15:00');
INSERT INTO ES1DEV.MENU_ITEM_ACCESS (menuItemAccessID, menuItemID, operatorClassID, addedBy, addedDt, updateBy, updateDt) VALUES (8, 8, 'ALLPNLS', 'adasneves', '2025-04-22 09:15:00', 'adasneves', '2025-04-22 09:15:00');
INSERT INTO ES1DEV.MENU_ITEM_ACCESS (menuItemAccessID, menuItemID, operatorClassID, addedBy, addedDt, updateBy, updateDt) VALUES (9, 9, 'ALLPNLS', 'adasneves', '2025-04-22 09:15:00', 'adasneves', '2025-04-22 09:15:00');
INSERT INTO ES1DEV.MENU_ITEM_ACCESS (menuItemAccessID, menuItemID, operatorClassID, addedBy, addedDt, updateBy, updateDt) VALUES (10, 10, 'ALLPNLS', 'adasneves', '2025-04-22 09:15:00', 'adasneves', '2025-04-22 09:15:00');
INSERT INTO ES1DEV.MENU_ITEM_ACCESS (menuItemAccessID, menuItemID, operatorClassID, addedBy, addedDt, updateBy, updateDt) VALUES (11, 11, 'ALLPNLS', 'adasneves', '2025-04-22 09:15:00', 'adasneves', '2025-04-22 09:15:00');
INSERT INTO ES1DEV.MENU_ITEM_ACCESS (menuItemAccessID, menuItemID, operatorClassID, addedBy, addedDt, updateBy, updateDt) VALUES (12, 12, 'ALLPNLS', 'adasneves', '2025-04-22 09:15:00', 'adasneves', '2025-04-22 09:15:00');
INSERT INTO ES1DEV.MENU_ITEM_ACCESS (menuItemAccessID, menuItemID, operatorClassID, addedBy, addedDt, updateBy, updateDt) VALUES (13, 13, 'ALLPNLS', 'adasneves', '2025-04-22 09:15:00', 'adasneves', '2025-04-22 09:15:00');
INSERT INTO ES1DEV.MENU_ITEM_ACCESS (menuItemAccessID, menuItemID, operatorClassID, addedBy, addedDt, updateBy, updateDt) VALUES (14, 14, 'ALLPNLS', 'adasneves', '2025-04-22 09:15:00', 'adasneves', '2025-04-22 09:15:00');
INSERT INTO ES1DEV.MENU_ITEM_ACCESS (menuItemAccessID, menuItemID, operatorClassID, addedBy, addedDt, updateBy, updateDt) VALUES (15, 15, 'ALLPNLS', 'adasneves', '2025-04-22 09:15:00', 'adasneves', '2025-04-22 09:15:00');
INSERT INTO ES1DEV.MENU_ITEM_ACCESS (menuItemAccessID, menuItemID, operatorClassID, addedBy, addedDt, updateBy, updateDt) VALUES (16, 16, 'ALLPNLS', 'adasneves', '2025-04-22 09:15:00', 'adasneves', '2025-04-22 09:15:00');
INSERT INTO ES1DEV.MENU_ITEM_ACCESS (menuItemAccessID, menuItemID, operatorClassID, addedBy, addedDt, updateBy, updateDt) VALUES (17, 17, 'ALLPNLS', 'adasneves', '2025-04-22 09:15:00', 'adasneves', '2025-04-22 09:15:00');
INSERT INTO ES1DEV.MENU_ITEM_ACCESS (menuItemAccessID, menuItemID, operatorClassID, addedBy, addedDt, updateBy, updateDt) VALUES (18, 18, 'ALLPNLS', 'adasneves', '2025-04-22 09:15:00', 'adasneves', '2025-04-22 09:15:00');
INSERT INTO ES1DEV.MENU_ITEM_ACCESS (menuItemAccessID, menuItemID, operatorClassID, addedBy, addedDt, updateBy, updateDt) VALUES (19, 19, 'ALLPNLS', 'adasneves', '2025-04-22 09:15:00', 'adasneves', '2025-04-22 09:15:00');
INSERT INTO ES1DEV.MENU_ITEM_ACCESS (menuItemAccessID, menuItemID, operatorClassID, addedBy, addedDt, updateBy, updateDt) VALUES (20, 21, 'ALLPNLS', 'adasneves', '2025-04-22 09:15:00', 'adasneves', '2025-04-22 09:15:00');
INSERT INTO ES1DEV.MENU_ITEM_ACCESS (menuItemAccessID, menuItemID, operatorClassID, addedBy, addedDt, updateBy, updateDt) VALUES (21, 22, 'ALLPNLS', 'adasneves', '2025-04-22 09:15:00', 'adasneves', '2025-04-22 09:15:00');
INSERT INTO ES1DEV.MENU_ITEM_ACCESS (menuItemAccessID, menuItemID, operatorClassID, addedBy, addedDt, updateBy, updateDt) VALUES (22, 23, 'ALLPNLS', 'adasneves', '2025-04-22 09:15:00', 'adasneves', '2025-04-22 09:15:00');
INSERT INTO ES1DEV.MENU_ITEM_ACCESS (menuItemAccessID, menuItemID, operatorClassID, addedBy, addedDt, updateBy, updateDt) VALUES (23, 25, 'ALLPNLS', 'adasneves', '2025-04-22 09:15:00', 'adasneves', '2025-04-22 09:15:00');
INSERT INTO ES1DEV.MENU_ITEM_ACCESS (menuItemAccessID, menuItemID, operatorClassID, addedBy, addedDt, updateBy, updateDt) VALUES (24, 1, 'MOSTPNLS', 'adasneves', '2025-04-22 09:15:00', 'adasneves', '2025-04-22 09:15:00');
INSERT INTO ES1DEV.MENU_ITEM_ACCESS (menuItemAccessID, menuItemID, operatorClassID, addedBy, addedDt, updateBy, updateDt) VALUES (26, 3, 'MOSTPNLS', 'adasneves', '2025-04-22 09:15:00', 'adasneves', '2025-04-22 09:15:00');
INSERT INTO ES1DEV.MENU_ITEM_ACCESS (menuItemAccessID, menuItemID, operatorClassID, addedBy, addedDt, updateBy, updateDt) VALUES (27, 4, 'MOSTPNLS', 'adasneves', '2025-04-22 09:15:00', 'adasneves', '2025-04-22 09:15:00');
INSERT INTO ES1DEV.MENU_ITEM_ACCESS (menuItemAccessID, menuItemID, operatorClassID, addedBy, addedDt, updateBy, updateDt) VALUES (28, 5, 'MOSTPNLS', 'adasneves', '2025-04-22 09:15:00', 'adasneves', '2025-04-22 09:15:00');
INSERT INTO ES1DEV.MENU_ITEM_ACCESS (menuItemAccessID, menuItemID, operatorClassID, addedBy, addedDt, updateBy, updateDt) VALUES (29, 6, 'MOSTPNLS', 'adasneves', '2025-04-22 09:15:00', 'adasneves', '2025-04-22 09:15:00');
INSERT INTO ES1DEV.MENU_ITEM_ACCESS (menuItemAccessID, menuItemID, operatorClassID, addedBy, addedDt, updateBy, updateDt) VALUES (30, 7, 'MOSTPNLS', 'adasneves', '2025-04-22 09:15:00', 'adasneves', '2025-04-22 09:15:00');
INSERT INTO ES1DEV.MENU_ITEM_ACCESS (menuItemAccessID, menuItemID, operatorClassID, addedBy, addedDt, updateBy, updateDt) VALUES (31, 8, 'MOSTPNLS', 'adasneves', '2025-04-22 09:15:00', 'adasneves', '2025-04-22 09:15:00');
INSERT INTO ES1DEV.MENU_ITEM_ACCESS (menuItemAccessID, menuItemID, operatorClassID, addedBy, addedDt, updateBy, updateDt) VALUES (32, 9, 'MOSTPNLS', 'adasneves', '2025-04-22 09:15:00', 'adasneves', '2025-04-22 09:15:00');
INSERT INTO ES1DEV.MENU_ITEM_ACCESS (menuItemAccessID, menuItemID, operatorClassID, addedBy, addedDt, updateBy, updateDt) VALUES (33, 10, 'MOSTPNLS', 'adasneves', '2025-04-22 09:15:00', 'adasneves', '2025-04-22 09:15:00');
INSERT INTO ES1DEV.MENU_ITEM_ACCESS (menuItemAccessID, menuItemID, operatorClassID, addedBy, addedDt, updateBy, updateDt) VALUES (34, 11, 'MOSTPNLS', 'adasneves', '2025-04-22 09:15:00', 'adasneves', '2025-04-22 09:15:00');
INSERT INTO ES1DEV.MENU_ITEM_ACCESS (menuItemAccessID, menuItemID, operatorClassID, addedBy, addedDt, updateBy, updateDt) VALUES (35, 12, 'MOSTPNLS', 'adasneves', '2025-04-22 09:15:00', 'adasneves', '2025-04-22 09:15:00');
INSERT INTO ES1DEV.MENU_ITEM_ACCESS (menuItemAccessID, menuItemID, operatorClassID, addedBy, addedDt, updateBy, updateDt) VALUES (36, 13, 'MOSTPNLS', 'adasneves', '2025-04-22 09:15:00', 'adasneves', '2025-04-22 09:15:00');
INSERT INTO ES1DEV.MENU_ITEM_ACCESS (menuItemAccessID, menuItemID, operatorClassID, addedBy, addedDt, updateBy, updateDt) VALUES (37, 14, 'MOSTPNLS', 'adasneves', '2025-04-22 09:15:00', 'adasneves', '2025-04-22 09:15:00');
INSERT INTO ES1DEV.MENU_ITEM_ACCESS (menuItemAccessID, menuItemID, operatorClassID, addedBy, addedDt, updateBy, updateDt) VALUES (38, 15, 'MOSTPNLS', 'adasneves', '2025-04-22 09:15:00', 'adasneves', '2025-04-22 09:15:00');
INSERT INTO ES1DEV.MENU_ITEM_ACCESS (menuItemAccessID, menuItemID, operatorClassID, addedBy, addedDt, updateBy, updateDt) VALUES (39, 16, 'MOSTPNLS', 'adasneves', '2025-04-22 09:15:00', 'adasneves', '2025-04-22 09:15:00');
INSERT INTO ES1DEV.MENU_ITEM_ACCESS (menuItemAccessID, menuItemID, operatorClassID, addedBy, addedDt, updateBy, updateDt) VALUES (40, 17, 'MOSTPNLS', 'adasneves', '2025-04-22 09:15:00', 'adasneves', '2025-04-22 09:15:00');
INSERT INTO ES1DEV.MENU_ITEM_ACCESS (menuItemAccessID, menuItemID, operatorClassID, addedBy, addedDt, updateBy, updateDt) VALUES (41, 18, 'MOSTPNLS', 'adasneves', '2025-04-22 09:15:00', 'adasneves', '2025-04-22 09:15:00');
INSERT INTO ES1DEV.MENU_ITEM_ACCESS (menuItemAccessID, menuItemID, operatorClassID, addedBy, addedDt, updateBy, updateDt) VALUES (42, 19, 'MOSTPNLS', 'adasneves', '2025-04-22 09:15:00', 'adasneves', '2025-04-22 09:15:00');
INSERT INTO ES1DEV.MENU_ITEM_ACCESS (menuItemAccessID, menuItemID, operatorClassID, addedBy, addedDt, updateBy, updateDt) VALUES (43, 21, 'MOSTPNLS', 'adasneves', '2025-04-22 09:15:00', 'adasneves', '2025-04-22 09:15:00');
INSERT INTO ES1DEV.MENU_ITEM_ACCESS (menuItemAccessID, menuItemID, operatorClassID, addedBy, addedDt, updateBy, updateDt) VALUES (44, 22, 'MOSTPNLS', 'adasneves', '2025-04-22 09:15:00', 'adasneves', '2025-04-22 09:15:00');
INSERT INTO ES1DEV.MENU_ITEM_ACCESS (menuItemAccessID, menuItemID, operatorClassID, addedBy, addedDt, updateBy, updateDt) VALUES (45, 23, 'MOSTPNLS', 'adasneves', '2025-04-22 09:15:00', 'adasneves', '2025-04-22 09:15:00');
INSERT INTO ES1DEV.MENU_ITEM_ACCESS (menuItemAccessID, menuItemID, operatorClassID, addedBy, addedDt, updateBy, updateDt) VALUES (46, 25, 'MOSTPNLS', 'adasneves', '2025-04-22 09:15:00', 'adasneves', '2025-04-22 09:15:00');
INSERT INTO ES1DEV.MENU_ITEM_ACCESS (menuItemAccessID, menuItemID, operatorClassID, addedBy, addedDt, updateBy, updateDt) VALUES (47, 26, 'ALLPNLS', 'adasneves', '2025-04-22 09:15:00', 'adasneves', '2025-04-22 09:15:00');
INSERT INTO ES1DEV.MENU_ITEM_ACCESS (menuItemAccessID, menuItemID, operatorClassID, addedBy, addedDt, updateBy, updateDt) VALUES (48, 27, 'ALLPNLS', 'adasneves', '2025-04-22 09:15:00', 'adasneves', '2025-04-22 09:15:00');
INSERT INTO ES1DEV.MENU_ITEM_ACCESS (menuItemAccessID, menuItemID, operatorClassID, addedBy, addedDt, updateBy, updateDt) VALUES (49, 29, 'ALLPNLS', 'adasneves', '2025-04-22 09:15:00', 'adasneves', '2025-04-22 09:15:00');
INSERT INTO ES1DEV.MENU_ITEM_ACCESS (menuItemAccessID, menuItemID, operatorClassID, addedBy, addedDt, updateBy, updateDt) VALUES (50, 26, 'MOSTPNLS', 'adasneves', '2025-04-22 09:15:00', 'adasneves', '2025-04-22 09:15:00');
INSERT INTO ES1DEV.MENU_ITEM_ACCESS (menuItemAccessID, menuItemID, operatorClassID, addedBy, addedDt, updateBy, updateDt) VALUES (51, 27, 'MOSTPNLS', 'adasneves', '2025-04-22 09:15:00', 'adasneves', '2025-04-22 09:15:00');
INSERT INTO ES1DEV.MENU_ITEM_ACCESS (menuItemAccessID, menuItemID, operatorClassID, addedBy, addedDt, updateBy, updateDt) VALUES (52, 29, 'MOSTPNLS', 'adasneves', '2025-04-22 09:15:00', 'adasneves', '2025-04-22 09:15:00');
INSERT INTO ES1DEV.MENU_ITEM_ACCESS (menuItemAccessID, menuItemID, operatorClassID, addedBy, addedDt, updateBy, updateDt) VALUES (53, 30, 'MOSTPNLS', 'adasneves', '2025-04-22 09:15:00', 'adasneves', '2025-04-22 09:15:00');
INSERT INTO ES1DEV.MENU_ITEM_ACCESS (menuItemAccessID, menuItemID, operatorClassID, addedBy, addedDt, updateBy, updateDt) VALUES (54, 30, 'ALLPNLS', 'adasneves', '2025-04-22 09:15:00', 'adasneves', '2025-04-22 09:15:00');


/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

