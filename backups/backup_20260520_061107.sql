-- MySQL dump 10.13  Distrib 5.7.24, for Linux (x86_64)
--
-- Host: localhost    Database: gzutest
-- ------------------------------------------------------
-- Server version	5.5.5-10.4.32-MariaDB

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
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add content type',4,'add_contenttype'),(14,'Can change content type',4,'change_contenttype'),(15,'Can delete content type',4,'delete_contenttype'),(16,'Can view content type',4,'view_contenttype'),(17,'Can add session',5,'add_session'),(18,'Can change session',5,'change_session'),(19,'Can delete session',5,'delete_session'),(20,'Can view session',5,'view_session'),(21,'Can add custom user',6,'add_customuser'),(22,'Can change custom user',6,'change_customuser'),(23,'Can delete custom user',6,'delete_customuser'),(24,'Can view custom user',6,'view_customuser'),(25,'Can add department',7,'add_department'),(26,'Can change department',7,'change_department'),(27,'Can delete department',7,'delete_department'),(28,'Can view department',7,'view_department'),(29,'Can add expense category',8,'add_expensecategory'),(30,'Can change expense category',8,'change_expensecategory'),(31,'Can delete expense category',8,'delete_expensecategory'),(32,'Can view expense category',8,'view_expensecategory'),(33,'Can add expense disbursement',9,'add_expensedisbursement'),(34,'Can change expense disbursement',9,'change_expensedisbursement'),(35,'Can delete expense disbursement',9,'delete_expensedisbursement'),(36,'Can view expense disbursement',9,'view_expensedisbursement'),(37,'Can add payment method',10,'add_paymentmethod'),(38,'Can change payment method',10,'change_paymentmethod'),(39,'Can delete payment method',10,'delete_paymentmethod'),(40,'Can view payment method',10,'view_paymentmethod'),(41,'Can add recurring expense',11,'add_recurringexpense'),(42,'Can change recurring expense',11,'change_recurringexpense'),(43,'Can delete recurring expense',11,'delete_recurringexpense'),(44,'Can view recurring expense',11,'view_recurringexpense'),(45,'Can add notification',12,'add_notification'),(46,'Can change notification',12,'change_notification'),(47,'Can delete notification',12,'delete_notification'),(48,'Can view notification',12,'view_notification'),(49,'Can add expense request',13,'add_expenserequest'),(50,'Can change expense request',13,'change_expenserequest'),(51,'Can delete expense request',13,'delete_expenserequest'),(52,'Can view expense request',13,'view_expenserequest'),(53,'Can add expense report',14,'add_expensereport'),(54,'Can change expense report',14,'change_expensereport'),(55,'Can delete expense report',14,'delete_expensereport'),(56,'Can view expense report',14,'view_expensereport'),(57,'Can add expense receipt',15,'add_expensereceipt'),(58,'Can change expense receipt',15,'change_expensereceipt'),(59,'Can delete expense receipt',15,'delete_expensereceipt'),(60,'Can view expense receipt',15,'view_expensereceipt'),(61,'Can add expense item',16,'add_expenseitem'),(62,'Can change expense item',16,'change_expenseitem'),(63,'Can delete expense item',16,'delete_expenseitem'),(64,'Can view expense item',16,'view_expenseitem'),(65,'Can add department expense request history',17,'add_departmentexpenserequesthistory'),(66,'Can change department expense request history',17,'change_departmentexpenserequesthistory'),(67,'Can delete department expense request history',17,'delete_departmentexpenserequesthistory'),(68,'Can view department expense request history',17,'view_departmentexpenserequesthistory'),(69,'Can add department budget',18,'add_departmentbudget'),(70,'Can change department budget',18,'change_departmentbudget'),(71,'Can delete department budget',18,'delete_departmentbudget'),(72,'Can view department budget',18,'view_departmentbudget'),(73,'Can add audit log',19,'add_auditlog'),(74,'Can change audit log',19,'change_auditlog'),(75,'Can delete audit log',19,'delete_auditlog'),(76,'Can view audit log',19,'view_auditlog');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_expenses_customuser_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_expenses_customuser_id` FOREIGN KEY (`user_id`) REFERENCES `expenses_customuser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'contenttypes','contenttype'),(19,'expenses','auditlog'),(6,'expenses','customuser'),(7,'expenses','department'),(18,'expenses','departmentbudget'),(17,'expenses','departmentexpenserequesthistory'),(8,'expenses','expensecategory'),(9,'expenses','expensedisbursement'),(16,'expenses','expenseitem'),(15,'expenses','expensereceipt'),(14,'expenses','expensereport'),(13,'expenses','expenserequest'),(12,'expenses','notification'),(10,'expenses','paymentmethod'),(11,'expenses','recurringexpense'),(5,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2026-05-08 09:46:32.982988'),(2,'contenttypes','0002_remove_content_type_name','2026-05-08 09:46:33.147563'),(3,'auth','0001_initial','2026-05-08 09:46:33.883803'),(4,'auth','0002_alter_permission_name_max_length','2026-05-08 09:46:34.033889'),(5,'auth','0003_alter_user_email_max_length','2026-05-08 09:46:34.073854'),(6,'auth','0004_alter_user_username_opts','2026-05-08 09:46:34.126073'),(7,'auth','0005_alter_user_last_login_null','2026-05-08 09:46:34.177548'),(8,'auth','0006_require_contenttypes_0002','2026-05-08 09:46:34.188258'),(9,'auth','0007_alter_validators_add_error_messages','2026-05-08 09:46:34.249063'),(10,'auth','0008_alter_user_username_max_length','2026-05-08 09:46:34.339877'),(11,'auth','0009_alter_user_last_name_max_length','2026-05-08 09:46:34.405296'),(12,'auth','0010_alter_group_name_max_length','2026-05-08 09:46:34.485270'),(13,'auth','0011_update_proxy_permissions','2026-05-08 09:46:34.523889'),(14,'auth','0012_alter_user_first_name_max_length','2026-05-08 09:46:34.548623'),(15,'expenses','0001_initial','2026-05-08 09:46:39.195720'),(16,'admin','0001_initial','2026-05-08 09:46:39.537203'),(17,'admin','0002_logentry_remove_auto_add','2026-05-08 09:46:39.701526'),(18,'admin','0003_logentry_add_action_flag_choices','2026-05-08 09:46:39.780424'),(19,'chatbot','0001_initial','2026-05-08 09:46:41.578495'),(20,'chatbot','0002_remove_allocation_pack_id_remove_allocation_user_id_and_more','2026-05-08 09:46:50.714205'),(21,'expenses','0002_remove_expense_amount_remove_expense_date_and_more','2026-05-08 09:46:52.359929'),(22,'expenses','0003_alter_recurringexpense_expense','2026-05-08 09:46:53.106442'),(23,'expenses','0004_customuser_email','2026-05-08 09:46:53.226910'),(24,'expenses','0005_alter_customuser_email','2026-05-08 09:46:53.374189'),(25,'expenses','0006_remove_customuser_username','2026-05-08 09:46:53.517841'),(26,'expenses','0007_customuser_username','2026-05-08 09:46:53.666999'),(27,'expenses','0008_create_admin_user','2026-05-08 09:46:56.398476'),(28,'expenses','0009_delete_expense','2026-05-08 09:46:56.437643'),(29,'sessions','0001_initial','2026-05-08 09:46:56.561362');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('ly78fyne7qle2dsb04mjgwscw3a3r4xc','.eJxVjDsOwjAQBe_iGln-sjYlfc5g7dobHECOFCcV4u4QKQW0b2beSyTc1pq2zkuairgILU6_G2F-cNtBuWO7zTLPbV0mkrsiD9rlMBd-Xg_376Bir9_aGzBcDGcsYKOhoDyBZooK6MwmOIzBugwjKuutsyo7HbwGVqEg4ijeH9elN5g:1wPZdl:wcdkhtO4OceRskWGszq255m1BzR3b7kwlZ6ZG2HMuFY','2026-06-03 05:38:45.586133');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expenses_auditlog`
--

DROP TABLE IF EXISTS `expenses_auditlog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `expenses_auditlog` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `action` varchar(255) NOT NULL,
  `object_id` int(10) unsigned NOT NULL CHECK (`object_id` >= 0),
  `timestamp` datetime(6) NOT NULL,
  `details` longtext DEFAULT NULL,
  `content_type_id` int(11) NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `expenses_auditlog_content_type_id_344e6645_fk_django_co` (`content_type_id`),
  KEY `expenses_auditlog_user_id_52265dce_fk_expenses_customuser_id` (`user_id`),
  CONSTRAINT `expenses_auditlog_content_type_id_344e6645_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `expenses_auditlog_user_id_52265dce_fk_expenses_customuser_id` FOREIGN KEY (`user_id`) REFERENCES `expenses_customuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expenses_auditlog`
--

LOCK TABLES `expenses_auditlog` WRITE;
/*!40000 ALTER TABLE `expenses_auditlog` DISABLE KEYS */;
INSERT INTO `expenses_auditlog` VALUES (1,'User Saved',2,'2026-05-08 09:57:16.548681','User \'Finance Officer\' saved',6,1),(2,'User Saved',3,'2026-05-08 09:58:40.979654','User \'Auditor\' saved',6,1),(3,'User Saved',4,'2026-05-08 10:00:39.050815','User \'ICT Head\' saved',6,1),(4,'User Saved',5,'2026-05-08 10:01:46.164890','User \'Engineering Head\' saved',6,1),(5,'User Saved',6,'2026-05-08 10:02:37.711771','User \'Tatenda Zhou\' saved',6,1),(6,'User Saved',7,'2026-05-08 10:03:44.419317','User \'Linda Chari\' saved',6,1),(7,'Budget Saved',1,'2026-05-08 10:06:19.180699','Budget for \'Information Technology\' saved',18,1),(8,'Budget Edited',1,'2026-05-08 10:06:51.171278','Budget for \'Finance\' edited',18,1),(9,'Budget Saved',2,'2026-05-08 10:07:23.420115','Budget for \'Information Technology\' saved',18,1),(10,'Budget Saved',3,'2026-05-08 10:07:42.163640','Budget for \'Human Resources\' saved',18,1),(11,'Budget Saved',4,'2026-05-08 10:08:03.732416','Budget for \'Engineering\' saved',18,1),(12,'Budget Saved',5,'2026-05-08 10:08:22.034452','Budget for \'Engineering\' saved',18,1),(13,'Budget Edited',5,'2026-05-08 10:08:40.501346','Budget for \'Science\' edited',18,1),(14,'Budget Saved',6,'2026-05-08 10:09:08.447353','Budget for \'Agriculture\' saved',18,1),(15,'Expense Request Saved',1,'2026-05-08 10:16:57.924119','Expense Request \'Printer Repair\' saved',13,6),(16,'Approved Expense',1,'2026-05-08 10:17:58.900716','Expense \'Printer Repair\' approved',13,5),(17,'Expense Disbursed',1,'2026-05-08 10:23:28.994809','Expense \'ExpenseRequest object (1)\' disbursed',9,2),(18,'User Saved',8,'2026-05-10 08:55:28.466281','User \'Richard Shoko\' saved',6,1),(19,'Expense Request Saved',2,'2026-05-14 23:29:45.816315','Expense Request \'Utilities\' saved',13,6),(20,'Approved Expense',2,'2026-05-14 23:30:29.912686','Expense \'Utilities\' approved',13,5);
/*!40000 ALTER TABLE `expenses_auditlog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expenses_customuser`
--

DROP TABLE IF EXISTS `expenses_customuser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `expenses_customuser` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `fullname` varchar(50) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `role` varchar(255) NOT NULL,
  `department_id` bigint(20) DEFAULT NULL,
  `email` varchar(254) NOT NULL,
  `username` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `username` (`username`),
  KEY `expenses_customuser_department_id_151dbf16_fk_expenses_` (`department_id`),
  CONSTRAINT `expenses_customuser_department_id_151dbf16_fk_expenses_` FOREIGN KEY (`department_id`) REFERENCES `expenses_department` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expenses_customuser`
--

LOCK TABLES `expenses_customuser` WRITE;
/*!40000 ALTER TABLE `expenses_customuser` DISABLE KEYS */;
INSERT INTO `expenses_customuser` VALUES (1,'pbkdf2_sha256$600000$Upd6ubtKoOMveEBxd2OYWL$yCGYByoRBmMpzJmUv6Xtb9ZlHBtCbH1Hot3kMCr6jCc=','2026-05-20 05:38:45.568354',1,'Ruvarashe Shoko',1,1,'Admin',NULL,'admin@gmail.com','admin@gmail.com'),(2,'pbkdf2_sha256$600000$tY7ikS3azLlonxyJWxvsmJ$tTGeRj1VIhyfVs0GKUxWtkuyMnfQoCP2E0fuFljkoFU=','2026-05-08 10:22:23.509990',0,'Finance Officer',1,0,'Finance',2,'finance@gzu.ac.zw','finance@gzu.ac.zw'),(3,'pbkdf2_sha256$600000$uQHp62FilmLokTjejhTwBO$aomb9o0mhna3Y3YTZ0MQX5ccu6YXegB/6ii0zMxYNI0=',NULL,0,'Auditor',1,0,'Audit',3,'audit@gzu.ac.zw','audit@gzu.ac.zw'),(4,'pbkdf2_sha256$600000$Mae7e407q2FWbDGVSfoukT$To6gODW4Q5liG8DfHTYh58WPokB5NRyIhVcD1qAN+IQ=',NULL,0,'ICT Head',1,0,'Head',1,'headict@gzu.ac.zw','headict@gzu.ac.zw'),(5,'pbkdf2_sha256$600000$cHUQI8ix50mgpNqtPoDg9v$Bz5tLxIcaW5HRezZ29dx7XX3nMnmxh7ckwhw/TpuB1s=','2026-05-14 23:30:05.354801',0,'Engineering Head',1,0,'Head',4,'headeng@gzu.ac.zw','headeng@gzu.ac.zw'),(6,'pbkdf2_sha256$600000$81N0THtNtSIwVcs6SFwKOC$04MQWUMjUJIstyFL5MRX/zS6Nfeyy0lZf0u9GLDPn3o=','2026-05-14 23:33:29.787688',0,'Tatenda Zhou',1,0,'Staff',4,'staff1@gzu.ac.zw','staff1@gzu.ac.zw'),(7,'pbkdf2_sha256$600000$lHKPW4EQ6PYAnldNHBAgum$TP3Be3Sup2HDP5ExHP7CpDm5CNo7jZzb1Ubc8cUt+pY=',NULL,0,'Linda Chari',1,0,'Staff',1,'staff2@gzu.ac.zw','staff2@gzu.ac.zw'),(8,'pbkdf2_sha256$600000$XHXzWcWpWy3smBELvag0se$JO7xI+ABMtJ4bZle+jJ0kliwnJHD95p+eFr3kXPPwFw=',NULL,0,'Richard Shoko',1,0,'Staff',1,'staff5@gzu.ac.zw','staff5@gzu.ac.zw'),(10,'pbkdf2_sha256$600000$SI6zwZwtT3EZdYHcDhbD08$gvuJ3eAmFTr0gAaUnVluaXu9it67hmpISuK1inXa8+w=',NULL,0,'Passion Joni',1,0,'Staff',1,'staff10@gmail.com','staff10@gmail.com'),(11,'pbkdf2_sha256$600000$VVgjt6qkWPoZ7kLhdYCKqL$8fRuwdcW9pGi6o6ZtVdkQK1TVAp9NnSetmYNAzdq4N0=',NULL,0,'Grace Kuchekenya',0,0,'Staff',4,'staff11@gmail.com','staff11@gmail.com');
/*!40000 ALTER TABLE `expenses_customuser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expenses_customuser_groups`
--

DROP TABLE IF EXISTS `expenses_customuser_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `expenses_customuser_groups` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `customuser_id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `expenses_customuser_groups_customuser_id_group_id_a1c8f241_uniq` (`customuser_id`,`group_id`),
  KEY `expenses_customuser_groups_group_id_e3c46b3b_fk_auth_group_id` (`group_id`),
  CONSTRAINT `expenses_customuser__customuser_id_7f2c11b6_fk_expenses_` FOREIGN KEY (`customuser_id`) REFERENCES `expenses_customuser` (`id`),
  CONSTRAINT `expenses_customuser_groups_group_id_e3c46b3b_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expenses_customuser_groups`
--

LOCK TABLES `expenses_customuser_groups` WRITE;
/*!40000 ALTER TABLE `expenses_customuser_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `expenses_customuser_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expenses_customuser_user_permissions`
--

DROP TABLE IF EXISTS `expenses_customuser_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `expenses_customuser_user_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `customuser_id` bigint(20) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `expenses_customuser_user_customuser_id_permission_4865d7c9_uniq` (`customuser_id`,`permission_id`),
  KEY `expenses_customuser__permission_id_bd139b07_fk_auth_perm` (`permission_id`),
  CONSTRAINT `expenses_customuser__customuser_id_b80424f1_fk_expenses_` FOREIGN KEY (`customuser_id`) REFERENCES `expenses_customuser` (`id`),
  CONSTRAINT `expenses_customuser__permission_id_bd139b07_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expenses_customuser_user_permissions`
--

LOCK TABLES `expenses_customuser_user_permissions` WRITE;
/*!40000 ALTER TABLE `expenses_customuser_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `expenses_customuser_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expenses_department`
--

DROP TABLE IF EXISTS `expenses_department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `expenses_department` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` longtext DEFAULT NULL,
  `head_of_department` varchar(255) DEFAULT NULL,
  `code` varchar(10) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expenses_department`
--

LOCK TABLES `expenses_department` WRITE;
/*!40000 ALTER TABLE `expenses_department` DISABLE KEYS */;
INSERT INTO `expenses_department` VALUES (1,'Information Technology','Systems & infrastructure','Dr. Moyo','ICT'),(2,'Finance','Financial management','Mrs. Chikore','FIN'),(3,'Human Resources','Staff management','Mr. Dube','HR'),(4,'Engineering','Engineering faculty','Prof. Ncube','ENG'),(5,'Science','Science faculty','Dr. Mlambo','SCI'),(6,'Agriculture','Agriculture projects','Mr. Chari','AGR'),(7,'Faculty of CommerceFaculty of Commerce','nan','Shoko Ruvarashe','FOC'),(8,'Faculty of Arts','Faculty of Arts','Moyo Blessing','FOA');
/*!40000 ALTER TABLE `expenses_department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expenses_departmentbudget`
--

DROP TABLE IF EXISTS `expenses_departmentbudget`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `expenses_departmentbudget` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `budget_amount` decimal(10,2) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `department_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `expenses_departmentb_department_id_6f07d3d2_fk_expenses_` (`department_id`),
  CONSTRAINT `expenses_departmentb_department_id_6f07d3d2_fk_expenses_` FOREIGN KEY (`department_id`) REFERENCES `expenses_department` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expenses_departmentbudget`
--

LOCK TABLES `expenses_departmentbudget` WRITE;
/*!40000 ALTER TABLE `expenses_departmentbudget` DISABLE KEYS */;
INSERT INTO `expenses_departmentbudget` VALUES (1,30000.00,'2026-05-01','2026-05-31',2),(2,25000.00,'2026-05-01','2026-05-31',1),(3,15000.00,'2026-05-01','2026-05-31',3),(4,40000.00,'2026-05-01','2026-05-31',4),(5,35000.00,'2026-05-01','2026-05-31',5),(6,20000.00,'2026-05-01','2026-05-31',6);
/*!40000 ALTER TABLE `expenses_departmentbudget` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expenses_departmentexpenserequesthistory`
--

DROP TABLE IF EXISTS `expenses_departmentexpenserequesthistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `expenses_departmentexpenserequesthistory` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `status` varchar(10) NOT NULL,
  `action_date` datetime(6) NOT NULL,
  `action_taken_by_id` bigint(20) DEFAULT NULL,
  `department_id` bigint(20) NOT NULL,
  `expense_request_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `expenses_departmente_action_taken_by_id_fdd608a0_fk_expenses_` (`action_taken_by_id`),
  KEY `expenses_departmente_department_id_d7142298_fk_expenses_` (`department_id`),
  KEY `expenses_departmente_expense_request_id_eb0e72a4_fk_expenses_` (`expense_request_id`),
  CONSTRAINT `expenses_departmente_action_taken_by_id_fdd608a0_fk_expenses_` FOREIGN KEY (`action_taken_by_id`) REFERENCES `expenses_customuser` (`id`),
  CONSTRAINT `expenses_departmente_department_id_d7142298_fk_expenses_` FOREIGN KEY (`department_id`) REFERENCES `expenses_department` (`id`),
  CONSTRAINT `expenses_departmente_expense_request_id_eb0e72a4_fk_expenses_` FOREIGN KEY (`expense_request_id`) REFERENCES `expenses_expenserequest` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expenses_departmentexpenserequesthistory`
--

LOCK TABLES `expenses_departmentexpenserequesthistory` WRITE;
/*!40000 ALTER TABLE `expenses_departmentexpenserequesthistory` DISABLE KEYS */;
INSERT INTO `expenses_departmentexpenserequesthistory` VALUES (1,'Approved','2026-05-08 10:17:58.923841',5,4,1),(2,'Approved','2026-05-14 23:30:29.926982',5,4,2);
/*!40000 ALTER TABLE `expenses_departmentexpenserequesthistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expenses_expensecategory`
--

DROP TABLE IF EXISTS `expenses_expensecategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `expenses_expensecategory` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` longtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expenses_expensecategory`
--

LOCK TABLES `expenses_expensecategory` WRITE;
/*!40000 ALTER TABLE `expenses_expensecategory` DISABLE KEYS */;
INSERT INTO `expenses_expensecategory` VALUES (1,'Stationery','Office supplies'),(2,'Travel','Transport & accommodation'),(3,'Maintenance','Repairs'),(4,'Utilities','Water, electricity, internet'),(5,'Training','Workshops'),(6,'Software','Licenses'),(7,'Fuel','Vehicle fuel'),(8,'Research','Research work');
/*!40000 ALTER TABLE `expenses_expensecategory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expenses_expensedisbursement`
--

DROP TABLE IF EXISTS `expenses_expensedisbursement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `expenses_expensedisbursement` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `disbursed_at` datetime(6) NOT NULL,
  `payment_method` varchar(50) NOT NULL,
  `reference_number` varchar(255) DEFAULT NULL,
  `notes` longtext DEFAULT NULL,
  `disbursed_by_id` bigint(20) DEFAULT NULL,
  `expense_request_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `expense_request_id` (`expense_request_id`),
  KEY `expenses_expensedisb_disbursed_by_id_609f5376_fk_expenses_` (`disbursed_by_id`),
  CONSTRAINT `expenses_expensedisb_disbursed_by_id_609f5376_fk_expenses_` FOREIGN KEY (`disbursed_by_id`) REFERENCES `expenses_customuser` (`id`),
  CONSTRAINT `expenses_expensedisb_expense_request_id_7d276e38_fk_expenses_` FOREIGN KEY (`expense_request_id`) REFERENCES `expenses_expenserequest` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expenses_expensedisbursement`
--

LOCK TABLES `expenses_expensedisbursement` WRITE;
/*!40000 ALTER TABLE `expenses_expensedisbursement` DISABLE KEYS */;
INSERT INTO `expenses_expensedisbursement` VALUES (1,'2026-05-08 10:23:28.964987','Cash','00456','Paid by Cash',2,1);
/*!40000 ALTER TABLE `expenses_expensedisbursement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expenses_expenseitem`
--

DROP TABLE IF EXISTS `expenses_expenseitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `expenses_expenseitem` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `description` longtext NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `request_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `expenses_expenseitem_request_id_f3c33c8c_fk_expenses_` (`request_id`),
  CONSTRAINT `expenses_expenseitem_request_id_f3c33c8c_fk_expenses_` FOREIGN KEY (`request_id`) REFERENCES `expenses_expenserequest` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expenses_expenseitem`
--

LOCK TABLES `expenses_expenseitem` WRITE;
/*!40000 ALTER TABLE `expenses_expenseitem` DISABLE KEYS */;
INSERT INTO `expenses_expenseitem` VALUES (1,'Printer Repair Parts',600.00,1),(2,'Service fee',600.00,1),(3,'April Water Bill',200.00,2),(4,'April Electricity Bill',250.00,2);
/*!40000 ALTER TABLE `expenses_expenseitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expenses_expensereceipt`
--

DROP TABLE IF EXISTS `expenses_expensereceipt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `expenses_expensereceipt` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `file` varchar(100) NOT NULL,
  `uploaded_at` datetime(6) NOT NULL,
  `disbursement_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `expenses_expenserece_disbursement_id_2b9c9030_fk_expenses_` (`disbursement_id`),
  CONSTRAINT `expenses_expenserece_disbursement_id_2b9c9030_fk_expenses_` FOREIGN KEY (`disbursement_id`) REFERENCES `expenses_expensedisbursement` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expenses_expensereceipt`
--

LOCK TABLES `expenses_expensereceipt` WRITE;
/*!40000 ALTER TABLE `expenses_expensereceipt` DISABLE KEYS */;
INSERT INTO `expenses_expensereceipt` VALUES (1,'expense_receipts/IMG_20260411_201525_363_JbFFvNQ.jpg','2026-05-08 10:24:08.327771',1);
/*!40000 ALTER TABLE `expenses_expensereceipt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expenses_expensereport`
--

DROP TABLE IF EXISTS `expenses_expensereport`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `expenses_expensereport` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `total_expense` decimal(12,2) NOT NULL,
  `category_summary` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`category_summary`)),
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `expenses_expenserepo_user_id_61085961_fk_expenses_` (`user_id`),
  CONSTRAINT `expenses_expenserepo_user_id_61085961_fk_expenses_` FOREIGN KEY (`user_id`) REFERENCES `expenses_customuser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expenses_expensereport`
--

LOCK TABLES `expenses_expensereport` WRITE;
/*!40000 ALTER TABLE `expenses_expensereport` DISABLE KEYS */;
/*!40000 ALTER TABLE `expenses_expensereport` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expenses_expenserequest`
--

DROP TABLE IF EXISTS `expenses_expenserequest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `expenses_expenserequest` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `date` date NOT NULL,
  `description` longtext NOT NULL,
  `status` varchar(10) NOT NULL,
  `approved_at` datetime(6) DEFAULT NULL,
  `rejected_at` datetime(6) DEFAULT NULL,
  `approved_by_id` bigint(20) DEFAULT NULL,
  `category_id` bigint(20) DEFAULT NULL,
  `department_id` bigint(20) NOT NULL,
  `rejected_by_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `expenses_expenserequ_approved_by_id_5f7aab9c_fk_expenses_` (`approved_by_id`),
  KEY `expenses_expenserequ_category_id_7d405fc3_fk_expenses_` (`category_id`),
  KEY `expenses_expenserequ_department_id_04f1fad0_fk_expenses_` (`department_id`),
  KEY `expenses_expenserequ_rejected_by_id_7c2303d9_fk_expenses_` (`rejected_by_id`),
  KEY `expenses_expenserequ_user_id_38baacdd_fk_expenses_` (`user_id`),
  CONSTRAINT `expenses_expenserequ_approved_by_id_5f7aab9c_fk_expenses_` FOREIGN KEY (`approved_by_id`) REFERENCES `expenses_customuser` (`id`),
  CONSTRAINT `expenses_expenserequ_category_id_7d405fc3_fk_expenses_` FOREIGN KEY (`category_id`) REFERENCES `expenses_expensecategory` (`id`),
  CONSTRAINT `expenses_expenserequ_department_id_04f1fad0_fk_expenses_` FOREIGN KEY (`department_id`) REFERENCES `expenses_department` (`id`),
  CONSTRAINT `expenses_expenserequ_rejected_by_id_7c2303d9_fk_expenses_` FOREIGN KEY (`rejected_by_id`) REFERENCES `expenses_customuser` (`id`),
  CONSTRAINT `expenses_expenserequ_user_id_38baacdd_fk_expenses_` FOREIGN KEY (`user_id`) REFERENCES `expenses_customuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expenses_expenserequest`
--

LOCK TABLES `expenses_expenserequest` WRITE;
/*!40000 ALTER TABLE `expenses_expenserequest` DISABLE KEYS */;
INSERT INTO `expenses_expenserequest` VALUES (1,'Printer Repair',1200.00,'2026-05-08','Repair Printers','Disbursed','2026-05-08 10:17:58.845962',NULL,5,3,4,NULL,6),(2,'Utilities',450.00,'2026-05-15','Utilities','Approved','2026-05-14 23:30:29.860454',NULL,5,4,4,NULL,6);
/*!40000 ALTER TABLE `expenses_expenserequest` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expenses_notification`
--

DROP TABLE IF EXISTS `expenses_notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `expenses_notification` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `message` longtext NOT NULL,
  `timestamp` datetime(6) NOT NULL,
  `read` tinyint(1) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `expenses_notification_user_id_09a29418_fk_expenses_customuser_id` (`user_id`),
  CONSTRAINT `expenses_notification_user_id_09a29418_fk_expenses_customuser_id` FOREIGN KEY (`user_id`) REFERENCES `expenses_customuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expenses_notification`
--

LOCK TABLES `expenses_notification` WRITE;
/*!40000 ALTER TABLE `expenses_notification` DISABLE KEYS */;
INSERT INTO `expenses_notification` VALUES (1,'Your expense request \'Printer Repair\' has been approved.','2026-05-08 10:17:58.946061',1,6),(2,'Your expense request \'Printer Repair\' has been disbursed.','2026-05-08 10:23:29.029386',1,6),(3,'Your expense request \'Utilities\' has been approved.','2026-05-14 23:30:29.938331',0,6);
/*!40000 ALTER TABLE `expenses_notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expenses_paymentmethod`
--

DROP TABLE IF EXISTS `expenses_paymentmethod`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `expenses_paymentmethod` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` longtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expenses_paymentmethod`
--

LOCK TABLES `expenses_paymentmethod` WRITE;
/*!40000 ALTER TABLE `expenses_paymentmethod` DISABLE KEYS */;
/*!40000 ALTER TABLE `expenses_paymentmethod` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expenses_recurringexpense`
--

DROP TABLE IF EXISTS `expenses_recurringexpense`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `expenses_recurringexpense` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `recurrence_interval` varchar(100) NOT NULL,
  `next_due_date` date NOT NULL,
  `expense_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `expenses_recurringex_expense_id_61326d2c_fk_expenses_` (`expense_id`),
  CONSTRAINT `expenses_recurringex_expense_id_61326d2c_fk_expenses_` FOREIGN KEY (`expense_id`) REFERENCES `expenses_expenserequest` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expenses_recurringexpense`
--

LOCK TABLES `expenses_recurringexpense` WRITE;
/*!40000 ALTER TABLE `expenses_recurringexpense` DISABLE KEYS */;
/*!40000 ALTER TABLE `expenses_recurringexpense` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-05-20  6:11:07
