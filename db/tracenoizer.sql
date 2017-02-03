-- MySQL dump 10.13  Distrib 5.5.54, for debian-linux-gnu (i686)
--
-- Host: localhost    Database: tracenoizer
-- ------------------------------------------------------
-- Server version	5.5.54-0+deb7u1

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
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accounts` (
  `ac_id` int(11) NOT NULL AUTO_INCREMENT,
  `ac_name` tinytext,
  `ac_pw` tinytext,
  `ac_ftp` tinytext,
  `ac_used` int(11) DEFAULT NULL,
  `ac_http` tinytext,
  `ac_path` tinytext,
  PRIMARY KEY (`ac_id`),
  KEY `ac_id` (`ac_id`),
  KEY `ac_used` (`ac_used`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `globalurl`
--

DROP TABLE IF EXISTS `globalurl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `globalurl` (
  `g_id` int(11) NOT NULL AUTO_INCREMENT,
  `g_url_id` int(11) DEFAULT NULL,
  `g_used` int(1) DEFAULT NULL,
  `g_string` text,
  KEY `g_id` (`g_id`),
  KEY `g_url_id` (`g_url_id`),
  KEY `g_used` (`g_used`)
) ENGINE=MyISAM AUTO_INCREMENT=830248 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `image`
--

DROP TABLE IF EXISTS `image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `image` (
  `img_id` int(11) NOT NULL AUTO_INCREMENT,
  `img_url_id` int(11) DEFAULT NULL,
  `img_used` int(1) DEFAULT NULL,
  `img_link` text,
  KEY `img_id` (`img_id`),
  KEY `img_url_id` (`img_url_id`),
  KEY `img_used` (`img_used`)
) ENGINE=MyISAM AUTO_INCREMENT=61630 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `input`
--

DROP TABLE IF EXISTS `input`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `input` (
  `in_id` int(11) NOT NULL AUTO_INCREMENT,
  `in_main_id` int(11) DEFAULT NULL,
  `in_keyword` tinytext,
  KEY `in_id` (`in_id`),
  KEY `in_main_id` (`in_main_id`)
) ENGINE=MyISAM AUTO_INCREMENT=35958 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `keyword`
--

DROP TABLE IF EXISTS `keyword`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `keyword` (
  `keyword_id` int(11) NOT NULL AUTO_INCREMENT,
  `keyword_main_id` int(11) DEFAULT NULL,
  `keyword` varchar(255) DEFAULT NULL,
  `keyword_infog` float(11,9) DEFAULT NULL,
  `keyword_html` text,
  `keyword_size` int(11) DEFAULT NULL,
  KEY `keyword_id` (`keyword_id`),
  KEY `keyword_main_id` (`keyword_main_id`),
  KEY `keyword` (`keyword`),
  KEY `keyword_size` (`keyword_size`),
  KEY `keyword_main_id_2` (`keyword_main_id`,`keyword`)
) ENGINE=MyISAM AUTO_INCREMENT=8837 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mailurl`
--

DROP TABLE IF EXISTS `mailurl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mailurl` (
  `m_id` int(11) NOT NULL AUTO_INCREMENT,
  `m_url_id` int(11) DEFAULT NULL,
  `m_used` int(1) DEFAULT NULL,
  `m_string` tinytext,
  KEY `m_id` (`m_id`),
  KEY `m_url_id` (`m_url_id`),
  KEY `m_used` (`m_used`)
) ENGINE=MyISAM AUTO_INCREMENT=68044 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `main`
--

DROP TABLE IF EXISTS `main`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `main` (
  `main_id` int(11) NOT NULL AUTO_INCREMENT,
  `main_date` date DEFAULT NULL,
  `main_usr_id` int(11) DEFAULT NULL,
  `main_generation` int(11) DEFAULT NULL,
  `main_weblink` tinytext,
  `main_ac_id` int(11) DEFAULT NULL,
  `main_html` text,
  `main_st_id` int(11) DEFAULT NULL,
  KEY `main_id` (`main_id`),
  KEY `main_usr_id` (`main_usr_id`),
  KEY `main_generation` (`main_generation`),
  KEY `main_ac_id` (`main_ac_id`),
  KEY `main_st_id` (`main_st_id`)
) ENGINE=MyISAM AUTO_INCREMENT=37356 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `status`
--

DROP TABLE IF EXISTS `status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `status` (
  `st_id` int(11) DEFAULT NULL,
  `st_string` tinytext,
  KEY `st_id` (`st_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `text`
--

DROP TABLE IF EXISTS `text`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `text` (
  `tx_id` int(11) NOT NULL AUTO_INCREMENT,
  `tx_main_id` int(11) DEFAULT NULL,
  `tx_url_id` int(11) DEFAULT NULL,
  `tx_word` int(11) DEFAULT NULL,
  `tx_text` longtext,
  `tx_lang` char(2) DEFAULT NULL,
  KEY `tx_id` (`tx_id`),
  KEY `tx_main_id` (`tx_main_id`),
  KEY `tx_url_id` (`tx_url_id`),
  KEY `tx_word` (`tx_word`),
  KEY `tx_lang` (`tx_lang`)
) ENGINE=MyISAM AUTO_INCREMENT=52198 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `url`
--

DROP TABLE IF EXISTS `url`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `url` (
  `url_id` int(11) NOT NULL AUTO_INCREMENT,
  `url_main_id` int(11) DEFAULT NULL,
  `url` text,
  KEY `url_id` (`url_id`),
  KEY `url_main_id` (`url_main_id`)
) ENGINE=MyISAM AUTO_INCREMENT=52197 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `usr_id` int(11) NOT NULL AUTO_INCREMENT,
  `usr_name` varchar(30) NOT NULL DEFAULT '',
  `usr_pw` tinytext,
  `usr_mail` tinytext,
  UNIQUE KEY `usr_name` (`usr_name`),
  KEY `usr_id` (`usr_id`),
  KEY `usr_name_2` (`usr_name`)
) ENGINE=MyISAM AUTO_INCREMENT=17199 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wordcount`
--

DROP TABLE IF EXISTS `wordcount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wordcount` (
  `wordcount_id` int(11) NOT NULL AUTO_INCREMENT,
  `wordcount_tx_id` int(11) NOT NULL DEFAULT '0',
  `wordcount_keyword_id` int(11) NOT NULL DEFAULT '0',
  `wordcount_infog` float(11,9) DEFAULT NULL,
  KEY `wordcount_id` (`wordcount_id`),
  KEY `wordcount_tx_id` (`wordcount_tx_id`),
  KEY `wordcount_keyword_id` (`wordcount_keyword_id`)
) ENGINE=MyISAM AUTO_INCREMENT=65037 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-02-03  9:43:06
