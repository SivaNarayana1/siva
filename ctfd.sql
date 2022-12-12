-- MariaDB dump 10.17  Distrib 10.4.12-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: 127.0.0.1    Database: ctfd
-- ------------------------------------------------------
-- Server version	10.4.12-MariaDB-1:10.4.12+maria~bionic

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
-- Table structure for table `alembic_version`
--

DROP TABLE IF EXISTS `alembic_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alembic_version` (
  `version_num` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`version_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alembic_version`
--

LOCK TABLES `alembic_version` WRITE;
/*!40000 ALTER TABLE `alembic_version` DISABLE KEYS */;
INSERT INTO `alembic_version` VALUES ('46a278193a94');
/*!40000 ALTER TABLE `alembic_version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `awards`
--

DROP TABLE IF EXISTS `awards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `awards` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `team_id` int(11) DEFAULT NULL,
  `name` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date` datetime(6) DEFAULT NULL,
  `value` int(11) DEFAULT NULL,
  `category` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `icon` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `requirements` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`requirements`)),
  `type` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT 'standard',
  PRIMARY KEY (`id`),
  KEY `awards_ibfk_1` (`team_id`),
  KEY `awards_ibfk_2` (`user_id`),
  CONSTRAINT `awards_ibfk_1` FOREIGN KEY (`team_id`) REFERENCES `teams` (`id`) ON DELETE CASCADE,
  CONSTRAINT `awards_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `awards`
--

LOCK TABLES `awards` WRITE;
/*!40000 ALTER TABLE `awards` DISABLE KEYS */;
/*!40000 ALTER TABLE `awards` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `challenge_topics`
--

DROP TABLE IF EXISTS `challenge_topics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `challenge_topics` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `challenge_id` int(11) DEFAULT NULL,
  `topic_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `challenge_id` (`challenge_id`),
  KEY `topic_id` (`topic_id`),
  CONSTRAINT `challenge_topics_ibfk_1` FOREIGN KEY (`challenge_id`) REFERENCES `challenges` (`id`) ON DELETE CASCADE,
  CONSTRAINT `challenge_topics_ibfk_2` FOREIGN KEY (`topic_id`) REFERENCES `topics` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `challenge_topics`
--

LOCK TABLES `challenge_topics` WRITE;
/*!40000 ALTER TABLE `challenge_topics` DISABLE KEYS */;
/*!40000 ALTER TABLE `challenge_topics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `challenges`
--

DROP TABLE IF EXISTS `challenges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `challenges` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `max_attempts` int(11) DEFAULT NULL,
  `value` int(11) DEFAULT NULL,
  `category` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `requirements` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`requirements`)),
  `connection_info` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `next_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `next_id` (`next_id`),
  CONSTRAINT `challenges_ibfk_1` FOREIGN KEY (`next_id`) REFERENCES `challenges` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `challenges`
--

LOCK TABLES `challenges` WRITE;
/*!40000 ALTER TABLE `challenges` DISABLE KEYS */;
INSERT INTO `challenges` VALUES (1,'Cross Site Scripting','This Challenge is about Cross Site Scripting',0,100,'Multiple choice','standard','visible',NULL,NULL,NULL),(2,'Buffer Overflow','This Challenge is about Cross Site Scripting',0,100,'Multiple choice','standard','visible',NULL,NULL,NULL),(3,'Incident Response','This challenge is about incident response',0,100,'Multiple Choice','standard','visible',NULL,NULL,NULL),(4,'Cryptography','This challenge is about cryptography',0,100,'Fill The answer','standard','visible',NULL,NULL,NULL),(5,'StackOverflow','This challenge is for Stack Overflow',0,100,'Multiple Choice','standard','visible',NULL,NULL,NULL),(6,'Factorial of program','This is a factorial program',0,100,'program','standard','visible',NULL,NULL,NULL),(7,'Fibanocci series','1+2=?',0,100,'Program','standard','visible',NULL,NULL,NULL),(8,'anagram program','This is anagram program',0,100,'Program','standard','visible',NULL,NULL,NULL);
/*!40000 ALTER TABLE `challenges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date` datetime(6) DEFAULT NULL,
  `author_id` int(11) DEFAULT NULL,
  `challenge_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `team_id` int(11) DEFAULT NULL,
  `page_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `author_id` (`author_id`),
  KEY `challenge_id` (`challenge_id`),
  KEY `page_id` (`page_id`),
  KEY `team_id` (`team_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`challenge_id`) REFERENCES `challenges` (`id`) ON DELETE CASCADE,
  CONSTRAINT `comments_ibfk_3` FOREIGN KEY (`page_id`) REFERENCES `pages` (`id`) ON DELETE CASCADE,
  CONSTRAINT `comments_ibfk_4` FOREIGN KEY (`team_id`) REFERENCES `teams` (`id`) ON DELETE CASCADE,
  CONSTRAINT `comments_ibfk_5` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `config`
--

DROP TABLE IF EXISTS `config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `config`
--

LOCK TABLES `config` WRITE;
/*!40000 ALTER TABLE `config` DISABLE KEYS */;
INSERT INTO `config` VALUES (1,'ctf_version','3.5.0'),(2,'ctf_theme','core'),(3,'dynamic_challenges_alembic_version','b37fb68807ea'),(4,'ctf_name','CS CTFd'),(5,'ctf_description','This CTFd is for Computer Science'),(6,'user_mode','teams'),(7,'start','1669522980'),(8,'end','1672460580'),(9,'freeze',NULL),(10,'challenge_visibility','private'),(11,'registration_visibility','public'),(12,'score_visibility','public'),(13,'account_visibility','public'),(14,'verify_emails',NULL),(15,'mail_server',NULL),(16,'mail_port',NULL),(17,'mail_tls',NULL),(18,'mail_ssl',NULL),(19,'mail_username',NULL),(20,'mail_password',NULL),(21,'mail_useauth',NULL),(22,'verification_email_subject','Confirm your account for {ctf_name}'),(23,'verification_email_body','Welcome to {ctf_name}!\n\nClick the following link to confirm and activate your account:\n{url}\n\nIf the link is not clickable, try copying and pasting it into your browser.'),(24,'successful_registration_email_subject','Successfully registered for {ctf_name}'),(25,'successful_registration_email_body','You\'ve successfully registered for {ctf_name}!'),(26,'user_creation_email_subject','Message from {ctf_name}'),(27,'user_creation_email_body','A new account has been created for you for {ctf_name} at {url}. \n\nUsername: {name}\nPassword: {password}'),(28,'password_reset_subject','Password Reset Request from {ctf_name}'),(29,'password_reset_body','Did you initiate a password reset on {ctf_name}? If you didn\'t initiate this request you can ignore this email. \n\nClick the following link to reset your password:\n{url}\n\nIf the link is not clickable, try copying and pasting it into your browser.'),(30,'password_change_alert_subject','Password Change Confirmation for {ctf_name}'),(31,'password_change_alert_body','Your password for {ctf_name} has been changed.\n\nIf you didn\'t request a password change you can reset your password here: {url}'),(32,'setup','1'),(33,'version_latest',NULL),(34,'next_update_check','1670066555');
/*!40000 ALTER TABLE `config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dynamic_challenge`
--

DROP TABLE IF EXISTS `dynamic_challenge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dynamic_challenge` (
  `id` int(11) NOT NULL,
  `initial` int(11) DEFAULT NULL,
  `minimum` int(11) DEFAULT NULL,
  `decay` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `dynamic_challenge_ibfk_1` FOREIGN KEY (`id`) REFERENCES `challenges` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dynamic_challenge`
--

LOCK TABLES `dynamic_challenge` WRITE;
/*!40000 ALTER TABLE `dynamic_challenge` DISABLE KEYS */;
/*!40000 ALTER TABLE `dynamic_challenge` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_entries`
--

DROP TABLE IF EXISTS `field_entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_entries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`value`)),
  `field_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `team_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `field_id` (`field_id`),
  KEY `team_id` (`team_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `field_entries_ibfk_1` FOREIGN KEY (`field_id`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `field_entries_ibfk_2` FOREIGN KEY (`team_id`) REFERENCES `teams` (`id`) ON DELETE CASCADE,
  CONSTRAINT `field_entries_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_entries`
--

LOCK TABLES `field_entries` WRITE;
/*!40000 ALTER TABLE `field_entries` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_entries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fields`
--

DROP TABLE IF EXISTS `fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_type` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `required` tinyint(1) DEFAULT NULL,
  `public` tinyint(1) DEFAULT NULL,
  `editable` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `CONSTRAINT_1` CHECK (`required` in (0,1)),
  CONSTRAINT `CONSTRAINT_2` CHECK (`public` in (0,1)),
  CONSTRAINT `CONSTRAINT_3` CHECK (`editable` in (0,1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fields`
--

LOCK TABLES `fields` WRITE;
/*!40000 ALTER TABLE `fields` DISABLE KEYS */;
/*!40000 ALTER TABLE `fields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `files`
--

DROP TABLE IF EXISTS `files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `files` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `location` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `challenge_id` int(11) DEFAULT NULL,
  `page_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `page_id` (`page_id`),
  KEY `files_ibfk_1` (`challenge_id`),
  CONSTRAINT `files_ibfk_1` FOREIGN KEY (`challenge_id`) REFERENCES `challenges` (`id`) ON DELETE CASCADE,
  CONSTRAINT `files_ibfk_2` FOREIGN KEY (`page_id`) REFERENCES `pages` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `files`
--

LOCK TABLES `files` WRITE;
/*!40000 ALTER TABLE `files` DISABLE KEYS */;
INSERT INTO `files` VALUES (1,'page','9f726de20a711264f12bb8d159b2a5a0/emailcode1.py',NULL,NULL),(3,'page','98b05c1dc96c0fea6a707c833c5aa3a4/sample.py',NULL,NULL);
/*!40000 ALTER TABLE `files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flags`
--

DROP TABLE IF EXISTS `flags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `challenge_id` int(11) DEFAULT NULL,
  `type` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `flags_ibfk_1` (`challenge_id`),
  CONSTRAINT `flags_ibfk_1` FOREIGN KEY (`challenge_id`) REFERENCES `challenges` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flags`
--

LOCK TABLES `flags` WRITE;
/*!40000 ALTER TABLE `flags` DISABLE KEYS */;
INSERT INTO `flags` VALUES (1,2,'static','siva2','case_insensitive'),(2,1,'static','siva1','case_insensitive'),(3,3,'static','siva3','case_insensitive'),(4,5,'static','siva5','case_insensitive'),(5,4,'static','siva4','case_insensitive'),(6,6,'static','siva6','case_insensitive'),(7,7,'static','siva7','case_insensitive'),(8,7,'static','siva8','case_insensitive'),(9,8,'static','siva9','case_insensitive');
/*!40000 ALTER TABLE `flags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hints`
--

DROP TABLE IF EXISTS `hints`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hints` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `challenge_id` int(11) DEFAULT NULL,
  `content` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cost` int(11) DEFAULT NULL,
  `requirements` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`requirements`)),
  PRIMARY KEY (`id`),
  KEY `hints_ibfk_1` (`challenge_id`),
  CONSTRAINT `hints_ibfk_1` FOREIGN KEY (`challenge_id`) REFERENCES `challenges` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hints`
--

LOCK TABLES `hints` WRITE;
/*!40000 ALTER TABLE `hints` DISABLE KEYS */;
/*!40000 ALTER TABLE `hints` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notifications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date` datetime(6) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `team_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `team_id` (`team_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`team_id`) REFERENCES `teams` (`id`),
  CONSTRAINT `notifications_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pages`
--

DROP TABLE IF EXISTS `pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `route` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `draft` tinyint(1) DEFAULT NULL,
  `hidden` tinyint(1) DEFAULT NULL,
  `auth_required` tinyint(1) DEFAULT NULL,
  `format` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `route` (`route`),
  CONSTRAINT `CONSTRAINT_1` CHECK (`draft` in (0,1)),
  CONSTRAINT `CONSTRAINT_2` CHECK (`hidden` in (0,1)),
  CONSTRAINT `CONSTRAINT_3` CHECK (`auth_required` in (0,1))
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pages`
--

LOCK TABLES `pages` WRITE;
/*!40000 ALTER TABLE `pages` DISABLE KEYS */;
INSERT INTO `pages` VALUES (1,'None','index','<div class=\"row\">\r\n    <div class=\"col-md-6 offset-md-3\">\r\n        <img class=\"w-100 mx-auto d-block\" style=\"max-width: 500px;padding: 50px;padding-top: 14vh;\" src=\"/themes/core/static/img/logo.png?d=7ce88dea\" />\r\n        <h3 class=\"text-center\">\r\n            <p>A cool CTF platform from <a href=\"https://ctfd.io\">ctfd.io</a></p>\r\n            <p>Follow us on social media:</p>\r\n            <a href=\"https://twitter.com/ctfdio\"><i class=\"fab fa-twitter fa-2x\" aria-hidden=\"true\"></i></a>&nbsp;\r\n            <a href=\"https://facebook.com/ctfdio\"><i class=\"fab fa-facebook fa-2x\" aria-hidden=\"true\"></i></a>&nbsp;\r\n            <a href=\"https://github.com/ctfd\"><i class=\"fab fa-github fa-2x\" aria-hidden=\"true\"></i></a>\r\n        </h3>\r\n        <br>\r\n        <h4 class=\"text-center\">\r\n            <a href=\"admin\">Click here</a> to login and setup your CTF\r\n        </h4>\r\n    </div>\r\n</div>',0,0,0,'markdown'),'(6,'allworkshops','workshop/joinworkshop/sampleworkshop/allworkshops','<html><head>\r\n	<title>CS CTFd</title>\r\n	<meta charset=\"utf-8\">\r\n	<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n	<link rel=\"shortcut icon\" href=\"/themes/core/static/img/favicon.ico?d=4dec80fc\" type=\"image/x-icon\">\r\n	<link rel=\"stylesheet\" href=\"/themes/core/static/css/fonts.min.css?d=4dec80fc\">\r\n	<link rel=\"stylesheet\" href=\"/themes/core/static/css/main.min.css?d=4dec80fc\">\r\n	<link rel=\"stylesheet\" href=\"/themes/core/static/css/core.min.css?d=4dec80fc\">\r\n	\r\n	<script type=\"text/javascript\">\r\n      function load() {\r\n      	var currentURL= window.location.href;\r\n        let paramString = currentURL.split(\'?\')[1];\r\n        let queryString = new URLSearchParams(paramString);      \r\n        for(let pair of queryString.entries()) {\r\n            document.getElementById(\"greeting\").innerHTML = pair[1];\r\n            console.log(\"Key is:\" + pair[0]);         \r\n            console.log(\"Value is:\" + pair[1]);  \r\n        }\r\n      };\r\n    </script>\r\n\r\n	\r\n	<script type=\"text/javascript\">\r\n		var init = {\r\n			\'urlRoot\': \"\",\r\n			\'csrfNonce\': \"22a4f6c418aca3d1627d266e2ab736d8347681e0af13d8dda1bb156299578cff\",\r\n			\'userMode\': \"teams\",\r\n			\'userId\': 1,\r\n			\'userName\': \"Admin\",\r\n			\'userEmail\': \"kota.sivanarayana6475@gmail.com\",\r\n			\'teamId\': 2, \r\n			\'teamName\': \"adminteam\",\r\n			\'start\': 1669522980,\r\n			\'end\': 1672460580,\r\n			\'theme_settings\': null\r\n		}\r\n	</script><style>undefined</style>\r\n	\r\n<link rel=\"preconnect\" href=\"https://fonts.googleapis.com\" crossorigin=\"true\"><link rel=\"preconnect\" href=\"https://fonts.gstatic.com\"><link rel=\"stylesheet\" href=\"https://fonts.googleapis.com/css2?family=Mulish:wght@200;300;400;500;600;700;800;900&amp;display=swa\"></head>\r\n<body data-new-gr-c-s-check-loaded=\"14.1087.0\" data-gr-ext-installed=\"\" onload=\"load()\">\r\n	<nav class=\"navbar navbar-expand-md navbar-dark bg-dark fixed-top\">\r\n    <div class=\"container\">\r\n        <a href=\"/\" class=\"navbar-brand\">\r\n            \r\n                CS CTFd\r\n            \r\n        </a>\r\n        <button class=\"navbar-toggler\" type=\"button\" data-toggle=\"collapse\" data-target=\"#base-navbars\" aria-controls=\"base-navbars\" aria-expanded=\"false\" aria-label=\"Toggle navigation\">\r\n            <span class=\"navbar-toggler-icon\"></span>\r\n        </button>\r\n        <div class=\"collapse navbar-collapse\" id=\"base-navbars\">\r\n            <ul class=\"navbar-nav mr-auto\">\r\n                \r\n                    <li class=\"nav-item\">\r\n                        <a class=\"nav-link\" href=\"/workshop\">workshop</a>\r\n                    </li>\r\n                \r\n\r\n                \r\n                    <li class=\"nav-item\">\r\n                        <a class=\"nav-link\" href=\"/users\">Users</a>\r\n                    </li>\r\n                    \r\n                    <li class=\"nav-item\">\r\n                        <a class=\"nav-link\" href=\"/teams\">Teams</a>\r\n                    </li>\r\n                    \r\n                \r\n\r\n                \r\n                    <li class=\"nav-item\">\r\n                        <a class=\"nav-link\" href=\"/scoreboard\">Scoreboard</a>\r\n                    </li>\r\n                \r\n\r\n                <li class=\"nav-item\">\r\n                    <a class=\"nav-link\" href=\"/challenges\">Challenges</a>\r\n                </li>\r\n            </ul>\r\n\r\n            <hr class=\"d-sm-flex d-md-flex d-lg-none\">\r\n\r\n            <ul class=\"navbar-nav ml-md-auto d-block d-sm-flex d-md-flex\">\r\n                \r\n                    \r\n                        <li class=\"nav-item\">\r\n                            <a class=\"nav-link\" href=\"/admin\">\r\n                                <span class=\"d-block\" data-toggle=\"tooltip\" data-placement=\"bottom\" title=\"\" data-original-title=\"Admin Panel\">\r\n                                    <i class=\"fas fa-wrench d-none d-md-block d-lg-none\"></i>\r\n                                </span>\r\n                                <span class=\"d-sm-block d-md-none d-lg-block\">\r\n                                    <i class=\"fas fa-wrench pr-1\"></i>Admin Panel\r\n                                </span>\r\n                            </a>\r\n                        </li>\r\n                    \r\n                    <li class=\"nav-item\">\r\n                        <a class=\"nav-link\" href=\"/notifications\">\r\n                            <span class=\"d-block\" data-toggle=\"tooltip\" data-placement=\"bottom\" title=\"\" data-original-title=\"Notifications\">\r\n                                <i class=\"fas fa-bell d-none d-md-block d-lg-none\"></i>\r\n                            </span>\r\n                            <span class=\"d-sm-block d-md-none d-lg-block\">\r\n                                <i class=\"fas fa-bell pr-1\"></i>\r\n                                <span class=\"badge badge-pill badge-danger badge-notification\"></span>\r\n                                Notifications\r\n                            </span>\r\n                        </a>\r\n                    </li>\r\n                    \r\n                    <li class=\"nav-item\">\r\n                        <a class=\"nav-link\" href=\"/team\">\r\n                            <span class=\"d-block\" data-toggle=\"tooltip\" data-placement=\"bottom\" title=\"\" data-original-title=\"Team\">\r\n                                <i class=\"fas fa-users d-none d-md-block d-lg-none\"></i>\r\n                            </span>\r\n                            <span class=\"d-sm-block d-md-none d-lg-block\">\r\n                                <i class=\"fas fa-users pr-1\"></i>Team\r\n                            </span>\r\n                        </a>\r\n                    </li>\r\n                    \r\n                    <li class=\"nav-item\">\r\n                        <a class=\"nav-link\" href=\"/user\">\r\n                            <span class=\"d-block\" data-toggle=\"tooltip\" data-placement=\"bottom\" title=\"\" data-original-title=\"Profile\">\r\n                                <i class=\"fas fa-user-circle d-none d-md-block d-lg-none\"></i>\r\n                            </span>\r\n                            <span class=\"d-sm-block d-md-none d-lg-block\">\r\n                                <i class=\"fas fa-user-circle pr-1\"></i>Profile\r\n                            </span>\r\n                        </a>\r\n                    </li>\r\n                    <li class=\"nav-item\">\r\n                        <a class=\"nav-link\" href=\"/settings\">\r\n                            <span class=\"d-block\" data-toggle=\"tooltip\" data-placement=\"bottom\" title=\"\" data-original-title=\"Settings\">\r\n                                <i class=\"fas fa-cogs d-none d-md-block d-lg-none\"></i>\r\n                            </span>\r\n                            <span class=\"d-sm-block d-md-none d-lg-block\">\r\n                                <i class=\"fas fa-cogs pr-1\"></i>Settings\r\n                            </span>\r\n                        </a>\r\n                    </li>\r\n                    <li class=\"nav-item\">\r\n                        <a class=\"nav-link\" href=\"/logout\">\r\n                            <span class=\"d-block\" data-toggle=\"tooltip\" data-placement=\"bottom\" title=\"\" data-original-title=\"Logout\">\r\n                                <i class=\"fas fa-sign-out-alt d-none d-md-block d-lg-none\"></i>\r\n                            </span>\r\n                            <span class=\"d-sm-block d-md-none d-lg-block\">\r\n                                <i class=\"fas fa-sign-out-alt pr-1\"></i><span class=\"d-lg-none\">Logout</span>\r\n                            </span>\r\n                        </a>\r\n                    </li>\r\n                \r\n            </ul>\r\n        </div>\r\n    </div>\r\n</nav>\r\n\r\n	<main role=\"main\">\r\n		\r\n	<div class=\"container\">\r\n	\r\n	<title>CS CTFd</title>\r\n	<meta charset=\"utf-8\">\r\n	<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n	<link rel=\"shortcut icon\" href=\"/themes/core/static/img/favicon.ico?d=f36ef5bd\" type=\"image/x-icon\">\r\n	<link rel=\"stylesheet\" href=\"/themes/core/static/css/fonts.min.css?d=f36ef5bd\">\r\n	<link rel=\"stylesheet\" href=\"/themes/core/static/css/main.min.css?d=f36ef5bd\">\r\n	<link rel=\"stylesheet\" href=\"/themes/core/static/css/core.min.css?d=f36ef5bd\">\r\n	\r\n\r\n\r\n	\r\n	<script type=\"text/javascript\">\r\n		var init = {\r\n			\'urlRoot\': \"\",\r\n			\'csrfNonce\': \"5a7b92361de93378f66abe458dda9941213eb98488bdd85d88f4ff768e39b1a5\",\r\n			\'userMode\': \"teams\",\r\n			\'userId\': 1,\r\n			\'userName\': \"Admin\",\r\n			\'userEmail\': \"kota.sivanarayana6475@gmail.com\",\r\n			\'teamId\': null, \r\n			\'teamName\': null,\r\n			\'start\': 1669522980,\r\n			\'end\': 1672460580,\r\n			\'theme_settings\': null\r\n		}\r\n	</script><style>undefined</style>\r\n	\r\n<link rel=\"preconnect\" href=\"https://fonts.googleapis.com\" crossorigin=\"true\"><link rel=\"preconnect\" href=\"https://fonts.gstatic.com\"><link rel=\"stylesheet\" href=\"https://fonts.googleapis.com/css2?family=Mulish:wght@200;300;400;500;600;700;800;900&amp;display=swa\">\r\n\r\n	<nav class=\"navbar navbar-expand-md navbar-dark bg-dark fixed-top\">\r\n    <div class=\"container\">\r\n        <a href=\"/\" class=\"navbar-brand\">\r\n            \r\n                CS CTFd\r\n            \r\n        </a>\r\n        <button class=\"navbar-toggler\" type=\"button\" data-toggle=\"collapse\" data-target=\"#base-navbars\" aria-controls=\"base-navbars\" aria-expanded=\"false\" aria-label=\"Toggle navigation\">\r\n            <span class=\"navbar-toggler-icon\"></span>\r\n        </button>\r\n        <div class=\"collapse navbar-collapse\" id=\"base-navbars\">\r\n            <ul class=\"navbar-nav mr-auto\">\r\n                \r\n                    <li class=\"nav-item\">\r\n                        <a class=\"nav-link\" href=\"/workshop\">workshop</a>\r\n                    </li>\r\n                \r\n\r\n                \r\n                    <li class=\"nav-item\">\r\n                        <a class=\"nav-link\" href=\"/users\">Users</a>\r\n                    </li>\r\n                    \r\n                    <li class=\"nav-item\">\r\n                        <a class=\"nav-link\" href=\"/teams\">Teams</a>\r\n                    </li>\r\n                    \r\n                \r\n\r\n                \r\n                    <li class=\"nav-item\">\r\n                        <a class=\"nav-link\" href=\"/scoreboard\">Scoreboard</a>\r\n                    </li>\r\n                \r\n\r\n                <li class=\"nav-item\">\r\n                    <a class=\"nav-link\" href=\"/challenges\">Challenges</a>\r\n                </li>\r\n            </ul>\r\n\r\n            <hr class=\"d-sm-flex d-md-flex d-lg-none\">\r\n\r\n            <ul class=\"navbar-nav ml-md-auto d-block d-sm-flex d-md-flex\">\r\n                \r\n                    \r\n                        <li class=\"nav-item\">\r\n                            <a class=\"nav-link\" href=\"/admin\">\r\n                                <span class=\"d-block\" data-toggle=\"tooltip\" data-placement=\"bottom\" title=\"\" data-original-title=\"Admin Panel\">\r\n                                    <i class=\"fas fa-wrench d-none d-md-block d-lg-none\"></i>\r\n                                </span>\r\n                                <span class=\"d-sm-block d-md-none d-lg-block\">\r\n                                    <i class=\"fas fa-wrench pr-1\"></i>Admin Panel\r\n                                </span>\r\n                            </a>\r\n                        </li>\r\n                    \r\n                    <li class=\"nav-item\">\r\n                        <a class=\"nav-link\" href=\"/notifications\">\r\n                            <span class=\"d-block\" data-toggle=\"tooltip\" data-placement=\"bottom\" title=\"\" data-original-title=\"Notifications\">\r\n                                <i class=\"fas fa-bell d-none d-md-block d-lg-none\"></i>\r\n                            </span>\r\n                            <span class=\"d-sm-block d-md-none d-lg-block\">\r\n                                <i class=\"fas fa-bell pr-1\"></i>\r\n                                <span class=\"badge badge-pill badge-danger badge-notification\"></span>\r\n                                Notifications\r\n                            </span>\r\n                        </a>\r\n                    </li>\r\n                    \r\n                    <li class=\"nav-item\">\r\n                        <a class=\"nav-link\" href=\"/team\">\r\n                            <span class=\"d-block\" data-toggle=\"tooltip\" data-placement=\"bottom\" title=\"\" data-original-title=\"Team\">\r\n                                <i class=\"fas fa-users d-none d-md-block d-lg-none\"></i>\r\n                            </span>\r\n                            <span class=\"d-sm-block d-md-none d-lg-block\">\r\n                                <i class=\"fas fa-users pr-1\"></i>Team\r\n                            </span>\r\n                        </a>\r\n                    </li>\r\n                    \r\n                    <li class=\"nav-item\">\r\n                        <a class=\"nav-link\" href=\"/user\">\r\n                            <span class=\"d-block\" data-toggle=\"tooltip\" data-placement=\"bottom\" title=\"\" data-original-title=\"Profile\">\r\n                                <i class=\"fas fa-user-circle d-none d-md-block d-lg-none\"></i>\r\n                            </span>\r\n                            <span class=\"d-sm-block d-md-none d-lg-block\">\r\n                                <i class=\"fas fa-user-circle pr-1\"></i>Profile\r\n                            </span>\r\n                        </a>\r\n                    </li>\r\n                    <li class=\"nav-item\">\r\n                        <a class=\"nav-link\" href=\"/settings\">\r\n                            <span class=\"d-block\" data-toggle=\"tooltip\" data-placement=\"bottom\" title=\"\" data-original-title=\"Settings\">\r\n                                <i class=\"fas fa-cogs d-none d-md-block d-lg-none\"></i>\r\n                            </span>\r\n                            <span class=\"d-sm-block d-md-none d-lg-block\">\r\n                                <i class=\"fas fa-cogs pr-1\"></i>Settings\r\n                            </span>\r\n                        </a>\r\n                    </li>\r\n                    <li class=\"nav-item\">\r\n                        <a class=\"nav-link\" href=\"/logout\">\r\n                            <span class=\"d-block\" data-toggle=\"tooltip\" data-placement=\"bottom\" title=\"\" data-original-title=\"Logout\">\r\n                                <i class=\"fas fa-sign-out-alt d-none d-md-block d-lg-none\"></i>\r\n                            </span>\r\n                            <span class=\"d-sm-block d-md-none d-lg-block\">\r\n                                <i class=\"fas fa-sign-out-alt pr-1\"></i><span class=\"d-lg-none\">Logout</span>\r\n                            </span>\r\n                        </a>\r\n                    </li>\r\n                \r\n            </ul>\r\n        </div>\r\n    </div>\r\n</nav>\r\n\r\n	<main role=\"main\">\r\n		\r\n	<div class=\"jumbotron\">\r\n		<div class=\"container\">\r\n			<h1>All Workshops</h1>\r\n		</div>\r\n	</div>\r\n      <h3 align=\"left\">List of Workshops</h3>\r\n      <a href=\"http://127.0.0.1:8000/workshop/joinworkshop/sampleworkshop/allworkshops><p id=\"greeting\"></p></a>\r\n      \r\n	<div class=\"container\">\r\n		<div class=\"row\">\r\n			<div class=\"col-md-6 offset-md-3\">\r\n				<div>\r\n\r\n\r\n</div>\r\n\r\n				\r\n				\r\n				\r\n		\r\n					\r\n                  	\r\n			</div>					\r\n               				\r\n             									\r\n					<input id=\"nonce\" name=\"nonce\" type=\"hidden\" value=\"5a7b92361de93378f66abe458dda9941213eb98488bdd85d88f4ff768e39b1a5\">\r\n				</form>\r\n				\r\n			</div>\r\n		</div>\r\n	</div>\r\n\r\n	</main>\r\n\r\n	\r\n\r\n	<script defer=\"\" src=\"/themes/core/static/js/vendor.bundle.min.js?d=f36ef5bd\"></script>\r\n	<script defer=\"\" src=\"/themes/core/static/js/core.min.js?d=f36ef5bd\"></script>\r\n	<script defer=\"\" src=\"/themes/core/static/js/helpers.min.js?d=f36ef5bd\"></script>\r\n\r\n	\r\n	<script defer=\"\" src=\"/themes/core/static/js/pages/main.min.js?d=f36ef5bd\"></script>\r\n	\r\n\r\n	\r\n\r\n\r\n	\r\n\r\n	\r\n\r\n<grammarly-desktop-integration data-grammarly-shadow-root=\"true\"></grammarly-desktop-integration>\r\n	</div>\r\n\r\n	</main>\r\n\r\n	\r\n\r\n	<script defer=\"\" src=\"/themes/core/static/js/vendor.bundle.min.js?d=4dec80fc\"></script>\r\n	<script defer=\"\" src=\"/themes/core/static/js/core.min.js?d=4dec80fc\"></script>\r\n	<script defer=\"\" src=\"/themes/core/static/js/helpers.min.js?d=4dec80fc\"></script>\r\n\r\n	\r\n	<script defer=\"\" src=\"/themes/core/static/js/pages/main.min.js?d=4dec80fc\"></script>\r\n	\r\n\r\n	\r\n	\r\n\r\n	\r\n\r\n	\r\n\r\n</body></html>',0,1,0,'html'),(7,'workshopscoreboard','workshop/joinworkshop/sampleworkshop/workshopscoreboard','<html><head>\r\n	<title>CS CTFd</title>\r\n	<meta charset=\"utf-8\">\r\n	<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n	<link rel=\"shortcut icon\" href=\"/themes/core/static/img/favicon.ico?d=95de3fdd\" type=\"image/x-icon\">\r\n	<link rel=\"stylesheet\" href=\"/themes/core/static/css/fonts.min.css?d=95de3fdd\">\r\n	<link rel=\"stylesheet\" href=\"/themes/core/static/css/main.min.css?d=95de3fdd\">\r\n	<link rel=\"stylesheet\" href=\"/themes/core/static/css/core.min.css?d=95de3fdd\">\r\n	\r\n	\r\n\r\n	\r\n	<script type=\"text/javascript\">\r\n		var init = {\r\n			\'urlRoot\': \"\",\r\n			\'csrfNonce\': \"eaaf8ecf246f18599526d44a54e6a1156d17283bc4570ce7b15255d1e406183a\",\r\n			\'userMode\': \"teams\",\r\n			\'userId\': 1,\r\n			\'userName\': \"Admin\",\r\n			\'userEmail\': \"kota.sivanarayana6475@gmail.com\",\r\n			\'teamId\': 2, \r\n			\'teamName\': \"adminteam\",\r\n			\'start\': 1669522980,\r\n			\'end\': 1672460580,\r\n			\'theme_settings\': null\r\n		}\r\n	</script>\r\n	\r\n<style>undefined</style><link rel=\"preconnect\" href=\"https://fonts.googleapis.com\" crossorigin=\"true\"><link rel=\"preconnect\" href=\"https://fonts.gstatic.com\"><link rel=\"stylesheet\" href=\"https://fonts.googleapis.com/css2?family=Mulish:wght@200;300;400;500;600;700;800;900&amp;display=swa\"></head>\r\n<body data-new-gr-c-s-check-loaded=\"14.1087.0\" data-gr-ext-installed=\"\">\r\n	<nav class=\"navbar navbar-expand-md navbar-dark bg-dark fixed-top\">\r\n    <div class=\"container\">\r\n        <a href=\"/\" class=\"navbar-brand\">\r\n            \r\n                CS CTFd\r\n            \r\n        </a>\r\n        <button class=\"navbar-toggler\" type=\"button\" data-toggle=\"collapse\" data-target=\"#base-navbars\" aria-controls=\"base-navbars\" aria-expanded=\"false\" aria-label=\"Toggle navigation\">\r\n            <span class=\"navbar-toggler-icon\"></span>\r\n        </button>\r\n        <div class=\"collapse navbar-collapse\" id=\"base-navbars\">\r\n            <ul class=\"navbar-nav mr-auto\">\r\n                \r\n                    <li class=\"nav-item\">\r\n                        <a class=\"nav-link\" href=\"/workshop\">workshop</a>\r\n                    </li>\r\n                \r\n\r\n                \r\n                    <li class=\"nav-item\">\r\n                        <a class=\"nav-link\" href=\"/users\">Users</a>\r\n                    </li>\r\n                    \r\n                    <li class=\"nav-item\">\r\n                        <a class=\"nav-link\" href=\"/teams\">Teams</a>\r\n                    </li>\r\n                    \r\n                \r\n\r\n                \r\n                    <li class=\"nav-item\">\r\n                        <a class=\"nav-link\" href=\"/scoreboard\">Scoreboard</a>\r\n                    </li>\r\n                \r\n\r\n                <li class=\"nav-item\">\r\n                    <a class=\"nav-link\" href=\"/challenges\">Challenges</a>\r\n                </li>\r\n            </ul>\r\n\r\n            <hr class=\"d-sm-flex d-md-flex d-lg-none\">\r\n\r\n            <ul class=\"navbar-nav ml-md-auto d-block d-sm-flex d-md-flex\">\r\n                \r\n                    \r\n                        <li class=\"nav-item\">\r\n                            <a class=\"nav-link\" href=\"/admin\">\r\n                                <span class=\"d-block\" data-toggle=\"tooltip\" data-placement=\"bottom\" title=\"\" data-original-title=\"Admin Panel\">\r\n                                    <i class=\"fas fa-wrench d-none d-md-block d-lg-none\"></i>\r\n                                </span>\r\n                                <span class=\"d-sm-block d-md-none d-lg-block\">\r\n                                    <i class=\"fas fa-wrench pr-1\"></i>Admin Panel\r\n                                </span>\r\n                            </a>\r\n                        </li>\r\n                    \r\n                    <li class=\"nav-item\">\r\n                        <a class=\"nav-link\" href=\"/notifications\">\r\n                            <span class=\"d-block\" data-toggle=\"tooltip\" data-placement=\"bottom\" title=\"\" data-original-title=\"Notifications\">\r\n                                <i class=\"fas fa-bell d-none d-md-block d-lg-none\"></i>\r\n                            </span>\r\n                            <span class=\"d-sm-block d-md-none d-lg-block\">\r\n                                <i class=\"fas fa-bell pr-1\"></i>\r\n                                <span class=\"badge badge-pill badge-danger badge-notification\"></span>\r\n                                Notifications\r\n                            </span>\r\n                        </a>\r\n                    </li>\r\n                    \r\n                    <li class=\"nav-item\">\r\n                        <a class=\"nav-link\" href=\"/team\">\r\n                            <span class=\"d-block\" data-toggle=\"tooltip\" data-placement=\"bottom\" title=\"\" data-original-title=\"Team\">\r\n                                <i class=\"fas fa-users d-none d-md-block d-lg-none\"></i>\r\n                            </span>\r\n                            <span class=\"d-sm-block d-md-none d-lg-block\">\r\n                                <i class=\"fas fa-users pr-1\"></i>Team\r\n                            </span>\r\n                        </a>\r\n                    </li>\r\n                    \r\n                    <li class=\"nav-item\">\r\n                        <a class=\"nav-link\" href=\"/user\">\r\n                            <span class=\"d-block\" data-toggle=\"tooltip\" data-placement=\"bottom\" title=\"\" data-original-title=\"Profile\">\r\n                                <i class=\"fas fa-user-circle d-none d-md-block d-lg-none\"></i>\r\n                            </span>\r\n                            <span class=\"d-sm-block d-md-none d-lg-block\">\r\n                                <i class=\"fas fa-user-circle pr-1\"></i>Profile\r\n                            </span>\r\n                        </a>\r\n                    </li>\r\n                    <li class=\"nav-item\">\r\n                        <a class=\"nav-link\" href=\"/settings\">\r\n                            <span class=\"d-block\" data-toggle=\"tooltip\" data-placement=\"bottom\" title=\"\" data-original-title=\"Settings\">\r\n                                <i class=\"fas fa-cogs d-none d-md-block d-lg-none\"></i>\r\n                            </span>\r\n                            <span class=\"d-sm-block d-md-none d-lg-block\">\r\n                                <i class=\"fas fa-cogs pr-1\"></i>Settings\r\n                            </span>\r\n                        </a>\r\n                    </li>\r\n                    <li class=\"nav-item\">\r\n                        <a class=\"nav-link\" href=\"/logout\">\r\n                            <span class=\"d-block\" data-toggle=\"tooltip\" data-placement=\"bottom\" title=\"\" data-original-title=\"Logout\">\r\n                                <i class=\"fas fa-sign-out-alt d-none d-md-block d-lg-none\"></i>\r\n                            </span>\r\n                            <span class=\"d-sm-block d-md-none d-lg-block\">\r\n                                <i class=\"fas fa-sign-out-alt pr-1\"></i><span class=\"d-lg-none\">Logout</span>\r\n                            </span>\r\n                        </a>\r\n                    </li>\r\n                \r\n            </ul>\r\n        </div>\r\n    </div>\r\n</nav>\r\n\r\n	<main role=\"main\">\r\n		\r\n<div class=\"jumbotron\">\r\n	<div class=\"container\">\r\n		<h1>Scoreboard</h1>\r\n	</div>\r\n</div>\r\n<div class=\"container\">\r\n	<div>\r\n\r\n\r\n</div>\r\n\r\n	<div id=\"score-graph\" class=\"row d-flex align-items-center\" style=\"-webkit-tap-highlight-color: transparent; user-select: none; position: relative;\" _echarts_instance_=\"ec_1669704538195\"><div style=\"position: relative; width: 1140px; height: 400px; padding: 0px; margin: 0px; border-width: 0px; cursor: default;\"><canvas data-zr-dom-id=\"zr_0\" width=\"1425\" height=\"500\" style=\"position: absolute; left: 0px; top: 0px; width: 1140px; height: 400px; user-select: none; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); padding: 0px; margin: 0px; border-width: 0px;\"></canvas></div><div style=\"position: absolute; display: none; border-style: solid; white-space: nowrap; z-index: 9999999; transition: left 0.4s cubic-bezier(0.23, 1, 0.32, 1) 0s, top 0.4s cubic-bezier(0.23, 1, 0.32, 1) 0s; background-color: rgba(50, 50, 50, 0.7); border-width: 0px; border-color: rgb(51, 51, 51); border-radius: 4px; color: rgb(255, 255, 255); font: 14px / 21px &quot;Microsoft YaHei&quot;; padding: 5px; left: 209px; top: 127px; pointer-events: none;\">01:48\r\n11-29<br><span style=\"display:inline-block;margin-right:5px;border-radius:10px;width:10px;height:10px;background-color:hsl(7, 82%, 47%);\"></span>teampraveen: 100</div></div>\r\n\r\n	\r\n	\r\n	<div id=\"scoreboard\" class=\"row\">\r\n		<div class=\"col-md-12\">\r\n			<table class=\"table table-striped\">\r\n				<thead>\r\n					<tr>\r\n						<td scope=\"col\" width=\"10px\"><b>Place</b></td>\r\n						<td scope=\"col\"><b>Team</b></td>\r\n						<td scope=\"col\"><b>Score</b></td>\r\n					</tr>\r\n				</thead>\r\n				<tbody>\r\n				\r\n					<tr>\r\n						<th scope=\"row\" class=\"text-center\">1</th>\r\n						<td>\r\n							<a href=\"/teams/1\">\r\n								teampraveen\r\n\r\n								\r\n							</a>\r\n						</td>\r\n						<td>100</td>\r\n					</tr>\r\n				\r\n				</tbody>\r\n			</table>\r\n		</div>\r\n	</div>\r\n	\r\n	\r\n</div>\r\n\r\n	</main>\r\n\r\n	\r\n\r\n	<script defer=\"\" src=\"/themes/core/static/js/vendor.bundle.min.js?d=95de3fdd\"></script>\r\n	<script defer=\"\" src=\"/themes/core/static/js/core.min.js?d=95de3fdd\"></script>\r\n	<script defer=\"\" src=\"/themes/core/static/js/helpers.min.js?d=95de3fdd\"></script>\r\n\r\n	\r\n	<script defer=\"\" src=\"/themes/core/static/js/pages/scoreboard.min.js?d=95de3fdd\"></script>\r\n\r\n\r\n	\r\n	<script defer=\"\" src=\"/themes/core/static/js/echarts.bundle.min.js?d=95de3fdd\"></script>\r\n\r\n\r\n	\r\n\r\n	\r\n\r\n</body><grammarly-desktop-integration data-grammarly-shadow-root=\"true\"></grammarly-desktop-integration></html>',0,1,0,'html'),(8,'workshopcreatesuccess','workshop/createworkshop/workshopcreatesuccess','<html>\r\n  <p>success</p>\r\n</html>',0,1,0,'html'),(10,'sample','sample','<html>\r\n  <body>\r\n    <a href=\"http://127.0.0.1:8000/workshop/joinworkshop/sampleworkshop\">Submit</a>\r\n  </body>\r\n</html>',0,1,0,'html');
/*!40000 ALTER TABLE `pages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `solves`
--

DROP TABLE IF EXISTS `solves`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `solves` (
  `id` int(11) NOT NULL,
  `challenge_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `team_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `challenge_id` (`challenge_id`,`team_id`),
  UNIQUE KEY `challenge_id_2` (`challenge_id`,`user_id`),
  KEY `team_id` (`team_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `solves_ibfk_1` FOREIGN KEY (`challenge_id`) REFERENCES `challenges` (`id`) ON DELETE CASCADE,
  CONSTRAINT `solves_ibfk_2` FOREIGN KEY (`id`) REFERENCES `submissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `solves_ibfk_3` FOREIGN KEY (`team_id`) REFERENCES `teams` (`id`) ON DELETE CASCADE,
  CONSTRAINT `solves_ibfk_4` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `solves`
--

LOCK TABLES `solves` WRITE;
/*!40000 ALTER TABLE `solves` DISABLE KEYS */;
INSERT INTO `solves` VALUES (1,1,1,2),(2,1,2,1),(3,2,1,2),(4,2,2,1);
/*!40000 ALTER TABLE `solves` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `submissions`
--

DROP TABLE IF EXISTS `submissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `submissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `challenge_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `team_id` int(11) DEFAULT NULL,
  `ip` varchar(46) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `provided` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `challenge_id` (`challenge_id`),
  KEY `team_id` (`team_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `submissions_ibfk_1` FOREIGN KEY (`challenge_id`) REFERENCES `challenges` (`id`) ON DELETE CASCADE,
  CONSTRAINT `submissions_ibfk_2` FOREIGN KEY (`team_id`) REFERENCES `teams` (`id`) ON DELETE CASCADE,
  CONSTRAINT `submissions_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `submissions`
--

LOCK TABLES `submissions` WRITE;
/*!40000 ALTER TABLE `submissions` DISABLE KEYS */;
INSERT INTO `submissions` VALUES (1,1,1,2,'172.19.0.1','siva1','correct','2022-11-29 01:48:08.176819'),(2,1,2,1,'172.19.0.1','siva1','correct','2022-11-29 06:48:29.807990'),(3,2,1,2,'172.19.0.1','siva2','correct','2022-11-29 06:50:40.472034'),(4,2,2,1,'172.19.0.1','siva2','correct','2022-11-29 06:52:26.474883');
/*!40000 ALTER TABLE `submissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `challenge_id` int(11) DEFAULT NULL,
  `value` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tags_ibfk_1` (`challenge_id`),
  CONSTRAINT `tags_ibfk_1` FOREIGN KEY (`challenge_id`) REFERENCES `challenges` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teams`
--

DROP TABLE IF EXISTS `teams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `teams` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `oauth_id` int(11) DEFAULT NULL,
  `name` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `secret` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `website` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `affiliation` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bracket` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hidden` tinyint(1) DEFAULT NULL,
  `banned` tinyint(1) DEFAULT NULL,
  `created` datetime(6) DEFAULT NULL,
  `captain_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `id` (`id`,`oauth_id`),
  UNIQUE KEY `oauth_id` (`oauth_id`),
  KEY `team_captain_id` (`captain_id`),
  CONSTRAINT `team_captain_id` FOREIGN KEY (`captain_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `CONSTRAINT_1` CHECK (`hidden` in (0,1)),
  CONSTRAINT `CONSTRAINT_2` CHECK (`banned` in (0,1))
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teams`
--

LOCK TABLES `teams` WRITE;
/*!40000 ALTER TABLE `teams` DISABLE KEYS */;
INSERT INTO `teams` VALUES (1,NULL,'teampraveen',NULL,'$bcrypt-sha256$v=2,t=2b,r=12$URzED6inFul1Y2/y0OaFX.$BLNK3Kdc0ghBzpjyqJIEvVSFwJZbgYm',NULL,NULL,NULL,NULL,NULL,0,0,'2022-11-28 07:55:42.950094',2),(2,NULL,'adminteam',NULL,'$bcrypt-sha256$v=2,t=2b,r=12$vxhcJh.f9dvQGv9ehgDHH.$LvMz8Ck.hiVP6af0TZWu87NgvHFHrF6',NULL,NULL,NULL,NULL,NULL,1,0,'2022-11-28 08:02:44.423749',1);
/*!40000 ALTER TABLE `teams` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tokens`
--

DROP TABLE IF EXISTS `tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created` datetime(6) DEFAULT NULL,
  `expiration` datetime(6) DEFAULT NULL,
  `value` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `value` (`value`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `tokens_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tokens`
--

LOCK TABLES `tokens` WRITE;
/*!40000 ALTER TABLE `tokens` DISABLE KEYS */;
INSERT INTO `tokens` VALUES (1,'user',1,'2022-12-01 01:29:37.308786','2022-12-30 00:00:00.000000','622f6363c61209f9491dd924b608bdb02b6a5178e4de9a1a972fec1dd64f2894');
/*!40000 ALTER TABLE `tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `topics`
--

DROP TABLE IF EXISTS `topics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `topics` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `value` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `value` (`value`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `topics`
--

LOCK TABLES `topics` WRITE;
/*!40000 ALTER TABLE `topics` DISABLE KEYS */;
INSERT INTO `topics` VALUES (1,'Cross ');
/*!40000 ALTER TABLE `topics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tracking`
--

DROP TABLE IF EXISTS `tracking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tracking` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ip` varchar(46) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `date` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tracking_ibfk_1` (`user_id`),
  CONSTRAINT `tracking_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tracking`
--

LOCK TABLES `tracking` WRITE;
/*!40000 ALTER TABLE `tracking` DISABLE KEYS */;
INSERT INTO `tracking` VALUES (1,NULL,'172.19.0.1',1,'2022-12-03 02:54:18.610494'),(2,NULL,'172.19.0.1',2,'2022-12-02 01:00:14.530451'),(3,NULL,'172.19.0.1',3,'2022-11-29 00:37:16.509662'),(4,NULL,'172.19.0.1',4,'2022-11-29 00:44:57.110532');
/*!40000 ALTER TABLE `tracking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unlocks`
--

DROP TABLE IF EXISTS `unlocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unlocks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `team_id` int(11) DEFAULT NULL,
  `target` int(11) DEFAULT NULL,
  `date` datetime(6) DEFAULT NULL,
  `type` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `unlocks_ibfk_1` (`team_id`),
  KEY `unlocks_ibfk_2` (`user_id`),
  CONSTRAINT `unlocks_ibfk_1` FOREIGN KEY (`team_id`) REFERENCES `teams` (`id`) ON DELETE CASCADE,
  CONSTRAINT `unlocks_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unlocks`
--

LOCK TABLES `unlocks` WRITE;
/*!40000 ALTER TABLE `unlocks` DISABLE KEYS */;
/*!40000 ALTER TABLE `unlocks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `oauth_id` int(11) DEFAULT NULL,
  `name` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `secret` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `website` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `affiliation` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bracket` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hidden` tinyint(1) DEFAULT NULL,
  `banned` tinyint(1) DEFAULT NULL,
  `verified` tinyint(1) DEFAULT NULL,
  `team_id` int(11) DEFAULT NULL,
  `created` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `id` (`id`,`oauth_id`),
  UNIQUE KEY `oauth_id` (`oauth_id`),
  KEY `team_id` (`team_id`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`team_id`) REFERENCES `teams` (`id`),
  CONSTRAINT `CONSTRAINT_1` CHECK (`hidden` in (0,1)),
  CONSTRAINT `CONSTRAINT_2` CHECK (`banned` in (0,1)),
  CONSTRAINT `CONSTRAINT_3` CHECK (`verified` in (0,1))
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,NULL,'Admin','$bcrypt-sha256$v=2,t=2b,r=12$5fDB1qkQIi5xLQoK8Zyepe$B4/HwDNZK.QX3U1J49iAGQ3U5rr0R9y','kota.sivanarayana6475@gmail.com','admin',NULL,NULL,NULL,NULL,NULL,1,0,0,2,'2022-11-27 04:23:59.736615'),(2,NULL,'praveen','$bcrypt-sha256$v=2,t=2b,r=12$dQYm.WVLmfvcc6JIhcUTG.$n3xFE0ZuQE/yDMNHsTQjDkaS075GIse','praveenkumarreddykamasani@gmail.com','user',NULL,NULL,NULL,NULL,NULL,0,0,0,1,'2022-11-27 07:03:17.178275'),(3,NULL,'siva','$bcrypt-sha256$v=2,t=2b,r=12$k3wfuIUSGtqmzQaSgagv6O$t2hz/5UwUScJyMy8TLYAtEEeod1nqhy','kota.sivanarayana8@gmail.com','user',NULL,NULL,NULL,NULL,NULL,0,0,0,NULL,'2022-11-29 00:36:39.885717'),(4,NULL,'jashwanth','$bcrypt-sha256$v=2,t=2b,r=12$ozUPIgwTOugyhmEg8Vrso.$/NXfnAXFRrZXaQds22/tn4OTMKWhLfy','jaswanthreddy14@gmail.com','user',NULL,NULL,NULL,NULL,NULL,0,0,0,NULL,'2022-11-29 00:44:57.052853');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'ctfd'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-12-03  3:32:55
