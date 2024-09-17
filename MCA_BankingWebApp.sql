CREATE DATABASE  IF NOT EXISTS `webbanking` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `webbanking`;
-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: webbanking
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
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts` (
  `accountID` int NOT NULL AUTO_INCREMENT,
  `userID` int NOT NULL,
  `IFSC` varchar(11) DEFAULT 'IBAN0123456',
  `accountNumber` varchar(20) DEFAULT NULL,
  `accountTypeId` int NOT NULL,
  `fullName` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `address` text,
  `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `ActiveStatus` bit(1) DEFAULT b'1',
  `BalanceAmount` decimal(15,2) DEFAULT '0.00',
  `AccountStatus` int DEFAULT '1',
  `Remarks` varchar(1000) DEFAULT 'NA',
  PRIMARY KEY (`accountID`),
  KEY `userID` (`userID`),
  KEY `accountTypeId` (`accountTypeId`),
  CONSTRAINT `accounts_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `tblusers` (`UserId`),
  CONSTRAINT `accounts_ibfk_2` FOREIGN KEY (`accountTypeId`) REFERENCES `accounttypes` (`AccountTypeID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts`
--

LOCK TABLES `accounts` WRITE;
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
INSERT INTO `accounts` VALUES (1,1,'IBAN0123456','202409000001',1,'sri nidhi','prajwal.m@qsgsoft.com','7760655119','qwe','2024-09-15 09:18:21',_binary '',80.00,3,'Account is approved.'),(2,1,'IBAN0123456','202409000002',3,'sri nidhi','prajwal.m@example.com','7760655119','qwe','2024-09-15 09:18:52',_binary '',100.00,3,'Approved'),(3,1,'IBAN0123456','202409000003',2,'sri nidhi','prajwal.m@example.com','7760655119','qwe','2024-09-15 09:23:02',_binary '',100.00,1,'NA'),(4,0,'IBAN0123456','202409000004',1,'God','god.m@heaven.com','9999999999','Milky way galaxy','2024-09-15 09:23:02',_binary '',5000000.00,3,'NA'),(5,2,'IBAN0123456','202409000005',1,'Prajwal M','Prajwalmallesh1999@gmail.com','0776065511','4th cross 1st B main, shambhavinagar','2024-09-17 07:45:53',_binary '',20.00,3,'Approved');
/*!40000 ALTER TABLE `accounts` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `generate_account_number` BEFORE INSERT ON `accounts` FOR EACH ROW BEGIN
    DECLARE next_id INT;
    
    -- Manually retrieve the next auto-increment value for accountID
    SET next_id = (SELECT AUTO_INCREMENT FROM information_schema.TABLES WHERE TABLE_NAME='Accounts' AND TABLE_SCHEMA=DATABASE());

    -- Generate the account number with the current year and month
    SET NEW.accountNumber = CONCAT(YEAR(CURDATE()), LPAD(MONTH(CURDATE()), 2, '0'), LPAD(next_id, 6, '0'));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `accountstatus`
--

DROP TABLE IF EXISTS `accountstatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accountstatus` (
  `StatusId` int NOT NULL AUTO_INCREMENT,
  `Status` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`StatusId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accountstatus`
--

LOCK TABLES `accountstatus` WRITE;
/*!40000 ALTER TABLE `accountstatus` DISABLE KEYS */;
INSERT INTO `accountstatus` VALUES (1,'Processing'),(2,'On Hold'),(3,'Approved');
/*!40000 ALTER TABLE `accountstatus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounttypes`
--

DROP TABLE IF EXISTS `accounttypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounttypes` (
  `AccountTypeID` int NOT NULL AUTO_INCREMENT,
  `AccountTypeLabel` varchar(50) NOT NULL,
  PRIMARY KEY (`AccountTypeID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounttypes`
--

LOCK TABLES `accounttypes` WRITE;
/*!40000 ALTER TABLE `accounttypes` DISABLE KEYS */;
INSERT INTO `accounttypes` VALUES (1,'Savings Account'),(2,'Current Account'),(3,'Salary Account');
/*!40000 ALTER TABLE `accounttypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `beneficiary`
--

DROP TABLE IF EXISTS `beneficiary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `beneficiary` (
  `beneficiaryId` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `accountNumber` varchar(20) NOT NULL,
  `bankName` varchar(255) NOT NULL,
  `ifscCode` varchar(11) NOT NULL,
  `beneficiaryTypeId` int NOT NULL,
  `nickname` varchar(255) DEFAULT NULL,
  `address` text,
  `mobileNumber` varchar(15) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `transferLimit` decimal(15,2) DEFAULT NULL,
  `activationStart` date DEFAULT NULL,
  `activationEnd` date DEFAULT NULL,
  `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ActiveStatus` bit(1) DEFAULT b'1',
  PRIMARY KEY (`beneficiaryId`),
  KEY `userId` (`userId`),
  KEY `beneficiaryTypeId` (`beneficiaryTypeId`),
  CONSTRAINT `beneficiary_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `tblusers` (`UserId`),
  CONSTRAINT `beneficiary_ibfk_2` FOREIGN KEY (`beneficiaryTypeId`) REFERENCES `beneficiarytype` (`beneficiaryTypeId`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `beneficiary`
--

LOCK TABLES `beneficiary` WRITE;
/*!40000 ALTER TABLE `beneficiary` DISABLE KEYS */;
INSERT INTO `beneficiary` VALUES (1,1,'Prajwal M','202409000005','BDFC','IBAN0123456',1,'','WTC','1234567890','prajwal.m@example.com',0.00,'2024-09-03','2024-09-28','2024-09-16 11:50:38','2024-09-17 07:49:12',_binary '');
/*!40000 ALTER TABLE `beneficiary` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `beneficiarytype`
--

DROP TABLE IF EXISTS `beneficiarytype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `beneficiarytype` (
  `beneficiaryTypeId` int NOT NULL AUTO_INCREMENT,
  `typeName` varchar(50) NOT NULL,
  PRIMARY KEY (`beneficiaryTypeId`),
  UNIQUE KEY `typeName` (`typeName`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `beneficiarytype`
--

LOCK TABLES `beneficiarytype` WRITE;
/*!40000 ALTER TABLE `beneficiarytype` DISABLE KEYS */;
INSERT INTO `beneficiarytype` VALUES (1,'Individual'),(2,'Organization');
/*!40000 ALTER TABLE `beneficiarytype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kycdetails`
--

DROP TABLE IF EXISTS `kycdetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kycdetails` (
  `kycID` int NOT NULL AUTO_INCREMENT,
  `accountID` int NOT NULL,
  `kycDocumentTypeId` int NOT NULL,
  `kycDocumentNumber` varchar(100) NOT NULL,
  `kycStatusID` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`kycID`),
  KEY `accountID` (`accountID`),
  KEY `kycStatusID` (`kycStatusID`),
  KEY `kycDocumentTypeId` (`kycDocumentTypeId`),
  CONSTRAINT `kycdetails_ibfk_1` FOREIGN KEY (`accountID`) REFERENCES `accounts` (`accountID`),
  CONSTRAINT `kycdetails_ibfk_2` FOREIGN KEY (`kycStatusID`) REFERENCES `kycstatus` (`statusID`),
  CONSTRAINT `kycdetails_ibfk_3` FOREIGN KEY (`kycDocumentTypeId`) REFERENCES `kycoptions` (`KYCOptionID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kycdetails`
--

LOCK TABLES `kycdetails` WRITE;
/*!40000 ALTER TABLE `kycdetails` DISABLE KEYS */;
INSERT INTO `kycdetails` VALUES (1,1,1,'123412341234',1),(2,2,2,'123412341234',1),(3,3,1,'123312331233',1),(4,5,1,'112211221122',1);
/*!40000 ALTER TABLE `kycdetails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kycoptions`
--

DROP TABLE IF EXISTS `kycoptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kycoptions` (
  `KYCOptionID` int NOT NULL AUTO_INCREMENT,
  `KYCOptionLabel` varchar(50) NOT NULL,
  PRIMARY KEY (`KYCOptionID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kycoptions`
--

LOCK TABLES `kycoptions` WRITE;
/*!40000 ALTER TABLE `kycoptions` DISABLE KEYS */;
INSERT INTO `kycoptions` VALUES (1,'Aadhaar Card'),(2,'PAN Card'),(3,'Passport');
/*!40000 ALTER TABLE `kycoptions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kycstatus`
--

DROP TABLE IF EXISTS `kycstatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kycstatus` (
  `statusID` int NOT NULL AUTO_INCREMENT,
  `statusName` varchar(50) NOT NULL,
  PRIMARY KEY (`statusID`),
  UNIQUE KEY `statusName` (`statusName`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kycstatus`
--

LOCK TABLES `kycstatus` WRITE;
/*!40000 ALTER TABLE `kycstatus` DISABLE KEYS */;
INSERT INTO `kycstatus` VALUES (2,'APPROVED'),(1,'PENDING'),(3,'REJECTED');
/*!40000 ALTER TABLE `kycstatus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblroles`
--

DROP TABLE IF EXISTS `tblroles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblroles` (
  `RoleId` int NOT NULL AUTO_INCREMENT,
  `RoleName` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`RoleId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblroles`
--

LOCK TABLES `tblroles` WRITE;
/*!40000 ALTER TABLE `tblroles` DISABLE KEYS */;
INSERT INTO `tblroles` VALUES (1,'Admin'),(2,'User');
/*!40000 ALTER TABLE `tblroles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbluserroles`
--

DROP TABLE IF EXISTS `tbluserroles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbluserroles` (
  `UserRoleId` int NOT NULL AUTO_INCREMENT,
  `UserId` int DEFAULT NULL,
  `RoleId` int DEFAULT NULL,
  PRIMARY KEY (`UserRoleId`),
  KEY `UserId` (`UserId`),
  KEY `RoleId` (`RoleId`),
  CONSTRAINT `tbluserroles_ibfk_1` FOREIGN KEY (`UserId`) REFERENCES `tblusers` (`UserId`),
  CONSTRAINT `tbluserroles_ibfk_2` FOREIGN KEY (`RoleId`) REFERENCES `tblroles` (`RoleId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbluserroles`
--

LOCK TABLES `tbluserroles` WRITE;
/*!40000 ALTER TABLE `tbluserroles` DISABLE KEYS */;
INSERT INTO `tbluserroles` VALUES (1,1,2),(2,2,2),(3,3,1);
/*!40000 ALTER TABLE `tbluserroles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblusers`
--

DROP TABLE IF EXISTS `tblusers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblusers` (
  `UserId` int NOT NULL AUTO_INCREMENT,
  `UserName` varchar(200) DEFAULT NULL,
  `Password` varchar(200) DEFAULT NULL,
  `FirstName` varchar(200) DEFAULT NULL,
  `LastName` varchar(200) DEFAULT NULL,
  `Email` varchar(200) DEFAULT NULL,
  `Phone` varchar(200) DEFAULT NULL,
  `Address` blob,
  `CreatedAt` timestamp NULL DEFAULT NULL,
  `UpdatedAt` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`UserId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblusers`
--

LOCK TABLES `tblusers` WRITE;
/*!40000 ALTER TABLE `tblusers` DISABLE KEYS */;
INSERT INTO `tblusers` VALUES (1,'srinidhi','DGYYLscQhABl66pHxebOkA==','Sri','Nidhi','prajwalcode369@gmail.com','1234567890',NULL,'2024-08-26 12:27:28',NULL),(2,'Prajwal Mallesh','DGYYLscQhABl66pHxebOkA==','Prajwal','M','Prajwalmallesh1999@gmail.com','0776065511',NULL,'2024-09-17 07:45:00',NULL),(3,'Sri Hari','DGYYLscQhABl66pHxebOkA==','Sri','Hari','yuvagowda17@gmail.com','0776065512',NULL,'2024-09-17 07:46:53',NULL);
/*!40000 ALTER TABLE `tblusers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transactions` (
  `transactionId` int NOT NULL AUTO_INCREMENT,
  `senderAccountId` int DEFAULT NULL,
  `recipientAccountNumber` varchar(20) DEFAULT NULL,
  `recipientIFSC` varchar(11) DEFAULT NULL,
  `amount` decimal(15,2) DEFAULT NULL,
  `transactionDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `status` bit(1) DEFAULT NULL,
  `transactionType` bit(1) DEFAULT NULL,
  `referenceNumber` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`transactionId`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transactions`
--

LOCK TABLES `transactions` WRITE;
/*!40000 ALTER TABLE `transactions` DISABLE KEYS */;
INSERT INTO `transactions` VALUES (1,4,'202409000001','IBAN0123456',100.00,'2024-09-16 17:45:57',_binary '',_binary '\0','8798087c-7453-11ef-a1dc-902e165f51f7'),(2,1,'202409000001','IBAN0123456',100.00,'2024-09-16 17:45:57',_binary '',_binary '','879819ef-7453-11ef-a1dc-902e165f51f7'),(3,1,'202409000004','IBAN0123456',100.00,'2024-09-16 17:46:23',_binary '',_binary '\0','96e04336-7453-11ef-a1dc-902e165f51f7'),(4,4,'202409000004','IBAN0123456',100.00,'2024-09-16 17:46:23',_binary '',_binary '','96e0462f-7453-11ef-a1dc-902e165f51f7'),(5,1,'202409000005','IBAN0123456',10.00,'2024-09-17 07:49:28',_binary '',_binary '\0','5e2f8f60-74c9-11ef-a1dc-902e165f51f7'),(6,5,'202409000005','IBAN0123456',10.00,'2024-09-17 07:49:28',_binary '',_binary '','5e2f9570-74c9-11ef-a1dc-902e165f51f7'),(7,1,'202409000005','IBAN0123456',10.00,'2024-09-17 08:05:14',_binary '',_binary '\0','918ca504-74cb-11ef-a1dc-902e165f51f7'),(8,5,'202409000005','IBAN0123456',10.00,'2024-09-17 08:05:14',_binary '',_binary '','918ca923-74cb-11ef-a1dc-902e165f51f7');
/*!40000 ALTER TABLE `transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'webbanking'
--

--
-- Dumping routines for database 'webbanking'
--
/*!50003 DROP PROCEDURE IF EXISTS `GetAccountTypes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAccountTypes`()
BEGIN
    SELECT AccountTypeID, AccountTypeLabel FROM AccountTypes;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetKYCOptions` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetKYCOptions`()
BEGIN
    SELECT KYCOptionID, KYCOptionLabel FROM KYCOptions;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spRegisterUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spRegisterUser`(
    IN p_UserName VARCHAR(200),
    IN p_Password VARCHAR(200),
    IN p_FirstName VARCHAR(200),
    IN p_LastName VARCHAR(200),
    IN p_Email VARCHAR(200),
    IN p_Phone VARCHAR(200),
    OUT v_ResultCode INT
)
BEGIN
    DECLARE v_UserExists INT;
    DECLARE v_EmailExists INT;
    DECLARE v_PhoneExists INT;
    DECLARE v_NewUserId INT;

    -- Check if the username already exists
    SELECT COUNT(*)
    INTO v_UserExists
    FROM tblUsers
    WHERE UserName = p_UserName;

    IF v_UserExists > 0 THEN
        SET v_ResultCode = -1; -- Username already exists
    ELSE
        -- Check if the email already exists
        SELECT COUNT(*)
        INTO v_EmailExists
        FROM tblUsers
        WHERE Email = p_Email;

        IF v_EmailExists > 0 THEN
            SET v_ResultCode = -2; -- Email already exists
        ELSE
            -- Check if the phone number already exists
            SELECT COUNT(*)
            INTO v_PhoneExists
            FROM tblUsers
            WHERE Phone = p_Phone;

            IF v_PhoneExists > 0 THEN
                SET v_ResultCode = -3; -- Phone number already exists
            ELSE
                -- Insert the new user if username, email, and phone number are unique
                INSERT INTO tblUsers (UserName, `Password`, FirstName, LastName, Email, Phone, CreatedAt, UpdatedAt)
                VALUES (p_UserName, p_Password, p_FirstName, p_LastName, p_Email, p_Phone, NOW(), NULL);

                -- Get the ID of the newly inserted user
                SET v_NewUserId = LAST_INSERT_ID();

                -- Insert into tblUserRoles with RoleId = 2
                INSERT INTO tblUserRoles (UserId, RoleId)
                VALUES (v_NewUserId, 2);

                -- Success
                SET v_ResultCode = 0;
            END IF;
        END IF;
    END IF;

    -- Return the result code
    SELECT v_ResultCode AS v_ResultCode;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spUserLogin` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spUserLogin`(
    IN p_credential VARCHAR(200),
    IN p_password VARCHAR(200)
)
BEGIN
    DECLARE v_UserId INT;
    DECLARE v_UserName VARCHAR(200);
    DECLARE v_Email VARCHAR(200);
    DECLARE v_FirstName VARCHAR(200);
    DECLARE v_LastName VARCHAR(200);
	DECLARE message varchar(100);
    -- Attempt to find the user by username and password
    SELECT UserId, UserName, Email, FirstName, LastName
    INTO v_UserId, v_UserName, v_Email, v_FirstName, v_LastName
    FROM tblUsers
    WHERE (UserName = p_credential OR Email = p_credential)
      AND Password = p_password
    LIMIT 1;

    -- Check if user was found
    IF v_UserId IS NOT NULL THEN
        SELECT json_arrayagg(
        json_object(
        'userId',u.UserId, 
        'userName',u.UserName, 
        'emai',u.Email, 
        'firstName',u.FirstName, 
        'lastName',u.LastName,
		'roleId' ,r.RoleId,
        'roleName', r.RoleName, 
        'userRoleId', ur.UserRoleId
        )
        ) as result
        FROM tblUsers u
        JOIN tblUserRoles ur ON u.UserId = ur.UserId
        JOIN tblRoles r ON ur.RoleId = r.RoleId
        WHERE u.UserId = v_UserId;
    ELSE
    set message = 'Invalid username/email or password';
     -- json_object('message',message) AS message
        SELECT null;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SP_CreateTransaction` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_CreateTransaction`(
    IN p_senderAccountId INT,
    IN p_recipientAccountNumber VARCHAR(20),
    IN p_recipientIFSC VARCHAR(11),
    IN p_amount DECIMAL(15, 2),
    OUT p_statusCode INT,
    OUT p_message VARCHAR(255)
)
BEGIN
    DECLARE v_senderBalance DECIMAL(15, 2);
    DECLARE v_recipientAccountId INT;

    -- Initialize output parameters
    SET p_statusCode = 0;
    SET p_message = 'Transaction successful';

    -- Start transaction
    START TRANSACTION;

    -- Check sender's balance
    SELECT BalanceAmount INTO v_senderBalance
    FROM accounts
    WHERE accountId = p_senderAccountId and AccountStatus = 3 AND ActiveStatus = 1;

    -- Validate sender's balance
    IF v_senderBalance IS NULL THEN
        SET p_statusCode = 3; -- Sender account not found
        SET p_message = 'Sender account not found';
        ROLLBACK;
    ELSEIF v_senderBalance < p_amount THEN
        SET p_statusCode = 1; -- Insufficient balance
        SET p_message = 'Insufficient balance';
        ROLLBACK;
    ELSE
        -- Check if recipient exists based on account number and IFSC
        SELECT accountId INTO v_recipientAccountId
        FROM accounts
        WHERE accountNumber = p_recipientAccountNumber AND IFSC = p_recipientIFSC AND  AccountStatus = 3 AND ActiveStatus = 1;

        IF v_recipientAccountId IS NULL THEN
            SET p_statusCode = 2; -- Recipient account not found
            SET p_message = 'Recipient account not found';
            ROLLBACK;
        ELSE
            -- Deduct amount from sender
            UPDATE accounts
            SET BalanceAmount = BalanceAmount - p_amount
            WHERE accountId = p_senderAccountId;

            -- Add amount to recipient
            UPDATE accounts
            SET BalanceAmount = BalanceAmount + p_amount
            WHERE accountId = v_recipientAccountId;

            -- Insert the transaction record for the sender (debit = 0)
            INSERT INTO transactions (senderAccountId, recipientAccountNumber, recipientIFSC, amount, status, transactionType, referenceNumber)
            VALUES (p_senderAccountId, p_recipientAccountNumber, p_recipientIFSC, p_amount, 1, 0, UUID());

            -- Insert the transaction record for the recipient (credit = 1)
            INSERT INTO transactions (senderAccountId, recipientAccountNumber, recipientIFSC, amount, status, transactionType, referenceNumber)
            VALUES (v_recipientAccountId, p_recipientAccountNumber, p_recipientIFSC, p_amount, 1, 1, UUID());

            -- Commit transaction
            COMMIT;
        END IF;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SP_GetAccountDetails` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_GetAccountDetails`(
    IN p_queryType INT,    -- New parameter to determine the type of query
    IN p_accountID INT     -- AccountID parameter, used when queryType is 2
)
BEGIN
    IF p_queryType = 1 THEN
        -- Case 1: Get all account details
        SELECT 
            a.accountID AS AccountID,
            a.accountNumber AS AccountNumber,
            a.IFSC AS IFSC,
            a.fullName AS AccFullName,  -- Changed fullName to AccFullName
            a.email AS AccEmail,
            a.phone AS AccPhone,
            a.address AS AccAddress,
            a.createdAt AS AccCreatedAt,
            a.ActiveStatus AS ActiveStatus,
            a.BalanceAmount AS BalanceAmount,
            a.Remarks AS AccRemarks,
            
            ats.StatusId AS AccountStatusID,       -- Fetch AccountStatusID
            ats.Status AS AccountStatusName,       -- Fetch AccountStatusName
            
            atp.AccountTypeID AS AccountTypeID,    -- Fetch AccountTypeID
            atp.AccountTypeLabel AS AccountTypeName, -- Fetch AccountTypeLabel
            
            u.UserID AS UserID,
            u.UserName AS UserName,
            u.FirstName AS UserFirstName,
            u.LastName AS UserLastName,
            u.Email AS UserEmail,
            u.Phone AS UserPhone,
            u.Address AS UserAddress,
            u.CreatedAt AS UserCreatedAt,
            
            k.kycID AS KycID,
            ko.KYCOptionID AS KycOptionID,         -- Fetch KYCOptionID
            ko.KYCOptionLabel AS KycOptionLabel,   -- Fetch KYCOptionLabel
            k.kycDocumentNumber AS KycDocumentNumber,
            
            ks.statusID AS KycStatusID,            -- Fetch KYCStatusID
            ks.statusName AS KycStatusName         -- Fetch KYCStatusName
        FROM accounts a
        JOIN tblusers u ON a.userID = u.UserID
        LEFT JOIN accountstatus ats ON a.AccountStatus = ats.StatusId
        LEFT JOIN accounttypes atp ON a.accountTypeId = atp.AccountTypeID
        LEFT JOIN kycdetails k ON a.accountID = k.accountID
        LEFT JOIN kycoptions ko ON k.kycDocumentTypeId = ko.KYCOptionID
        LEFT JOIN kycstatus ks ON k.kycStatusID = ks.statusID
        where a.ActiveStatus = 1;
        
    ELSEIF p_queryType = 2 THEN
        -- Case 2: Get account details by accountID
        SELECT 
            a.accountID AS AccountID,
            a.accountNumber AS AccountNumber,
            a.IFSC AS IFSC,
            a.fullName AS AccFullName,  -- Changed fullName to AccFullName
            a.email AS AccEmail,
            a.phone AS AccPhone,
            a.address AS AccAddress,
            a.createdAt AS AccCreatedAt,
            a.ActiveStatus AS ActiveStatus,
            a.BalanceAmount AS BalanceAmount,
            a.Remarks AS AccRemarks,
            
            ats.StatusId AS AccountStatusID,       -- Fetch AccountStatusID
            ats.Status AS AccountStatusName,       -- Fetch AccountStatusName
            
            atp.AccountTypeID AS AccountTypeID,    -- Fetch AccountTypeID
            atp.AccountTypeLabel AS AccountTypeName, -- Fetch AccountTypeLabel
            
            u.UserID AS UserID,
            u.UserName AS UserName,
            u.FirstName AS UserFirstName,
            u.LastName AS UserLastName,
            u.Email AS UserEmail,
            u.Phone AS UserPhone,
            u.Address AS UserAddress,
            u.CreatedAt AS UserCreatedAt,
            
            k.kycID AS KycID,
            ko.KYCOptionID AS KycOptionID,         -- Fetch KYCOptionID
            ko.KYCOptionLabel AS KycOptionLabel,   -- Fetch KYCOptionLabel
            k.kycDocumentNumber AS KycDocumentNumber,
            
            ks.statusID AS KycStatusID,            -- Fetch KYCStatusID
            ks.statusName AS KycStatusName         -- Fetch KYCStatusName
        FROM accounts a
        JOIN tblusers u ON a.userID = u.UserID
        LEFT JOIN accountstatus ats ON a.AccountStatus = ats.StatusId
        LEFT JOIN accounttypes atp ON a.accountTypeId = atp.AccountTypeID
        LEFT JOIN kycdetails k ON a.accountID = k.accountID
        LEFT JOIN kycoptions ko ON k.kycDocumentTypeId = ko.KYCOptionID
        LEFT JOIN kycstatus ks ON k.kycStatusID = ks.statusID
        WHERE a.accountID = p_accountID and  a.ActiveStatus = 1;
    END IF;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SP_GetAccoutStatusOptions` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_GetAccoutStatusOptions`()
BEGIN
select StatusId, `Status` from accountstatus;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SP_getAllBeneficiaryTypes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_getAllBeneficiaryTypes`()
BEGIN
    SELECT 
        beneficiaryTypeId AS id,
        typeName AS name
    FROM BeneficiaryType;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SP_GetAllUsers` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_GetAllUsers`()
BEGIN
    SELECT 
        UserId,
        UserName,
        FirstName,
        LastName,
        Email,
        Phone,
        Address
    FROM tblusers;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SP_getBeneficiaries` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_getBeneficiaries`(
    IN queryType INT,
    IN p_userId INT,
    IN p_beneficiaryId INT
)
BEGIN
    CASE
    WHEN queryType = 1 THEN 
        SELECT 
            b.beneficiaryId AS beneficiaryId,
            b.userId AS userId,
            b.`name` AS `name`,
            b.accountNumber AS accountNumber,
            b.bankName AS bankName,
            b.ifscCode AS ifscCode,
            bt.beneficiaryTypeId AS beneficiaryType, -- Return the ID
            bt.typeName AS beneficiaryTypeName, -- Return the name
            b.nickname AS nickname,
            b.address AS address,
            b.mobileNumber AS mobileNumber,
            b.email AS email,
            b.transferLimit AS transferLimit,
            b.activationStart AS activationStart,
            b.activationEnd AS activationEnd
        FROM Beneficiary b
        JOIN BeneficiaryType bt ON b.beneficiaryTypeId = bt.beneficiaryTypeId
        WHERE b.userId = p_userId and b.ActiveStatus = 1;
    
    WHEN queryType = 2 THEN
        SELECT 
            b.beneficiaryId AS beneficiaryId,
            b.userId AS userId,
            b.`name` AS `name`,
            b.accountNumber AS accountNumber,
            b.bankName AS bankName,
            b.ifscCode AS ifscCode,
            bt.beneficiaryTypeId AS beneficiaryType, -- Return the ID
            bt.typeName AS beneficiaryTypeName, -- Return the name
            b.nickname AS nickname,
            b.address AS address,
            b.mobileNumber AS mobileNumber,
            b.email AS email,
            b.transferLimit AS transferLimit,
            b.activationStart AS activationStart,
            b.activationEnd AS activationEnd
        FROM Beneficiary b
        JOIN BeneficiaryType bt ON b.beneficiaryTypeId = bt.beneficiaryTypeId
        WHERE b.userId = p_userId AND b.beneficiaryId = p_beneficiaryId and b.ActiveStatus = 1;
    END CASE;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SP_GetTransactionDetails` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_GetTransactionDetails`(
    IN queryType INT,  -- 1: Get all transactions, 2: Get transactions for a specific user
    IN userId INT      -- UserId to filter transactions (only applicable when queryType = 2)
)
BEGIN
    IF queryType = 1 THEN
        -- Get all transactions with sender and recipient details
        SELECT 
            t.transactionId,
            t.senderAccountId,
            sa.fullName AS senderName,
            t.recipientAccountNumber,
            t.recipientIFSC,
            ra.fullName AS recipientName,  -- Join to get recipient full name from accounts
            -- Display amount with + for Credit (transactionType = 1) and - for Debit (transactionType = 0)
            CASE 
                WHEN t.transactionType = 1 THEN t.amount  -- Credit
                ELSE -t.amount                            -- Debit
            END AS amount,
            t.transactionDate,
            -- Display status as 'Success' for 1 and 'Failed' for 0
            CASE 
                WHEN t.status = 1 THEN 'Success' 
                ELSE 'Failed'
            END AS status,
            -- Display transactionType as 'Credit' for 1 and 'Debit' for 0
            CASE 
                WHEN t.transactionType = 1 THEN 'Credit' 
                ELSE 'Debit'
            END AS transactionType,
            t.referenceNumber
        FROM transactions t
        LEFT JOIN accounts sa ON t.senderAccountId = sa.accountID  -- Join for sender's details
        LEFT JOIN accounts ra ON t.recipientAccountNumber = ra.accountNumber AND t.recipientIFSC = ra.IFSC  -- Join for recipient's details
        ORDER BY t.transactionDate DESC;  -- Order by latest transactionDate

    ELSEIF queryType = 2 THEN
        -- Get transactions for a specific user based on their accountID
        SELECT 
            t.transactionId,
            t.senderAccountId,
            sa.fullName AS senderName,
            t.recipientAccountNumber,
            t.recipientIFSC,
            ra.fullName AS recipientName,  -- Join to get recipient full name from accounts
            -- Display amount with + for Credit (transactionType = 1) and - for Debit (transactionType = 0)
            CASE 
                WHEN t.transactionType = 1 THEN t.amount  -- Credit
                ELSE -t.amount                            -- Debit
            END AS amount,
            t.transactionDate,
            -- Display status as 'Success' for 1 and 'Failed' for 0
            CASE 
                WHEN t.status = 1 THEN 'Success' 
                ELSE 'Failed'
            END AS status,
            -- Display transactionType as 'Credit' for 1 and 'Debit' for 0
            CASE 
                WHEN t.transactionType = 1 THEN 'Credit' 
                ELSE 'Debit'
            END AS transactionType,
            t.referenceNumber
        FROM transactions t
        LEFT JOIN accounts sa ON t.senderAccountId = sa.accountID  -- Join for sender's details
        LEFT JOIN accounts ra ON t.recipientAccountNumber = ra.accountNumber AND t.recipientIFSC = ra.IFSC  -- Join for recipient's details
        WHERE sa.userID = userId
        ORDER BY t.transactionDate DESC;  -- Order by latest transactionDate

    ELSE
        -- If queryType is invalid
        SELECT 'Invalid query type' AS errorMessage;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SP_GetUserAccountDetails` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_GetUserAccountDetails`(
IN User_ID int 
)
BEGIN
    SELECT 
        a.accountID,
        a.IFSC,
        a.accountNumber,
        a.accountTypeId AS accountTypeId,
        at.AccountTypeLabel AS accountType,
        a.fullName,
        a.email,
        a.phone,
        a.address,
        a.createdAt,
        a.ActiveStatus,
        a.BalanceAmount,
        a.AccountStatus AS accountStatusId,
        `as`.Status AS accountStatus,
        a.Remarks
    FROM 
        accounts a
    JOIN 
        accounttypes at ON a.accountTypeId = at.AccountTypeID
    JOIN 
        accountstatus `as` ON a.AccountStatus = `as`.StatusId
        where UserID = User_ID and ActiveStatus = 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SP_InsertAccountAndKYC` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_InsertAccountAndKYC`(
    IN p_userID INT,
    IN p_accountTypeId INT,
    IN p_fullName VARCHAR(50),
    IN p_email VARCHAR(100),
    IN p_phone VARCHAR(20),
    IN p_address TEXT,
    IN p_kycDocumentTypeId INT,
    IN p_kycDocumentNumber VARCHAR(100),
    OUT p_responseCode INT,
    OUT p_responseMessage VARCHAR(255)
)
BEGIN
    DECLARE v_accountID INT;

    -- Declare the exit handler for any SQL exception
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
        -- Rollback transaction if any error occurs
        ROLLBACK;
        SET p_responseCode = 500;
        SET p_responseMessage = 'An error occurred. Transaction rolled back.';
    END;

    -- Check if the user already has the given accountTypeId
    IF EXISTS (
        SELECT 1 FROM Accounts 
        WHERE userID = p_userID AND accountTypeId = p_accountTypeId
    ) THEN
        SET p_responseCode = 1;
        SET p_responseMessage = 'Already account exists';
    ELSE
        -- Start a transaction
        START TRANSACTION;

        -- Insert into Accounts table
        INSERT INTO Accounts (
            userID, accountTypeId, fullName, email, phone, address
        )
        VALUES (
            p_userID, p_accountTypeId, p_fullName, p_email, p_phone, p_address
        );

        -- Retrieve the last inserted accountID
        SET v_accountID = LAST_INSERT_ID();

        -- Insert into KYCDetails table
        INSERT INTO KYCDetails (
            accountID, kycDocumentTypeId, kycDocumentNumber
        )
        VALUES (
            v_accountID, p_kycDocumentTypeId, p_kycDocumentNumber
        );

        -- Commit the transaction
        COMMIT;

        -- Set success response code and message
        SET p_responseCode = 0;
        SET p_responseMessage = 'Account and KYC details inserted successfully';
    END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SP_insertBeneficiary` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_insertBeneficiary`(
    IN p_userId INT,
    IN p_name VARCHAR(255),
    IN p_accountNumber VARCHAR(20),
    IN p_bankName VARCHAR(255),
    IN p_ifscCode VARCHAR(11),
    IN p_beneficiaryTypeId INT,
    IN p_nickname VARCHAR(255),
    IN p_address TEXT,
    IN p_mobileNumber VARCHAR(15),
    IN p_email VARCHAR(255),
    IN p_transferLimit DECIMAL(15, 2),
    IN p_activationStart DATE,
    IN p_activationEnd DATE
)
BEGIN
    INSERT INTO Beneficiary (
        userId, name, accountNumber, bankName, ifscCode, beneficiaryTypeId, nickname, 
        address, mobileNumber, email, transferLimit, activationStart, activationEnd
    ) VALUES (
        p_userId, p_name, p_accountNumber, p_bankName, p_ifscCode, p_beneficiaryTypeId, p_nickname, 
        p_address, p_mobileNumber, p_email, p_transferLimit, p_activationStart, p_activationEnd
    );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SP_SoftDeleteBeneficiary` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_SoftDeleteBeneficiary`(IN beneficiary_Id INT)
BEGIN
    -- Update ActiveStatus to 0 (soft delete)
    UPDATE beneficiary 
    SET ActiveStatus = 0, updatedAt = CURRENT_TIMESTAMP
    WHERE beneficiaryId = beneficiary_Id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SP_UpdateAccountStatus` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_UpdateAccountStatus`(
    IN p_accountID INT,            -- The account ID for which the update is performed
    IN p_newAccountStatus INT,      -- The new account status
    IN p_newRemarks VARCHAR(1000)   -- The new remarks for the update
)
BEGIN
    -- Update the AccountStatus and Remarks for the provided accountID
    UPDATE accounts
    SET
        AccountStatus = p_newAccountStatus,  -- Update the account status
        Remarks = p_newRemarks               -- Update the remarks
    WHERE
        accountID = p_accountID;             -- Match the accountID to perform the update

    -- Optionally: You can add a check if the account exists and return a message.
    IF ROW_COUNT() = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No account found with the provided accountID';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SP_updateBeneficiary` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_updateBeneficiary`(
    IN p_beneficiaryId INT,
    IN p_userId INT,
    IN p_name VARCHAR(255),
    IN p_accountNumber VARCHAR(20),
    IN p_bankName VARCHAR(255),
    IN p_ifscCode VARCHAR(11),
    IN p_beneficiaryTypeId INT,
    IN p_nickname VARCHAR(255),
    IN p_address TEXT,
    IN p_mobileNumber VARCHAR(15),
    IN p_email VARCHAR(255),
    IN p_transferLimit DECIMAL(15, 2),
    IN p_activationStart DATE,
    IN p_activationEnd DATE
)
BEGIN
    UPDATE Beneficiary
    SET 
        name = p_name,
        accountNumber = p_accountNumber,
        bankName = p_bankName,
        ifscCode = p_ifscCode,
        beneficiaryTypeId = p_beneficiaryTypeId,
        nickname = p_nickname,
        address = p_address,
        mobileNumber = p_mobileNumber,
        email = p_email,
        transferLimit = p_transferLimit,
        activationStart = p_activationStart,
        activationEnd = p_activationEnd
    WHERE beneficiaryId = p_beneficiaryId AND userId = p_userId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-09-17 16:33:28
