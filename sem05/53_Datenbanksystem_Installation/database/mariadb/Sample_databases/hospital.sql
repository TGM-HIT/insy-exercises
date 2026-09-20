-- MySQL dump 10.13  Distrib 5.7.22, for Linux (x86_64)
--
-- Host: localhost    Database: drugie
-- ------------------------------------------------------
-- Server version	5.6.40

DROP DATABASE IF EXISTS hospital;
CREATE DATABASE hospital;
USE hospital;

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `affiliated_with`
--

DROP TABLE IF EXISTS `affiliated_with`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `affiliated_with` (
  `physician` int(11) NOT NULL,
  `department` int(11) NOT NULL,
  `primaryaffiliation` tinyint(1) NOT NULL,
  PRIMARY KEY (`physician`,`department`),
  KEY `fk_department_departmentid` (`department`),
  CONSTRAINT `fk_department_departmentid` FOREIGN KEY (`department`) REFERENCES `department` (`departmentid`),
  CONSTRAINT `fk_physician_employeeid11652` FOREIGN KEY (`physician`) REFERENCES `physician` (`employeeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `affiliated_with`
--

LOCK TABLES `affiliated_with` WRITE;
/*!40000 ALTER TABLE `affiliated_with` DISABLE KEYS */;
INSERT INTO `affiliated_with` VALUES (1,1,1),(2,1,1),(3,1,0),(3,2,1),(4,1,1),(5,1,1),(6,2,1),(7,1,0),(7,2,1),(8,1,1),(9,3,1);
/*!40000 ALTER TABLE `affiliated_with` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `appointment`
--

DROP TABLE IF EXISTS `appointment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `appointment` (
  `appointmentid` int(11) NOT NULL,
  `patient` int(11) NOT NULL,
  `prepnurse` int(11) DEFAULT NULL,
  `physician` int(11) NOT NULL,
  `start_dt_time` datetime NOT NULL,
  `end_dt_time` datetime NOT NULL,
  `examinationroom` text NOT NULL,
  PRIMARY KEY (`appointmentid`),
  KEY `fk_nurse_employeeid11580` (`prepnurse`),
  KEY `fk_patient_ssn11612` (`patient`),
  KEY `fk_physician_employeeid11676` (`physician`),
  CONSTRAINT `fk_nurse_employeeid11580` FOREIGN KEY (`prepnurse`) REFERENCES `nurse` (`employeeid`),
  CONSTRAINT `fk_patient_ssn11612` FOREIGN KEY (`patient`) REFERENCES `patient` (`ssn`),
  CONSTRAINT `fk_physician_employeeid11676` FOREIGN KEY (`physician`) REFERENCES `physician` (`employeeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointment`
--

LOCK TABLES `appointment` WRITE;
/*!40000 ALTER TABLE `appointment` DISABLE KEYS */;
INSERT INTO `appointment` VALUES (13216584,100000001,101,1,'2008-04-24 10:00:00','2008-04-24 11:00:00','A'),(26548913,100000002,101,2,'2008-04-24 10:00:00','2008-04-24 11:00:00','B'),(36549879,100000001,102,1,'2008-04-25 10:00:00','2008-04-25 11:00:00','A'),(46846589,100000004,103,4,'2008-04-25 10:00:00','2008-04-25 11:00:00','B'),(59871321,100000004,NULL,4,'2008-04-26 10:00:00','2008-04-26 11:00:00','C'),(69879231,100000003,103,2,'2008-04-26 11:00:00','2008-04-26 12:00:00','C'),(76983231,100000001,NULL,3,'2008-04-26 12:00:00','2008-04-26 13:00:00','C'),(86213939,100000004,102,9,'2008-04-27 10:00:00','2008-04-21 11:00:00','A'),(93216548,100000002,101,2,'2008-04-27 10:00:00','2008-04-27 11:00:00','B');
/*!40000 ALTER TABLE `appointment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `block`
--

DROP TABLE IF EXISTS `block`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `block` (
  `blockfloor` int(11) NOT NULL,
  `blockcode` int(11) NOT NULL,
  PRIMARY KEY (`blockfloor`,`blockcode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `block`
--

LOCK TABLES `block` WRITE;
/*!40000 ALTER TABLE `block` DISABLE KEYS */;
INSERT INTO `block` VALUES (1,1),(1,2),(1,3),(2,1),(2,2),(2,3),(3,1),(3,2),(3,3),(4,1),(4,2),(4,3);
/*!40000 ALTER TABLE `block` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `department` (
  `departmentid` int(11) NOT NULL,
  `name` text NOT NULL,
  `head` int(11) NOT NULL,
  PRIMARY KEY (`departmentid`),
  KEY `fk_physician_employeeid11644` (`head`),
  CONSTRAINT `fk_physician_employeeid11644` FOREIGN KEY (`head`) REFERENCES `physician` (`employeeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` VALUES (1,'General Medicine',4),(2,'Surgery',7),(3,'Psychiatry',9);
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medication`
--

DROP TABLE IF EXISTS `medication`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `medication` (
  `code` int(11) NOT NULL,
  `name` text NOT NULL,
  `brand` text NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medication`
--

LOCK TABLES `medication` WRITE;
/*!40000 ALTER TABLE `medication` DISABLE KEYS */;
INSERT INTO `medication` VALUES (1,'Procrastin-X','X','N/A'),(2,'Thesisin','Foo Labs','N/A'),(3,'Awakin','Bar Laboratories','N/A'),(4,'Crescavitin','Baz Industries','N/A'),(5,'Melioraurin','Snafu Pharmaceuticals','N/A');
/*!40000 ALTER TABLE `medication` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nurse`
--

DROP TABLE IF EXISTS `nurse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nurse` (
  `employeeid` int(11) NOT NULL,
  `name` text NOT NULL,
  `position` text NOT NULL,
  `registered` tinyint(1) NOT NULL,
  `ssn` int(11) NOT NULL,
  PRIMARY KEY (`employeeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nurse`
--

LOCK TABLES `nurse` WRITE;
/*!40000 ALTER TABLE `nurse` DISABLE KEYS */;
INSERT INTO `nurse` VALUES (101,'Carla Espinosa','Head Nurse',1,111111110),(102,'Laverne Roberts','Nurse',1,222222220),(103,'Paul Flowers','Nurse',0,333333330);
/*!40000 ALTER TABLE `nurse` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `on_call`
--

DROP TABLE IF EXISTS `on_call`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `on_call` (
  `nurse` int(11) NOT NULL,
  `blockfloor` int(11) NOT NULL,
  `blockcode` int(11) NOT NULL,
  `oncallstart` datetime NOT NULL,
  `oncallend` datetime NOT NULL,
  PRIMARY KEY (`nurse`,`blockfloor`,`blockcode`,`oncallstart`,`oncallend`),
  KEY `fk_oncall_block_floor` (`blockfloor`,`blockcode`),
  CONSTRAINT `fk_oncall_block_floor` FOREIGN KEY (`blockfloor`, `blockcode`) REFERENCES `block` (`blockfloor`, `blockcode`),
  CONSTRAINT `fk_oncall_nurse_employeeid` FOREIGN KEY (`nurse`) REFERENCES `nurse` (`employeeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `on_call`
--

LOCK TABLES `on_call` WRITE;
/*!40000 ALTER TABLE `on_call` DISABLE KEYS */;
INSERT INTO `on_call` VALUES (101,1,1,'2008-11-04 11:00:00','2008-11-04 19:00:00'),(103,1,1,'2008-11-04 19:00:00','2008-11-05 03:00:00'),(101,1,2,'2008-11-04 11:00:00','2008-11-04 19:00:00'),(103,1,2,'2008-11-04 19:00:00','2008-11-05 03:00:00'),(102,1,3,'2008-11-04 11:00:00','2008-11-04 19:00:00'),(103,1,3,'2008-11-04 19:00:00','2008-11-05 03:00:00');
/*!40000 ALTER TABLE `on_call` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient`
--

DROP TABLE IF EXISTS `patient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patient` (
  `ssn` int(11) NOT NULL,
  `name` text NOT NULL,
  `address` text NOT NULL,
  `phone` text NOT NULL,
  `insuranceid` int(11) NOT NULL,
  `pcp` int(11) NOT NULL,
  PRIMARY KEY (`ssn`),
  KEY `fk_physician_employeeid11668` (`pcp`),
  CONSTRAINT `fk_physician_employeeid11668` FOREIGN KEY (`pcp`) REFERENCES `physician` (`employeeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient`
--

LOCK TABLES `patient` WRITE;
/*!40000 ALTER TABLE `patient` DISABLE KEYS */;
INSERT INTO `patient` VALUES (100000001,'John Smith','42 Foobar Lane','555-0256',68476213,1),(100000002,'Grace Ritchie','37 Snafu Drive','555-0512',36546321,2),(100000003,'Random J. Patient','101 Omgbbq Street','555-1204',65465421,2),(100000004,'Dennis Doe','1100 Foobaz Avenue','555-2048',68421879,3);
/*!40000 ALTER TABLE `patient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `physician`
--

DROP TABLE IF EXISTS `physician`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `physician` (
  `employeeid` int(11) NOT NULL,
  `name` text NOT NULL,
  `position` text NOT NULL,
  `ssn` int(11) NOT NULL,
  PRIMARY KEY (`employeeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `physician`
--

LOCK TABLES `physician` WRITE;
/*!40000 ALTER TABLE `physician` DISABLE KEYS */;
INSERT INTO `physician` VALUES (1,'John Dorian','Staff Internist',111111111),(2,'Elliot Reid','Attending Physician',222222222),(3,'Christopher Turk','Surgical Attending Physician',333333333),(4,'Percival Cox','Senior Attending Physician',444444444),(5,'Bob Kelso','Head Chief of Medicine',555555555),(6,'Todd Quinlan','Surgical Attending Physician',666666666),(7,'John Wen','Surgical Attending Physician',777777777),(8,'Keith Dudemeister','MD Resident',888888888),(9,'Molly Clock','Attending Psychiatrist',999999999);
/*!40000 ALTER TABLE `physician` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prescribes`
--

DROP TABLE IF EXISTS `prescribes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prescribes` (
  `physician` int(11) NOT NULL,
  `patient` int(11) NOT NULL,
  `medication` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `appointment` int(11) DEFAULT NULL,
  `dose` text NOT NULL,
  PRIMARY KEY (`physician`,`patient`,`medication`,`date`),
  KEY `fk_appointment_appointmentid` (`appointment`),
  KEY `fk_medication_code` (`medication`),
  KEY `fk_patient_ssn11620` (`patient`),
  CONSTRAINT `fk_appointment_appointmentid` FOREIGN KEY (`appointment`) REFERENCES `appointment` (`appointmentid`),
  CONSTRAINT `fk_medication_code` FOREIGN KEY (`medication`) REFERENCES `medication` (`code`),
  CONSTRAINT `fk_patient_ssn11620` FOREIGN KEY (`patient`) REFERENCES `patient` (`ssn`),
  CONSTRAINT `fk_physician_employeeid11684` FOREIGN KEY (`physician`) REFERENCES `physician` (`employeeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prescribes`
--

LOCK TABLES `prescribes` WRITE;
/*!40000 ALTER TABLE `prescribes` DISABLE KEYS */;
INSERT INTO `prescribes` VALUES (1,100000001,1,'2008-04-24 10:47:00',13216584,'5'),(9,100000004,2,'2008-04-27 10:53:00',86213939,'10'),(9,100000004,2,'2008-04-30 16:53:00',NULL,'5');
/*!40000 ALTER TABLE `prescribes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `procedure`
--

DROP TABLE IF EXISTS `procedure`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `procedure` (
  `code` int(11) NOT NULL,
  `name` text NOT NULL,
  `cost` double NOT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `procedure`
--

LOCK TABLES `procedure` WRITE;
/*!40000 ALTER TABLE `procedure` DISABLE KEYS */;
INSERT INTO `procedure` VALUES (1,'Reverse Rhinopodoplasty',1500),(2,'Obtuse Pyloric Recombobulation',3750),(3,'Folded Demiophtalmectomy',4500),(4,'Complete Walletectomy',10000),(5,'Obfuscated Dermogastrotomy',4899),(6,'Reversible Pancreomyoplasty',5600),(7,'Follicular Demiectomy',25);
/*!40000 ALTER TABLE `procedure` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `room`
--

DROP TABLE IF EXISTS `room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `room` (
  `roomnumber` int(11) NOT NULL,
  `roomtype` varchar(30) NOT NULL,
  `blockfloor` int(11) NOT NULL,
  `blockcode` int(11) NOT NULL,
  `unavailable` tinyint(1) NOT NULL,
  PRIMARY KEY (`roomnumber`),
  KEY `fk_room_block_pk` (`blockfloor`,`blockcode`),
  CONSTRAINT `fk_room_block_pk` FOREIGN KEY (`blockfloor`, `blockcode`) REFERENCES `block` (`blockfloor`, `blockcode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room`
--

LOCK TABLES `room` WRITE;
/*!40000 ALTER TABLE `room` DISABLE KEYS */;
INSERT INTO `room` VALUES (101,'Single',1,1,0),(102,'Single',1,1,0),(103,'Single',1,1,0),(111,'Single',1,2,0),(112,'Single',1,2,1),(113,'Single',1,2,0),(121,'Single',1,3,0),(122,'Single',1,3,0),(123,'Single',1,3,0),(201,'Single',2,1,1),(202,'Single',2,1,0),(203,'Single',2,1,0),(211,'Single',2,2,0),(212,'Single',2,2,0),(213,'Single',2,2,1),(221,'Single',2,3,0),(222,'Single',2,3,0),(223,'Single',2,3,0),(301,'Single',3,1,0),(302,'Single',3,1,1),(303,'Single',3,1,0),(311,'Single',3,2,0),(312,'Single',3,2,0),(313,'Single',3,2,0),(321,'Single',3,3,1),(322,'Single',3,3,0),(323,'Single',3,3,0),(401,'Single',4,1,0),(402,'Single',4,1,1),(403,'Single',4,1,0),(411,'Single',4,2,0),(412,'Single',4,2,0),(413,'Single',4,2,0),(421,'Single',4,3,1),(422,'Single',4,3,0),(423,'Single',4,3,0);
/*!40000 ALTER TABLE `room` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stay`
--

DROP TABLE IF EXISTS `stay`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stay` (
  `stayid` int(11) NOT NULL,
  `patient` int(11) NOT NULL,
  `room` int(11) NOT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime NOT NULL,
  PRIMARY KEY (`stayid`),
  KEY `fk_patient_ssn11628` (`patient`),
  KEY `fk_room_number` (`room`),
  CONSTRAINT `fk_patient_ssn11628` FOREIGN KEY (`patient`) REFERENCES `patient` (`ssn`),
  CONSTRAINT `fk_room_number` FOREIGN KEY (`room`) REFERENCES `room` (`roomnumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stay`
--

LOCK TABLES `stay` WRITE;
/*!40000 ALTER TABLE `stay` DISABLE KEYS */;
INSERT INTO `stay` VALUES (3215,100000001,111,'2008-05-01 00:00:00','2008-05-04 00:00:00'),(3216,100000003,123,'2008-05-03 00:00:00','2008-05-14 00:00:00'),(3217,100000004,112,'2008-05-02 00:00:00','2008-05-03 00:00:00');
/*!40000 ALTER TABLE `stay` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trained_in`
--

DROP TABLE IF EXISTS `trained_in`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trained_in` (
  `physician` int(11) NOT NULL,
  `treatment` int(11) NOT NULL,
  `certificationdate` date NOT NULL,
  `certificationexpires` date NOT NULL,
  PRIMARY KEY (`physician`,`treatment`),
  KEY `fk_procedure_code11700` (`treatment`),
  CONSTRAINT `fk_physician_employeeid11660` FOREIGN KEY (`physician`) REFERENCES `physician` (`employeeid`),
  CONSTRAINT `fk_procedure_code11700` FOREIGN KEY (`treatment`) REFERENCES `procedure` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trained_in`
--

LOCK TABLES `trained_in` WRITE;
/*!40000 ALTER TABLE `trained_in` DISABLE KEYS */;
INSERT INTO `trained_in` VALUES (3,1,'2008-01-01','2008-12-31'),(3,2,'2008-01-01','2008-12-31'),(3,5,'2008-01-01','2008-12-31'),(3,6,'2008-01-01','2008-12-31'),(3,7,'2008-01-01','2008-12-31'),(6,2,'2008-01-01','2008-12-31'),(6,5,'2007-01-01','2007-12-31'),(6,6,'2008-01-01','2008-12-31'),(7,1,'2008-01-01','2008-12-31'),(7,2,'2008-01-01','2008-12-31'),(7,3,'2008-01-01','2008-12-31'),(7,4,'2008-01-01','2008-12-31'),(7,5,'2008-01-01','2008-12-31'),(7,6,'2008-01-01','2008-12-31'),(7,7,'2008-01-01','2008-12-31');
/*!40000 ALTER TABLE `trained_in` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `undergoes`
--

DROP TABLE IF EXISTS `undergoes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `undergoes` (
  `patient` int(11) NOT NULL,
  `procedure` int(11) NOT NULL,
  `stay` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `physician` int(11) NOT NULL,
  `assistingnurse` int(11) DEFAULT NULL,
  PRIMARY KEY (`patient`,`procedure`,`stay`,`date`),
  KEY `fk_nurse_employeeid11588` (`assistingnurse`),
  KEY `fk_physician_employeeid11692` (`physician`),
  KEY `fk_procedure_code11708` (`procedure`),
  KEY `fk_stay_stayid` (`stay`),
  CONSTRAINT `fk_nurse_employeeid11588` FOREIGN KEY (`assistingnurse`) REFERENCES `nurse` (`employeeid`),
  CONSTRAINT `fk_patient_ssn11636` FOREIGN KEY (`patient`) REFERENCES `patient` (`ssn`),
  CONSTRAINT `fk_physician_employeeid11692` FOREIGN KEY (`physician`) REFERENCES `physician` (`employeeid`),
  CONSTRAINT `fk_procedure_code11708` FOREIGN KEY (`procedure`) REFERENCES `procedure` (`code`),
  CONSTRAINT `fk_stay_stayid` FOREIGN KEY (`stay`) REFERENCES `stay` (`stayid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `undergoes`
--

LOCK TABLES `undergoes` WRITE;
/*!40000 ALTER TABLE `undergoes` DISABLE KEYS */;
INSERT INTO `undergoes` VALUES (100000001,2,3215,'2008-05-03 00:00:00',7,101),(100000001,6,3215,'2008-05-02 00:00:00',3,101),(100000001,7,3217,'2008-05-10 00:00:00',7,101),(100000004,1,3217,'2008-05-07 00:00:00',3,102),(100000004,4,3217,'2008-05-13 00:00:00',3,103),(100000004,5,3217,'2008-05-09 00:00:00',6,NULL);
/*!40000 ALTER TABLE `undergoes` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-06-30 18:59:26
