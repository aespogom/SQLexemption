DROP DATABASE IF EXISTS `assets`;
CREATE DATABASE  IF NOT EXISTS `assets` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `assets`;
-- MySQL dump 10.13  Distrib 8.0.25, for Win64 (x86_64)
--
-- Host: 217.182.172.82    Database: assets
-- ------------------------------------------------------
-- Server version	5.7.29

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
-- Table structure for table `models`
--
DROP TABLE IF EXISTS `models`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `models` (
  `id_model` varchar(32) NOT NULL,
  `name` varchar(256) DEFAULT NULL,
  `valid_date` date DEFAULT NULL,
  `creation_date` date DEFAULT NULL,
  `created_by` varchar(256) DEFAULT NULL,
  `comments` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`id_model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;



--
-- Dumping data for table `models`
--
LOCK TABLES `models` WRITE;
/*!40000 ALTER TABLE `models` DISABLE KEYS */;
INSERT INTO `models` 
  (`id_model`, `name`, `valid_date`, `creation_date`, `created_by`, `comments`) VALUES 
  ('1b8131ba1aa94f8ebc30be409968869e','Red A','2026-01-01','2021-07-01','admin', 'Modelo inicial: Málaga, Sevilla, Gijón y L1, L2, L3 y L4'),
  ('d7399d82cc8a404c81fca5b54fc395e7','Red B','2026-01-01','2021-07-02','admin', 'Nuevo parque Barcelona y L5 Barcelona Gijón'),
  ('883376684f3e4dedbe831f6e6b2a1ab8','Red C','2026-01-01','2021-07-03','admin', 'Nueva linea: L6 Barcelona Málaga');
/*!40000 ALTER TABLE `models` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Table structure for table `ac_line_sections`
--
DROP TABLE IF EXISTS `ac_line_sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ac_line_sections` (
  `id_section` varchar(32) NOT NULL,
  `id_model` varchar(32) NOT NULL,
  `action` tinyint(4) NOT NULL DEFAULT '0',
  `id_line` varchar(32) NOT NULL,
  `r0` double DEFAULT NULL,
  `x0` double DEFAULT NULL,
  `b0` double DEFAULT NULL,
  `r1` double DEFAULT NULL,
  `x1` double DEFAULT NULL,
  `b1` double DEFAULT NULL,
  `r2` double DEFAULT NULL,
  `x2` double DEFAULT NULL,
  `b2` double DEFAULT NULL,
  `length` float DEFAULT '0',
  `sequential` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`id_section`,`id_model`),
  KEY `idx_ac_line_sections_line` (`id_line`),
  -- CONSTRAINT `ac_line_sections_ibfk_1` FOREIGN KEY (`id_section`, `id_model`) REFERENCES `sections` (`id_section`, `id_model`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_ac_line_sections_section` FOREIGN KEY (`id_section`) REFERENCES `sections` (`id_section`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_ac_line_sections_line` FOREIGN KEY (`id_line`) REFERENCES `power_lines` (`id_line`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_ac_line_sections_model` FOREIGN KEY (`id_model`) REFERENCES `models` (`id_model`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Dumping data for table `ac_line_sections`
--
LOCK TABLES `ac_line_sections` WRITE;
/*!40000 ALTER TABLE `ac_line_sections` DISABLE KEYS */;
INSERT INTO  `ac_line_sections`
  (`id_section`, `id_line`, `id_model`, `action`,  `r0`, `x0`, `b0`, `r1`, `x1`, `b1`, `r2`, `x2`, `b2`, `length`, `sequential`) VALUES 
  ('da810641b046452ba23e2afe666ea555','4a8abc87c17a4ea8be9722425e19ab50','1b8131ba1aa94f8ebc30be409968869e',1,0,0,0,0.011,0.052,0,0,0,0,10,1), -- L2
  ('99314a47b6524444848a6613428fc638','2782a2789f4c4154b6460499282f0d94','1b8131ba1aa94f8ebc30be409968869e',1,0,0,0,0.003,0.040,0,0,0,0,15,1), -- L3
  ('9ff0f7d124fb400380f3a217c123f757','2782a2789f4c4154b6460499282f0d94','1b8131ba1aa94f8ebc30be409968869e',1,0,0,0,0.003,0.020,0,0,0,0,13,1), -- L4
  ('e6069ac6ad804d2eb52533eb9f0c8bdd','4c736abcfd1c4167a82ac9755b316d84','1b8131ba1aa94f8ebc30be409968869e',1,0,0,0,0.001,0.500,0,0,0,0,20,1), -- T1
  ('72e0cc5e0c164003a83dd734386dc7c6','682e29e930254b2ab70fda988972e5eb','d7399d82cc8a404c81fca5b54fc395e7',1,0,0,0,0.006,0.037,0,0,0,0,13,1), -- L5
  ('e171b791dd2e456996cf0496294ef2b0','801aa55e4a0a495aa314bd64cf145349','883376684f3e4dedbe831f6e6b2a1ab8',1,0,0,0,0.003,0.040,0,0,0,0,13,1); -- L6
/*!40000 ALTER TABLE `ac_line_sections` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Table structure for table `batteries`
--
DROP TABLE IF EXISTS `batteries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `batteries` (
  `id_generator` varchar(32) NOT NULL,
  `id_model` varchar(32) NOT NULL,
  `action` tinyint(4) NOT NULL DEFAULT '0',
  `enom` double DEFAULT NULL,
  `soc_0` double DEFAULT NULL,
  `min_soc` double DEFAULT NULL,
  `max_soc` double DEFAULT NULL,
  PRIMARY KEY (`id_generator`,`id_model`),
  -- CONSTRAINT `batteries_ibfk_1` FOREIGN KEY (`id_generator`, `id_model`) REFERENCES `generators` (`id_generator`, `id_model`) ON DELETE CASCADE ON UPDATE NO ACTION
  CONSTRAINT `fk_batteries_generator` FOREIGN KEY (`id_generator`) REFERENCES `generators` (`id_generator`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_batteries_model` FOREIGN KEY (`id_model`) REFERENCES `models` (`id_model`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Dumping data for table `batteries`
--
LOCK TABLES `batteries` WRITE;
/*!40000 ALTER TABLE `batteries` DISABLE KEYS */;
/*!40000 ALTER TABLE `batteries` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Table structure for table `bays`
--
DROP TABLE IF EXISTS `bays`;
CREATE TABLE `bays` (
   `id_bay` varchar(32) NOT NULL,
   `id_model` varchar(32) NOT NULL,
   `action` tinyint NOT NULL,
   `name` varchar(45) NOT NULL DEFAULT '""',
   `number` tinyint NOT NULL DEFAULT '0',
   `id_voltage_level` varchar(32) DEFAULT NULL,
   -- PRIMARY KEY (`id_bay`,`id_model`,`action`),
   PRIMARY KEY (`id_bay`,`id_model`),
   KEY `idx_bays_voltage_level` (`id_voltage_level`),
   -- CONSTRAINT `fk_bay_voltage_level` FOREIGN KEY (`id_voltage_level`, `id_model`) REFERENCES `voltage_levels` (`id_voltage_level`, `id_model`) ON DELETE CASCADE ON UPDATE NO ACTION,
   CONSTRAINT `fk_bays_voltage_level` FOREIGN KEY (`id_voltage_level`) REFERENCES `voltage_levels` (`id_voltage_level`) ON DELETE CASCADE ON UPDATE NO ACTION,
   CONSTRAINT `fk_bays_model` FOREIGN KEY (`id_model`) REFERENCES `models` (`id_model`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `bays`
--
LOCK TABLES `bays` WRITE;
/*!40000 ALTER TABLE `bays` DISABLE KEYS */;
/*!40000 ALTER TABLE `bays` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Table structure for table `buses`
--
DROP TABLE IF EXISTS `buses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `buses` (
  `id_bus` varchar(32) NOT NULL DEFAULT 'uuid_v4s()',
  `id_model` varchar(32) NOT NULL,
  `action` tinyint(4) NOT NULL DEFAULT '0',
  `name` varchar(256) NOT NULL DEFAULT '""',
  `x` float DEFAULT '0',
  `y` float DEFAULT '0',
  `rotation` float DEFAULT '0',
  `is_dc` tinyint(1) NOT NULL DEFAULT '0',
  `secondary_id` varchar(48) DEFAULT NULL,
  `sequential` tinyint(4) DEFAULT '0',
  `id_bdi` varchar(48) DEFAULT NULL,
  PRIMARY KEY (`id_bus`,`id_model`),
  -- KEY `id_model_buses` (`id_model`),
  CONSTRAINT `fk_buses_model` FOREIGN KEY (`id_model`) REFERENCES `models` (`id_model`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Dumping data for table `buses`
--
LOCK TABLES `buses` WRITE;
/*!40000 ALTER TABLE `buses` DISABLE KEYS */;
INSERT INTO `buses`
  (`id_bus`, `id_model`, `action`, `name`, `x`, `y`, `rotation`, `is_dc`, `secondary_id`, `sequential`, `id_bdi`) VALUES
  ('ae396164fd304c279bb5d4359e7c41f4','1b8131ba1aa94f8ebc30be409968869e',1,'b1',0,0,0,0,'b1',1,NULL),
  ('6e011d64d51a4a42a1cffb992d290cfd','1b8131ba1aa94f8ebc30be409968869e',1,'b2',0,0,0,0,'b2',1,NULL),
  ('d13a5876e22749e3acb5083b31f06dfc','1b8131ba1aa94f8ebc30be409968869e',1,'b3',0,0,0,0,'b3',1,NULL),
  ('46a53a056a3542eeb5e53591568463cf','1b8131ba1aa94f8ebc30be409968869e',1,'b4',0,0,0,0,'b4',1,NULL),
  ('50c0e3f55ce24a1180c824cc155b8ffa','1b8131ba1aa94f8ebc30be409968869e',1,'b5',0,0,0,0,'b5',1,NULL),
  ('dc5348213e904df1988cc5b7f9db8d13','1b8131ba1aa94f8ebc30be409968869e',1,'b6',0,0,0,0,'b6',1,NULL),
  ('f939e7bcbe4c4df098e897806dab4f87','1b8131ba1aa94f8ebc30be409968869e',1,'b7',0,0,0,0,'b7',1,NULL),
  ('0cd72bbb1a66449891630a0ad447b846','1b8131ba1aa94f8ebc30be409968869e',1,'b8',0,0,0,0,'b8',1,8),
  ('10e008e3326e40eba379588e50af2eea','d7399d82cc8a404c81fca5b54fc395e7',1,'b9',0,0,0,0,'b9',1,NULL),
  ('1ddcf194ac1f48999ce0e5b58ed0e2f0','d7399d82cc8a404c81fca5b54fc395e7',1,'b10',0,0,0,0,'b10',1,NULL);
/*!40000 ALTER TABLE `buses` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Table structure for table `buses_connectivity_nodes`
--
DROP TABLE IF EXISTS `buses_connectivity_nodes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `buses_connectivity_nodes` (
  `id_bus` varchar(32) NOT NULL,
  `id_connectivity_node` varchar(32) NOT NULL,
  `id_model` varchar(45) NOT NULL,
  `action` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_bus`,`id_connectivity_node`,`id_model`),
  -- TODO: Aclarar esto de las keys, ¿porque las emparejamos?
  KEY `idx_buses_connectivity_nodes_connectivity_node` (`id_connectivity_node`),
  KEY `idx_buses_connectivity_nodes_bus_model` (`id_bus`,`id_model`),
  KEY `idx_buses_connectivity_nodes_connectivity_node_model` (`id_connectivity_node`,`id_model`),
  -- CONSTRAINT `fk_buses_connectivity_nodes_1` FOREIGN KEY (`id_bus`, `id_model`) REFERENCES `buses` (`id_bus`, `id_model`) ON DELETE CASCADE ON UPDATE NO ACTION,
  -- CONSTRAINT `fk_buses_connectivity_nodes_2` FOREIGN KEY (`id_connectivity_node`, `id_model`) REFERENCES `connectivity_nodes` (`id_connectivity_node`, `id_model`) ON DELETE CASCADE ON UPDATE NO ACTION
  CONSTRAINT `fk_buses_connectivity_nodes_bus` FOREIGN KEY (`id_bus`) REFERENCES `buses` (`id_bus`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_buses_connectivity_nodes_connectivity_node` FOREIGN KEY (`id_connectivity_node`) REFERENCES `connectivity_nodes` (`id_connectivity_node`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_buses_connectivity_nodes_model` FOREIGN KEY (`id_model`) REFERENCES `models` (`id_model`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;



--
-- Dumping data for table `buses_connectivity_nodes`
--
LOCK TABLES `buses_connectivity_nodes` WRITE;
/*!40000 ALTER TABLE `buses_connectivity_nodes` DISABLE KEYS */;
INSERT INTO `buses_connectivity_nodes`
  (`id_bus`, `id_connectivity_node`, `id_model`, `action`) VALUES
  ('0cd72bbb1a66449891630a0ad447b846','88db55fbebf743e29a325c7a45d44aa6','1b8131ba1aa94f8ebc30be409968869e',1),
  ('0cd72bbb1a66449891630a0ad447b846','d9031da1d7614345bfc7cd0602c3482b','d7399d82cc8a404c81fca5b54fc395e7',1),
  ('0cd72bbb1a66449891630a0ad447b846','e9c114b526a1417795c7e4ad8ac0aae2','1b8131ba1aa94f8ebc30be409968869e',1),
  ('10e008e3326e40eba379588e50af2eea','72270e722510489297950e53229b9f18','d7399d82cc8a404c81fca5b54fc395e7',1),
  ('10e008e3326e40eba379588e50af2eea','ba9d35b4725048adb9682b9ba85ce0b4','d7399d82cc8a404c81fca5b54fc395e7',1),
  ('10e008e3326e40eba379588e50af2eea','d085c469305f4144a00e6c4af51619b6','d7399d82cc8a404c81fca5b54fc395e7',1),
  ('1ddcf194ac1f48999ce0e5b58ed0e2f0','972aac9009694a40b5369eef7afe8e45','d7399d82cc8a404c81fca5b54fc395e7',1),
  ('1ddcf194ac1f48999ce0e5b58ed0e2f0','e6c8ce9bb1bc4a758db30f4ffa2108df','883376684f3e4dedbe831f6e6b2a1ab8',1),
  ('46a53a056a3542eeb5e53591568463cf','7df9c8d5347e42f7aba4d406ba309d14','1b8131ba1aa94f8ebc30be409968869e',1),
  ('46a53a056a3542eeb5e53591568463cf','99b4a0733c2646528b5f1da6fff17f4f','1b8131ba1aa94f8ebc30be409968869e',1),
  ('46a53a056a3542eeb5e53591568463cf','cfa5e1ea17824184888514243c4391e6','1b8131ba1aa94f8ebc30be409968869e',1),
  ('50c0e3f55ce24a1180c824cc155b8ffa','247076746a914bceb27ea333ceeddddd','1b8131ba1aa94f8ebc30be409968869e',1),
  ('50c0e3f55ce24a1180c824cc155b8ffa','9d6a7f53ace847fdac6b9310888cc29a','1b8131ba1aa94f8ebc30be409968869e',1),
  ('50c0e3f55ce24a1180c824cc155b8ffa','f50b29ba5ee74e5f8b47134733a09608','1b8131ba1aa94f8ebc30be409968869e',1),
  ('6e011d64d51a4a42a1cffb992d290cfd','086533eb5c064d03956f7d148894f161','1b8131ba1aa94f8ebc30be409968869e',1),
  ('6e011d64d51a4a42a1cffb992d290cfd','24961d21824d4695ae1df573da42c3a3','1b8131ba1aa94f8ebc30be409968869e',1),
  ('ae396164fd304c279bb5d4359e7c41f4','85076048f6f846aa81a6767cb7de0808','1b8131ba1aa94f8ebc30be409968869e',1),
  ('ae396164fd304c279bb5d4359e7c41f4','8ae269f11d7046b79f7b08c65dcf110b','1b8131ba1aa94f8ebc30be409968869e',1),
  ('d13a5876e22749e3acb5083b31f06dfc','2e5f3fd3ac084934b786cd4680ff288c','883376684f3e4dedbe831f6e6b2a1ab8',1),
  ('d13a5876e22749e3acb5083b31f06dfc','4cc87ef6f3c34593aa3f2ebce84ebe08','1b8131ba1aa94f8ebc30be409968869e',1),
  ('d13a5876e22749e3acb5083b31f06dfc','aa480fce99e54f7faf13889fe4d50f80','1b8131ba1aa94f8ebc30be409968869e',1),
  ('dc5348213e904df1988cc5b7f9db8d13','47d3ad463c3548659d2fd7a2bb061344','1b8131ba1aa94f8ebc30be409968869e',1),
  ('dc5348213e904df1988cc5b7f9db8d13','ab398fe207714543a08364012e3b417b','1b8131ba1aa94f8ebc30be409968869e',1),
  ('f939e7bcbe4c4df098e897806dab4f87','4c51439a6f504c77afbd568d6379c011','1b8131ba1aa94f8ebc30be409968869e',1),
  ('f939e7bcbe4c4df098e897806dab4f87','68ba55d9a79a4326b470b452844b11a3','1b8131ba1aa94f8ebc30be409968869e',1),
  ('f939e7bcbe4c4df098e897806dab4f87','ce2272b340484c488aa17de1384414bd','1b8131ba1aa94f8ebc30be409968869e',1);
/*!40000 ALTER TABLE `buses_connectivity_nodes` ENABLE KEYS */;
UNLOCK TABLES;



--
-- Table structure for table `communities`
--
DROP TABLE IF EXISTS `communities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `communities` (
  `id_community` varchar(32) NOT NULL,
  `name` varchar(256) DEFAULT NULL,
  `id_country` varchar(32) NOT NULL,
  `id_INE` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`id_community`),
  KEY `idx_communities_country` (`id_country`),
  CONSTRAINT `fk_communities_country` FOREIGN KEY (`id_country`) REFERENCES `countries` (`id_country`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;



--
-- Dumping data for table `communities`
--
LOCK TABLES `communities` WRITE;
/*!40000 ALTER TABLE `communities` DISABLE KEYS */;
INSERT INTO `communities`
  (`id_community`,`name`,`id_country`,`id_INE`) VALUES
  ('6066234ef685409a9bb379cc94552e0e', 'Default', '9179f0d706c244eca11e0e51311f5065', NULL),
  ('02cd9b25310249069017bdb58bdedd75','Comunidad de Madrid','3a9ac31c5d4648aebaba57fbe8697c8c','13'),
  ('0aab6f3e6e474d91aade13700c3da3b2','Portugal','14815b3649a440cd81e3ebb3ab1a24fc',NULL),
  ('0c2fde5ea2f34785aa17f7d5e2e0e74d','Comunidad Foral de Navarra','3a9ac31c5d4648aebaba57fbe8697c8c','15'),
  ('0cc5314f534f4e1b83e4539c49daf5e1','Reino Unido','582c2289d58f4a65b7024e130311f1fd',NULL),
  ('15693944b49641f48459081cad82182a','Comunidad Valenciana','3a9ac31c5d4648aebaba57fbe8697c8c','10'),
  ('21b3a9a92753497c881e8dacc7e93f0a','Melilla','3a9ac31c5d4648aebaba57fbe8697c8c','19'),
  ('2275cc136d0a407f9ff75d8ecfe7ae40','Canarias','3a9ac31c5d4648aebaba57fbe8697c8c','5.'),
  ('276cb6f5a2174feea0d96b2898152f33','Principado de Asturias','3a9ac31c5d4648aebaba57fbe8697c8c','3.'),
  ('288fefb1c62544f09afe4d3f5f8b405f','Región de Murcia','3a9ac31c5d4648aebaba57fbe8697c8c','14'),
  ('2b37c36ddc334cce8d5a6121745920e3','Ceuta','3a9ac31c5d4648aebaba57fbe8697c8c','18'),
  ('4524db80880b42be96c341e28eaba2bd','Chile','061a44ae7eda4527af91b00c7d596db9',NULL),
  ('4c3a036560e540689fe2a36a8d95b9fa','Cataluña','3a9ac31c5d4648aebaba57fbe8697c8c','9.'),
  ('51608ba8c53648e1956cdc3f96495268','Andalucía','3a9ac31c5d4648aebaba57fbe8697c8c','1.'),
  ('58d31d01cf2d4da1bd14f07af354616e','Belgium','d97bdbcab6544f3f852d1fd904e11066',NULL),
  ('5b34a91d24404aed938d8d5d0a7449dd','Extremadura','3a9ac31c5d4648aebaba57fbe8697c8c','11'),
  ('5f2c2daf59584629a34ccaadbfabf5cb','Ceuta','3a9ac31c5d4648aebaba57fbe8697c8c','18'),
  ('718df78f578744aca7695f2d400b7f7c','Andorra','6be011d3e1004d11a2535a7c86dafac8',NULL),
  ('8ab6b92fad7f40c9b30c2dabb03b4c3b','Italy','ae3378b359304e489b818f0b0e629577',NULL),
  ('92959ca30ed544b18914b9319f641f1d','Perú','5d0036f9a4024a079b2efc41f85941e2',NULL),
  ('92c9d689bece4ffb9f388d1ac2577861','Melilla','3a9ac31c5d4648aebaba57fbe8697c8c','19'),
  ('946572223b1f46928b09bfd44aa5a8e0','Galicia','3a9ac31c5d4648aebaba57fbe8697c8c','12'),
  ('a349e205b93f431e9eda3547472bc4be','Cantabria','3a9ac31c5d4648aebaba57fbe8697c8c','6.'),
  ('af301af45f644d88a9e3b94e03386d52','Czech Republic','a2ff3788fc3a45a0a140d037254dc9b1',NULL),
  ('bf491c5deeeb4eabac907977f1cff84a','Germany','cc38df63d3804a899eacf41e9c5b1129',NULL),
  ('c3284555f83e4e52a96639558319eb72','Argelia','71937d206a1f4406b39654c6a6caa1be',NULL),
  ('ca85ea023b6646af977f09dc96bfd009','Aragón','3a9ac31c5d4648aebaba57fbe8697c8c','2.'),
  ('d01553b4fb24401e90d07c06b2fd8711','Marruecos','a69439d0750e479993fdf4ba8d49b491',NULL),
  ('d04831209bf247759a355d71ce3ca627','Italy North','ae3378b359304e489b818f0b0e629577',NULL),
  ('d687c1c849e7426b807384900c19c94d','País Vasco','3a9ac31c5d4648aebaba57fbe8697c8c','16'),
  ('d979c0da1a294df0a5973588265f455a','Castilla y León','3a9ac31c5d4648aebaba57fbe8697c8c','7.'),
  ('e0250518555a44199804ac3b5c142356','La Rioja','3a9ac31c5d4648aebaba57fbe8697c8c','17'),
  ('e15918454d6240dab7a5cdaa1b30bb5a','Luxembourg','35cf96c7238c4c9aaf5174a917dd2311',NULL),
  ('ea5d241640d24fe0bf4fb8ffba29e1bc','Islas Baleares','3a9ac31c5d4648aebaba57fbe8697c8c','4.'),
  ('f7367dab474f406a949a2d103af80ab4','Francia','94de7e8c3e95485587db902f484d37b8',NULL),
  ('fced908db7f64155bf73abd3693de691','Suiza','3749d67f800e437694974a963d27655b',NULL),
  ('fe41cc1f40b54e378f71f6bc87b57579','Castilla-La Mancha','3a9ac31c5d4648aebaba57fbe8697c8c','8.');
/*!40000 ALTER TABLE `communities` ENABLE KEYS */;
UNLOCK TABLES;



--
-- Table structure for table `connectivity_nodes`
--
DROP TABLE IF EXISTS `connectivity_nodes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `connectivity_nodes` (
  `id_connectivity_node` varchar(32) NOT NULL,
  `id_model` varchar(32) NOT NULL,
  `action` tinyint(4) NOT NULL DEFAULT '0',
  `name` varchar(24) DEFAULT NULL,
  `x` float DEFAULT NULL,
  `y` float DEFAULT NULL,
  PRIMARY KEY (`id_connectivity_node`,`id_model`),
  KEY `idx_connectivity_nodes_model` (`id_model`),
  CONSTRAINT `fk_connectivity_nodes_model` FOREIGN KEY (`id_model`) REFERENCES `models` (`id_model`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Dumping data for table `connectivity_nodes`
--
LOCK TABLES `connectivity_nodes` WRITE;
/*!40000 ALTER TABLE `connectivity_nodes` DISABLE KEYS */;
INSERT INTO `connectivity_nodes`
  (`id_connectivity_node`, `id_model` , `action`, `name`, `x`, `y`) VALUES
  ('ef6b962490544e6682b86e0fd83c33bf','1b8131ba1aa94f8ebc30be409968869e',1,'c1',0,0),
  ('cc89d0c029214d44b2878bc738be52c9','1b8131ba1aa94f8ebc30be409968869e',1,'c2',0,0),
  ('08b0b9b95c954724bca93fd8d009adf6','1b8131ba1aa94f8ebc30be409968869e',1,'c3',0,0),
  ('85076048f6f846aa81a6767cb7de0808','1b8131ba1aa94f8ebc30be409968869e',1,'c4',0,0),
  ('8ae269f11d7046b79f7b08c65dcf110b','1b8131ba1aa94f8ebc30be409968869e',1,'c5',0,0),
  ('e54ef70eb2dc44b1ab07147a61b33378','1b8131ba1aa94f8ebc30be409968869e',1,'c6',0,0),
  ('ff264b13b9d74c238820c42fc2452a07','1b8131ba1aa94f8ebc30be409968869e',1,'c7',0,0),
  ('086533eb5c064d03956f7d148894f161','1b8131ba1aa94f8ebc30be409968869e',1,'c8',0,0),
  ('24961d21824d4695ae1df573da42c3a3','1b8131ba1aa94f8ebc30be409968869e',1,'c9',0,0),
  ('486c227100d84124bef8c4b8ab0a2403','1b8131ba1aa94f8ebc30be409968869e',1,'c10',0,0),
  ('527e04846d5e4b38a674a28246121952','1b8131ba1aa94f8ebc30be409968869e',1,'c11',0,0),
  ('e565b74b90974dcc94c24a21fe9565b5','1b8131ba1aa94f8ebc30be409968869e',1,'c12',0,0),
  ('3af4b9d177874d3ea2ce11d875303adf','1b8131ba1aa94f8ebc30be409968869e',1,'c13',0,0),
  ('69192bc30877459082e64f8d56fee7a8','1b8131ba1aa94f8ebc30be409968869e',1,'c14',0,0),
  ('6a2d55cf3f8b4052b2b6a80b0b7669ed','1b8131ba1aa94f8ebc30be409968869e',1,'c15',0,0),
  ('aa480fce99e54f7faf13889fe4d50f80','1b8131ba1aa94f8ebc30be409968869e',1,'c16',0,0),
  ('4cc87ef6f3c34593aa3f2ebce84ebe08','1b8131ba1aa94f8ebc30be409968869e',1,'c17',0,0),
  ('87146d90fb904a1eac24a8e04c37498a','1b8131ba1aa94f8ebc30be409968869e',1,'c18',0,0),
  ('16d60e2b13e347009658bc269b379d00','1b8131ba1aa94f8ebc30be409968869e',1,'c19',0,0),
  ('7df9c8d5347e42f7aba4d406ba309d14','1b8131ba1aa94f8ebc30be409968869e',1,'c20',0,0),
  ('cfa5e1ea17824184888514243c4391e6','1b8131ba1aa94f8ebc30be409968869e',1,'c21',0,0),
  ('dedbf8b7d56347b98a449a509aedcfb4','1b8131ba1aa94f8ebc30be409968869e',1,'c22',0,0),
  ('069e806ed9874727aab592149ffb3479','1b8131ba1aa94f8ebc30be409968869e',1,'c23',0,0),
  ('33b76167770441cc94edb63881b1e550','1b8131ba1aa94f8ebc30be409968869e',1,'c24',0,0),
  ('99b4a0733c2646528b5f1da6fff17f4f','1b8131ba1aa94f8ebc30be409968869e',1,'c25',0,0),
  ('f427933e896940c2bda8a994ef72d1b1','1b8131ba1aa94f8ebc30be409968869e',1,'c26',0,0),
  ('5b51b0220030406f9b44dcc81c057ffe','1b8131ba1aa94f8ebc30be409968869e',1,'c27',0,0),
  ('4ad6290a356a41c4af39719846433a84','1b8131ba1aa94f8ebc30be409968869e',1,'c28',0,0),
  ('b605a307589648d2a1adbc869e49f292','1b8131ba1aa94f8ebc30be409968869e',1,'c29',0,0),
  ('0e95549c4a534758bd0b4eeec1b55ed0','1b8131ba1aa94f8ebc30be409968869e',1,'c30',0,0),
  ('1aac390a4e1c45d1935fb528d13904ba','1b8131ba1aa94f8ebc30be409968869e',1,'c31',0,0),
  ('f50b29ba5ee74e5f8b47134733a09608','1b8131ba1aa94f8ebc30be409968869e',1,'c32',0,0),
  ('247076746a914bceb27ea333ceeddddd','1b8131ba1aa94f8ebc30be409968869e',1,'c33',0,0),
  ('f19d257a6ae6462b94d8015370cbc4a7','1b8131ba1aa94f8ebc30be409968869e',1,'c34',0,0),
  ('a730c38cd694472c902dd8f2ea15df89','1b8131ba1aa94f8ebc30be409968869e',1,'c35',0,0),
  ('47d3ad463c3548659d2fd7a2bb061344','1b8131ba1aa94f8ebc30be409968869e',1,'c36',0,0),
  ('ab398fe207714543a08364012e3b417b','1b8131ba1aa94f8ebc30be409968869e',1,'c37',0,0),
  ('a4244c36b08c48e385a4024a820e36c6','1b8131ba1aa94f8ebc30be409968869e',1,'c38',0,0),
  ('efe89ce57b6a474c9d69e59ffbc35582','1b8131ba1aa94f8ebc30be409968869e',1,'c39',0,0),
  ('d0b0717653dd43cf9be9fdf4ee5bc22f','1b8131ba1aa94f8ebc30be409968869e',1,'c40',0,0),
  ('9d6a7f53ace847fdac6b9310888cc29a','1b8131ba1aa94f8ebc30be409968869e',1,'c41',0,0),
  ('38b887c106e745f4b4a05ec7e3c3f343','1b8131ba1aa94f8ebc30be409968869e',1,'c42',0,0),
  ('4c51439a6f504c77afbd568d6379c011','1b8131ba1aa94f8ebc30be409968869e',1,'c43',0,0),
  ('1e14ffa433384f8dbc2bc01faea02fa9','1b8131ba1aa94f8ebc30be409968869e',1,'c44',0,0),
  ('497db037b6184c85ba02b1349a4bd70b','1b8131ba1aa94f8ebc30be409968869e',1,'c45',0,0),
  ('03a0d1a6765d440f9c15f508f9ae2164','1b8131ba1aa94f8ebc30be409968869e',1,'c46',0,0),
  ('88db55fbebf743e29a325c7a45d44aa6','1b8131ba1aa94f8ebc30be409968869e',1,'c47',0,0),
  ('75ed1c5878294e9d9c18bcafec0d64b6','1b8131ba1aa94f8ebc30be409968869e',1,'c48',0,0),
  ('7658cc6cd4834da789c5acbccc4870ae','1b8131ba1aa94f8ebc30be409968869e',1,'c49',0,0),
  ('68ba55d9a79a4326b470b452844b11a3','1b8131ba1aa94f8ebc30be409968869e',1,'c50',0,0),
  ('76f8cedf733b47c6871a8f55785f810e','1b8131ba1aa94f8ebc30be409968869e',1,'c51',0,0),
  ('7268f4b1a56f4314bdf17bff655bebc1','1b8131ba1aa94f8ebc30be409968869e',1,'c52',0,0),
  ('6e9fa25fb3ba42a992989d61f9cd8c9e','1b8131ba1aa94f8ebc30be409968869e',1,'c53',0,0),
  ('e9c114b526a1417795c7e4ad8ac0aae2','1b8131ba1aa94f8ebc30be409968869e',1,'c54',0,0),
  ('ce2272b340484c488aa17de1384414bd','1b8131ba1aa94f8ebc30be409968869e',1,'c55',0,0),
  ('d6b7ac3bea3f46198625677d88555bd1','1b8131ba1aa94f8ebc30be409968869e',1,'c56',0,0),
  ('fce12f96e98b428a81fdc8091d6c49dc','1b8131ba1aa94f8ebc30be409968869e',1,'c57',0,0),
  ('13e11b1a2b014126b5754b8efc909130','d7399d82cc8a404c81fca5b54fc395e7',1,'c58',0,0),
  ('4ae1b9eb41bf4634878afac593703a6a','d7399d82cc8a404c81fca5b54fc395e7',1,'c59',0,0),
  ('b36405f8f0f140648444c1231bf73a86','d7399d82cc8a404c81fca5b54fc395e7',1,'c60',0,0),
  ('ba9d35b4725048adb9682b9ba85ce0b4','d7399d82cc8a404c81fca5b54fc395e7',1,'c61',0,0),
  ('72270e722510489297950e53229b9f18','d7399d82cc8a404c81fca5b54fc395e7',1,'c62',0,0),
  ('f74c93db485e4a0c94e1ce0ac95a7546','d7399d82cc8a404c81fca5b54fc395e7',1,'c63',0,0),
  ('575717c169ea4c4e815075200684dedf','d7399d82cc8a404c81fca5b54fc395e7',1,'c64',0,0),
  ('972aac9009694a40b5369eef7afe8e45','d7399d82cc8a404c81fca5b54fc395e7',1,'c65',0,0),
  ('d085c469305f4144a00e6c4af51619b6','d7399d82cc8a404c81fca5b54fc395e7',1,'c66',0,0),
  ('9a23e5577d304b01abf5855a0973af0e','d7399d82cc8a404c81fca5b54fc395e7',1,'c67',0,0),
  ('d9031da1d7614345bfc7cd0602c3482b','d7399d82cc8a404c81fca5b54fc395e7',1,'c68',0,0),
  ('62aecf7737ff4c769f0f0d05a2be1aad','d7399d82cc8a404c81fca5b54fc395e7',1,'c69',0,0),
  ('8a12ed8052d74d4dbdea274d3a65c97c','d7399d82cc8a404c81fca5b54fc395e7',1,'c70',0,0),
  ('60d80db791ed40b0b2590b12b1fc1132','d7399d82cc8a404c81fca5b54fc395e7',1,'c71',0,0),
  ('e6c8ce9bb1bc4a758db30f4ffa2108df','883376684f3e4dedbe831f6e6b2a1ab8',1,'c72',0,0),
  ('0f760626ba1e49019f28c6b7550ac75d','883376684f3e4dedbe831f6e6b2a1ab8',1,'c73',0,0),
  ('a77338ecb1b14ad58290f1b110edd8d4','883376684f3e4dedbe831f6e6b2a1ab8',1,'c74',0,0),
  ('9b971863578447bcbf28dcde17f37c28','883376684f3e4dedbe831f6e6b2a1ab8',1,'c75',0,0),
  ('a6299206f9104abbb7cce40f46f2ebb2','883376684f3e4dedbe831f6e6b2a1ab8',1,'c76',0,0),
  ('dbcdbb0ec9544230b55ebf772c998510','883376684f3e4dedbe831f6e6b2a1ab8',1,'c77',0,0),
  ('65302046d06441ce9c34ef2bc3d28578','883376684f3e4dedbe831f6e6b2a1ab8',1,'c78',0,0),
  ('2e5f3fd3ac084934b786cd4680ff288c','883376684f3e4dedbe831f6e6b2a1ab8',1,'c79',0,0);
/*!40000 ALTER TABLE `connectivity_nodes` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Table structure for table `connectivity_nodes_voltage_levels`
--
DROP TABLE IF EXISTS `connectivity_nodes_voltage_levels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `connectivity_nodes_voltage_levels` (
  `id_connectivity_node` varchar(32) NOT NULL,
  `id_voltage_level` varchar(32) NOT NULL,
  `id_model` varchar(32) NOT NULL,
  `action` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_connectivity_node`,`id_model`,`id_voltage_level`),
  KEY `idx_connectivity_nodes_voltage_levels_model` (`id_voltage_level`,`id_model`),
  -- CONSTRAINT `fk_connectivity_nodes_voltage_levels_1` FOREIGN KEY (`id_connectivity_node`, `id_model`) REFERENCES `connectivity_nodes` (`id_connectivity_node`, `id_model`) ON DELETE CASCADE ON UPDATE NO ACTION,
  -- CONSTRAINT `fk_connectivity_nodes_voltage_levels_2` FOREIGN KEY (`id_voltage_level`, `id_model`) REFERENCES `voltage_levels` (`id_voltage_level`, `id_model`) ON DELETE CASCADE ON UPDATE NO ACTION
  CONSTRAINT `fk_connectivity_nodes_voltage_levels_connectivity_node` FOREIGN KEY (`id_connectivity_node`) REFERENCES `connectivity_nodes` (`id_connectivity_node`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_connectivity_nodes_voltage_levels_voltage_level` FOREIGN KEY (`id_voltage_level`) REFERENCES `voltage_levels` (`id_voltage_level`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_connectivity_nodes_voltage_levels_model` FOREIGN KEY (`id_model`) REFERENCES `models` (`id_model`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Dumping data for table `connectivity_nodes_voltage_levels`
--
LOCK TABLES `connectivity_nodes_voltage_levels` WRITE;
/*!40000 ALTER TABLE `connectivity_nodes_voltage_levels` DISABLE KEYS */;
INSERT INTO `connectivity_nodes_voltage_levels`
  (`id_connectivity_node`,`id_voltage_level` ,`id_model`,`action`) VALUES
  ('03a0d1a6765d440f9c15f508f9ae2164','48ce7abce09c4568bc28d86f7b20c486','1b8131ba1aa94f8ebc30be409968869e',1),
  ('069e806ed9874727aab592149ffb3479','4c6f97d6e21a40aba03c62f8dd2d9979','1b8131ba1aa94f8ebc30be409968869e',1),
  ('086533eb5c064d03956f7d148894f161','1a87cf8e36194ab7a536d19bc56b770a','1b8131ba1aa94f8ebc30be409968869e',1),
  ('08b0b9b95c954724bca93fd8d009adf6','1a87cf8e36194ab7a536d19bc56b770a','1b8131ba1aa94f8ebc30be409968869e',1),
  ('0e95549c4a534758bd0b4eeec1b55ed0','fa633d70cf2b4c299a852a627051673c','1b8131ba1aa94f8ebc30be409968869e',1),
  ('0f760626ba1e49019f28c6b7550ac75d','271f651a18754726b5cf54b6b34a03b6','883376684f3e4dedbe831f6e6b2a1ab8',1),
  ('13e11b1a2b014126b5754b8efc909130','271f651a18754726b5cf54b6b34a03b6','d7399d82cc8a404c81fca5b54fc395e7',1),
  ('16d60e2b13e347009658bc269b379d00','4c6f97d6e21a40aba03c62f8dd2d9979','1b8131ba1aa94f8ebc30be409968869e',1),
  ('1aac390a4e1c45d1935fb528d13904ba','fa633d70cf2b4c299a852a627051673c','1b8131ba1aa94f8ebc30be409968869e',1),
  ('1e14ffa433384f8dbc2bc01faea02fa9','48ce7abce09c4568bc28d86f7b20c486','1b8131ba1aa94f8ebc30be409968869e',1),
  ('247076746a914bceb27ea333ceeddddd','fa633d70cf2b4c299a852a627051673c','1b8131ba1aa94f8ebc30be409968869e',1),
  ('24961d21824d4695ae1df573da42c3a3','1a87cf8e36194ab7a536d19bc56b770a','1b8131ba1aa94f8ebc30be409968869e',1),
  ('2e5f3fd3ac084934b786cd4680ff288c','4c6f97d6e21a40aba03c62f8dd2d9979','883376684f3e4dedbe831f6e6b2a1ab8',1),
  ('33b76167770441cc94edb63881b1e550','4c6f97d6e21a40aba03c62f8dd2d9979','1b8131ba1aa94f8ebc30be409968869e',1),
  ('38b887c106e745f4b4a05ec7e3c3f343','fa633d70cf2b4c299a852a627051673c','1b8131ba1aa94f8ebc30be409968869e',1),
  ('3af4b9d177874d3ea2ce11d875303adf','4c6f97d6e21a40aba03c62f8dd2d9979','1b8131ba1aa94f8ebc30be409968869e',1),
  ('47d3ad463c3548659d2fd7a2bb061344','fa633d70cf2b4c299a852a627051673c','1b8131ba1aa94f8ebc30be409968869e',1),
  ('486c227100d84124bef8c4b8ab0a2403','1a87cf8e36194ab7a536d19bc56b770a','1b8131ba1aa94f8ebc30be409968869e',1),
  ('497db037b6184c85ba02b1349a4bd70b','48ce7abce09c4568bc28d86f7b20c486','1b8131ba1aa94f8ebc30be409968869e',1),
  ('4ad6290a356a41c4af39719846433a84','4c6f97d6e21a40aba03c62f8dd2d9979','1b8131ba1aa94f8ebc30be409968869e',1),
  ('4ae1b9eb41bf4634878afac593703a6a','271f651a18754726b5cf54b6b34a03b6','d7399d82cc8a404c81fca5b54fc395e7',1),
  ('4c51439a6f504c77afbd568d6379c011','48ce7abce09c4568bc28d86f7b20c486','1b8131ba1aa94f8ebc30be409968869e',1),
  ('4cc87ef6f3c34593aa3f2ebce84ebe08','4c6f97d6e21a40aba03c62f8dd2d9979','1b8131ba1aa94f8ebc30be409968869e',1),
  ('527e04846d5e4b38a674a28246121952','1a87cf8e36194ab7a536d19bc56b770a','1b8131ba1aa94f8ebc30be409968869e',1),
  ('575717c169ea4c4e815075200684dedf','271f651a18754726b5cf54b6b34a03b6','d7399d82cc8a404c81fca5b54fc395e7',1),
  ('5b51b0220030406f9b44dcc81c057ffe','4c6f97d6e21a40aba03c62f8dd2d9979','1b8131ba1aa94f8ebc30be409968869e',1),
  ('60d80db791ed40b0b2590b12b1fc1132','48ce7abce09c4568bc28d86f7b20c486','d7399d82cc8a404c81fca5b54fc395e7',1),
  ('62aecf7737ff4c769f0f0d05a2be1aad','48ce7abce09c4568bc28d86f7b20c486','d7399d82cc8a404c81fca5b54fc395e7',1),
  ('65302046d06441ce9c34ef2bc3d28578','4c6f97d6e21a40aba03c62f8dd2d9979','883376684f3e4dedbe831f6e6b2a1ab8',1),
  ('68ba55d9a79a4326b470b452844b11a3','48ce7abce09c4568bc28d86f7b20c486','1b8131ba1aa94f8ebc30be409968869e',1),
  ('69192bc30877459082e64f8d56fee7a8','4c6f97d6e21a40aba03c62f8dd2d9979','1b8131ba1aa94f8ebc30be409968869e',1),
  ('6a2d55cf3f8b4052b2b6a80b0b7669ed','4c6f97d6e21a40aba03c62f8dd2d9979','1b8131ba1aa94f8ebc30be409968869e',1),
  ('6e9fa25fb3ba42a992989d61f9cd8c9e','48ce7abce09c4568bc28d86f7b20c486','1b8131ba1aa94f8ebc30be409968869e',1),
  ('72270e722510489297950e53229b9f18','271f651a18754726b5cf54b6b34a03b6','d7399d82cc8a404c81fca5b54fc395e7',1),
  ('7268f4b1a56f4314bdf17bff655bebc1','48ce7abce09c4568bc28d86f7b20c486','1b8131ba1aa94f8ebc30be409968869e',1),
  ('75ed1c5878294e9d9c18bcafec0d64b6','48ce7abce09c4568bc28d86f7b20c486','1b8131ba1aa94f8ebc30be409968869e',1),
  ('7658cc6cd4834da789c5acbccc4870ae','48ce7abce09c4568bc28d86f7b20c486','1b8131ba1aa94f8ebc30be409968869e',1),
  ('76f8cedf733b47c6871a8f55785f810e','48ce7abce09c4568bc28d86f7b20c486','1b8131ba1aa94f8ebc30be409968869e',1),
  ('7df9c8d5347e42f7aba4d406ba309d14','4c6f97d6e21a40aba03c62f8dd2d9979','1b8131ba1aa94f8ebc30be409968869e',1),
  ('85076048f6f846aa81a6767cb7de0808','1a87cf8e36194ab7a536d19bc56b770a','1b8131ba1aa94f8ebc30be409968869e',1),
  ('87146d90fb904a1eac24a8e04c37498a','4c6f97d6e21a40aba03c62f8dd2d9979','1b8131ba1aa94f8ebc30be409968869e',1),
  ('88db55fbebf743e29a325c7a45d44aa6','48ce7abce09c4568bc28d86f7b20c486','1b8131ba1aa94f8ebc30be409968869e',1),
  ('8a12ed8052d74d4dbdea274d3a65c97c','48ce7abce09c4568bc28d86f7b20c486','d7399d82cc8a404c81fca5b54fc395e7',1),
  ('8ae269f11d7046b79f7b08c65dcf110b','1a87cf8e36194ab7a536d19bc56b770a','1b8131ba1aa94f8ebc30be409968869e',1),
  ('972aac9009694a40b5369eef7afe8e45','271f651a18754726b5cf54b6b34a03b6','d7399d82cc8a404c81fca5b54fc395e7',1),
  ('99b4a0733c2646528b5f1da6fff17f4f','4c6f97d6e21a40aba03c62f8dd2d9979','1b8131ba1aa94f8ebc30be409968869e',1),
  ('9a23e5577d304b01abf5855a0973af0e','271f651a18754726b5cf54b6b34a03b6','d7399d82cc8a404c81fca5b54fc395e7',1),
  ('9b971863578447bcbf28dcde17f37c28','271f651a18754726b5cf54b6b34a03b6','883376684f3e4dedbe831f6e6b2a1ab8',1),
  ('9d6a7f53ace847fdac6b9310888cc29a','fa633d70cf2b4c299a852a627051673c','1b8131ba1aa94f8ebc30be409968869e',1),
  ('a4244c36b08c48e385a4024a820e36c6','fa633d70cf2b4c299a852a627051673c','1b8131ba1aa94f8ebc30be409968869e',1),
  ('a6299206f9104abbb7cce40f46f2ebb2','4c6f97d6e21a40aba03c62f8dd2d9979','883376684f3e4dedbe831f6e6b2a1ab8',1),
  ('a730c38cd694472c902dd8f2ea15df89','fa633d70cf2b4c299a852a627051673c','1b8131ba1aa94f8ebc30be409968869e',1),
  ('a77338ecb1b14ad58290f1b110edd8d4','271f651a18754726b5cf54b6b34a03b6','883376684f3e4dedbe831f6e6b2a1ab8',1),
  ('aa480fce99e54f7faf13889fe4d50f80','4c6f97d6e21a40aba03c62f8dd2d9979','1b8131ba1aa94f8ebc30be409968869e',1),
  ('ab398fe207714543a08364012e3b417b','fa633d70cf2b4c299a852a627051673c','1b8131ba1aa94f8ebc30be409968869e',1),
  ('b36405f8f0f140648444c1231bf73a86','271f651a18754726b5cf54b6b34a03b6','d7399d82cc8a404c81fca5b54fc395e7',1),
  ('b605a307589648d2a1adbc869e49f292','fa633d70cf2b4c299a852a627051673c','1b8131ba1aa94f8ebc30be409968869e',1),
  ('ba9d35b4725048adb9682b9ba85ce0b4','271f651a18754726b5cf54b6b34a03b6','d7399d82cc8a404c81fca5b54fc395e7',1),
  ('cc89d0c029214d44b2878bc738be52c9','1a87cf8e36194ab7a536d19bc56b770a','1b8131ba1aa94f8ebc30be409968869e',1),
  ('ce2272b340484c488aa17de1384414bd','48ce7abce09c4568bc28d86f7b20c486','1b8131ba1aa94f8ebc30be409968869e',1),
  ('cfa5e1ea17824184888514243c4391e6','4c6f97d6e21a40aba03c62f8dd2d9979','1b8131ba1aa94f8ebc30be409968869e',1),
  ('d085c469305f4144a00e6c4af51619b6','271f651a18754726b5cf54b6b34a03b6','d7399d82cc8a404c81fca5b54fc395e7',1),
  ('d0b0717653dd43cf9be9fdf4ee5bc22f','fa633d70cf2b4c299a852a627051673c','1b8131ba1aa94f8ebc30be409968869e',1),
  ('d6b7ac3bea3f46198625677d88555bd1','48ce7abce09c4568bc28d86f7b20c486','1b8131ba1aa94f8ebc30be409968869e',1),
  ('d9031da1d7614345bfc7cd0602c3482b','48ce7abce09c4568bc28d86f7b20c486','d7399d82cc8a404c81fca5b54fc395e7',1),
  ('dbcdbb0ec9544230b55ebf772c998510','4c6f97d6e21a40aba03c62f8dd2d9979','883376684f3e4dedbe831f6e6b2a1ab8',1),
  ('dedbf8b7d56347b98a449a509aedcfb4','4c6f97d6e21a40aba03c62f8dd2d9979','1b8131ba1aa94f8ebc30be409968869e',1),
  ('e54ef70eb2dc44b1ab07147a61b33378','1a87cf8e36194ab7a536d19bc56b770a','1b8131ba1aa94f8ebc30be409968869e',1),
  ('e565b74b90974dcc94c24a21fe9565b5','1a87cf8e36194ab7a536d19bc56b770a','1b8131ba1aa94f8ebc30be409968869e',1),
  ('e6c8ce9bb1bc4a758db30f4ffa2108df','271f651a18754726b5cf54b6b34a03b6','883376684f3e4dedbe831f6e6b2a1ab8',1),
  ('e9c114b526a1417795c7e4ad8ac0aae2','48ce7abce09c4568bc28d86f7b20c486','1b8131ba1aa94f8ebc30be409968869e',1),
  ('ef6b962490544e6682b86e0fd83c33bf','1a87cf8e36194ab7a536d19bc56b770a','1b8131ba1aa94f8ebc30be409968869e',1),
  ('efe89ce57b6a474c9d69e59ffbc35582','fa633d70cf2b4c299a852a627051673c','1b8131ba1aa94f8ebc30be409968869e',1),
  ('f19d257a6ae6462b94d8015370cbc4a7','fa633d70cf2b4c299a852a627051673c','1b8131ba1aa94f8ebc30be409968869e',1),
  ('f427933e896940c2bda8a994ef72d1b1','4c6f97d6e21a40aba03c62f8dd2d9979','1b8131ba1aa94f8ebc30be409968869e',1),
  ('f50b29ba5ee74e5f8b47134733a09608','fa633d70cf2b4c299a852a627051673c','1b8131ba1aa94f8ebc30be409968869e',1),
  ('f74c93db485e4a0c94e1ce0ac95a7546','271f651a18754726b5cf54b6b34a03b6','d7399d82cc8a404c81fca5b54fc395e7',1),
  ('ff264b13b9d74c238820c42fc2452a07','1a87cf8e36194ab7a536d19bc56b770a','1b8131ba1aa94f8ebc30be409968869e',1);
/*!40000 ALTER TABLE `connectivity_nodes_voltage_levels` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Table structure for table `contingencies`
--
DROP TABLE IF EXISTS `contingencies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contingencies` (
  `id_contingency` varchar(32) NOT NULL,
  `id_model` varchar(32) NOT NULL,
  `action` tinyint(4) NOT NULL DEFAULT '0',
  `name` varchar(45) NOT NULL DEFAULT '',
  PRIMARY KEY (`id_contingency`,`id_model`),
  KEY `idx_contingencies_model` (`id_model`),
  CONSTRAINT `fk_contingencies_model` FOREIGN KEY (`id_model`) REFERENCES `models` (`id_model`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;



--
-- Dumping data for table `contingencies`
--
LOCK TABLES `contingencies` WRITE;
/*!40000 ALTER TABLE `contingencies` DISABLE KEYS */;
INSERT INTO `contingencies`
  (`id_contingency` , `id_model` , `action`, `name`) VALUES
  ('9c0396b486f645379049ae8efe5c3f53','1b8131ba1aa94f8ebc30be409968869e',1,'Contingencia 1');
/*!40000 ALTER TABLE `contingencies` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Table structure for table `contingencies_generators`
--
DROP TABLE IF EXISTS `contingencies_generators`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contingencies_generators` (
  `id_contingency` varchar(32) NOT NULL,
  `id_generator` varchar(32) NOT NULL,
  `id_model` varchar(32) NOT NULL,
  `action` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_contingency`,`id_model`,`id_generator`),
  KEY `idx_contingencies_generators_generator` (`id_generator`,`id_model`),
  -- CONSTRAINT `fk_contingency_generator_generator` FOREIGN KEY (`id_generator`, `id_model`) REFERENCES `generators` (`id_generator`, `id_model`) ON DELETE CASCADE ON UPDATE NO ACTION,
  -- CONSTRAINT `fk_contingency_generators_contingency` FOREIGN KEY (`id_contingency`, `id_model`) REFERENCES `contingencies` (`id_contingency`, `id_model`) ON DELETE CASCADE ON UPDATE NO ACTION
  CONSTRAINT `fk_contingencies_generators_generator` FOREIGN KEY (`id_generator`) REFERENCES `generators` (`id_generator`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_contingencies_generators_contingency` FOREIGN KEY (`id_contingency`) REFERENCES `contingencies` (`id_contingency`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_contingencies_generators_model` FOREIGN KEY (`id_model`) REFERENCES `models` (`id_model`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contingencies_generators`
--
LOCK TABLES `contingencies_generators` WRITE;
/*!40000 ALTER TABLE `contingencies_generators` DISABLE KEYS */;
INSERT INTO `contingencies_generators`
  (`id_contingency`,`id_generator`,`id_model`) VALUES
  ('9c0396b486f645379049ae8efe5c3f53','87021b2b9b5246c68eb8b850313b84e2','1b8131ba1aa94f8ebc30be409968869e');
/*!40000 ALTER TABLE `contingencies_generators` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contingencies_sections`
--
DROP TABLE IF EXISTS `contingencies_sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contingencies_sections` (
  `id_contingency` varchar(32) NOT NULL,
  `id_section` varchar(32) NOT NULL,
  `id_model` varchar(32) NOT NULL,
  `action` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_contingency`,`id_section`,`id_model`),
  KEY `idx_contingency_sections_sections` (`id_section`),
  KEY `idx_contingencies_sections_contingency_model` (`id_contingency`,`id_model`),
  KEY `idx_contingencies_sections_section_model` (`id_section`,`id_model`),
  -- CONSTRAINT `fk_contingencies_sections_1` FOREIGN KEY (`id_contingency`, `id_model`) REFERENCES `contingencies` (`id_contingency`, `id_model`) ON DELETE CASCADE ON UPDATE NO ACTION,
  -- CONSTRAINT `fk_contingencies_sections_2` FOREIGN KEY (`id_section`, `id_model`) REFERENCES `sections` (`id_section`, `id_model`) ON DELETE CASCADE ON UPDATE NO ACTION
  CONSTRAINT `fk_contingencies_sections_contingency` FOREIGN KEY (`id_contingency`) REFERENCES `contingencies` (`id_contingency`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_contingencies_sections_section` FOREIGN KEY (`id_section`) REFERENCES `sections` (`id_section`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_contingencies_sections_model` FOREIGN KEY (`id_model`) REFERENCES `models` (`id_model`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;



--
-- Dumping data for table `contingencies_sections`
--
LOCK TABLES `contingencies_sections` WRITE;
/*!40000 ALTER TABLE `contingencies_sections` DISABLE KEYS */;
INSERT INTO `contingencies_sections`
  (`id_contingency`,`id_section`,`id_model`) VALUES
  ('9c0396b486f645379049ae8efe5c3f53','9ff0f7d124fb400380f3a217c123f757','1b8131ba1aa94f8ebc30be409968869e'),
  ('9c0396b486f645379049ae8efe5c3f53','da810641b046452ba23e2afe666ea555','1b8131ba1aa94f8ebc30be409968869e');
/*!40000 ALTER TABLE `contingencies_sections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `countries`
--
DROP TABLE IF EXISTS `countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `countries` (
  `id_country` varchar(32) NOT NULL,
  `ISO3` varchar(3) DEFAULT NULL,
  `name` varchar(256) DEFAULT NULL,
  `ISO2` varchar(4) DEFAULT NULL,
  PRIMARY KEY (`id_country`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;



--
-- Dumping data for table `countries`
--
LOCK TABLES `countries` WRITE;
/*!40000 ALTER TABLE `countries` DISABLE KEYS */;
INSERT INTO `countries`
  (`id_country`,`ISO3`,`name`,`ISO2`) VALUES
  ('9179f0d706c244eca11e0e51311f5065','DEF','Default', 'DF'),
  ('6be011d3e1004d11a2535a7c86dafac8','AND','Andorra','AN'),
  ('d97bdbcab6544f3f852d1fd904e11066','BEL','Bélgica','BE'),
  ('3749d67f800e437694974a963d27655b','CHE','Suiza','CH'),
  ('061a44ae7eda4527af91b00c7d596db9','CHL','Chile','CL'),
  ('a2ff3788fc3a45a0a140d037254dc9b1','CZE','República Checa','CH'),
  ('cc38df63d3804a899eacf41e9c5b1129','DEU','Alemania','DE'),
  ('71937d206a1f4406b39654c6a6caa1be','DZA','Argelia','DZ'),
  ('3a9ac31c5d4648aebaba57fbe8697c8c','ESP','España','ES'),
  ('94de7e8c3e95485587db902f484d37b8','FRA','Francia','FR'),
  ('582c2289d58f4a65b7024e130311f1fd','GBR','Reino Unido','GB'),
  ('ae3378b359304e489b818f0b0e629577','ITA','Italia','IT'),
  ('35cf96c7238c4c9aaf5174a917dd2311','LUX','Luxemburgo','LU'),
  ('a69439d0750e479993fdf4ba8d49b491','MAR','Marruecos','MA'),
  ('5d0036f9a4024a079b2efc41f85941e2','PER','Perú','PE'),
  ('14815b3649a440cd81e3ebb3ab1a24fc','PRT','Portugal','PT');
/*!40000 ALTER TABLE `countries` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Table structure for table `dc_line_sections`
--
DROP TABLE IF EXISTS `dc_line_sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dc_line_sections` (
  `id_section` varchar(32) NOT NULL,
  `id_model` varchar(32) NOT NULL,
  `action` tinyint(4) NOT NULL DEFAULT '0',
  `id_line` varchar(32) NOT NULL,
  `r0` float DEFAULT NULL,
  `r1` float DEFAULT NULL,
  `length` float DEFAULT NULL,
  `sequential` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`id_section`,`id_model`),
  KEY `idx_dc_line_sections_powerline` (`id_line`),
  CONSTRAINT `fk_dc_line_sections_powerline` FOREIGN KEY (`id_line`) REFERENCES `power_lines` (`id_line`) ON DELETE CASCADE ON UPDATE NO ACTION,
  -- CONSTRAINT `fk_dc_line_section_sections` FOREIGN KEY (`id_section`, `id_model`) REFERENCES `sections` (`id_section`, `id_model`) ON DELETE CASCADE ON UPDATE NO ACTION
  CONSTRAINT `fk_dc_line_sections_section` FOREIGN KEY (`id_section`) REFERENCES `sections` (`id_section`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_dc_line_sections_model` FOREIGN KEY (`id_model`) REFERENCES `models` (`id_model`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Dumping data for table `dc_line_sections`
--
LOCK TABLES `dc_line_sections` WRITE;
/*!40000 ALTER TABLE `dc_line_sections` DISABLE KEYS */;
/*!40000 ALTER TABLE `dc_line_sections` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Table structure for table `dynamic_line_rating_devices`
--
DROP TABLE IF EXISTS `dynamic_line_rating_devices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dynamic_line_rating_devices` (
  `id_dlr` varchar(32) NOT NULL,
  `id_section` varchar(32) NOT NULL,
  `id_model` varchar(32) NOT NULL,
  `action` tinyint(4) NOT NULL DEFAULT '0',
  `name` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id_dlr`,`id_model`),
  KEY `idx_dlr_sections` (`id_section`,`id_model`),
  -- CONSTRAINT `fk_dlr_sections` FOREIGN KEY (`id_section`, `id_model`) REFERENCES `sections` (`id_section`, `id_model`) ON DELETE CASCADE ON UPDATE NO ACTION
  CONSTRAINT `fk_dlr_section` FOREIGN KEY (`id_section`) REFERENCES `sections` (`id_section`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_dlr_model` FOREIGN KEY (`id_model`) REFERENCES `models` (`id_model`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Dynamic Line Rating devices';
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Dumping data for table `dynamic_line_rating_devices`
--
LOCK TABLES `dynamic_line_rating_devices` WRITE;
/*!40000 ALTER TABLE `dynamic_line_rating_devices` DISABLE KEYS */;
/*!40000 ALTER TABLE `dynamic_line_rating_devices` ENABLE KEYS */;
UNLOCK TABLES;



--
-- Table structure for table `emissions`
--
DROP TABLE IF EXISTS `emissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `emissions` (
  `id_emissions` varchar(32) NOT NULL,
  `name` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`id_emissions`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Dumping data for table `emissions`
--
LOCK TABLES `emissions` WRITE;
/*!40000 ALTER TABLE `emissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `emissions` ENABLE KEYS */;
UNLOCK TABLES;



--
-- Table structure for table `fixed_shunts`
--
DROP TABLE IF EXISTS `fixed_shunts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fixed_shunts` (
  `id_shunt` varchar(32) NOT NULL,
  `id_model` varchar(32) NOT NULL,
  `action` tinyint(4) NOT NULL DEFAULT '0',
  `id_connectivity_node` varchar(32) NOT NULL,
  `name` varchar(256) DEFAULT NULL,
  `secondary_id` varchar(48) DEFAULT NULL,
  `active` tinyint(4) DEFAULT '1',
  `g` float DEFAULT '0',
  `b` float DEFAULT '0',
  `g1` float DEFAULT '0',
  `b1` float DEFAULT '0',
  `rating` float DEFAULT '0',
  `sequential` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`id_shunt`,`id_model`),
  KEY `idx_fixed_shunts_model` (`id_model`),
  KEY `idx_fixed_shunts_cn_model` (`id_connectivity_node`,`id_model`),
  -- CONSTRAINT `fk_fixed_shunts_cn` FOREIGN KEY (`id_connectivity_node`, `id_model`) REFERENCES `connectivity_nodes` (`id_connectivity_node`, `id_model`) ON DELETE CASCADE ON UPDATE NO ACTION,
  -- CONSTRAINT `fk_fixed_shunts_model` FOREIGN KEY (`id_model`) REFERENCES `models` (`id_model`) ON DELETE CASCADE ON UPDATE NO ACTION
  CONSTRAINT `fk_fixed_shunts_connectivity_node` FOREIGN KEY (`id_connectivity_node`) REFERENCES `connectivity_nodes` (`id_connectivity_node`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_fixed_shunts_model` FOREIGN KEY (`id_model`) REFERENCES `models` (`id_model`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Dumping data for table `fixed_shunts`
--
LOCK TABLES `fixed_shunts` WRITE;
/*!40000 ALTER TABLE `fixed_shunts` DISABLE KEYS */;
/*!40000 ALTER TABLE `fixed_shunts` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Table structure for table `fuels`
--
DROP TABLE IF EXISTS `fuels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fuels` (
  `id_fuel` varchar(32) NOT NULL,
  `name` varchar(256) DEFAULT NULL,
  `id_icon` VARCHAR(32) DEFAULT '553e1c7f2d294852af9c37d1a5c86931', -- default barrel icon
  `id_model` VARCHAR(32) NOT NULL,
  `action` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_fuel`, `id_model`),
  CONSTRAINT `fk_icons_fuels` FOREIGN KEY (`id_icon`) REFERENCES `icons` (`id_icon`),
  CONSTRAINT `fk_model_fuels` FOREIGN KEY (`id_model`) REFERENCES `models` (`id_model`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Dumping data for table `fuels`
--
LOCK TABLES `fuels` WRITE;
/*!40000 ALTER TABLE `fuels` DISABLE KEYS */;
/*!40000 ALTER TABLE `fuels` ENABLE KEYS */;
UNLOCK TABLES;



--
-- Table structure for table `generation_technologies`
--
DROP TABLE IF EXISTS `generation_technologies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `generation_technologies` (
  `id_technology` varchar(32) NOT NULL,
  `name` varchar(256) DEFAULT NULL,
  `id_icon` VARCHAR(32) DEFAULT 'b121365191924e9382c8fdb4f3984444', -- default thunder icon
  `id_model` VARCHAR(32) NOT NULL,
  `action` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_technology`, `id_model`),
  CONSTRAINT `fk_icons_generation_technologies` FOREIGN KEY (`id_icon`) REFERENCES `icons` (`id_icon`),
  CONSTRAINT `fk_model_generation_technologies` FOREIGN KEY (`id_model`) REFERENCES `models` (`id_model`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Dumping data for table `generation_technologies`
--
LOCK TABLES `generation_technologies` WRITE;
/*!40000 ALTER TABLE `generation_technologies` DISABLE KEYS */;
INSERT INTO `generation_technologies` 
  (`id_technology`, `name`, `id_icon`, `id_model`, `action`) VALUES
  ('03ef5f3e2b3b435baf3d1740c59eea13', 'Others renewable', 'c7c9660a04e04b4fa08ccfd07a959b55', '1b8131ba1aa94f8ebc30be409968869e', 1),
  ('0e2011c71524489b8dddde64a2d537a2', 'Swell RoR and Daily Storage (turbine)', 'e9f574334c3449849ba9400b6242ce96', '1b8131ba1aa94f8ebc30be409968869e', 1),
  ('102c142d4b0e4b3c871de71e7cb75335', 'Gas OCGT new', 'd866124fe64b447299aa25ae0dac67c8', '1b8131ba1aa94f8ebc30be409968869e', 1),
  ('15cb674ec954421992f943f58e58cc09', 'Wind Onshore', '6ccdaca7be4142e68a7965946d5ab112', '1b8131ba1aa94f8ebc30be409968869e', 1),
  ('18d3099948e146e1b1e8e3c2d4432678', 'Solar (Thermal)', '37234006dd9b4403b6498de925acb3f5', '1b8131ba1aa94f8ebc30be409968869e', 1),
  ('1a318c3cf6ca4d6f96bb0003c653b4ea', 'Power to Gas (generation)', '62e61ac6e8c345dd8f14309d2f4572e1', '1b8131ba1aa94f8ebc30be409968869e', 1),
  ('209fbc62927949ff890c17aafd7ea2b9', 'Hard Coal biofuel', '1d20debd3268455ca8da125b688477c0', '1b8131ba1aa94f8ebc30be409968869e', 1),
  ('22444f179b144c69b91ad06c87daf84d', 'Gas OCGT old', 'd866124fe64b447299aa25ae0dac67c8', '1b8131ba1aa94f8ebc30be409968869e', 1),
  ('239080d06cc542a88d3c3e137dd5aa8e', 'Conventional gas old 2', '553e1c7f2d294852af9c37d1a5c86931', '1b8131ba1aa94f8ebc30be409968869e', 1),
  ('25b196f686094d3fb8d8b0fe15c79c1d', 'Oil shale biofuel', '553e1c7f2d294852af9c37d1a5c86931', '1b8131ba1aa94f8ebc30be409968869e', 1),
  ('2b4bdd2f4db14e55ad1d245bc8bcc388', 'Oil shale old', '553e1c7f2d294852af9c37d1a5c86931', '1b8131ba1aa94f8ebc30be409968869e', 1),
  ('2cc4bab6b6d545e485abd77d7419bd2f', 'Demand Side Response', '7f31cad94e284146b14483f396d1ed56', '1b8131ba1aa94f8ebc30be409968869e', 1),
  ('2cf678dde3a54843952262e893eabd34', 'Lignite new', '1d20debd3268455ca8da125b688477c0', '1b8131ba1aa94f8ebc30be409968869e', 1),
  ('31525d833ec64c12934d05cc088ba99e', 'Pump Storage - Closed Loop (turbine/pump)', 'a217617a6b304a38b493e0fb4bf26b30', '1b8131ba1aa94f8ebc30be409968869e', 1),
  ('32bdd33ce2cb47a097a55383ff1fc39b', 'Heavy oil old 1', '553e1c7f2d294852af9c37d1a5c86931', '1b8131ba1aa94f8ebc30be409968869e', 1),
  ('372aaf2e45294c858223f69052f9f3b2', 'Heavy oil old 2', '553e1c7f2d294852af9c37d1a5c86931', '1b8131ba1aa94f8ebc30be409968869e', 1),
  ('3b0e9a1bd1764e88ac848d1ae5ec388f', 'Nuclear', '065e05103e71427b993841e543a0b4a4', '1b8131ba1aa94f8ebc30be409968869e', 1),
  ('4c094f888e714428b8c9a873e87b5fb7', 'hvdc', '0ee425bf56124d14a86526ee29f1731e', '1b8131ba1aa94f8ebc30be409968869e', 1),
  ('52f6e7ab88b04a95b1fb1f0b3d4f6562', 'Hard Coal old 1', '1d20debd3268455ca8da125b688477c0', '1b8131ba1aa94f8ebc30be409968869e', 1),
  ('56dc7142ba1741d89d602ad34fc36faf', 'Gas CCGT old 2', 'b96427a9a99947d6b8f24f6876c9aa1b', '1b8131ba1aa94f8ebc30be409968869e', 1),
  ('62a24e5860594eac89ef00df2f0878cc', 'Gas CCGT CCS', 'b96427a9a99947d6b8f24f6876c9aa1b', '1b8131ba1aa94f8ebc30be409968869e', 1),
  ('63de71a1d77640a7a6df864d8bdf5392', 'Gas CCGT present 2', 'b96427a9a99947d6b8f24f6876c9aa1b', '1b8131ba1aa94f8ebc30be409968869e', 1),
  ('81fb9aaf1ca246bcafdd20a3905b0e85', 'Heavy oil biofuel', '553e1c7f2d294852af9c37d1a5c86931', '1b8131ba1aa94f8ebc30be409968869e', 1),
  ('85fb0ea572ac446c914fd1896c3d0c13', 'Light oil biofuel', '553e1c7f2d294852af9c37d1a5c86931', '1b8131ba1aa94f8ebc30be409968869e', 1),
  ('901e76bfdcb648c6aea81fb15db1b052', 'Hard Coal new', '1d20debd3268455ca8da125b688477c0', '1b8131ba1aa94f8ebc30be409968869e', 1),
  ('9318c6d59f3f4da7aa5aa1d0bf1228bd', 'Oil shale new', '553e1c7f2d294852af9c37d1a5c86931', '1b8131ba1aa94f8ebc30be409968869e', 1),
  ('9399c01f287c4830a135d546c442120e', 'Run-of-River and pondage', 'e9f574334c3449849ba9400b6242ce96', '1b8131ba1aa94f8ebc30be409968869e', 1),
  ('957a7cb21bc4411cbfdac0ce03b8eaca', 'Power to Gas (load)', '62e61ac6e8c345dd8f14309d2f4572e1', '1b8131ba1aa94f8ebc30be409968869e', 1),
  ('9b5f819599fc4cff821760045ae4343c', 'Light oil', '553e1c7f2d294852af9c37d1a5c86931', '1b8131ba1aa94f8ebc30be409968869e', 1),
  ('a19662d9d8c542c1bb0f9f3da2280f68', 'Pump Storage - Open Loop (turbine/pump)', 'a217617a6b304a38b493e0fb4bf26b30', '1b8131ba1aa94f8ebc30be409968869e', 1),
  ('a31c92941061484aaabcbabba2e143b6', 'Others non-renewable', '712f31a8464e445c9d22c376f65d42c7', '1b8131ba1aa94f8ebc30be409968869e', 1),
  ('a64157f4ca864a2d8873130e9776b28d', 'Battery Storage charge (load)', '8cf41c45a2ac499695520b37519fa7b4', '1b8131ba1aa94f8ebc30be409968869e', 1),
  ('a820b03c5e5847bfa035ed73d0c73894', 'Gas biofuel', '553e1c7f2d294852af9c37d1a5c86931', '1b8131ba1aa94f8ebc30be409968869e', 1),
  ('a865894b3eaa400bad88322551562c4d', 'Conventional gas old 1', '553e1c7f2d294852af9c37d1a5c86931', '1b8131ba1aa94f8ebc30be409968869e', 1),
  ('aa82690bf5114d11bdb498eb0162c74e', 'Default', 'b121365191924e9382c8fdb4f3984444', '1b8131ba1aa94f8ebc30be409968869e', 1),
  ('ab5393d2db014f209d6edf1c91ebe4b7', 'Hard Coal old 2', '1d20debd3268455ca8da125b688477c0', '1b8131ba1aa94f8ebc30be409968869e', 1),
  ('ad869a1c9d13455e9794a030b6f5b65d', 'Lignite CCS', '1d20debd3268455ca8da125b688477c0', '1b8131ba1aa94f8ebc30be409968869e', 1),
  ('afb2da0c901e4a719ff9f95df0dab526', 'Gas CCGT old 1', 'b96427a9a99947d6b8f24f6876c9aa1b', '1b8131ba1aa94f8ebc30be409968869e', 1),
  ('b9147d18b3d9403d953804efdb76ac47', 'Lignite old 2', '1d20debd3268455ca8da125b688477c0', '1b8131ba1aa94f8ebc30be409968869e', 1),
  ('c25cc49fc9e84288b09614057ab99137', 'Solar (Photovoltaic)', '51ae878481c14b50a712a7a32ca7d0e2', '1b8131ba1aa94f8ebc30be409968869e', 1),
  ('c8249af9150a49ee86c8148d36089608', 'Lignite biofuel', '1d20debd3268455ca8da125b688477c0', '1b8131ba1aa94f8ebc30be409968869e', 1),
  ('cd748c6eb35f48f59b355f5d08a85bb0', 'Hard Coal CCS', '1d20debd3268455ca8da125b688477c0', '1b8131ba1aa94f8ebc30be409968869e', 1),
  ('d1031297e64d45b7b8af5c3503e5c9a2', 'Wind Offshore', '6ccdaca7be4142e68a7965946d5ab112', '1b8131ba1aa94f8ebc30be409968869e', 1),
  ('d2e12b0a60f841d8983ad7da62add2d2', 'Gas CCGT new', 'b96427a9a99947d6b8f24f6876c9aa1b', '1b8131ba1aa94f8ebc30be409968869e', 1),
  ('e3ce3259d4f84401a0f9ef60ec28c727', 'Lignite old 1', '1d20debd3268455ca8da125b688477c0', '1b8131ba1aa94f8ebc30be409968869e', 1),
  ('e6a6af30840941159ffe2bbae9d11cb0', 'Gas CCGT present 1', 'b96427a9a99947d6b8f24f6876c9aa1b', '1b8131ba1aa94f8ebc30be409968869e', 1),
  ('e9e9404c770f4fd2afbba12aae14bbb9', 'Battery Storage discharge (gen.)', '8cf41c45a2ac499695520b37519fa7b4', '1b8131ba1aa94f8ebc30be409968869e', 1),
  ('f507df80664d44b0a4188c0846a29a71', 'Reservoir', 'e9f574334c3449849ba9400b6242ce96', '1b8131ba1aa94f8ebc30be409968869e', 1);
/*!40000 ALTER TABLE `generation_technologies` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Table structure for table `generation_technologies_groups`
--
DROP TABLE IF EXISTS `generation_technologies_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `generation_technologies_groups` (
  `id_technology` varchar(32) NOT NULL,
  `id_group` VARCHAR(32) NOT NULL,
  `id_model` varchar(32) NOT NULL,
  `action` tinyint(4) NOT NULL DEFAULT '0',
  -- constraint linked to id_technology only. This allows us to attach groups in new models (deltas), regardless of the id_model.
  -- double constraint tech + model would mean that the grouping should be performed at the same time that the creation of technologies!
  CONSTRAINT `fk_gentech_groups_gentech` FOREIGN KEY (`id_technology`) REFERENCES `generation_technologies` (`id_technology`),
  CONSTRAINT `fk_gentech_groups_groups` FOREIGN KEY (`id_group`) REFERENCES `technology_groups` (`id_group`),
  CONSTRAINT `fk_gentech_groups_model` FOREIGN KEY (`id_model`) REFERENCES `models` (`id_model`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;



--
-- Dumping data for table `generation_technologies_groups`
--
LOCK TABLES `generation_technologies_groups` WRITE;
/*!40000 ALTER TABLE `generation_technologies_groups` DISABLE KEYS */;
INSERT INTO `generation_technologies_groups`
  (`id_technology`, `id_group`, `id_model`) VALUES
  ('03ef5f3e2b3b435baf3d1740c59eea13', 'a2ef3fe8a76548b8ad2cec7d2de12e6c', '1b8131ba1aa94f8ebc30be409968869e'),
  ('03ef5f3e2b3b435baf3d1740c59eea13', 'b0f5bd3725c541cf91fb6e2d7a560817', '1b8131ba1aa94f8ebc30be409968869e'),
  ('03ef5f3e2b3b435baf3d1740c59eea13', '727ee88494a94865be7c990eb14117b1', '1b8131ba1aa94f8ebc30be409968869e'),
  ('0e2011c71524489b8dddde64a2d537a2', 'a2ef3fe8a76548b8ad2cec7d2de12e6c', '1b8131ba1aa94f8ebc30be409968869e'),
  ('0e2011c71524489b8dddde64a2d537a2', 'b0f5bd3725c541cf91fb6e2d7a560817', '1b8131ba1aa94f8ebc30be409968869e'),
  ('102c142d4b0e4b3c871de71e7cb75335', '712f31a8464e445c9d22c376f65d42c7', '1b8131ba1aa94f8ebc30be409968869e'),
  ('15cb674ec954421992f943f58e58cc09', 'a2ef3fe8a76548b8ad2cec7d2de12e6c', '1b8131ba1aa94f8ebc30be409968869e'),
  ('15cb674ec954421992f943f58e58cc09', 'b0f5bd3725c541cf91fb6e2d7a560817', '1b8131ba1aa94f8ebc30be409968869e'),
  ('18d3099948e146e1b1e8e3c2d4432678', 'a2ef3fe8a76548b8ad2cec7d2de12e6c', '1b8131ba1aa94f8ebc30be409968869e'),
  ('18d3099948e146e1b1e8e3c2d4432678', 'f728731234cb41bf8312b84f4c146443', '1b8131ba1aa94f8ebc30be409968869e'),
  ('18d3099948e146e1b1e8e3c2d4432678', 'b0f5bd3725c541cf91fb6e2d7a560817', '1b8131ba1aa94f8ebc30be409968869e'),
  ('1a318c3cf6ca4d6f96bb0003c653b4ea', '262ecc638cf5427fb42a53667588fe50', '1b8131ba1aa94f8ebc30be409968869e'),
  ('209fbc62927949ff890c17aafd7ea2b9', '712f31a8464e445c9d22c376f65d42c7', '1b8131ba1aa94f8ebc30be409968869e'),
  ('22444f179b144c69b91ad06c87daf84d', '712f31a8464e445c9d22c376f65d42c7', '1b8131ba1aa94f8ebc30be409968869e'),
  ('239080d06cc542a88d3c3e137dd5aa8e', '712f31a8464e445c9d22c376f65d42c7', '1b8131ba1aa94f8ebc30be409968869e'),
  ('25b196f686094d3fb8d8b0fe15c79c1d', '712f31a8464e445c9d22c376f65d42c7', '1b8131ba1aa94f8ebc30be409968869e'),
  ('2b4bdd2f4db14e55ad1d245bc8bcc388', '712f31a8464e445c9d22c376f65d42c7', '1b8131ba1aa94f8ebc30be409968869e'),
  ('2cc4bab6b6d545e485abd77d7419bd2f', 'cc75003ca5d2409ba5267a51ad16cea6', '1b8131ba1aa94f8ebc30be409968869e'),
  ('2cf678dde3a54843952262e893eabd34', '712f31a8464e445c9d22c376f65d42c7', '1b8131ba1aa94f8ebc30be409968869e'),
  ('31525d833ec64c12934d05cc088ba99e', 'a2ef3fe8a76548b8ad2cec7d2de12e6c', '1b8131ba1aa94f8ebc30be409968869e'),
  ('31525d833ec64c12934d05cc088ba99e', 'b0f5bd3725c541cf91fb6e2d7a560817', '1b8131ba1aa94f8ebc30be409968869e'),
  ('32bdd33ce2cb47a097a55383ff1fc39b', '712f31a8464e445c9d22c376f65d42c7', '1b8131ba1aa94f8ebc30be409968869e'),
  ('372aaf2e45294c858223f69052f9f3b2', '712f31a8464e445c9d22c376f65d42c7', '1b8131ba1aa94f8ebc30be409968869e'),
  ('3b0e9a1bd1764e88ac848d1ae5ec388f', '712f31a8464e445c9d22c376f65d42c7', '1b8131ba1aa94f8ebc30be409968869e'),
  ('3b0e9a1bd1764e88ac848d1ae5ec388f', 'b0f5bd3725c541cf91fb6e2d7a560817', '1b8131ba1aa94f8ebc30be409968869e'),
  ('52f6e7ab88b04a95b1fb1f0b3d4f6562', '712f31a8464e445c9d22c376f65d42c7', '1b8131ba1aa94f8ebc30be409968869e'),
  ('56dc7142ba1741d89d602ad34fc36faf', '712f31a8464e445c9d22c376f65d42c7', '1b8131ba1aa94f8ebc30be409968869e'),
  ('62a24e5860594eac89ef00df2f0878cc', '712f31a8464e445c9d22c376f65d42c7', '1b8131ba1aa94f8ebc30be409968869e'),
  ('63de71a1d77640a7a6df864d8bdf5392', '712f31a8464e445c9d22c376f65d42c7', '1b8131ba1aa94f8ebc30be409968869e'),
  ('81fb9aaf1ca246bcafdd20a3905b0e85', '712f31a8464e445c9d22c376f65d42c7', '1b8131ba1aa94f8ebc30be409968869e'),
  ('85fb0ea572ac446c914fd1896c3d0c13', '712f31a8464e445c9d22c376f65d42c7', '1b8131ba1aa94f8ebc30be409968869e'),
  ('901e76bfdcb648c6aea81fb15db1b052', '712f31a8464e445c9d22c376f65d42c7', '1b8131ba1aa94f8ebc30be409968869e'),
  ('9318c6d59f3f4da7aa5aa1d0bf1228bd', '712f31a8464e445c9d22c376f65d42c7', '1b8131ba1aa94f8ebc30be409968869e'),
  ('9399c01f287c4830a135d546c442120e', 'a2ef3fe8a76548b8ad2cec7d2de12e6c', '1b8131ba1aa94f8ebc30be409968869e'),
  ('9399c01f287c4830a135d546c442120e', 'b0f5bd3725c541cf91fb6e2d7a560817', '1b8131ba1aa94f8ebc30be409968869e'),
  ('957a7cb21bc4411cbfdac0ce03b8eaca', '262ecc638cf5427fb42a53667588fe50', '1b8131ba1aa94f8ebc30be409968869e'),
  ('957a7cb21bc4411cbfdac0ce03b8eaca', 'cc75003ca5d2409ba5267a51ad16cea6', '1b8131ba1aa94f8ebc30be409968869e'),
  ('9b5f819599fc4cff821760045ae4343c', '712f31a8464e445c9d22c376f65d42c7', '1b8131ba1aa94f8ebc30be409968869e'),
  ('a19662d9d8c542c1bb0f9f3da2280f68', 'a2ef3fe8a76548b8ad2cec7d2de12e6c', '1b8131ba1aa94f8ebc30be409968869e'),
  ('a19662d9d8c542c1bb0f9f3da2280f68', 'b0f5bd3725c541cf91fb6e2d7a560817', '1b8131ba1aa94f8ebc30be409968869e'),
  ('a31c92941061484aaabcbabba2e143b6', '712f31a8464e445c9d22c376f65d42c7', '1b8131ba1aa94f8ebc30be409968869e'),
  ('a31c92941061484aaabcbabba2e143b6', '727ee88494a94865be7c990eb14117b1', '1b8131ba1aa94f8ebc30be409968869e'),
  ('a64157f4ca864a2d8873130e9776b28d', 'cc75003ca5d2409ba5267a51ad16cea6', '1b8131ba1aa94f8ebc30be409968869e'),
  ('a820b03c5e5847bfa035ed73d0c73894', '712f31a8464e445c9d22c376f65d42c7', '1b8131ba1aa94f8ebc30be409968869e'),
  ('a865894b3eaa400bad88322551562c4d', '712f31a8464e445c9d22c376f65d42c7', '1b8131ba1aa94f8ebc30be409968869e'),
  ('ab5393d2db014f209d6edf1c91ebe4b7', '712f31a8464e445c9d22c376f65d42c7', '1b8131ba1aa94f8ebc30be409968869e'),
  ('ad869a1c9d13455e9794a030b6f5b65d', '712f31a8464e445c9d22c376f65d42c7', '1b8131ba1aa94f8ebc30be409968869e'),
  ('afb2da0c901e4a719ff9f95df0dab526', '712f31a8464e445c9d22c376f65d42c7', '1b8131ba1aa94f8ebc30be409968869e'),
  ('b9147d18b3d9403d953804efdb76ac47', '712f31a8464e445c9d22c376f65d42c7', '1b8131ba1aa94f8ebc30be409968869e'),
  ('c25cc49fc9e84288b09614057ab99137', 'a2ef3fe8a76548b8ad2cec7d2de12e6c', '1b8131ba1aa94f8ebc30be409968869e'),
  ('c25cc49fc9e84288b09614057ab99137', 'f728731234cb41bf8312b84f4c146443', '1b8131ba1aa94f8ebc30be409968869e'),
  ('c25cc49fc9e84288b09614057ab99137', 'b0f5bd3725c541cf91fb6e2d7a560817', '1b8131ba1aa94f8ebc30be409968869e'),
  ('c8249af9150a49ee86c8148d36089608', '712f31a8464e445c9d22c376f65d42c7', '1b8131ba1aa94f8ebc30be409968869e'),
  ('cd748c6eb35f48f59b355f5d08a85bb0', '712f31a8464e445c9d22c376f65d42c7', '1b8131ba1aa94f8ebc30be409968869e'),
  ('d1031297e64d45b7b8af5c3503e5c9a2', 'a2ef3fe8a76548b8ad2cec7d2de12e6c', '1b8131ba1aa94f8ebc30be409968869e'),
  ('d1031297e64d45b7b8af5c3503e5c9a2', 'b0f5bd3725c541cf91fb6e2d7a560817', '1b8131ba1aa94f8ebc30be409968869e'),
  ('d2e12b0a60f841d8983ad7da62add2d2', '712f31a8464e445c9d22c376f65d42c7', '1b8131ba1aa94f8ebc30be409968869e'),
  ('e3ce3259d4f84401a0f9ef60ec28c727', '712f31a8464e445c9d22c376f65d42c7', '1b8131ba1aa94f8ebc30be409968869e'),
  ('e6a6af30840941159ffe2bbae9d11cb0', '712f31a8464e445c9d22c376f65d42c7', '1b8131ba1aa94f8ebc30be409968869e'),
  ('f507df80664d44b0a4188c0846a29a71', 'a2ef3fe8a76548b8ad2cec7d2de12e6c', '1b8131ba1aa94f8ebc30be409968869e'),
  ('f507df80664d44b0a4188c0846a29a71', 'b0f5bd3725c541cf91fb6e2d7a560817', '1b8131ba1aa94f8ebc30be409968869e');
/*!40000 ALTER TABLE `generation_technologies_groups` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Table structure for table `generators`
--
DROP TABLE IF EXISTS `generators`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `generators` (
  `id_generator` varchar(32) NOT NULL,
  `id_model` varchar(32) NOT NULL,
  `action` tinyint(4) NOT NULL DEFAULT '0',
  `id_connectivity_node` varchar(32) NOT NULL,
  `id_connectivity_node_control` varchar(32) DEFAULT NULL,
  `id_power_plant` varchar(32) DEFAULT NULL,
  `id_technology` varchar(32) NOT NULL,
  `name` varchar(256) DEFAULT NULL,
  `secondary_id` varchar(48) DEFAULT NULL,
  `snom` double DEFAULT NULL,
  `p` float DEFAULT '0',
  `v` float DEFAULT '1',
  `pf` float DEFAULT '0.9',
  `pmin` float DEFAULT NULL,
  `pmax` float DEFAULT NULL,
  `qmin` float DEFAULT NULL,
  `qmax` float DEFAULT NULL,
  `r0_source` double DEFAULT NULL,
  `x0_source` double DEFAULT NULL,
  `r1_source` double DEFAULT NULL,
  `x1_source` double DEFAULT NULL,
  `r2_source` double DEFAULT NULL,
  `x2_source` double DEFAULT NULL,
  `must_run` tinyint(1) DEFAULT NULL,
  `om_fixed` float DEFAULT NULL,
  `om_variable` float DEFAULT NULL,
  `investment_cost` double DEFAULT NULL,
  `mttf` float DEFAULT NULL,
  `mttr` double DEFAULT NULL,
  `online_date` date DEFAULT NULL,
  `offline_date` date DEFAULT NULL,
  `sequential` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`id_generator`,`id_model`),
  KEY `idx_generators_technology` (`id_technology`),
  KEY `idx_generators_connectivity_node_control` (`id_connectivity_node_control`),
  KEY `idx_generators_connectivity_node` (`id_connectivity_node`),
  KEY `idx_generators_power_plant` (`id_power_plant`),
  KEY `idx_generators_model` (`id_model`),
  CONSTRAINT `fk_generators_technology` FOREIGN KEY (`id_technology`) REFERENCES `generation_technologies` (`id_technology`),
  CONSTRAINT `fk_generators_node_control` FOREIGN KEY (`id_connectivity_node_control`) REFERENCES `connectivity_nodes` (`id_connectivity_node`),
  CONSTRAINT `fk_generators_connectivity_node` FOREIGN KEY (`id_connectivity_node`) REFERENCES `connectivity_nodes` (`id_connectivity_node`),
  CONSTRAINT `fk_generators_power_plant` FOREIGN KEY (`id_power_plant`) REFERENCES `power_plants` (`id_power_plant`),
  CONSTRAINT `fk_generators_model` FOREIGN KEY (`id_model`) REFERENCES `models` (`id_model`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;



--
-- Dumping data for table `generators`
--
LOCK TABLES `generators` WRITE;
/*!40000 ALTER TABLE `generators` DISABLE KEYS */;
INSERT INTO `generators`
  (`id_generator`, `id_model`, `action`, `id_connectivity_node`, `id_connectivity_node_control`, `id_power_plant`, `id_technology`, `name`, `secondary_id`, `snom`, `p`, `v`, `pf`, `pmin`, `pmax`, `qmin`, `qmax`, `r0_source`, `x0_source`, `r1_source`, `x1_source`, `r2_source`, `x2_source`, `must_run`, `om_fixed`, `om_variable`, `investment_cost`, `mttf`, `mttr`, `online_date`, `offline_date`, `sequential`) VALUES
  ('87021b2b9b5246c68eb8b850313b84e2','1b8131ba1aa94f8ebc30be409968869e',1,'ef6b962490544e6682b86e0fd83c33bf',NULL,'7420f4cb8deb481c8160ceee28241cc3','3b0e9a1bd1764e88ac848d1ae5ec388f','G1','G1',2000,1000,1,0.9,200,2000,-1500,1500,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1);
/*!40000 ALTER TABLE `generators` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Table structure for table `technology_groups`
--
DROP TABLE IF EXISTS `technology_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `technology_groups` (
  `id_group` VARCHAR(32) NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `id_icon` VARCHAR(32) DEFAULT 'b121365191924e9382c8fdb4f3984444', -- default thunder icon
  `id_model` VARCHAR(32) NOT NULL,
  `action` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_group`, `id_model`),
  CONSTRAINT `fk_groups_model` FOREIGN KEY (`id_model`) REFERENCES `models` (`id_model`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;



--
-- Dumping data for table `technology_groups`
--
LOCK TABLES `technology_groups` WRITE;
/*!40000 ALTER TABLE `technology_groups` DISABLE KEYS */;
INSERT INTO `technology_groups`
  (`id_group`, `name`, `id_icon`, `id_model`, `action`) VALUES
  ('a2ef3fe8a76548b8ad2cec7d2de12e6c', 'Renewables', '40460cde06c740278c350af67e360091', '1b8131ba1aa94f8ebc30be409968869e', 1),
  ('712f31a8464e445c9d22c376f65d42c7', 'Non Renewables', '712f31a8464e445c9d22c376f65d42c7', '1b8131ba1aa94f8ebc30be409968869e', 1),
  ('b0f5bd3725c541cf91fb6e2d7a560817', 'Carbon-free Generation', '12ef11cf4f3e419584f394c6ee0be2c9', '1b8131ba1aa94f8ebc30be409968869e', 1),
  ('727ee88494a94865be7c990eb14117b1', 'Other Generation', '3d6beccae3f34b91a01be58ad5387bfb', '1b8131ba1aa94f8ebc30be409968869e', 1),
  ('3c36683b637f46c5a67c05797d1a5b4c', 'Renewable Waste', '4ef7bcf4da354eb98511401411dffccb', '1b8131ba1aa94f8ebc30be409968869e', 1),
  ('ca78652cec1a417e9a25d6cc55e6f388', 'Non-renewable Waste', '2f04b893e67444f98a401634729bf517', '1b8131ba1aa94f8ebc30be409968869e', 1),
  ('9b7785360979470f8c5a0165edc4df02', 'Auxiliary Generation', '654a3623efd145b981445fbe0e1785e6', '1b8131ba1aa94f8ebc30be409968869e', 1),
  ('f728731234cb41bf8312b84f4c146443', 'Solar', 'd1e4712fd718490082f36dda1bc5da02', '1b8131ba1aa94f8ebc30be409968869e', 1),
  ('262ecc638cf5427fb42a53667588fe50', 'Hydrogen', '9d84eceb0c15458c8b44942e1f8d705e', '1b8131ba1aa94f8ebc30be409968869e', 1),
  ('cc75003ca5d2409ba5267a51ad16cea6', 'Demand', '139ecde75085421dbdacc94c4e93c499', '1b8131ba1aa94f8ebc30be409968869e', 1);
/*!40000 ALTER TABLE `technology_groups` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Table structure for table `hvdc`
--
DROP TABLE IF EXISTS `hvdc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hvdc` (
  `id_section` varchar(32) NOT NULL,
  `id_model` varchar(32) NOT NULL,
  `action` tinyint(4) NOT NULL DEFAULT '0',
  `length` float NOT NULL DEFAULT '0',
  `r` float NOT NULL DEFAULT '0',
  `loss_factor` float NOT NULL DEFAULT '0',
  `min_firing_angle_f` float NOT NULL DEFAULT '-6.28',
  `max_firing_angle_f` float NOT NULL DEFAULT '6.28',
  `min_firing_angle_t` float NOT NULL DEFAULT '-6.28',
  `max_firing_angle_t` float NOT NULL DEFAULT '6.28',
  `vset_f` float NOT NULL DEFAULT '1',
  `vset_t` float NOT NULL DEFAULT '1',
  `Pset` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_section`,`id_model`),
  -- CONSTRAINT `hvdc_ibfk_1` FOREIGN KEY (`id_section`, `id_model`) REFERENCES `sections` (`id_section`, `id_model`) ON DELETE CASCADE ON UPDATE NO ACTION
  CONSTRAINT `fk_hvdc_section` FOREIGN KEY (`id_section`) REFERENCES `sections` (`id_section`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_hvdc_model` FOREIGN KEY (`id_model`) REFERENCES `models` (`id_model`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Dumping data for table `hvdc`
--
LOCK TABLES `hvdc` WRITE;
/*!40000 ALTER TABLE `hvdc` DISABLE KEYS */;
/*!40000 ALTER TABLE `hvdc` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Table structure for table `impedance_tables`
--
DROP TABLE IF EXISTS `impedance_tables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `impedance_tables` (
  `id_table` varchar(32) NOT NULL,
  -- TODO: no debería llevar el id_model???
  `name` varchar(256) NOT NULL,
  PRIMARY KEY (`id_table`),
  KEY `idx_impedance_tables_table` (`id_table`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;



--
-- Dumping data for table `impedance_tables`
--
LOCK TABLES `impedance_tables` WRITE;
/*!40000 ALTER TABLE `impedance_tables` DISABLE KEYS */;
INSERT INTO `impedance_tables`
  (`id_table`, `name`) VALUES
  ('87021b2b9b5246c68eb8b850313b84e1', 'Default');
/*!40000 ALTER TABLE `impedance_tables` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Table structure for table `impedance_tables_data`
--
DROP TABLE IF EXISTS `impedance_tables_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `impedance_tables_data` (
  `id_table` varchar(32) NOT NULL,
  -- TODO: no debería llevar el id_model???
  `position` int(11) NOT NULL,
  `value` float NOT NULL,
  PRIMARY KEY (`id_table`,`position`),
  CONSTRAINT `fk_impedance_tables_data_table` FOREIGN KEY (`id_table`) REFERENCES `impedance_tables` (`id_table`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Dumping data for table `impedance_tables_data`
--
LOCK TABLES `impedance_tables_data` WRITE;
/*!40000 ALTER TABLE `impedance_tables_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `impedance_tables_data` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Table structure for table `icons`
--
DROP TABLE IF EXISTS `icons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `icons` (
  id_icon VARCHAR(32) NOT NULL,
  name_EN VARCHAR (225),
  name_ES VARCHAR (225),
  color_HEX VARCHAR (7),
  svg TEXT NOT NULL,
  svg_name VARCHAR (225),
  PRIMARY KEY (`id_icon`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;



--
-- Dumping data for table `icons`
--
LOCK TABLES `icons` WRITE;
/*!40000 ALTER TABLE `icons` DISABLE KEYS */;
INSERT INTO `icons`
  (`id_icon`, `name_EN`, `name_ES`, `color_HEX`, `svg`, `svg_name`) VALUES
  ( "b121365191924e9382c8fdb4f3984444","Energy","Energía","#ffcc00",'<svg width="31" height="31" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" overflow="hidden"> <defs>    <clipPath id="clip0">       <rect x="875" y="487" width="31" height="31"/>    </clipPath> </defs> <g clip-path="url(#clip0)" transform="translate(-875.52543,-487.45974)"><path d="m 884.0309,517.18877 c -0.52092,-0.38303 -0.70476,-1.0878 -0.41367,-1.67 l 4.581,-9.22327 -6.43484,-2.16027 c -0.68946,-0.24514 -1.05716,-0.99588 -0.82735,-1.68533 0.0612,-0.18384 0.16854,-0.36769 0.30643,-0.50559 l 13.13015,-13.23739 c 0.45962,-0.45964 1.17972,-0.52092 1.70064,-0.13789 0.52091,0.38302 0.70477,1.08779 0.41367,1.66999 l -4.581,9.22328 6.43485,2.16027 c 0.68944,0.22981 1.05715,0.99587 0.82733,1.68532 -0.0612,0.18384 -0.16853,0.3677 -0.32174,0.50559 l -13.13015,13.23739 c -0.44431,0.45964 -1.16441,0.52092 -1.68532,0.1379 z m 0.56688,-14.87675 5.86796,1.96109 c 0.36771,0.12257 0.65881,0.39835 0.79671,0.75074 0.15321,0.35238 0.13788,0.75073 -0.0307,1.10311 l -1.63935,3.29403 5.91393,-5.95989 -5.86796,-1.97642 c -0.68945,-0.22982 -1.05716,-0.99587 -0.82735,-1.68532 0.0153,-0.0612 0.046,-0.10729 0.0612,-0.16853 l 1.63935,-3.29403 z" fill="#ffcc00" fill-rule="evenodd"/></g></svg>',"energy.svg"),
  ( "8cf41c45a2ac499695520b37519fa7b4","Batteries","Baterías","#5C9999",'<svg width="29" height="17" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" overflow="hidden"><defs><clipPath id="clip0"><rect x="878" y="645" width="29" height="17"/></clipPath></defs><g clip-path="url(#clip0)" transform="translate(-878 -645)"><path d="M903.32 658.77 903.32 656.05 905.32 656.05C905.58 656.056 905.79 655.85 905.8 655.59 905.8 655.584 905.8 655.577 905.8 655.57L905.8 650.51C905.8 650.245 905.59 650.03 905.32 650.03L903.32 650.03 903.32 647.29C903.33 646.031 902.31 645.006 901.05 645 901.04 645 901.04 645 901.03 645L881.25 645C880 645.017 878.99 646.039 879 647.29L879 658.74C878.99 659.999 880.01 661.024 881.27 661.03 881.28 661.03 881.28 661.03 881.29 661.03L901 661.03C902.26 661.052 903.3 660.049 903.32 658.79 903.32 658.784 903.32 658.777 903.32 658.77ZM881.25 658.91C881.17 658.915 881.11 658.858 881.1 658.78 881.1 658.777 881.1 658.773 881.1 658.77L881.1 647.29C881.1 647.213 881.16 647.15 881.24 647.15 881.24 647.15 881.25 647.15 881.25 647.15L901 647.15C901.07 647.144 901.13 647.198 901.14 647.269 901.14 647.276 901.14 647.283 901.14 647.29L901.14 658.74C901.15 658.812 901.09 658.874 901.02 658.88 901.01 658.881 901.01 658.881 901 658.88L881.22 658.88Z" fill="#5C9999" fill-rule="evenodd"/><path d="M885.42 657.9 885.42 649.25C885.41 649.11 885.3 649 885.16 649L882.25 649C882.11 649 882 649.112 882 649.25L882 657.93C882 658.07 882.11 658.185 882.25 658.19L885.16 658.19C885.3 658.167 885.41 658.046 885.42 657.9Z" fill="#5C9999" fill-rule="evenodd"/><path d="M890.42 657.9 890.42 649.25C890.42 649.112 890.31 649 890.17 649 890.17 649 890.16 649 890.16 649L887.25 649C887.11 649 887 649.112 887 649.25L887 657.93C887 658.07 887.11 658.185 887.25 658.19L890.16 658.19C890.31 658.17 890.42 658.047 890.42 657.9Z" fill="#5C9999" fill-rule="evenodd"/></g></svg>',"batteries.svg"),
  ( "1d20debd3268455ca8da125b688477c0","Coal","Carbón","#993300",'<svg width="28" height="27" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" overflow="hidden"><defs><clipPath id="clip0"><rect x="72" y="161" width="28" height="27"/></clipPath></defs><g clip-path="url(#clip0)" transform="translate(-72 -161)"><path d="M98.2419 187.012 73.7617 187.012C73.3417 187.012 73.0018 186.672 73.0018 186.252 73.0018 185.832 73.3417 185.492 73.7617 185.492L77.9818 185.492C77.7118 185.031 77.5717 184.502 77.5717 183.972 77.5717 183.952 77.5717 183.922 77.5717 183.902 76.6817 183.672 76.0117 182.921 75.8718 182.012L74.6117 173.152C73.4017 172.781 72.7318 171.501 73.1017 170.292 73.3517 169.491 74.0117 168.902 74.8217 168.731L77.5117 164.211C78.0218 163.351 78.9217 162.801 79.9218 162.731 79.9918 162.731 80.0618 162.721 80.1218 162.721 81.0517 162.721 81.9218 163.141 82.5017 163.861L82.7118 164.121 84.0118 162.071C84.7318 160.971 86.2118 160.671 87.3018 161.391 87.5718 161.571 87.8018 161.801 87.9818 162.071L89.2818 164.131 89.4918 163.871C90.0718 163.151 90.9418 162.721 91.8718 162.731 91.9418 162.731 92.0118 162.731 92.0718 162.741 93.0718 162.811 93.9618 163.361 94.4818 164.211L97.1718 168.741C98.4118 168.992 99.2018 170.201 98.9519 171.441 98.7819 172.261 98.1819 172.921 97.3919 173.161L96.1318 182.012C95.9919 182.921 95.3219 183.672 94.4318 183.902L94.4318 183.932C94.4318 183.942 94.4318 183.952 94.4318 183.972 94.4318 184.512 94.2918 185.031 94.0218 185.492L98.2419 185.492C98.6618 185.492 99.0018 185.832 99.0018 186.252 98.9918 186.672 98.6518 187.012 98.2419 187.012L98.2419 187.012 98.2419 187.012ZM89.8618 183.962C89.8618 184.802 90.5418 185.482 91.3818 185.482 92.2218 185.482 92.9018 184.802 92.9018 183.962 92.9018 183.962 92.9018 183.962 92.9018 183.962L89.8618 183.962ZM83.6618 183.962C83.6618 184.502 83.5218 185.021 83.2517 185.482L88.7418 185.482C88.4718 185.021 88.3318 184.492 88.3318 183.962L83.6618 183.962ZM79.0918 183.962C79.0918 184.802 79.7718 185.482 80.6118 185.482 81.4518 185.482 82.1318 184.802 82.1318 183.962L79.0918 183.962ZM76.8117 177.821 77.3717 181.792C77.4317 182.161 77.7518 182.442 78.1217 182.442L93.8619 182.442C94.2418 182.442 94.5619 182.161 94.6119 181.792L95.1718 177.821 76.8117 177.821ZM76.1617 173.252 76.6018 176.302 95.4018 176.302 95.8318 173.252 76.1617 173.252ZM75.2817 170.201C74.8618 170.201 74.5217 170.542 74.5217 170.961 74.5217 171.381 74.8618 171.732 75.2817 171.732L96.7119 171.732C97.1318 171.732 97.4719 171.391 97.4719 170.971 97.4719 170.552 97.1318 170.211 96.7119 170.211L75.2817 170.211ZM91.8718 164.251C91.4118 164.251 90.9718 164.461 90.6918 164.821L90.1618 165.492 92.1918 168.681 95.3918 168.681 93.1919 164.981C92.9418 164.551 92.4919 164.281 91.9918 164.251 91.9418 164.251 91.9118 164.251 91.8718 164.251ZM86.0017 162.531C85.7218 162.521 85.4618 162.661 85.3017 162.891L85.3017 162.891 81.6218 168.681 90.3718 168.681 86.6918 162.891 86.6918 162.891C86.5418 162.661 86.2818 162.521 86.0017 162.531ZM80.1318 164.251C80.0918 164.251 80.0618 164.251 80.0218 164.251 79.5217 164.281 79.0718 164.561 78.8217 164.991L76.6317 168.691 79.8218 168.691 81.8517 165.502 81.3118 164.831C81.0317 164.461 80.5918 164.251 80.1318 164.251Z" fill="#993300" fill-rule="evenodd"/></g></svg>',"coal.svg"),
  ( "b96427a9a99947d6b8f24f6876c9aa1b","Combined Cycle Gas Turbine","Ciclo combinado","#FFCC66",'<svg width="31" height="29" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" overflow="hidden"><defs><clipPath id="clip0"><rect x="72" y="267" width="31" height="29"/></clipPath></defs><g clip-path="url(#clip0)" transform="translate(-72 -267)"><path d="M101.168 295 86.7983 295 86.7983 294.99 73.8082 294.99C73.5383 294.99 73.2883 294.85 73.1382 294.63 72.9883 294.4 72.9583 294.12 73.0583 293.87 74.4483 290.53 75.4383 287.05 76.0182 283.48 76.4683 278.48 76.4883 273.46 76.0782 268.45 76.0582 268.22 76.1283 267.99 76.2783 267.82 76.4283 267.65 76.6483 267.55 76.8783 267.55L85.2683 267.55C85.4983 267.55 85.7183 267.65 85.8683 267.82 86.0184 267.99 86.0883 268.22 86.0683 268.45 85.6583 273.45 85.6683 278.47 86.1283 283.46L87.3683 283.46 87.3683 274.38C87.3683 273.93 87.7283 273.56 88.1784 273.56L93.0884 273.56C93.5383 273.56 93.8984 273.93 93.8984 274.38L93.8984 283.46 95.4983 283.46 95.4983 274.38C95.4983 273.93 95.8584 273.56 96.3083 273.56L101.158 273.56C101.608 273.56 101.968 273.93 101.968 274.38L101.968 294.18C101.968 294.63 101.608 294.99 101.168 295ZM93.0784 286.74 97.9283 286.74C98.3783 286.74 98.7384 287.11 98.7384 287.56L98.7384 293.36 100.358 293.36 100.358 285.1 86.3983 285.1C86.5083 285.68 86.6483 286.28 86.7983 286.88L86.7983 286.74 89.7883 286.74C90.2384 286.74 90.5983 287.11 90.5983 287.56L90.5983 290.84C90.5983 291.29 90.2384 291.66 89.7883 291.66L88.2583 291.66C88.4483 292.2 88.6583 292.77 88.8884 293.35L92.2683 293.35 92.2683 287.55C92.2683 287.11 92.6283 286.74 93.0784 286.74L93.0784 286.74ZM93.8884 288.38 93.8884 288.38 93.8884 293.36 97.1283 293.36 97.1283 288.38 93.8884 288.38 93.8884 288.38ZM77.9683 272.46C78.0883 276.21 77.9683 279.97 77.6183 283.71 77.5182 284.43 77.3783 285.18 77.2183 285.94 77.0583 286.69 76.8683 287.49 76.6583 288.27 76.4483 289.05 76.1983 289.88 75.9183 290.73 75.6483 291.55 75.3382 292.44 74.9883 293.36L87.1483 293.36C86.8083 292.45 86.4983 291.56 86.2183 290.73 85.9383 289.9 85.6983 289.07 85.4783 288.27 85.2583 287.47 85.0683 286.69 84.9183 285.94 84.7583 285.19 84.6283 284.44 84.5183 283.71 84.1683 279.97 84.0483 276.22 84.1683 272.46L77.9683 272.46ZM87.3683 288.38 87.3683 288.38 87.3683 288.94C87.4784 289.29 87.5883 289.66 87.7083 290.02L88.9883 290.02 88.9883 288.38 87.3683 288.38 87.3683 288.38ZM97.1283 278.48 97.1283 283.46 100.358 283.46 100.358 278.48 97.1283 278.48ZM88.9883 278.48 88.9883 278.48 88.9883 283.46 92.2783 283.46 92.2783 278.48 88.9883 278.48 88.9883 278.48ZM97.1283 275.2 97.1283 276.84 100.358 276.84 100.358 275.2 97.1283 275.2ZM88.9883 275.2 88.9883 275.2 88.9883 276.84 92.2783 276.84 92.2783 275.2 88.9883 275.2 88.9883 275.2ZM77.7683 269.18 77.7683 269.18C77.8183 269.73 77.8583 270.29 77.8883 270.82L84.2483 270.82C84.2783 270.28 84.3183 269.73 84.3683 269.18L77.7683 269.18ZM101.188 271.92 97.9583 271.92C97.5084 271.92 97.1383 271.55 97.1383 271.1 97.1383 270.65 97.5084 270.28 97.9583 270.28L101.198 270.28C101.648 270.28 102.018 270.65 102.018 271.1 102.018 271.55 101.648 271.92 101.188 271.92ZM95.0983 271.92 91.8583 271.92C91.4083 271.92 91.0384 271.55 91.0384 271.1 91.0384 270.65 91.4083 270.28 91.8583 270.28L95.0883 270.28C95.5383 270.28 95.9084 270.65 95.9084 271.1 95.9184 271.55 95.5583 271.92 95.0983 271.92L95.0983 271.92 95.0983 271.92ZM89.0083 271.92C88.5583 271.92 88.1984 271.55 88.1984 271.1 88.1984 271.1 88.1984 271.1 88.1984 271.1 88.1884 268.85 89.9983 267.02 92.2383 267L100.948 267C101.398 267 101.758 267.37 101.758 267.82 101.758 268.27 101.398 268.64 100.948 268.64L92.2383 268.64C90.8883 268.65 89.8083 269.75 89.8083 271.1 89.8183 271.55 89.4583 271.92 89.0083 271.92 89.0083 271.92 89.0083 271.92 89.0083 271.92L89.0083 271.92Z" fill="#FFCC66" fill-rule="evenodd"/></g></svg>',"combined_cycle_gas_turbine.svg"),
  ( "2ac32f02efa34ff98a0b0a07d13ed29d","Cogeneration","Cogeneración","#CFA2CA",'<svg width="32" height="23" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" overflow="hidden"><defs><clipPath id="clip0"><rect x="72" y="379" width="32" height="23"/></clipPath></defs><g clip-path="url(#clip0)" transform="translate(-72 -379)"><path d="M102.101 399.783C102.571 399.763 102.951 399.363 102.931 398.893L102.361 388.693C102.341 388.423 102.201 388.183 101.971 388.043L94.6108 383.393C94.4508 383.293 94.2607 383.243 94.0807 383.253 93.9408 383.263 93.8108 383.303 93.6908 383.363 93.4007 383.513 93.2307 383.823 93.2507 384.143L93.4407 387.503 87.6007 383.783C87.4408 383.683 87.2608 383.633 87.0707 383.643 86.9307 383.653 86.8007 383.693 86.6808 383.753 86.3907 383.903 86.2207 384.213 86.2407 384.533L86.4307 387.893 81.4007 384.693 81.2307 383.523 81.2307 383.503C81.0907 382.543 80.9607 381.593 80.8207 380.633 80.8207 380.633 80.6807 379.843 80.6707 379.803 80.6707 379.793 80.6707 379.783 80.6707 379.763 80.6407 379.563 80.5507 378.953 79.6807 379.003L74.5106 379.293C74.0607 379.303 73.7007 379.663 73.6807 380.113L73.0007 400.503C72.9907 400.743 73.0906 400.973 73.2607 401.133 73.4407 401.293 73.6807 401.383 73.9207 401.373L102.101 399.783ZM81.0007 394.463C81.3607 396.993 81.6608 399.033 81.6907 399.243L74.7707 399.633 75.2707 384.313 79.5107 384.073C79.5407 384.273 80.4107 390.403 81.0007 394.463L81.0007 394.463ZM101.121 398.153 83.4407 399.143 82.7207 394.123 100.831 393.103 101.121 398.153ZM100.751 391.433 82.4907 392.463 82.2307 390.673 100.651 389.633 100.751 391.433ZM84.7007 388.843 81.9907 388.993 81.6907 386.933 84.7007 388.843ZM91.7208 388.453 88.2107 388.653 88.0708 386.133 91.7208 388.453ZM98.7808 388.053 95.2308 388.253 95.0908 385.723 98.7808 388.053ZM79.2707 382.403 75.3207 382.623 75.3807 380.933 79.0307 380.723 79.2707 382.403ZM88.7708 396.523C88.7408 395.973 88.2707 395.553 87.7207 395.583 87.1707 395.613 86.7507 396.083 86.7807 396.633 86.8107 397.183 87.2808 397.603 87.8307 397.573 88.3807 397.553 88.8008 397.083 88.7708 396.523ZM92.7707 396.303C92.7407 395.753 92.2708 395.333 91.7208 395.363 91.1707 395.393 90.7507 395.863 90.7807 396.413 90.8108 396.963 91.2807 397.383 91.8307 397.353 92.3808 397.323 92.8007 396.853 92.7707 396.303ZM95.7608 396.133C95.7308 395.583 95.2608 395.163 94.7107 395.193 94.1607 395.223 93.7408 395.693 93.7708 396.243 93.8008 396.793 94.2707 397.213 94.8207 397.183 95.3708 397.153 95.7908 396.683 95.7608 396.133ZM98.7608 395.963C98.7308 395.413 98.2608 394.993 97.7107 395.023 97.1608 395.053 96.7408 395.523 96.7708 396.073 96.8008 396.623 97.2708 397.043 97.8207 397.013 98.3707 396.983 98.7908 396.513 98.7608 395.963Z" fill="#CFA2CA" fill-rule="evenodd"/></g></svg>',"cogeneration.svg"),
  ( "3f9442bb6f8c442ca8ef1225bde66a14","Pumping Load","Consumo bombeo","#3670B6",'<svg width="31" height="31" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" overflow="hidden"><defs><clipPath id="clip0"><rect x="875" y="323" width="31" height="31"/></clipPath></defs><g clip-path="url(#clip0)" transform="translate(-875 -323)"><path d="M888.24 353.99C887.75 353.99 887.36 353.6 887.36 353.11L887.36 350.45C886.79 350.27 886.23 350.04 885.69 349.77 884.03 351.19 881.55 351.09 880.01 349.55L878.47 348.01C878.13 347.67 878.13 347.11 878.47 346.77L880.51 344.73C880.2 344.14 879.94 343.53 879.73 342.9 877.61 342.67 876 340.87 876 338.74L876 336.56C876 336.07 876.39 335.68 876.88 335.68L879.64 335.68C879.85 335 880.11 334.34 880.44 333.71 879.21 332.04 879.38 329.72 880.84 328.25L882.38 326.71C882.72 326.37 883.28 326.37 883.62 326.71L885.52 328.61C886.15 328.28 886.8 328.02 887.48 327.81 887.68 325.65 889.49 324 891.66 324L893.83 324C894.32 324 894.71 324.39 894.71 324.88L894.71 327.88C895.35 328.09 895.98 328.36 896.57 328.68 898.23 327.26 900.71 327.36 902.25 328.9L903.79 330.44C904.13 330.78 904.13 331.34 903.79 331.68L901.61 333.86C901.91 334.46 902.15 335.08 902.35 335.71 904.43 335.99 905.99 337.76 906 339.86L906 342.04C906 342.53 905.61 342.92 905.12 342.92L902.25 342.92C902.05 343.5 901.81 344.07 901.53 344.62 903.01 346.28 902.94 348.8 901.36 350.37L899.82 351.91C899.48 352.25 898.92 352.25 898.58 351.91 898.58 351.91 898.58 351.91 898.58 351.91L896.39 349.72C895.8 350.02 895.18 350.28 894.54 350.48 894.2 352.5 892.46 353.99 890.41 353.99L888.24 353.99ZM885.98 347.93C886.76 348.38 887.59 348.72 888.46 348.94 888.85 349.04 889.12 349.39 889.12 349.79L889.12 352.23 890.42 352.23C891.76 352.23 892.85 351.14 892.85 349.8 892.85 349.4 893.12 349.05 893.51 348.95 894.42 348.72 895.3 348.36 896.11 347.88 896.46 347.68 896.89 347.73 897.18 348.02L899.2 350.05 900.12 349.13C901.07 348.18 901.07 346.64 900.12 345.69 900.12 345.69 900.12 345.69 900.12 345.69L899.82 345.39C899.53 345.11 899.48 344.66 899.69 344.32 900.16 343.54 900.51 342.7 900.75 341.82 900.85 341.44 901.2 341.17 901.6 341.17L904.25 341.17 904.25 339.87C904.25 338.53 903.16 337.44 901.82 337.44L901.68 337.44C901.27 337.44 900.92 337.16 900.83 336.77 900.61 335.85 900.26 334.96 899.78 334.14 899.58 333.8 899.64 333.36 899.92 333.08L901.94 331.06 901.02 330.14C900.07 329.19 898.53 329.19 897.58 330.14L897.33 330.39C897.04 330.68 896.6 330.73 896.25 330.52 895.43 330.02 894.54 329.64 893.6 329.39 893.22 329.29 892.95 328.94 892.95 328.54L892.95 325.76 891.65 325.76C890.31 325.76 889.22 326.85 889.22 328.19L889.22 328.48C889.22 328.89 888.94 329.24 888.55 329.33 887.59 329.57 886.67 329.95 885.82 330.45 885.68 330.53 885.53 330.57 885.37 330.57 885.14 330.57 884.91 330.48 884.75 330.31L883 328.56 882.08 329.48C881.13 330.43 881.13 331.97 882.08 332.92L882.12 332.96C882.4 333.24 882.46 333.68 882.26 334.03 881.76 334.88 881.39 335.8 881.16 336.76 881.07 337.16 880.71 337.43 880.3 337.43L877.76 337.43 877.76 338.73C877.76 340.07 878.85 341.16 880.19 341.16L880.39 341.16C880.79 341.16 881.13 341.43 881.24 341.81 881.49 342.73 881.87 343.6 882.36 344.41 882.57 344.76 882.52 345.2 882.23 345.49L880.34 347.39 881.26 348.3C882.21 349.25 883.75 349.25 884.7 348.3L884.93 348.07C885.2 347.79 885.64 347.73 885.98 347.93L885.98 347.93ZM887.58 345.91C887.18 345.75 886.95 345.32 887.05 344.89L888.37 339.57 886.93 339.57C886.64 339.57 886.37 339.44 886.19 339.22 886.02 339 885.96 338.71 886.04 338.45L887.74 332.63C887.86 332.24 888.23 331.98 888.64 331.98L893.11 331.98C893.42 331.98 893.71 332.13 893.88 332.38 894.05 332.63 894.08 332.94 893.96 333.22L892.89 335.61 894.08 335.61C894.42 335.61 894.73 335.79 894.9 336.08 895.06 336.37 895.04 336.72 894.85 336.99L888.72 345.59C888.54 345.84 888.26 345.98 887.95 345.98 887.82 345.99 887.7 345.96 887.58 345.91ZM888.15 337.8 889.54 337.8C889.82 337.8 890.09 337.92 890.27 338.14 890.45 338.35 890.51 338.63 890.45 338.9L890.02 340.62 892.32 337.39 891.48 337.39C891.17 337.39 890.88 337.24 890.71 336.99 890.54 336.74 890.51 336.43 890.63 336.15L891.7 333.76 889.34 333.76 888.15 337.8Z" fill="#3670B6" fill-rule="evenodd"/></g></svg>',"pumping_load.svg"),
  ( "d23b83aa55db4a5b97dc2183805a50d5","Connection","Enlace balear","#EB6539",'<svg width="31" height="31" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" overflow="hidden"><defs><clipPath id="clip0"><rect x="875" y="487" width="31" height="31"/></clipPath></defs><g clip-path="url(#clip0)" transform="translate(-875 -487)"><path d="M876 502.86C876 502.38 876.39 501.98 876.87 501.97 876.87 501.97 876.87 501.97 876.87 501.97 877.35 501.97 877.74 502.37 877.74 502.85 877.74 502.85 877.74 502.85 877.74 502.85 877.69 510.16 883.56 516.13 890.87 516.19 895.08 516.17 899.02 514.13 901.47 510.7L899.7 510.81C899.21 510.83 898.8 510.44 898.79 509.95 898.77 509.48 899.13 509.08 899.6 509.04L903.09 508.82C903.58 508.8 903.99 509.17 904.01 509.66 904.01 509.68 904.01 509.7 904.01 509.72L904.01 513.47C904.01 513.95 903.62 514.34 903.14 514.34 902.66 514.34 902.27 513.95 902.27 513.47L902.27 512.54C899.47 515.95 895.29 517.93 890.88 517.95 882.6 517.89 875.95 511.14 876 502.86ZM887.07 512.81C886.73 512.56 886.61 512.1 886.8 511.72L889.79 505.7 885.59 504.29C885.14 504.13 884.9 503.64 885.05 503.19 885.09 503.07 885.16 502.95 885.25 502.86L893.82 494.22C894.12 493.92 894.59 493.88 894.93 494.13 895.27 494.38 895.39 494.84 895.2 495.22L892.21 501.24 896.41 502.65C896.86 502.8 897.1 503.3 896.95 503.75 896.91 503.87 896.84 503.99 896.74 504.08L888.17 512.72C887.88 513.02 887.41 513.06 887.07 512.81L887.07 512.81ZM887.44 503.1 891.27 504.38C891.51 504.46 891.7 504.64 891.79 504.87 891.89 505.1 891.88 505.36 891.77 505.59L890.7 507.74 894.56 503.85 890.73 502.56C890.28 502.41 890.04 501.91 890.19 501.46 890.2 501.42 890.22 501.39 890.23 501.35L891.3 499.2 887.44 503.1ZM904.25 503.09C904.3 495.78 898.43 489.82 891.12 489.75 886.91 489.77 882.97 491.81 880.52 495.24L882.29 495.13C882.78 495.11 883.19 495.5 883.2 495.99 883.22 496.46 882.86 496.86 882.39 496.9L878.9 497.12C878.42 497.14 878 496.77 877.98 496.29 877.98 496.27 877.98 496.26 877.98 496.24L877.98 496.24 877.98 492.48C877.96 492 878.34 491.6 878.82 491.58 879.3 491.56 879.7 491.94 879.72 492.42 879.72 492.44 879.72 492.46 879.72 492.48L879.72 493.41C882.52 490 886.69 488.02 891.11 488 899.38 488.09 906.03 494.84 905.98 503.11 905.98 503.59 905.59 503.98 905.11 503.98 904.63 503.98 904.26 503.57 904.25 503.09L904.25 503.09Z" fill="#EB6539" fill-rule="evenodd"/></g></svg>',"connection.svg"),
  ( "6ccdaca7be4142e68a7965946d5ab112","Wind","Eólica","#6FB114",'<svg width="32" height="27" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" overflow="hidden"><defs><clipPath id="clip0"><rect x="72" y="543" width="32" height="27"/></clipPath></defs><g clip-path="url(#clip0)" transform="translate(-72 -543)"><path d="M74.139 569.01 74.269 569.01C77.169 569.01 80.019 568.3 82.5891 566.96 84.369 566.01 86.0191 564.83 87.4791 563.44 87.6591 563.47 87.839 563.48 88.0191 563.48 88.1991 563.48 88.3791 563.46 88.559 563.44 90.019 564.83 91.6691 566.01 93.4491 566.96 96.0191 568.3 98.8691 569.01 101.769 569.01L101.899 569.01C102.289 569.08 102.679 568.91 102.899 568.58 103.049 568.34 103.059 568.03 102.919 567.78 101.429 565.21 99.279 563.07 96.6991 561.59 94.9291 560.58 93.0291 559.82 91.0591 559.31 90.9291 558.98 90.749 558.68 90.5091 558.41 91.0391 556.52 91.2891 554.57 91.2591 552.61 91.1891 549.69 90.3191 546.85 88.7491 544.38 88.579 544.14 88.3091 544 88.0091 544 87.7191 544 87.4391 544.14 87.2691 544.38 85.699 546.84 84.8291 549.69 84.7591 552.61 84.7291 554.57 84.979 556.52 85.5091 558.41 85.2791 558.68 85.089 558.98 84.959 559.31 82.9891 559.82 81.0891 560.58 79.319 561.59 76.7391 563.07 74.5891 565.2 73.0991 567.78 72.959 568.03 72.969 568.34 73.1191 568.58 73.369 568.91 73.7591 569.08 74.139 569.01ZM84.869 561.09C85.019 561.7 85.3591 562.25 85.829 562.67 84.5691 563.77 83.1891 564.73 81.7191 565.52 79.799 566.52 77.699 567.13 75.539 567.28 76.7891 565.55 78.389 564.11 80.2391 563.05 81.6991 562.23 83.2491 561.57 84.869 561.09L84.869 561.09ZM91.1991 561.09C92.809 561.57 94.369 562.23 95.8391 563.06 97.6891 564.12 99.289 565.56 100.539 567.29 98.3791 567.13 96.2791 566.53 94.359 565.53 92.889 564.74 91.509 563.78 90.2491 562.68 90.709 562.25 91.0491 561.7 91.1991 561.09L91.1991 561.09ZM88.0291 558.98C88.4391 558.98 88.8291 559.14 89.1091 559.43 89.369 559.69 89.5191 560.05 89.5091 560.42 89.4791 561.21 88.8191 561.84 88.0191 561.82 87.229 561.84 86.5591 561.21 86.529 560.42 86.529 560.05 86.6691 559.69 86.9391 559.43 87.239 559.14 87.6291 558.98 88.0291 558.98ZM88.0291 557.3C87.7091 557.3 87.3791 557.35 87.069 557.44 86.6991 555.86 86.519 554.24 86.539 552.62 86.5791 550.54 87.089 548.49 88.0291 546.63 88.9691 548.49 89.4691 550.54 89.5191 552.62 89.5391 554.24 89.359 555.86 88.9891 557.44 88.679 557.35 88.3591 557.3 88.0291 557.3Z" fill="#6FB114" fill-rule="evenodd"/></g></svg>',"wind.svg"),
  ( "553e1c7f2d294852af9c37d1a5c86931","Oil & Gas","Fuel + gas","#BA0F16",'<svg width="23" height="27" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" overflow="hidden"><defs><clipPath id="clip0"><rect x="515" y="377" width="23" height="27"/></clipPath></defs><g clip-path="url(#clip0)" transform="translate(-515 -377)"><path d="M535.15 403 516.83 403C515.82 403 515 402.18 515 401.17 515 400.16 515.82 399.34 516.83 399.34L517.55 399.34 517.55 382.79 516.83 382.79C515.82 382.79 515 381.97 515 380.96 515 379.95 515.82 379.13 516.83 379.13L519.69 379.13 519.69 377.76C519.69 377.34 520.04 377 520.46 377L522.61 377C523.03 377 523.38 377.34 523.38 377.76L523.38 379.13 535.15 379.13C536.16 379.13 536.98 379.95 536.98 380.96 536.98 381.97 536.16 382.79 535.15 382.79 535.15 382.79 535.15 382.79 535.15 382.79L534.43 382.79 534.43 399.34 535.15 399.34C536.16 399.34 536.98 400.16 536.98 401.17 536.98 402.18 536.16 403 535.15 403ZM516.83 400.87C516.66 400.87 516.53 401.01 516.53 401.17 516.53 401.34 516.67 401.47 516.83 401.47L516.83 401.47 535.15 401.47C535.32 401.47 535.45 401.33 535.45 401.17 535.45 401 535.31 400.87 535.15 400.87L516.83 400.87ZM519.09 392.9 519.09 399.35 532.9 399.35 532.9 392.9 519.09 392.9ZM519.09 390.76 519.09 391.37 532.9 391.37 532.9 390.76 519.09 390.76ZM519.09 382.79 519.09 389.24 532.9 389.24 532.9 382.79 519.09 382.79ZM516.83 380.66C516.66 380.66 516.52 380.8 516.52 380.96 516.52 381.13 516.66 381.27 516.82 381.27 516.82 381.27 516.82 381.27 516.82 381.27L535.14 381.27C535.31 381.27 535.45 381.13 535.45 380.97 535.45 380.81 535.31 380.67 535.14 380.67L516.83 380.67ZM521.23 378.53 521.23 379.14 521.85 379.14 521.85 378.53 521.23 378.53Z" fill="#BA0F16" fill-rule="evenodd"/></g></svg>',"oil_and_gas.svg"),
  ( "654a3623efd145b981445fbe0e1785e6","Auxiliary Generation","Generación auxiliar","#C91C17",'<svg width="29" height="29" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" overflow="hidden"><defs><clipPath id="clip0"><rect x="515" y="159" width="29" height="29"/></clipPath></defs><g clip-path="url(#clip0)" transform="translate(-515 -159)"><path d="M542.18 188 515.82 188C515.37 188 515 187.63 515 187.18L515 165.74C515.01 163.79 516.37 162.12 518.28 161.72L518.28 160.82C518.28 160.37 518.65 160 519.1 160 519.55 160 519.92 160.37 519.92 160.82L519.92 161.72C521.83 162.12 523.19 163.79 523.2 165.74L523.2 176.89C523.76 176.69 524.33 176.56 524.92 176.5 525.11 175.5 525.67 174.61 526.48 174L526.48 170.72C526.48 170.27 526.85 169.9 527.3 169.9L528.12 169.9 528.12 169.08C528.12 167.72 529.22 166.62 530.58 166.62L537.25 166.62C538.61 166.62 539.71 167.72 539.71 169.08L539.71 169.9 540.53 169.9C540.98 169.9 541.35 170.27 541.35 170.72L541.35 174C542.39 174.77 543 175.99 542.99 177.28L542.99 187.18C542.99 187.63 542.63 188 542.18 188ZM538.9 174.82C537.54 174.82 536.44 175.92 536.44 177.28L536.44 186.36 541.36 186.36 541.36 177.28C541.35 175.92 540.25 174.82 538.9 174.82ZM533.04 184.72 533.04 186.36 534.79 186.36 534.79 184.72 533.04 184.72ZM519.98 183.08C519.94 183.35 519.92 183.63 519.92 183.9L519.92 186.36 531.4 186.36 531.4 183.9C531.4 183.63 531.38 183.35 531.34 183.08L519.98 183.08ZM516.64 174.82 516.64 186.36 518.28 186.36 518.28 174.82 516.64 174.82ZM530.58 168.26C530.13 168.26 529.76 168.63 529.76 169.08L529.76 169.9 530.58 169.9C531.03 169.9 531.4 170.27 531.4 170.72L531.4 174C532.44 174.77 533.04 175.99 533.04 177.28L533.04 183.08 534.79 183.08 534.79 177.28C534.79 175.99 535.39 174.77 536.43 174L536.43 170.72C536.43 170.27 536.8 169.9 537.25 169.9L538.07 169.9 538.07 169.08C538.07 168.63 537.7 168.26 537.25 168.26L530.58 168.26ZM525.66 178.1C523.43 178.11 521.4 179.41 520.46 181.44L530.86 181.44C529.92 179.41 527.89 178.11 525.66 178.1ZM528.94 174.82C527.87 174.82 526.93 175.51 526.6 176.52 528.49 176.76 530.21 177.74 531.4 179.23L531.4 177.28C531.4 175.92 530.3 174.82 528.94 174.82L528.94 174.82ZM519.92 174.82 519.92 179.23C520.39 178.65 520.94 178.14 521.56 177.72L521.56 174.82 519.92 174.82ZM538.9 173.18C539.18 173.18 539.45 173.21 539.72 173.26L539.72 171.54 538.08 171.54 538.08 173.26C538.34 173.21 538.62 173.18 538.9 173.18ZM528.94 173.18C529.22 173.18 529.49 173.21 529.76 173.26L529.76 171.54 528.12 171.54 528.12 173.26C528.39 173.21 528.67 173.18 528.94 173.18L528.94 173.18ZM519.92 171.54 519.92 173.18 521.56 173.18 521.56 171.54 519.92 171.54ZM516.64 171.54 516.64 173.18 518.28 173.18 518.28 171.54 516.64 171.54ZM519.92 168.26 519.92 169.9 521.56 169.9 521.56 168.26 519.92 168.26ZM516.64 168.26 516.64 169.9 518.28 169.9 518.28 168.26 516.64 168.26ZM519.92 163.42 519.92 166.61 521.56 166.61 521.56 165.73C521.56 164.7 520.9 163.77 519.92 163.42ZM518.28 163.42C517.3 163.77 516.64 164.7 516.64 165.74L516.64 166.62 518.28 166.62 518.28 163.42Z" fill="#C91C17" fill-rule="evenodd"/></g></svg>',"auxiliary_generation.svg"),
  ( "12ef11cf4f3e419584f394c6ee0be2c9","Carbon-free Generation","Generación sin emisiones","#95C41A",'<svg width="35" height="23" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" overflow="hidden"><defs><clipPath id="clip0"><rect x="879" y="590" width="35" height="23"/></clipPath></defs><g clip-path="url(#clip0)" transform="translate(-879 -590)"><path d="M884.453 612.26C882.753 612.281 881.143 611.485 880.133 610.12 879.042 608.59 878.717 606.642 879.253 604.84 879.853 602.659 881.753 601.089 884.013 600.91L884.343 600.91 884.473 600.59C885.483 598.03 887.843 596.254 890.583 596 890.803 596 891.013 596 891.233 596 893.923 596.03 896.393 597.494 897.713 599.84L897.843 600.07 898.103 600.07C898.963 600.212 899.783 600.536 900.513 601.02 903.303 603.016 903.943 606.895 901.953 609.684 900.783 611.309 898.913 612.275 896.913 612.28ZM885.253 602.58C884.073 602.58 881.623 602.58 880.843 605.3 880.453 606.602 880.693 608.01 881.493 609.11 882.193 610.051 883.313 610.589 884.493 610.55L896.903 610.55C898.883 610.605 900.653 609.314 901.203 607.41 901.813 605.564 901.143 603.536 899.563 602.41 898.713 601.887 897.723 601.62 896.723 601.64 895.853 599.84 894.353 597.64 891.323 597.64L890.733 597.64C887.533 597.92 886.353 600.12 885.633 602.56Z" fill="#9DC41A" fill-rule="evenodd"/><path d="M905.057 603.203 905.057 600.483C905.057 600.423 905.057 600.363 905.057 600.303L905.057 599.863 904.767 599.863C903.237 599.836 901.767 599.265 900.627 598.253 899.507 596.918 898.927 595.207 899.007 593.463L899.007 592.833 899.647 592.833 899.877 592.833C901.547 592.784 903.177 593.366 904.437 594.463 904.677 594.702 904.887 594.967 905.067 595.253L905.427 595.783 905.587 595.163C905.797 594.212 906.267 593.337 906.937 592.633 908.197 591.536 909.817 590.953 911.487 591.003L911.717 591.003 912.357 591.003 912.357 591.643C912.437 593.387 911.857 595.097 910.737 596.433 909.797 597.29 908.627 597.857 907.377 598.063L907.267 598.063 907.207 598.153C906.687 598.824 906.387 599.644 906.367 600.493L906.367 603.213ZM900.557 594.583C900.647 595.561 901.047 596.485 901.697 597.223 902.467 597.881 903.437 598.28 904.447 598.363L904.837 598.413 904.757 598.033C904.607 597.056 904.177 596.144 903.517 595.403 902.777 594.759 901.857 594.36 900.877 594.263L900.507 594.263ZM910.677 592.433C909.697 592.53 908.777 592.929 908.037 593.573 907.377 594.346 906.977 595.303 906.887 596.313L906.837 596.713 907.227 596.633C908.197 596.48 909.107 596.05 909.847 595.393 910.497 594.657 910.907 593.733 910.997 592.753L910.997 592.383Z" fill="#9DC41A" fill-rule="evenodd"/></g></svg>',"carbon_free_generation.svg"),
  ( "e9f574334c3449849ba9400b6242ce96","Hydro","Hidráulica","#0090d1",'<svg width="20" height="28" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" overflow="hidden"><defs><clipPath id="clip0"><rect x="515" y="216" width="20" height="28"/></clipPath></defs><g clip-path="url(#clip0)" transform="translate(-515 -216)"><path d="M524.5 242.96C519.26 242.96 515 239.21 515 234.594 515 231.565 516.49 227.719 519.43 223.181 520.76 221.133 522.22 219.161 523.81 217.296 524.14 216.931 524.72 216.902 525.1 217.219 525.13 217.238 525.15 217.267 525.18 217.296 526.77 219.161 528.24 221.133 529.57 223.181 532.51 227.719 534 231.565 534 234.594 534 239.21 529.74 242.96 524.5 242.96ZM524.5 219.036 524.5 219.036C522.79 221.133 521.24 223.354 519.86 225.671 517.78 229.219 516.73 232.219 516.73 234.585 516.73 238.354 520.22 241.431 524.5 241.431 528.78 241.431 532.27 238.363 532.27 234.585 532.27 232.219 531.22 229.219 529.14 225.671 527.76 223.363 526.21 221.142 524.5 219.036Z" fill="#0090D1" fill-rule="evenodd"/></g></svg>',"hydro.svg"),
  ( "93d198581d2c4581a9089dcc4498e942","Hydrowind","Hidroeólica","#00FFFF",'<svg width="31" height="32" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" overflow="hidden"><defs><clipPath id="clip0"><rect x="515" y="538" width="31" height="32"/></clipPath></defs><g clip-path="url(#clip0)" transform="translate(-515 -538)"><path d="M534.302 565.66C533.612 565.66 533.242 566.13 532.642 566.96 532.032 568.15 530.832 568.92 529.502 569 528.162 568.93 526.972 568.15 526.352 566.96 525.752 566.13 525.382 565.66 524.702 565.66 524.022 565.66 523.642 566.13 523.052 566.96 522.442 568.15 521.242 568.92 519.912 569 519.452 569.04 519.052 568.69 519.012 568.23 518.972 567.77 519.322 567.37 519.782 567.33 519.822 567.33 519.872 567.33 519.912 567.33 520.602 567.33 520.972 566.86 521.562 566.03 522.172 564.84 523.372 564.07 524.702 563.99 526.042 564.06 527.232 564.84 527.852 566.03 528.452 566.86 528.822 567.33 529.512 567.33 530.202 567.33 530.572 566.86 531.172 566.03 531.782 564.84 532.982 564.07 534.312 563.99 535.652 564.06 536.842 564.84 537.462 566.03 538.062 566.86 538.432 567.33 539.122 567.33 539.582 567.29 539.982 567.63 540.022 568.09 540.062 568.55 539.722 568.95 539.262 568.99 539.212 568.99 539.172 568.99 539.122 568.99 536.172 569 535.962 565.66 534.302 565.66ZM536.322 561.96C535.742 561.13 535.372 560.66 534.702 560.66 534.032 560.66 533.662 561.13 533.082 561.96 532.492 563.14 531.322 563.92 530.002 564 528.682 563.92 527.512 563.14 526.922 561.96 526.332 561.13 525.972 560.66 525.302 560.66 524.632 560.66 524.262 561.13 523.682 561.96 523.092 563.14 521.912 563.92 520.592 564 519.272 563.92 518.102 563.14 517.512 561.96 516.922 561.13 516.562 560.66 515.892 560.66 515.432 560.69 515.032 560.35 515.002 559.89 514.972 559.43 515.312 559.03 515.772 559 515.812 559 515.852 559 515.892 559 517.212 559.08 518.382 559.86 518.972 561.04 519.562 561.87 519.922 562.34 520.592 562.34 521.262 562.34 521.632 561.87 522.212 561.04 522.802 559.86 523.982 559.08 525.292 559 526.612 559.08 527.782 559.86 528.382 561.04 528.962 561.87 529.332 562.34 530.002 562.34 530.672 562.34 531.042 561.87 531.622 561.04 532.212 559.86 533.392 559.08 534.702 559 536.022 559.08 537.192 559.86 537.792 561.04 538.372 561.87 538.742 562.34 539.412 562.34 540.082 562.34 540.452 561.87 541.032 561.04 541.622 559.86 542.802 559.08 544.112 559 544.572 558.97 544.962 559.32 544.992 559.78 545.022 560.24 544.672 560.63 544.212 560.66 544.182 560.66 544.142 560.66 544.112 560.66 543.442 560.66 543.072 561.13 542.492 561.96 541.902 563.14 540.722 563.92 539.402 564 538.092 563.92 536.922 563.14 536.322 561.96L536.322 561.96ZM529.002 558.52 523.222 556.73C522.942 556.65 522.732 556.42 522.662 556.14 522.592 555.86 522.682 555.57 522.882 555.37L525.822 552.5 521.062 547.84C520.842 547.63 520.762 547.3 520.852 547.01L522.682 541.36C522.832 540.92 523.312 540.68 523.762 540.83 523.882 540.87 523.992 540.94 524.072 541.02L527.012 543.9 531.782 539.24C531.942 539.09 532.152 539 532.372 539 532.462 539 532.542 539.01 532.622 539.04L538.402 540.82C538.682 540.9 538.892 541.13 538.962 541.41 539.032 541.69 538.942 541.98 538.742 542.18L535.802 545.05 540.562 549.71C540.782 549.92 540.862 550.25 540.772 550.54L538.952 556.19C538.802 556.63 538.322 556.87 537.872 556.72 537.752 556.68 537.642 556.61 537.562 556.53L534.622 553.65 531.652 556.55 529.972 558.19 529.842 558.31C529.682 558.46 529.472 558.55 529.252 558.55 529.172 558.56 529.082 558.54 529.002 558.52ZM525.042 555.58 529.022 556.8 532.712 553.2 533.432 552.5 532.312 551.4C531.372 551.9 530.252 551.9 529.312 551.4L525.042 555.58ZM533.502 547.31C534.022 548.22 534.022 549.33 533.502 550.24L534.752 551.46 534.812 551.52 537.762 554.41 539.022 550.52 534.612 546.21 533.502 547.31ZM522.602 547.03 527.012 551.34 528.132 550.25C527.612 549.34 527.612 548.23 528.132 547.32L526.952 546.17 523.872 543.15 522.602 547.03ZM529.922 547.72C529.332 548.18 529.232 549.03 529.692 549.61 529.732 549.66 529.772 549.7 529.812 549.75 530.362 550.28 531.242 550.28 531.792 549.75 532.332 549.24 532.342 548.38 531.832 547.85 531.792 547.8 531.742 547.76 531.692 547.72 531.182 547.31 530.452 547.31 529.922 547.72L529.922 547.72ZM532.312 546.15 536.582 541.98 532.602 540.75 528.202 545.06 529.032 545.88 529.312 546.16C530.252 545.65 531.382 545.65 532.312 546.15L532.312 546.15Z" fill="#00FFFF" fill-rule="evenodd"/></g></svg>',"hydrowind.svg"),
  ( "0ee425bf56124d14a86526ee29f1731e","International Exchanges","Intercambios internacionales","#E5DDB7",'<svg width="29" height="25" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" overflow="hidden"><defs><clipPath id="clip0"><rect x="875" y="542" width="29" height="25"/></clipPath></defs><g clip-path="url(#clip0)" transform="translate(-875 -542)"><path d="M887.737 565.874 889.587 564.824C889.967 564.614 890.097 564.134 889.887 563.754 889.817 563.624 889.717 563.524 889.587 563.454L887.737 562.404C887.357 562.184 886.867 562.304 886.647 562.684 886.577 562.804 886.537 562.944 886.537 563.084L886.537 563.344 878.187 563.344 881.807 557.164C882.027 556.794 881.897 556.304 881.527 556.094 881.527 556.094 881.517 556.094 881.517 556.084 881.137 555.864 880.647 555.994 880.417 556.374L876.107 563.734C875.887 564.114 876.017 564.594 876.397 564.814 876.517 564.884 876.667 564.924 876.807 564.924L886.547 564.924 886.547 565.184C886.547 565.624 886.907 565.974 887.347 565.974 887.477 565.984 887.617 565.944 887.737 565.874ZM903.877 563.814 899.127 555.604 899.347 555.474C899.717 555.264 899.847 554.784 899.637 554.414 899.567 554.294 899.467 554.194 899.347 554.124L897.547 553.084C897.167 552.864 896.687 552.994 896.477 553.374 896.407 553.494 896.377 553.624 896.367 553.764L896.367 555.844C896.367 556.274 896.727 556.624 897.157 556.624 897.297 556.624 897.427 556.584 897.547 556.524L897.767 556.394 901.837 563.434 894.767 563.424 894.767 563.424C894.337 563.424 893.987 563.774 893.987 564.204 893.987 564.204 893.987 564.204 893.987 564.204 893.987 564.634 894.337 564.984 894.767 564.984L894.767 564.984 903.197 564.994C903.627 564.994 903.977 564.644 903.977 564.214 903.987 564.074 903.947 563.934 903.877 563.814ZM892.987 557.484C892.987 556.104 891.867 554.984 890.487 554.984 889.107 554.984 887.987 556.104 887.987 557.484 887.987 558.864 889.107 559.984 890.487 559.984 891.867 559.984 892.987 558.864 892.987 557.484ZM891.317 557.484C891.317 557.944 890.947 558.314 890.487 558.314 890.027 558.314 889.657 557.944 889.657 557.484 889.657 557.024 890.027 556.654 890.487 556.654 890.947 556.654 891.317 557.024 891.317 557.484ZM884.177 553.884 886.007 552.844C886.377 552.634 886.517 552.164 886.307 551.794 886.237 551.664 886.137 551.564 886.007 551.494L885.777 551.364 889.917 544.334 893.497 550.434C893.717 550.814 894.207 550.934 894.587 550.724 894.957 550.514 895.097 550.044 894.887 549.674 894.887 549.674 894.877 549.664 894.877 549.664L890.607 542.394C890.377 542.014 889.887 541.884 889.507 542.114 889.387 542.184 889.297 542.274 889.227 542.394L884.397 550.594 884.167 550.464C883.787 550.244 883.297 550.384 883.077 550.764 883.007 550.884 882.977 551.004 882.977 551.144L882.977 553.224C882.977 553.654 883.337 554.004 883.767 554.004 883.767 554.004 883.767 554.004 883.777 554.004 883.927 553.984 884.057 553.944 884.177 553.884L884.177 553.884Z" fill="#E5DDB7" fill-rule="evenodd"/></g></svg>',"international_exchanges.svg"),
  ( "4e7056f76a9b449aab0966d491fd8b15","Diesel","Motores diésel","#8DA69F",'<svg width="28" height="23" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" overflow="hidden"><defs><clipPath id="clip0"><rect x="515" y="432" width="28" height="23"/></clipPath></defs><g clip-path="url(#clip0)" transform="translate(-515 -432)"><path d="M529.97 453.99 518.68 453.99 517.2 451.51C517.12 451.37 516.98 451.28 516.82 451.27L515 451.27 515 438.72 516.82 438.72C516.98 438.71 517.13 438.62 517.2 438.48L518.68 436 523 436 523 434 520 434C519.45 434 519 433.55 519 433 519 432.45 519.45 432 520 432L528 432C528.55 432 529 432.45 529 433 529 433.55 528.55 434 528 434L525 434 525 436 529.98 436 531.57 438.5C531.65 438.64 531.79 438.72 531.95 438.73L536.03 438.73 536.03 439.94 538.66 439.94C538.98 439.93 539.22 439.66 539.21 439.34L539.21 437 540.42 437 541.99 438.71 541.99 450.28 540.42 451.99 539.21 451.99 539.21 449.65C539.22 449.33 538.98 449.06 538.66 449.05L536.03 449.05 536.03 451.27 531.95 451.27C531.79 451.28 531.65 451.36 531.57 451.5L529.97 453.99 529.97 453.99ZM516.49 449.77 516.81 449.77C517.45 449.77 518.04 450.09 518.4 450.61L518.49 450.74 519.53 452.49 529.15 452.49 530.3 450.69C530.62 450.17 531.17 449.84 531.77 449.78L531.94 449.77 534.52 449.77 534.52 440.21 531.94 440.21C531.33 440.21 530.75 439.92 530.39 439.43L530.3 439.29 529.15 437.49 519.53 437.49 518.49 439.24C518.17 439.79 517.61 440.15 516.98 440.21L516.82 440.22 516.5 440.22 516.5 449.77ZM537.49 447.55 538.65 447.55C539.42 447.55 540.13 447.99 540.47 448.68L540.49 448.72 540.49 440.26 540.47 440.3C540.16 440.94 539.53 441.37 538.82 441.43L538.65 441.44 537.49 441.44 537.49 447.55Z" fill="#8DA69F" fill-rule="evenodd"/></g></svg>',"diesel.svg"),
  ( "712f31a8464e445c9d22c376f65d42c7","Non Renewables","No renovable","#C0C0C0",'<svg width="29" height="28" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" overflow="hidden"><defs><clipPath id="clip0"><rect x="875" y="271" width="29" height="28"/></clipPath></defs><g clip-path="url(#clip0)" transform="translate(-875 -271)"><path d="M876.812 297.99C876.342 297.97 875.972 297.57 876.002 297.09 876.022 296.65 876.372 296.3 876.812 296.28L876.812 285.85C876.812 285.57 876.952 285.3 877.182 285.14 877.312 285.05 877.472 285 877.632 285 877.742 285 877.852 285.02 877.952 285.07L879.272 285.65 879.292 285.66 880.392 282.89 880.402 282.86C880.842 281.77 881.072 280.59 881.062 279.41L881.062 272.83C881.062 272.37 881.422 272 881.882 272L893.212 272C893.672 272 894.032 272.38 894.032 272.83L894.032 277.95 899.502 277.95C899.962 277.95 900.322 278.33 900.322 278.79L900.322 281.86C900.342 282.7 900.502 283.52 900.802 284.31L901.352 285.99C901.502 286.44 901.622 286.8 901.712 287.05L900.922 287.05 901.892 287.48C901.822 287.34 901.762 287.2 901.712 287.05L901.892 287.05C901.892 287.06 901.892 287.06 901.892 287.07 901.932 287.21 901.942 287.36 901.942 287.5L902.592 287.79C902.902 287.93 903.092 288.24 903.092 288.58L903.092 296.29 903.152 296.29C903.622 296.31 903.992 296.71 903.962 297.19 903.942 297.63 903.592 297.98 903.152 298L876.812 297.99ZM878.452 296.28 901.462 296.28 901.462 289.13 896.932 287.13 896.932 288.56C896.932 288.84 896.792 289.11 896.562 289.27 896.332 289.43 896.042 289.46 895.792 289.34L890.752 287.12 890.752 288.55C890.752 288.83 890.612 289.1 890.382 289.26 890.252 289.35 890.092 289.4 889.932 289.4 889.822 289.4 889.712 289.38 889.612 289.33L884.572 287.12 884.572 288.53C884.572 288.81 884.432 289.08 884.202 289.24 884.072 289.33 883.912 289.38 883.752 289.38 883.642 289.38 883.532 289.36 883.432 289.31L878.452 287.14 878.452 296.28ZM895.292 287.28 895.292 287.04 894.752 287.04 895.292 287.28ZM889.112 287.28 889.112 287.04 888.582 287.04 889.112 287.28ZM882.932 287.26 882.932 287.04 882.452 287.04 882.932 287.26ZM882.442 287.04 882.932 287.04 882.932 285.84C882.932 285.56 883.072 285.29 883.302 285.13 883.432 285.04 883.592 284.99 883.752 284.99 883.862 284.99 883.972 285.01 884.072 285.06L888.512 287.02 889.112 287.02 889.112 285.85C889.112 285.57 889.252 285.3 889.482 285.14 889.612 285.05 889.772 285 889.932 285 890.042 285 890.152 285.02 890.252 285.07L894.642 287 894.702 287 893.182 283.48C892.652 282.19 892.392 280.8 892.402 279.41L892.402 277.02 882.712 277.02 882.712 279.42C882.722 280.82 882.462 282.2 881.932 283.49L881.092 286.44 882.442 287.04ZM896.432 285.06 899.002 286.19 899.922 286.59 899.242 284.82C898.892 283.87 898.702 282.86 898.682 281.85L898.682 279.62 894.032 279.62C894.052 280.73 894.272 281.82 894.692 282.84L895.792 285.05C896.002 284.97 896.232 284.97 896.432 285.06L896.432 285.06ZM882.712 275.33 892.402 275.33 892.402 273.66 882.712 273.66 882.712 275.33ZM896.742 293.99C896.332 293.99 895.992 293.54 895.992 292.99 895.992 292.44 896.332 291.99 896.742 291.99L898.242 291.99C898.652 291.99 898.992 292.44 898.992 292.99 898.992 293.54 898.652 293.99 898.242 293.99L896.742 293.99ZM891.742 293.99C891.332 293.99 890.992 293.54 890.992 292.99 890.992 292.44 891.332 291.99 891.742 291.99L893.242 291.99C893.652 291.99 893.992 292.44 893.992 292.99 893.992 293.54 893.652 293.99 893.242 293.99L891.742 293.99ZM886.742 293.99C886.332 293.99 885.992 293.54 885.992 292.99 885.992 292.44 886.332 291.99 886.742 291.99L888.242 291.99C888.652 291.99 888.992 292.44 888.992 292.99 888.992 293.54 888.662 293.99 888.242 293.99L886.742 293.99ZM881.742 293.99C881.332 293.99 880.992 293.54 880.992 292.99 880.992 292.44 881.332 291.99 881.742 291.99L883.242 291.99C883.652 291.99 883.992 292.44 883.992 292.99 883.992 293.54 883.652 293.99 883.242 293.99L881.742 293.99Z" fill="#C0C0C0" fill-rule="evenodd"/></g></svg>',"non_renewables.svg"),
  ( "065e05103e71427b993841e543a0b4a4","Nuclear","Nuclear","#464394",'<svg width="28" height="25" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" overflow="hidden"><defs><clipPath id="clip0"><rect x="72" y="215" width="28" height="25"/></clipPath></defs><g clip-path="url(#clip0)" transform="translate(-72 -215)"><path d="M92.0001 239.01C92.18 239.01 92.3501 238.97 92.5101 238.88 94.4301 237.84 96.0501 236.33 97.21 234.48 98.3801 232.62 99.0001 230.46 99.0001 228.26 98.9801 227.72 98.5301 227.29 97.9801 227.3L89.1401 227.3C88.9901 226.88 88.76 226.5 88.4501 226.17L92.87 218.95C93 218.74 93.0401 218.48 92.98 218.24 92.91 217.98 92.7401 217.77 92.5001 217.64 90.5001 216.56 88.2701 216 86.0001 216 83.73 216 81.5 216.56 79.5 217.64 79.26 217.77 79.0901 217.98 79.0201 218.24 78.9601 218.48 78.9901 218.74 79.1301 218.95L83.55 226.17C83.2401 226.49 83.01 226.88 82.86 227.3L74.0201 227.3C73.48 227.28 73.02 227.71 73 228.25 73 230.45 73.62 232.6 74.7901 234.47 75.96 236.32 77.5801 237.83 79.5 238.87 79.66 238.95 79.8301 239 80.01 239 80.37 239 80.7 238.82 80.89 238.52L85.3101 231.3C85.5401 231.35 85.77 231.37 86.0001 231.37 86.2301 231.37 86.46 231.35 86.69 231.3L91.1101 238.52C91.3101 238.83 91.6401 239.01 92.0001 239.01ZM82.87 229.22 82.87 229.22C83.02 229.64 83.2501 230.03 83.56 230.35L79.6701 236.7C78.42 235.86 77.36 234.77 76.55 233.5 75.74 232.2 75.24 230.74 75.08 229.22L82.87 229.22 82.87 229.22ZM96.9301 229.22 96.9301 229.22C96.7801 230.74 96.2801 232.21 95.4701 233.51 94.6701 234.78 93.61 235.87 92.3501 236.71L88.4601 230.36C88.77 230.04 89.0001 229.65 89.1501 229.23L96.9301 229.22 96.9301 229.22ZM86.0101 227.07C86.2301 227.07 86.44 227.12 86.63 227.23L86.63 227.23 86.63 227.23 86.64 227.23 86.65 227.23C87.0301 227.44 87.27 227.83 87.27 228.26 87.27 228.68 87.0401 229.07 86.66 229.28L86.63 229.29 86.6 229.31C86.41 229.4 86.2101 229.45 86.0001 229.46 85.79 229.46 85.5901 229.41 85.4001 229.31L85.3901 229.31 85.3701 229.3 85.3501 229.29 85.3401 229.29C84.97 229.08 84.7401 228.69 84.7301 228.27 84.7301 227.84 84.97 227.45 85.3501 227.24L85.3601 227.24 85.3701 227.24 85.3701 227.24 85.3701 227.24C85.5701 227.13 85.79 227.07 86.0101 227.07ZM86.0101 225.15C85.78 225.15 85.5501 225.17 85.3201 225.22L81.43 218.87C82.88 218.25 84.44 217.93 86.0101 217.93 87.5901 217.93 89.1401 218.25 90.5901 218.87L86.7001 225.22C86.47 225.17 86.2401 225.15 86.0101 225.15Z" fill="#464394" fill-rule="evenodd"/></g></svg>',"nuclear.svg"),
  ( "c7c9660a04e04b4fa08ccfd07a959b55","Other Renewables","Otras renovables","#8C5DA2",'<svg width="30" height="30" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" overflow="hidden"><defs><clipPath id="clip0"><rect x="875" y="378" width="30" height="30"/></clipPath></defs><g clip-path="url(#clip0)" transform="translate(-875 -378)"><path d="M878.11 407C876.99 407.04 876.05 406.17 876 405.05L876 401.25C876 400.75 876.19 400.27 876.53 399.92 876.94 399.5 877.51 399.26 878.1 399.27L878.11 399.27 881.79 399.3 882.79 398.49C883.99 397.53 885.48 397.01 887.01 397.01 887.85 397.01 888.69 397.17 889.48 397.48L889.51 397.49 889.63 397.54 891.1 398.17C891.31 398.26 891.55 398.31 891.78 398.31L895.33 398.31C896.7 398.26 897.86 399.33 897.91 400.7 897.91 400.79 897.91 400.87 897.9 400.96L898.31 400.55 900.61 398.24C901.52 397.36 902.93 397.23 903.98 397.95 904.52 398.31 904.88 398.88 904.97 399.53 905.05 400.17 904.85 400.8 904.42 401.28L900.71 405.44C899.82 406.45 898.53 407.02 897.18 407L878.11 407ZM878.11 400.84C878.01 400.84 877.9 400.88 877.83 400.95 877.76 401.02 877.71 401.11 877.71 401.22L877.71 405.06C877.72 405.27 877.9 405.44 878.11 405.43L897.19 405.43C898.03 405.44 898.83 405.08 899.39 404.45L899.39 404.45 903.11 400.28C903.27 400.1 903.33 399.86 903.27 399.63 903.23 399.49 903.15 399.36 903.03 399.27 902.69 398.99 902.19 399.02 901.88 399.32L899.16 402.06 899.15 402.07 899.14 402.08 898.35 402.84C898.18 403 897.96 403.09 897.72 403.09L888.44 403.09C888.19 403.09 887.95 402.99 887.78 402.8 887.64 402.64 887.57 402.42 887.59 402.21 887.66 401.79 888.03 401.49 888.46 401.51L895.34 401.51C895.6 401.51 895.85 401.4 896.02 401.21 896.17 401.04 896.24 400.82 896.21 400.6 896.13 400.17 895.75 399.86 895.31 399.88L891.79 399.88C891.31 399.88 890.83 399.78 890.39 399.59L888.92 398.96 888.79 398.91C888.22 398.68 887.62 398.57 887 398.57 885.88 398.57 884.79 398.95 883.91 399.65L882.65 400.66C882.49 400.79 882.29 400.86 882.09 400.86L882.11 400.86 878.11 400.84 878.11 400.84 878.11 400.84ZM883.27 393.74C882.92 393.39 882.92 392.81 883.27 392.46L884.82 390.9 884.82 385.24C884.82 381.24 888.06 378 892.06 378L898.09 378C898.59 378 899 378.41 899 378.91L899 384.94C899 388.94 895.76 392.18 891.76 392.18L886.1 392.18 884.55 393.74C884.2 394.09 883.62 394.09 883.27 393.74 883.27 393.73 883.27 393.73 883.27 393.74L883.27 393.74ZM887.92 390.37 891.76 390.37C894.76 390.37 897.19 387.94 897.19 384.94L897.19 379.81 892.06 379.81C889.06 379.81 886.63 382.24 886.63 385.24L886.63 389.08 889.82 385.89 889.82 382.85C889.82 382.35 890.23 381.94 890.73 381.94 891.23 381.94 891.64 382.35 891.64 382.85L891.64 384.08 893.6 382.12C893.92 381.74 894.49 381.68 894.88 382 895.26 382.32 895.32 382.89 895 383.28 894.97 383.32 894.93 383.36 894.88 383.4L892.92 385.36 893.42 385.36C893.92 385.34 894.34 385.74 894.36 386.24 894.38 386.74 893.98 387.16 893.48 387.18 893.46 387.18 893.44 387.18 893.42 387.18L891.11 387.18 887.92 390.37Z" fill="#8C5DA2" fill-rule="evenodd"/></g></svg>',"other_renewables.svg"),
  ( "40460cde06c740278c350af67e360091","Renewables","Renovable","#99FF33",'<svg width="17" height="31" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" overflow="hidden"><defs><clipPath id="clip0"><rect x="875" y="217" width="17" height="31"/></clipPath></defs><g clip-path="url(#clip0)" transform="translate(-875 -217)"><path d="M884 246.989C883.53 246.979 883.16 246.579 883.17 246.109L883.17 242.939C881.19 242.709 879.37 241.739 878.08 240.219 876.73 238.639 876 236.639 876 234.569 876 231.539 877.24 227.709 879.69 223.189 880.78 221.169 882 219.209 883.34 217.339 883.6 216.979 884.1 216.889 884.46 217.149 884.53 217.199 884.6 217.269 884.65 217.339 885.99 219.209 887.2 221.169 888.3 223.189 890.75 227.709 891.99 231.539 891.99 234.569 892 236.639 891.26 238.649 889.92 240.219 888.63 241.739 886.81 242.719 884.83 242.939L884.83 246.109C884.84 246.579 884.47 246.979 884 246.989ZM887.13 234.349C887.33 234.349 887.52 234.419 887.67 234.559 888.02 234.879 888.07 235.419 887.77 235.799L884.83 239.489 884.83 241.179C888.05 240.649 890.39 237.829 890.33 234.569 890.33 229.289 885.9 222.169 884 219.359 882.1 222.179 877.67 229.289 877.67 234.569 877.61 237.829 879.95 240.639 883.17 241.179L883.17 239.499 880.23 235.809C879.93 235.429 879.98 234.899 880.33 234.569 880.66 234.269 881.16 234.299 881.46 234.619 881.48 234.639 881.49 234.649 881.5 234.669L883.16 236.759 883.16 235.029 880.22 231.339C879.92 230.969 879.97 230.429 880.32 230.099 880.65 229.799 881.15 229.829 881.45 230.149 881.47 230.169 881.48 230.179 881.49 230.199L883.15 232.289 883.15 229.119C883.12 228.659 883.47 228.259 883.93 228.239 884.39 228.219 884.79 228.559 884.81 229.019 884.81 229.049 884.81 229.089 884.81 229.119L884.81 232.289 886.48 230.199C886.75 229.849 887.25 229.779 887.6 230.049 887.62 230.059 887.64 230.079 887.65 230.089 888 230.409 888.05 230.949 887.75 231.329L884.81 235.019 884.81 236.749 886.47 234.659C886.65 234.469 886.88 234.349 887.13 234.349Z" fill="#99FF33" fill-rule="evenodd"/></g></svg>',"renewables.svg"),
  ( "2f04b893e67444f98a401634729bf517","Non-renewable Waste","Residuos no renovables","#666666",'<svg width="28" height="29" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" overflow="hidden"><defs><clipPath id="clip0"><rect x="72" y="323" width="28" height="29"/></clipPath></defs><g clip-path="url(#clip0)" transform="translate(-72 -323)"><path d="M94.8101 351.99 77.24 351.99C76.79 351.98 76.44 351.62 76.44 351.17L76.44 332.72 73.82 332.72C73.3699 332.72 73 332.35 73 331.9 73 331.45 73.3699 331.08 73.82 331.08L75.4901 331.08C75.68 329.93 76.26 328.87 77.14 328.11 78.02 327.34 79.15 326.91 80.32 326.91L81.7701 326.91 81.7701 324.82C81.7701 324.37 82.12 324.01 82.5701 324L89.45 324C89.9001 324.01 90.2501 324.37 90.2501 324.82L90.2501 326.91 91.7101 326.91C92.88 326.91 94.0101 327.34 94.8901 328.11 95.77 328.88 96.3501 329.93 96.5401 331.09L98.2101 331.09C98.66 331.09 99.0301 331.46 99.0301 331.91 99.0301 332.36 98.66 332.73 98.2101 332.73L95.6001 332.73 95.6001 351.18C95.6101 351.62 95.2501 351.99 94.8101 351.99ZM78.04 332.72 78.04 350.33 94.0001 350.33 94.0001 332.72 78.04 332.72ZM80.32 328.55C78.8 328.56 77.48 329.61 77.13 331.08L94.9101 331.08C94.5601 329.6 93.2401 328.55 91.7201 328.55L80.32 328.55ZM83.3901 325.63 83.3901 326.9 88.66 326.9 88.66 325.63 83.3901 325.63Z" fill="#666666" fill-rule="evenodd"/></g></svg>',"non_renewable_waste.svg"),
  ( "4ef7bcf4da354eb98511401411dffccb","Renewable Waste","Residuos renovables","#A0A0A0",'<svg width="27" height="29" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" overflow="hidden"><defs><clipPath id="clip0"><rect x="875" y="163" width="27" height="29"/></clipPath></defs><g clip-path="url(#clip0)" transform="translate(-875 -163)"><path d="M897.8 191 880.23 191C879.78 190.99 879.43 190.643 879.43 190.209L879.43 172.418 876.82 172.418C876.37 172.418 876 172.061 876 171.628 876 171.194 876.37 170.837 876.82 170.837L878.49 170.837C878.68 169.728 879.26 168.706 880.14 167.963 881.02 167.221 882.15 166.806 883.32 166.806L884.77 166.806 884.77 164.791C884.77 164.357 885.12 164.01 885.57 164L892.45 164C892.9 164.01 893.25 164.357 893.25 164.791L893.25 166.806 894.71 166.806C895.88 166.806 897.01 167.221 897.89 167.963 898.77 168.706 899.35 169.718 899.54 170.837L901.21 170.837C901.66 170.837 902.03 171.194 902.03 171.628 902.03 172.061 901.66 172.418 901.21 172.418L898.6 172.418 898.6 190.209C898.61 190.643 898.25 191 897.8 191ZM881.04 172.418 881.04 189.399 897 189.399 897 172.418 881.04 172.418ZM883.32 168.397C881.8 168.407 880.48 169.419 880.13 170.846L897.91 170.846C897.56 169.419 896.24 168.407 894.72 168.397L883.32 168.397ZM886.38 165.581 886.38 166.806 891.65 166.806 891.65 165.581 886.38 165.581ZM889.22 186.179C888.5 186.179 887.8 186.034 887.14 185.754 885.73 185.118 884.71 183.874 884.38 182.408 884.36 182.341 884.34 182.273 884.32 182.186 884.18 182.292 884 182.36 883.82 182.36 883.65 182.36 883.48 182.302 883.34 182.206 882.99 181.945 882.92 181.463 883.18 181.116L884.25 179.737C884.4 179.544 884.64 179.429 884.89 179.429 885.07 179.429 885.25 179.486 885.39 179.592L886.89 180.74C887.24 181.01 887.3 181.492 887.02 181.83 886.75 182.158 886.27 182.225 885.92 181.974 886.11 182.987 886.8 183.855 887.76 184.318 888.22 184.51 888.71 184.607 889.21 184.616 890.11 184.607 890.98 184.289 891.67 183.729 891.82 183.594 892.01 183.527 892.21 183.527 892.43 183.527 892.65 183.614 892.8 183.777 893.1 184.096 893.08 184.587 892.75 184.877 891.77 185.696 890.52 186.159 889.22 186.179ZM893.15 182.321C892.97 182.321 892.79 182.264 892.65 182.158L891.15 181C890.8 180.73 890.74 180.248 891.02 179.911 891.29 179.583 891.77 179.515 892.12 179.766 891.91 178.754 891.23 177.895 890.28 177.423 889.82 177.23 889.33 177.134 888.83 177.124 887.93 177.134 887.06 177.452 886.37 178.011 886.22 178.146 886.03 178.214 885.83 178.214 885.38 178.214 885.02 177.857 885.03 177.433 885.03 177.22 885.13 177.008 885.29 176.864 886.28 176.044 887.53 175.591 888.82 175.571 889.54 175.571 890.24 175.716 890.9 175.996 892.31 176.632 893.33 177.876 893.66 179.342 893.68 179.409 893.7 179.477 893.72 179.564 893.86 179.458 894.04 179.39 894.22 179.39 894.39 179.39 894.56 179.448 894.7 179.544 895.05 179.805 895.13 180.287 894.86 180.634L893.79 182.013C893.64 182.215 893.4 182.331 893.15 182.321Z" fill="#A0A0A0" fill-rule="evenodd"/></g></svg>',"renewable_waste.svg"),
  ( "3d6beccae3f34b91a01be58ad5387bfb","Other Generation","Resto generación","#0886BB",'<svg width="31" height="32" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" overflow="hidden"><defs><clipPath id="clip0"><rect x="875" y="432" width="31" height="32"/></clipPath></defs><g clip-path="url(#clip0)" transform="translate(-875 -432)"><path d="M883.51 460.99C883.09 460.75 882.95 460.21 883.19 459.79 883.43 459.37 883.97 459.23 884.39 459.47 888.49 461.83 893.54 461.83 897.63 459.47 898.05 459.23 898.59 459.37 898.83 459.79 899.07 460.21 898.93 460.75 898.51 460.99 893.87 463.67 888.15 463.67 883.51 460.99L883.51 460.99ZM881.34 448C881.34 442.66 885.67 438.33 891.01 438.33 896.35 438.33 900.68 442.66 900.68 448 900.68 453.34 896.35 457.67 891.01 457.67L891.01 457.67C885.67 457.66 881.34 453.34 881.34 448ZM884.39 443.68 887.1 446.2C887.29 446.38 887.4 446.64 887.38 446.9L887.05 451.64C887.02 452.06 886.7 452.39 886.29 452.45L884.63 452.67C886.12 454.7 888.49 455.91 891.01 455.92 893.45 455.93 895.75 454.8 897.24 452.87L893.81 450.68C893.61 450.55 893.48 450.36 893.42 450.13L892.58 446.34 887.82 444.17C887.49 444.02 887.29 443.68 887.31 443.32L887.46 440.94C886.21 441.56 885.15 442.51 884.39 443.68ZM889.26 440.29 889.11 442.82 893.72 444.92C893.97 445.03 894.15 445.26 894.21 445.53L895.07 449.39 898.17 451.37C898.67 450.32 898.92 449.17 898.92 448.01 898.92 443.64 895.38 440.1 891.01 440.1 890.42 440.09 889.83 440.15 889.26 440.29L889.26 440.29ZM883.1 448C883.1 449.04 883.3 450.06 883.7 451.02L885.35 450.8 885.6 447.2 883.58 445.31C883.25 446.17 883.09 447.08 883.1 448ZM878.01 455.5C875.33 450.86 875.33 445.14 878.01 440.5 878.27 440.09 878.81 439.96 879.22 440.22 879.62 440.46 879.75 440.98 879.53 441.38 877.17 445.48 877.17 450.53 879.53 454.62 879.79 455.03 879.66 455.57 879.25 455.83 878.84 456.09 878.3 455.96 878.04 455.55 878.03 455.53 878.02 455.52 878.01 455.5L878.01 455.5ZM902.8 455.82C902.38 455.58 902.24 455.04 902.48 454.62 904.84 450.52 904.84 445.47 902.48 441.38 902.24 440.96 902.38 440.42 902.8 440.18 903.22 439.94 903.76 440.08 904 440.5 906.68 445.14 906.68 450.86 904 455.5 903.76 455.92 903.22 456.06 902.8 455.82L902.8 455.82ZM889.31 455.02 888.55 454.5C888.24 454.29 888.1 453.91 888.2 453.55L888.96 450.69C889.09 450.22 889.57 449.94 890.04 450.07 890.11 450.09 890.18 450.12 890.25 450.16L893.72 452.16C894.14 452.4 894.29 452.94 894.04 453.36 893.94 453.53 893.79 453.66 893.61 453.74L890.14 455.12C889.86 455.22 889.55 455.19 889.31 455.02L889.31 455.02ZM890.1 453.23 891.26 452.77 890.36 452.25 890.1 453.23ZM897.62 436.53C893.52 434.17 888.47 434.17 884.38 436.53 883.95 436.75 883.42 436.57 883.2 436.14 883 435.74 883.13 435.26 883.51 435.01 888.15 432.33 893.87 432.33 898.51 435.01 898.94 435.24 899.1 435.77 898.87 436.2 898.64 436.63 898.11 436.79 897.68 436.56 897.66 436.55 897.64 436.54 897.62 436.53L897.62 436.53Z" fill="#0886BB" fill-rule="evenodd"/></g></svg>',"other_generation.svg"),
  ( "d1e4712fd718490082f36dda1bc5da02","Solar","Solar","#E48500",'<svg width="25" height="25" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" overflow="hidden"><defs><clipPath id="clip0"><rect x="515" y="324" width="25" height="25"/></clipPath></defs><g clip-path="url(#clip0)" transform="translate(-515 -324)"><path d="M522.644 348.015C522.094 347.815 521.805 347.205 522.015 346.655 522.024 346.635 522.024 346.625 522.034 346.605L522.765 344.615C522.965 344.065 523.575 343.785 524.125 343.985 524.675 344.185 524.955 344.795 524.755 345.345L524.025 347.335C523.855 347.895 523.265 348.205 522.705 348.035 522.685 348.025 522.665 348.015 522.644 348.015ZM531.565 347.625C531.295 347.515 531.085 347.305 530.975 347.035L530.095 345.115C529.845 344.585 530.085 343.955 530.615 343.715 531.145 343.465 531.775 343.705 532.015 344.235L532.905 346.155C533.175 346.675 532.985 347.315 532.465 347.585 532.185 347.725 531.865 347.745 531.565 347.625L531.565 347.625ZM524.475 342.995C520.625 341.585 518.645 337.325 520.045 333.475 520.715 331.635 522.094 330.135 523.875 329.295 527.585 327.565 532.005 329.165 533.735 332.885 533.735 332.885 533.735 332.885 533.735 332.885 535.465 336.595 533.865 341.015 530.145 342.745 530.145 342.745 530.145 342.745 530.145 342.745 528.365 343.575 526.325 343.665 524.475 342.995ZM522.024 334.205C521.535 335.525 521.605 336.985 522.205 338.265 522.805 339.535 523.875 340.525 525.195 341.005 527.945 342.005 530.985 340.585 531.985 337.835 532.985 335.085 531.565 332.045 528.815 331.045 527.495 330.565 526.045 330.625 524.775 331.215L524.765 331.215C523.495 331.805 522.505 332.875 522.024 334.205ZM516.085 341.945C515.534 341.745 515.255 341.135 515.455 340.585 515.555 340.315 515.755 340.105 516.005 339.985L517.925 339.095C518.445 338.835 519.084 339.045 519.345 339.575 519.605 340.095 519.395 340.735 518.865 340.995 518.845 341.005 518.825 341.015 518.805 341.025L516.885 341.915C516.745 341.985 516.585 342.015 516.435 342.015 516.315 342.005 516.195 341.985 516.085 341.945ZM537.615 341.005 537.615 341.005 535.625 340.275C535.075 340.085 534.775 339.485 534.964 338.935 535.155 338.385 535.755 338.085 536.305 338.275 536.315 338.275 536.335 338.285 536.345 338.295L538.335 339.015C538.875 339.245 539.135 339.865 538.905 340.405 538.705 340.905 538.135 341.165 537.615 341.005L537.615 341.005ZM517.685 333.745 515.695 333.025C515.145 332.825 514.865 332.215 515.065 331.665 515.265 331.115 515.875 330.835 516.424 331.035L516.424 331.035 518.414 331.765C518.965 331.965 519.245 332.575 519.045 333.125 518.845 333.665 518.235 333.945 517.685 333.745L517.685 333.745ZM534.705 332.435C534.455 331.905 534.685 331.275 535.215 331.025 535.215 331.025 535.215 331.025 535.225 331.025L537.145 330.135C537.695 329.935 538.305 330.215 538.515 330.765 538.695 331.255 538.495 331.805 538.035 332.065L536.115 332.955C535.585 333.195 534.955 332.965 534.705 332.435ZM522.605 328.405C522.335 328.295 522.125 328.085 522.015 327.815L521.125 325.895C520.875 325.365 521.105 324.735 521.635 324.484 522.165 324.235 522.794 324.465 523.045 324.995L523.045 324.995 523.935 326.915C524.205 327.435 524.005 328.074 523.495 328.345 523.215 328.505 522.895 328.525 522.605 328.405L522.605 328.405ZM529.925 328.044C529.375 327.845 529.095 327.235 529.294 326.685 529.294 326.685 529.294 326.685 529.294 326.685L530.005 324.695C530.205 324.145 530.825 323.865 531.375 324.065 531.925 324.265 532.205 324.875 532.015 325.425L531.285 327.415C531.085 327.965 530.475 328.245 529.925 328.044 529.925 328.044 529.925 328.044 529.925 328.044L529.925 328.044Z" fill="#E48500" fill-rule="evenodd"/></g></svg>',"solar.svg"),
  ( "51ae878481c14b50a712a7a32ca7d0e2","Solar PV","Solar fotovoltaica","#E48500",'<svg width="28" height="27" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" overflow="hidden"><defs><clipPath id="clip0"><rect x="72" y="597" width="28" height="27"/></clipPath></defs><g clip-path="url(#clip0)" transform="translate(-72 -597)"><path d="M98.2441 623C98.5141 623 98.7641 622.86 98.8941 622.63 99.0241 622.41 99.0341 622.14 98.9141 621.92L93.9741 612.4C93.8441 612.15 93.5741 611.99 93.2941 611.99L78.7141 611.99C78.4341 611.99 78.1641 612.14 78.0341 612.4L73.0841 621.92C72.9641 622.14 72.9741 622.41 73.1041 622.63 73.244 622.86 73.4941 623 73.7641 623L98.2441 623ZM85.2441 621.52 75.0041 621.52 76.7041 618.24 85.2341 618.24 85.2441 621.52ZM97.0142 621.52 86.7741 621.52 86.7741 618.24 95.3041 618.24 97.0142 621.52ZM85.2441 616.76 77.4841 616.76 79.1841 613.48 85.2441 613.48 85.2441 616.76ZM94.5341 616.76 86.7741 616.76 86.7741 613.48 92.8341 613.48 94.5341 616.76ZM87.0141 610.28 87.0141 608.71C87.0141 608.31 86.5641 607.99 86.0141 607.99 85.4641 607.99 85.0141 608.31 85.0141 608.71L85.0141 610.28C85.0141 610.67 85.4641 610.99 86.0141 610.99 86.5641 610.99 87.0141 610.68 87.0141 610.28ZM81.9741 607.83 82.8541 606.95C83.0741 606.73 83.0741 606.37 82.8541 606.15 82.8541 606.15 82.8541 606.15 82.8541 606.15 82.634 605.93 82.2741 605.93 82.0541 606.15 82.0541 606.15 82.0541 606.15 82.0541 606.15L81.1741 607.03C80.9541 607.25 80.9541 607.61 81.1741 607.83 81.1741 607.83 81.1741 607.83 81.1741 607.83 81.2841 607.94 81.4241 608 81.5741 607.99 81.7241 608 81.8642 607.94 81.9741 607.83ZM90.8441 607.83C91.0641 607.61 91.0641 607.25 90.8441 607.03 90.8441 607.03 90.8441 607.03 90.8441 607.03L89.9641 606.15C89.7442 605.93 89.3841 605.93 89.1641 606.15 89.1641 606.15 89.1641 606.15 89.1641 606.15 88.9441 606.37 88.9441 606.73 89.1641 606.95 89.1641 606.95 89.1641 606.95 89.1641 606.95L90.0441 607.83C90.1541 607.94 90.2941 608 90.4442 607.99 90.5941 608 90.7441 607.94 90.8441 607.83ZM89.0142 604C89.0142 602.34 87.6742 601 86.0141 601 84.3541 601 83.0141 602.34 83.0141 604 83.0141 605.66 84.3541 607 86.0141 607 87.6742 607 89.0142 605.65 89.0142 604ZM87.3741 604C87.3741 604.75 86.7641 605.36 86.0141 605.36 85.2641 605.36 84.6541 604.75 84.6541 604 84.6541 603.25 85.2641 602.64 86.0141 602.64 86.7641 602.63 87.3741 603.24 87.3741 604ZM82.2941 605C82.6841 605 83.0041 604.55 83.0041 604 83.0041 603.45 82.6841 603 82.2941 603L80.7241 603C80.3341 603 80.0141 603.45 80.0141 604 80.0141 604.55 80.3341 605 80.7241 605L82.2941 605ZM91.2941 605C91.6841 605 92.0042 604.55 92.0042 604 92.0042 603.45 91.6841 603 91.2941 603L89.7242 603C89.3341 603 89.0142 603.45 89.0142 604 89.0142 604.55 89.3341 605 89.7242 605L91.2941 605ZM82.8441 600.83C83.0641 600.61 83.0641 600.25 82.8441 600.04 82.8441 600.04 82.8441 600.04 82.8441 600.04L81.9641 599.16C81.7441 598.94 81.3841 598.94 81.1642 599.16 81.1642 599.16 81.1642 599.16 81.1642 599.16 80.9441 599.38 80.9441 599.74 81.1642 599.96 81.1642 599.96 81.1642 599.96 81.1642 599.96L82.0441 600.84C82.1541 600.95 82.2941 601.01 82.4441 601 82.5941 601 82.7441 600.94 82.8441 600.83ZM89.9741 600.83 90.8541 599.95C91.0741 599.73 91.0741 599.37 90.8541 599.15 90.8541 599.15 90.8541 599.15 90.8541 599.15 90.6341 598.93 90.2741 598.93 90.0541 599.15 90.0541 599.15 90.0541 599.15 90.0541 599.15L89.1741 600.03C88.9541 600.25 88.9541 600.61 89.1741 600.82 89.1741 600.82 89.1741 600.82 89.1741 600.82 89.2841 600.93 89.4241 600.99 89.5741 600.99 89.7242 601 89.8641 600.94 89.9741 600.83ZM87.0141 599.28 87.0141 597.71C87.0141 597.31 86.5641 597 86.0141 597 85.4641 597 85.0141 597.32 85.0141 597.71L85.0141 599.28C85.0141 599.67 85.4641 599.99 86.0141 599.99 86.5641 599.99 87.0141 599.68 87.0141 599.28Z" fill="#E48500" fill-rule="evenodd"/></g></svg>',"solar_pv.svg"),
  ( "37234006dd9b4403b6498de925acb3f5","Solar Thermal","Solar térmica","#FF0000",'<svg width="25" height="25" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" overflow="hidden"><defs><clipPath id="clip0"><rect x="515" y="271" width="25" height="25"/></clipPath></defs><g clip-path="url(#clip0)" transform="translate(-515 -271)"><path d="M522.645 295.015C522.094 294.815 521.805 294.205 522.015 293.655 522.024 293.635 522.024 293.625 522.034 293.605L522.765 291.615C522.965 291.065 523.575 290.785 524.125 290.985 524.675 291.185 524.955 291.795 524.755 292.345L524.025 294.335C523.855 294.895 523.265 295.205 522.704 295.035 522.675 295.025 522.655 295.025 522.645 295.015ZM531.565 294.635C531.295 294.525 531.085 294.315 530.975 294.045L530.085 292.125C529.835 291.595 530.075 290.965 530.605 290.725 531.135 290.475 531.765 290.715 532.005 291.245L532.895 293.165C533.165 293.685 532.975 294.325 532.455 294.595 532.185 294.725 531.855 294.745 531.565 294.635L531.565 294.635ZM524.475 289.995C520.625 288.585 518.645 284.325 520.045 280.475 520.715 278.635 522.094 277.134 523.875 276.295 527.585 274.565 532.005 276.165 533.735 279.885 533.735 279.885 533.735 279.885 533.735 279.885 535.465 283.595 533.865 288.015 530.145 289.745 530.145 289.745 530.145 289.745 530.145 289.745 528.365 290.585 526.325 290.665 524.475 289.995ZM522.024 281.205C521.535 282.525 521.605 283.985 522.205 285.265 522.805 286.535 523.875 287.525 525.195 288.005 527.945 289.005 530.985 287.585 531.985 284.835 532.985 282.085 531.565 279.045 528.815 278.045 527.495 277.565 526.045 277.625 524.775 278.215L524.765 278.215C523.484 278.805 522.495 279.885 522.024 281.205ZM516.075 288.945C515.524 288.745 515.245 288.135 515.445 287.585 515.544 287.315 515.745 287.105 515.995 286.985L517.915 286.095C518.435 285.835 519.075 286.045 519.335 286.575 519.595 287.095 519.385 287.735 518.855 287.995 518.835 288.005 518.815 288.015 518.795 288.025L516.875 288.915C516.735 288.985 516.575 289.015 516.424 289.015 516.315 289.005 516.195 288.985 516.075 288.945ZM537.615 288.005 537.615 288.005 535.625 287.275C535.075 287.085 534.775 286.485 534.964 285.935 535.155 285.385 535.755 285.085 536.305 285.275 536.315 285.275 536.335 285.285 536.345 285.295L538.335 286.015C538.875 286.245 539.135 286.865 538.905 287.405 538.695 287.905 538.135 288.165 537.615 288.005L537.615 288.005ZM517.685 280.745 515.695 280.025C515.145 279.825 514.865 279.215 515.065 278.665 515.265 278.115 515.875 277.835 516.424 278.035L516.424 278.035 518.414 278.765C518.965 278.965 519.245 279.575 519.045 280.125 518.845 280.665 518.235 280.945 517.685 280.745L517.685 280.745ZM534.705 279.435C534.455 278.905 534.685 278.275 535.215 278.025 535.215 278.025 535.215 278.025 535.225 278.025L537.145 277.134C537.695 276.935 538.305 277.215 538.515 277.765 538.695 278.255 538.495 278.805 538.035 279.065L536.115 279.955C535.585 280.195 534.955 279.965 534.705 279.435ZM522.605 275.415C522.335 275.305 522.125 275.095 522.015 274.825L521.125 272.905C520.875 272.375 521.105 271.745 521.635 271.495 522.165 271.245 522.794 271.475 523.045 272.005L523.045 272.005 523.935 273.925C524.205 274.445 524.005 275.085 523.495 275.355 523.215 275.505 522.895 275.525 522.605 275.415L522.605 275.415ZM529.914 275.044C529.365 274.845 529.085 274.235 529.284 273.685 529.284 273.685 529.284 273.685 529.284 273.685L529.995 271.695C530.195 271.145 530.815 270.865 531.365 271.065 531.915 271.265 532.195 271.875 532.005 272.425L531.275 274.415C531.075 274.965 530.475 275.245 529.914 275.044 529.924 275.044 529.914 275.044 529.914 275.044L529.914 275.044Z" fill="#FF0000" fill-rule="evenodd"/></g></svg>',"solar_thermal.svg"),
  ( "1a14851e5d2543a4953c5b3c612644f6","Thermal renewable","Térmica renovable / Otras renovables","#9a5cbc",'<svg width="21" height="31" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" overflow="hidden"><defs><clipPath id="clip0"><rect x="72" y="485" width="21" height="31"/></clipPath></defs><g clip-path="url(#clip0)" transform="translate(-72 -485)"><path d="M73.0003 505.331C73.0003 501.831 74.4903 497.391 77.4403 492.141 78.7603 489.781 80.2303 487.511 81.8303 485.341 82.1103 484.961 82.6503 484.891 83.0303 485.171 83.1003 485.221 83.1504 485.281 83.2004 485.341 83.2203 485.361 84.7903 487.431 86.6104 490.451 87.3404 489.891 87.8503 489.521 88.0303 489.391L88.0404 489.381C88.1804 489.281 88.3503 489.231 88.5303 489.231 88.9104 489.231 89.2403 489.481 89.3503 489.841 89.4604 490.181 91.9603 498.111 92.0103 504.701 92.0803 507.521 91.0204 510.251 89.0603 512.281 87.3404 514.031 84.9803 515.011 82.5203 515.011 77.2203 514.951 72.9603 510.631 73.0003 505.331ZM74.7303 505.331C74.7003 509.661 78.1803 513.201 82.5103 513.241 84.5104 513.241 86.4303 512.441 87.8303 511.021 89.4604 509.331 90.3404 507.051 90.2704 504.701 90.0603 500.241 89.3103 495.821 88.0404 491.541 87.6803 491.811 87.3003 492.111 86.8903 492.441 86.7404 492.561 86.5503 492.631 86.3603 492.631 86.0504 492.631 85.7703 492.471 85.6203 492.201 84.4203 490.141 83.2703 488.431 82.5103 487.361 80.6803 489.951 74.7303 498.901 74.7303 505.331ZM76.0003 504.931C76.0003 500.531 79.3103 494.571 81.2803 491.401 81.5303 491.001 82.0503 490.871 82.4504 491.121 82.5603 491.191 82.6603 491.291 82.7303 491.401 83.2104 492.171 83.3803 492.461 84.7003 494.711L85.1103 495.421 85.4603 495.141C85.6103 495.021 85.8003 494.951 85.9904 494.951 86.3903 494.951 86.7404 495.231 86.8303 495.631 87.5204 498.481 87.9103 501.391 88.0004 504.321 88.0604 506.171 87.3704 507.961 86.1004 509.291 85.0203 510.391 83.5503 511.001 82.0103 511.001 78.6703 510.981 75.9903 508.271 76.0003 504.931ZM77.7103 504.931C77.7003 507.311 79.6203 509.251 82.0003 509.261 83.0804 509.261 84.1203 508.831 84.8803 508.061 85.8203 507.051 86.3303 505.711 86.2703 504.331 86.2103 501.991 85.9304 499.661 85.4303 497.371 85.2704 497.511 85.0703 497.581 84.8603 497.591 84.8103 497.591 84.7503 497.581 84.7003 497.581 84.4603 497.531 84.2403 497.381 84.1203 497.171L83.0704 495.381C82.4404 494.291 82.2003 493.891 81.9903 493.531 80.4103 496.251 77.7103 501.351 77.7103 504.931Z" fill="#9A5CBC" fill-rule="evenodd"/></g></svg>',"thermal_renewable.svg"),
  ( "d866124fe64b447299aa25ae0dac67c8","Gas Turbine","Turbina de gas","#BA0F16",'<svg width="30" height="29" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" overflow="hidden"><defs><clipPath id="clip0"><rect x="74" y="431" width="30" height="29"/></clipPath></defs><g clip-path="url(#clip0)" transform="translate(-74 -431)"><path d="M75 451.995C75.15 449.9 76.25 447.991 78 446.825L78.19 446.705C79.6101 446.001 80.52 444.569 80.56 442.985 80.55 442.565 80.4901 442.148 80.3701 441.745L80.04 440.645 81.1801 440.785C82.27 440.875 83.2901 441.346 84.07 442.115 84.7001 442.796 85.1201 443.637 85.3 444.545 85.47 445.313 85.5301 446.1 85.5001 446.885L85.5001 447.635C85.5001 448.307 85.43 448.977 85.3 449.635L85.3 449.905C85.0901 451.115 85.0901 451.505 85.3 451.735 85.44 451.878 85.64 451.944 85.84 451.915 86.1401 451.924 86.43 451.795 86.63 451.565 87.1001 450.839 87.32 449.978 87.25 449.115L87.25 446.765 88.6 448.685C88.71 448.854 88.81 449.031 88.9001 449.215 89.33 450.094 89.5401 451.058 89.5401 452.035 89.5001 456.024 86.2901 459.255 82.3 459.325 78.28 459.336 75.01 456.086 75 452.065 75 452.042 75 452.018 75 451.995ZM82.0501 442.635C82.0501 442.745 82.0501 442.855 82.0501 442.975 82.03 444.978 80.95 446.82 79.2201 447.825L78.96 447.985C77.56 448.864 76.64 450.34 76.48 451.985 76.48 455.167 79.0501 457.753 82.23 457.775L82.45 457.775C85.44 457.596 87.8201 455.198 87.98 452.205L87.98 452.085 87.98 452.165C87.91 452.287 87.8201 452.401 87.72 452.505 87.24 453.057 86.5401 453.372 85.81 453.365 85.16 453.396 84.5401 453.131 84.11 452.645 83.5301 451.955 83.52 451.345 83.77 449.845L83.89 449.125C83.9701 448.679 84.0201 448.228 84.03 447.775L84.03 447.175C84.08 446.398 84.03 445.618 83.87 444.855 83.75 444.22 83.4601 443.632 83.0201 443.155 82.7801 442.907 82.5001 442.709 82.1801 442.575L82.07 442.525ZM93.7801 445.265 93.7801 445.265C93.77 445.125 93.67 445.006 93.5401 444.965L93.4201 444.965C93.35 444.964 93.27 444.993 93.2201 445.045L93.2201 445.045C92.84 445.429 92.33 445.645 91.79 445.645 91.25 445.643 90.7401 445.431 90.36 445.055 89.57 444.286 89.55 443.019 90.32 442.227 90.33 442.213 90.35 442.199 90.36 442.185L90.36 442.185C90.45 442.096 90.47 441.96 90.4201 441.845 90.3701 441.736 90.2601 441.666 90.1401 441.665L90.04 441.665C88.94 441.665 88.04 440.77 88.04 439.665 88.04 438.56 88.94 437.665 90.04 437.665L90.04 437.665C90.1801 437.653 90.2901 437.558 90.33 437.425 90.3801 437.313 90.36 437.181 90.27 437.095L90.27 437.095C89.48 436.323 89.47 435.057 90.24 434.267 90.25 434.256 90.2601 434.245 90.27 434.235 90.65 433.854 91.16 433.642 91.7001 433.645 92.24 433.642 92.75 433.854 93.13 434.235L93.13 434.235C93.1801 434.292 93.2601 434.325 93.34 434.325 93.3801 434.334 93.4201 434.334 93.4601 434.325L93.56 434.325 93.56 434.325 93.6101 434.325C93.64 434.29 93.66 434.249 93.6801 434.205L93.6801 434.025C93.6801 432.907 94.59 432 95.71 432 96.8201 432 97.7301 432.907 97.7301 434.025L97.7301 434.085C97.7301 434.206 97.81 434.313 97.92 434.355 97.96 434.364 98 434.364 98.04 434.355 98.11 434.356 98.19 434.327 98.24 434.275L98.24 434.275C99.0299 433.485 100.31 433.485 101.1 434.275 101.89 435.065 101.89 436.345 101.1 437.135L101.1 437.135C101.01 437.224 100.99 437.36 101.04 437.475L101.04 437.575 101.04 437.575 101.04 437.625C101.07 437.656 101.11 437.677 101.16 437.685L101.33 437.685C102.43 437.685 103.33 438.58 103.33 439.685 103.33 440.79 102.43 441.685 101.33 441.685L101.28 441.685C101.11 441.69 100.97 441.834 100.98 442.005 100.98 442.005 100.98 442.005 100.98 442.005 100.98 442.079 101.01 442.15 101.06 442.205L101.06 442.205C101.85 442.995 101.85 444.275 101.06 445.065 100.27 445.855 98.99 445.855 98.2 445.065L98.2 445.065C98.1501 445.005 98.07 444.972 97.99 444.975 97.95 444.966 97.9001 444.966 97.8601 444.975 97.75 445.02 97.6801 445.127 97.6801 445.245L97.6801 445.355C97.6801 446.473 96.77 447.38 95.66 447.38 94.5401 447.38 93.63 446.473 93.63 445.355ZM94.1001 443.535C94.8 443.795 95.27 444.458 95.28 445.205L95.28 445.265C95.36 445.541 95.65 445.701 95.92 445.622 96.1001 445.573 96.23 445.438 96.28 445.265L96.28 445.145C96.28 444.151 97.08 443.343 98.08 443.341 98.56 443.339 99.0201 443.532 99.36 443.875L99.36 443.875C99.4601 443.969 99.59 444.022 99.7301 444.025 99.87 444.024 100 443.966 100.1 443.865 100.3 443.668 100.31 443.345 100.11 443.144 100.11 443.141 100.1 443.138 100.1 443.135L100.1 443.135 100.1 443.135C99.39 442.436 99.39 441.296 100.09 440.589 100.09 440.585 100.1 440.58 100.1 440.575 100.44 440.251 100.88 440.068 101.35 440.065L101.41 440.065C101.69 440.144 101.97 439.984 102.05 439.708 102.13 439.432 101.97 439.144 101.7 439.065 101.6 439.038 101.5 439.038 101.41 439.065L101.3 439.065C100.58 439.056 99.93 438.625 99.6501 437.965L99.6501 437.865 99.6501 437.775C99.44 437.184 99.56 436.527 99.96 436.045L100.07 435.925 100.07 435.925C100.27 435.719 100.27 435.391 100.07 435.185 99.9701 435.084 99.84 435.026 99.7001 435.025 99.56 435.025 99.43 435.083 99.33 435.185L99.33 435.185C98.63 435.889 97.4901 435.891 96.7801 435.189 96.7801 435.188 96.7801 435.186 96.7801 435.185 96.45 434.85 96.27 434.403 96.2601 433.935L96.2601 433.875C96.34 433.599 96.1801 433.311 95.9001 433.232 95.63 433.153 95.34 433.313 95.2601 433.589 95.23 433.683 95.23 433.782 95.2601 433.875L95.2601 433.985C95.25 434.702 94.83 435.348 94.1701 435.635L94.07 435.635 93.98 435.635C93.39 435.839 92.7301 435.722 92.24 435.325L92.13 435.215 92.13 435.215C91.9301 435.011 91.59 435.011 91.39 435.215 91.19 435.419 91.19 435.751 91.39 435.955L91.39 436.005C92.0901 436.748 92.0599 437.918 91.32 438.62 90.99 438.932 90.55 439.112 90.1001 439.125L90.04 439.125C89.76 439.046 89.48 439.206 89.4 439.482 89.32 439.758 89.48 440.046 89.75 440.125 89.8501 440.152 89.95 440.152 90.04 440.125L90.15 440.125C91.15 440.13 91.96 440.945 91.95 441.945 91.95 442.416 91.76 442.869 91.43 443.205L91.43 443.205C91.23 443.407 91.23 443.733 91.43 443.935L91.43 443.935C91.64 444.136 91.96 444.136 92.1701 443.935L92.1701 443.935 92.2201 443.935C92.56 443.605 93.0201 443.422 93.4901 443.425 93.72 443.418 93.95 443.462 94.16 443.555ZM93 439.535C93 438.016 94.23 436.785 95.75 436.785 97.27 436.785 98.5001 438.016 98.5001 439.535 98.5001 441.054 97.27 442.285 95.75 442.285 94.23 442.285 93 441.054 93 439.535ZM94.5001 439.535C94.5001 440.225 95.0599 440.785 95.75 440.785 96.44 440.785 97 440.225 97 439.535 97 438.845 96.44 438.285 95.75 438.285 95.0599 438.285 94.5001 438.845 94.5001 439.535Z" fill="#BA0F16" fill-rule="evenodd"/></g></svg>',"gas_turbine.svg"),
  ( "de09122bbd6d4df284391b600b3349d3","Steam Turbine","Turbina de vapor","#AF8E00",'<svg width="29" height="30" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" overflow="hidden"><defs><clipPath id="clip0"><rect x="515" y="481" width="29" height="30"/></clipPath></defs><g clip-path="url(#clip0)" transform="translate(-515 -481)"><path d="M528.302 510.19C527.022 510.03 525.792 509.59 524.702 508.9L523.652 508.36C522.732 507.79 521.712 507.4 520.642 507.21 519.482 507.11 518.322 507.38 517.322 507.98 517.152 508.08 517.002 508.18 516.862 508.29L516.652 508.46C516.552 508.55 516.302 508.77 516.272 508.79 515.962 509.07 515.492 509.05 515.212 508.74 514.932 508.44 514.952 507.97 515.252 507.69L515.582 507.4 515.702 507.3C517.112 506.13 518.922 505.56 520.752 505.71 521.932 505.86 523.062 506.26 524.072 506.88L525.602 507.66C526.462 508.18 527.412 508.53 528.402 508.68 529.712 508.77 531.022 508.5 532.192 507.9 532.482 507.75 532.762 507.57 533.022 507.37L533.152 507.26 533.262 507.16C533.552 506.86 534.022 506.86 534.322 507.15 534.622 507.44 534.622 507.91 534.332 508.21L534.332 508.21C533.902 508.62 533.412 508.96 532.882 509.23 531.642 509.88 530.262 510.21 528.862 510.2 528.672 510.21 528.492 510.2 528.302 510.19ZM528.302 506.19C527.022 506.03 525.792 505.59 524.702 504.9L523.642 504.36C522.722 503.79 521.702 503.4 520.632 503.21 519.282 503.09 517.932 503.48 516.852 504.29L516.642 504.46C516.542 504.55 516.292 504.77 516.262 504.79 515.962 505.07 515.482 505.06 515.202 504.75 514.922 504.45 514.932 503.97 515.242 503.69L515.572 503.4 515.692 503.3C517.102 502.13 518.912 501.56 520.742 501.71 521.922 501.86 523.052 502.26 524.062 502.87L525.592 503.65C526.452 504.17 527.402 504.52 528.392 504.67 529.702 504.76 531.012 504.49 532.182 503.89 532.472 503.74 532.752 503.56 533.012 503.36L533.142 503.25 533.252 503.15C533.542 502.85 534.012 502.85 534.312 503.14 534.612 503.43 534.612 503.9 534.322 504.2L534.322 504.2C533.892 504.61 533.402 504.95 532.872 505.22 531.632 505.87 530.252 506.2 528.852 506.19 528.672 506.21 528.492 506.2 528.302 506.19L528.302 506.19ZM528.302 502.19C527.022 502.03 525.792 501.59 524.702 500.9L523.652 500.36C522.732 499.79 521.712 499.4 520.642 499.21 519.482 499.11 518.322 499.38 517.322 499.98 517.162 500.08 517.012 500.18 516.862 500.29L516.652 500.46C516.552 500.55 516.302 500.77 516.272 500.79 515.962 501.06 515.482 501.03 515.212 500.72 514.952 500.42 514.962 499.97 515.242 499.7L515.572 499.4 515.692 499.3C515.962 499.08 516.252 498.87 516.552 498.69 517.812 497.93 519.272 497.59 520.742 497.71 521.922 497.86 523.052 498.26 524.062 498.88L525.592 499.66C526.452 500.18 527.402 500.53 528.392 500.68 529.702 500.77 531.012 500.5 532.182 499.9 532.472 499.75 532.752 499.57 533.012 499.37L533.142 499.26 533.252 499.16C533.542 498.86 534.012 498.86 534.312 499.15 534.612 499.44 534.612 499.91 534.322 500.21 533.892 500.62 533.402 500.96 532.872 501.23 531.632 501.88 530.252 502.21 528.852 502.2 528.672 502.2 528.492 502.2 528.302 502.19ZM533.072 495.43 533.072 495.39C533.062 495.25 532.962 495.13 532.832 495.1 532.792 495.08 532.752 495.07 532.712 495.07 532.642 495.07 532.562 495.1 532.512 495.15L532.472 495.19C532.092 495.57 531.582 495.78 531.042 495.78 530.502 495.78 529.992 495.57 529.612 495.19 528.822 494.4 528.822 493.12 529.612 492.33L529.642 492.3C529.732 492.21 529.752 492.08 529.702 491.96 529.652 491.85 529.552 491.78 529.432 491.78L529.322 491.78C528.202 491.78 527.302 490.87 527.302 489.76 527.302 488.65 528.212 487.74 529.322 487.74L529.362 487.74C529.502 487.73 529.622 487.63 529.652 487.5 529.702 487.39 529.682 487.26 529.602 487.18L529.562 487.14C529.182 486.76 528.972 486.25 528.972 485.71 528.972 485.17 529.182 484.66 529.562 484.28 529.942 483.9 530.452 483.69 530.992 483.69 531.532 483.69 532.042 483.9 532.422 484.28L532.452 484.31C532.542 484.4 532.672 484.42 532.782 484.37 532.812 484.36 532.852 484.34 532.882 484.33L532.902 484.32 532.952 484.28C532.982 484.24 533.002 484.2 533.012 484.16L533.022 484.09 533.022 483.98C533.042 482.86 533.972 481.98 535.092 482 536.172 482.02 537.042 482.9 537.072 483.98L537.072 484.03C537.072 484.15 537.152 484.26 537.262 484.31 537.302 484.33 537.342 484.34 537.382 484.34 537.452 484.34 537.532 484.31 537.582 484.26L537.622 484.22C538.412 483.43 539.692 483.43 540.482 484.22 540.862 484.6 541.072 485.11 541.072 485.65 541.072 486.19 540.862 486.7 540.482 487.08L540.452 487.11C540.362 487.2 540.342 487.33 540.392 487.44 540.402 487.47 540.422 487.51 540.422 487.54L540.422 487.56 540.472 487.61C540.512 487.64 540.552 487.66 540.592 487.67L540.662 487.68 540.772 487.68C541.892 487.7 542.772 488.63 542.752 489.75 542.732 490.83 541.852 491.7 540.772 491.73L540.712 491.73C540.542 491.73 540.402 491.88 540.412 492.05 540.412 492.12 540.442 492.19 540.492 492.25L540.532 492.29C541.322 493.08 541.322 494.36 540.532 495.15 539.742 495.94 538.462 495.94 537.672 495.15L537.642 495.12C537.582 495.07 537.512 495.04 537.432 495.04 537.392 495.04 537.342 495.05 537.302 495.07 537.192 495.12 537.122 495.22 537.122 495.34L537.122 495.45C537.102 496.57 536.172 497.45 535.052 497.43 533.962 497.39 533.092 496.52 533.072 495.43L533.072 495.43ZM533.392 493.71C534.092 493.97 534.562 494.63 534.572 495.37L534.572 495.43C534.572 495.72 534.802 495.95 535.092 495.95 535.382 495.95 535.612 495.72 535.612 495.43L535.612 495.32C535.622 494.32 536.432 493.52 537.432 493.52 537.902 493.52 538.352 493.71 538.692 494.04L538.732 494.08C538.832 494.18 538.962 494.23 539.102 494.23 539.242 494.23 539.372 494.17 539.472 494.08 539.672 493.88 539.682 493.55 539.472 493.34 539.472 493.34 539.472 493.34 539.472 493.34L539.432 493.3C538.732 492.58 538.752 491.44 539.462 490.74 539.802 490.41 540.242 490.23 540.712 490.23L540.772 490.23C541.062 490.23 541.292 490 541.292 489.71 541.292 489.42 541.062 489.19 540.772 489.19L540.662 489.19C539.942 489.19 539.302 488.76 539.012 488.1 539.002 488.07 538.992 488.03 538.982 488L538.962 487.91C538.762 487.32 538.882 486.66 539.282 486.18L539.382 486.06 539.422 486.02C539.622 485.82 539.622 485.48 539.422 485.28 539.422 485.28 539.422 485.28 539.422 485.28 539.222 485.08 538.882 485.08 538.682 485.28L538.642 485.32C538.302 485.65 537.852 485.83 537.382 485.83 537.132 485.83 536.892 485.78 536.662 485.68 536.002 485.4 535.572 484.75 535.572 484.03L535.572 483.97C535.572 483.68 535.342 483.45 535.052 483.45 534.762 483.45 534.532 483.68 534.532 483.97L534.532 484.08C534.532 484.8 534.102 485.44 533.442 485.73 533.412 485.74 533.372 485.75 533.342 485.76L533.252 485.78C532.662 485.98 532.002 485.87 531.522 485.47L531.402 485.36 531.362 485.32C531.162 485.12 530.832 485.11 530.622 485.32 530.622 485.32 530.622 485.32 530.622 485.32 530.422 485.52 530.422 485.86 530.622 486.06L530.662 486.1C531.172 486.61 531.322 487.38 531.042 488.04 530.782 488.74 530.122 489.21 529.372 489.22L529.312 489.22C529.022 489.22 528.792 489.45 528.792 489.74 528.792 490.03 529.022 490.26 529.312 490.26L529.422 490.26C530.422 490.27 531.222 491.08 531.222 492.08 531.222 492.55 531.032 493 530.702 493.34L530.662 493.38C530.462 493.58 530.452 493.91 530.662 494.12 530.662 494.12 530.662 494.12 530.662 494.12 530.862 494.32 531.192 494.33 531.402 494.12 531.402 494.12 531.402 494.12 531.402 494.12L531.442 494.08C531.782 493.75 532.232 493.56 532.712 493.56 532.942 493.57 533.172 493.62 533.392 493.71ZM532.292 489.71C532.292 488.19 533.522 486.96 535.032 486.95 536.552 486.95 537.782 488.18 537.782 489.69 537.782 491.2 536.552 492.44 535.042 492.45 535.042 492.45 535.042 492.45 535.042 492.45 533.522 492.45 532.292 491.22 532.292 489.71L532.292 489.71ZM533.792 489.71C533.792 490.4 534.352 490.96 535.042 490.95 535.732 490.95 536.292 490.39 536.282 489.69 536.282 489 535.722 488.45 535.032 488.45 534.352 488.46 533.792 489.02 533.792 489.71L533.792 489.71Z" fill="#AF8E00" fill-rule="evenodd"/></g></svg>',"steam_turbine.svg"),
  ( "a217617a6b304a38b493e0fb4bf26b30","Pump Turbine","Turbinación bombeo","#007cf9",'<svg width="29" height="29" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" overflow="hidden"><defs><clipPath id="clip0"><rect x="515" y="597" width="29" height="29"/></clipPath></defs><g clip-path="url(#clip0)" transform="translate(-515 -597)"><path d="M521.25 625.46C517.82 625.48 515.03 622.72 515 619.29 515 615.97 516.9 611.59 520.64 606.28L521.25 605.41 522.16 606.7C525.7 611.82 527.5 616.06 527.5 619.29 527.48 622.72 524.68 625.48 521.25 625.46ZM521.25 608.03 521.04 608.35C518.97 611.46 516.5 615.88 516.5 619.3 516.53 621.9 518.65 623.99 521.25 623.97 523.85 623.99 525.97 621.9 526 619.3 526 615.88 523.53 611.46 521.46 608.35L521.25 608.03ZM535.8 613.46C534.68 613.46 533.78 612.55 533.78 611.44L533.78 611.4C533.77 611.26 533.67 611.14 533.54 611.11 533.5 611.09 533.46 611.08 533.42 611.08 533.35 611.08 533.27 611.11 533.22 611.16L533.18 611.2C532.8 611.58 532.29 611.79 531.75 611.79 531.21 611.79 530.7 611.58 530.32 611.2 529.53 610.41 529.53 609.13 530.32 608.34L530.35 608.31C530.44 608.22 530.46 608.09 530.41 607.97 530.36 607.86 530.26 607.79 530.14 607.79L530.03 607.79C528.91 607.79 528.01 606.88 528.01 605.77 528.01 604.66 528.92 603.75 530.03 603.75L530.07 603.75C530.21 603.74 530.33 603.64 530.36 603.51 530.41 603.4 530.39 603.27 530.31 603.18L530.27 603.14C529.89 602.76 529.68 602.25 529.68 601.71 529.68 601.17 529.89 600.66 530.27 600.28 530.65 599.9 531.16 599.69 531.7 599.69 532.24 599.69 532.75 599.9 533.13 600.28L533.16 600.31C533.22 600.37 533.29 600.4 533.37 600.4 533.41 600.4 533.45 600.39 533.49 600.37 533.52 600.36 533.56 600.34 533.59 600.34L533.61 600.33 533.66 600.28C533.69 600.25 533.71 600.2 533.72 600.16L533.73 600.09 533.73 599.98C533.75 598.86 534.68 597.98 535.8 598 536.88 598.02 537.75 598.9 537.78 599.98L537.78 600.03C537.78 600.15 537.86 600.26 537.97 600.31 538.01 600.33 538.05 600.34 538.09 600.34 538.16 600.34 538.24 600.31 538.29 600.26L538.33 600.22C539.12 599.43 540.4 599.44 541.19 600.23 541.57 600.61 541.78 601.12 541.78 601.65 541.78 602.19 541.57 602.7 541.19 603.08L541.16 603.11C541.07 603.2 541.05 603.33 541.1 603.44 541.11 603.47 541.13 603.51 541.13 603.54L541.13 603.56 541.18 603.61C541.22 603.64 541.26 603.66 541.3 603.67L541.37 603.68 541.48 603.68C542.6 603.7 543.48 604.63 543.46 605.75 543.44 606.83 542.56 607.7 541.48 607.73L541.42 607.73C541.25 607.73 541.11 607.88 541.12 608.05 541.12 608.12 541.15 608.19 541.2 608.25L541.24 608.29C542.03 609.08 542.03 610.36 541.24 611.15 540.45 611.94 539.17 611.94 538.38 611.15L538.35 611.12C538.29 611.07 538.22 611.04 538.14 611.04 538.09 611.04 538.05 611.05 538.01 611.07 537.9 611.12 537.83 611.22 537.83 611.34L537.83 611.45C537.82 612.56 536.92 613.46 535.8 613.46ZM533.43 609.58C533.66 609.58 533.89 609.63 534.1 609.72 534.8 609.98 535.27 610.64 535.28 611.38L535.28 611.44C535.28 611.73 535.51 611.96 535.8 611.96 536.09 611.96 536.32 611.73 536.32 611.44L536.32 611.33C536.32 610.33 537.14 609.53 538.13 609.53 538.6 609.53 539.06 609.72 539.39 610.05L539.43 610.09C539.53 610.19 539.66 610.24 539.8 610.24 539.94 610.24 540.07 610.18 540.17 610.09 540.37 609.89 540.38 609.56 540.17 609.35 540.17 609.35 540.17 609.35 540.17 609.35L540.13 609.31C539.43 608.59 539.45 607.45 540.16 606.75 540.49 606.42 540.94 606.24 541.41 606.24L541.47 606.24C541.76 606.24 541.99 606.01 541.99 605.72 541.99 605.43 541.76 605.2 541.47 605.2L541.36 605.2C540.64 605.2 540 604.77 539.71 604.11 539.7 604.08 539.69 604.04 539.68 604.01L539.66 603.92C539.46 603.33 539.58 602.67 539.98 602.19L540.08 602.07 540.12 602.03C540.32 601.83 540.32 601.49 540.12 601.29 539.92 601.09 539.58 601.09 539.38 601.29L539.34 601.33C538.62 602.03 537.48 602.01 536.78 601.3 536.45 600.97 536.27 600.52 536.27 600.05L536.27 599.99C536.27 599.7 536.04 599.47 535.75 599.47 535.46 599.47 535.23 599.7 535.23 599.99L535.23 600.1C535.23 600.82 534.8 601.46 534.14 601.75 534.11 601.76 534.07 601.78 534.04 601.78L533.95 601.8C533.36 602 532.7 601.89 532.22 601.49L532.11 601.38 532.07 601.34C531.97 601.24 531.84 601.19 531.7 601.19 531.41 601.19 531.18 601.42 531.18 601.71 531.18 601.85 531.24 601.98 531.33 602.08L531.37 602.12C531.88 602.63 532.03 603.4 531.75 604.06 531.49 604.76 530.83 605.23 530.08 605.24L530.02 605.24C529.73 605.24 529.5 605.47 529.5 605.76 529.5 606.05 529.73 606.28 530.02 606.28L530.13 606.28C531.13 606.29 531.93 607.1 531.93 608.1 531.93 608.57 531.74 609.02 531.41 609.36L531.37 609.4C531.17 609.6 531.16 609.93 531.37 610.14 531.37 610.14 531.37 610.14 531.37 610.14 531.57 610.34 531.9 610.35 532.11 610.14 532.11 610.14 532.11 610.14 532.11 610.14L532.15 610.1C532.5 609.77 532.96 609.58 533.43 609.58L533.43 609.58ZM535.75 608.46C534.23 608.46 533 607.23 533 605.71 533 604.19 534.23 602.96 535.75 602.96 537.27 602.96 538.5 604.19 538.5 605.71 538.5 607.23 537.27 608.46 535.75 608.46ZM535.75 604.46C535.06 604.46 534.5 605.02 534.5 605.71 534.5 606.4 535.06 606.96 535.75 606.96 536.44 606.96 537 606.4 537 605.71 537 605.02 536.45 604.46 535.75 604.46Z" fill="#007CF9" fill-rule="evenodd"/></g></svg>',"pump_turbine.svg"),
  ( "7f31cad94e284146b14483f396d1ed56","Electric Car","Coche Eléctrico","#006698",'<svg width="102" height="95" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" overflow="hidden"><defs><clipPath id="clip0"><rect x="614" y="528" width="102" height="95"/></clipPath></defs><g clip-path="url(#clip0)" transform="translate(-614 -528)"><path d="M632.956 606.012C630.411 605.814 628.203 607.975 628.011 610.837 627.835 613.699 629.755 616.183 632.299 616.399 632.411 616.417 632.523 616.417 632.635 616.417 635.195 616.417 637.259 614.095 637.259 611.215 637.259 608.478 635.371 606.211 632.956 606.012ZM634.044 611.323C634.028 611.755 633.851 612.133 633.563 612.421 633.275 612.708 632.907 612.835 632.523 612.817 631.739 612.763 631.147 611.989 631.195 611.107 631.243 610.26 631.867 609.613 632.619 609.613L632.715 609.613C633.515 609.667 634.107 610.423 634.044 611.323 634.059 611.323 634.059 611.323 634.044 611.323L634.044 611.323Z" fill="#006698" fill-rule="evenodd"/><path d="M686.575 606.012C683.713 605.814 681.228 607.975 681.012 610.837 680.814 613.699 682.975 616.183 685.837 616.399 685.963 616.417 686.089 616.417 686.215 616.417 689.095 616.417 691.417 614.095 691.417 611.215 691.417 608.478 689.293 606.211 686.575 606.012ZM687.799 611.323C687.781 611.755 687.582 612.133 687.258 612.421 686.935 612.708 686.521 612.835 686.089 612.817 685.207 612.763 684.541 611.989 684.594 611.107 684.649 610.26 685.35 609.613 686.197 609.613L686.305 609.613C687.205 609.667 687.871 610.423 687.799 611.323 687.816 611.323 687.816 611.323 687.799 611.323L687.799 611.323Z" fill="#006698" fill-rule="evenodd"/><path d="M654.667 599.001 661.333 599.001C662.25 599.001 663 598.325 663 597.5 663 596.675 662.25 596 661.333 596L654.667 596C653.75 596 653 596.675 653 597.5 653 598.325 653.75 599.001 654.667 599.001Z" fill="#006698" fill-rule="evenodd"/><path d="M625.358 529.331C624.654 528.781 623.646 528.932 623.119 529.665L623.119 529.665 618.318 536.332C617.79 537.065 617.934 538.115 618.638 538.665 618.91 538.882 619.246 538.999 619.598 538.999L621.198 538.999 618.318 542.999C617.79 543.732 617.934 544.782 618.638 545.333 619.342 545.882 620.351 545.733 620.878 544.999 620.878 544.999 620.878 544.999 620.878 544.999L625.679 538.332C626.207 537.598 626.063 536.548 625.358 535.999 625.087 535.782 624.75 535.665 624.399 535.665L622.798 535.665 625.679 531.665C626.223 530.932 626.079 529.882 625.358 529.331L625.358 529.331Z" fill="#006698" fill-rule="evenodd"/><path d="M688.926 556 647.549 556C646.707 550.267 641.758 546 635.9 546L625.8 546C624.875 546 624.117 546.75 624.117 547.667L624.117 551 614.017 551 614.017 554.333 624.117 554.333 624.117 561 614.017 561 614.017 564.334 624.117 564.334 624.117 567.667C624.117 568.584 624.875 569.333 625.8 569.333L635.9 569.333C641.758 569.333 646.707 565.067 647.549 559.333L688.926 559.333C701.45 559.317 711.634 569.35 711.651 581.767 711.668 587.784 709.244 593.55 704.918 597.784L704.918 594.35C704.918 593.9 704.732 593.484 704.429 593.167L701.871 590.633C692.899 581.7 680.829 576.5 668.12 576.05 668.053 576.034 667.968 576.017 667.884 576 667.817 576 667.766 576.017 667.699 576.034 667.194 576.017 666.705 576 666.2 576 653.845 576 641.927 580.484 632.702 588.6L631.675 589.5 622.4 592.25C617.401 593.717 613.983 598.267 614 603.434L614 611C614 611.917 614.758 612.667 615.683 612.667L620.868 612.667C621.794 619.034 627.753 623.451 634.183 622.551 639.351 621.817 643.425 617.801 644.165 612.667L674.735 612.667C675.661 619.034 681.62 623.451 688.05 622.551 693.219 621.817 697.292 617.801 698.032 612.667L703.217 612.667C704.143 612.667 704.901 611.917 704.901 611L704.901 602.2C716.28 593.467 718.351 577.267 709.547 566 704.615 559.684 697.006 556 688.926 556ZM635.9 566 627.484 566 627.484 549.333 635.9 549.333C640.546 549.333 644.317 553.067 644.317 557.667 644.317 562.267 640.563 566 635.9 566ZM666.2 589.334 637.096 589.334C645.378 582.85 655.629 579.334 666.2 579.334L666.2 589.334ZM669.567 579.467C676.839 579.95 683.91 582.134 690.172 585.817L684.246 589.334 669.567 589.334 669.567 579.467ZM617.384 603.45C617.367 599.767 619.808 596.517 623.376 595.467L632.786 592.684 666.2 592.684 666.2 609.35 644.199 609.35C644.182 609.217 644.148 609.101 644.132 608.967 644.098 608.801 644.081 608.65 644.047 608.484 643.997 608.267 643.947 608.067 643.879 607.867 643.829 607.717 643.795 607.567 643.745 607.417 643.677 607.2 643.593 607 643.509 606.784 643.459 606.651 643.408 606.517 643.358 606.384 643.257 606.15 643.139 605.917 643.021 605.701 642.971 605.601 642.92 605.501 642.87 605.401 642.701 605.084 642.499 604.784 642.297 604.483 642.247 604.417 642.196 604.334 642.129 604.267 641.977 604.051 641.809 603.834 641.64 603.617 641.556 603.517 641.455 603.417 641.371 603.317 641.219 603.15 641.068 602.984 640.917 602.817 640.815 602.717 640.698 602.617 640.597 602.501 640.445 602.35 640.294 602.217 640.126 602.084 640.008 601.984 639.89 601.884 639.755 601.8 639.587 601.667 639.419 601.55 639.25 601.434 639.116 601.351 638.998 601.251 638.863 601.167 638.695 601.051 638.509 600.951 638.341 600.851 638.206 600.767 638.055 600.7 637.92 600.617 637.735 600.517 637.55 600.434 637.365 600.35 637.214 600.284 637.079 600.217 636.927 600.167 636.726 600.084 636.523 600.017 636.321 599.95 636.17 599.901 636.035 599.85 635.884 599.801 635.665 599.733 635.446 599.684 635.227 599.633 635.075 599.601 634.941 599.567 634.789 599.533 634.537 599.484 634.301 599.45 634.032 599.417 633.914 599.401 633.78 599.384 633.662 599.367 633.308 599.333 632.921 599.317 632.534 599.317 632.146 599.317 631.759 599.333 631.389 599.367 631.254 599.384 631.136 599.401 631.019 599.417 630.766 599.45 630.514 599.484 630.261 599.533 630.11 599.567 629.975 599.601 629.824 599.633 629.605 599.684 629.386 599.733 629.167 599.801 629.015 599.85 628.881 599.901 628.729 599.95 628.527 600.017 628.325 600.084 628.123 600.167 627.972 600.234 627.837 600.284 627.686 600.35 627.501 600.434 627.316 600.517 627.13 600.617 626.996 600.684 626.844 600.767 626.709 600.851 626.524 600.951 626.356 601.051 626.187 601.167 626.053 601.251 625.918 601.334 625.8 601.434 625.632 601.55 625.463 601.684 625.295 601.8 625.177 601.901 625.043 601.984 624.925 602.084 624.757 602.217 624.605 602.367 624.454 602.501 624.336 602.601 624.235 602.701 624.134 602.801 623.982 602.967 623.831 603.134 623.679 603.3 623.595 603.4 623.494 603.5 623.41 603.6 623.242 603.817 623.073 604.034 622.922 604.251 622.871 604.317 622.804 604.383 622.753 604.467 622.551 604.767 622.366 605.067 622.181 605.384 622.13 605.484 622.08 605.584 622.029 605.684 621.912 605.917 621.794 606.133 621.693 606.367 621.643 606.5 621.592 606.634 621.542 606.767 621.457 606.984 621.373 607.183 621.306 607.4 621.256 607.551 621.222 607.7 621.171 607.85 621.121 608.05 621.054 608.267 621.003 608.467 620.969 608.617 620.936 608.784 620.919 608.95 620.902 609.084 620.868 609.201 620.852 609.334L617.384 609.334 617.384 603.45ZM632.534 619.334C627.888 619.334 624.117 615.6 624.117 611 624.117 606.4 627.888 602.667 632.534 602.667 637.18 602.667 640.95 606.4 640.95 611 640.95 615.6 637.18 619.334 632.534 619.334ZM686.401 619.334C681.754 619.334 677.984 615.6 677.984 611 677.984 606.4 681.754 602.667 686.401 602.667 691.046 602.667 694.817 606.4 694.817 611 694.817 615.6 691.046 619.334 686.401 619.334ZM701.551 609.334 698.066 609.334C698.049 609.201 698.016 609.084 697.999 608.95 697.965 608.784 697.948 608.634 697.915 608.467 697.864 608.25 697.814 608.05 697.746 607.85 697.696 607.7 697.662 607.551 697.612 607.4 697.544 607.183 697.46 606.984 697.376 606.767 697.325 606.634 697.275 606.5 697.224 606.367 697.123 606.133 697.006 605.901 696.888 605.684 696.837 605.584 696.787 605.484 696.736 605.384 696.568 605.067 696.366 604.767 696.164 604.467 696.114 604.4 696.063 604.317 696.013 604.251 695.861 604.034 695.693 603.817 695.525 603.6 695.44 603.5 695.339 603.4 695.255 603.3 695.104 603.134 694.952 602.967 694.8 602.801 694.699 602.701 694.582 602.601 694.481 602.484 694.329 602.334 694.177 602.2 694.009 602.067 693.891 601.967 693.774 601.867 693.639 601.783 693.471 601.65 693.303 601.534 693.134 601.417 693 601.334 692.882 601.234 692.747 601.151 692.579 601.034 692.394 600.934 692.225 600.834 692.09 600.75 691.939 600.684 691.804 600.6 691.619 600.5 691.434 600.417 691.249 600.334 691.097 600.267 690.962 600.2 690.811 600.15 690.609 600.067 690.407 600 690.205 599.933 690.054 599.884 689.919 599.834 689.768 599.784 689.549 599.717 689.33 599.667 689.111 599.617 688.959 599.584 688.825 599.55 688.673 599.517 688.421 599.467 688.185 599.433 687.915 599.401 687.798 599.384 687.663 599.367 687.545 599.35 687.192 599.317 686.805 599.301 686.418 599.301 686.03 599.301 685.643 599.317 685.273 599.35 685.138 599.367 685.02 599.384 684.902 599.401 684.65 599.433 684.397 599.467 684.145 599.517 683.994 599.55 683.859 599.584 683.708 599.617 683.489 599.667 683.27 599.717 683.051 599.784 682.899 599.834 682.765 599.884 682.613 599.933 682.411 600 682.209 600.067 682.007 600.15 681.855 600.217 681.721 600.267 681.569 600.334 681.384 600.417 681.199 600.5 681.014 600.6 680.88 600.667 680.728 600.75 680.593 600.834 680.408 600.934 680.24 601.034 680.071 601.151 679.937 601.234 679.802 601.317 679.684 601.417 679.516 601.534 679.347 601.667 679.179 601.783 679.061 601.884 678.926 601.967 678.809 602.067 678.64 602.2 678.489 602.35 678.337 602.484 678.219 602.584 678.119 602.684 678.018 602.784 677.866 602.95 677.715 603.117 677.563 603.284 677.479 603.384 677.378 603.484 677.294 603.584 677.126 603.8 676.957 604.017 676.806 604.234 676.755 604.3 676.688 604.367 676.637 604.451 676.435 604.75 676.25 605.05 676.065 605.367 676.014 605.467 675.964 605.567 675.913 605.667 675.795 605.901 675.678 606.117 675.577 606.35 675.526 606.484 675.476 606.617 675.425 606.751 675.341 606.967 675.257 607.167 675.189 607.383 675.139 607.534 675.105 607.684 675.055 607.834 675.004 608.034 674.937 608.25 674.887 608.45 674.853 608.601 674.819 608.767 674.802 608.933 674.786 609.067 674.752 609.184 674.735 609.317L669.584 609.317 669.584 592.65 684.734 592.65C685.037 592.65 685.34 592.567 685.609 592.417L693.336 587.817C695.541 589.35 697.595 591.067 699.514 592.95L701.584 595 701.584 609.334Z" fill="#006698" fill-rule="evenodd"/></g></svg>',"electric_car.svg"),
  ( "62e61ac6e8c345dd8f14309d2f4572e1","Flame","Llama","#BA0F16",'<svg version="1.1" id="Capa_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 611.999 611.999" style="enable-background:new 0 0 611.999 611.999;" xml:space="preserve"><g><path  d="M216.02,611.195c5.978,3.178,12.284-3.704,8.624-9.4c-19.866-30.919-38.678-82.947-8.706-149.952 c49.982-111.737,80.396-169.609,80.396-169.609s16.177,67.536,60.029,127.585c42.205,57.793,65.306,130.478,28.064,191.029 c-3.495,5.683,2.668,12.388,8.607,9.349c46.1-23.582,97.806-70.885,103.64-165.017c2.151-28.764-1.075-69.034-17.206-119.851 c-20.741-64.406-46.239-94.459-60.992-107.365c-4.413-3.861-11.276-0.439-10.914,5.413c4.299,69.494-21.845,87.129-36.726,47.386 c-5.943-15.874-9.409-43.33-9.409-76.766c0-55.665-16.15-112.967-51.755-159.531c-9.259-12.109-20.093-23.424-32.523-33.073 c-4.5-3.494-11.023,0.018-10.611,5.7c2.734,37.736,0.257,145.885-94.624,275.089c-86.029,119.851-52.693,211.896-40.864,236.826 C153.666,566.767,185.212,594.814,216.02,611.195z" fill="#BA0F16"/></g></svg>',"flame.svg"),
  ( "9d84eceb0c15458c8b44942e1f8d705e","Hydrogen","Hidrógeno","#9DC41A",'<svg width="512px" height="512px" viewBox="-32 0 512 512" xmlns="http://www.w3.org/2000/svg"><path d="M448 80v352c0 26.51-21.49 48-48 48H48c-26.51 0-48-21.49-48-48V80c0-26.51 21.49-48 48-48h352c26.51 0 48 21.49 48 48zm-112 48h-32c-8.837 0-16 7.163-16 16v80H160v-80c0-8.837-7.163-16-16-16h-32c-8.837 0-16 7.163-16 16v224c0 8.837 7.163 16 16 16h32c8.837 0 16-7.163 16-16v-80h128v80c0 8.837 7.163 16 16 16h32c8.837 0 16-7.163 16-16V144c0-8.837-7.163-16-16-16z" fill="#9DC41A"/></svg>',"hydrogen.svg"),
  ( "139ecde75085421dbdacc94c4e93c499","Demand","Demanda","#666666",'<svg width="44" height="51" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" overflow="hidden"><defs><clipPath id="clip0"><rect x="112" y="134" width="44" height="51"/></clipPath></defs><g clip-path="url(#clip0)" transform="translate(-112 -134)"><path d="M144.429 135C143.719 135 143 135.076 142.29 135.225 139.488 135.76 137.1 137.419 135.545 139.83 133 143.737 133.157 148.716 135.854 152.466L135.597 158.249C135.597 158.514 135.749 158.73 135.959 158.834 136.063 158.888 136.22 158.995 136.32 158.995 136.477 158.995 136.529 158.995 136.634 158.888L141.719 156.482C142.599 156.747 143.532 156.855 144.364 156.855 147.789 156.855 151.109 155.088 153.131 151.931 154.22 150.267 154.791 148.342 154.895 146.305 155 145.932 154.739 145.613 154.377 145.613 153.963 145.613 153.649 145.932 153.649 146.256 153.545 148.019 153.078 149.682 152.094 151.126 150.346 153.811 147.488 155.344 144.46 155.344 143.623 155.344 142.769 155.227 141.924 154.98 141.832 154.935 141.749 154.908 141.671 154.908 141.58 154.908 141.492 154.944 141.405 155.034L137.153 157.12 137.362 152.304C137.362 152.088 137.309 151.931 137.257 151.823 134.765 148.608 134.56 144.111 136.791 140.63 138.137 138.544 140.211 137.1 142.599 136.614 143.214 136.493 143.828 136.435 144.434 136.435 146.237 136.435 147.985 136.965 149.501 138.008 151.418 139.349 152.717 141.381 153.34 143.63 153.383 143.985 153.636 144.192 153.963 144.192 154.028 144.192 154.098 144.183 154.168 144.165 154.534 144.111 154.739 143.737 154.686 143.31 154.011 140.63 152.455 138.382 150.277 136.83 148.538 135.634 146.508 135 144.429 135Z" fill="#666666" fill-rule="evenodd"/><path d="M117.941 145.388C118.251 145.388 118.513 145.55 118.718 145.711 118.928 145.926 119.032 146.244 119.032 146.508L119.032 153.285 116.745 153.285 116.745 146.508C116.798 145.926 117.265 145.388 117.941 145.388ZM128.906 145.388C129.268 145.388 129.53 145.55 129.687 145.711 129.893 145.926 130.05 146.244 130.05 146.508L130.05 153.285 127.762 153.285 127.762 146.508C127.815 145.926 128.334 145.388 128.906 145.388ZM132.442 154.776 132.442 157.069 114.353 157.069 114.353 154.776ZM126.047 168.692 126.047 170.774 120.8 170.774 120.8 168.692ZM125.423 172.212 125.423 174.241 121.424 174.241 121.424 172.212ZM117.941 144.004C116.483 144.004 115.392 145.178 115.392 146.562L115.392 153.334 113.729 153.334C113.314 153.334 113.004 153.656 113.004 154.028L113.004 157.71C113.004 158.135 113.314 158.453 113.729 158.453L113.886 158.453 113.886 161.122C113.886 161.23 113.991 161.44 114.043 161.602L116.173 164.32C116.317 164.495 116.523 164.576 116.723 164.576 116.885 164.576 117.042 164.522 117.16 164.428 117.474 164.159 117.474 163.734 117.265 163.469L115.292 160.907 115.292 158.507 131.503 158.507 131.503 160.907 126.462 167.361 120.381 167.361 119.238 165.865C119.19 165.709 119.085 165.655 119.032 165.601 118.897 165.485 118.731 165.431 118.574 165.431 118.365 165.431 118.164 165.525 118.046 165.709 117.889 165.973 117.889 166.295 118.046 166.56L119.499 168.374 119.499 171.571C119.499 172.001 119.809 172.266 120.124 172.319L120.124 175.092C120.124 175.517 120.486 175.84 120.853 175.84L121.005 175.84 121.005 183.252C121.005 183.678 121.32 184 121.682 184L125.423 184C125.789 184 126.099 183.678 126.099 183.252L126.099 180.48C126.099 180.054 125.789 179.732 125.423 179.732 125.008 179.732 124.698 180.054 124.698 180.48L124.698 182.504 122.411 182.504 122.411 175.84 124.698 175.84 124.698 177.6C124.698 177.972 125.008 178.348 125.423 178.348 125.789 178.348 126.099 177.972 126.099 177.6L126.099 175.84 126.256 175.84C126.619 175.84 126.981 175.517 126.981 175.145L126.981 172.319C127.348 172.319 127.605 172.001 127.605 171.571L127.605 168.374 132.961 161.655C133.066 161.494 133.066 161.387 133.066 161.176L133.066 158.507 133.271 158.507C133.633 158.507 134 158.189 134 157.763L134 154.135C133.843 153.656 133.533 153.334 133.166 153.334L131.451 153.334 131.451 146.616C131.451 145.926 131.193 145.285 130.726 144.699 130.259 144.269 129.635 144.004 128.906 144.004 127.505 144.004 126.361 145.178 126.361 146.562L126.361 153.334 120.486 153.334 120.486 146.562C120.486 145.926 120.228 145.232 119.761 144.699 119.29 144.269 118.666 144.004 117.941 144.004Z" fill="#666666" fill-rule="evenodd"/><path d="M119.717 159C119.361 159 119 159.431 119 160 119 160.497 119.361 160.994 119.717 160.994L127.283 160.994C127.639 160.994 128 160.497 128 160 128 159.431 127.639 159 127.283 159Z" fill="#666666" fill-rule="evenodd"/><path d="M145.979 139.501 143.477 142.871C143.373 143.086 143.32 143.405 143.425 143.621 143.582 143.886 143.84 144.048 144.103 144.048L146.757 144.048 142.905 148.649 144.103 145.975C144.208 145.76 144.155 145.49 144.05 145.279 143.893 145.117 143.687 144.955 143.425 144.955L140.981 144.955 144.05 139.501ZM143.582 138.004C143.32 138.004 143.115 138.108 143.01 138.324L139.157 145.279C139 145.49 139 145.76 139.157 146.029 139.262 146.24 139.468 146.348 139.73 146.348L142.332 146.348 139.415 152.926C139.262 153.25 139.415 153.623 139.678 153.838 139.783 153.892 139.94 154 140.041 154 140.251 154 140.46 153.892 140.561 153.73L148.633 143.729C148.891 143.513 148.996 143.243 148.838 142.978 148.738 142.709 148.475 142.552 148.217 142.552L145.458 142.552 147.955 139.128C148.06 138.912 148.112 138.593 148.007 138.377 147.85 138.108 147.592 138.004 147.33 138.004Z" fill="#ffcc00" fill-rule="evenodd"/></g></svg>',"demand.svg");
/*!40000 ALTER TABLE `icons` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Table structure for table `loads`
--
DROP TABLE IF EXISTS `loads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `loads` (
  `id_load` varchar(32) NOT NULL,
  `id_model` varchar(32) NOT NULL,
  `action` tinyint(4) NOT NULL DEFAULT '0',
  `id_connectivity_node` varchar(32) NOT NULL,
  `name` varchar(256) DEFAULT NULL,
  `active` tinyint(4) DEFAULT '1',
  `p` float DEFAULT NULL,
  `q` float DEFAULT NULL,
  `id_load_type` varchar(32) DEFAULT NULL,
  `online_date` date DEFAULT NULL,
  `offline_date` date DEFAULT NULL,
  `secondary_id` varchar(48) DEFAULT NULL,
  `sequential` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`id_load`,`id_model`),
  KEY `idx_loads_load_type` (`id_load_type`),
  KEY `idx_loads_connectivity_node_model` (`id_connectivity_node`,`id_model`),
  -- CONSTRAINT `loads_ibfk_1` FOREIGN KEY (`id_connectivity_node`, `id_model`) REFERENCES `connectivity_nodes` (`id_connectivity_node`, `id_model`) ON DELETE CASCADE ON UPDATE NO ACTION,
  -- CONSTRAINT `loads_ibfk_2` FOREIGN KEY (`id_load_type`) REFERENCES `loads_types` (`id_load_type`)
  CONSTRAINT `fk_loads_connectivity_node` FOREIGN KEY (`id_connectivity_node`) REFERENCES `connectivity_nodes` (`id_connectivity_node`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_loads_load_type` FOREIGN KEY (`id_load_type`) REFERENCES `loads_types` (`id_load_type`),
  CONSTRAINT `fk_loads_model` FOREIGN KEY (`id_model`) REFERENCES `models` (`id_model`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;



--
-- Dumping data for table `loads`
--
LOCK TABLES `loads` WRITE;
/*!40000 ALTER TABLE `loads` DISABLE KEYS */;
INSERT INTO `loads` 
  (`id_load`, `id_model`, `action`, `id_connectivity_node`, `name`, `active`, `p`, `q`, `id_load_type`, `online_date`, `offline_date`, `secondary_id`, `sequential`) VALUES 
  ('3e579c116066406f9ef96aed9da21aff','1b8131ba1aa94f8ebc30be409968869e',1,'38b887c106e745f4b4a05ec7e3c3f343','L1',1,600,400,'f13875beaa584e42adaceb876f7f2bb1',NULL,NULL,NULL,1),
  ('a8a5732a54894eedb8e6b1ef2e1c883d','1b8131ba1aa94f8ebc30be409968869e',1,'d6b7ac3bea3f46198625677d88555bd1','L2',1,400,300,'f13875beaa584e42adaceb876f7f2bb1',NULL,NULL,NULL,1),
  ('b85cc7bd538d41dda8e9c26dc787beb4','d7399d82cc8a404c81fca5b54fc395e7',1,'9a23e5577d304b01abf5855a0973af0e','L3',1,20,15,'f13875beaa584e42adaceb876f7f2bb1',NULL,NULL,NULL,1);
/*!40000 ALTER TABLE `loads` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Table structure for table `loads_types`
--
DROP TABLE IF EXISTS `loads_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `loads_types` (
  `id_load_type` varchar(32) NOT NULL,
  `name` varchar(256) NOT NULL DEFAULT '""',
  PRIMARY KEY (`id_load_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;



--
-- Dumping data for table `loads_types`
--
LOCK TABLES `loads_types` WRITE;
/*!40000 ALTER TABLE `loads_types` DISABLE KEYS */;
INSERT INTO `loads_types` 
  (`id_load_type`, `name`) VALUES 
  ('f13875beaa584e42adaceb876f7f2bb1','Default');
/*!40000 ALTER TABLE `loads_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logs`
--
DROP TABLE IF EXISTS `logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `logs` (
  `idlogs` int(11) NOT NULL AUTO_INCREMENT,
  `userid` varchar(45) DEFAULT NULL,
  `table_name` varchar(45) DEFAULT NULL,
  `attribute` varchar(45) DEFAULT NULL,
  `old_value` varchar(45) DEFAULT NULL,
  `new_value` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idlogs`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Dumping data for table `logs`
--
LOCK TABLES `logs` WRITE;
/*!40000 ALTER TABLE `logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `logs` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Table structure for table `logs_usage`
--
DROP TABLE IF EXISTS `logs_usage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `logs_usage` (
  `log_id` varchar(32) NOT NULL,
  `user_id` varchar(64) NOT NULL,
  `function_name` varchar(256) NOT NULL,
  `execution_time` datetime NOT NULL,
  `attribute` varchar(64) NOT NULL,
  `attribute_id` varchar(32) NOT NULL,
  PRIMARY KEY (`log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Dumping data for table `logs_usage`
--
LOCK TABLES `logs_usage` WRITE;
/*!40000 ALTER TABLE `logs_usage` DISABLE KEYS */;
/*!40000 ALTER TABLE `logs_usage` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Table structure for table `models_groups`
--
DROP TABLE IF EXISTS `models_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `models_groups` (
  `id_model_group` varchar(32) NOT NULL,
  `name` varchar(256) NOT NULL DEFAULT '""',
  PRIMARY KEY (`id_model_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;



--
-- Dumping data for table `models_groups`
--
LOCK TABLES `models_groups` WRITE;
/*!40000 ALTER TABLE `models_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `models_groups` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Table structure for table `models_models`
--
DROP TABLE IF EXISTS `models_models`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `models_models` (
  `id_model_parent` varchar(32) NOT NULL,
  `id_model_child` varchar(32) NOT NULL,
  PRIMARY KEY (`id_model_parent`,`id_model_child`),
  KEY `idx_models_models_model_child` (`id_model_child`),
  CONSTRAINT `fk_models_models_model_child` FOREIGN KEY (`id_model_child`) REFERENCES `models` (`id_model`),
  CONSTRAINT `fk_models_models_model_parent` FOREIGN KEY (`id_model_parent`) REFERENCES `models` (`id_model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;



--
-- Dumping data for table `models_models`
--
LOCK TABLES `models_models` WRITE;
/*!40000 ALTER TABLE `models_models` DISABLE KEYS */;
INSERT INTO `models_models` 
  (`id_model_parent`,`id_model_child`) VALUES 
  ('1b8131ba1aa94f8ebc30be409968869e','d7399d82cc8a404c81fca5b54fc395e7'),
  ('d7399d82cc8a404c81fca5b54fc395e7','883376684f3e4dedbe831f6e6b2a1ab8');
/*!40000 ALTER TABLE `models_models` ENABLE KEYS */;
UNLOCK TABLES;



--
-- Table structure for table `models_models_groups`
--
DROP TABLE IF EXISTS `models_models_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `models_models_groups` (
  `id_model` varchar(32) NOT NULL,
  `action` tinyint(4) NOT NULL DEFAULT '0',
  `id_model_group` varchar(32) NOT NULL,
  PRIMARY KEY (`id_model`,`id_model_group`),
  KEY `idx_models_models_groups_model_group` (`id_model_group`),
  CONSTRAINT `fk_models_models_groups_model_group` FOREIGN KEY (`id_model_group`) REFERENCES `models_groups` (`id_model_group`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_models_models_groups_model` FOREIGN KEY (`id_model`) REFERENCES `models` (`id_model`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;



--
-- Dumping data for table `models_models_groups`
--
LOCK TABLES `models_models_groups` WRITE;
/*!40000 ALTER TABLE `models_models_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `models_models_groups` ENABLE KEYS */;
UNLOCK TABLES;



--
-- Table structure for table `owners`
--
DROP TABLE IF EXISTS `owners`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `owners` (
  `id_owner` varchar(32) NOT NULL,
  -- TODO: aqui si que sí añadiría id_model, esto puede crecer a demanda (por ejemplo para cada solicitante de propuesta de planificación)
  `name` varchar(256) NOT NULL,
  PRIMARY KEY (`id_owner`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Dumping data for table `owners`
--
LOCK TABLES `owners` WRITE;
/*!40000 ALTER TABLE `owners` DISABLE KEYS */;
INSERT INTO `owners` 
  (`id_owner`, `name`)  VALUES 
  ('00ee8062ed95481980e0443ca5343a61','Torresol'),
  ('014ab33249de466dad94b12af99a8aca','Sca Hygiene Paper España S.L.'),
  ('019cca69189440ee8fbae24ce489e4cc','Repsol Quimica'),
  ('0420065455fd403c9f2ae94ec66a885a','Bv Vilalba'),
  ('04540efe149d4be7a14d159d6d83de45','Enel Unión Fenosa Renovables'),
  ('07aa622fc6f04bf6bb4fc02d52e6e470','Energia Hidroelectrica de Navarra, S.A.'),
  ('09e0538c69c74fffbb6e3dc6c07eb3a9','No Aplica'),
  ('0a18a14d19db4116a4b6033126256880','Enher'),
  ('0b8118f709b9416f840d0223f35a11e9','Tecnalia'),
  ('0c01a3e722c64df99d12b5dd25df95f7','Desarrollo Eólico Del Ebro'),
  ('0d34a6ee90244fcd94085ac7e9f7ba58','Termosolar Palma S.A.etilla, S.L.'),
  ('0dd3825da5b54073b022797868a67b82','Molinos Del Ebro'),
  ('106449ff0cb246d6aeb3bc975d04c693','Ferroatlantica'),
  ('12bf0fedf2b244c8a28c852a660b1037','Bahia de Bizkaia Electricidad'),
  ('137c596215c74a9688739d142e968dda','Desarrollos Eolicos S.A.'),
  ('1b027e86047f4a6a9862ad984126f863','Eufer Renovables Ibericas 2004'),
  ('214c813c66e04555906b7b2aceb1c33e','Hidroelectrica de Ourol, S.L.'),
  ('24e1360f62bc47a99bf8367d5f121b76','Default'),
  ('2585dd0cfaea45c59cc8f402097051a1','Enerfin'),
  ('25cf86b96a144cf9ad6a1bcd858aff34','Genia'),
  ('2853982c86cb4678a76880e72b3a98f4','Berta Energías Renovables S.L.'),
  ('29cde79076da4153adc75f7ba3f504ca','Acerinox'),
  ('2a9b22eec4384043b6452d8092950a59','Parque Eólico Sierra de Las Carbas S.L.'),
  ('2b520f24a7cb44db8ea752096e2fcb7d','Ignis'),
  ('2bf182696c634b24a358785c7ce05418','Rsev'),
  ('2d33ef9508ee4a5684079fb7755e811a','Eolica de Medinaceli S.L.'),
  ('307c174962fc4c5b9826b7d88978e6a1','Erz'),
  ('36b26324457c41999a7673609e0b484b','R.T.E. (Reseau de Transport D´Electricite)'),
  ('372c7b2f2afa4a3783283a9511dce289','Acuasur'),
  ('37c4dc7d5e784a319123cf93886a4102','Aigües Ter Llobregat'),
  ('37daf138799d4d38ab45f0c3b99f9c5f','Asociacion Nuclear Asco Vandellos Ii, Aie'),
  ('382e8bffc637438fbd5a6a45e2334f42','Se Dro'),
  ('39695ba1c60c4e6f8d5e5df99dfde153','Arcelor'),
  ('3c9b1e58305c4b0a896fb916d8ff4a08','Emalsa'),
  ('3e759b2f670e4c88bfe4ef3e19047dd3','Ede'),
  ('3ebb117789fb47cd8e63d724ca7e100a','Cobre Las Cruces'),
  ('3f01eca805d34cce8e350044900d7451','Tramp'),
  ('40219c31e4af4f3c9c18e6c982c6903f','Termosolar Alvarado S.L.'),
  ('40756092a0614e23969b3909e0b6716c','Eolica Rubio'),
  ('40f5ecaf0c6545be9fa4ccde25867a18','Northeolic-Gea'),
  ('464b12fc766f4ac58debd66fe7d256e9','Extresol-3 S.L.'),
  ('4ccd1e653ddf4245adf3260d65b6ed33','Ch03'),
  ('4d1a0000786047bc8030914d100fdfd0','Desarrollos Eólicos Rabosera S.A.'),
  ('4f5673a955304ba0b4eb691eb871cf86','Arcelor-Zaragoza'),
  ('4f679d184f21474daf161bda2d65ebaa','Metro Barcelona'),
  ('4fe8fdae824a4fc1a20550b85e395ba1','Iberdrola Renovables'),
  ('516532d4d066453b8e5d76d5ce9350b1','Ifercat'),
  ('52305d326d9f4a0a92879c4d42cc6e5d','Cementos Alfa'),
  ('5489b398cad54919bdd731d12c7ec37c','Ts3'),
  ('55a37fc9d774429f96b22500022b24c8','Pe La Boga S.L.'),
  ('57c24d9d177e4b77814e0906c307a39e','Parque Eolico Rio Gallego, S.L.'),
  ('58660b8b657b4441af8d96bc870e0b29','Catalana Denrgías Renovables S.L.'),
  ('5b3a0b7d9adf4e6f94c664c2cc446c4c','Ansa'),
  ('5c33640bdd5742188ce28b6f39ca26e6','P T Tecnología Iber S.L.u'),
  ('5d53799bc38f44eab14d184074b7389b','Repsol Electricidad y Gas'),
  ('5dbc33e811d84a7faa72df14bb524abd','Aeropuertos Españoles y Navegacion Aerea'),
  ('61a9614a017c4317b2264c7a1520a680','Parque Eólico Belchite, S.L.'),
  ('61df3986539844f087ba9e68be57847e','Tubos Reunidos'),
  ('622b778603f243179d02d365d9227b84','Parques Eólicos de Cerrato, S.L'),
  ('62c2c96d25c3479f9fba36e6eaf320ca','R.E.N. '),
  ('62c44256458a41e98b18c7732981bf63','Iberenova Renovables'),
  ('6308469609a14f63b2325a001b40e077','Parque Eólico Cantales, S.L.'),
  ('6347dfe5856b4b22a322892c98bf2968','Egl'),
  ('6932624128d74e8fa66a114c83a2a677','Ts2'),
  ('6aff65a4907a481395318c143dda70ab','Renomar'),
  ('6cba05372a224a008b0e457dd85b6cbd','Fuerzas Electricas de Andorra'),
  ('6fd70badd13642519ba6bb2664a9c803','Adif'),
  ('709a1e26ebe341609c9295d67d23bb72','Compartido Varias Empresas'),
  ('76ec40d2103a42e3b56f7c26b0d5bd1b','Soluzia'),
  ('7a8ebad835034109bf71a3076a4dcbb6','Red Eléctrica de España'),
  ('7bcf03524f4f421c8d9dc103ad5c7a29','Vall de Soller'),
  ('7d8bd6a77ef34eedbbdcdf2babb9cd2b','Elcogas'),
  ('7dbe29fb07434471b370b6bd9acf52c4','Elecdey'),
  ('7e2acf4b31944ce4979f4ab026512a12','Aceriasa'),
  ('7e5662d247e64e7e95ae5dbbd133a5f5','Unión Fenosa Distribución'),
  ('80c0a5df7c884fd9b900f595c11f67ae','Global 3 Energia'),
  ('821a19468fbb45d5bf1b5ffd4e041303','Electra Castillejense'),
  ('84c956c384494142a4f1467453ff670b','Acampo Arias S.L'),
  ('856c0c9a7fac40e2beae260a9fa2adfa','Northeolic Sierra de Tineo S.L.'),
  ('879ea8b0002c41bea7b53d0890e030d9','Alcoa (Aluminio)'),
  ('87df56dd833540e1aff376c1f03b5572','Parque Eolico Finca de Mogan S.A.'),
  ('88d866bd40d649edacfb6d3e49e051c2','Fecsa'),
  ('890a6e34ca664967bee8b3e29c203048','Prom'),
  ('8a7561d2248845698cf77b7a421c1d9d','Productor Regional de Energía Renovable, S. A'),
  ('8f4b5344346d43e5a6b9866a807114bc','Hidroelectrica Del Cantábrico Distribución'),
  ('9292cee406d94dd9838c3080cc15139e','Esabr'),
  ('93e3ea87befb46279f02f03cc86bec94','Explotaciones Eólicas Aldehuelas'),
  ('93fc4001127241029b0d878e86ad7ac2','Gas Natural Fenosa'),
  ('93fc96c6858a4a57bc2327e1cf568ecd','Danta de Energias S.A.'),
  ('94e55eeaa96d4eaabc8047a4b024da8f','Graftech'),
  ('95b3638549d54bb4b25d5a72f16d61d4','O.N.E.'),
  ('967b3ec4834d4e6aa76987b62b96eed5','Tals'),
  ('97809404ae244345bd8894650e1e07cb','Naturgy'),
  ('99183888227c4004b60d5be30d72d150','Acuanorte'),
  ('99683ba9fc214fb0a281a7691b76bae3','Energías Eólicas de Cuenca'),
  ('9a1cdaf629df4f8bba7b6e374dd5c435','Reganosa'),
  ('9ae104fe2d7745408b9d94d9cdfba690','Frvls'),
  ('9aff7b8e3efb40ff808b01112f02126a','Iberdrola Renovables, S.A.U.'),
  ('9c52557d98684335b862458cb50ee83b','Iberdrola Distribucion'),
  ('9e79ebc288224bec903aacecdf85e05d','Iberdrola Renovables La Rioja, S.A.'),
  ('9f40b195bc27486aa4b6a292d34bebb3','Agencia Balear Del Agua y Calidad Ambiental (Abaqua)'),
  ('9fa1b939f0f74bfeaf25c75705be520c','Ence Energia'),
  ('a0b1680945164fbd80bb915eccd6c2f0','Atlantic Copper S.L.u'),
  ('a5fda7296bbc4962a519723c030951fb','Iberdrola Generacion'),
  ('a617a4fbd163486e99604eab118a1722','Edp-Renewables'),
  ('a664245d126e4dce9c4d346a54a566ec','Rea (Red Electrica Andina)'),
  ('a73557eb757b4b44b85413977e93e20a','Repsol'),
  ('a87cc65e7a9549c4a1e13151afda4feb','Unelco'),
  ('a95142166a174b10bb11ef3445889441','Zede Arcos'),
  ('ad8f873b9efc4fa886be5b24151ebf85','Iberdrola Energía Solar de Puertollano,S.A.'),
  ('af057ae4a6c84fbfb6f89ed2d4a62b89','Endesa Distribucion'),
  ('af5b8fad153f44098f4826bb73b59449','Desarollos Eólicos, S.A.'),
  ('b1517cf84faf4a219227d9bdbf3c5a1d','Productor Regional de Energía Renovable S.A.'),
  ('b2467f7fdbb14a1ba96e6070a388228e','Drago Renovables S.L.'),
  ('b62a202e59ad43218c30609804ec4d71','Enel Green Power España S.L.'),
  ('b7ffde47eecc4555b51c52819451bd72','Siderurgica Balboa'),
  ('b9a2f319bc4148bb90560401a55097e1','Aprovechamiento Energia Renovables Del Ebro S.L'),
  ('b9b8139353ab4c628ddb009069566611','Acciona Eolica Levante'),
  ('bb463c97f91d49f0ae78585125adbba6','Iberéolica Solar Olivenza,S.L.U.'),
  ('bbf322a5a07442c498307f399ee02a77','Viesgo Infraestructuras Energéticas S.L.'),
  ('bc229e4f33d14eb2a8852c3457e92404','Parque Eólico Magaz S.L.'),
  ('bce20657db89461ab8a963638531a49a','Elaw'),
  ('be2a732237de466297017cdacbf963fe','Mylsa'),
  ('be64f7ced6f74ce8a2bdfb7c5c692130','Cementos Especiales'),
  ('be696d03a4974296aa72e0dc871353c6','Parques Eolicos S.A.n Lorenzo S.L.u'),
  ('be84ce0fe29d4ef989bb19b9169ef5e0','Grupo Renovalia de Energía, S.L.'),
  ('bedef8027f0342e9a8243ee568855602','Fer2001 S.A'),
  ('c14312226b0a4af7b7b30638a16c5b68','Uninsa'),
  ('c19313f4c3e44fd5baf3c6aadbaf7603','Energías Renovables de Ricobayo S.A.'),
  ('c1b1b3c2fb564e4d85cee163612144e8','Celsa'),
  ('c32e884a1ff74b3a9699459b123fed3d','Gamesa'),
  ('c507e28a6c4c4f1eafe52dba7f573ecf','Sevillana'),
  ('cc8e466b56084904a6f4273c12a4baf1','Ts1'),
  ('cd5a0e8832c44a8dbcdcc4c7d29d6e68','Abengoa Solar'),
  ('ce8f0f00c25a4cee96fd8362cab8a793','Central Nuclear Almaraz'),
  ('d125c42efd9841f7a45d05e34b0d980c','Sec Hueneja S.L.'),
  ('d1fa5e5039864b079417c9bb5826e0d4','Solaben Electricidad Uno, S.A.'),
  ('d36451b9bddd41f08579c2c9085b5053','Ider'),
  ('d46dca9f33d84e29b3950450615fa1ae','Ibe- Energia Renovable  de Aragon'),
  ('d490e80b6b334d13b232a416cf6d8232','Tirme'),
  ('d76e9ffb2aa5411c907bc96692a0a411','Analp Gestion S.A.u'),
  ('d78fd8335825446aae0b468740905a9c','Viesgo Distribución Eléctrica S.L.'),
  ('d8ff66f7cf8c49538a9585700d9262b5','Red Electrica Del Sur'),
  ('d9bba1dff64c4d228c42ed539221e2e2','Energías Especiales Del Alto Ulla'),
  ('da75fe12bfb640298092ee8015d3d1d3','Acciona Energia'),
  ('dacd5f6de67b4c8abfad7fd29b7e7a17','Eyra'),
  ('dce6a836583d4b699fcea38bd5ff11d9','Andasol I Central Termosolar Uno S.A.'),
  ('e0abff2b745b45fd86ea5680c8b17a96','Iberenova Promociones S.A.'),
  ('e1fdb92c43fc410fb8cd148d7426f8f6','Cepsa'),
  ('e3e686f57b944a4ba5e9c7e7ed683b9e','Acuamed'),
  ('e7196f75b5a2405db7e5d09ce1d0a682','Gerrsa'),
  ('e729e7c9fda04e89ab877b3e1bf84179','Nueva Generadora Del Sur'),
  ('e7b5d02baf714c8d9f6638cacd60069b','Iberdrola Energías Renovables de Castilla -La Mancha S.A.'),
  ('ea213eb7078d452fae4f205388e3aba4','Adelanta Energias Renovables'),
  ('eb60153b642f42cba7acfddc4fe34631','Disa'),
  ('eb9d63b5c2f34ce4b20f8c9b21213714','Endesa Generacion'),
  ('f131dc50a36d4a5189fbfc6ccf2fba1f','Proyectos Eólicos Valencianos'),
  ('f281284f37ee4020a40a8b1107ae17ab','Hidrocantábrico Generación'),
  ('f2f9cc7b77934224911646780e8fe059','Siderurgica Sevillana'),
  ('f2fd21694cd6469dac58af9894801d0f','Samca'),
  ('f35a429086c8470095c42187ed1ee015','Ibereolica'),
  ('f460faace0b24bd3abb1edce1ee6bf31','Zede'),
  ('f7d0c4e1b4934a418af08f9da913cb9f','Aprovechamiento Energia Renovables de La Tierra Alta'),
  ('f8fecb538f8842b29d5f20d69ed84c07','Deb'),
  ('fc7645b86f7348e2a39a42177a8426ae','Insular Aguas de Lanzarote S.A.'),
  ('fd0993a54d074a9e9f3198ffa1fe0cfd','Alpiq'),
  ('fe5068a574b64fd8b51fd4680696aadb','Aries Solar Termoelectrica S.L.'),
  ('ff034dec86e14aadb936eae1a915a83a','Green'),
  ('ff308225f107489bbc8f7646d7134571','Sistemas Energéticos Monfero-Guitiriz, S.A. (Sociedad Unipersonal)');
/*!40000 ALTER TABLE `owners` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Table structure for table `positions`
--
DROP TABLE IF EXISTS `positions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `positions` (
  `id_position` varchar(32) NOT NULL,
  `id_model` varchar(32) NOT NULL,
  `action` tinyint(4) NOT NULL DEFAULT '0',
  `id_position_type` tinyint(4) DEFAULT NULL,
  `online_date` date DEFAULT NULL,
  `offline_date` date DEFAULT NULL,
  PRIMARY KEY (`id_position`,`id_model`),
  KEY `idx_positions_position_type` (`id_position_type`),
  CONSTRAINT `fk_positions_position_type` FOREIGN KEY (`id_position_type`) REFERENCES `positions_types` (`id_position_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Dumping data for table `positions`
--
LOCK TABLES `positions` WRITE;
/*!40000 ALTER TABLE `positions` DISABLE KEYS */;
/*!40000 ALTER TABLE `positions` ENABLE KEYS */;
UNLOCK TABLES;



--
-- Table structure for table `positions_buses`
--
DROP TABLE IF EXISTS `positions_buses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `positions_buses` (
  `id_position` varchar(32) NOT NULL,
  `id_bus` varchar(32) NOT NULL,
  `id_model` varchar(32) NOT NULL,
  `action` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_position`,`id_model`,`id_bus`),
  KEY `idx_position_buses_bus_model` (`id_bus`,`id_model`),
  -- CONSTRAINT `fk_position_bus_bar_bus_bar` FOREIGN KEY (`id_bus`, `id_model`) REFERENCES `buses` (`id_bus`, `id_model`) ON DELETE CASCADE ON UPDATE NO ACTION,
  -- CONSTRAINT `fk_position_bus_bar_position` FOREIGN KEY (`id_position`, `id_model`) REFERENCES `positions` (`id_position`, `id_model`) ON DELETE CASCADE ON UPDATE NO ACTION
  CONSTRAINT `fk_position_buses_bus` FOREIGN KEY (`id_bus`) REFERENCES `buses` (`id_bus`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_position_buses_position` FOREIGN KEY (`id_position`) REFERENCES `positions` (`id_position`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_position_buses_model` FOREIGN KEY (`id_model`) REFERENCES `models` (`id_model`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Dumping data for table `positions_buses`
--
LOCK TABLES `positions_buses` WRITE;
/*!40000 ALTER TABLE `positions_buses` DISABLE KEYS */;
/*!40000 ALTER TABLE `positions_buses` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Table structure for table `positions_sections`
--
DROP TABLE IF EXISTS `positions_sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `positions_sections` (
  `id_position` varchar(32) NOT NULL,
  `id_section` varchar(32) NOT NULL,
  `id_model` varchar(32) NOT NULL,
  `action` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_position`,`id_model`,`id_section`),
  KEY `idx_positions_sections_section_model` (`id_section`,`id_model`),
  CONSTRAINT `fk_positions_sections_position` FOREIGN KEY (`id_position`) REFERENCES `positions` (`id_position`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_positions_sections_section` FOREIGN KEY (`id_section`) REFERENCES `sections` (`id_section`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_positions_sections_model` FOREIGN KEY (`id_model`) REFERENCES `models` (`id_model`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Dumping data for table `positions_sections`
--
LOCK TABLES `positions_sections` WRITE;
/*!40000 ALTER TABLE `positions_sections` DISABLE KEYS */;
/*!40000 ALTER TABLE `positions_sections` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Table structure for table `positions_types`
--
DROP TABLE IF EXISTS `positions_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `positions_types` (
  `id_position_type` tinyint(4) NOT NULL,
  `name` varchar(45) NOT NULL,
  `comments` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`id_position_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;



--
-- Dumping data for table `positions_types`
--
LOCK TABLES `positions_types` WRITE;
/*!40000 ALTER TABLE `positions_types` DISABLE KEYS */;
INSERT INTO `positions_types` 
  (`id_position_type`,`name`,`comments`) VALUES 
  (0,'Indeterminado',NULL),
  (1,'Blindada',NULL),
  (2,'Convencional',NULL);
/*!40000 ALTER TABLE `positions_types` ENABLE KEYS */;
UNLOCK TABLES;



--
-- Table structure for table `power_lines`
--
DROP TABLE IF EXISTS `power_lines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `power_lines` (
  `id_line` varchar(32) NOT NULL,
  `id_model` varchar(32) NOT NULL,
  `action` tinyint(4) NOT NULL DEFAULT '0',
  `name` varchar(256) DEFAULT NULL,
  `online_date` date DEFAULT NULL,
  `offline_date` date DEFAULT NULL,
  PRIMARY KEY (`id_line`,`id_model`),
  CONSTRAINT `fk_power_lines_model` FOREIGN KEY (`id_model`) REFERENCES `models` (`id_model`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;



--
-- Dumping data for table `power_lines`
--
LOCK TABLES `power_lines` WRITE;
/*!40000 ALTER TABLE `power_lines` DISABLE KEYS */;
INSERT INTO `power_lines`
  (`id_line`,`id_model`,`action`,`name`,`online_date`,`offline_date`) VALUES
  ('4c736abcfd1c4167a82ac9755b316d84','1b8131ba1aa94f8ebc30be409968869e',1,'PL1',NULL,NULL),
  ('4a8abc87c17a4ea8be9722425e19ab50','1b8131ba1aa94f8ebc30be409968869e',1,'PL2',NULL,NULL),
  ('2782a2789f4c4154b6460499282f0d94','1b8131ba1aa94f8ebc30be409968869e',1,'PL3',NULL,NULL),
  ('682e29e930254b2ab70fda988972e5eb','d7399d82cc8a404c81fca5b54fc395e7',1,'PL5',NULL,NULL),
  ('801aa55e4a0a495aa314bd64cf145349','883376684f3e4dedbe831f6e6b2a1ab8',1,'PL6',NULL,NULL);
/*!40000 ALTER TABLE `power_lines` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Table structure for table `power_plants`
--
DROP TABLE IF EXISTS `power_plants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `power_plants` (
  `id_power_plant` varchar(32) NOT NULL,
  `id_model` varchar(32) NOT NULL,
  `action` tinyint(4) NOT NULL DEFAULT '0',
  `name` varchar(256) DEFAULT NULL,
  `online_date` date DEFAULT NULL,
  `offline_date` date DEFAULT NULL,
  PRIMARY KEY (`id_power_plant`,`id_model`),
  CONSTRAINT `fk_power_plants_model` FOREIGN KEY (`id_model`) REFERENCES `models` (`id_model`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Dumping data for table `power_plants`
--
LOCK TABLES `power_plants` WRITE;
/*!40000 ALTER TABLE `power_plants` DISABLE KEYS */;
INSERT INTO `power_plants`
  (`id_power_plant`,`id_model`,`action`,`name`,`online_date` ,`offline_date`) VALUES
  ('7420f4cb8deb481c8160ceee28241cc3','1b8131ba1aa94f8ebc30be409968869e',1,'Planta G1',NULL,NULL);
/*!40000 ALTER TABLE `power_plants` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Table structure for table `profile_groups`
--
DROP TABLE IF EXISTS `profile_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profile_groups` (
  `id_profile_group` varchar(32) NOT NULL,
  -- TODO: pensar si añadir id_model
  `name` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`id_profile_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profile_groups`
--
LOCK TABLES `profile_groups` WRITE;
/*!40000 ALTER TABLE `profile_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `profile_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profiles_`
--
DROP TABLE IF EXISTS `profiles_`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profiles_` (
  `id_profile` varchar(32) NOT NULL,
  `name` varchar(256) DEFAULT NULL,
  `id_profile_group` varchar(32) NOT NULL,
  `utc_offset` double NOT NULL DEFAULT '0',
  `file_name` varchar(3000) NOT NULL,
  PRIMARY KEY (`id_profile`),
  KEY `idx_profiles_profile_group` (`id_profile_group`),
  CONSTRAINT `fk_profiles_profile_group` FOREIGN KEY (`id_profile_group`) REFERENCES `profile_groups` (`id_profile_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Dumping data for table `profiles_`
--
LOCK TABLES `profiles_` WRITE;
/*!40000 ALTER TABLE `profiles_` DISABLE KEYS */;
/*!40000 ALTER TABLE `profiles_` ENABLE KEYS */;
UNLOCK TABLES;



--
-- Table structure for table `provinces`
--
DROP TABLE IF EXISTS `provinces`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `provinces` (
  `id_province` varchar(32) NOT NULL,
  `name` varchar(256) DEFAULT NULL,
  `id_community` varchar(32) NOT NULL,
  `id_INE` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`id_province`),
  KEY `idx_provinces_community` (`id_community`),
  CONSTRAINT `fk_provinces_community` FOREIGN KEY (`id_community`) REFERENCES `communities` (`id_community`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;



--
-- Dumping data for table `provinces`
--
LOCK TABLES `provinces` WRITE;
/*!40000 ALTER TABLE `provinces` DISABLE KEYS */;
INSERT INTO `provinces` 
  (`id_province`,`name`,`id_community`,`id_INE`) VALUES 
  ('f8647836e0034570ac249e03a1b3d742','Default', '6066234ef685409a9bb379cc94552e0e', NULL),
  ('0094dadc4023480a81d45cbfe8d26620','León','d979c0da1a294df0a5973588265f455a','24'),
  ('03a3223494d54d52a6753faaa5372151','Portugal','0aab6f3e6e474d91aade13700c3da3b2',NULL),
  ('1e13520324844d4b808ae4ebb1ee3dbc','Córdoba','51608ba8c53648e1956cdc3f96495268','14'),
  ('1f1b2e23cdc64f23861b9fae0ffa98cb','Navarra','0c2fde5ea2f34785aa17f7d5e2e0e74d','31'),
  ('250aca31eb4b459da7782d5cb701bd53','Badajoz','5b34a91d24404aed938d8d5d0a7449dd','6.'),
  ('25afe09b87c044aaa6e50bc922f18be2','Albacete','fe41cc1f40b54e378f71f6bc87b57579','2.'),
  ('2dbf8541f9d24a5c8d4950dcf3f77243','Toledo','fe41cc1f40b54e378f71f6bc87b57579','45'),
  ('2fb769e53b284d86b073eafe43aae7e7','Almería','51608ba8c53648e1956cdc3f96495268','4.'),
  ('35ce72d017ac428a938506c07cecce7e','Alemania','bf491c5deeeb4eabac907977f1cff84a',NULL),
  ('361196b6eba14a629207831d05331ece','Cuenca','fe41cc1f40b54e378f71f6bc87b57579','16'),
  ('37af8f8a57f446a7ade68f1af6929aa7','Italia','8ab6b92fad7f40c9b30c2dabb03b4c3b',NULL),
  ('37e7196be5d342c9b11e56725829b9c0','Madrid','02cd9b25310249069017bdb58bdedd75','28'),
  ('38227564e4a6432d99482801a4f165a7','Pontevedra','946572223b1f46928b09bfd44aa5a8e0','36'),
  ('3a0909573058415b87c701a0410a2ae1','Luxemburgo','e15918454d6240dab7a5cdaa1b30bb5a',NULL),
  ('3ac7e0a2159e4475b8de87d0d131ea0e','Andorra','718df78f578744aca7695f2d400b7f7c',NULL),
  ('3e28501d77e14127b0dea97febecfc6e','Santa Cruz de Tenerife','2275cc136d0a407f9ff75d8ecfe7ae40','38'),
  ('4004c527517e467aa40fb63e389058d4','Soria','d979c0da1a294df0a5973588265f455a','42'),
  ('47f35c0c64b1445e9c07dc6005082005','Baleares','ea5d241640d24fe0bf4fb8ffba29e1bc','7.'),
  ('48eeb6a559d24afc93d4b81181156228','Granada','51608ba8c53648e1956cdc3f96495268','18'),
  ('5262895d62e1450b9c013ea73880dab5','Salamanca','d979c0da1a294df0a5973588265f455a','37'),
  ('547406da0ab5436dad68633297461b13','Huelva','51608ba8c53648e1956cdc3f96495268','21'),
  ('56545f0adcbf4578b1d1f18cac695a01','Málaga','51608ba8c53648e1956cdc3f96495268','29'),
  ('5a9a788796d742a5a1b850b2836bb67b','Vizcaya','d687c1c849e7426b807384900c19c94d','48'),
  ('6176a043c5d24d98a5bd5f179548dc0b','Zamora','d979c0da1a294df0a5973588265f455a','49'),
  ('62f0f9db811f43f2ab4acc2fd09f7047','Cádiz','51608ba8c53648e1956cdc3f96495268','11'),
  ('63b790f5ebf3461bb785ed1ea4593871','A Coruña','946572223b1f46928b09bfd44aa5a8e0','15'),
  ('67d6ae09c4de455f87cfd3187cf5f5e1','Cáceres','5b34a91d24404aed938d8d5d0a7449dd','10'),
  ('69e3bc57d691434b9c49c6c6e32221e6','Francia','f7367dab474f406a949a2d103af80ab4',NULL),
  ('6b91b9b2557f4033ae3429ba5c128f8f','Lérida','4c3a036560e540689fe2a36a8d95b9fa','25'),
  ('6e9101e1398e4a5ca0bcbcfd0f31d170','Suiza','fced908db7f64155bf73abd3693de691',NULL),
  ('6f207382419c4bf880d6bd5c58a075e1','Marruecos','d01553b4fb24401e90d07c06b2fd8711',NULL),
  ('73a972a5fe244283baf11380811b053f','Barcelona','4c3a036560e540689fe2a36a8d95b9fa','8.'),
  ('7ac2e99484394ba999f99166b2be6806','Guadalajara','fe41cc1f40b54e378f71f6bc87b57579','19'),
  ('7d1e6844d5984b858e722df7583ecb9f','Republica Checa','af301af45f644d88a9e3b94e03386d52',NULL),
  ('7de85a75325c493b9dcbcb862b7fd7f6','Valencia','15693944b49641f48459081cad82182a','46'),
  ('898d9bbb7fd642f19c96fe91fcdea60a','Palencia','d979c0da1a294df0a5973588265f455a','34'),
  ('8e78a8e8322c4e91a5b77c3881f2b1a5','Lugo','946572223b1f46928b09bfd44aa5a8e0','27'),
  ('8e963276e6be496ab29cb668bf4e5904','Melilla','92c9d689bece4ffb9f388d1ac2577861','52'),
  ('9e7ebb31fa7842d99373e6c4657610e7','Tarragona','4c3a036560e540689fe2a36a8d95b9fa','43'),
  ('a240e3ef841f4efc82ca091d6cd39ab1','Argelia','c3284555f83e4e52a96639558319eb72',NULL),
  ('a4fbe5699d744ab0b4650e2027d122a0','Huesca','ca85ea023b6646af977f09dc96bfd009','22'),
  ('a6df6d22781b4c898af9696dabffab0d','Girona','4c3a036560e540689fe2a36a8d95b9fa','17'),
  ('aa980e4e0bfc487f8d585c03f7f62677','Burgos','d979c0da1a294df0a5973588265f455a','9.'),
  ('aecf9212c6ff4203b2c687e8f187543c','Reino Unido','0cc5314f534f4e1b83e4539c49daf5e1',NULL),
  ('b21b241212ad48c8987aec5df94f4a0b','Valladolid','d979c0da1a294df0a5973588265f455a','47'),
  ('b8176380373747a78d51479c878c6853','Segovia','d979c0da1a294df0a5973588265f455a','40'),
  ('b8c3c1bd4c7a42329c1d71bbc08473de','Sevilla','51608ba8c53648e1956cdc3f96495268','41'),
  ('b94eaf668beb49fabcabb9680a71b2ba','Castellón','15693944b49641f48459081cad82182a','12'),
  ('ba5ef49362fd45dd98626dbf13607680','Teruel','ca85ea023b6646af977f09dc96bfd009','44'),
  ('bcbbba97bb7940d7ad3158d06ddca0e0','Ciudad Real','fe41cc1f40b54e378f71f6bc87b57579','13'),
  ('bcfa459e2f5b490bb0bf7d9456dbdaee','Álava','d687c1c849e7426b807384900c19c94d','1.'),
  ('bf280ba0bde643d3beb5ebdb6cc17da4','Belgica','58d31d01cf2d4da1bd14f07af354616e',NULL),
  ('c12324f0115747c28de8769a8d565991','Alicante','15693944b49641f48459081cad82182a','3.'),
  ('c157cd47b3aa43c0a7d4b25e591df472','La Rioja','e0250518555a44199804ac3b5c142356','26'),
  ('d0db2ffd257f44acae4feb110a6b8f32','Ceuta','2b37c36ddc334cce8d5a6121745920e3','51'),
  ('d1422ca38be448b48e7aab8523845342','Guipuzcoa','d687c1c849e7426b807384900c19c94d','20'),
  ('d4e3d411e7c0461194ad7f27b222271f','Asturias','276cb6f5a2174feea0d96b2898152f33','33'),
  ('d7b7b4d7dc4c4c28a5635bf1b35618a2','Cantabria','a349e205b93f431e9eda3547472bc4be','39'),
  ('ddf165bad521491fb74d69f901b11832','Perú','92959ca30ed544b18914b9319f641f1d',NULL),
  ('de0f5547619e46d0b719abbb35e72ed3','Orense','946572223b1f46928b09bfd44aa5a8e0','32'),
  ('de387c31305144da909b551c5f9e3b13','Álvila','d979c0da1a294df0a5973588265f455a','5.'),
  ('e4be8bf4dcdc45cb9e581914264f19a2','Zaragoza','ca85ea023b6646af977f09dc96bfd009','50'),
  ('e78aa05f621d4f76a438d048063c5090','Murcia','288fefb1c62544f09afe4d3f5f8b405f','30'),
  ('ea6aa36b86054627b7f21c398fd8280a','Las Palmas','2275cc136d0a407f9ff75d8ecfe7ae40','35'),
  ('ec1d8701de794d04a0146f0e0f5aed81','Chile','4524db80880b42be96c341e28eaba2bd',NULL),
  ('f63d1db4fa564c62b7148e99b9f8beb3','Jaén','51608ba8c53648e1956cdc3f96495268','23');
/*!40000 ALTER TABLE `provinces` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Table structure for table `sections`
--
DROP TABLE IF EXISTS `sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sections` (
  `id_section` varchar(32) NOT NULL,
  `id_model` varchar(32) NOT NULL,
  `action` tinyint(4) NOT NULL DEFAULT '0',
  `id_connectivity_node_1` varchar(32) NOT NULL,
  `id_connectivity_node_2` varchar(32) NOT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  `name` varchar(256) DEFAULT NULL,
  `rating` double DEFAULT NULL,
  `id_rating_profile` varchar(32) DEFAULT NULL,
  `contingency_factor1` float NOT NULL DEFAULT '1',
  `contingency_factor2` float NOT NULL DEFAULT '1',
  `contingency_factor3` float NOT NULL DEFAULT '1',
  `online_date` date DEFAULT NULL,
  `offline_date` date DEFAULT NULL,
  `mttf` double DEFAULT NULL,
  `mttr` double DEFAULT NULL,
  `secondary_id` varchar(48) DEFAULT NULL,
  `sequential` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_section`,`id_model`),
  KEY `idx_sections_model` (`id_model`),
  KEY `idx_sections_connectivity_node_1_model` (`id_connectivity_node_1`,`id_model`),
  KEY `idx_sections_connectivity_node_2_model` (`id_connectivity_node_2`,`id_model`),
  -- CONSTRAINT `sections_ibfk_1` FOREIGN KEY (`id_connectivity_node_1`, `id_model`) REFERENCES `connectivity_nodes` (`id_connectivity_node`, `id_model`) ON DELETE CASCADE ON UPDATE NO ACTION,
  -- CONSTRAINT `sections_ibfk_2` FOREIGN KEY (`id_connectivity_node_2`, `id_model`) REFERENCES `connectivity_nodes` (`id_connectivity_node`, `id_model`) ON DELETE CASCADE ON UPDATE NO ACTION
  CONSTRAINT `fk_sections_connectivity_node_1` FOREIGN KEY (`id_connectivity_node_1`) REFERENCES `connectivity_nodes` (`id_connectivity_node`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_sections_connectivity_node_2` FOREIGN KEY (`id_connectivity_node_2`) REFERENCES `connectivity_nodes` (`id_connectivity_node`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_sections_model` FOREIGN KEY (`id_model`) REFERENCES `models` (`id_model`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Dumping data for table `sections`
--
LOCK TABLES `sections` WRITE;
/*!40000 ALTER TABLE `sections` DISABLE KEYS */;
INSERT INTO `sections` 
  (`id_section`, `id_model`, `action`, `id_connectivity_node_1`, `id_connectivity_node_2`, `active`, `name`, `rating`, `id_rating_profile`, `contingency_factor1`, `contingency_factor2`, `contingency_factor3`, `online_date`, `offline_date`, `mttf`, `mttr`, `secondary_id`, `sequential`) VALUES   
  ('59307e467ae74533859a2d22d2157add','1b8131ba1aa94f8ebc30be409968869e',1,'8ae269f11d7046b79f7b08c65dcf110b','e54ef70eb2dc44b1ab07147a61b33378',1,'s1',9999,NULL,1,1,1,NULL,NULL,NULL,NULL,'s1',1),
  ('75a4f7111f954ed68d5fc6f90b45df5c','1b8131ba1aa94f8ebc30be409968869e',1,'ff264b13b9d74c238820c42fc2452a07','086533eb5c064d03956f7d148894f161',1,'s2',9999,NULL,1,1,1,NULL,NULL,NULL,NULL,'s2',1),
  ('6b20530bb5ae46629837af85e6192f15','1b8131ba1aa94f8ebc30be409968869e',1,'24961d21824d4695ae1df573da42c3a3','486c227100d84124bef8c4b8ab0a2403',1,'s3',9999,NULL,1,1,1,NULL,NULL,NULL,NULL,'s3',1),
  ('694587e4245f4437a0216e24ccecdc47','1b8131ba1aa94f8ebc30be409968869e',1,'527e04846d5e4b38a674a28246121952','e565b74b90974dcc94c24a21fe9565b5',1,'s4',9999,NULL,1,1,1,NULL,NULL,NULL,NULL,'s4',1),
  ('be235955a329417892ee0ea507dbf555','1b8131ba1aa94f8ebc30be409968869e',1,'3af4b9d177874d3ea2ce11d875303adf','69192bc30877459082e64f8d56fee7a8',1,'s5',9999,NULL,1,1,1,NULL,NULL,NULL,NULL,'s5',1),
  ('89648e78ff9c4f92bcdc8f497a02c067','1b8131ba1aa94f8ebc30be409968869e',1,'6a2d55cf3f8b4052b2b6a80b0b7669ed','aa480fce99e54f7faf13889fe4d50f80',1,'s6',9999,NULL,1,1,1,NULL,NULL,NULL,NULL,'s6',1),
  ('bd9a5a2e634d4811853f0e3c31d7cd69','1b8131ba1aa94f8ebc30be409968869e',1,'4cc87ef6f3c34593aa3f2ebce84ebe08','87146d90fb904a1eac24a8e04c37498a',1,'s7',9999,NULL,1,1,1,NULL,NULL,NULL,NULL,'s7',1),
  ('489a81f4e52c4389ae9ff536c12a87ec','1b8131ba1aa94f8ebc30be409968869e',1,'16d60e2b13e347009658bc269b379d00','7df9c8d5347e42f7aba4d406ba309d14',1,'s8',9999,NULL,1,1,1,NULL,NULL,NULL,NULL,'s8',1),
  ('80ee040765964aab84a1567b604d9222','1b8131ba1aa94f8ebc30be409968869e',1,'cfa5e1ea17824184888514243c4391e6','dedbf8b7d56347b98a449a509aedcfb4',1,'s9',9999,NULL,1,1,1,NULL,NULL,NULL,NULL,'s9',1),
  ('6f19602218fe493789fbf49c357aa946','1b8131ba1aa94f8ebc30be409968869e',1,'069e806ed9874727aab592149ffb3479','33b76167770441cc94edb63881b1e550',1,'s10',9999,NULL,1,1,1,NULL,NULL,NULL,NULL,'s10',1),
  ('476822dadc3e4c40841a5d1f8a26eee5','1b8131ba1aa94f8ebc30be409968869e',1,'b605a307589648d2a1adbc869e49f292','0e95549c4a534758bd0b4eeec1b55ed0',1,'s11',9999,NULL,1,1,1,NULL,NULL,NULL,NULL,'s11',1),
  ('175ebf8b030f47dab6253c9798b05cfb','1b8131ba1aa94f8ebc30be409968869e',1,'1aac390a4e1c45d1935fb528d13904ba','f50b29ba5ee74e5f8b47134733a09608',1,'s12',9999,NULL,1,1,1,NULL,NULL,NULL,NULL,'s12',1),
  ('204fea48fc0145f5a70885376effdf0c','1b8131ba1aa94f8ebc30be409968869e',1,'247076746a914bceb27ea333ceeddddd','f19d257a6ae6462b94d8015370cbc4a7',1,'s13',9999,NULL,1,1,1,NULL,NULL,NULL,NULL,'s13',1),
  ('592c908a1b034ed9bb0c2e616dc15a33','1b8131ba1aa94f8ebc30be409968869e',1,'a730c38cd694472c902dd8f2ea15df89','47d3ad463c3548659d2fd7a2bb061344',1,'s14',9999,NULL,1,1,1,NULL,NULL,NULL,NULL,'s14',1),
  ('10530aad36bd43bcb271ca2b9cc1339f','1b8131ba1aa94f8ebc30be409968869e',1,'ab398fe207714543a08364012e3b417b','a4244c36b08c48e385a4024a820e36c6',1,'s15',9999,NULL,1,1,1,NULL,NULL,NULL,NULL,'s15',1),
  ('d632b9df84a0471eb6ffd5c49d0733d4','1b8131ba1aa94f8ebc30be409968869e',1,'efe89ce57b6a474c9d69e59ffbc35582','d0b0717653dd43cf9be9fdf4ee5bc22f',1,'s16',9999,NULL,1,1,1,NULL,NULL,NULL,NULL,'s16',1),
  ('ba6797bd7c5649f0ad0b575f38a49226','1b8131ba1aa94f8ebc30be409968869e',1,'497db037b6184c85ba02b1349a4bd70b','03a0d1a6765d440f9c15f508f9ae2164',1,'s17',9999,NULL,1,1,1,NULL,NULL,NULL,NULL,'s17',1),
  ('f58ce764de7c47c391dce069385bcec3','1b8131ba1aa94f8ebc30be409968869e',1,'4c51439a6f504c77afbd568d6379c011','1e14ffa433384f8dbc2bc01faea02fa9',1,'s18',9999,NULL,1,1,1,NULL,NULL,NULL,NULL,'s18',1),
  ('4a51c3b1332e483db962ea814851d43e','1b8131ba1aa94f8ebc30be409968869e',1,'7658cc6cd4834da789c5acbccc4870ae','68ba55d9a79a4326b470b452844b11a3',1,'s19',9999,NULL,1,1,1,NULL,NULL,NULL,NULL,'s19',1),
  ('14816741a3574c3898969a29f61382ce','1b8131ba1aa94f8ebc30be409968869e',1,'88db55fbebf743e29a325c7a45d44aa6','75ed1c5878294e9d9c18bcafec0d64b6',1,'s20',9999,NULL,1,1,1,NULL,NULL,NULL,NULL,'s20',1),
  ('61850b9dee474a1fa2822b2e3074fabd','1b8131ba1aa94f8ebc30be409968869e',1,'6e9fa25fb3ba42a992989d61f9cd8c9e','e9c114b526a1417795c7e4ad8ac0aae2',1,'s21',9999,NULL,1,1,1,NULL,NULL,NULL,NULL,'s21',1),
  ('301c5bcbcd5e418c9f762dcda4db2c65','1b8131ba1aa94f8ebc30be409968869e',1,'76f8cedf733b47c6871a8f55785f810e','7268f4b1a56f4314bdf17bff655bebc1',1,'s22',9999,NULL,1,1,1,NULL,NULL,NULL,NULL,'s22',1),
  ('03a9f58df60e4d9f8aa9cd6ac786aee8','d7399d82cc8a404c81fca5b54fc395e7',1,'13e11b1a2b014126b5754b8efc909130','4ae1b9eb41bf4634878afac593703a6a',1,'s23',9999,NULL,1,1,1,NULL,NULL,NULL,NULL,NULL,1),
  ('0fa959124dbf4385af9e64f259a4d4d6','1b8131ba1aa94f8ebc30be409968869e',1,'5b51b0220030406f9b44dcc81c057ffe','4ad6290a356a41c4af39719846433a84',1,'s23',9999,NULL,1,1,1,NULL,NULL,NULL,NULL,'s23',1),
  ('5bbeb19027874225af25cfba9d8df0ae','d7399d82cc8a404c81fca5b54fc395e7',1,'b36405f8f0f140648444c1231bf73a86','ba9d35b4725048adb9682b9ba85ce0b4',1,'s24',9999,NULL,1,1,1,NULL,NULL,NULL,NULL,NULL,1),
  ('fe5ec7281f6940398e297710e7f5f33a','1b8131ba1aa94f8ebc30be409968869e',1,'99b4a0733c2646528b5f1da6fff17f4f','f427933e896940c2bda8a994ef72d1b1',1,'s24',9999,NULL,1,1,1,NULL,NULL,NULL,NULL,'s24',1),
  ('882507ee84284c03ad35981632ebe284','d7399d82cc8a404c81fca5b54fc395e7',1,'72270e722510489297950e53229b9f18','f74c93db485e4a0c94e1ce0ac95a7546',1,'s25',9999,NULL,1,1,1,NULL,NULL,NULL,NULL,NULL,1),
  ('ccbb06fe8b004dbab910b8ccb8e5ddec','1b8131ba1aa94f8ebc30be409968869e',1,'08b0b9b95c954724bca93fd8d009adf6','85076048f6f846aa81a6767cb7de0808',1,'s25',9999,NULL,1,1,1,NULL,NULL,NULL,NULL,'s25',1),
  ('cb5f7e82e6564c68b79eee506bc6c6d6','d7399d82cc8a404c81fca5b54fc395e7',1,'575717c169ea4c4e815075200684dedf','972aac9009694a40b5369eef7afe8e45',1,'s26',9999,NULL,1,1,1,NULL,NULL,NULL,NULL,NULL,1),
  ('f7ee8e3a41cf485da80ef92e6fafc37a','1b8131ba1aa94f8ebc30be409968869e',1,'ef6b962490544e6682b86e0fd83c33bf','cc89d0c029214d44b2878bc738be52c9',1,'s26',9999,NULL,1,1,1,NULL,NULL,NULL,NULL,'s26',1),
  ('018bce1f634b49ae94cf8cc686e6c405','d7399d82cc8a404c81fca5b54fc395e7',1,'d9031da1d7614345bfc7cd0602c3482b','62aecf7737ff4c769f0f0d05a2be1aad',1,'s27',9999,NULL,1,1,1,NULL,NULL,NULL,NULL,NULL,1),
  ('16194f064dc042d6811a1b35f623470e','d7399d82cc8a404c81fca5b54fc395e7',1,'8a12ed8052d74d4dbdea274d3a65c97c','60d80db791ed40b0b2590b12b1fc1132',1,'s28',9999,NULL,1,1,1,NULL,NULL,NULL,NULL,NULL,1),
  ('82562dbc68d44b50955683341b8576a5','883376684f3e4dedbe831f6e6b2a1ab8',1,'e6c8ce9bb1bc4a758db30f4ffa2108df','0f760626ba1e49019f28c6b7550ac75d',1,'s29',9999,NULL,1,1,1,NULL,NULL,NULL,NULL,NULL,1),
  ('2fa5317387954a3ab6643652f47d29d3','883376684f3e4dedbe831f6e6b2a1ab8',1,'a77338ecb1b14ad58290f1b110edd8d4','9b971863578447bcbf28dcde17f37c28',1,'s30',9999,NULL,1,1,1,NULL,NULL,NULL,NULL,NULL,1),
  ('2c358e08f1ce4254a1be6b44e2a2f6cf','883376684f3e4dedbe831f6e6b2a1ab8',1,'65302046d06441ce9c34ef2bc3d28578','2e5f3fd3ac084934b786cd4680ff288c',1,'s31',9999,NULL,1,1,1,NULL,NULL,NULL,NULL,NULL,1),
  ('8dd707f55c1f444db458b2832b16be4c','883376684f3e4dedbe831f6e6b2a1ab8',1,'a6299206f9104abbb7cce40f46f2ebb2','dbcdbb0ec9544230b55ebf772c998510',1,'s32',9999,NULL,1,1,1,NULL,NULL,NULL,NULL,NULL,1),
  ('5998c99f9ddf489d9eb885228d9e4d83','1b8131ba1aa94f8ebc30be409968869e',1,'e54ef70eb2dc44b1ab07147a61b33378','ff264b13b9d74c238820c42fc2452a07',1,'i1',9999,NULL,1,1,1,NULL,NULL,NULL,NULL,'i1',1),
  ('3282195a7aef43d7a4f1453059f11bcf','1b8131ba1aa94f8ebc30be409968869e',1,'486c227100d84124bef8c4b8ab0a2403','527e04846d5e4b38a674a28246121952',1,'i2',9999,NULL,1,1,1,NULL,NULL,NULL,NULL,'i2',1),
  ('db5a825f24054b6d97810dd6917bd6df','1b8131ba1aa94f8ebc30be409968869e',1,'69192bc30877459082e64f8d56fee7a8','6a2d55cf3f8b4052b2b6a80b0b7669ed',1,'i3',9999,NULL,1,1,1,NULL,NULL,NULL,NULL,'i3',1),
  ('9b9750c171e146f19c76c7c9120429bc','1b8131ba1aa94f8ebc30be409968869e',1,'87146d90fb904a1eac24a8e04c37498a','16d60e2b13e347009658bc269b379d00',1,'i4',9999,NULL,1,1,1,NULL,NULL,NULL,NULL,'i4',1),
  ('0dba01654b0340d8981ba4922fef2489','1b8131ba1aa94f8ebc30be409968869e',1,'dedbf8b7d56347b98a449a509aedcfb4','069e806ed9874727aab592149ffb3479',1,'i5',9999,NULL,1,1,1,NULL,NULL,NULL,NULL,'i5',1),
  ('9aeb529eb67c4ee386daf1b6cc652670','1b8131ba1aa94f8ebc30be409968869e',1,'0e95549c4a534758bd0b4eeec1b55ed0','1aac390a4e1c45d1935fb528d13904ba',1,'i6',9999,NULL,1,1,1,NULL,NULL,NULL,NULL,'i6',1),
  ('4e9c9d85cac64e6ab10a6a3b73ed040c','1b8131ba1aa94f8ebc30be409968869e',1,'f19d257a6ae6462b94d8015370cbc4a7','a730c38cd694472c902dd8f2ea15df89',1,'i7',9999,NULL,1,1,1,NULL,NULL,NULL,NULL,'i7',1),
  ('2704c0643f984607995a7c1d002868e6','1b8131ba1aa94f8ebc30be409968869e',1,'a4244c36b08c48e385a4024a820e36c6','efe89ce57b6a474c9d69e59ffbc35582',1,'i8',9999,NULL,1,1,1,NULL,NULL,NULL,NULL,'i8',1),
  ('bce66f65d98145dd96b36215f559cbfd','1b8131ba1aa94f8ebc30be409968869e',1,'1e14ffa433384f8dbc2bc01faea02fa9','497db037b6184c85ba02b1349a4bd70b',1,'i9',9999,NULL,1,1,1,NULL,NULL,NULL,NULL,'i9',1),
  ('2d33e0835dfe44619ab6cb19998b19da','1b8131ba1aa94f8ebc30be409968869e',1,'75ed1c5878294e9d9c18bcafec0d64b6','7658cc6cd4834da789c5acbccc4870ae',1,'i10',9999,NULL,1,1,1,NULL,NULL,NULL,NULL,'i90',1),
  ('64ed69d3cbbf443f9a7a33a13a39dc41','1b8131ba1aa94f8ebc30be409968869e',1,'7268f4b1a56f4314bdf17bff655bebc1','6e9fa25fb3ba42a992989d61f9cd8c9e',1,'i11',9999,NULL,1,1,1,NULL,NULL,NULL,NULL,'i91',1),
  ('f87d7ff16f5547af82616434a97351f5','1b8131ba1aa94f8ebc30be409968869e',1,'f427933e896940c2bda8a994ef72d1b1','5b51b0220030406f9b44dcc81c057ffe',1,'i12',9999,NULL,1,1,1,NULL,NULL,NULL,NULL,'i92',1),
  ('9e31c2edf3de49b698d1b624ec28ac7b','1b8131ba1aa94f8ebc30be409968869e',1,'cc89d0c029214d44b2878bc738be52c9','08b0b9b95c954724bca93fd8d009adf6',1,'i13',9999,NULL,1,1,1,NULL,NULL,NULL,NULL,'i93',1),
  ('9fc783880b8343dcbd9062eade599e38','1b8131ba1aa94f8ebc30be409968869e',1,'9d6a7f53ace847fdac6b9310888cc29a','38b887c106e745f4b4a05ec7e3c3f343',1,'i14',9999,NULL,1,1,1,NULL,NULL,NULL,NULL,'i94',1),
  ('bbfd60d908f542e4932b89e1e1da4b69','1b8131ba1aa94f8ebc30be409968869e',1,'ce2272b340484c488aa17de1384414bd','d6b7ac3bea3f46198625677d88555bd1',1,'i15',9999,NULL,1,1,1,NULL,NULL,NULL,NULL,'i95',1),
  ('ff1652a2d9e34e2f9420081105fb541c','d7399d82cc8a404c81fca5b54fc395e7',1,'4ae1b9eb41bf4634878afac593703a6a','b36405f8f0f140648444c1231bf73a86',1,'i16',9999,NULL,1,1,1,NULL,NULL,NULL,NULL,NULL,1),
  ('84d1a846a6d1479aa303a3bd0a2528cb','d7399d82cc8a404c81fca5b54fc395e7',1,'d085c469305f4144a00e6c4af51619b6','9a23e5577d304b01abf5855a0973af0e',1,'i17',9999,NULL,1,1,1,NULL,NULL,NULL,NULL,NULL,1),
  ('cd6cbd5e0ce74dda8ffb17d6183c6481','d7399d82cc8a404c81fca5b54fc395e7',1,'f74c93db485e4a0c94e1ce0ac95a7546','575717c169ea4c4e815075200684dedf',1,'i18',9999,NULL,1,1,1,NULL,NULL,NULL,NULL,NULL,1),
  ('2431ccf6d8264333a9825cf539ed3cff','d7399d82cc8a404c81fca5b54fc395e7',1,'62aecf7737ff4c769f0f0d05a2be1aad','8a12ed8052d74d4dbdea274d3a65c97c',1,'i19',9999,NULL,1,1,1,NULL,NULL,NULL,NULL,NULL,1),
  ('a062e006bb81439c9a3c8b4733c5a426','883376684f3e4dedbe831f6e6b2a1ab8',1,'0f760626ba1e49019f28c6b7550ac75d','a77338ecb1b14ad58290f1b110edd8d4',1,'i20',9999,NULL,1,1,1,NULL,NULL,NULL,NULL,NULL,1),
  ('b820515899c844a496b8863891b1d3b3','883376684f3e4dedbe831f6e6b2a1ab8',1,'dbcdbb0ec9544230b55ebf772c998510','65302046d06441ce9c34ef2bc3d28578',1,'i21',9999,NULL,1,1,1,NULL,NULL,NULL,NULL,NULL,1),
  ('e6069ac6ad804d2eb52533eb9f0c8bdd','1b8131ba1aa94f8ebc30be409968869e',1,'33b76167770441cc94edb63881b1e550','b605a307589648d2a1adbc869e49f292',1,'L1',9999,NULL,1,1,1,NULL,NULL,NULL,NULL,'L1',1),
  ('da810641b046452ba23e2afe666ea555','1b8131ba1aa94f8ebc30be409968869e',1,'d0b0717653dd43cf9be9fdf4ee5bc22f','03a0d1a6765d440f9c15f508f9ae2164',1,'L2',9999,NULL,1,1,1,NULL,NULL,NULL,NULL,'L2',1),
  ('99314a47b6524444848a6613428fc638','1b8131ba1aa94f8ebc30be409968869e',1,'4ad6290a356a41c4af39719846433a84','fce12f96e98b428a81fdc8091d6c49dc',1,'L3',9999,NULL,1,1,1,NULL,NULL,NULL,NULL,'L3',1),
  ('9ff0f7d124fb400380f3a217c123f757','1b8131ba1aa94f8ebc30be409968869e',1,'fce12f96e98b428a81fdc8091d6c49dc','76f8cedf733b47c6871a8f55785f810e',1,'L4',9999,NULL,1,1,1,NULL,NULL,NULL,NULL,'L4',1),
  ('72e0cc5e0c164003a83dd734386dc7c6','d7399d82cc8a404c81fca5b54fc395e7',1,'13e11b1a2b014126b5754b8efc909130','60d80db791ed40b0b2590b12b1fc1132',1,'L5',1200,NULL,1,1,1,NULL,NULL,NULL,NULL,NULL,1),
  ('e171b791dd2e456996cf0496294ef2b0','883376684f3e4dedbe831f6e6b2a1ab8',1,'a6299206f9104abbb7cce40f46f2ebb2','9b971863578447bcbf28dcde17f37c28',1,'L6',1200,NULL,1,1,1,NULL,NULL,NULL,NULL,NULL,1),
  ('a5bed7fb497a4b968de3d183e63a2ec0','1b8131ba1aa94f8ebc30be409968869e',1,'e565b74b90974dcc94c24a21fe9565b5','3af4b9d177874d3ea2ce11d875303adf',1,'T1',9999,NULL,1,1,1,NULL,NULL,NULL,NULL,'T1',1);
/*!40000 ALTER TABLE `sections` ENABLE KEYS */;
UNLOCK TABLES;



--
-- Table structure for table `sections_groups`
--
DROP TABLE IF EXISTS `sections_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sections_groups` (
  `id_section_group` varchar(32) NOT NULL,
  `id_model` varchar(32) NOT NULL,
  `action` tinyint(4) NOT NULL DEFAULT '0',
  `name` varchar(256) DEFAULT NULL,
  `online_date` date DEFAULT NULL,
  `offline_date` date DEFAULT NULL,
  `description` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`id_section_group`,`id_model`),
  KEY `idx_sections_groups_model` (`id_model`),
  CONSTRAINT `fk_sections_groups_model` FOREIGN KEY (`id_model`) REFERENCES `models` (`id_model`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Dumping data for table `sections_groups`
--
LOCK TABLES `sections_groups` WRITE;
/*!40000 ALTER TABLE `sections_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `sections_groups` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Table structure for table `sections_locations`
--
DROP TABLE IF EXISTS `sections_locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sections_locations` (
  `id_line_location` varchar(32) NOT NULL,
  `id_model` varchar(32) NOT NULL,
  `action` tinyint(4) NOT NULL DEFAULT '0',
  `id_section` varchar(32) NOT NULL,
  `sequential_position` int(11) NOT NULL,
  `latitude` float DEFAULT NULL,
  `longitude` float DEFAULT NULL,
  `altitude` float DEFAULT NULL,
  PRIMARY KEY (`id_line_location`),
  KEY `idx_sections_locations_section_model` (`id_section`,`id_model`),
  -- CONSTRAINT `sections_locations_ibfk_1` FOREIGN KEY (`id_section`, `id_model`) REFERENCES `sections` (`id_section`, `id_model`) ON DELETE CASCADE ON UPDATE NO ACTION
  CONSTRAINT `fk_sections_locations_section` FOREIGN KEY (`id_section`) REFERENCES `sections` (`id_section`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_sections_locations_model` FOREIGN KEY (`id_model`) REFERENCES `models` (`id_model`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;




--
-- Dumping data for table `sections_locations`
--
LOCK TABLES `sections_locations` WRITE;
/*!40000 ALTER TABLE `sections_locations` DISABLE KEYS */;
INSERT INTO `sections_locations`
  (`id_line_location`,`id_model`,`action`,`id_section`,`sequential_position`,`latitude`,`longitude`,`altitude`) VALUES
  ('010120f8086a489ab00b7ca00234a97f','1b8131ba1aa94f8ebc30be409968869e',1,'e6069ac6ad804d2eb52533eb9f0c8bdd',1,43.5315,-5.70347,0),
  ('22662f568fba424c8dd213433e544249','1b8131ba1aa94f8ebc30be409968869e',1,'99314a47b6524444848a6613428fc638',2,40.062,-2.16557,0),
  ('24a6444ab3204f039970642fb9a1ab5a','1b8131ba1aa94f8ebc30be409968869e',1,'da810641b046452ba23e2afe666ea555',1,37.3755,-6.0251,0),
  ('a5f8ebe0625347208ffb060bef19d92e','1b8131ba1aa94f8ebc30be409968869e',1,'e6069ac6ad804d2eb52533eb9f0c8bdd',2,37.3755,-6.0251,0),
  ('b40b2f31aa12413786f1e167228c3627','1b8131ba1aa94f8ebc30be409968869e',1,'da810641b046452ba23e2afe666ea555',2,36.7183,-4.51931,0),
  ('d6b311335142441f8aea2992b31db31a','1b8131ba1aa94f8ebc30be409968869e',1,'9ff0f7d124fb400380f3a217c123f757',2,43.5315,-5.70347,0),
  ('e6aff7d33bbe4c1aba6535ed31e828cd','1b8131ba1aa94f8ebc30be409968869e',1,'9ff0f7d124fb400380f3a217c123f757',1,40.062,-2.16557,0),
  ('f647d73c66c544719ba3cd951e791a9d','1b8131ba1aa94f8ebc30be409968869e',1,'99314a47b6524444848a6613428fc638',1,36.7183,-4.51931,0);
/*!40000 ALTER TABLE `sections_locations` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Temporary view structure for view `sections_bus`
--

DROP TABLE IF EXISTS `sections_bus`;
/*!50001 DROP VIEW IF EXISTS `sections_bus`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `sections_bus` AS SELECT
 1 AS `section_name1`,
 1 AS `bus_name1`,
 1 AS `bus_name2`,
 1 AS `sid1`,
 1 AS `bid1`,
 1 AS `bid2`*/;
SET character_set_client = @saved_cs_client;


--
-- Table structure for table `sections_sections_groups`
--

DROP TABLE IF EXISTS `sections_sections_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sections_sections_groups` (
  `id_section_group` varchar(32) NOT NULL,
  `id_section` varchar(32) NOT NULL,
  `id_model` varchar(32) NOT NULL,
  `action` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_section_group`,`id_model`),
  KEY `idx_sections_sections_groups_section_model` (`id_section`,`id_model`),
  -- CONSTRAINT `sections_sections_groups_ibfk_1` FOREIGN KEY (`id_section`, `id_model`) REFERENCES `sections` (`id_section`, `id_model`) ON DELETE CASCADE ON UPDATE NO ACTION,
  -- CONSTRAINT `sections_sections_groups_ibfk_2` FOREIGN KEY (`id_section_group`, `id_model`) REFERENCES `sections_groups` (`id_section_group`, `id_model`) ON DELETE CASCADE ON UPDATE NO ACTION
  CONSTRAINT `fk_sections_sections_groups_section` FOREIGN KEY (`id_section`) REFERENCES `sections` (`id_section`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_sections_sections_groups_section_group` FOREIGN KEY (`id_section_group`) REFERENCES `sections_groups` (`id_section_group`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_sections_sections_groups_model` FOREIGN KEY (`id_model`) REFERENCES `models` (`id_model`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sections_sections_groups`
--

LOCK TABLES `sections_sections_groups` WRITE;
/*!40000 ALTER TABLE `sections_sections_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `sections_sections_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `series_reactances`
--

DROP TABLE IF EXISTS `series_reactances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `series_reactances` (
  `id_section` varchar(32) NOT NULL,
  `id_model` varchar(32) NOT NULL,
  `action` tinyint(4) NOT NULL DEFAULT '0',
  `r0` float NOT NULL DEFAULT '0',
  `r1` float NOT NULL DEFAULT '0',
  `r2` float NOT NULL DEFAULT '0',
  `x0` float NOT NULL DEFAULT '0',
  `x1` float NOT NULL DEFAULT '0',
  `x2` float NOT NULL DEFAULT '0',
  `id_impedance_table` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id_section`,`id_model`),
  KEY `idx_series_reactances_impedance_table` (`id_impedance_table`),
  -- CONSTRAINT `fk_series_reactance_impedance_table` FOREIGN KEY (`id_impedance_table`) REFERENCES `impedance_tables` (`id_table`),
  -- CONSTRAINT `fk_series_reactance_sections` FOREIGN KEY (`id_section`, `id_model`) REFERENCES `sections` (`id_section`, `id_model`) ON DELETE CASCADE ON UPDATE NO ACTION
  CONSTRAINT `fk_series_reactances_impedance_table` FOREIGN KEY (`id_impedance_table`) REFERENCES `impedance_tables` (`id_table`),
  CONSTRAINT `fk_series_reactances_section` FOREIGN KEY (`id_section`) REFERENCES `sections` (`id_section`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_series_reactances_model` FOREIGN KEY (`id_model`) REFERENCES `models` (`id_model`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `series_reactances`
--
LOCK TABLES `series_reactances` WRITE;
/*!40000 ALTER TABLE `series_reactances` DISABLE KEYS */;
/*!40000 ALTER TABLE `series_reactances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ssc`
--
DROP TABLE IF EXISTS `ssc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ssc` (
  `id_ssc` varchar(32) NOT NULL,
  `id_model` varchar(32) NOT NULL,
  `action` tinyint(4) NOT NULL DEFAULT '0',
  `id_connectivity_node` varchar(32) NOT NULL,
  `name` varchar(256) NOT NULL DEFAULT '""',
  `vset` float NOT NULL DEFAULT '1',
  `sequential` tinyint(4) NOT NULL DEFAULT '0',
  `secondary_id` varchar(48) DEFAULT NULL,
  PRIMARY KEY (`id_ssc`,`id_model`),
  KEY `idx_ssc_connectivity_node_model` (`id_connectivity_node`,`id_model`),
  -- CONSTRAINT `fk_ssc_cn` FOREIGN KEY (`id_connectivity_node`, `id_model`) REFERENCES `connectivity_nodes` (`id_connectivity_node`, `id_model`) ON DELETE CASCADE ON UPDATE NO ACTION
  CONSTRAINT `fk_ssc_connectivity_node` FOREIGN KEY (`id_connectivity_node`) REFERENCES `connectivity_nodes` (`id_connectivity_node`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_ssc_model` FOREIGN KEY (`id_model`) REFERENCES `models` (`id_model`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='static Synchronous Compensator';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ssc`
--
LOCK TABLES `ssc` WRITE;
/*!40000 ALTER TABLE `ssc` DISABLE KEYS */;
/*!40000 ALTER TABLE `ssc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sssc`
--
DROP TABLE IF EXISTS `sssc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sssc` (
  `id_section` varchar(32) NOT NULL,
  `id_model` varchar(32) NOT NULL,
  `action` tinyint(4) NOT NULL DEFAULT '0',
  `r0` float NOT NULL DEFAULT '0',
  `x0` float NOT NULL DEFAULT '0',
  `r1` float NOT NULL DEFAULT '0',
  `x1` float NOT NULL DEFAULT '0',
  `vset` float NOT NULL DEFAULT '1',
  `vset_min` float NOT NULL DEFAULT '0.9',
  `vset_max` float NOT NULL DEFAULT '1.1',
  `Pfset` float NOT NULL DEFAULT '0',
  `P_min` float NOT NULL DEFAULT '-99999',
  `P_max` float NOT NULL DEFAULT '99999',
  `Qfset` float NOT NULL DEFAULT '0',
  `Q_min` float NOT NULL DEFAULT '-99999',
  `Q_max` float NOT NULL DEFAULT '99999',
  `id_control_mode` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_section`,`id_model`),
  KEY `idx_sssc_control_mode` (`id_control_mode`),
  -- CONSTRAINT `fk_sssc_control` FOREIGN KEY (`id_control_mode`) REFERENCES `sssc_control_modes` (`id_control_mode`),
  -- CONSTRAINT `fk_sssc_sections` FOREIGN KEY (`id_section`, `id_model`) REFERENCES `sections` (`id_section`, `id_model`) ON DELETE CASCADE ON UPDATE NO ACTION
  CONSTRAINT `fk_sssc_control_mode` FOREIGN KEY (`id_control_mode`) REFERENCES `sssc_control_modes` (`id_control_mode`),
  CONSTRAINT `fk_sssc_section` FOREIGN KEY (`id_section`) REFERENCES `sections` (`id_section`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_sssc_model` FOREIGN KEY (`id_model`) REFERENCES `models` (`id_model`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sssc`
--
LOCK TABLES `sssc` WRITE;
/*!40000 ALTER TABLE `sssc` DISABLE KEYS */;
/*!40000 ALTER TABLE `sssc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sssc_control_modes`
--
DROP TABLE IF EXISTS `sssc_control_modes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sssc_control_modes` (
  `id_control_mode` tinyint(4) NOT NULL,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id_control_mode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sssc_control_modes`
--
LOCK TABLES `sssc_control_modes` WRITE;
/*!40000 ALTER TABLE `sssc_control_modes` DISABLE KEYS */;
/*!40000 ALTER TABLE `sssc_control_modes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `substations`
--
DROP TABLE IF EXISTS `substations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `substations` (
  `id_substation` varchar(32) NOT NULL,
  `id_model` varchar(32) NOT NULL,
  `action` tinyint(4) NOT NULL DEFAULT '0',
  `id_zone` varchar(32) DEFAULT NULL,
  `id_province` varchar(32) DEFAULT NULL,
  `name` varchar(256) DEFAULT NULL,
  `latitude` float DEFAULT NULL,
  `longitude` float DEFAULT NULL,
  `online_date` date DEFAULT NULL,
  `offline_date` date DEFAULT NULL,
  `id_bdi` varchar(48) DEFAULT NULL,
  `comment` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`id_substation`,`id_model`),
  KEY `idx_substations_province` (`id_province`),
  KEY `idx_substations_zone` (`id_zone`),
  KEY `idx_substations_model` (`id_model`),
  -- CONSTRAINT `fk_substation_province` FOREIGN KEY (`id_province`) REFERENCES `provinces` (`id_province`),
  -- CONSTRAINT `fk_substation_zone` FOREIGN KEY (`id_zone`) REFERENCES `zones` (`id_zone`),
  -- CONSTRAINT `fk_substations_model` FOREIGN KEY (`id_model`) REFERENCES `models` (`id_model`) ON DELETE CASCADE ON UPDATE NO ACTION
  CONSTRAINT `fk_substations_province` FOREIGN KEY (`id_province`) REFERENCES `provinces` (`id_province`),
  CONSTRAINT `fk_substations_zone` FOREIGN KEY (`id_zone`) REFERENCES `zones` (`id_zone`),
  CONSTRAINT `fk_substations_model` FOREIGN KEY (`id_model`) REFERENCES `models` (`id_model`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Dumping data for table `substations`
--
LOCK TABLES `substations` WRITE;
/*!40000 ALTER TABLE `substations` DISABLE KEYS */;
INSERT INTO `substations`
  (`id_substation`,`id_model`,`action`,`id_zone` ,`id_province`,`name`,`latitude` ,`longitude` ,`online_date`,`offline_date`,`id_bdi`,`comment`) VALUES
  ('8d13c0d515ba497d9df314790cb29002','1b8131ba1aa94f8ebc30be409968869e',1,NULL,'b8c3c1bd4c7a42329c1d71bbc08473de','Gijón',43.5315,-5.70347,NULL,NULL,NULL,'Gijón'),
  ('9db4690c201547a982160547d11c6e4e','d7399d82cc8a404c81fca5b54fc395e7',1,NULL,NULL,'Barcelona',41.3888,2.15899,NULL,NULL,NULL,'Barcelona'),
  ('b36cb4678c8a4c87a25241c07db6335c','1b8131ba1aa94f8ebc30be409968869e',1,NULL,'56545f0adcbf4578b1d1f18cac695a01','Málaga',36.7183,-4.51931,NULL,NULL,NULL,'Málaga'),
  ('f66d486e13054b85b663366c51b210b5','1b8131ba1aa94f8ebc30be409968869e',1,NULL,'d4e3d411e7c0461194ad7f27b222271f','Sevilla',37.3755,-6.0251,NULL,NULL,NULL,'Sevilla');
/*!40000 ALTER TABLE `substations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `svc`
--
DROP TABLE IF EXISTS `svc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `svc` (
  `id_svc` varchar(32) NOT NULL,
  `id_model` varchar(32) NOT NULL,
  `action` tinyint(4) NOT NULL DEFAULT '0',
  `id_connectivity_node` varchar(32) NOT NULL,
  `name` varchar(256) NOT NULL DEFAULT '""',
  `vset` float NOT NULL DEFAULT '1',
  `b_max` float DEFAULT '0',
  `b_min` float DEFAULT '0',
  `secondary_id` varchar(48) DEFAULT NULL,
  `sequential` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id_svc`,`id_model`),
  KEY `idx_svc_connectivity_node_model` (`id_connectivity_node`,`id_model`),
  -- CONSTRAINT `fk_svc_connectivity_node` FOREIGN KEY (`id_connectivity_node`, `id_model`) REFERENCES `connectivity_nodes` (`id_connectivity_node`, `id_model`) ON DELETE CASCADE ON UPDATE NO ACTION
  CONSTRAINT `fk_svc_connectivity_node` FOREIGN KEY (`id_connectivity_node`) REFERENCES `connectivity_nodes` (`id_connectivity_node`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_svc_model` FOREIGN KEY (`id_model`) REFERENCES `models` (`id_model`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Static Voltage Compensator';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `svc`
--
LOCK TABLES `svc` WRITE;
/*!40000 ALTER TABLE `svc` DISABLE KEYS */;
/*!40000 ALTER TABLE `svc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `switched_shunts`
--
DROP TABLE IF EXISTS `switched_shunts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `switched_shunts` (
  `id_shunt` varchar(32) NOT NULL,
  `id_model` varchar(32) NOT NULL,
  `action` tinyint(4) NOT NULL DEFAULT '0',
  `id_connectivity_node` varchar(32) NOT NULL,
  `id_table` varchar(32) NOT NULL,
  `name` varchar(256) DEFAULT NULL,
  `secondary_id` varchar(48) DEFAULT NULL,
  `rating` float DEFAULT NULL,
  `active` tinyint(4) DEFAULT '1',
  `g` float DEFAULT '0',
  `b` float DEFAULT '0',
  `online_date` datetime DEFAULT NULL,
  `offline_date` datetime DEFAULT NULL,
  `sequential` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`id_shunt`,`id_model`),
  KEY `idx_switched_shunts_table` (`id_table`),
  KEY `idx_switched_shunts_connectivity_node_model` (`id_connectivity_node`,`id_model`),
  -- CONSTRAINT `switched_shunts_fk1` FOREIGN KEY (`id_connectivity_node`, `id_model`) REFERENCES `connectivity_nodes` (`id_connectivity_node`, `id_model`) ON DELETE CASCADE ON UPDATE NO ACTION,
  -- CONSTRAINT `switched_shunts_fk2` FOREIGN KEY (`id_table`) REFERENCES `impedance_tables` (`id_table`)
  CONSTRAINT `fk_switched_shunts_connectivity_node` FOREIGN KEY (`id_connectivity_node`) REFERENCES `connectivity_nodes` (`id_connectivity_node`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_switched_shunts_table` FOREIGN KEY (`id_table`) REFERENCES `impedance_tables` (`id_table`),
  CONSTRAINT `fk_switched_shunts_model` FOREIGN KEY (`id_model`) REFERENCES `models` (`id_model`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `switched_shunts`
--
LOCK TABLES `switched_shunts` WRITE;
/*!40000 ALTER TABLE `switched_shunts` DISABLE KEYS */;
/*!40000 ALTER TABLE `switched_shunts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `switches`
--
DROP TABLE IF EXISTS `switches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `switches` (
  `id_section` varchar(32) NOT NULL,
  `id_model` varchar(32) NOT NULL,
  `action` tinyint(4) NOT NULL DEFAULT '0',
  `normal_state` tinyint(4) NOT NULL DEFAULT '1',
  `switch_type` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_section`,`id_model`),
  KEY `idx_switches_switch_type` (`switch_type`),
  -- CONSTRAINT `fk_switches_1` FOREIGN KEY (`id_section`, `id_model`) REFERENCES `sections` (`id_section`, `id_model`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_switches_section` FOREIGN KEY (`id_section`) REFERENCES `sections` (`id_section`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_switches_switch_type` FOREIGN KEY (`switch_type`) REFERENCES `switches_types` (`id_switch_type`),
  CONSTRAINT `fk_switches_model` FOREIGN KEY (`id_model`) REFERENCES `models` (`id_model`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;



--
-- Dumping data for table `switches`
--
LOCK TABLES `switches` WRITE;
/*!40000 ALTER TABLE `switches` DISABLE KEYS */;
INSERT INTO `switches`
  (`id_section`,`id_model`,`action`,`normal_state`,`switch_type`) VALUES
  ('018bce1f634b49ae94cf8cc686e6c405','d7399d82cc8a404c81fca5b54fc395e7',1,1,0),
  ('03a9f58df60e4d9f8aa9cd6ac786aee8','d7399d82cc8a404c81fca5b54fc395e7',1,1,0),
  ('0dba01654b0340d8981ba4922fef2489','1b8131ba1aa94f8ebc30be409968869e',1,1,1),
  ('10530aad36bd43bcb271ca2b9cc1339f','1b8131ba1aa94f8ebc30be409968869e',1,1,0),
  ('14816741a3574c3898969a29f61382ce','1b8131ba1aa94f8ebc30be409968869e',1,1,0),
  ('16194f064dc042d6811a1b35f623470e','d7399d82cc8a404c81fca5b54fc395e7',1,1,0),
  ('175ebf8b030f47dab6253c9798b05cfb','1b8131ba1aa94f8ebc30be409968869e',1,1,0),
  ('204fea48fc0145f5a70885376effdf0c','1b8131ba1aa94f8ebc30be409968869e',1,1,0),
  ('2431ccf6d8264333a9825cf539ed3cff','d7399d82cc8a404c81fca5b54fc395e7',1,1,1),
  ('2704c0643f984607995a7c1d002868e6','1b8131ba1aa94f8ebc30be409968869e',1,1,1),
  ('2c358e08f1ce4254a1be6b44e2a2f6cf','883376684f3e4dedbe831f6e6b2a1ab8',1,1,0),
  ('2d33e0835dfe44619ab6cb19998b19da','1b8131ba1aa94f8ebc30be409968869e',1,1,1),
  ('2fa5317387954a3ab6643652f47d29d3','883376684f3e4dedbe831f6e6b2a1ab8',1,1,0),
  ('301c5bcbcd5e418c9f762dcda4db2c65','1b8131ba1aa94f8ebc30be409968869e',1,1,0),
  ('3282195a7aef43d7a4f1453059f11bcf','1b8131ba1aa94f8ebc30be409968869e',1,1,1),
  ('476822dadc3e4c40841a5d1f8a26eee5','1b8131ba1aa94f8ebc30be409968869e',1,1,0),
  ('489a81f4e52c4389ae9ff536c12a87ec','1b8131ba1aa94f8ebc30be409968869e',1,1,0),
  ('4a51c3b1332e483db962ea814851d43e','1b8131ba1aa94f8ebc30be409968869e',1,1,0),
  ('4e9c9d85cac64e6ab10a6a3b73ed040c','1b8131ba1aa94f8ebc30be409968869e',1,1,1),
  ('592c908a1b034ed9bb0c2e616dc15a33','1b8131ba1aa94f8ebc30be409968869e',1,1,0),
  ('59307e467ae74533859a2d22d2157add','1b8131ba1aa94f8ebc30be409968869e',1,1,0),
  ('5998c99f9ddf489d9eb885228d9e4d83','1b8131ba1aa94f8ebc30be409968869e',1,1,1),
  ('5bbeb19027874225af25cfba9d8df0ae','d7399d82cc8a404c81fca5b54fc395e7',1,1,0),
  ('61850b9dee474a1fa2822b2e3074fabd','1b8131ba1aa94f8ebc30be409968869e',1,1,0),
  ('64ed69d3cbbf443f9a7a33a13a39dc41','1b8131ba1aa94f8ebc30be409968869e',1,1,1),
  ('694587e4245f4437a0216e24ccecdc47','1b8131ba1aa94f8ebc30be409968869e',1,1,0),
  ('6b20530bb5ae46629837af85e6192f15','1b8131ba1aa94f8ebc30be409968869e',1,1,0),
  ('6f19602218fe493789fbf49c357aa946','1b8131ba1aa94f8ebc30be409968869e',1,1,0),
  ('75a4f7111f954ed68d5fc6f90b45df5c','1b8131ba1aa94f8ebc30be409968869e',1,1,0),
  ('80ee040765964aab84a1567b604d9222','1b8131ba1aa94f8ebc30be409968869e',1,1,0),
  ('82562dbc68d44b50955683341b8576a5','883376684f3e4dedbe831f6e6b2a1ab8',1,1,0),
  ('84d1a846a6d1479aa303a3bd0a2528cb','d7399d82cc8a404c81fca5b54fc395e7',1,1,1),
  ('882507ee84284c03ad35981632ebe284','d7399d82cc8a404c81fca5b54fc395e7',1,1,0),
  ('89648e78ff9c4f92bcdc8f497a02c067','1b8131ba1aa94f8ebc30be409968869e',1,1,0),
  ('8dd707f55c1f444db458b2832b16be4c','883376684f3e4dedbe831f6e6b2a1ab8',1,1,0),
  ('9aeb529eb67c4ee386daf1b6cc652670','1b8131ba1aa94f8ebc30be409968869e',1,1,1),
  ('9b9750c171e146f19c76c7c9120429bc','1b8131ba1aa94f8ebc30be409968869e',1,1,1),
  ('9e31c2edf3de49b698d1b624ec28ac7b','1b8131ba1aa94f8ebc30be409968869e',1,1,1),
  ('9fc783880b8343dcbd9062eade599e38','1b8131ba1aa94f8ebc30be409968869e',1,1,1),
  ('a062e006bb81439c9a3c8b4733c5a426','883376684f3e4dedbe831f6e6b2a1ab8',1,1,1),
  ('b820515899c844a496b8863891b1d3b3','883376684f3e4dedbe831f6e6b2a1ab8',1,1,1),
  ('ba6797bd7c5649f0ad0b575f38a49226','1b8131ba1aa94f8ebc30be409968869e',1,1,0),
  ('bbfd60d908f542e4932b89e1e1da4b69','1b8131ba1aa94f8ebc30be409968869e',1,1,1),
  ('bce66f65d98145dd96b36215f559cbfd','1b8131ba1aa94f8ebc30be409968869e',1,1,1),
  ('bd9a5a2e634d4811853f0e3c31d7cd69','1b8131ba1aa94f8ebc30be409968869e',1,1,0),
  ('be235955a329417892ee0ea507dbf555','1b8131ba1aa94f8ebc30be409968869e',1,1,0),
  ('cb5f7e82e6564c68b79eee506bc6c6d6','d7399d82cc8a404c81fca5b54fc395e7',1,1,0),
  ('ccbb06fe8b004dbab910b8ccb8e5ddec','1b8131ba1aa94f8ebc30be409968869e',1,1,0),
  ('cd6cbd5e0ce74dda8ffb17d6183c6481','d7399d82cc8a404c81fca5b54fc395e7',1,1,1),
  ('d632b9df84a0471eb6ffd5c49d0733d4','1b8131ba1aa94f8ebc30be409968869e',1,1,0),
  ('db5a825f24054b6d97810dd6917bd6df','1b8131ba1aa94f8ebc30be409968869e',1,1,1),
  ('f58ce764de7c47c391dce069385bcec3','1b8131ba1aa94f8ebc30be409968869e',1,1,0),
  ('f7ee8e3a41cf485da80ef92e6fafc37a','1b8131ba1aa94f8ebc30be409968869e',1,1,0),
  ('f87d7ff16f5547af82616434a97351f5','1b8131ba1aa94f8ebc30be409968869e',1,1,1),
  ('fe5ec7281f6940398e297710e7f5f33a','1b8131ba1aa94f8ebc30be409968869e',1,1,0),
  ('ff1652a2d9e34e2f9420081105fb541c','d7399d82cc8a404c81fca5b54fc395e7',1,1,1);
/*!40000 ALTER TABLE `switches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `switches_types`
--
DROP TABLE IF EXISTS `switches_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `switches_types` (
  `id_switch_type` int(11) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_switch_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;



--
-- Dumping data for table `switches_types`
--
LOCK TABLES `switches_types` WRITE;
/*!40000 ALTER TABLE `switches_types` DISABLE KEYS */;
INSERT INTO `switches_types`
  (`id_switch_type`,`name`) VALUES
  (0,'isolator'),
  (1,'Breaker');
/*!40000 ALTER TABLE `switches_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tap_changers`
--
DROP TABLE IF EXISTS `tap_changers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tap_changers` (
  `id_tap_changer` varchar(32) NOT NULL,
  `max_tap_position` int(11) DEFAULT NULL,
  `min_tap_position` int(11) DEFAULT NULL,
  `inc_tap` float DEFAULT NULL,
  `default_tap_position` int(11) DEFAULT NULL,
  `current_tap_position` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_tap_changer`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tap_changers`
--
LOCK TABLES `tap_changers` WRITE;
/*!40000 ALTER TABLE `tap_changers` DISABLE KEYS */;
/*!40000 ALTER TABLE `tap_changers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tcsc`
--
DROP TABLE IF EXISTS `tcsc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tcsc` (
  `id_section` varchar(32) NOT NULL,
  `id_model` varchar(32) NOT NULL,
  `action` tinyint(4) NOT NULL DEFAULT '0',
  `Kw` float DEFAULT '0',
  `p_ref` float DEFAULT '0',
  `T1` float DEFAULT '0',
  `T2` float DEFAULT '0',
  `T3` float DEFAULT '0',
  `Tw` float DEFAULT '0',
  `xc` float DEFAULT '0',
  `xl` float DEFAULT '0',
  `x_max` float DEFAULT '0',
  `x_min` float DEFAULT '0',
  PRIMARY KEY (`id_section`,`id_model`),
  -- CONSTRAINT `fk_tcsc_sections` FOREIGN KEY (`id_section`, `id_model`) REFERENCES `sections` (`id_section`, `id_model`) ON DELETE CASCADE ON UPDATE NO ACTION
  CONSTRAINT `fk_tcsc_section` FOREIGN KEY (`id_section`) REFERENCES `sections` (`id_section`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_tcsc_model` FOREIGN KEY (`id_model`) REFERENCES `models` (`id_model`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tcsc`
--
LOCK TABLES `tcsc` WRITE;
/*!40000 ALTER TABLE `tcsc` DISABLE KEYS */;
/*!40000 ALTER TABLE `tcsc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `thermal_generators`
--
DROP TABLE IF EXISTS `thermal_generators`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `thermal_generators` (
  `id_generator` varchar(32) NOT NULL,
  `id_model` varchar(32) NOT NULL,
  `action` tinyint(4) NOT NULL DEFAULT '0',
  `heat_rate_base` float DEFAULT NULL,
  `heat_rate_inc` float DEFAULT NULL,
  `heat_rate_inc2` float DEFAULT NULL,
  PRIMARY KEY (`id_generator`,`id_model`),
  -- CONSTRAINT `thermal_generators_ibfk_1` FOREIGN KEY (`id_generator`, `id_model`) REFERENCES `generators` (`id_generator`, `id_model`) ON DELETE CASCADE ON UPDATE NO ACTION
  CONSTRAINT `fk_thermal_generators_generator` FOREIGN KEY (`id_generator`) REFERENCES `generators` (`id_generator`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_thermal_generators_model` FOREIGN KEY (`id_model`) REFERENCES `models` (`id_model`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `thermal_generators`
--
LOCK TABLES `thermal_generators` WRITE;
/*!40000 ALTER TABLE `thermal_generators` DISABLE KEYS */;
/*!40000 ALTER TABLE `thermal_generators` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `thermal_generators_emissions`
--
DROP TABLE IF EXISTS `thermal_generators_emissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `thermal_generators_emissions` (
  `id_generator` varchar(32) NOT NULL,
  `id_emissions` varchar(32) NOT NULL,
  PRIMARY KEY (`id_generator`,`id_emissions`),
  KEY `idx_thermal_generators_emissions_emissions` (`id_emissions`),
  -- CONSTRAINT `thermal_generators_emissions_ibfk_1` FOREIGN KEY (`id_emissions`) REFERENCES `emissions` (`id_emissions`),
  -- CONSTRAINT `thermal_generators_emissions_ibfk_2` FOREIGN KEY (`id_generator`) REFERENCES `thermal_generators` (`id_generator`)
  CONSTRAINT `fk_thermal_generators_emissions_emissions` FOREIGN KEY (`id_emissions`) REFERENCES `emissions` (`id_emissions`),
  CONSTRAINT `fk_thermal_generators_emissions_generator` FOREIGN KEY (`id_generator`) REFERENCES `thermal_generators` (`id_generator`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `thermal_generators_emissions`
--
LOCK TABLES `thermal_generators_emissions` WRITE;
/*!40000 ALTER TABLE `thermal_generators_emissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `thermal_generators_emissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `thermal_generators_fuels`
--
DROP TABLE IF EXISTS `thermal_generators_fuels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `thermal_generators_fuels` (
  `id_generator` varchar(32) NOT NULL,
  -- valorar si añadir id_model
  `id_fuel` varchar(32) NOT NULL,
  PRIMARY KEY (`id_generator`,`id_fuel`),
  KEY `idx_thermal_generators_fuels_fuel` (`id_fuel`),
  -- CONSTRAINT `thermal_generators_fuels_ibfk_1` FOREIGN KEY (`id_fuel`) REFERENCES `fuels` (`id_fuel`),
  -- CONSTRAINT `thermal_generators_fuels_ibfk_2` FOREIGN KEY (`id_generator`) REFERENCES `thermal_generators` (`id_generator`)
  CONSTRAINT `fk_thermal_generators_fuels_fuel` FOREIGN KEY (`id_fuel`) REFERENCES `fuels` (`id_fuel`),
  CONSTRAINT `fk_thermal_generators_fuels_generator` FOREIGN KEY (`id_generator`) REFERENCES `thermal_generators` (`id_generator`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `thermal_generators_fuels`
--
LOCK TABLES `thermal_generators_fuels` WRITE;
/*!40000 ALTER TABLE `thermal_generators_fuels` DISABLE KEYS */;
/*!40000 ALTER TABLE `thermal_generators_fuels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transformers2w`
--
DROP TABLE IF EXISTS `transformers2w`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transformers2w` (
  `id_section` varchar(32) NOT NULL,
  `id_model` varchar(32) NOT NULL,
  `action` tinyint(4) NOT NULL DEFAULT '0',
  `r0` double DEFAULT NULL,
  `x0` double DEFAULT NULL,
  `g0` double DEFAULT NULL,
  `b0` double DEFAULT NULL,
  `r1` double DEFAULT NULL,
  `x1` double DEFAULT NULL,
  `g1` double DEFAULT NULL,
  `b1` double DEFAULT NULL,
  `HVnom` float DEFAULT NULL COMMENT 'Higher voltage nominal voltage in kV',
  `LVnom` float DEFAULT NULL COMMENT 'Lower voltage nominal voltage in kV',
  PRIMARY KEY (`id_section`,`id_model`),
  -- CONSTRAINT `fk_transformer2w_1` FOREIGN KEY (`id_section`, `id_model`) REFERENCES `sections` (`id_section`, `id_model`) ON DELETE CASCADE ON UPDATE NO ACTION
  CONSTRAINT `fk_transformers2w_section` FOREIGN KEY (`id_section`) REFERENCES `sections` (`id_section`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_transformers2w_model` FOREIGN KEY (`id_model`) REFERENCES `models` (`id_model`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;



--
-- Dumping data for table `transformers2w`
--
LOCK TABLES `transformers2w` WRITE;
/*!40000 ALTER TABLE `transformers2w` DISABLE KEYS */;
INSERT INTO `transformers2w`
  (`id_section`,`id_model`,`action`,`r0`,`x0`,`g0`,`b0`,`r1`,`x1`,`g1`,`b1`,`HVnom`,`LVnom`) VALUES
  ('a5bed7fb497a4b968de3d183e63a2ec0','1b8131ba1aa94f8ebc30be409968869e',1,0,0,0,0,0,0,0,0,400,200);
/*!40000 ALTER TABLE `transformers2w` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transformers2w_phase_shifters`
--
DROP TABLE IF EXISTS `transformers2w_phase_shifters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transformers2w_phase_shifters` (
  `id_section` varchar(32) NOT NULL,
  `id_model` varchar(32) NOT NULL,
  `action` tinyint(4) NOT NULL DEFAULT '0',
  `r0` float NOT NULL DEFAULT '0',
  `x0` float NOT NULL DEFAULT '0',
  `g0` float NOT NULL DEFAULT '0',
  `b0` float NOT NULL DEFAULT '0',
  `r1` float DEFAULT '0',
  `x1` float DEFAULT '0',
  `g1` float DEFAULT '0',
  `b1` float DEFAULT '0',
  `tap_positions` int(11) DEFAULT '1',
  `min_angle` float DEFAULT '-6.28' COMMENT 'Min angle in radians',
  `max_angle` float DEFAULT '6.28' COMMENT 'Max angle in radians',
  `default_position` int(11) DEFAULT '0',
  `min_power` float DEFAULT '-10000000000',
  `max_power` float DEFAULT '10000000000',
  `HVnom` float DEFAULT '1',
  `LVnom` float DEFAULT '1',
  PRIMARY KEY (`id_section`,`id_model`),
  KEY `idx_transformers2w_phase_shifters_section_model` (`id_section`,`id_model`),
  -- CONSTRAINT `fk_phase_shifter1` FOREIGN KEY (`id_section`, `id_model`) REFERENCES `sections` (`id_section`, `id_model`) ON DELETE CASCADE ON UPDATE NO ACTION
  CONSTRAINT `fk_transformers2w_phase_shifters_section` FOREIGN KEY (`id_section`) REFERENCES `sections` (`id_section`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_transformers2w_phase_shifters_model` FOREIGN KEY (`id_model`) REFERENCES `models` (`id_model`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transformers2w_phase_shifters`
--
LOCK TABLES `transformers2w_phase_shifters` WRITE;
/*!40000 ALTER TABLE `transformers2w_phase_shifters` DISABLE KEYS */;
/*!40000 ALTER TABLE `transformers2w_phase_shifters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transformers2w_voltage_regulators`
--
DROP TABLE IF EXISTS `transformers2w_voltage_regulators`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transformers2w_voltage_regulators` (
  `id_section` varchar(32) NOT NULL,
  `id_model` varchar(32) NOT NULL,
  `action` tinyint(4) NOT NULL DEFAULT '0',
  `r0` float NOT NULL DEFAULT '0',
  `x0` float NOT NULL DEFAULT '0',
  `g0` float NOT NULL DEFAULT '0',
  `b0` float NOT NULL DEFAULT '0',
  `r1` float NOT NULL DEFAULT '0',
  `x1` float NOT NULL DEFAULT '0',
  `g1` float NOT NULL DEFAULT '0',
  `b1` float NOT NULL DEFAULT '0',
  `tap_positions` int(11) NOT NULL DEFAULT '1',
  `max_ratio` float NOT NULL DEFAULT '1.05',
  `min_ratio` float NOT NULL DEFAULT '0.95',
  `default_position` int(11) NOT NULL DEFAULT '0',
  `min_voltage` float DEFAULT '0.9',
  `max_voltage` float DEFAULT '1.1',
  `HVnom` float DEFAULT '1',
  `LVnom` float DEFAULT '1',
  PRIMARY KEY (`id_model`,`id_section`),
  KEY `idx_transformer2w_voltage_regulators_section_model` (`id_section`,`id_model`),
  -- CONSTRAINT `fk_transformer2w_voltage_regulators` FOREIGN KEY (`id_section`, `id_model`) REFERENCES `sections` (`id_section`, `id_model`) ON DELETE CASCADE ON UPDATE NO ACTION
  CONSTRAINT `fk_transformers2w_voltage_regulators_section` FOREIGN KEY (`id_section`) REFERENCES `sections` (`id_section`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_transformers2w_voltage_regulators_model` FOREIGN KEY (`id_model`) REFERENCES `models` (`id_model`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transformers2w_voltage_regulators`
--
LOCK TABLES `transformers2w_voltage_regulators` WRITE;
/*!40000 ALTER TABLE `transformers2w_voltage_regulators` DISABLE KEYS */;
/*!40000 ALTER TABLE `transformers2w_voltage_regulators` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transformersnw`
--
DROP TABLE IF EXISTS `transformersnw`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transformersnw` (
  `id_transformer_nw` varchar(32) NOT NULL,
  `id_model` varchar(32) NOT NULL,
  `action` tinyint(4) NOT NULL DEFAULT '0',
  `name` varchar(256) DEFAULT NULL,
  `online_date` date DEFAULT NULL,
  `offline_date` date DEFAULT NULL,
  `secondary_id` varchar(48) DEFAULT NULL,
  PRIMARY KEY (`id_transformer_nw`,`id_model`),
  KEY `idx_transformersnw_model` (`id_model`),
  -- CONSTRAINT `fk_transformersnw_model` FOREIGN KEY (`id_model`) REFERENCES `models` (`id_model`) ON DELETE CASCADE ON UPDATE NO ACTION
  CONSTRAINT `fk_transformersnw_model` FOREIGN KEY (`id_model`) REFERENCES `models` (`id_model`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transformersnw`
--
LOCK TABLES `transformersnw` WRITE;
/*!40000 ALTER TABLE `transformersnw` DISABLE KEYS */;
/*!40000 ALTER TABLE `transformersnw` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transformersnw_windings`
--
DROP TABLE IF EXISTS `transformersnw_windings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transformersnw_windings` (
  `id_transformer_nw` varchar(32) NOT NULL,
  `id_section` varchar(32) NOT NULL,
  `id_model` varchar(32) NOT NULL,
  `action` tinyint(4) NOT NULL,
  PRIMARY KEY (`id_transformer_nw`,`id_model`,`id_section`),
  KEY `idx_transformersnw_windings_transformer_nw` (`id_transformer_nw`),
  KEY `idx_transformersnw_windings_section_model` (`id_section`,`id_model`),
  -- CONSTRAINT `fk_transformer_composition_1` FOREIGN KEY (`id_section`, `id_model`) REFERENCES `windings` (`id_section`, `id_model`) ON DELETE CASCADE ON UPDATE NO ACTION,
  -- CONSTRAINT `fk_transformer_composition_2` FOREIGN KEY (`id_transformer_nw`, `id_model`) REFERENCES `transformersnw` (`id_transformer_nw`, `id_model`) ON DELETE CASCADE ON UPDATE NO ACTION
  CONSTRAINT `fk_transformersnw_windings_section` FOREIGN KEY (`id_section`) REFERENCES `windings` (`id_section`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_transformersnw_windings_transformer_nw` FOREIGN KEY (`id_transformer_nw`) REFERENCES `transformersnw` (`id_transformer_nw`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_transformersnw_windings_model` FOREIGN KEY (`id_model`) REFERENCES `models` (`id_model`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transformersnw_windings`
--
LOCK TABLES `transformersnw_windings` WRITE;
/*!40000 ALTER TABLE `transformersnw_windings` DISABLE KEYS */;
/*!40000 ALTER TABLE `transformersnw_windings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `upfc`
--
DROP TABLE IF EXISTS `upfc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `upfc` (
  `id_section` varchar(32) NOT NULL,
  `id_model` varchar(32) NOT NULL,
  `action` tinyint(4) NOT NULL DEFAULT '0',
  `vsh` float NOT NULL DEFAULT '1',
  `Pfset` float NOT NULL DEFAULT '0',
  `Qfset` float NOT NULL DEFAULT '0',
  `rl` float NOT NULL DEFAULT '0',
  `xl` float NOT NULL DEFAULT '0',
  `bl` float NOT NULL DEFAULT '0',
  `rs` float NOT NULL DEFAULT '0',
  `xs` float NOT NULL DEFAULT '0',
  `rsh` float NOT NULL DEFAULT '0',
  `xsh` float NOT NULL DEFAULT '0',
  `id_control_mode` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_section`,`id_model`),
  KEY `idx_upfc_control_mode` (`id_control_mode`),
  -- CONSTRAINT `fk_upfc_ctrl` FOREIGN KEY (`id_control_mode`) REFERENCES `upfc_control_modes` (`id_control_mode`),
  -- CONSTRAINT `fk_upfc_sections` FOREIGN KEY (`id_section`, `id_model`) REFERENCES `sections` (`id_section`, `id_model`) ON DELETE CASCADE ON UPDATE NO ACTION
  CONSTRAINT `fk_upfc_control_mode` FOREIGN KEY (`id_control_mode`) REFERENCES `upfc_control_modes` (`id_control_mode`),
  CONSTRAINT `fk_upfc_section` FOREIGN KEY (`id_section`) REFERENCES `sections` (`id_section`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_upfc_model` FOREIGN KEY (`id_model`) REFERENCES `models` (`id_model`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `upfc`
--
LOCK TABLES `upfc` WRITE;
/*!40000 ALTER TABLE `upfc` DISABLE KEYS */;
/*!40000 ALTER TABLE `upfc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `upfc_control_modes`
--
DROP TABLE IF EXISTS `upfc_control_modes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `upfc_control_modes` (
  `id_control_mode` tinyint(4) NOT NULL,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id_control_mode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `upfc_control_modes`
--
LOCK TABLES `upfc_control_modes` WRITE;
/*!40000 ALTER TABLE `upfc_control_modes` DISABLE KEYS */;
/*!40000 ALTER TABLE `upfc_control_modes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `voltage_level_configurations`
--
DROP TABLE IF EXISTS `voltage_level_configurations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `voltage_level_configurations` (
  `id_voltage_level_configuration` varchar(32) NOT NULL,
  `voltage_level_configuration` varchar(64) NOT NULL,
  PRIMARY KEY (`id_voltage_level_configuration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Dumping data for table `voltage_level_configurations`
--
LOCK TABLES `voltage_level_configurations` WRITE;
/*!40000 ALTER TABLE `voltage_level_configurations` DISABLE KEYS */;
INSERT INTO `voltage_level_configurations`
  (`id_voltage_level_configuration`,`voltage_level_configuration`) VALUES
  ('220eaff2739e49cbb6eb4cbf9a70c166','Doble Barra Con Doble Interruptor'),
  ('244c4ef5b4cd431a9d5c88152191ee93','Default'),
  ('262558eebc50442d8b3d3a2cde0c22a5','Doble Barra Con Barras De Transferencia'),
  ('301de393d90e4b48b2050ba17a4e4be2','Doble Barra'),
  ('3167208822074ffcb301983f160f1023','Barra Simple Con Transferencia'),
  ('50bdd39c73c644c386c89db99fbe67b4','Interruptor y Medio'),
  ('6dbb50cd23d344cdad591e0cb305268b','Conexión en T'),
  ('6e8f435c92b64d77be3f433dd92e2bc4','Binudo Con Dobles Barras'),
  ('95d9591f42004afc888cbe63cc3a9d3e','Barra Simple'),
  ('e4f4654af6724aacb05874053ed1ede6','Triple Barra'),
  ('f890dd5c7bc54242816664fc55cff34b','Anillo'),
  ('ff249b1e08f54d108c9317a18ac5355c','NSR');
/*!40000 ALTER TABLE `voltage_level_configurations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `voltage_level_types`
--
DROP TABLE IF EXISTS `voltage_level_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `voltage_level_types` (
  `id_voltage_level_type` varchar(32) NOT NULL,
  `voltage_level_type` varchar(64) NOT NULL,
  PRIMARY KEY (`id_voltage_level_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;



--
-- Dumping data for table `voltage_level_types`
--
LOCK TABLES `voltage_level_types` WRITE;
/*!40000 ALTER TABLE `voltage_level_types` DISABLE KEYS */;
INSERT INTO `voltage_level_types`
  (`id_voltage_level_type`,`voltage_level_type`) VALUES
  ('12482db1abd44324a521376132304062','Blindada Exterior'),
  ('15ac256ddab7469cb328ca8061d2d290','Default'),
  ('3aea968d39354781b0ded5d21a50a4d5','Convencional Interior'),
  ('51871fc672d847ddb6e30113ca688457','Blindada Interior'),
  ('9d7ecd1647a34139b52a19120891b494','Híbrido Interior'),
  ('caa4c2041b594927862ad16765deb9e8','Convencional Exterior'),
  ('e579ee3263824a31bcaabd6bef3e635c','Híbrido Exterior');
/*!40000 ALTER TABLE `voltage_level_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `voltage_levels`
--
DROP TABLE IF EXISTS `voltage_levels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `voltage_levels` (
  `id_voltage_level` varchar(32) NOT NULL,
  `id_model` varchar(32) NOT NULL,
  `action` tinyint(4) NOT NULL DEFAULT '0',
  `id_substation` varchar(32) NOT NULL,
  `id_voltage_level_type` varchar(32) NOT NULL,
  `id_voltage_level_configuration` varchar(32) DEFAULT NULL,
  `voltage` float NOT NULL,
  `online_date` date DEFAULT NULL,
  `offline_date` date DEFAULT NULL,
  `id_bdi` varchar(48) DEFAULT NULL,
  `comment` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`id_voltage_level`,`id_model`),
  KEY `idx_voltage_levels_voltage_level_type` (`id_voltage_level_type`),
  KEY `idx_voltage_levels_voltage_level_configuration` (`id_voltage_level_configuration`),
  KEY `idx_voltage_levels_model` (`id_model`),
  KEY `idx_voltage_levels_substation_model` (`id_substation`,`id_model`),
  -- CONSTRAINT `fk_voltage_levels_substation` FOREIGN KEY (`id_substation`, `id_model`) REFERENCES `substations` (`id_substation`, `id_model`) ON DELETE CASCADE ON UPDATE NO ACTION,
  -- CONSTRAINT `fk_voltage_levels_voltage_level_type` FOREIGN KEY (`id_voltage_level_type`) REFERENCES `voltage_level_types` (`id_voltage_level_type`),
  -- CONSTRAINT `fk_voltage_levels_voltage_level_configuration` FOREIGN KEY (`id_voltage_level_configuration`) REFERENCES `voltage_level_configurations` (`id_voltage_level_configuration`),
  -- CONSTRAINT `fk_voltage_levels_model` FOREIGN KEY (`id_model`) REFERENCES `models` (`id_model`) ON DELETE CASCADE ON UPDATE NO ACTION
  CONSTRAINT `fk_voltage_levels_substation` FOREIGN KEY (`id_substation`) REFERENCES `substations` (`id_substation`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_voltage_levels_voltage_level_type` FOREIGN KEY (`id_voltage_level_type`) REFERENCES `voltage_level_types` (`id_voltage_level_type`),
  CONSTRAINT `fk_voltage_levels_voltage_level_configuration` FOREIGN KEY (`id_voltage_level_configuration`) REFERENCES `voltage_level_configurations` (`id_voltage_level_configuration`),
  CONSTRAINT `fk_voltage_levels_model` FOREIGN KEY (`id_model`) REFERENCES `models` (`id_model`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Dumping data for table `voltage_levels`
--
LOCK TABLES `voltage_levels` WRITE;
/*!40000 ALTER TABLE `voltage_levels` DISABLE KEYS */;
INSERT INTO `voltage_levels`
  (`id_voltage_level`,`id_model`,`action`,`id_substation`,`id_voltage_level_type`,`id_voltage_level_configuration`,`voltage`,`online_date`,`offline_date`,`id_bdi`,`comment`) VALUES
  ('1a87cf8e36194ab7a536d19bc56b770a','1b8131ba1aa94f8ebc30be409968869e',1,'b36cb4678c8a4c87a25241c07db6335c','caa4c2041b594927862ad16765deb9e8','301de393d90e4b48b2050ba17a4e4be2',220,NULL,NULL,NULL,'subestacion 1 parque 1'),
  ('4c6f97d6e21a40aba03c62f8dd2d9979','1b8131ba1aa94f8ebc30be409968869e',1,'b36cb4678c8a4c87a25241c07db6335c','caa4c2041b594927862ad16765deb9e8','301de393d90e4b48b2050ba17a4e4be2',400,NULL,NULL,NULL,'subestacion 1 parque 2'),
  ('fa633d70cf2b4c299a852a627051673c','1b8131ba1aa94f8ebc30be409968869e',1,'f66d486e13054b85b663366c51b210b5','caa4c2041b594927862ad16765deb9e8','301de393d90e4b48b2050ba17a4e4be2',400,NULL,NULL,NULL,'subestacion 2 parque 3'),
  ('48ce7abce09c4568bc28d86f7b20c486','1b8131ba1aa94f8ebc30be409968869e',1,'8d13c0d515ba497d9df314790cb29002','caa4c2041b594927862ad16765deb9e8','301de393d90e4b48b2050ba17a4e4be2',400,NULL,NULL,NULL,'subestacion 3 parque 4'),
  ('271f651a18754726b5cf54b6b34a03b6','d7399d82cc8a404c81fca5b54fc395e7',1,'9db4690c201547a982160547d11c6e4e','caa4c2041b594927862ad16765deb9e8','301de393d90e4b48b2050ba17a4e4be2',400,NULL,NULL,NULL,'subestacion 4 parque 5');
/*!40000 ALTER TABLE `voltage_levels` ENABLE KEYS */;
UNLOCK TABLES;



--
-- Table structure for table `vsc`
--
DROP TABLE IF EXISTS `vsc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vsc` (
  `id_section` varchar(32) NOT NULL,
  `id_model` varchar(32) NOT NULL,
  `action` tinyint(4) NOT NULL DEFAULT '0',
  `r` float DEFAULT NULL,
  `x` float DEFAULT NULL,
  `id_control_mode` tinyint(4) NOT NULL DEFAULT '0',
  `m` float DEFAULT NULL,
  `m_max` float DEFAULT NULL,
  `m_min` float DEFAULT NULL,
  `theta` float DEFAULT NULL,
  `theta_min` float DEFAULT NULL,
  `theta_max` float DEFAULT NULL,
  `Beq` float DEFAULT NULL,
  `Beq_min` float DEFAULT NULL,
  `Beq_max` float DEFAULT NULL,
  `alpha1` float DEFAULT NULL,
  `alpha2` float DEFAULT NULL,
  `alpha3` float DEFAULT NULL,
  `k` float DEFAULT NULL,
  `kdp` float DEFAULT NULL,
  `Pac_set` float DEFAULT '0',
  `Pdc_set` float DEFAULT '0',
  `vsc_set` float DEFAULT '1',
  `vdc_set` float DEFAULT '1',
  PRIMARY KEY (`id_section`,`id_model`),
  KEY `idx_vsc_control_model` (`id_control_mode`),
  -- CONSTRAINT `fk_vsc_1` FOREIGN KEY (`id_section`, `id_model`) REFERENCES `sections` (`id_section`, `id_model`) ON DELETE CASCADE ON UPDATE NO ACTION,
  -- CONSTRAINT `fk_vsc_2` FOREIGN KEY (`id_control_mode`) REFERENCES `vsc_control_modes` (`id_vsc_control_mode`)
  CONSTRAINT `fk_vsc_section` FOREIGN KEY (`id_section`) REFERENCES `sections` (`id_section`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_vsc_control_mode` FOREIGN KEY (`id_control_mode`) REFERENCES `vsc_control_modes` (`id_vsc_control_mode`),
  CONSTRAINT `fk_vsc_model` FOREIGN KEY (`id_model`) REFERENCES `models` (`id_model`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vsc`
--
LOCK TABLES `vsc` WRITE;
/*!40000 ALTER TABLE `vsc` DISABLE KEYS */;
/*!40000 ALTER TABLE `vsc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vsc_control_modes`
--
DROP TABLE IF EXISTS `vsc_control_modes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vsc_control_modes` (
  `id_vsc_control_mode` tinyint(4) NOT NULL,
  `name` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id_vsc_control_mode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vsc_control_modes`
--
LOCK TABLES `vsc_control_modes` WRITE;
/*!40000 ALTER TABLE `vsc_control_modes` DISABLE KEYS */;
/*!40000 ALTER TABLE `vsc_control_modes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `windings`
--
DROP TABLE IF EXISTS `windings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `windings` (
  `id_section` varchar(32) NOT NULL,
  `id_model` varchar(32) NOT NULL,
  `action` tinyint(4) NOT NULL DEFAULT '0',
  `r0` double DEFAULT NULL,
  `x0` double DEFAULT NULL,
  `g0` double DEFAULT NULL,
  `b0` double DEFAULT NULL,
  `r1` double DEFAULT NULL,
  `x1` double DEFAULT NULL,
  `g1` double DEFAULT NULL,
  `b1` double DEFAULT NULL,
  `r2` double DEFAULT NULL,
  `x2` double DEFAULT NULL,
  `g2` double DEFAULT NULL,
  `b2` double DEFAULT NULL,
  `Vnomf` float DEFAULT NULL,
  `Vnomt` float DEFAULT NULL,
  PRIMARY KEY (`id_section`,`id_model`),
  -- CONSTRAINT `fk_windings_1` FOREIGN KEY (`id_section`, `id_model`) REFERENCES `sections` (`id_section`, `id_model`) ON DELETE CASCADE ON UPDATE NO ACTION
  CONSTRAINT `fk_windings_section` FOREIGN KEY (`id_section`) REFERENCES `sections` (`id_section`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_windings_model` FOREIGN KEY (`id_model`) REFERENCES `sections` (`id_model`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `windings`
--
LOCK TABLES `windings` WRITE;
/*!40000 ALTER TABLE `windings` DISABLE KEYS */;
/*!40000 ALTER TABLE `windings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zones`
--
DROP TABLE IF EXISTS `zones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zones` (
  `id_zone` varchar(32) NOT NULL,
  `name` varchar(256) DEFAULT NULL,
  `code` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_zone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;




--
-- Dumping data for table `zones`
--
LOCK TABLES `zones` WRITE;
/*!40000 ALTER TABLE `zones` DISABLE KEYS */;
INSERT INTO `zones`
  (`id_zone`,`name`,`code`) VALUES
  ('04cfdb675fc111ebbf7480e82cc8ac0d','Andorra','91'),
  ('0b5b795583d04279994ffc9b8694797b','Melilla','82'),
  ('0c6be0749de342169ea2a7720c400365','Ireland','102'),
  ('1d9bc07e5446483680c03f739b7d0f93','Sur','5'),
  ('210fa2b23dc34715930dd0884b3d4367','Chile','201'),
  ('3066a862ae5c4a769dcd8e1bff391c8f','Fuerteventura','64'),
  ('3072b79a64044d7f964ce795d049d315','La Gomera','63'),
  ('3bf8c72695b7437585675970d81cca7d','Mallorca','71'),
  ('3cfbd0b88f3e4a2b8052d7490cbe63dd','Gran Canaria','61'),
  ('52ca989ee59241bca4a63b9347d6132e','Belgium','100'),
  ('57f7486857034e3e9daab3b891d01e27','Germany','101'),
  ('5d076aab648043d4aa6c0ff6cdb93df5','Formentera','74'),
  ('6bb4b65b95994f9fb8246cf4c7126316','Este','3'),
  ('71df5183321e495184256bf3071c6a7e','Tenerife','62'),
  ('7227fd8081194e31a07078b84e08bf6f','Italy','103'),
  ('72dcc238278d434d90ae06cf22a12758','United Kingdom','106'),
  ('78581deff04d4e058811c8ca60359c3c','Noroeste','1'),
  ('95170261ec8b41c1a5ba0290e0f54b18','Norte','2'),
  ('ab35ef4b5e134ad5a10ffcc05b095ef9','Portugal','6'),
  ('b716fea8202a48b6bf04eeef487a1b24','Morroco','7'),
  ('bad0240fa053464aba18eca282763727','Ceuta','81'),
  ('c3e0d86eb7ee4993b17cf483fc835c9e','Menorca','72'),
  ('c57a43e192a64c27b5cc5d55dff0dea8','Argelia','202'),
  ('caa2913c2fe0445887537f28993b4f4a','La Plama','66'),
  ('cc49a6682c8648b2b5b4413fe5a927ce','Luxembourg','104'),
  ('d1a95bd6cfa44bcfab4a337a293bef18','Switzerland','105'),
  ('d71d5b7edf434edca792d7df3ac8abd7','France','8'),
  ('db10270a444846e4aeaac3a524e8b2b3','Default','0'),
  ('e87970eb516a489ca0c20a7bb15d43d4','Lanzarote','65'),
  ('ebfb938eb6c843b2929edbff4c563f28','Centro','4'),
  ('f7dfdfb12f9f4e18a6177bece6964c32','Perú','200'),
  ('fe66f7e9374248aebcf21abc1f4939f1','Ibiza','73');
/*!40000 ALTER TABLE `zones` ENABLE KEYS */;
UNLOCK TABLES;



--
-- Dumping events for database 'assets'
--

--
-- Dumping routines for database 'assets'
--
/*!50003 DROP FUNCTION IF EXISTS `get_bus_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
DELIMITER ;;
CREATE DEFINER=`ree`@`%` FUNCTION `get_bus_id`(sid VARCHAR(48)) RETURNS varchar(32) CHARSET utf8mb4
    READS SQL DATA
BEGIN

/*
Find the Bus id from the secondary id (or PSSe number)
*/

DECLARE _bus_id VARCHAR(32);
SELECT id_bus INTO _bus_id FROM buses WHERE buses.secondary_id = sid;

RETURN _bus_id;
END ;;
DELIMITER ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `get_default_generation_technology` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` FUNCTION `get_default_generation_technology`() RETURNS varchar(32) CHARSET utf8mb4
    READS SQL DATA
BEGIN

    DECLARE val VARCHAR(32);
    SELECT id_technology  INTO val
    FROM generation_technologies WHERE name = 'Default'
    LIMIT 1;

RETURN val;
END ;;
DELIMITER ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `get_section_substation_from` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` FUNCTION `get_section_substation_from`(_id_model VARCHAR(32), _id_section VARCHAR(32)) RETURNS varchar(32) CHARSET utf8mb4
    READS SQL DATA
BEGIN

DECLARE _id_bus VARCHAR(32);

SELECT id_substation INTO _id_bus FROM substations
WHERE id_substation =
	(SELECT id_substation FROM voltage_levels
     WHERE id_voltage_level =
		(SELECT id_voltage_level from connectivity_nodes_voltage_levels
	   	 WHERE id_connectivity_node =
			(SELECT id_connectivity_node_1 FROM sections
            WHERE id_section = _id_section AND id_model = _id_model)
        )
    );

RETURN _id_bus;
END ;;
DELIMITER ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `get_section_substation_to` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` FUNCTION `get_section_substation_to`(_id_model VARCHAR(32), _id_section VARCHAR(32)) RETURNS varchar(32) CHARSET utf8mb4
    READS SQL DATA
BEGIN

DECLARE _id_bus VARCHAR(32);

SELECT id_substation INTO _id_bus FROM substations
WHERE id_substation =
	(SELECT id_substation FROM voltage_levels
     WHERE id_voltage_level =
		(SELECT id_voltage_level from connectivity_nodes_voltage_levels
	   	 WHERE id_connectivity_node =
			(SELECT id_connectivity_node_2 FROM sections
            WHERE id_section = _id_section AND id_model = _id_model)
        )
    );

RETURN _id_bus;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `tr` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
DELIMITER ;;
CREATE DEFINER=`ree`@`%` FUNCTION `tr`(`str` TEXT, `dict_from` VARCHAR(1024), `dict_to` VARCHAR(1024)) RETURNS text CHARSET utf8mb4
    NO SQL
    DETERMINISTIC
    SQL SECURITY INVOKER
BEGIN
	DECLARE len INTEGER;
	DECLARE i INTEGER;

	IF dict_to IS NOT NULL AND (CHAR_LENGTH(dict_from) != CHAR_LENGTH(dict_to)) THEN
		SET @error = CONCAT('Length of dicts does not match.');
		SIGNAL SQLSTATE '49999'
			SET MESSAGE_TEXT = @error;
	END IF;

	SET len = CHAR_LENGTH(dict_from);
	SET i = 1;

	WHILE len >= i  DO
		SET @f = SUBSTR(dict_from, i, 1);
		SET @t = IF(dict_to IS NULL, '', SUBSTR(dict_to, i, 1));

		SET str = REPLACE(str, @f, @t);
		SET i = i + 1;

	END WHILE;

	RETURN str;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `uuid_v4s` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
DELIMITER ;;
CREATE DEFINER=`ree`@`%` FUNCTION `uuid_v4s`() RETURNS char(32) CHARSET utf8mb4
    NO SQL
BEGIN
	/*
    -- Generate 8 2-byte strings that we will combine into a UUIDv4
    SET @h1 = LPAD(HEX(FLOOR(RAND() * 0xffff)), 4, '0');
    SET @h2 = LPAD(HEX(FLOOR(RAND() * 0xffff)), 4, '0');
    SET @h3 = LPAD(HEX(FLOOR(RAND() * 0xffff)), 4, '0');
    SET @h6 = LPAD(HEX(FLOOR(RAND() * 0xffff)), 4, '0');
    SET @h7 = LPAD(HEX(FLOOR(RAND() * 0xffff)), 4, '0');
    SET @h8 = LPAD(HEX(FLOOR(RAND() * 0xffff)), 4, '0');

    -- 4th section will start with a 4 indicating the version
    SET @h4 = CONCAT('4', LPAD(HEX(FLOOR(RAND() * 0x0fff)), 3, '0'));

    -- 5th section first half-byte can only be 8, 9 A or B
    SET @h5 = CONCAT(HEX(FLOOR(RAND() * 4 + 8)), LPAD(HEX(FLOOR(RAND() * 0x0fff)), 3, '0'));
    */
    
    -- -------------------------------------------------
    -- using a more secure approach with random bytes --
    -- -------------------------------------------------
    
    -- Generate 8 2-byte strings that we will combine into a UUIDv4
    SET @h1 = LOWER(HEX(RANDOM_BYTES(2)));
    SET @h2 = LOWER(HEX(RANDOM_BYTES(2)));
    SET @h3 = LOWER(HEX(RANDOM_BYTES(2)));
    SET @h6 = LOWER(HEX(RANDOM_BYTES(2)));
    SET @h7 = LOWER(HEX(RANDOM_BYTES(2)));
    SET @h8 = LOWER(HEX(RANDOM_BYTES(2)));

    -- 4th section will start with a 4 indicating the version
    SET @h4 = CONCAT('4',
					 LPAD(LOWER(HEX(RANDOM_BYTES(2))), 3, '0')  # 3 random characters
                     );

    -- 5th section first half-byte can only be 8, 9 A or B
    SET @h5 = CONCAT(HEX(FLOOR(RAND() * 4 + 8)), # Random between {8, 9, A, B}
					 LPAD(LOWER(HEX(RANDOM_BYTES(2))), 3, '0')  # 3 random characters
                     );

    -- Build the complete UUID
    RETURN LOWER(CONCAT(
        @h1, @h2, @h3,  @h4,  @h5,  @h6, @h7, @h8
    ));
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_bus` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
DELIMITER ;;
CREATE DEFINER=`ree`@`%` PROCEDURE `add_bus`(IN id_bus_ VARCHAR(32),
							IN id_voltage_level_ VARCHAR(32),
                            IN id_substation_ VARCHAR(32),
                            IN id_zone_ VARCHAR(32),
                            IN id_province_ VARCHAR(32),
                            IN bus_name_ VARCHAR(256),
                            IN voltage_level_name_ VARCHAR(256),
                            IN substation_name_ VARCHAR(256),
                            IN bus_secondary_id_ VARCHAR(256),
                            IN Vnom_ float,
                            IN latitude_ float,
                            IN longitude_ float)
BEGIN

/*  EXAMPLE:

		CALL add_bus('bus inventado', 'vl inventado', 'se inventada',
					 'b716fea8202a48b6bf04eeef487a1b24',  # id zone: Marruecos
					 '6f207382419c4bf880d6bd5c58a075e1',  # id province: Marruecos
					 'fake bus','fake vl', 'fake se', 'secondary_id 000',
					 40, 0, 0)

	TO CLEANUP:
		DELETE FROM bus_bars WHERE bus_bars.name = 'fake bus';
		DELETE FROM voltage_level WHERE voltage_level.name = 'fake vl';
		DELETE FROM substations WHERE substations.name = 'fake se';
*/

DECLARE existing_substations int;
DECLARE existing_voltage_levels int;

# log the process
CALL add_usage_log("add_bus", "id_bus", id_bus_);

# check if the substation has been created or not ------------------------------
SELECT COUNT(*)
INTO existing_substations
FROM substations
WHERE id_substation = id_substation_;

# if the substation does not exist, create it
IF (existing_substations = 0) THEN
	INSERT INTO substations
    (id_substation, id_zone, id_province, name, latitude, longitude)
    VALUES
    (id_substation_, id_zone_, id_province_, substation_name_, latitude_, longitude_)
    ON duplicate key update id_substation=id_substation_;
END IF;


# check if the voltage_level has been created or not ---------------------------
SELECT COUNT(*)
INTO existing_voltage_levels
FROM voltage_levels
WHERE id_voltage_level = id_voltage_level_;

# if the voltage_level does not exist, create it
IF (existing_voltage_levels = 0) THEN
	INSERT INTO voltage_levels
    (id_voltage_level, id_substation,  name, voltage)
    VALUES
    (id_voltage_level_, id_substation_, voltage_level_name_, Vnom_)
    ON duplicate key update id_voltage_level=id_voltage_level_;
END IF;


# create the bus
INSERT INTO buses
(id_bus, id_voltage_level, name, Vnom, secondary_id, latitude, longitude)
VALUES
(id_bus_, id_voltage_level_, bus_name_, Vnom_, bus_secondary_id_, latitude_, longitude_)
ON duplicate key update id_bus=id_bus_;



END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_generator` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
DELIMITER ;;
CREATE DEFINER=`ree`@`%` PROCEDURE `add_generator`(IN id_bus VARCHAR(32),
								  IN gen_name VARCHAR(256),
								  IN gen_secondary_id VARCHAR(48),
								  IN Snom FLOAT,
								  IN Pmin FLOAT,
								  IN Pmax FLOAT,
								  IN Qmin FLOAT,
								  IN Qmax FLOAT,
                                  OUT id_cn VARCHAR(32),
								  OUT id_gen VARCHAR(32),
								  OUT id_tech VARCHAR(32))
BEGIN


	SET id_cn = uuid_v4s();
	SET id_gen = uuid_v4s();
	SET id_tech = get_default_generation_technology();

	CALL add_generator_with_uuid(id_bus,
								 id_cn,
								 id_gen,
								 id_tech,
								 gen_name,
								 gen_secondary_id,
								 Snom,
								 Pmin,
								 Pmax,
								 Qmin,
								 Qmax);

	SELECT id_cn, id_gen, id_tech;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_generator_to_delta` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
DELIMITER ;;
CREATE DEFINER=`ree`@`%` PROCEDURE `add_generator_to_delta`(IN _id_gen VARCHAR(32),
										   IN _id_model VARCHAR(32),
                                           IN _active TINYINT(4),
                                           IN _p FLOAT,
                                           IN _v FLOAT,
                                           IN _pf FLOAT,
                                           IN _id_p_profile VARCHAR(32),
                                           IN _action TINYINT(4))
BEGIN

	# log the process
	CALL add_usage_log("add_generator_to_delta", "id_gen", _id_gen);

	INSERT INTO generators_deltas
    (id_generator, id_model, id_p_profile, active, p, q, pf, action)
    VALUES
    (_id_gen, _id_model, _id_p_profile, _active, _p, _q, _pf, _action);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_generator_to_model` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
DELIMITER ;;
CREATE DEFINER=`ree`@`%` PROCEDURE `add_generator_to_model`(IN _id_gen VARCHAR(32),
										   IN _id_model VARCHAR(32),
                                           IN _active TINYINT(4),
                                           IN _p FLOAT,
                                           IN _v FLOAT,
                                           IN _pf FLOAT,
                                           IN _id_p_profile VARCHAR(32))
BEGIN

	# log the process
	CALL add_usage_log("add_generator_to_model", "id_gen", _id_gen);

	INSERT INTO generators_models
    (id_generator, id_model, id_p_profile, active, p, q, pf)
    VALUES
    (_id_gen, _id_model, _id_p_profile, _active, _p, _q, _pf);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_generator_with_uuid` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
DELIMITER ;;
CREATE DEFINER=`ree`@`%` PROCEDURE `add_generator_with_uuid`(IN id_bus VARCHAR(32),
															 IN id_cn VARCHAR(32),
															 IN id_gen VARCHAR(32),
															 IN id_tech VARCHAR(32),
															 IN gen_name VARCHAR(256),
															 IN gen_secondary_id VARCHAR(48),
															 IN Snom FLOAT,
															 IN Pmin FLOAT,
															 IN Pmax FLOAT,
															 IN Qmin FLOAT,
															 IN Qmax FLOAT)
BEGIN

	-- DECLARE id_tech VARCHAR(32);
    -- set id_tech = get_default_generation_technology();

	# log the process
	CALL add_usage_log("add_generator_with_uuid", "id_gen", id_gen);

	# create connectivity node
    CALL create_connectivity_node(id_cn,  id_bus);

    # create the generator
    INSERT INTO generators
    (id_generator, id_connectivity_node, id_technology, name, secondary_id, snom, pmin, pmax, qmin, qmax)
    VALUES
    (id_gen, id_cn, id_tech, gen_name, gen_secondary_id, Snom, Pmin, Pmax, Qmin, Qmax)
    ON duplicate key update id_generator=id_gen;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_load_to_delta` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
DELIMITER ;;
CREATE DEFINER=`ree`@`%` PROCEDURE `add_load_to_delta`(IN _id_load VARCHAR(32),
									  IN _id_delta VARCHAR(32),
                                      IN _p FLOAT,
                                      IN _q FLOAT,
                                      IN _active TINYINT(4),
                                      IN _action TINYINT(4),
                                      IN _id_p_profile VARCHAR(32),
                                      IN _id_q_profile VARCHAR(32))
BEGIN

	# log the process
	CALL add_usage_log("add_load_to_delta", "id_load", _id_load);

    # create the insert
	INSERT INTO loads_deltas
    (id_load, id_delta, active, action, p, q, id_p_profile, id_q_profile)
    VALUES
    (_id_load, _id_delta, _active, _action, _p, _q, _id_p_profile, _id_q_profile);


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_load_to_model` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
DELIMITER ;;
CREATE DEFINER=`ree`@`%` PROCEDURE `add_load_to_model`(IN _id_load VARCHAR(32),
									  IN _id_model VARCHAR(32),
                                      IN _p FLOAT,
                                      IN _q FLOAT,
                                      IN _active TINYINT(4),
                                      IN _id_p_profile VARCHAR(32),
                                      IN _id_q_profile VARCHAR(32))
BEGIN

	# log the process
	CALL add_usage_log("add_load_to_model", "id_load", _id_load);

    # create the insert
	INSERT INTO loads_model
    (id_load, id_model, active, p, q, id_p_profile, id_q_profile)
    VALUES
    (_id_load, _id_model, _active, _p, _q, _id_p_profile, _id_q_profile);


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_load_with_uuids` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
DELIMITER ;;
CREATE DEFINER=`ree`@`%` PROCEDURE `add_load_with_uuids`(IN _id_load VARCHAR(32),
										IN _id_bus VARCHAR(32),
                                        IN _id_cn VARCHAR(32),
                                        IN _secondary_id VARCHAR(48),
                                        IN _name VARCHAR(256))
BEGIN


    # log the process
	CALL add_usage_log("add_load_with_uuids", "id_load", _id_load);

	# create connectivity node
    CALL create_connectivity_node(_id_cn,  _id_bus);

    # create the load
    INSERT INTO loads
    (id_load, id_connectivity_node, name, secondary_id)
	VALUES
    (_id_load, _id_cn, _name, _secondary_id)
    ON duplicate key update id_load=_id_load;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_power_line` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
DELIMITER ;;
CREATE DEFINER=`ree`@`%` PROCEDURE `add_power_line`(IN id_bus_from VARCHAR(32),  # ID of the bus from (table bus_bars)
													   IN id_bus_to VARCHAR(32),  # ID of the bus to (table bus_bars)
													   IN line_name VARCHAR(256), # name of the line, it is propagates to sections as well
													   IN line_name_code VARCHAR(45), # name of the line (set on the one section created)
													   IN line_r FLOAT,  # line total per unit resistance
													   IN line_x FLOAT,   # line total per unit reactance
													   IN line_b FLOAT,  # line total per unit susceptance
													   IN line_length FLOAT,   # line total length in km
													   IN line_rating FLOAT,   # line nominal rating in MW
													   OUT _id_section VARCHAR(32),  # Return: ID of the section created
													   OUT _id_line VARCHAR(32),  # Return: ID of the power line created
													   OUT _id_fk_from VARCHAR(32), # Return: ID of the connectivity node "from" created
													   OUT _id_fk_to VARCHAR(32) # Return: ID of the connectivity node "to" created
                                                       )
BEGIN

    /*  EXAMPLE:

		SET @_id_section = '';
		SET @_id_line = '';
		SET @_id_fk_from = '';
		SET @_id_fk_to = '';
		CALL add_ac_power_line('00ed1af58c324aba8e4bdd6b87bdfa6f',  # from
							   '00d58a98e2f24a78b6a77212e8fcbbfd',  # to
							   'myFakeLine',  # name
							   'fake',  # name_code
							   0.01,   # r
							   0.05,   # x
							   0.005, # b
							   10.0,  # km
							   100,   # MW
							   @_id_section,
							   @_id_line,
							   @_id_fk_from,
							   @_id_fk_to);

		SELECT @_id_section, @_id_line, @_id_fk_from, @_id_fk_to;

    */



  -- create unique id's needed for the procedure
	SET _id_section = uuid_v4s();
    SET _id_line = uuid_v4s();
    SET _id_fk_from = uuid_v4s();
    SET _id_fk_to = uuid_v4s();

    # register usage: Already called in the next function
    # CALL add_usage_log(_user_id, "add_ac_power_line", "id_line", _id_line);

    # add the power line
	CALL add_power_line_with_uuids(id_bus_from,  # from
									  id_bus_to,  # to
									  _id_section, # section
									  _id_line, # line
									  _id_fk_from, # connectivity_node from
									  _id_fk_to, # connectivity_node to
									  line_name,  # name
									  line_name_code,  # name_code
									  line_r,   # r
									  line_x,   # x
									  line_b,  # b
									  line_length,  # km
									  line_rating);  # MW
    #return the values
    SELECT _id_section, _id_line, _id_fk_from, _id_fk_to;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_power_line_to_delta` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
DELIMITER ;;
CREATE DEFINER=`ree`@`%` PROCEDURE `add_power_line_to_delta`(IN _id_line VARCHAR(32),
											   IN _id_delta VARCHAR(32),
                                               IN _active TINYINT(4),
                                               IN _rating FLOAT,
                                               IN _id_rating_profile VARCHAR(32),
                                               IN _action TINYINT(4))
BEGIN

	# register usage
    CALL add_usage_log("add_power_line_to_delta", "id_line", _id_line);

	INSERT INTO lines_deltas
    (id_line, id_delta, active, rating, id_rating_profile, action)
    VALUES
    (_id_line, _id_delta, _active, _rating, _id_rating_profile, _action);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_power_line_to_model` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
DELIMITER ;;
CREATE DEFINER=`ree`@`%` PROCEDURE `add_power_line_to_model`(IN _id_line VARCHAR(32),
											   IN _id_model VARCHAR(32),
                                               IN _active TINYINT(4),
                                               IN _rating FLOAT,
                                               IN _id_rating_profile VARCHAR(32))
BEGIN

    # register usage
    CALL add_usage_log("add_power_line_to_model", "id_line", _id_line);

	INSERT INTO lines_models
    (id_line, id_model, active, rating, id_rating_profile)
    VALUES
    (_id_line, _id_model, _active, _rating, _id_rating_profile);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_power_line_with_uuids` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
DELIMITER ;;
CREATE DEFINER=`ree`@`%` PROCEDURE `add_power_line_with_uuids`(
	IN id_bus_from VARCHAR(32),  # ID of the bus from (table bus_bars)
	IN id_bus_to VARCHAR(32),  # ID of the bus to (table bus_bars)
	IN id_section VARCHAR(32),  # ID of the section (table sections)
	IN id_line VARCHAR(32),  # ID of the power line (table lines)
	IN id_fk_from VARCHAR(32), # ID of the connectivity node "from" (table connectivity_nodes)
	IN id_fk_to VARCHAR(32), # ID of the connectivity node "to" (table connectivity_nodes)
	IN line_name VARCHAR(256), # name of the line, it is propagates to sections as well
	IN line_name_code VARCHAR(45), # name of the line (set on the one section created)
	IN line_r FLOAT,  # line total per unit resistance
	IN line_x FLOAT,   # line total per unit reactance
	IN line_b FLOAT,  # line total per unit susceptance
	IN line_length FLOAT,   # line total length in km
	IN line_rating FLOAT   # line nominal rating in MW
   )
BEGIN

    /*  EXAMPLE:

		CALL add_ac_power_line('00ed1af58c324aba8e4bdd6b87bdfa6f',  # from
							   '00d58a98e2f24a78b6a77212e8fcbbfd',  # to
							   '418db41dbea54e4a88c1d79437f28ece', # section
							   'ea44190b99534f6590bd11a830dc5aac', # line
							   '9932bbc540f24ba6956caf7c910edb16', # connectivity_node from
							   'f8fe536b56684a87bbf0bff028a5eb5c', # connectivity_node to
							   'myFakeLine',  # name
							   'fake',  # name_code
							   0.01,   # r
							   0.05,   # x
							   0.005, # b
							   10.0,  # km
							   100); # MW
    */

    # log the process
    CALL add_usage_log("add_power_line_with_uuids", "id_line", id_line);

    # create power line
    INSERT INTO power_lines(id_line, name) VALUES (id_line, line_name)
    on duplicate key update id_line=id_line;

    # create connectivity nodes
    CALL create_connectivity_node(id_fk_from,  id_bus_from);
    CALL create_connectivity_node(id_fk_to,  id_bus_to);

    # create section
    INSERT INTO sections(id_section, id_connectivity_node_1, id_connectivity_node_2, name, rating, secondary_id)
    VALUES(id_section, id_fk_from, id_fk_to, line_name, line_rating, line_name_code)
    ON duplicate key update id_section=id_section;

    # create ac_line_section
    INSERT INTO ac_line_sections(id_section, r1, x1, b1, length)
	VALUES (id_section, line_r, line_x, line_b, line_length)
    ON duplicate key update id_section=id_section;

    # create association between ac_line section and power line
    INSERT INTO power_lines_ac_line_sections(id_line, id_section)
    VALUES (id_line, id_section)
    ON duplicate key update id_line=id_line;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_substation` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
DELIMITER ;;
CREATE DEFINER=`ree`@`%` PROCEDURE `add_substation`(
	IN _id_substation varchar(32),
	IN _params JSON
)
BEGIN
    DECLARE _name VARCHAR(256)
		DEFAULT JSON_UNQUOTE(JSON_EXTRACT(_params, '$.name'));
    DECLARE _latitude FLOAT
		DEFAULT JSON_UNQUOTE(JSON_EXTRACT(_params, '$.latitude'));
    DECLARE _longitude FLOAT
		DEFAULT JSON_UNQUOTE(JSON_EXTRACT(_params, '$.longitude'));
    DECLARE _online_date DATE
		DEFAULT JSON_UNQUOTE(JSON_EXTRACT(_params, '$.online_date'));
    DECLARE _offline_date DATE
		DEFAULT JSON_UNQUOTE(JSON_EXTRACT(_params, '$.offine_date'));
    DECLARE _id_zone VARCHAR(32)
		DEFAULT JSON_UNQUOTE(JSON_EXTRACT(_params, '$.id_zone'));
    DECLARE _id_province VARCHAR(32)
		DEFAULT JSON_UNQUOTE(JSON_EXTRACT(_params, '$.id_province'));

	INSERT INTO substations
		(id_substation,
		 name,
		 latitude,
		 longitude,
		 online_date,
		 offline_date,
		 id_zone,
		 id_province)
	VALUES
		(_id_substation,
		_name,
		_latitude,
		_longitude,
		_online_date,
		_offline_date,
		_id_zone,
		_id_province);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_switch` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
DELIMITER ;;
CREATE DEFINER=`ree`@`%` PROCEDURE `add_switch`(IN id_fk_from VARCHAR(32),
							   IN id_fk_to VARCHAR(32),
                               IN id_section VARCHAR(32),
                               IN sw_name VARCHAR(256),
                               IN normal_state TINYINT(4),
                               IN switch_type TINYINT(4) # 1: switch, 2: Sectionalizer
                               )
BEGIN

# create section
INSERT INTO sections(id_section, id_connectivity_node_1, id_connectivity_node_2, name)
VALUES(id_section, id_fk_from, id_fk_to, sw_name)
ON duplicate key update id_section=id_section,
						id_connectivity_node_1=id_fk_from,
                        id_connectivity_node_2=id_fk_to,
                        name=sw_name;

# create the switch
INSERT INTO switches (id_section, normal_state, switch_type)
VALUES (id_section, normal_state, switch_type)
ON duplicate key update id_section=id_section;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_switched_shunt` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
DELIMITER ;;
CREATE DEFINER=`ree`@`%` PROCEDURE `add_switched_shunt`(IN _id_bus VARCHAR(32),
													    IN _name VARCHAR(256),
													    IN _secondary_id VARCHAR(48),
													    IN _rating FLOAT,
                                                        IN _id_table VARCHAR(32))
BEGIN

	DECLARE _id_cn VARCHAR(32);
	DECLARE _id_shunt VARCHAR(32);

    SET _id_cn = uuid_v4s();
    SET _id_shunt = uuid_v4s();

	CALL add_switched_shunt_with_uuid(_id_bus,
									  _id_cn,
                                      _id_shunt,
                                      _name,
                                      _secondary_id,
                                      _rating,
                                      _id_table);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_switched_shunt_to_delta` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
DELIMITER ;;
CREATE DEFINER=`ree`@`%` PROCEDURE `add_switched_shunt_to_delta`(IN _id_shunt VARCHAR(32),
												IN _id_delta VARCHAR(32),
                                                IN _active TINYINT(4),
                                                IN _action TINYINT(4),
                                                IN _g FLOAT,
                                                IN _b FLOAT
                                                )
BEGIN

	# log the process
	CALL add_usage_log("add_switched_shunt_to_delta", "id_shunt", id_shunt);

	INSERT INTO switched_shunts_models
    (id_shunt, id_delta, active, g, b, action)
    VALUES
    (_id_shunt, _id_delta, _active, _g, _b, _action);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_switched_shunt_to_model` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
DELIMITER ;;
CREATE DEFINER=`ree`@`%` PROCEDURE `add_switched_shunt_to_model`(IN _id_shunt VARCHAR(32),
												IN _id_model VARCHAR(32),
                                                IN _active TINYINT(4),
                                                IN _g FLOAT,
                                                IN _b FLOAT
                                                )
BEGIN

	# log the process
	CALL add_usage_log("add_switched_shunt_to_model", "id_shunt", id_shunt);

	INSERT INTO switched_shunts_models
    (id_shunt, id_model, active, g, b)
    VALUES
    (_id_shunt, _id_model, _active, _g, _b);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_switched_shunt_with_uuid` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
DELIMITER ;;
CREATE DEFINER=`ree`@`%` PROCEDURE `add_switched_shunt_with_uuid`(IN _id_bus VARCHAR(32),
											     IN _id_cn VARCHAR(32),
                                                 IN _id_shunt VARCHAR(32),
                                                 IN _name VARCHAR(256),
											     IN _secondary_id VARCHAR(48),
											     IN _rating FLOAT,
                                                 IN _id_table VARCHAR(32))
BEGIN

	# log the process
	CALL add_usage_log("add_switched_shunt_with_uuid", "id_shunt", _id_shunt);

	# create connectivity node
    CALL create_connectivity_node(_id_cn,  _id_bus);

    # create switched shunt
    INSERT INTO switched_shunts
    (id_shunt, id_connectivity_node, name, secondary_id, rating, id_table)
    VALUES
    (_id_shunt, _id_cn, _name, _secondary_id, _rating, _id_table);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_transformer2w` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;

DELIMITER ;;
CREATE DEFINER=`ree`@`%` PROCEDURE `add_transformer2w`(IN id_bus_from VARCHAR(32),  # ID of the bus from (table bus_bars)
								    IN id_bus_to VARCHAR(32),  # ID of the bus to (table bus_bars)
								    IN xfo_name VARCHAR(256), # name of the line, it is propagates to sections as well
								    IN xfo_name_code VARCHAR(45), # name of the line (set on the one section created)
								    IN xfo_r FLOAT,  # line total per unit resistance
								    IN xfo_x FLOAT,   # line total per unit reactance
								    IN xfo_b FLOAT,  # line total per unit susceptance
								    IN xfo_length FLOAT,   # line total length in km
								    IN xfo_rating FLOAT,   # line nominal rating in MW
                                    IN xfo_hvnom FLOAT,
                                    IN xfo_lvnom FLOAT,
								    OUT _id_section VARCHAR(32),  # Return: ID of the section created
								    OUT _id_xfo VARCHAR(32),  # Return: ID of the power line created
								    OUT _id_fk_from VARCHAR(32), # Return: ID of the connectivity node "from" created
								    OUT _id_fk_to VARCHAR(32) # Return: ID of the connectivity node "to" created)
									)
BEGIN

    /*  EXAMPLE:

		SET @_id_section = '';
		SET @_id_line = '';
		SET @_id_fk_from = '';
		SET @_id_fk_to = '';
		CALL add_transformer('00ed1af58c324aba8e4bdd6b87bdfa6f',  # from
							 '00d58a98e2f24a78b6a77212e8fcbbfd',  # to
							 'myFakeTransformer',  # name
							 'fake',  # name_code
							 0.01,   # r
							 0.05,   # x
							 0.005, # b
							 10.0,  # km
							 100,   # MW
                             132, 	# kV
                             132,   # kV
							 @_id_section,
							 @_id_xfo,
							 @_id_fk_from,
							 @_id_fk_to);
    */

	-- create unique id's needed for the procedure
	SET _id_section = uuid_v4s();
    SET _id_xfo = uuid_v4s();
    SET _id_fk_from = uuid_v4s();
    SET _id_fk_to = uuid_v4s();

	CALL add_transformer2w_with_uuids(id_bus_from,  # from
							  		   id_bus_to,  # to
									   _id_section, # section
									   _id_xfo, # line
									   _id_fk_from, # connectivity_node from
									   _id_fk_to, # connectivity_node to
									   xfo_name,  # name
									   xfo_name_code,  # name_code
									   xfo_r,   # r
									   xfo_x,   # x
									   xfo_b,  # b
									   xfo_rating,# MW
                                       xfo_hvnom,  # kV
                                       xfo_lvnom  # kV
                                       );

	-- return the values
    SELECT _id_section, _id_xfo, _id_fk_from, _id_fk_to;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_transformer2w_phase_shifter_with_uuids` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;

DELIMITER ;;
CREATE DEFINER=`ree`@`%` PROCEDURE `add_transformer2w_phase_shifter_with_uuids`(IN id_bus_from VARCHAR(32),  # ID of the bus from (table bus_bars)
																  IN id_bus_to VARCHAR(32),  # ID of the bus to (table bus_bars)
																  IN id_section VARCHAR(32), # section
																  IN id_xfo VARCHAR(32), # line
																  IN id_fk_from VARCHAR(32), # connectivity_node from
																  IN id_fk_to VARCHAR(32), # connectivity_node to
																  IN xfo_name VARCHAR(256), # name of the line, it is propagates to sections as well
																  IN xfo_name_code VARCHAR(45), # name of the line (set on the one section created)
																  IN xfo_r FLOAT,  # line total per unit resistance
																  IN xfo_x FLOAT,   # line total per unit reactance
																  IN xfo_b FLOAT,  # line total per unit susceptance
																  IN xfo_rating FLOAT,   # line nominal rating in MW
																  IN xfo_hvnom FLOAT,  # High nominal voltage
																  IN xfo_lvnom FLOAT,  # low nominal voltage
																  IN _tap_positions INT,  # number of tap positions
																  IN _max_angle FLOAT,   # maximum tap angle in radians
																  IN _min_angle FLOAT,   # minimum tap angle in radians
																  IN _default_position INT,   # default tap position (0)
																  IN _min_power FLOAT,  # Minimum allowed control power in MW
																  IN _max_power FLOAT  # maximum allowed control power in MW
																  )
BEGIN

	-- insert the data in the transformers table
	CALL add_transformer2w_with_uuids(id_bus_from ,  # ID of the bus from (table bus_bars)
									  id_bus_to,  # ID of the bus to (table bus_bars)
									  id_section, # section
									  id_xfo, # line
									  id_fk_from, # connectivity_node from
									  id_fk_to, # connectivity_node to
									  xfo_name, # name of the line, it is propagates to sections as well
									  xfo_name_code, # name of the line (set on the one section created)
									  xfo_r ,  # line total per unit resistance
									  xfo_x ,   # line total per unit reactance
									  xfo_b ,  # line total per unit susceptance
									  xfo_rating ,   # line nominal rating in MW
									  xfo_hvnom ,
									  xfo_lvnom);

	-- log the process
	CALL add_usage_log("add_transformer2w_phase_shifter_with_uuids", "id_section", id_section);

    # inset the data in the voltage regulators table
	INSERT INTO phase_shifters
    (id_section, tap_positions, max_ratio, min_ratio, default_position, min_voltage, max_voltage)
    VALUES
    (id_section, _tap_positions, _max_angle, _min_angle, _default_position, _min_power, _max_power)
    ON duplicate key update id_section=id_section;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_transformer2w_to_delta` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;

DELIMITER ;;
CREATE DEFINER=`ree`@`%` PROCEDURE `add_transformer2w_to_delta`(IN _id_section VARCHAR(32),
															   IN _id_delta VARCHAR(32),
															   IN _id_bus_control VARCHAR(32),
															   IN _id_rating_profile VARCHAR(32),
															   IN _active TINYINT(4),
															   IN _tap_angle FLOAT,
															   IN _tap_module FLOAT,
															   IN _v_control FLOAT,
															   IN _p_control FLOAT,
															   IN _rating FLOAT)
BEGIN


    -- log the process
    CALL add_usage_log("add_transformer2w_to_delta", "id_section", _id_section);

    INSERT INTO transformers2w_models
    (id_section, id_delta, id_bus_control, id_rating_profile, active, tap_angle, tap_module, v_control, p_control, rating)
    VALUES
    (_id_section, _id_delta, _id_bus_control, _id_rating_profile, _active, _tap_angle, _tap_module, _v_control, _p_control, _rating);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_transformer2w_to_model` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;

DELIMITER ;;
CREATE DEFINER=`ree`@`%` PROCEDURE `add_transformer2w_to_model`(IN _id_section VARCHAR(32),
											   IN _id_model VARCHAR(32),
                                               IN _id_bus_control VARCHAR(32),
                                               IN _id_rating_profile VARCHAR(32),
                                               IN _active TINYINT(4),
                                               IN _tap_angle FLOAT,
                                               IN _tap_module FLOAT,
                                               IN _v_control FLOAT,
                                               IN _p_control FLOAT,
                                               IN _rating FLOAT)
BEGIN


    -- log the process
    CALL add_usage_log("add_transformer2w_to_model", "id_section", _id_section);

    INSERT INTO transformers2w_models
    (id_section, id_model, id_bus_control, id_rating_profile, active, tap_angle, tap_module, v_control, p_control, rating)
    VALUES
    (_id_section, _id_model, _id_bus_control, _id_rating_profile, _active, _tap_angle, _tap_module, _v_control, _p_control, _rating);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_transformer2w_voltage_regulator_with_uuids` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;

DELIMITER ;;
CREATE DEFINER=`ree`@`%` PROCEDURE `add_transformer2w_voltage_regulator_with_uuids`(IN id_bus_from VARCHAR(32),  # ID of the bus from (table bus_bars)
												  IN id_bus_to VARCHAR(32),  # ID of the bus to (table bus_bars)
                                                  IN id_section VARCHAR(32), # section
												  IN id_xfo VARCHAR(32), # line
												  IN id_fk_from VARCHAR(32), # connectivity_node from
												  IN id_fk_to VARCHAR(32), # connectivity_node to
												  IN xfo_name VARCHAR(256), # name of the line, it is propagates to sections as well
												  IN xfo_name_code VARCHAR(45), # name of the line (set on the one section created)
												  IN xfo_r FLOAT,  # line total per unit resistance
												  IN xfo_x FLOAT,   # line total per unit reactance
												  IN xfo_b FLOAT,  # line total per unit susceptance
												  IN xfo_rating FLOAT,   # line nominal rating in MW
												  IN xfo_hvnom FLOAT,  # High nominal voltage
												  IN xfo_lvnom FLOAT,  # low nominal voltage
                                                  IN _tap_positions INT,  # number of tap positions
                                                  IN _max_ratio FLOAT,   # maximum tap ratio (p.u.)
                                                  IN _min_ratio FLOAT,   # minimum tap ratio (p.u.)
                                                  IN _default_position INT,   # default tap position (0)
                                                  IN _min_voltage FLOAT,  # Minimum allowed voltage (p.u.)
                                                  IN _max_voltage FLOAT  # maximum allowed voltage (p.u.)
                                                  )
BEGIN

	# insert the data in the transformers table
	CALL add_transformer2w_with_uuids(id_bus_from ,  # ID of the bus from (table bus_bars)
								    id_bus_to,  # ID of the bus to (table bus_bars)
								    id_section, # section
								    id_xfo, # line
								    id_fk_from, # connectivity_node from
								    id_fk_to, # connectivity_node to
								    xfo_name, # name of the line, it is propagates to sections as well
								    xfo_name_code, # name of the line (set on the one section created)
								    xfo_r ,  # line total per unit resistance
								    xfo_x ,   # line total per unit reactance
								    xfo_b ,  # line total per unit susceptance
								    xfo_rating ,   # line nominal rating in MW
								    xfo_hvnom ,
								    xfo_lvnom);

    # log the process
	CALL add_usage_log("add_transformer_voltage_regulator_with_uuids", "id_section", id_section);

    # inset the data in the voltage regulators table
	INSERT INTO voltage_regulators
    (id_section, tap_positions, max_ratio, min_ratio, default_position, min_voltage, max_voltage)
    VALUES
    (id_section, _tap_positions, _max_ratio, _min_ratio, _default_position, _min_voltage, _max_voltage)
    ON duplicate key update id_section=id_section;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_transformer2w_with_uuids` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;

DELIMITER ;;
CREATE DEFINER=`ree`@`%` PROCEDURE `add_transformer2w_with_uuids`(IN id_bus_from VARCHAR(32),  # ID of the bus from (table bus_bars)
												  IN id_bus_to VARCHAR(32),  # ID of the bus to (table bus_bars)
                                                  IN id_section VARCHAR(32), # section
												  IN id_xfo VARCHAR(32), # line
												  IN id_fk_from VARCHAR(32), # connectivity_node from
												  IN id_fk_to VARCHAR(32), # connectivity_node to
												  IN xfo_name VARCHAR(256), # name of the line, it is propagates to sections as well
												  IN xfo_name_code VARCHAR(45), # name of the line (set on the one section created)
												  IN xfo_r FLOAT,  # line total per unit resistance
												  IN xfo_x FLOAT,   # line total per unit reactance
												  IN xfo_b FLOAT,  # line total per unit susceptance
												  IN xfo_rating FLOAT,   # line nominal rating in MW
												  IN xfo_hvnom FLOAT,
												  IN xfo_lvnom FLOAT
												  )
BEGIN

	# register usage
    CALL add_usage_log("add_transformer2w_with_uuids", "id_section", id_section);

	# create connectivity nodes and associate to buses
    CALL create_connectivity_node(id_fk_from,  id_bus_from);
    CALL create_connectivity_node(id_fk_to,  id_bus_to);

    # create section
    INSERT INTO sections (id_section, id_connectivity_node_1, id_connectivity_node_2, name, rating, secondary_id)
    VALUES(id_section, id_fk_from, id_fk_to, xfo_name, xfo_rating, xfo_name_code)
    ON duplicate key update id_section=id_section;

    # create 2W transformer
    INSERT INTO transformers2w (id_section, r1, x1, b1, rating, HVnom, LVnom)
    VALUES (id_section, xfo_r, xfo_x, xfo_b, xfo_rating, xfo_hvnom, xfo_lvnom)
    ON duplicate key update id_section=id_section;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_usage_log` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;

DELIMITER ;;
CREATE DEFINER=`ree`@`%` PROCEDURE `add_usage_log`(IN _function_name VARCHAR(64),
													IN _attribute VARCHAR(64),
													IN _attribute_id VARCHAR(32))
BEGIN

DECLARE _user_id VARCHAR(64);
DECLARE _log_id VARCHAR(32);
DECLARE _execution_time DATETIME;

SET _user_id = USER();
SET _log_id = uuid_v4s();
SET _execution_time = now();

INSERT INTO logs_usage
(log_id, user_id, function_name, execution_time, attribute, attribute_id)
VALUES
(_log_id, _user_id, _function_name, _execution_time, _attribute, _attribute_id);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `associate_connectivity_node_to_bus` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;

DELIMITER ;;
CREATE DEFINER=`ree`@`%` PROCEDURE `associate_connectivity_node_to_bus`(IN id_cn VARCHAR(32),  IN id_bus VARCHAR(32))
BEGIN

    # associate connectivity node to buses
    INSERT INTO buses_connectivity_nodes(id_bus, id_connectivity_node) VALUES (id_bus, id_cn)
    ON duplicate key update id_bus=id_bus;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `connect_to_double_bar_double_switch` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;

DELIMITER ;;
CREATE DEFINER=`ree`@`%` PROCEDURE `connect_to_double_bar_double_switch`(IN c4_id VARCHAR(32),  # Connectivity node of the line
																		IN id_bus1 VARCHAR(32),  # ID of the bus bar
                                                                        IN id_bus2 VARCHAR(32)  # ID of the bus bar
																		)
BEGIN

/*
Diseño de la BBDD de modelos
Apartado 2.3.5:
Página 24 de 105 Departamento de planificación eléctrica
- c1: nudo de conectividad
- c2: nudo de conectividad
- c3: nudo de conectividad
- c4: nudo de conectividad
- c6: nudo de conectividad
- c7: nudo de conectividad
- c8: nudo de conectividad
- s1: seccionador conectado a c1, c2
- i1: interruptor conectado a c2, c3
- s2: seccionador conectado a c3, c4
- s4: seccionador conectado a c4, c6
- i2: interruptor conectado a c6, c7
- s5: seccionador conectado a c7, c8
*/

DECLARE c1_id VARCHAR(32);
DECLARE c2_id VARCHAR(32);
DECLARE c3_id VARCHAR(32);
DECLARE c6_id VARCHAR(32);
DECLARE c7_id VARCHAR(32);
DECLARE c8_id VARCHAR(32);

DECLARE i1_id VARCHAR(32);
DECLARE i2_id VARCHAR(32);
DECLARE s1_id VARCHAR(32);
DECLARE s2_id VARCHAR(32);
DECLARE s4_id VARCHAR(32);
DECLARE s5_id VARCHAR(32);

SET c1_id = uuid_v4s();
SET c2_id = uuid_v4s();
SET c3_id = uuid_v4s();
SET c6_id = uuid_v4s();
SET c7_id = uuid_v4s();
SET c8_id = uuid_v4s();

SET i1_id = uuid_v4s();
SET i2_id = uuid_v4s();
SET s1_id = uuid_v4s();
SET s2_id = uuid_v4s();
SET s4_id = uuid_v4s();
SET s5_id = uuid_v4s();

# create the missing connectivity nodes
CALL create_connectivity_node(c1_id, "c1");
CALL create_connectivity_node(c2_id, "c2");
CALL create_connectivity_node(c3_id, "c3");
CALL create_connectivity_node(c6_id, "c6");
CALL create_connectivity_node(c7_id, "c7");
CALL create_connectivity_node(c8_id, "c8");
CALL associate_connectivity_node_to_bus(c1_id, id_bus1);
CALL associate_connectivity_node_to_bus(c8_id, id_bus2);

# create the switches
# 1: switch, 2: Sectionalizer
CALL add_switch(c1_id, c2_id, s1_id, "s1", 1, 2);
CALL add_switch(c2_id, c3_id, i1_id, "i1", 1, 1);
CALL add_switch(c3_id, c4_id, s2_id, "s2", 1, 2);

CALL add_switch(c4_id, c6_id, s4_id, "s4", 1, 2);
CALL add_switch(c6_id, c7_id, i1_id, "i2", 1, 1);
CALL add_switch(c7_id, c8_id, s5_id, "s5", 1, 2);



END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `connect_to_double_bar_single_switch` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;

DELIMITER ;;
CREATE DEFINER=`ree`@`%` PROCEDURE `connect_to_double_bar_single_switch`(IN c4_id VARCHAR(32),  # Connectivity node of the line
																		IN id_bus1 VARCHAR(32),  # ID of the bus bar
                                                                        IN id_bus2 VARCHAR(32)  # ID of the bus bar
																		)
BEGIN

/*
Diseño de la BBDD de modelos
Apartado 2.3.2:
Página 24 de 105 Departamento de planificación eléctrica
- c1: nudo de conectividad
- c2: nudo de conectividad
- c3: nudo de conectividad
- c4: nudo de conectividad
- c8: nudo de conectividad
- s1: seccionador conectado a c1, c2
- i1: interruptor de línea conectado a c2, c3
- s2: seccionador conectado a c3, c4
- s2: seccionador conectado a c2, c8
*/

DECLARE c1_id VARCHAR(32);
DECLARE c2_id VARCHAR(32);
DECLARE c3_id VARCHAR(32);
DECLARE c8_id VARCHAR(32);

DECLARE i1_id VARCHAR(32);
DECLARE s1_id VARCHAR(32);
DECLARE s2_id VARCHAR(32);
DECLARE s5_id VARCHAR(32);

SET c1_id = uuid_v4s();
SET c2_id = uuid_v4s();
SET c3_id = uuid_v4s();
SET c8_id = uuid_v4s();

SET i1_id = uuid_v4s();
SET s1_id = uuid_v4s();
SET s2_id = uuid_v4s();
SET s5_id = uuid_v4s();

# create the missing connectivity nodes
CALL create_connectivity_node(c1_id, "c1");
CALL create_connectivity_node(c2_id, "c2");
CALL create_connectivity_node(c3_id, "c3");
CALL create_connectivity_node(c8_id, "c8");
CALL associate_connectivity_node_to_bus(c1_id, id_bus1);
CALL associate_connectivity_node_to_bus(c8_id, id_bus2);

# create the switches
# 1: switch, 2: Sectionalizer
CALL add_switch(c1_id, c2_id, s1_id, "s1", 1, 2);
CALL add_switch(c3_id, c4_id, s2_id, "s2", 1, 2);
CALL add_switch(c2_id, c8_id, s5_id, "s5", 1, 2);
CALL add_switch(c2_id, c3_id, i1_id, "i1", 1, 1);


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `connect_to_simple_bar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;

DELIMITER ;;
CREATE DEFINER=`ree`@`%` PROCEDURE `connect_to_simple_bar`(IN c4_id VARCHAR(32),  # Connectivity node of the line
														   IN id_bus VARCHAR(32)  # ID of the bus bar
														   )
BEGIN

/*
Diseño de la BBDD de modelos
Apartado 2.3.1:
- c1: nudo de conectividad conectado a la barra
- c2: nudo de conectividad
- c3: nudo de conectividad
- c4: nudo de conectividad de la rama
- s1: seccionador de salida de rama conectado a c1, c2
- i1: interruptor de línea conectado a c2, c3
- s2: seccionador de barra conectado a c3, c4
*/

DECLARE c1_id VARCHAR(32);
DECLARE c2_id VARCHAR(32);
DECLARE c3_id VARCHAR(32);
DECLARE i1_id VARCHAR(32);
DECLARE s1_id VARCHAR(32);
DECLARE s2_id VARCHAR(32);

SET c1_id = uuid_v4s();
SET c2_id = uuid_v4s();
SET c3_id = uuid_v4s();
SET i1_id = uuid_v4s();
SET s1_id = uuid_v4s();
SET s2_id = uuid_v4s();

# create the missing connectivity nodes
CALL create_connectivity_node(c1_id, "c1");
CALL create_connectivity_node(c2_id, "c2");
CALL create_connectivity_node(c3_id, "c3");
CALL associate_connectivity_node_to_bus(c1_id, id_bus);

# create the switches
# 1: switch, 2: Sectionalizer
CALL add_switch(c1_id, c2_id, s1_id, "s1", 1, 2);
CALL add_switch(c3_id, c4_id, s2_id, "s2", 1, 2);
CALL add_switch(c2_id, c3_id, i1_id, "i1", 1, 1);


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_connectivity_node` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;

DELIMITER ;;
CREATE DEFINER=`ree`@`%` PROCEDURE `create_connectivity_node`(IN id_cn VARCHAR(32), IN fk_name VARCHAR(24))
BEGIN

	# create connectivity node
    INSERT INTO connectivity_nodes(id_connectivity_node, name, x, y) VALUES (id_cn, fk_name, 0, 0)
    ON duplicate key update id_connectivity_node=id_cn, name=fk_name;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_main_bars_coupling` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;

DELIMITER ;;
CREATE DEFINER=`ree`@`%` PROCEDURE `create_main_bars_coupling`(IN id_bus1 VARCHAR(32),
                                                               IN id_bus2 VARCHAR(32)
															   )
BEGIN

/*
Diseño de la BBDD de modelos
Apartado 2.3.4:
Página 24 de 105 Departamento de planificación eléctrica
- b1: nueva barra (vamos a considerar que ya existe
- c5: nudo de conectividad
- s3: seccionador de barra conectado a c3, c5
*/

DECLARE c1_id VARCHAR(32);
DECLARE c2_id VARCHAR(32);
DECLARE c3_id VARCHAR(32);
DECLARE c4_id VARCHAR(32);

DECLARE i1_id VARCHAR(32);
DECLARE s1_id VARCHAR(32);
DECLARE s2_id VARCHAR(32);

SET c1_id = uuid_v4s();
SET c2_id = uuid_v4s();
SET c3_id = uuid_v4s();
SET c4_id = uuid_v4s();

SET i1_id = uuid_v4s();
SET s1_id = uuid_v4s();
SET s2_id = uuid_v4s();

# create the missing connectivity nodes
CALL create_connectivity_node(c1_id, "c1");
CALL create_connectivity_node(c2_id, "c2");
CALL create_connectivity_node(c3_id, "c3");
CALL create_connectivity_node(c4_id, "c4");
CALL associate_connectivity_node_to_bus(c1_id, id_bus1);
CALL associate_connectivity_node_to_bus(c4_id, id_bus2);

# create the switches
# 1: switch, 2: Sectionalizer
CALL add_switch(c1_id, c2_id, s1_id, "s1", 1, 2);
CALL add_switch(c2_id, c3_id, i1_id, "i1", 1, 1);
CALL add_switch(c3_id, c4_id, s2_id, "s2", 1, 2);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CRUD_substation` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;

DELIMITER ;;
CREATE DEFINER=`ree`@`%` PROCEDURE `CRUD_substation`(
	IN _operation varchar(32),
	IN _id_substation varchar(32),
	IN _params JSON
)
BEGIN

	-- Declare params coming from the JSON object
    DECLARE _name VARCHAR(256)
		DEFAULT NULLIF(JSON_UNQUOTE(JSON_EXTRACT(_params, '$.name')), 'null');
    DECLARE _latitude FLOAT
		DEFAULT NULLIF(JSON_UNQUOTE(JSON_EXTRACT(_params, '$.latitude')), 'null');
    DECLARE _longitude FLOAT
		DEFAULT NULLIF(JSON_UNQUOTE(JSON_EXTRACT(_params, '$.longitude')), 'null');
    DECLARE _online_date DATE
		DEFAULT NULLIF(JSON_UNQUOTE(JSON_EXTRACT(_params, '$.online_date')), 'null');
    DECLARE _offline_date DATE
		DEFAULT NULLIF(JSON_UNQUOTE(JSON_EXTRACT(_params, '$.offine_date')), 'null');
    DECLARE _id_zone VARCHAR(32)
		DEFAULT NULLIF(JSON_UNQUOTE(JSON_EXTRACT(_params, '$.id_zone')), 'null');
    DECLARE _id_province VARCHAR(32)
		DEFAULT NULLIF(JSON_UNQUOTE(JSON_EXTRACT(_params, '$.id_province')), 'null');

    -- Declare variables to store the current data (in case of update)
    DECLARE _curr_name VARCHAR(256);
    DECLARE _curr_latitude FLOAT;
    DECLARE _curr_longitude FLOAT;
    DECLARE _curr_id_zone VARCHAR(32);
    DECLARE _curr_id_province VARCHAR(32);
    DECLARE _curr_online_date DATE;
    DECLARE _curr_offline_date DATE;

    -- Start CRUD
	IF _operation = 'create'  THEN
		INSERT INTO substations
			(id_substation,
			 substations.name,
             latitude,
             longitude,
             online_date,
             offline_date,
             id_zone,
             id_province)
		VALUES
			(_id_substation,
            _name,
            _latitude,
            _longitude,
            _online_date,
            _offline_date,
            _id_zone,
            _id_province);

      ELSEIF _operation = 'read' THEN
			SELECT
				substations.id_substation,
				substations.name as substation,
				substations.latitude,
				substations.longitude,
				zones.name as zone,
				provinces.name as province,
				communities.name as community,
				countries.name as country,
				zones.id_zone,
				provinces.id_province,
				communities.id_community,
				countries.id_country
			FROM substations
			LEFT JOIN zones USING (id_zone)
			LEFT JOIN provinces USING (id_province)
			LEFT JOIN communities USING (id_community)
			LEFT JOIN countries USING (id_country)
			WHERE substations.id_substation = _id_substation;

      ELSEIF _operation = 'update' THEN
			-- Get current data (if any)
            SELECT
				substations.name,
				substations.latitude,
				substations.longitude,
				substations.id_zone,
				substations.id_province,
				substations.online_date,
                substations.offline_date
			INTO
				_curr_name,
                _curr_latitude,
                _curr_longitude,
                _curr_id_zone,
                _curr_id_province,
                _curr_online_date,
                _curr_offline_date
			FROM substations
			WHERE substations.id_substation = _id_substation;
            -- Update comparing against current data
            UPDATE substations
            SET     substations.name = IF(_name is not NULL, _name, _curr_name),
					latitude = IF(_latitude is not NULL, _latitude, _curr_latitude),
					longitude = IF(_longitude is not NULL, _longitude, _curr_longitude),
					online_date = IF(_online_date is not NULL, _online_date, _curr_online_date),
					offline_date = IF(_offline_date is not NULL, _offline_date, _curr_offline_date),
					id_zone = IF(_id_zone is not NULL, _id_zone, _curr_id_zone),
					id_province = IF(_id_province is not NULL, _id_province, _curr_id_province)
            WHERE  id_substation = _id_substation;

      ELSEIF _operation = 'delete' THEN
            DELETE FROM substations
            WHERE  id_substation = _id_substation;
	  END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_ac_power_line` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;

DELIMITER ;;
CREATE DEFINER=`ree`@`%` PROCEDURE `delete_ac_power_line`(IN id_line_ VARCHAR(32)  # id from the table power_lines
														  )
BEGIN

/* EXAMPLE:

    CALL delete_ac_power_line('33e027bd2b13494eab12602b5f9cbd8d')

*/

# log the process
CALL add_usage_log("delete_ac_power_line", "id_line", id_line_);

# find the sections that are related to the power line (store into @id_sections)
SELECT GROUP_CONCAT(id_section)
INTO @id_sections
FROM power_lines_ac_line_sections
WHERE id_line = id_line_;

# find the connectivity nodes associated with the sections
SELECT GROUP_CONCAT(id_connectivity_node)
INTO @id_connectivity_nodes
FROM connectivity_nodes
WHERE id_connectivity_node IN(
	SELECT id_connectivity_node_1 FROM sections WHERE FIND_IN_SET(id_section, @id_sections)
    UNION
    SELECT id_connectivity_node_2 FROM sections WHERE FIND_IN_SET(id_section, @id_sections)
);

# delete from the model and the delta
DELETE FROM lines_deltas WHERE id_line = id_line_;
DELETE FROM lines_models WHERE id_line = id_line_;

# delete record from the power_line - sections relation
DELETE FROM power_lines_ac_line_sections WHERE id_line = id_line_;

# delete record from the power_line
DELETE FROM power_lines WHERE id_line = id_line_;

# delete the ac_line sections
DELETE FROM ac_line_sections WHERE FIND_IN_SET(id_section, @id_sections);

# delete the locations
DELETE FROM line_locations WHERE FIND_IN_SET(id_section, @id_sections);

# delete the sections
DELETE FROM sections WHERE FIND_IN_SET(id_section, @id_sections);

# delete the connectivity nodes relation with the buses
DELETE FROM buses_connectivity_nodes WHERE FIND_IN_SET(id_connectivity_node, @id_connectivity_nodes);

# delete the connectivity nodes
DELETE FROM connectivity_nodes WHERE FIND_IN_SET(id_connectivity_node, @id_connectivity_nodes);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_connectivity_node` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;

DELIMITER ;;
CREATE DEFINER=`ree`@`%` PROCEDURE `delete_connectivity_node`(IN id_cn VARCHAR(32))
BEGIN

    # delete the relation with buses
	DELETE FROM buses_connectivity_nodes WHERE id_connectivity_node = id_cn;

    # delete the connectivity nodes from the potential control references:
    UPDATE generators SET id_connectivity_node_control = NULL
    WHERE generators.id_connectivity_node_control = id_cn;

    # delete the connectivity node itself
    DELETE FROM connectivity_nodes WHERE id_connectivity_node = id_cn;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_generator` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;

DELIMITER ;;
CREATE DEFINER=`ree`@`%` PROCEDURE `delete_generator`(IN id_gen VARCHAR(32))
BEGIN

	DECLARE id_cn VARCHAR(32);

    # log the process
	CALL add_usage_log("delete_generator", "id_gen", id_gen);

    # find the connectivity node
    SELECT id_connectivity_node INTO id_cn FROM generators WHERE id_generator = id_gen;

    # delete from models
    DELETE FROM generators_models WHERE id_generator = id_gen;

    # delete from deltas
    DELETE FROM generators_deltas WHERE id_generator = id_gen;

    # delete the generator
    DELETE FROM generators WHERE id_generator = id_gen;

    # delete CN and the bus connection
    CALL delete_connectivity_node(id_cn);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_phase_shifter` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;

DELIMITER ;;
CREATE DEFINER=`ree`@`%` PROCEDURE `delete_phase_shifter`(IN id_section_ VARCHAR(32))
BEGIN

    # log the process
	CALL add_usage_log("delete_phase_shifter", "id_section", id_section_);

	# delete the son
	DELETE FROM phase_shifters WHERE id_section = id_section_;

	# delete the parent
	CALL delete_transformer(id_section_);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_section` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;

DELIMITER ;;
CREATE DEFINER=`ree`@`%` PROCEDURE `delete_section`(IN _id_section VARCHAR(32))
BEGIN

SELECT COUNT(*) INTO @nsect FROM sections WHERE id_section = _id_section;

IF @nsect > 0 THEN

	# log the process
	CALL add_usage_log("delete_section", "id_section", _id_section);

	# find the connectivity nodes associated with the section
	SELECT id_connectivity_node_1 INTO @c1 FROM sections WHERE id_section = _id_section;
	SELECT id_connectivity_node_2 INTO @c2 FROM sections WHERE id_section = _id_section;

	# delete the sections
	DELETE FROM sections WHERE id_section = _id_section;

	# delete the connectivity nodes relation with the buses
	DELETE FROM buses_connectivity_nodes WHERE id_connectivity_node = @c1;
	DELETE FROM buses_connectivity_nodes WHERE id_connectivity_node = @c2;

	# delete the connectivity nodes
	DELETE FROM connectivity_nodes WHERE id_connectivity_node = @c1;
	DELETE FROM connectivity_nodes WHERE id_connectivity_node = @c2;
END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_substation` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;

DELIMITER ;;
CREATE DEFINER=`ree`@`%` PROCEDURE `delete_substation`(
	IN _id_substation varchar(32)
)
BEGIN
	# log the process
	CALL add_usage_log("delete_substation", "id_substation", _id_substation);

	DELETE FROM substations WHERE  id_substation = _id_substation;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_transformer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;

DELIMITER ;;
CREATE DEFINER=`ree`@`%` PROCEDURE `delete_transformer`(IN id_section_ VARCHAR(32))
BEGIN

	DECLARE id_fk_1 VARCHAR(32);
	DECLARE id_fk_2 VARCHAR(32);

	# log the process
	CALL add_usage_log("delete_transformer", "id_section", id_section_);

	# find the connectivity nodes
	SELECT id_connectivity_node_1 INTO id_fk_1 FROM sections WHERE id_section = id_section_;
	SELECT id_connectivity_node_2 INTO id_fk_2 FROM sections WHERE id_section = id_section_;

	# delete the connectivity nodes relation with the buses
	DELETE FROM buses_connectivity_nodes WHERE id_connectivity_node = id_fk_1;
	DELETE FROM buses_connectivity_nodes WHERE id_connectivity_node = id_fk_2;

	# delete the transformer drom the deltas
	DELETE FROM transformers2w_deltas WHERE id_section = id_section_;

	# delete the transformer from the models
	DELETE FROM transformers2w_models WHERE id_section = id_section_;

	# delete the transformer
	DELETE FROM transformerw2w WHERE id_section = id_section_;

	# delete the sections
	DELETE FROM sections WHERE id_section = id_section_;

	# delete the connectivity nodes
	DELETE FROM connectivity_nodes WHERE id_connectivity_node = id_fk_1;
	DELETE FROM connectivity_nodes WHERE id_connectivity_node = id_fk_2;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_transformer_nw` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;

DELIMITER ;;
CREATE DEFINER=`ree`@`%` PROCEDURE `delete_transformer_nw`(IN _id_transformer VARCHAR(32))
BEGIN

	# log the process
	CALL add_usage_log("delete_transformer_nw", "id_transformer", _id_transformer);

	# delete models and deltas
	DELETE FROM transformersnw_deltas WHERE id_transformer_nw = _id_transformer;
	DELETE FROM transformersnw_models WHERE id_transformer_nw = _id_transformer;

	# find the sections that are related to the power line (store into @id_sections)
	SELECT GROUP_CONCAT(id_section)
	INTO @id_sections
	FROM transformersnw_windings
	WHERE id_transformer_nw = _id_transformer;

	# find the connectivity nodes associated with the sections
	SELECT GROUP_CONCAT(id_connectivity_node)
	INTO @id_connectivity_nodes
	FROM connectivity_nodes
	WHERE id_connectivity_node IN(
		SELECT id_connectivity_node_1 FROM sections WHERE FIND_IN_SET(id_section, @id_sections)
		UNION
		SELECT id_connectivity_node_2 FROM sections WHERE FIND_IN_SET(id_section, @id_sections)
	);

	# delete the winding-transformer relations
	DELETE FROM transformersnw_windings WHERE id_transformer_nw = _id_transformer;

	# delete the NW-transformer relations
	DELETE FROM transformersnw WHERE id_transformer_nw = _id_transformer;

	# delete the windings
	DELETE FROM windings WHERE FIND_IN_SET(id_section, @id_sections);

	# delete the sections
	DELETE FROM sections WHERE FIND_IN_SET(id_section, @id_sections);

	# delete the connectivity nodes relation with the buses
	DELETE FROM buses_connectivity_nodes WHERE FIND_IN_SET(id_connectivity_node, @id_connectivity_nodes);

	# delete the connectivity nodes
	DELETE FROM connectivity_nodes WHERE FIND_IN_SET(id_connectivity_node, @id_connectivity_nodes);


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_voltage_regulator` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;

DELIMITER ;;
CREATE DEFINER=`ree`@`%` PROCEDURE `delete_voltage_regulator`(IN id_section_ VARCHAR(32))
BEGIN

	# log the process
	CALL add_usage_log("delete_voltage_regulator", "id_section_", id_section_);

	# delete the son
	DELETE FROM voltage_regulators WHERE id_section = id_section_;

	# delete the parent
	CALL delete_transformer(id_section_);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_all_buses_json` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;

DELIMITER ;;
CREATE DEFINER=`ree`@`%` PROCEDURE `get_all_buses_json`()
BEGIN


SELECT
	buses.id_bus as id,
    'Bus' as type,
    "ps" as phases,
    buses.name as name,
    buses.secondary_id as name_code,
    1 as active,
    0 as is_slack,
    voltage_levels.voltage as vnom,
    0.9 as vmin,
    1.1 as vmax,
    0 as rf,
    0 as xf,
    buses.x as x,
    buses.y as y,
    20 as h,
    180 as w,
    buses.latitude as lat,
    buses.longitude as lon,
    0 as alt,
    provinces.id_province as area,
    communities.id_community as zone,
    countries.id_country as country,
    substations.id_substation as substation
FROM buses
JOIN voltage_levels USING (id_voltage_level)
JOIN substations USING (id_substation)
JOIN provinces USING (id_province)
JOIN communities USING (id_community)
JOIN countries USING (id_country);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_all_dc_lines_json` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;

DELIMITER ;;
CREATE DEFINER=`ree`@`%` PROCEDURE `get_all_dc_lines_json`()
BEGIN

/*
id: Id única, prefentemente generada con UUIDv4
type: Nombre de la clase
phases: Tipo de modelos de fases («ps»: positive sequence, «3p»: three phase)
name: Nombre de la línea
name_code: Código alternativo de la línea
bus_from: id del bus «from»
bus_to: id del bus «to»
active: Estado de la línea (1: activo, 0: inactivo)
rate: Rating de potencia de la línea en MW
contingency_factor1: Multiplicador del rate para contingencias tipo 1
contingency_factor2: Multiplicador del rate para contingencias tipo 2
contingency_factor3: Multiplicador del rate para contingencias tipo 3
r: Resistencia de la línea (p.u. del sistema)
x: Reactancia de la línea (p.u. del sistema)
b: susceptancia shunt total de la línea (p.u. del sistema)
length: Longitud de la línea en km
base_temperature: Termperatura base de la línea (ºC)
operational_temperature: Temperatura operacional de la línea (ºC)
alpha: Coeficiente térmico de la línea
locations: Lista de longitudes y latitudes de los apoyos de la línea
*/

SELECT
	dc_line_sections.id_section as id,
    "dc-line" as type,
    "ps" as phases,
    sections.name as name,
    sections.secondary_id as name_code,
    get_section_bus_from(dc_line_sections.id_section) as bus_from,
    get_section_bus_to(dc_line_sections.id_section) as bus_to,
    1 as active,
    sections.rating as rate,
    1 as contingency_factor1,
    1 as contingency_factor2,
    1 as contingency_factor3,
    dc_line_sections.r1 as r,
    20 as base_temperature,
    20 as operational_temperature,
    0.0033 as alpha,
    '[]' as locations
FROM dc_line_sections
JOIN sections USING(id_section);


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_all_generators_json` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;

DELIMITER ;;
CREATE DEFINER=`ree`@`%` PROCEDURE `get_all_generators_json`()
BEGIN


SELECT
	generators.id_generator as id,
    'generator' as type,
    'ps' as phases,
    generators.name as name,
    generators.secondary_id as name_code,
    buses_connectivity_nodes.id_bus as 'bus',
    1 as active,
    0 as p,
    0.9 as pf,
    1.0 as vset,
    generators.snom as snom,
    generators.qmin,
    generators.qmax,
    generators.pmin,
    generators.pmax,
    1 as cost,
    generators.id_technology
FROM generators
JOIN buses_connectivity_nodes USING(id_connectivity_node);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_all_hvdcs` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;

DELIMITER ;;
CREATE DEFINER=`ree`@`%` PROCEDURE `get_all_hvdcs`()
BEGIN

/*
id: Id única, prefentemente generada con UUIDv4
type: Nombre de la clase
name: Nombre de la línea
name_code: Código alternativo de la línea
bus_from: id del bus «from»
bus_to: id del bus «to»
active: Estado de la línea (1: activo, 0: inactivo)
rate: Rating de potencia de la línea en MW
contingency_factor1: Multiplicador del rate para contingencias tipo 1
contingency_factor2: Multiplicador del rate para contingencias tipo 2
contingency_factor3: Multiplicador del rate para contingencias tipo 3
r: Resistencia de la línea (p.u. del sistema)
Pset: Potencia establecida de «from» a «to» (MW)
loss_factor: factor de pérdidas (p.u.)
vset_from: Tensión se set point en en lado «from» (p.u. del sistema)
vset_to: Tensión se set point en en lado «to» (p.u. del sistema)
min_firing_angle_f: Mínimo ángulo de disparo del convertidor «from» (radianes)
min_firing_angle_t: Mínimo ángulo de disparo del convertidor «to» (radianes)
max_firing_angle_f: Máximo ángulo de disparo del convertidor «from» (radianes)
max_firing_angle_t: Máximo ángulo de disparo del convertidor «to» (radianes)
length: Longitud de la línea en km
base_temperature: Termperatura base de la línea (ºC)
operational_temperature: Temperatura operacional de la línea (ºC)
alpha: Coeficiente térmico de la línea
locations: Lista de longitudes y latitudes de los apoyos de la línea
*/

SELECT
	sections.id_section as id,
	'HVDC' as type,
	sections.name as name,
	sections.secondary_id as name_code,
	get_bus_id(sections.id_connectivity_node_1) as bus_from,
	get_bus_id(sections.id_connectivity_node_2) as bus_to,
	1 as active,
	sections.rating as rate,
	sections.contingency_factor1 as contingency_factor1,
    sections.contingency_factor2 as contingency_factor2,
    sections.contingency_factor3 as contingency_factor3,
	hvdc.r as r,
	0 as Pset,
	0.0 as loss_factor,
	1 as vset_from,
	1 as vset_to,
	hvdc.min_firing_angle_f as min_firing_angle_f,
	hvdc.min_firing_angle_t as min_firing_angle_t,
	hvdc.max_firing_angle_f as max_firing_angle_f,
	hvdc.max_firing_angle_t as max_firing_angle_t,
	hvdc.length as length,
	20 as base_temperature,
	20 as operational_temperature,
	0.0033 as alpha,
	'[]' as locations
FROM
	sections
	JOIN hvdc USING (id_section);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_all_lines_json` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;

DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `get_all_lines_json`(_id_model VARCHAR(32))
BEGIN

/*
id: Id única, prefentemente generada con UUIDv4
type: Nombre de la clase
phases: Tipo de modelos de fases («ps»: positive sequence, «3p»: three phase)
name: Nombre de la línea
name_code: Código alternativo de la línea
bus_from: id del bus «from»
bus_to: id del bus «to»
active: Estado de la línea (1: activo, 0: inactivo)
rate: Rating de potencia de la línea en MW
contingency_factor1: Multiplicador del rate para contingencias tipo 1
contingency_factor2: Multiplicador del rate para contingencias tipo 2
contingency_factor3: Multiplicador del rate para contingencias tipo 3
r: Resistencia de la línea (p.u. del sistema)
x: Reactancia de la línea (p.u. del sistema)
b: susceptancia shunt total de la línea (p.u. del sistema)
length: Longitud de la línea en km
base_temperature: Termperatura base de la línea (ºC)
operational_temperature: Temperatura operacional de la línea (ºC)
alpha: Coeficiente térmico de la línea
locations: Lista de longitudes y latitudes de los apoyos de la línea
*/

SELECT
	ac_line_sections.id_section as "id_section",
    "line" as type,
    sections.name as "name",
    sections.secondary_id as "secondary_id",
    get_section_substation_from(_id_model, ac_line_sections.id_section) as "substation_from",
    get_section_substation_to(_id_model, ac_line_sections.id_section) as "substation_to",
    sections.active as "active",
    sections.rating as "rate",
    sections.contingency_factor1 as "contingency_factor1",
    sections.contingency_factor2 as "contingency_factor2",
    sections.contingency_factor3 as "contingency_factor3",
    ac_line_sections.r1 as "r1",
    ac_line_sections.x1 as "x1",
    ac_line_sections.b1 as "b1",
    '[]' as locations
FROM ac_line_sections
JOIN sections USING(id_section)
WHERE sections.id_model = _id_model;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_all_loads_json` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;

DELIMITER ;;
CREATE DEFINER=`ree`@`%` PROCEDURE `get_all_loads_json`()
BEGIN

/*
id: Id única, prefentemente generada con UUIDv4
type: Nombre de la clase
phases: Tipo de modelos de fases («ps»: positive sequence, «3p»: three phase)
name: Nombre de la carga
name_code: Código de la carga
bus: Identificador del bus
active: Estado de la carga (true / false)
g: Conductancia, expresada como potencia equivalente a v=1.0 p.u.
b: Susceptancia, expresada como potencia equivalente a v=1.0 p.u.
ir: Corriente real, expresada como potencia equivalente a v=1.0 p.u.
ii: Corriente imaginaria, expresada como potencia equivalente a v=1.0 p.u.
p: Potencia activa
q: Potencia reactiva
*/
SELECT
	loads.id_load as id,
    'load' as type,
    'ps' as phases,
    loads.name as name,
    loads.secondary_id as name_code,
    buses_connectivity_nodes.id_bus as bus,
    1 as active,
    0 as g,
    0 as b,
    0 as ir,
    0 as ii,
    0 as p,
    0 as q
FROM loads
JOIN buses_connectivity_nodes USING(id_connectivity_node);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_all_sections_buses` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;

DELIMITER ;;
CREATE DEFINER=`ree`@`%` PROCEDURE `get_all_sections_buses`()
BEGIN

	-- this query selects the sections and their bus1 and bus2 using the section id
	SELECT sid1 as id_section, bid1 as id_bus1, bid2 as id_bus2 FROM
		( -- this query gets the bus1 of each section
		SELECT
			sections.id_section as sid1,
			sections.name as section_name1,
			buses.name as bus_name1,
			buses.id_bus as bid1
		FROM sections
		JOIN buses_connectivity_nodes
			ON sections.id_connectivity_node_1 = buses_connectivity_nodes.id_connectivity_node
		JOIN buses USING (id_bus)
		) as Q1
	JOIN
		( -- this query gets the bus2 of each section
		SELECT
			sections.id_section as sid2,
			sections.name as section_name2,
			buses.name as bus_name2,
			buses.id_bus as bid2
		FROM sections
		JOIN buses_connectivity_nodes
			ON sections.id_connectivity_node_2 = buses_connectivity_nodes.id_connectivity_node
		JOIN buses USING (id_bus)
		) as Q2
	Where Q1.sid1 = Q2.sid2;  -- use the section id to match both queries

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_all_shunts_json` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;

DELIMITER ;;
CREATE DEFINER=`ree`@`%` PROCEDURE `get_all_shunts_json`()
BEGIN

/*
id: Id única, prefentemente generada con UUIDv4
type: Nombre de la clase
phases: Tipo de modelos de fases («ps»: positive sequence, «3p»: three phase)
name: Nombre del shunt
name_code: Código del shunt
bus: Identificador del bus
active: Estado de la carga (true / false, o 1 / 0)
controlled Si es controlable o no (true / false, o 1 / 0)
g: Conductancia, expresada como potencia equivalente a v=1.0 p.u.
b: Susceptancia, expresada como potencia equivalente a v=1.0 p.u.
bmax: Susceptancia máxima, expresada como potencia equivalente a v=1.0 p.u.
bmin: Susceptancia mínima, expresada como potencia equivalente a v=1.0 p.u.
id_impedance_table: ID de la tabla de impedancia.
*/

SELECT
	switched_shunts.id_shunt as id,
    'Shunt' as type,
    'ps' as phases,
    switched_shunts.name as name,
    switched_shunts.secondary_id as name_code,
    buses_connectivity_nodes.id_bus as bus,
    1 as active,
    1 as controlled,
    0 as g,
    0 as b,
    0 as bmax,
    0 as bmin,
    id_table as id_impedance_table
FROM switched_shunts
JOIN buses_connectivity_nodes USING(id_connectivity_node)

UNION

SELECT
	fixed_shunts.id_shunt as id,
    'Shunt' as type,
    'ps' as phases,
    fixed_shunts.name as name,
    fixed_shunts.secondary_id as name_code,
    buses_connectivity_nodes.id_bus as bus,
    1 as active,
    0 as controlled,
    fixed_shunts.g1 as g,
    fixed_shunts.b1 as b,
	fixed_shunts.b1 as bmax,
    fixed_shunts.b1 as bmin,
    Null as id_impedance_table
FROM fixed_shunts
JOIN buses_connectivity_nodes USING(id_connectivity_node);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_all_sssc_json` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;

DELIMITER ;;
CREATE DEFINER=`ree`@`%` PROCEDURE `get_all_sssc_json`()
BEGIN

/*
id: Id única, prefentemente generada con UUIDv4
type: Nombre de la clase («SSSC»)
name: Nombre del SSSC
name_code: Código alternativo
bus_from: id del bus «from»
bus_to: id del bus «to»
active: Estado del dispositivo (1: activo, 0: inactivo)
rate: Rating del dispositivo (MW)
contingency_factor1: Multiplicador del rate para contingencias tipo 1
contingency_factor2: Multiplicador del rate para contingencias tipo 2
contingency_factor3: Multiplicador del rate para contingencias tipo 3
rs: Resistencia serie del dispositivo (p.u. del sistema)
xs: Reactancia serie del dispositivo (p.u. del sistema)
control_mode: Modo de conrol. Ver tabla de modos de control.
vset: Tensión de consigna establecida de «envío» en el lado «from» (p.u.)
Pset: Potencia activa establecida de «envío» en el lado «from» (MW)
Qset: Potencia reactiva establecida de «envío» en el lado «from» (MW)
*/

SELECT
	sssc.id_section as id,
    "sssc" as type,
    "ps" as phases,
    sections.name as name,
    sections.secondary_id as name_code,
    get_section_bus_from(sssc.id_section) as bus_from,
    get_section_bus_to(sssc.id_section) as bus_to,
    1 as active,
    sections.rating as rate,
    sections.contingency_factor1 as contingency_factor1,
    sections.contingency_factor2 as contingency_factor2,
    sections.contingency_factor3 as contingency_factor3,
    sssc.r as rs,
    sssc.x as xs,
    0 as control_mode,
    1 as Vset,
    0 as Pset,
    0 as Qset
FROM sssc
JOIN sections USING(id_section);


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_all_transformers2w_json` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;

DELIMITER ;;
CREATE DEFINER=`ree`@`%` PROCEDURE `get_all_transformers2w_json`()
BEGIN


/*
id: Id única, prefentemente generada con UUIDv4
type: Nombre de la clase
phases: Tipo de modelos de fases («ps»: positive sequence, «3p»: three phase)
name: Nombre del transformador
name_code: Código alternativo del transformador
bus_from: id del bus «from»
bus_to: id del bus «to»
active: Estado de la línea (1: activo, 0: inactivo)
rate: Rating de potencia de la línea
contingency_factor1: Multiplicador del rate para contingencias tipo 1
contingency_factor2: Multiplicador del rate para contingencias tipo 2
contingency_factor3: Multiplicador del rate para contingencias tipo 3
Vnomf: Tensión nominal del lado «from» en kV
Vnomt: Tensión nominal del lado «to» en kV
r: Resistencia ( en p.u.)
x: Reactancia ( en p.u.)
g: Conductancia shunt total ( en p.u.)
b: Susceptancia shunt total ( en p.u.)
tap_module: Valor del tap ( por defecto 1.0)
min_tap_module: Valor mínimo del tap ( por defecto 0.5)
max_tap_module: Valor máximo del tap ( por defecto 1.5)
id_tap_module_table: ID de la tabla de módulos de taps.
tap_angle: Valor del ángulo ( por defecto 0.0 radianes)
min_tap_angle: Valor mínimo del ángulo ( por defecto 0.0)
max_tap_angle: Valor máximo del ángulo ( por defecto 2π)
id_tap_angle_table: ID de la tabla de ángulos de taps.
control_mode: Modo de conrol. Ver tabla de modos de control.
vset: Tensión de regulación (en p.u.).
pset: Nivel de potencia a regular (MW)
base_temperature: Termperatura base del transformador
operational_temperature: Temperatura operacional del transformador
alpha: Coeficiente térmico del transformador
*/


SELECT
	transformers2w.id_section as id,
    "transformer2w" as type,
    "ps" as phases,
    sections.name as name,
    sections.secondary_id as name_code,
    get_section_bus_from(transformers2w.id_section) as bus_from,
    get_section_bus_to(transformers2w.id_section) as bus_to,
    1 as active,
    sections.rating as rate,
    sections.contingency_factor1 as contingency_factor1,
    sections.contingency_factor2 as contingency_factor2,
    sections.contingency_factor3 as contingency_factor3,
    transformers2w.r1 as r,
    transformers2w.x1 as x,
    transformers2w.g1 as g,
    transformers2w.b1 as b,

    1 as tap_module,
	1 as min_tap_module,
	1 as max_tap_module,
	'' as id_tap_module_table,
	0 as tap_angle,
	0 as min_tap_angle,
	0 as max_tap_angle,
	'' as id_tap_angle_table,
	0 as control_mode,
	1 as vset,
	0 as pset,

    20 as base_temperature,
    20 as operational_temperature,
    0.0033 as alpha
FROM transformers2w
JOIN sections USING(id_section)
JOIN voltage_regulators
JOIN phase_shifters
WHERE voltage_regulators.id_section is Null  # to not include voltage regulators
	AND phase_shifters.id_section is Null # to not include phase shifters


UNION

-- Add voltage regulators
SELECT
	transformers2w.id_section as id,
    "transformer2w" as type,
    "ps" as phases,
    sections.name as name,
    sections.secondary_id as name_code,
    get_section_bus_from(transformers2w.id_section) as bus_from,
    get_section_bus_to(transformers2w.id_section) as bus_to,
    1 as active,
    sections.rating as rate,
    sections.contingency_factor1 as contingency_factor1,
    sections.contingency_factor2 as contingency_factor2,
    sections.contingency_factor3 as contingency_factor3,
    transformers2w.r1 as r,
    transformers2w.x1 as x,
    transformers2w.g1 as g,
    transformers2w.b1 as b,

    1 as tap_module,
	voltage_regulators.max_ratio as min_tap_module,
	voltage_regulators.min_ratio as max_tap_module,
	'' as id_tap_module_table,

	0 as tap_angle,
	0 as min_tap_angle,
	0 as max_tap_angle,
	'' as id_tap_angle_table,
	0 as control_mode,

	1 as vset,

    1 as pset,

    20 as base_temperature,
    20 as operational_temperature,
    0.0033 as alpha
FROM transformers2w
JOIN voltage_regulators USING(id_section)
JOIN sections USING(id_section)

UNION

-- Add phase shifters
SELECT
	transformers2w.id_section as id,
    "transformer2w" as type,
    "ps" as phases,
    sections.name as name,
    sections.secondary_id as name_code,
    get_section_bus_from(transformers2w.id_section) as bus_from,
    get_section_bus_to(transformers2w.id_section) as bus_to,
    1 as active,
    sections.rating as rate,
    sections.contingency_factor1 as contingency_factor1,
    sections.contingency_factor2 as contingency_factor2,
    sections.contingency_factor3 as contingency_factor3,
    transformers2w.r1 as r,
    transformers2w.x1 as x,
    transformers2w.g1 as g,
    transformers2w.b1 as b,

    1 as tap_module,
	1 as min_tap_module,
	1 as max_tap_module,
	'' as id_tap_module_table,

	0 as tap_angle,
	phase_shifters.min_angle as min_tap_angle,
	phase_shifters.max_angle as max_tap_angle,
	'' as id_tap_angle_table,

    2 as control_mode,

	1 as vset,
    0 as pset,

    20 as base_temperature,
    20 as operational_temperature,
    0.0033 as alpha
FROM transformers2w
JOIN phase_shifters USING(id_section)
JOIN sections USING(id_section);


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_all_upfc_json` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;

DELIMITER ;;
CREATE DEFINER=`ree`@`%` PROCEDURE `get_all_upfc_json`()
BEGIN

/*
id: Id única, prefentemente generada con UUIDv4
type: Nombre de la clase («upfc»)
name: Nombre del dispositivo
name_code: Código alternativo del dispositivo
bus_from: id del bus «from»
bus_to: id del bus «to»
active: Estado del dispositivo (1: activo, 0: inactivo)
rate: Rating de potencia del dispositivo (MW)
contingency_factor1: Multiplicador del rate para contingencias tipo 1
contingency_factor2: Multiplicador del rate para contingencias tipo 2
contingency_factor3: Multiplicador del rate para contingencias tipo 3
rl: Resistencia del dispositivo (p.u. del sistema)
xl: Reactancia del dispositivo (p.u. del sistema)
bl: Susceptancia del dispositivo (p.u. del sistema)
rs: Resistencia serie del dispositivo (p.u. del sistema)
xs: Reactancia serie del dispositivo (p.u. del sistema)
rsh: Resistencia shunt del dispositivo (p.u. del sistema)
xsh: Reactancia shunt del dispositivo (p.u. del sistema)
vsh: Tensión de set point en en lado «from» (p.u. del sistema)
Pset: Potencia activa establecida de «envío» en el lado «from» (MW)
Qset: Potencia reactiva establecida de «envío» en el lado «from» (MW)
*/

SELECT
	upfc.id_section as id,
    "upfc" as type,
    "ps" as phases,
    sections.name as name,
    sections.secondary_id as name_code,
    get_section_bus_from(upfc.id_section) as bus_from,
    get_section_bus_to(upfc.id_section) as bus_to,
    1 as active,
    sections.rating as rate,
    sections.contingency_factor1 as contingency_factor1,
    sections.contingency_factor2 as contingency_factor2,
    sections.contingency_factor3 as contingency_factor3,
    upfc.rl as rl,
    upfc.xl as xl,
    upfc.bl as bl,
    upfc.rs as rs,
    upfc.xs as xs,
    upfc.rsh as rsh,
    upfc.xsh as xsh,
    1 as vsh,
    0 as Pset,
    0 as Qset
FROM upfc
JOIN sections USING(id_section);


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_all_vsc_json` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;

DELIMITER ;;
CREATE DEFINER=`ree`@`%` PROCEDURE `get_all_vsc_json`()
BEGIN

/*
id: Id única, prefentemente generada con UUIDv4
type: Nombre de la clase («vsc»)
name: Nombre del dispositivo
name_code: Código alternativo del convertidor
bus_from: id del bus «from», es el lado DC siempre.
bus_to: id del bus «to», es el lado AC siempre.
active: Estado del dispositivo (1: activo, 0: inactivo)
rate: Rating de potencia del dispositivo en MW
contingency_factor1: Multiplicador del rate para contingencias tipo 1
contingency_factor2: Multiplicador del rate para contingencias tipo 2
contingency_factor3: Multiplicador del rate para contingencias tipo 3
r: Resistencia que modela las pérdidas resistivas (p.u. del sistema)
x: Reactancia que modela las pérdidas magnéticas (p.u. del sistema)
g: Conductancia que modela las pérdidas del inversor (p.u. del sistema)
m: Valor del control de tensión (equivale a los taps del transformador) (p.u.)
m_max: Valor máximo del control de tensión (p.u.)
m_min: Valor mínimo del control de tensión (p.u.)
theta: Ángulo de disparo del convertidor (radianes)
theta_max: Ángulo de disparo máximo del convertidor (radianes)
theta_min: Ángulo de disparo mínimo del convertidor (radianes)
Beq: Susceptancia que absorve la reaciva de la parte DC convertidor (radianes)
Beq_max: Ángulo de disparo máximo del convertidor (radianes)
Beq_min: Ángulo de disparo mínimo del convertidor (radianes)
alpha1: Parámetro 1 de la curva de pérdidas IEC 62751-2
alpha2: Parámetro 2 de la curva de pérdidas IEC 62751-2
alpha3: Parámetro 3 de la curva de pérdidas IEC 62751-2
k: Factor del convertidor. (Habitualmente sqrt(3) / 2 = 0.866666)
kdp: Pendiente del control droop potencia / Tensión. (p.u. / p.u.)
Pfset: Potencia establecida en el control de potencia activa (MW)
Qfset: Potencia establecida en el control de potencia reactiva (MW)
vac_set: Tensión establecida en el control de tensión AC. (p.u.)
vdc_set: Tensión establecida en el control de tensión DC. (p.u.)
mode: Modo de control. Ver la tabla adjunta.
*/

SELECT
	vsc.id_section as id,
    "vsc" as type,
    "ps" as phases,
    sections.name as name,
    sections.secondary_id as name_code,
    get_section_bus_from(vsc.id_section) as bus_from,
    get_section_bus_to(vsc.id_section) as bus_to,
    1 as active,
    sections.rating as rate,
    sections.contingency_factor1 as contingency_factor1,
    sections.contingency_factor2 as contingency_factor2,
    sections.contingency_factor3 as contingency_factor3,
    vsc.r as r,
    vsc.x as x,
    0 as g,
    1 as m,
    0 as theta,
    vsc.m_max as m_max,
    vsc.m_min as m_min,
    vsc.theta_max as theta_max,
    vsc.theta_min as theta_min,
    vsc.Beq_max as Beq_max,
    vsc.Beq_min as Beq_min,
    vsc.alpha1 as alpha1,
    vsc.alpha2 as alpha2,
    vsc.alpha3 as alpha3,
    vsc.k as k,
    vsc.kdp as kdp,
    0 as Pfset,
    0 as Qfset,
    1 as vac_set,
    1 as vdc_set,
    0 as mode
FROM vsc
JOIN sections USING(id_section);


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_model_buses_json` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;

DELIMITER ;;
CREATE DEFINER=`ree`@`%` PROCEDURE `get_model_buses_json`(IN _id_model VARCHAR(32))
BEGIN


SELECT
	buses.id_bus as id,
    'Bus' as type,
    "ps" as phases,
    buses.name as name,
    buses.secondary_id as name_code,
    buses_models.active as active,
    0 as is_slack,
    voltage_levels.voltage as vnom,
    0.9 as vmin,
    1.1 as vmax,
    0 as rf,
    0 as xf,
    buses.x as x,
    buses.y as y,
    20 as h,
    180 as w,
    buses.latitude as lat,
    buses.longitude as lon,
    0 as alt,
    provinces.id_province as area,
    communities.id_community as zone,
    countries.id_country as country,
    substations.id_substation as substation
FROM buses
JOIN voltage_levels USING (id_voltage_level)
JOIN substations USING (id_substation)
JOIN provinces USING (id_province)
JOIN communities USING (id_community)
JOIN countries USING (id_country)
JOIN buses_models USING (id_bus)
WHERE buses_models.id_model = _id_model;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_model_dc_lines_json` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;

DELIMITER ;;
CREATE DEFINER=`ree`@`%` PROCEDURE `get_model_dc_lines_json`(IN _id_model VARCHAR(32))
BEGIN

/*
id: Id única, prefentemente generada con UUIDv4
type: Nombre de la clase
phases: Tipo de modelos de fases («ps»: positive sequence, «3p»: three phase)
name: Nombre de la línea
name_code: Código alternativo de la línea
bus_from: id del bus «from»
bus_to: id del bus «to»
active: Estado de la línea (1: activo, 0: inactivo)
rate: Rating de potencia de la línea en MW
contingency_factor1: Multiplicador del rate para contingencias tipo 1
contingency_factor2: Multiplicador del rate para contingencias tipo 2
contingency_factor3: Multiplicador del rate para contingencias tipo 3
r: Resistencia de la línea (p.u. del sistema)
x: Reactancia de la línea (p.u. del sistema)
b: susceptancia shunt total de la línea (p.u. del sistema)
length: Longitud de la línea en km
base_temperature: Termperatura base de la línea (ºC)
operational_temperature: Temperatura operacional de la línea (ºC)
alpha: Coeficiente térmico de la línea
locations: Lista de longitudes y latitudes de los apoyos de la línea
*/

SELECT
	dc_line_sections.id_section as id,
    "dc-line" as type,
    "ps" as phases,
    sections.name as name,
    sections.secondary_id as name_code,
    get_section_bus_from(dc_line_sections.id_section) as bus_from,
    get_section_bus_to(dc_line_sections.id_section) as bus_to,
    dc_line_sections_models.active as active,
    dc_line_sections_models.rating as rate,
    1 as contingency_factor1,
    1 as contingency_factor2,
    1 as contingency_factor3,
    dc_line_sections.r1 as r,
    20 as base_temperature,
    20 as operational_temperature,
    0.0033 as alpha,
    '[]' as locations
FROM dc_line_sections
JOIN sections USING(id_section)
JOIN dc_line_sections_models USING(id_section)
WHERE dc_line_sections_models.id_model = _id_model;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_model_generators_json` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;

DELIMITER ;;
CREATE DEFINER=`ree`@`%` PROCEDURE `get_model_generators_json`(IN _id_model VARCHAR(32))
BEGIN


SELECT
	generators.id_generator as id,
    'generator' as type,
    'ps' as phases,
    generators.name as name,
    generators.secondary_id as name_code,
    buses_connectivity_nodes.id_bus as 'bus',
    generators_models.active as active,
    generators_models.p as p,
    generators_models.pf as pf,
    generators_models.v_set as vset,
    generators.snom as snom,
    generators.qmin,
    generators.qmax,
    generators.pmin,
    generators.pmax,
    1 as cost,
    generators.id_technology
FROM generators
JOIN buses_connectivity_nodes USING(id_connectivity_node)
JOIN generators_models USING(id_generator)
WHERE generators_models.id_model = _id_model;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_model_hvdcs` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;

DELIMITER ;;
CREATE DEFINER=`ree`@`%` PROCEDURE `get_model_hvdcs`(IN _id_model VARCHAR(32))
BEGIN

/*
id: Id única, prefentemente generada con UUIDv4
type: Nombre de la clase
name: Nombre de la línea
name_code: Código alternativo de la línea
bus_from: id del bus «from»
bus_to: id del bus «to»
active: Estado de la línea (1: activo, 0: inactivo)
rate: Rating de potencia de la línea en MW
contingency_factor1: Multiplicador del rate para contingencias tipo 1
contingency_factor2: Multiplicador del rate para contingencias tipo 2
contingency_factor3: Multiplicador del rate para contingencias tipo 3
r: Resistencia de la línea (p.u. del sistema)
Pset: Potencia establecida de «from» a «to» (MW)
loss_factor: factor de pérdidas (p.u.)
vset_from: Tensión se set point en en lado «from» (p.u. del sistema)
vset_to: Tensión se set point en en lado «to» (p.u. del sistema)
min_firing_angle_f: Mínimo ángulo de disparo del convertidor «from» (radianes)
min_firing_angle_t: Mínimo ángulo de disparo del convertidor «to» (radianes)
max_firing_angle_f: Máximo ángulo de disparo del convertidor «from» (radianes)
max_firing_angle_t: Máximo ángulo de disparo del convertidor «to» (radianes)
length: Longitud de la línea en km
base_temperature: Termperatura base de la línea (ºC)
operational_temperature: Temperatura operacional de la línea (ºC)
alpha: Coeficiente térmico de la línea
locations: Lista de longitudes y latitudes de los apoyos de la línea
*/

SELECT
	sections.id_section as id,
	'HVDC' as type,
	sections.name as name,
	sections.secondary_id as name_code,
	get_bus_id(sections.id_connectivity_node_1) as bus_from,
	get_bus_id(sections.id_connectivity_node_2) as bus_to,
	hvdc_models.active as active,
	sections.rating as rate,
	sections.contingency_factor1 as contingency_factor1,
    sections.contingency_factor2 as contingency_factor2,
    sections.contingency_factor3 as contingency_factor3,
	hvdc.r as r,
	hvdc_models.Pset as Pset,
	hvdc.loss_factor as loss_factor,
	hvdc_models.vset_f as vset_from,
	hvdc_models.vset_t as vset_to,
	hvdc.min_firing_angle_f as min_firing_angle_f,
	hvdc.min_firing_angle_t as min_firing_angle_t,
	hvdc.max_firing_angle_f as max_firing_angle_f,
	hvdc.max_firing_angle_t as max_firing_angle_t,
	hvdc.length as length,
	20 as base_temperature,
	20 as operational_temperature,
	0.0033 as alpha,
	'[]' as locations
FROM
	sections
	JOIN hvdc USING (id_section)
	JOIN hvdc_models using (id_section)
	WHERE hvdc_models.id_model = _id_model;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_model_lines_json` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;

DELIMITER ;;
CREATE DEFINER=`ree`@`%` PROCEDURE `get_model_lines_json`(IN _id_model VARCHAR(32))
BEGIN

/*
id: Id única, prefentemente generada con UUIDv4
type: Nombre de la clase
phases: Tipo de modelos de fases («ps»: positive sequence, «3p»: three phase)
name: Nombre de la línea
name_code: Código alternativo de la línea
bus_from: id del bus «from»
bus_to: id del bus «to»
active: Estado de la línea (1: activo, 0: inactivo)
rate: Rating de potencia de la línea en MW
contingency_factor1: Multiplicador del rate para contingencias tipo 1
contingency_factor2: Multiplicador del rate para contingencias tipo 2
contingency_factor3: Multiplicador del rate para contingencias tipo 3
r: Resistencia de la línea (p.u. del sistema)
x: Reactancia de la línea (p.u. del sistema)
b: susceptancia shunt total de la línea (p.u. del sistema)
length: Longitud de la línea en km
base_temperature: Termperatura base de la línea (ºC)
operational_temperature: Temperatura operacional de la línea (ºC)
alpha: Coeficiente térmico de la línea
locations: Lista de longitudes y latitudes de los apoyos de la línea
*/

SELECT
	ac_line_sections.id_section as id,
    "line" as type,
    "ps" as phases,
    sections.name as name,
    sections.secondary_id as name_code,
    get_section_bus_from(ac_line_sections.id_section) as bus_from,
    get_section_bus_to(ac_line_sections.id_section) as bus_to,
    ac_line_sections_models.active as active,
    ac_line_sections_models.rating as rate,
    sections.contingency_factor1 as contingency_factor1,
    sections.contingency_factor2 as contingency_factor2,
    sections.contingency_factor3 as contingency_factor3,
    ac_line_sections.r1 as r,
    ac_line_sections.x1 as x,
    ac_line_sections.b1 as b,
    20 as base_temperature,
    20 as operational_temperature,
    0.0033 as alpha,
    '[]' as locations
FROM ac_line_sections
JOIN sections USING(id_section)
JOIN ac_line_sections_models USING(id_section)
WHERE ac_line_sections.id_model = _id_model;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_model_loads_json` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;

DELIMITER ;;
CREATE DEFINER=`ree`@`%` PROCEDURE `get_model_loads_json`(IN _id_model VARCHAR(32))
BEGIN

/*
id: Id única, prefentemente generada con UUIDv4
type: Nombre de la clase
phases: Tipo de modelos de fases («ps»: positive sequence, «3p»: three phase)
name: Nombre de la carga
name_code: Código de la carga
bus: Identificador del bus
active: Estado de la carga (true / false)
g: Conductancia, expresada como potencia equivalente a v=1.0 p.u.
b: Susceptancia, expresada como potencia equivalente a v=1.0 p.u.
ir: Corriente real, expresada como potencia equivalente a v=1.0 p.u.
ii: Corriente imaginaria, expresada como potencia equivalente a v=1.0 p.u.
p: Potencia activa
q: Potencia reactiva
*/
SELECT
	loads.id_load as id,
    'load' as type,
    'ps' as phases,
    loads.name as name,
    loads.secondary_id as name_code,
    buses_connectivity_nodes.id_bus as bus,
    loads_models.active as active,
    0 as g,
    0 as b,
    0 as ir,
    0 as ii,
    loads_models.p as p,
    loads_models.q as q
FROM loads
JOIN buses_connectivity_nodes USING(id_connectivity_node)
JOIN loads_models USING(id_load)
WHERE loads_models.id_model = _id_model;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_model_shunts_json` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;

DELIMITER ;;
CREATE DEFINER=`ree`@`%` PROCEDURE `get_model_shunts_json`(IN _id_model VARCHAR(32))
BEGIN

/*
id: Id única, prefentemente generada con UUIDv4
type: Nombre de la clase
phases: Tipo de modelos de fases («ps»: positive sequence, «3p»: three phase)
name: Nombre del shunt
name_code: Código del shunt
bus: Identificador del bus
active: Estado de la carga (true / false, o 1 / 0)
controlled Si es controlable o no (true / false, o 1 / 0)
g: Conductancia, expresada como potencia equivalente a v=1.0 p.u.
b: Susceptancia, expresada como potencia equivalente a v=1.0 p.u.
bmax: Susceptancia máxima, expresada como potencia equivalente a v=1.0 p.u.
bmin: Susceptancia mínima, expresada como potencia equivalente a v=1.0 p.u.
id_impedance_table: ID de la tabla de impedancia.
*/

SELECT
	switched_shunts.id_shunt as id,
    'Shunt' as type,
    'ps' as phases,
    switched_shunts.name as name,
    switched_shunts.secondary_id as name_code,
    buses_connectivity_nodes.id_bus as bus,
    switched_shunts_models.active as active,
    1 as controlled,
    switched_shunts_models.g as g,
    switched_shunts_models.b as b,
    0 as bmax,
    0 as bmin,
    id_table as id_impedance_table
FROM switched_shunts
JOIN buses_connectivity_nodes USING(id_connectivity_node)
JOIN switched_shunts_models USING(id_shunt)
WHERE switched_shunts_models.id_model = _id_model

UNION

SELECT
	fixed_shunts.id_shunt as id,
    'Shunt' as type,
    'ps' as phases,
    fixed_shunts.name as name,
    fixed_shunts.secondary_id as name_code,
    buses_connectivity_nodes.id_bus as bus,
    fixed_shunts_models.active as active,
    0 as controlled,
    fixed_shunts.g1 as g,
    fixed_shunts.b1 as b,
	fixed_shunts.b1 as bmax,
    fixed_shunts.b1 as bmin,
    Null as id_impedance_table
FROM fixed_shunts
JOIN buses_connectivity_nodes USING(id_connectivity_node)
JOIN fixed_shunts_models USING(id_shunt)
WHERE switched_shunts_models.id_model = _id_model;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_model_sssc_json` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;

DELIMITER ;;
CREATE DEFINER=`ree`@`%` PROCEDURE `get_model_sssc_json`(IN _id_model VARCHAR(32))
BEGIN

/*
id: Id única, prefentemente generada con UUIDv4
type: Nombre de la clase («SSSC»)
name: Nombre del SSSC
name_code: Código alternativo
bus_from: id del bus «from»
bus_to: id del bus «to»
active: Estado del dispositivo (1: activo, 0: inactivo)
rate: Rating del dispositivo (MW)
contingency_factor1: Multiplicador del rate para contingencias tipo 1
contingency_factor2: Multiplicador del rate para contingencias tipo 2
contingency_factor3: Multiplicador del rate para contingencias tipo 3
rs: Resistencia serie del dispositivo (p.u. del sistema)
xs: Reactancia serie del dispositivo (p.u. del sistema)
control_mode: Modo de conrol. Ver tabla de modos de control.
vset: Tensión de consigna establecida de «envío» en el lado «from» (p.u.)
Pset: Potencia activa establecida de «envío» en el lado «from» (MW)
Qset: Potencia reactiva establecida de «envío» en el lado «from» (MW)
*/

SELECT
	sssc.id_section as id,
    "sssc" as type,
    "ps" as phases,
    sections.name as name,
    sections.secondary_id as name_code,
    get_section_bus_from(sssc.id_section) as bus_from,
    get_section_bus_to(sssc.id_section) as bus_to,
    sssc_models.active as active,
    sections.rating as rate,
    sections.contingency_factor1 as contingency_factor1,
    sections.contingency_factor2 as contingency_factor2,
    sections.contingency_factor3 as contingency_factor3,
    sssc.r as rs,
    sssc.x as xs,
    sssc_models.id_control_mode as control_mode,
    sssc_models.vf_set as Vset,
    sssc_models.Pfset as Pset,
    sssc_models.Qfset as Qset
FROM sssc
JOIN sections USING(id_section)
JOIN sssc_models
WHERE sssc_models.id_model = _id_model;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_model_transformers2w_json` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;

DELIMITER ;;
CREATE DEFINER=`ree`@`%` PROCEDURE `get_model_transformers2w_json`(IN _id_model VARCHAR(32))
BEGIN



/*
id: Id única, prefentemente generada con UUIDv4
type: Nombre de la clase
phases: Tipo de modelos de fases («ps»: positive sequence, «3p»: three phase)
name: Nombre del transformador
name_code: Código alternativo del transformador
bus_from: id del bus «from»
bus_to: id del bus «to»
active: Estado de la línea (1: activo, 0: inactivo)
rate: Rating de potencia de la línea
contingency_factor1: Multiplicador del rate para contingencias tipo 1
contingency_factor2: Multiplicador del rate para contingencias tipo 2
contingency_factor3: Multiplicador del rate para contingencias tipo 3
Vnomf: Tensión nominal del lado «from» en kV
Vnomt: Tensión nominal del lado «to» en kV
r: Resistencia ( en p.u.)
x: Reactancia ( en p.u.)
g: Conductancia shunt total ( en p.u.)
b: Susceptancia shunt total ( en p.u.)
tap_module: Valor del tap ( por defecto 1.0)
min_tap_module: Valor mínimo del tap ( por defecto 0.5)
max_tap_module: Valor máximo del tap ( por defecto 1.5)
id_tap_module_table: ID de la tabla de módulos de taps.
tap_angle: Valor del ángulo ( por defecto 0.0 radianes)
min_tap_angle: Valor mínimo del ángulo ( por defecto 0.0)
max_tap_angle: Valor máximo del ángulo ( por defecto 2π)
id_tap_angle_table: ID de la tabla de ángulos de taps.
control_mode: Modo de conrol. Ver tabla de modos de control.
vset: Tensión de regulación (en p.u.).
pset: Nivel de potencia a regular (MW)
base_temperature: Termperatura base del transformador
operational_temperature: Temperatura operacional del transformador
alpha: Coeficiente térmico del transformador
*/


SELECT
	transformers2w.id_section as id,
    "transformer2w" as type,
    "ps" as phases,
    sections.name as name,
    sections.secondary_id as name_code,
    get_section_bus_from(transformers2w.id_section) as bus_from,
    get_section_bus_to(transformers2w.id_section) as bus_to,
    transformers2w_models.active as active,
    transformers2w_models.rating as rate,
    sections.contingency_factor1 as contingency_factor1,
    sections.contingency_factor2 as contingency_factor2,
    sections.contingency_factor3 as contingency_factor3,
    transformers2w.r1 as r,
    transformers2w.x1 as x,
    transformers2w.g1 as g,
    transformers2w.b1 as b,

    1 as tap_module,
	1 as min_tap_module,
	1 as max_tap_module,
	'' as id_tap_module_table,
	0 as tap_angle,
	0 as min_tap_angle,
	0 as max_tap_angle,
	'' as id_tap_angle_table,
	0 as control_mode,
	1 as vset,
	0 as pset,

    20 as base_temperature,
    20 as operational_temperature,
    0.0033 as alpha
FROM transformers2w
JOIN sections USING(id_section)
JOIN transformers2w_models USING(id_section)
JOIN voltage_regulators
JOIN phase_shifters
WHERE voltage_regulators.id_section is Null  # to not include voltage regulators
	AND phase_shifters.id_section is Null # to not include phase shifters
	AND transformers2w_models.id_model = _id_model

UNION

-- Add voltage regulators
SELECT
	transformers2w.id_section as id,
    "transformer2w" as type,
    "ps" as phases,
    sections.name as name,
    sections.secondary_id as name_code,
    get_section_bus_from(transformers2w.id_section) as bus_from,
    get_section_bus_to(transformers2w.id_section) as bus_to,
    transformers2w_models.active as active,
    transformers2w_models.rating as rate,
    sections.contingency_factor1 as contingency_factor1,
    sections.contingency_factor2 as contingency_factor2,
    sections.contingency_factor3 as contingency_factor3,
    transformers2w.r1 as r,
    transformers2w.x1 as x,
    transformers2w.g1 as g,
    transformers2w.b1 as b,

    transformers2w_models.tap_module as tap_module,
	voltage_regulators.max_ratio as min_tap_module,
	voltage_regulators.min_ratio as max_tap_module,
	'' as id_tap_module_table,

	0 as tap_angle,
	0 as min_tap_angle,
	0 as max_tap_angle,
	'' as id_tap_angle_table,
	0 as control_mode,

	transformers2w_models.v_control as vset,

    1 as pset,

    20 as base_temperature,
    20 as operational_temperature,
    0.0033 as alpha
FROM transformers2w
JOIN voltage_regulators USING(id_section)
JOIN sections USING(id_section)
JOIN transformers2w_models USING(id_section)
WHERE transformers2w_models.id_model = _id_model

UNION

-- Add phase shifters
SELECT
	transformers2w.id_section as id,
    "transformer2w" as type,
    "ps" as phases,
    sections.name as name,
    sections.secondary_id as name_code,
    get_section_bus_from(transformers2w.id_section) as bus_from,
    get_section_bus_to(transformers2w.id_section) as bus_to,
    transformers2w_models.active as active,
    transformers2w_models.rating as rate,
    sections.contingency_factor1 as contingency_factor1,
    sections.contingency_factor2 as contingency_factor2,
    sections.contingency_factor3 as contingency_factor3,
    transformers2w.r1 as r,
    transformers2w.x1 as x,
    transformers2w.g1 as g,
    transformers2w.b1 as b,

    1 as tap_module,
	1 as min_tap_module,
	1 as max_tap_module,
	'' as id_tap_module_table,

	0 as tap_angle,
	phase_shifters.min_angle as min_tap_angle,
	phase_shifters.max_angle as max_tap_angle,
	'' as id_tap_angle_table,

    2 as control_mode,

	1 as vset,
    transformers2w_models.p_control as pset,

    20 as base_temperature,
    20 as operational_temperature,
    0.0033 as alpha
FROM transformers2w
JOIN phase_shifters USING(id_section)
JOIN sections USING(id_section)
JOIN transformers2w_models USING(id_section)
WHERE transformers2w_models.id_model = _id_model;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_model_upfc_json` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;

DELIMITER ;;
CREATE DEFINER=`ree`@`%` PROCEDURE `get_model_upfc_json`(IN _id_model VARCHAR(32))
BEGIN

/*
id: Id única, prefentemente generada con UUIDv4
type: Nombre de la clase («upfc»)
name: Nombre del dispositivo
name_code: Código alternativo del dispositivo
bus_from: id del bus «from»
bus_to: id del bus «to»
active: Estado del dispositivo (1: activo, 0: inactivo)
rate: Rating de potencia del dispositivo (MW)
contingency_factor1: Multiplicador del rate para contingencias tipo 1
contingency_factor2: Multiplicador del rate para contingencias tipo 2
contingency_factor3: Multiplicador del rate para contingencias tipo 3
rl: Resistencia del dispositivo (p.u. del sistema)
xl: Reactancia del dispositivo (p.u. del sistema)
bl: Susceptancia del dispositivo (p.u. del sistema)
rs: Resistencia serie del dispositivo (p.u. del sistema)
xs: Reactancia serie del dispositivo (p.u. del sistema)
rsh: Resistencia shunt del dispositivo (p.u. del sistema)
xsh: Reactancia shunt del dispositivo (p.u. del sistema)
vsh: Tensión de set point en en lado «from» (p.u. del sistema)
Pset: Potencia activa establecida de «envío» en el lado «from» (MW)
Qset: Potencia reactiva establecida de «envío» en el lado «from» (MW)
*/

SELECT
	upfc.id_section as id,
    "upfc" as type,
    "ps" as phases,
    sections.name as name,
    sections.secondary_id as name_code,
    get_section_bus_from(upfc.id_section) as bus_from,
    get_section_bus_to(upfc.id_section) as bus_to,
    upfc_models.active as active,
    sections.rating as rate,
    sections.contingency_factor1 as contingency_factor1,
    sections.contingency_factor2 as contingency_factor2,
    sections.contingency_factor3 as contingency_factor3,
    upfc.rl as rl,
    upfc.xl as xl,
    upfc.bl as bl,
    upfc.rs as rs,
    upfc.xs as xs,
    upfc.rsh as rsh,
    upfc.xsh as xsh,
    upfc_models.vsh as vsh,
    upfc_models.Pfset as Pset,
    upfc_models.Qfset as Qset
FROM upfc
JOIN sections USING(id_section)
JOIN upfc_models USING(id_section)
WHERE upfc_models.id_model = _id_model;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_model_vsc_json` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;

DELIMITER ;;
CREATE DEFINER=`ree`@`%` PROCEDURE `get_model_vsc_json`(IN _id_model VARCHAR(32))
BEGIN

/*
id: Id única, prefentemente generada con UUIDv4
type: Nombre de la clase («vsc»)
name: Nombre del dispositivo
name_code: Código alternativo del convertidor
bus_from: id del bus «from», es el lado DC siempre.
bus_to: id del bus «to», es el lado AC siempre.
active: Estado del dispositivo (1: activo, 0: inactivo)
rate: Rating de potencia del dispositivo en MW
contingency_factor1: Multiplicador del rate para contingencias tipo 1
contingency_factor2: Multiplicador del rate para contingencias tipo 2
contingency_factor3: Multiplicador del rate para contingencias tipo 3
r: Resistencia que modela las pérdidas resistivas (p.u. del sistema)
x: Reactancia que modela las pérdidas magnéticas (p.u. del sistema)
g: Conductancia que modela las pérdidas del inversor (p.u. del sistema)
m: Valor del control de tensión (equivale a los taps del transformador) (p.u.)
m_max: Valor máximo del control de tensión (p.u.)
m_min: Valor mínimo del control de tensión (p.u.)
theta: Ángulo de disparo del convertidor (radianes)
theta_max: Ángulo de disparo máximo del convertidor (radianes)
theta_min: Ángulo de disparo mínimo del convertidor (radianes)
Beq: Susceptancia que absorve la reaciva de la parte DC convertidor (radianes)
Beq_max: Ángulo de disparo máximo del convertidor (radianes)
Beq_min: Ángulo de disparo mínimo del convertidor (radianes)
alpha1: Parámetro 1 de la curva de pérdidas IEC 62751-2
alpha2: Parámetro 2 de la curva de pérdidas IEC 62751-2
alpha3: Parámetro 3 de la curva de pérdidas IEC 62751-2
k: Factor del convertidor. (Habitualmente sqrt(3) / 2 = 0.866666)
kdp: Pendiente del control droop potencia / Tensión. (p.u. / p.u.)
Pfset: Potencia establecida en el control de potencia activa (MW)
Qfset: Potencia establecida en el control de potencia reactiva (MW)
vac_set: Tensión establecida en el control de tensión AC. (p.u.)
vdc_set: Tensión establecida en el control de tensión DC. (p.u.)
mode: Modo de control. Ver la tabla adjunta.
*/

SELECT
	vsc.id_section as id,
    "vsc" as type,
    "ps" as phases,
    sections.name as name,
    sections.secondary_id as name_code,
    get_section_bus_from(vsc.id_section) as bus_from,
    get_section_bus_to(vsc.id_section) as bus_to,
    vsc_models.active as active,
    sections.rating as rate,
    sections.contingency_factor1 as contingency_factor1,
    sections.contingency_factor2 as contingency_factor2,
    sections.contingency_factor3 as contingency_factor3,
    vsc.r as r,
    vsc.x as x,
    0 as g,
    vsc_models.m as m,
    vsc_models.theta as theta,
    vsc.m_max as m_max,
    vsc.m_min as m_min,
    vsc.theta_max as theta_max,
    vsc.theta_min as theta_min,
    vsc.Beq_max as Beq_max,
    vsc.Beq_min as Beq_min,
    vsc.alpha1 as alpha1,
    vsc.alpha2 as alpha2,
    vsc.alpha3 as alpha3,
    vsc.k as k,
    vsc.kdp as kdp,
    vsc_models.Pfset as Pfset,
    vsc_models.Qfset as Qfset,
    vsc_models.vac_set as vac_set,
    vsc_models.vdc_set as vdc_set,
    vsc_models.id_control_mode as control_mode
FROM vsc
JOIN sections USING(id_section)
JOIN vsc_models USING(id_section)
WHERE vsc_models.id_model = _id_model;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_substation` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;

DELIMITER ;;
CREATE DEFINER=`ree`@`%` PROCEDURE `get_substation`(_id_substation varchar(32))
BEGIN
	SELECT
		substations.name as substation,
		substations.latitude,
		substations.longitude,
		zones.name as zone,
		provinces.name as province,
		communities.name as community,
		countries.name as country,
        substations.id_substation,
		zones.id_zone,
		provinces.id_province,
		communities.id_community,
		countries.id_country
	FROM substations
	LEFT JOIN zones USING (id_zone)
	LEFT JOIN provinces USING (id_province)
	LEFT JOIN communities USING (id_community)
	LEFT JOIN countries USING (id_country)
    WHERE substations.id_substation = _id_substation;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `read_substations` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;

DELIMITER ;;
CREATE DEFINER=`ree`@`%` PROCEDURE `read_substations`()
BEGIN
	SELECT
		substations.name as substation,
		substations.latitude,
		substations.longitude,
		zones.name as zone,
		provinces.name as province,
		communities.name as community,
		countries.name as country,
        substations.id_substation,
		zones.id_zone,
		provinces.id_province,
		communities.id_community,
		countries.id_country
	FROM substations
	INNER JOIN zones USING (id_zone)
	INNER JOIN provinces USING (id_province)
	INNER JOIN communities USING (id_community)
	INNER JOIN countries USING (id_country);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_substation` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;

DELIMITER ;;
CREATE DEFINER=`ree`@`%` PROCEDURE `update_substation`(
	IN _id_substation varchar(32),
	IN _params JSON
)
BEGIN
	-- Declare params coming from the JSON object
    DECLARE _name VARCHAR(256)
		DEFAULT NULLIF(JSON_UNQUOTE(JSON_EXTRACT(_params, '$.name')), 'null');
    DECLARE _latitude FLOAT
		DEFAULT NULLIF(JSON_UNQUOTE(JSON_EXTRACT(_params, '$.latitude')), 'null');
    DECLARE _longitude FLOAT
		DEFAULT NULLIF(JSON_UNQUOTE(JSON_EXTRACT(_params, '$.longitude')), 'null');
    DECLARE _online_date DATE
		DEFAULT NULLIF(JSON_UNQUOTE(JSON_EXTRACT(_params, '$.online_date')), 'null');
    DECLARE _offline_date DATE
		DEFAULT NULLIF(JSON_UNQUOTE(JSON_EXTRACT(_params, '$.offine_date')), 'null');
    DECLARE _id_zone VARCHAR(32)
		DEFAULT NULLIF(JSON_UNQUOTE(JSON_EXTRACT(_params, '$.id_zone')), 'null');
    DECLARE _id_province VARCHAR(32)
		DEFAULT NULLIF(JSON_UNQUOTE(JSON_EXTRACT(_params, '$.id_province')), 'null');

    -- Declare variables to store the current data (in case of update)
    DECLARE _curr_name VARCHAR(256);
    DECLARE _curr_latitude FLOAT;
    DECLARE _curr_longitude FLOAT;
    DECLARE _curr_id_zone VARCHAR(32);
    DECLARE _curr_id_province VARCHAR(32);
    DECLARE _curr_online_date DATE;
    DECLARE _curr_offline_date DATE;

    -- Get current data (if any)
	SELECT
		substations.name,
		substations.latitude,
		substations.longitude,
		substations.id_zone,
		substations.id_province,
		substations.online_date,
		substations.offline_date
	INTO
		_curr_name,
		_curr_latitude,
		_curr_longitude,
		_curr_id_zone,
		_curr_id_province,
		_curr_online_date,
		_curr_offline_date
	FROM substations
	WHERE substations.id_substation = _id_substation;
	-- Update comparing against current data
	UPDATE substations
	SET     substations.name = IF(_name is not NULL, _name, _curr_name),
			latitude = IF(_latitude is not NULL, _latitude, _curr_latitude),
			longitude = IF(_longitude is not NULL, _longitude, _curr_longitude),
			online_date = IF(_online_date is not NULL, _online_date, _curr_online_date),
			offline_date = IF(_offline_date is not NULL, _offline_date, _curr_offline_date),
			id_zone = IF(_id_zone is not NULL, _id_zone, _curr_id_zone),
			id_province = IF(_id_province is not NULL, _id_province, _curr_id_province)
	WHERE  id_substation = _id_substation;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `sections_bus`
--

/*!50001 DROP VIEW IF EXISTS `sections_bus`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`ree`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `sections_bus` AS select `q1`.`section_name1` AS `section_name1`,`q1`.`bus_name1` AS `bus_name1`,`q2`.`bus_name2` AS `bus_name2`,`q1`.`sid1` AS `sid1`,`q1`.`bid1` AS `bid1`,`q2`.`bid2` AS `bid2` from (((select `sections`.`id_section` AS `sid1`,`sections`.`name` AS `section_name1`,`buses`.`name` AS `bus_name1`,`buses`.`id_bus` AS `bid1` from ((`sections` join `buses_connectivity_nodes` on((`sections`.`id_connectivity_node_1` = `buses_connectivity_nodes`.`id_connectivity_node`))) join `buses` on((`buses_connectivity_nodes`.`id_bus` = `buses`.`id_bus`))))) `q1` join (select `sections`.`id_section` AS `sid2`,`sections`.`name` AS `section_name2`,`buses`.`name` AS `bus_name2`,`buses`.`id_bus` AS `bid2` from ((`sections` join `buses_connectivity_nodes` on((`sections`.`id_connectivity_node_2` = `buses_connectivity_nodes`.`id_connectivity_node`))) join `buses` on((`buses_connectivity_nodes`.`id_bus` = `buses`.`id_bus`)))) `q2`) where (`q1`.`sid1` = `q2`.`sid2`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-07-12 16:25:38

-- =====================================
-- 4 nodes grid extension
-- =====================================

-- New model
INSERT INTO `assets`.`models`
  (`id_model`, `name`, `valid_date`, `creation_date`, `created_by`, `comments`) VALUES
  ('93b3a87410b942c8817b45b42ada2dee', 'Red D', '2026-01-01','2021-07-05','admin','Conversión a Node-Breaker');

-- Assign as child
INSERT INTO `models_models`
  (`id_model_parent`, `id_model_child`) VALUES
  ('883376684f3e4dedbe831f6e6b2a1ab8','93b3a87410b942c8817b45b42ada2dee');

-- Add CNs into model
INSERT INTO `connectivity_nodes`
  (`id_connectivity_node`, `id_model`, `action`, `name`, `x`, `y`) VALUES
  ('ed51641bdc084004b57bf2015f015a75','93b3a87410b942c8817b45b42ada2dee',1,'c80',0,0),
  ('be42ea18ef674db69975fb4b8495500a','93b3a87410b942c8817b45b42ada2dee',1,'c81',0,0),
  ('c341eb4777c94b5898c53d6faaea48b5','93b3a87410b942c8817b45b42ada2dee',1,'c82',0,0),
  ('ee48ac68864847fb92970906d921c238','93b3a87410b942c8817b45b42ada2dee',1,'c83',0,0),
  ('3b3c599110b9435e8f8d07bfd0c84c4b','93b3a87410b942c8817b45b42ada2dee',1,'c84',0,0);

-- Connect CNs to buses
INSERT INTO `buses_connectivity_nodes`
  (`id_bus`,`id_connectivity_node`,`id_model`,`action`) VALUES
  ('d13a5876e22749e3acb5083b31f06dfc', 'ed51641bdc084004b57bf2015f015a75','93b3a87410b942c8817b45b42ada2dee',1),
  ('46a53a056a3542eeb5e53591568463cf', 'be42ea18ef674db69975fb4b8495500a','93b3a87410b942c8817b45b42ada2dee',1),
  ('d13a5876e22749e3acb5083b31f06dfc', 'c341eb4777c94b5898c53d6faaea48b5','93b3a87410b942c8817b45b42ada2dee',1);

-- Add new section into model, S33 connecting new CN (c80) with old CN f427933e896940c2bda8a994ef72d1b1 (c26)
-- Add new section into model, connecting new CN (c81) with old CN 6a2d55cf3f8b4052b2b6a80b0b7669ed (c15)
-- Add new section into model, S35 connecting new CNs ee48ac68864847fb92970906d921c238 (c83) and c341eb4777c94b5898c53d6faaea48b5 (c82)
-- Add new section into model, I22 connecting new CNs ee48ac68864847fb92970906d921c238 (c83) and 3b3c599110b9435e8f8d07bfd0c84c4b (c84)
-- Add new section into model, S37 connecting new CN (c84) with old CN 33b76167770441cc94edb63881b1e550 (c24)
INSERT INTO `sections`
  (`id_section`,`id_model`,`action`,`id_connectivity_node_1`,`id_connectivity_node_2`,`active`,`name`,`rating`,`id_rating_profile`,`contingency_factor1`,`contingency_factor2`,`contingency_factor3`,`online_date`,`offline_date`,`mttf`,`mttr`,`secondary_id`,`sequential`) VALUES
  ('41c2c0abf80a4095aed64a506c1813ff','93b3a87410b942c8817b45b42ada2dee',1,'ed51641bdc084004b57bf2015f015a75','f427933e896940c2bda8a994ef72d1b1',0,'s33',9999,NULL,1,1,1,NULL,NULL,NULL,NULL,NULL,1),
  ('aefe73ff8b4b4906b899cbaba1091e65','93b3a87410b942c8817b45b42ada2dee',1,'be42ea18ef674db69975fb4b8495500a','6a2d55cf3f8b4052b2b6a80b0b7669ed',0,'s34',9999,NULL,1,1,1,NULL,NULL,NULL,NULL,NULL,1),
  ('2a352069f4db478cb87d5c60dda38ed6','93b3a87410b942c8817b45b42ada2dee',1,'c341eb4777c94b5898c53d6faaea48b5','ee48ac68864847fb92970906d921c238',0,'s35',9999,NULL,1,1,1,NULL,NULL,NULL,NULL,NULL,1),
  ('dd93da4b764d41749ea324b5aae09927','93b3a87410b942c8817b45b42ada2dee',1,'ee48ac68864847fb92970906d921c238','3b3c599110b9435e8f8d07bfd0c84c4b',0,'i22',9999,NULL,1,1,1,NULL,NULL,NULL,NULL,NULL,1),
  ('981f77409efb430b8dbbb6ec1475e595','93b3a87410b942c8817b45b42ada2dee',1,'3b3c599110b9435e8f8d07bfd0c84c4b','33b76167770441cc94edb63881b1e550',0,'s37',9999,NULL,1,1,1,NULL,NULL,NULL,NULL,NULL,1);

-- Set sections as: breaker (type 1) or switch (type 0)
INSERT INTO `switches`
  (`id_section`,`id_model`,`action`,`normal_state`,`switch_type`) VALUES
  ('41c2c0abf80a4095aed64a506c1813ff','93b3a87410b942c8817b45b42ada2dee',1,0,0),
  ('aefe73ff8b4b4906b899cbaba1091e65','93b3a87410b942c8817b45b42ada2dee',1,0,0),
  ('2a352069f4db478cb87d5c60dda38ed6','93b3a87410b942c8817b45b42ada2dee',1,0,0),
  ('dd93da4b764d41749ea324b5aae09927','93b3a87410b942c8817b45b42ada2dee',1,0,1),
  ('981f77409efb430b8dbbb6ec1475e595','93b3a87410b942c8817b45b42ada2dee',1,0,0);

-- Set CNs as internal for each voltage level
INSERT INTO `connectivity_nodes_voltage_levels`
  (`id_connectivity_node`,`id_voltage_level`,`id_model`,`action`) VALUES
  ('ed51641bdc084004b57bf2015f015a75','4c6f97d6e21a40aba03c62f8dd2d9979','93b3a87410b942c8817b45b42ada2dee',1),
  ('be42ea18ef674db69975fb4b8495500a','4c6f97d6e21a40aba03c62f8dd2d9979','93b3a87410b942c8817b45b42ada2dee',1),
  ('c341eb4777c94b5898c53d6faaea48b5','4c6f97d6e21a40aba03c62f8dd2d9979','93b3a87410b942c8817b45b42ada2dee',1),
  ('ee48ac68864847fb92970906d921c238','4c6f97d6e21a40aba03c62f8dd2d9979','93b3a87410b942c8817b45b42ada2dee',1),
  ('3b3c599110b9435e8f8d07bfd0c84c4b','4c6f97d6e21a40aba03c62f8dd2d9979','93b3a87410b942c8817b45b42ada2dee',1);



--
-- Dumping data for table `bays_positions`
--

DROP TABLE IF EXISTS `bays_positions`;
CREATE TABLE `bays_positions` (
  `id_bay` VARCHAR(32) NOT NULL,
  `id_position` VARCHAR(32) NOT NULL,
  `id_model` VARCHAR(32) NOT NULL,
  `action` TINYINT(4) NOT NULL,
  PRIMARY KEY (`id_bay`, `id_position`, `id_model`),
  CONSTRAINT `fk_bays_positions_bay` FOREIGN KEY (`id_bay`) REFERENCES  `bays` (`id_bay`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_bays_positions_position`FOREIGN KEY (`id_position`) REFERENCES `positions` (`id_position`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_bays_positions_model`FOREIGN KEY (`id_model`) REFERENCES `models` (`id_model`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- change duplicated names S23, S24, S25, S26 changes to S38, S39, S40, S41
INSERT INTO `sections`
  (`id_section`, `id_model`, `action`, `id_connectivity_node_1`, `id_connectivity_node_2`, `active`, `name`, `rating`, `id_rating_profile`, `contingency_factor1`, `contingency_factor2`, `contingency_factor3`, `online_date`, `offline_date`, `mttf`, `mttr`, `secondary_id`, `sequential`) VALUES
  ('03a9f58df60e4d9f8aa9cd6ac786aee8','93b3a87410b942c8817b45b42ada2dee',0,'13e11b1a2b014126b5754b8efc909130','4ae1b9eb41bf4634878afac593703a6a',1,'S38',9999,NULL,1,1,1,NULL,NULL,NULL,NULL,NULL,1),
  ('5bbeb19027874225af25cfba9d8df0ae','93b3a87410b942c8817b45b42ada2dee',0,'b36405f8f0f140648444c1231bf73a86','ba9d35b4725048adb9682b9ba85ce0b4',1,'S39',9999,NULL,1,1,1,NULL,NULL,NULL,NULL,NULL,1),
  ('f7ee8e3a41cf485da80ef92e6fafc37a','93b3a87410b942c8817b45b42ada2dee',0,'ef6b962490544e6682b86e0fd83c33bf','cc89d0c029214d44b2878bc738be52c9',1,'S40',9999,NULL,1,1,1,NULL,NULL,NULL,NULL,NULL,1),
  ('ccbb06fe8b004dbab910b8ccb8e5ddec','93b3a87410b942c8817b45b42ada2dee',0,'08b0b9b95c954724bca93fd8d009adf6','85076048f6f846aa81a6767cb7de0808',1,'S41',9999,NULL,1,1,1,NULL,NULL,NULL,NULL,NULL,1);


--
-- Change Barcelona 400 to breaker-and-a-half configuration
---

-- delete bus bars connections
INSERT INTO `buses_connectivity_nodes`
  (`id_bus`, `id_connectivity_node`, `id_model`, `action`) VALUES
  ('1ddcf194ac1f48999ce0e5b58ed0e2f0','972aac9009694a40b5369eef7afe8e45','93b3a87410b942c8817b45b42ada2dee',-1),
  ('10e008e3326e40eba379588e50af2eea','72270e722510489297950e53229b9f18','93b3a87410b942c8817b45b42ada2dee',-1);


-- delete connectivity nodes in voltage level
INSERT INTO `connectivity_nodes_voltage_levels`
  (`id_connectivity_node`, `id_voltage_level`, `id_model`, `action`) VALUES
  ('972aac9009694a40b5369eef7afe8e45','271f651a18754726b5cf54b6b34a03b6', '93b3a87410b942c8817b45b42ada2dee',-1),
  ('72270e722510489297950e53229b9f18', '271f651a18754726b5cf54b6b34a03b6','93b3a87410b942c8817b45b42ada2dee',-1);


-- delete connectivity nodes
INSERT INTO `connectivity_nodes`
  (`id_connectivity_node`, `id_model`, `action`, `name`, `x`, `y`) VALUES
  ('972aac9009694a40b5369eef7afe8e45','93b3a87410b942c8817b45b42ada2dee',-1,'c65',0,0),
  ('72270e722510489297950e53229b9f18','93b3a87410b942c8817b45b42ada2dee',-1,'c62',0,0);


-- add new connectivity nodes
INSERT INTO `connectivity_nodes`
  (`id_connectivity_node`, `id_model`, `action`, `name`, `x`, `y`) VALUES
  ('0116998940604ff1a274e264ba4047a9','93b3a87410b942c8817b45b42ada2dee',1,'c85',0,0),
  ('2679986119284dc580e02269cdb9a55f','93b3a87410b942c8817b45b42ada2dee',1,'c86',0,0);


-- declare voltage level for c85, c86
INSERT INTO `connectivity_nodes_voltage_levels`
  (`id_connectivity_node`, `id_voltage_level`, `id_model`, `action`) VALUES
  ('0116998940604ff1a274e264ba4047a9','271f651a18754726b5cf54b6b34a03b6','93b3a87410b942c8817b45b42ada2dee',1),
  ('2679986119284dc580e02269cdb9a55f','271f651a18754726b5cf54b6b34a03b6','93b3a87410b942c8817b45b42ada2dee',1);

-- change S26, S25 connections
INSERT INTO `sections`
  (`id_section`, `id_model`, `action`, `id_connectivity_node_1`, `id_connectivity_node_2`, `active`, `name`, `rating`, `id_rating_profile`, `contingency_factor1`, `contingency_factor2`, `contingency_factor3`, `online_date`, `offline_date`, `mttf`, `mttr`, `secondary_id`, `sequential`) VALUES
  ('cb5f7e82e6564c68b79eee506bc6c6d6','93b3a87410b942c8817b45b42ada2dee',0,'575717c169ea4c4e815075200684dedf','9b971863578447bcbf28dcde17f37c28',1,'s26',9999,NULL,1,1,1,NULL,NULL,NULL,NULL,NULL,1),
  ('882507ee84284c03ad35981632ebe284','93b3a87410b942c8817b45b42ada2dee',0,'13e11b1a2b014126b5754b8efc909130','f74c93db485e4a0c94e1ce0ac95a7546',1,'s25',9999,NULL,1,1,1,NULL,NULL,NULL,NULL,NULL,1);


-- add S42, S43
INSERT INTO `sections`
  (`id_section`, `id_model`, `action`, `id_connectivity_node_1`, `id_connectivity_node_2`, `active`, `name`, `rating`, `id_rating_profile`, `contingency_factor1`, `contingency_factor2`, `contingency_factor3`, `online_date`, `offline_date`, `mttf`, `mttr`, `secondary_id`, `sequential`) VALUES
  ('8c88d08d4ff144208be6a46822122fad','93b3a87410b942c8817b45b42ada2dee',1,'0116998940604ff1a274e264ba4047a9','9b971863578447bcbf28dcde17f37c28',1,'s42',9999,NULL,1,1,1,NULL,NULL,NULL,NULL,NULL,1),
  ('814ccb57cbd94ce2b3854d61b66cab9a','93b3a87410b942c8817b45b42ada2dee',1,'2679986119284dc580e02269cdb9a55f','13e11b1a2b014126b5754b8efc909130',1,'s43',9999,NULL,1,1,1,NULL,NULL,NULL,NULL,NULL,1);


-- declare s42, s43 as switches
INSERT INTO `switches`
  (`id_section`, `id_model`, `action`, `normal_state`, `switch_type`) VALUES
  ('8c88d08d4ff144208be6a46822122fad', '93b3a87410b942c8817b45b42ada2dee', 1, 1, 0),
  ('814ccb57cbd94ce2b3854d61b66cab9a', '93b3a87410b942c8817b45b42ada2dee', 1, 1, 0);



-- update L5, L6 connection
INSERT INTO `sections`
  (`id_section`, `id_model`, `action`, `id_connectivity_node_1`, `id_connectivity_node_2`, `active`, `name`, `rating`, `id_rating_profile`, `contingency_factor1`, `contingency_factor2`, `contingency_factor3`, `online_date`, `offline_date`, `mttf`, `mttr`, `secondary_id`, `sequential`) VALUES
  ('72e0cc5e0c164003a83dd734386dc7c6','93b3a87410b942c8817b45b42ada2dee',0,'60d80db791ed40b0b2590b12b1fc1132','0116998940604ff1a274e264ba4047a9',1,'L5',1200,NULL,1,1,1,NULL,NULL,NULL,NULL,NULL,1),
  ('e171b791dd2e456996cf0496294ef2b0','93b3a87410b942c8817b45b42ada2dee',0,'a6299206f9104abbb7cce40f46f2ebb2','2679986119284dc580e02269cdb9a55f',1,'L6',1200,NULL,1,1,1,NULL,NULL,NULL,NULL,NULL,1);

--
-- Create positions
--

INSERT INTO `positions`
  (`id_position`, `id_model`, `action`, `id_position_type`, `online_date`, `offline_date`) VALUES
  -- Málaga 220
  ('d07669a7d80a448ea17674d44d746396', '93b3a87410b942c8817b45b42ada2dee', 1, 0, '2021-08-10', NULL),
  ('e0dfec4f193a4d6d91247f63bf0ae159', '93b3a87410b942c8817b45b42ada2dee', 1, 0, '2021-08-10', NULL),
  ('97a5960d2f454b1a84a27f8f35d4d257', '93b3a87410b942c8817b45b42ada2dee', 1, 0, '2021-08-10', NULL),
  -- Málaga 400
  ('84680f1f00794ae994ece98f6e9b0e6d', '93b3a87410b942c8817b45b42ada2dee', 1, 0, '2021-08-10', NULL),
  ('a5308a3ebfaa4fabbc75bed6a577461f', '93b3a87410b942c8817b45b42ada2dee', 1, 0, '2021-08-10', NULL),
  ('e8d80af84902485fbc975672b4113239', '93b3a87410b942c8817b45b42ada2dee', 1, 0, '2021-08-10', NULL),
  ('1f3ac2a25d5648459a569bdc1f59bd79', '93b3a87410b942c8817b45b42ada2dee', 1, 0, '2021-08-10', NULL),
  ('edc0422c012c4f50ba86ec79be78a070', '93b3a87410b942c8817b45b42ada2dee', 1, 0, '2021-08-10', NULL),
  -- Gijón 400
  ('3f01bde018fd4ba28a3147ce35b734e7', '93b3a87410b942c8817b45b42ada2dee', 1, 0, '2021-08-10', NULL),
  ('7455a1b97be84052a3f90d34c73695d5', '93b3a87410b942c8817b45b42ada2dee', 1, 0, '2021-08-10', NULL),
  ('b194a75d005841d7a1a8a09069a960a8', '93b3a87410b942c8817b45b42ada2dee', 1, 0, '2021-08-10', NULL),
  ('dab52f51d8224887be6790ded1a373fa', '93b3a87410b942c8817b45b42ada2dee', 1, 0, '2021-08-10', NULL),
  -- Sevilla 400
  ('de00fdcac8d34ec1b9c022fa75082252', '93b3a87410b942c8817b45b42ada2dee', 1, 0, '2021-08-10', NULL),
  ('b725a7bf3ff54194b56b5f3e47e64ad2', '93b3a87410b942c8817b45b42ada2dee', 1, 0, '2021-08-10', NULL),
  ('1eb664a43c1c4cac9fa4ea7d5aaabb83', '93b3a87410b942c8817b45b42ada2dee', 1, 0, '2021-08-10', NULL),
  ('0ce346ff163c4deeac726fdcc562c268', '93b3a87410b942c8817b45b42ada2dee', 1, 0, '2021-08-10', NULL),
  ('ee431dd8ae6147cd9cace9f61c8eced3', '93b3a87410b942c8817b45b42ada2dee', 1, 0, '2021-08-10', NULL),
  -- Barcelona 400
  ('5be5e3d4eafa4d238849eae454ebb383', '93b3a87410b942c8817b45b42ada2dee', 1, 0, '2021-08-10', NULL),
  ('ddcd29302e254b548624c3904b6c596a', '93b3a87410b942c8817b45b42ada2dee', 1, 0, '2021-08-10', NULL),
  ('4a4fb92a83ae41329e2e5db9058e5a59', '93b3a87410b942c8817b45b42ada2dee', 1, 0, '2021-08-10', NULL),
  ('3321457d06504b24a835c22ac359bc02', '93b3a87410b942c8817b45b42ada2dee', 1, 0, '2021-08-10', NULL);

-- add position and buses relations
INSERT INTO `positions_buses`
  (`id_position`, `id_bus`, `id_model`, `action`) VALUES
  -- Málaga 220
  ('d07669a7d80a448ea17674d44d746396', 'ae396164fd304c279bb5d4359e7c41f4', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('d07669a7d80a448ea17674d44d746396', '6e011d64d51a4a42a1cffb992d290cfd', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('e0dfec4f193a4d6d91247f63bf0ae159', '6e011d64d51a4a42a1cffb992d290cfd', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('97a5960d2f454b1a84a27f8f35d4d257', 'ae396164fd304c279bb5d4359e7c41f4', '93b3a87410b942c8817b45b42ada2dee', 1),
  -- Málaga 400
  ('84680f1f00794ae994ece98f6e9b0e6d', 'd13a5876e22749e3acb5083b31f06dfc', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('84680f1f00794ae994ece98f6e9b0e6d', '46a53a056a3542eeb5e53591568463cf', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('a5308a3ebfaa4fabbc75bed6a577461f', 'd13a5876e22749e3acb5083b31f06dfc', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('a5308a3ebfaa4fabbc75bed6a577461f', '46a53a056a3542eeb5e53591568463cf', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('e8d80af84902485fbc975672b4113239', 'd13a5876e22749e3acb5083b31f06dfc', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('e8d80af84902485fbc975672b4113239', '46a53a056a3542eeb5e53591568463cf', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('1f3ac2a25d5648459a569bdc1f59bd79', 'd13a5876e22749e3acb5083b31f06dfc', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('1f3ac2a25d5648459a569bdc1f59bd79', '46a53a056a3542eeb5e53591568463cf', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('edc0422c012c4f50ba86ec79be78a070', 'd13a5876e22749e3acb5083b31f06dfc', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('edc0422c012c4f50ba86ec79be78a070', '46a53a056a3542eeb5e53591568463cf', '93b3a87410b942c8817b45b42ada2dee', 1),
  -- Gijón 400
  ('3f01bde018fd4ba28a3147ce35b734e7', '50c0e3f55ce24a1180c824cc155b8ffa', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('3f01bde018fd4ba28a3147ce35b734e7', 'dc5348213e904df1988cc5b7f9db8d13', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('7455a1b97be84052a3f90d34c73695d5', '50c0e3f55ce24a1180c824cc155b8ffa', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('dab52f51d8224887be6790ded1a373fa', '50c0e3f55ce24a1180c824cc155b8ffa', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('b194a75d005841d7a1a8a09069a960a8', 'dc5348213e904df1988cc5b7f9db8d13', '93b3a87410b942c8817b45b42ada2dee', 1),
  -- Sevilla 400
  ('de00fdcac8d34ec1b9c022fa75082252', '0cd72bbb1a66449891630a0ad447b846', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('de00fdcac8d34ec1b9c022fa75082252', 'f939e7bcbe4c4df098e897806dab4f87', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('b725a7bf3ff54194b56b5f3e47e64ad2', '0cd72bbb1a66449891630a0ad447b846', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('1eb664a43c1c4cac9fa4ea7d5aaabb83', 'f939e7bcbe4c4df098e897806dab4f87', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('0ce346ff163c4deeac726fdcc562c268', '0cd72bbb1a66449891630a0ad447b846', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('ee431dd8ae6147cd9cace9f61c8eced3', 'f939e7bcbe4c4df098e897806dab4f87', '93b3a87410b942c8817b45b42ada2dee', 1),
  -- Barcelona 400
  ('5be5e3d4eafa4d238849eae454ebb383', '1ddcf194ac1f48999ce0e5b58ed0e2f0', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('4a4fb92a83ae41329e2e5db9058e5a59', '10e008e3326e40eba379588e50af2eea', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('3321457d06504b24a835c22ac359bc02', '10e008e3326e40eba379588e50af2eea', '93b3a87410b942c8817b45b42ada2dee', 1);

-- add positions and section relations
INSERT INTO `positions_sections`
  (`id_position`, `id_section`, `id_model`, `action`) VALUES
  -- Málaga 220
  ('d07669a7d80a448ea17674d44d746396', '59307e467ae74533859a2d22d2157add', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('d07669a7d80a448ea17674d44d746396', '75a4f7111f954ed68d5fc6f90b45df5c', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('d07669a7d80a448ea17674d44d746396', '5998c99f9ddf489d9eb885228d9e4d83', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('e0dfec4f193a4d6d91247f63bf0ae159', '6b20530bb5ae46629837af85e6192f15', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('e0dfec4f193a4d6d91247f63bf0ae159', '694587e4245f4437a0216e24ccecdc47', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('e0dfec4f193a4d6d91247f63bf0ae159', '3282195a7aef43d7a4f1453059f11bcf', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('97a5960d2f454b1a84a27f8f35d4d257', 'f7ee8e3a41cf485da80ef92e6fafc37a', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('97a5960d2f454b1a84a27f8f35d4d257', 'ccbb06fe8b004dbab910b8ccb8e5ddec', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('97a5960d2f454b1a84a27f8f35d4d257', '9e31c2edf3de49b698d1b624ec28ac7b', '93b3a87410b942c8817b45b42ada2dee', 1),
  -- Málaga 400
  ('84680f1f00794ae994ece98f6e9b0e6d', 'bd9a5a2e634d4811853f0e3c31d7cd69', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('84680f1f00794ae994ece98f6e9b0e6d', '489a81f4e52c4389ae9ff536c12a87ec', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('84680f1f00794ae994ece98f6e9b0e6d', '9b9750c171e146f19c76c7c9120429bc', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('a5308a3ebfaa4fabbc75bed6a577461f', 'be235955a329417892ee0ea507dbf555', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('a5308a3ebfaa4fabbc75bed6a577461f', '89648e78ff9c4f92bcdc8f497a02c067', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('a5308a3ebfaa4fabbc75bed6a577461f', 'aefe73ff8b4b4906b899cbaba1091e65', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('a5308a3ebfaa4fabbc75bed6a577461f', 'db5a825f24054b6d97810dd6917bd6df', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('e8d80af84902485fbc975672b4113239', '80ee040765964aab84a1567b604d9222', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('e8d80af84902485fbc975672b4113239', '6f19602218fe493789fbf49c357aa946', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('e8d80af84902485fbc975672b4113239', '2a352069f4db478cb87d5c60dda38ed6', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('e8d80af84902485fbc975672b4113239', '981f77409efb430b8dbbb6ec1475e595', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('e8d80af84902485fbc975672b4113239', '0dba01654b0340d8981ba4922fef2489', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('e8d80af84902485fbc975672b4113239', 'dd93da4b764d41749ea324b5aae09927', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('1f3ac2a25d5648459a569bdc1f59bd79', '0fa959124dbf4385af9e64f259a4d4d6', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('1f3ac2a25d5648459a569bdc1f59bd79', 'fe5ec7281f6940398e297710e7f5f33a', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('1f3ac2a25d5648459a569bdc1f59bd79', '41c2c0abf80a4095aed64a506c1813ff', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('1f3ac2a25d5648459a569bdc1f59bd79', 'f87d7ff16f5547af82616434a97351f5', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('edc0422c012c4f50ba86ec79be78a070', '8dd707f55c1f444db458b2832b16be4c', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('edc0422c012c4f50ba86ec79be78a070', '2c358e08f1ce4254a1be6b44e2a2f6cf', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('edc0422c012c4f50ba86ec79be78a070', 'b820515899c844a496b8863891b1d3b3', '93b3a87410b942c8817b45b42ada2dee', 1),
  -- Gijón 400
  ('3f01bde018fd4ba28a3147ce35b734e7', '204fea48fc0145f5a70885376effdf0c', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('3f01bde018fd4ba28a3147ce35b734e7', '592c908a1b034ed9bb0c2e616dc15a33', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('3f01bde018fd4ba28a3147ce35b734e7', '4e9c9d85cac64e6ab10a6a3b73ed040c', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('7455a1b97be84052a3f90d34c73695d5', '476822dadc3e4c40841a5d1f8a26eee5', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('7455a1b97be84052a3f90d34c73695d5', '175ebf8b030f47dab6253c9798b05cfb', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('7455a1b97be84052a3f90d34c73695d5', '9aeb529eb67c4ee386daf1b6cc652670', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('b194a75d005841d7a1a8a09069a960a8', '10530aad36bd43bcb271ca2b9cc1339f', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('b194a75d005841d7a1a8a09069a960a8', 'd632b9df84a0471eb6ffd5c49d0733d4', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('b194a75d005841d7a1a8a09069a960a8', '2704c0643f984607995a7c1d002868e6', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('dab52f51d8224887be6790ded1a373fa', '9fc783880b8343dcbd9062eade599e38', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('de00fdcac8d34ec1b9c022fa75082252', '14816741a3574c3898969a29f61382ce', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('de00fdcac8d34ec1b9c022fa75082252', '4a51c3b1332e483db962ea814851d43e', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('de00fdcac8d34ec1b9c022fa75082252', '2d33e0835dfe44619ab6cb19998b19da', '93b3a87410b942c8817b45b42ada2dee', 1),
  -- Sevilla 400
  ('b725a7bf3ff54194b56b5f3e47e64ad2', '301c5bcbcd5e418c9f762dcda4db2c65', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('b725a7bf3ff54194b56b5f3e47e64ad2', '61850b9dee474a1fa2822b2e3074fabd', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('b725a7bf3ff54194b56b5f3e47e64ad2', '64ed69d3cbbf443f9a7a33a13a39dc41', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('1eb664a43c1c4cac9fa4ea7d5aaabb83', 'f58ce764de7c47c391dce069385bcec3', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('1eb664a43c1c4cac9fa4ea7d5aaabb83', 'ba6797bd7c5649f0ad0b575f38a49226', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('1eb664a43c1c4cac9fa4ea7d5aaabb83', 'ff1652a2d9e34e2f9420081105fb541c', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('0ce346ff163c4deeac726fdcc562c268', '16194f064dc042d6811a1b35f623470e', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('0ce346ff163c4deeac726fdcc562c268', '018bce1f634b49ae94cf8cc686e6c405', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('0ce346ff163c4deeac726fdcc562c268', '2431ccf6d8264333a9825cf539ed3cff', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('ee431dd8ae6147cd9cace9f61c8eced3', 'bbfd60d908f542e4932b89e1e1da4b69', '93b3a87410b942c8817b45b42ada2dee', 1),
  -- Barcelona 400
  ('5be5e3d4eafa4d238849eae454ebb383', '82562dbc68d44b50955683341b8576a5', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('5be5e3d4eafa4d238849eae454ebb383', '2fa5317387954a3ab6643652f47d29d3', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('5be5e3d4eafa4d238849eae454ebb383', '8c88d08d4ff144208be6a46822122fad', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('5be5e3d4eafa4d238849eae454ebb383', 'a062e006bb81439c9a3c8b4733c5a426', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('ddcd29302e254b548624c3904b6c596a', 'cb5f7e82e6564c68b79eee506bc6c6d6', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('ddcd29302e254b548624c3904b6c596a', '882507ee84284c03ad35981632ebe284', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('ddcd29302e254b548624c3904b6c596a', 'cd6cbd5e0ce74dda8ffb17d6183c6481', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('4a4fb92a83ae41329e2e5db9058e5a59', '03a9f58df60e4d9f8aa9cd6ac786aee8', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('4a4fb92a83ae41329e2e5db9058e5a59', '5bbeb19027874225af25cfba9d8df0ae', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('4a4fb92a83ae41329e2e5db9058e5a59', '814ccb57cbd94ce2b3854d61b66cab9a', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('4a4fb92a83ae41329e2e5db9058e5a59', 'ff1652a2d9e34e2f9420081105fb541c', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('3321457d06504b24a835c22ac359bc02', '84d1a846a6d1479aa303a3bd0a2528cb', '93b3a87410b942c8817b45b42ada2dee', 1);

-- add new bays
INSERT INTO `bays`
  (`id_bay`,`id_model`,`action`,`name`,`number`,`id_voltage_level`) VALUES
  -- Málaga 220
  ('7f10f6a5a0ea4eea894a8a13166defb5','93b3a87410b942c8817b45b42ada2dee',1,'Calle 1',1,'4c6f97d6e21a40aba03c62f8dd2d9979'),
  ('1fbcce88d8bd466a9ebb85e3c6f1a747','93b3a87410b942c8817b45b42ada2dee',1,'Calle 2',2,'4c6f97d6e21a40aba03c62f8dd2d9979'),
  ('90dbec99509349708da689d770cf9ecd','93b3a87410b942c8817b45b42ada2dee',1,'Calle 3',3,'4c6f97d6e21a40aba03c62f8dd2d9979'),
  -- Málaga 400
  ('4915d1e0167b4f62a0bd83bb0dab3714','93b3a87410b942c8817b45b42ada2dee',1,'Calle 1',1,'1a87cf8e36194ab7a536d19bc56b770a'),
  ('6ff3eb633d374430848ee4d3964f8512','93b3a87410b942c8817b45b42ada2dee',1,'Calle 2',2,'1a87cf8e36194ab7a536d19bc56b770a'),
  ('b96db4eb43cb425597dc76820eb59b12','93b3a87410b942c8817b45b42ada2dee',1,'Calle 3',3,'1a87cf8e36194ab7a536d19bc56b770a'),
  ('030c691328cf49e3a27516f17e181b84','93b3a87410b942c8817b45b42ada2dee',1,'Calle 4',4,'1a87cf8e36194ab7a536d19bc56b770a'),
  ('1bf9846b1fca48b2a66ade9d67298c10','93b3a87410b942c8817b45b42ada2dee',1,'Calle 5',5,'1a87cf8e36194ab7a536d19bc56b770a'),
  -- Gijón 400
  ('b1715b80e0e34d7d9874e331a8e74874','93b3a87410b942c8817b45b42ada2dee',1,'Calle 1',1,'fa633d70cf2b4c299a852a627051673c'),
  ('c14cffc2467a4d2791afca7fc573974c','93b3a87410b942c8817b45b42ada2dee',1,'Calle 2',2,'fa633d70cf2b4c299a852a627051673c'),
  ('addb398351504baa9c9eec2d0e9d13b6','93b3a87410b942c8817b45b42ada2dee',1,'Calle 3',3,'fa633d70cf2b4c299a852a627051673c'),
  ('69b67233373949efabfcc93dfe29ac2e','93b3a87410b942c8817b45b42ada2dee',1,'Calle 4',4,'fa633d70cf2b4c299a852a627051673c'),
  -- Sevilla 400
  ('1ab9b4dbd05c494a9f2606ad49385197','93b3a87410b942c8817b45b42ada2dee',1,'Calle 1',1,'48ce7abce09c4568bc28d86f7b20c486'),
  ('5c551a75b0ef417ebef99d83ebaae295','93b3a87410b942c8817b45b42ada2dee',1,'Calle 2',2,'48ce7abce09c4568bc28d86f7b20c486'),
  ('154891989f41491d9179ed4bc8021850','93b3a87410b942c8817b45b42ada2dee',1,'Calle 3',3,'48ce7abce09c4568bc28d86f7b20c486'),
  ('7e976b5b05e8432eb7aae7dbd44d614d','93b3a87410b942c8817b45b42ada2dee',1,'Calle 4',4,'48ce7abce09c4568bc28d86f7b20c486'),
  ('0aa120b1117e4c2da29d9c7cf3800b5a','93b3a87410b942c8817b45b42ada2dee',1,'Calle 5',5,'48ce7abce09c4568bc28d86f7b20c486'),
  -- Barcelona 400
  ('0bd8af9c4e394c0d9164c1aa33048561','93b3a87410b942c8817b45b42ada2dee',1,'Calle 1',1,'271f651a18754726b5cf54b6b34a03b6'),
  ('ba36b569c3e942729fc8443747f8ba9f','93b3a87410b942c8817b45b42ada2dee',1,'Calle 2',2,'271f651a18754726b5cf54b6b34a03b6');

-- bays and positions relations
INSERT INTO `bays_positions`
  (`id_bay`, `id_position`, `id_model`, `action`) VALUES
  -- Málaga 220
  ('7f10f6a5a0ea4eea894a8a13166defb5', 'd07669a7d80a448ea17674d44d746396', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('1fbcce88d8bd466a9ebb85e3c6f1a747', 'e0dfec4f193a4d6d91247f63bf0ae159', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('90dbec99509349708da689d770cf9ecd', '97a5960d2f454b1a84a27f8f35d4d257', '93b3a87410b942c8817b45b42ada2dee', 1),
  -- Málaga 400
  ('4915d1e0167b4f62a0bd83bb0dab3714', '84680f1f00794ae994ece98f6e9b0e6d', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('6ff3eb633d374430848ee4d3964f8512', 'a5308a3ebfaa4fabbc75bed6a577461f', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('b96db4eb43cb425597dc76820eb59b12', 'e8d80af84902485fbc975672b4113239', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('030c691328cf49e3a27516f17e181b84', '1f3ac2a25d5648459a569bdc1f59bd79', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('1bf9846b1fca48b2a66ade9d67298c10', 'edc0422c012c4f50ba86ec79be78a070', '93b3a87410b942c8817b45b42ada2dee', 1),
  -- Gijón 400
  ('b1715b80e0e34d7d9874e331a8e74874', '3f01bde018fd4ba28a3147ce35b734e7', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('c14cffc2467a4d2791afca7fc573974c', '7455a1b97be84052a3f90d34c73695d5', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('addb398351504baa9c9eec2d0e9d13b6', 'b194a75d005841d7a1a8a09069a960a8', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('69b67233373949efabfcc93dfe29ac2e', 'dab52f51d8224887be6790ded1a373fa', '93b3a87410b942c8817b45b42ada2dee', 1),
  -- Sevilla 400
  ('1ab9b4dbd05c494a9f2606ad49385197', 'de00fdcac8d34ec1b9c022fa75082252', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('5c551a75b0ef417ebef99d83ebaae295', 'b725a7bf3ff54194b56b5f3e47e64ad2', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('154891989f41491d9179ed4bc8021850', '1eb664a43c1c4cac9fa4ea7d5aaabb83', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('7e976b5b05e8432eb7aae7dbd44d614d', '0ce346ff163c4deeac726fdcc562c268', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('0aa120b1117e4c2da29d9c7cf3800b5a', 'ee431dd8ae6147cd9cace9f61c8eced3', '93b3a87410b942c8817b45b42ada2dee', 1),
  -- Barcelona 400
  ('0bd8af9c4e394c0d9164c1aa33048561', '5be5e3d4eafa4d238849eae454ebb383', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('0bd8af9c4e394c0d9164c1aa33048561', 'ddcd29302e254b548624c3904b6c596a', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('0bd8af9c4e394c0d9164c1aa33048561', '4a4fb92a83ae41329e2e5db9058e5a59', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('ba36b569c3e942729fc8443747f8ba9f', '3321457d06504b24a835c22ac359bc02', '93b3a87410b942c8817b45b42ada2dee', 1);



--
-- Add two shunts to the model
--

-- add new connectivity nodes
INSERT INTO `connectivity_nodes`
  (`id_connectivity_node`, `id_model`, `action`, `name`, `x`, `y`) VALUES
  ('415aec04406c40e68b6228570c79913c','93b3a87410b942c8817b45b42ada2dee',1,'c87',0,0),
  ('1fef0d39c68e439d9ca5e9add63ef3df','93b3a87410b942c8817b45b42ada2dee',1,'c88',0,0),
  ('90badf83e67642f9b75cc916b2025166','93b3a87410b942c8817b45b42ada2dee',1,'c89',0,0),
  ('a936939693be4d8ca7213914fab7cb8f','93b3a87410b942c8817b45b42ada2dee',1,'c90',0,0),
  ('f558553e751a4da3b9404dcf02a7403a','93b3a87410b942c8817b45b42ada2dee',1,'c91',0,0),
  ('8bf0f8ba30ee46ffb3f85879feeedf6d','93b3a87410b942c8817b45b42ada2dee',1,'c92',0,0);

-- declare connectivity nodes in voltage_level
INSERT INTO `connectivity_nodes_voltage_levels`
  (`id_connectivity_node`, `id_voltage_level`, `id_model`, `action`) VALUES
  ('415aec04406c40e68b6228570c79913c', '271f651a18754726b5cf54b6b34a03b6', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('1fef0d39c68e439d9ca5e9add63ef3df', '271f651a18754726b5cf54b6b34a03b6', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('90badf83e67642f9b75cc916b2025166', '271f651a18754726b5cf54b6b34a03b6', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('a936939693be4d8ca7213914fab7cb8f', '48ce7abce09c4568bc28d86f7b20c486', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('f558553e751a4da3b9404dcf02a7403a', '48ce7abce09c4568bc28d86f7b20c486', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('8bf0f8ba30ee46ffb3f85879feeedf6d', '48ce7abce09c4568bc28d86f7b20c486', '93b3a87410b942c8817b45b42ada2dee', 1);

-- connect connectivity_node with buses
INSERT INTO `buses_connectivity_nodes`
  (`id_bus`, `id_connectivity_node`, `id_model`, `action`) VALUES
  ('1ddcf194ac1f48999ce0e5b58ed0e2f0', '415aec04406c40e68b6228570c79913c', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('0cd72bbb1a66449891630a0ad447b846', 'a936939693be4d8ca7213914fab7cb8f', '93b3a87410b942c8817b45b42ada2dee', 1);

-- Add new sections
INSERT INTO `sections`
  (`id_section`, `id_model`, `action`, `id_connectivity_node_1`, `id_connectivity_node_2`, `active`, `name`, `rating`, `id_rating_profile`, `contingency_factor1`, `contingency_factor2`, `contingency_factor3`, `online_date`, `offline_date`, `mttf`, `mttr`, `secondary_id`, `sequential`) VALUES
  ('0a52f5016b954790af89bf158d5f05bd', '93b3a87410b942c8817b45b42ada2dee', 1, '415aec04406c40e68b6228570c79913c', '1fef0d39c68e439d9ca5e9add63ef3df', 1, 's44', 9999,NULL,1,1,1,NULL,NULL,NULL,NULL,NULL,1),
  ('55641ece59ab4a08879d9cda4fb322df', '93b3a87410b942c8817b45b42ada2dee', 1, '1fef0d39c68e439d9ca5e9add63ef3df', '90badf83e67642f9b75cc916b2025166', 1, 'i23', 9999,NULL,1,1,1,NULL,NULL,NULL,NULL,NULL,1),
  ('d796e2eb998842ed9a9f42106ea1981a', '93b3a87410b942c8817b45b42ada2dee', 1, 'a936939693be4d8ca7213914fab7cb8f', 'f558553e751a4da3b9404dcf02a7403a', 1, 's45', 9999,NULL,1,1,1,NULL,NULL,NULL,NULL,NULL,1),
  ('0d387ca872844d41a36a84838f370442', '93b3a87410b942c8817b45b42ada2dee', 1, 'f558553e751a4da3b9404dcf02a7403a', '8bf0f8ba30ee46ffb3f85879feeedf6d', 1, 'i24', 9999,NULL,1,1,1,NULL,NULL,NULL,NULL,NULL,1);

-- declare switch types
INSERT INTO `switches`
  (`id_section`, `id_model`, `action`, `normal_state`, `switch_type`) VALUES
  ('0a52f5016b954790af89bf158d5f05bd', '93b3a87410b942c8817b45b42ada2dee', 1, 1, 0),
  ('55641ece59ab4a08879d9cda4fb322df', '93b3a87410b942c8817b45b42ada2dee', 1, 1, 1),
  ('d796e2eb998842ed9a9f42106ea1981a', '93b3a87410b942c8817b45b42ada2dee', 1, 1, 0),
  ('0d387ca872844d41a36a84838f370442', '93b3a87410b942c8817b45b42ada2dee', 1, 1, 1);

-- add new shunt devices
INSERT INTO `fixed_shunts`
  (`id_shunt`, `id_model`, `action`, `id_connectivity_node`, `name`, `secondary_id`, `active`, `g`, `b`, `g1`, `b1`, `rating`, `sequential`) VALUES
  ('ffd0adc64df64d8b86f5677d44faea37', '93b3a87410b942c8817b45b42ada2dee', 1, '90badf83e67642f9b75cc916b2025166', 'R1', NULL, 1, 0, -150, 0, 0, 150, 0),
  ('b5f19cc6bc884ab09e06df981d32b2ac', '93b3a87410b942c8817b45b42ada2dee', 1, '8bf0f8ba30ee46ffb3f85879feeedf6d', 'C1', NULL, 1, 0,  100, 0, 0, 100, 0);

-- add new positions
INSERT INTO `positions`
  (`id_position`, `id_model`, `action`, `id_position_type`, `online_date`, `offline_date`) VALUES
  ('ac45116108f74877bf9185f8eb3a91ef', '93b3a87410b942c8817b45b42ada2dee', 1, 0, '2021-08-10', NULL),
  ('2269c0abde0f4d7dbfb40c7e277fb779', '93b3a87410b942c8817b45b42ada2dee', 1, 0, '2021-08-10', NULL);

-- add new bays
INSERT INTO `bays`
  (`id_bay`,`id_model`,`action`,`name`,`number`,`id_voltage_level`) VALUES
  ('efd5f2d42d9a43fa89980de6e5e485b0','93b3a87410b942c8817b45b42ada2dee', 1,'Calle 6',6,'48ce7abce09c4568bc28d86f7b20c486'),
  ('100d8e94535d4b00964f6292ee4c4579','93b3a87410b942c8817b45b42ada2dee', 1,'Calle 3',3,'271f651a18754726b5cf54b6b34a03b6');

-- add bays and positions relations
INSERT INTO `bays_positions`
  (`id_bay`, `id_position`, `id_model`, `action`) VALUES
  ('efd5f2d42d9a43fa89980de6e5e485b0', 'ac45116108f74877bf9185f8eb3a91ef', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('100d8e94535d4b00964f6292ee4c4579', '2269c0abde0f4d7dbfb40c7e277fb779', '93b3a87410b942c8817b45b42ada2dee', 1);

-- add position and buses relations
INSERT INTO `positions_buses`
  (`id_position`, `id_bus`, `id_model`, `action`) VALUES
  ('ac45116108f74877bf9185f8eb3a91ef', '0cd72bbb1a66449891630a0ad447b846', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('2269c0abde0f4d7dbfb40c7e277fb779', '1ddcf194ac1f48999ce0e5b58ed0e2f0', '93b3a87410b942c8817b45b42ada2dee', 1);

-- add positions and section relations
INSERT INTO `positions_sections`
  (`id_position`, `id_section`, `id_model`, `action`) VALUES
  ('ac45116108f74877bf9185f8eb3a91ef', 'd796e2eb998842ed9a9f42106ea1981a', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('ac45116108f74877bf9185f8eb3a91ef', '0d387ca872844d41a36a84838f370442', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('2269c0abde0f4d7dbfb40c7e277fb779', '0a52f5016b954790af89bf158d5f05bd', '93b3a87410b942c8817b45b42ada2dee', 1),
  ('2269c0abde0f4d7dbfb40c7e277fb779', '55641ece59ab4a08879d9cda4fb322df', '93b3a87410b942c8817b45b42ada2dee', 1);




-- ----
--  NEW bypass
-- ----

-- Add new sections
INSERT INTO `sections`
  (`id_section`, `id_model`, `action`, `id_connectivity_node_1`, `id_connectivity_node_2`, `active`, `name`, `rating`, `id_rating_profile`, `contingency_factor1`, `contingency_factor2`, `contingency_factor3`, `online_date`, `offline_date`, `mttf`, `mttr`, `secondary_id`, `sequential`) VALUES
  ('413cade00ef14ec38879ec202704f10b', '93b3a87410b942c8817b45b42ada2dee', 1, '9b971863578447bcbf28dcde17f37c28', '13e11b1a2b014126b5754b8efc909130', 1, 's46', 9999,NULL,1,1,1,NULL,NULL,NULL,NULL,NULL,1);

-- declare switch types
INSERT INTO `switches`
  (`id_section`, `id_model`, `action`, `normal_state`, `switch_type`) VALUES
  ('413cade00ef14ec38879ec202704f10b', '93b3a87410b942c8817b45b42ada2dee', 1, 1, 0);



-- ----
--  NEW Madrid substation
-- ----


-- New model
INSERT INTO `models`
  (`id_model`, `name`, `valid_date`, `creation_date`, `created_by`, `comments`) VALUES
  ('1025036627f24b94a8dad3d4cc326a22', 'Red E', '2026-01-01','2021-08-24','admin', 'Nuevo parque Madrid: Configuración mixta con bypass');

-- Assign model parent
INSERT INTO `models_models`
  (`id_model_parent`, `id_model_child`) VALUES
  ('93b3a87410b942c8817b45b42ada2dee','1025036627f24b94a8dad3d4cc326a22');


-- New substations
INSERT INTO `substations`
  (`id_substation`, `id_model`, `action`, `id_zone`, `id_province`, `name`, `latitude`, `longitude`, `online_date`, `offline_date`, `id_bdi`, `comment`) VALUES
  -- Madrid substation
  ('0c1837e8ed174c838f61e6ae8e991c5f', '1025036627f24b94a8dad3d4cc326a22', 1, 'ebfb938eb6c843b2929edbff4c563f28', '37e7196be5d342c9b11e56725829b9c0', 'Madrid', '40.503660', '-3.248444', '2021-08-24', Null, Null, 'El mirador de Madrid');

-- New voltage level
INSERT INTO `voltage_levels`
  (`id_voltage_level`, `id_model`, `action`, `id_substation`, `id_voltage_level_type`, `id_voltage_level_configuration`, `voltage`, `online_date`, `offline_date`, `id_bdi`, `comment`) VALUES
  ('1b1cbdb8231942538363075623ff70ff', '1025036627f24b94a8dad3d4cc326a22', 1, '0c1837e8ed174c838f61e6ae8e991c5f', 'caa4c2041b594927862ad16765deb9e8', '50bdd39c73c644c386c89db99fbe67b4', 400, '2021-08-24', Null, Null, 'Parque 6, 400 kV');

-- New bus bars
INSERT INTO `buses`
  (`id_bus`, `id_model`, `action`, `name`, `x`, `y`, `rotation`, `is_dc`, `secondary_id`, `sequential`, `id_bdi`) VALUES
  -- Madrid 400
  ('73b3b73e08c64844b6d9b5c0cf4b1490', '1025036627f24b94a8dad3d4cc326a22', 1, 'b11', 0, 0, 0, 0, Null, 1, Null),
  ('d9b147e417e543848679ecec75b5d57e', '1025036627f24b94a8dad3d4cc326a22', 1, 'b12', 0, 0, 0, 0, Null, 1, Null),
  ('0e16a47898234bb6b7c5933091bcd378', '1025036627f24b94a8dad3d4cc326a22', 1, 'bt1', 0, 0, 0, 0, Null, 1, Null);


--  New positions
INSERT INTO `positions`
  (`id_position`, `id_model`, `action`, `id_position_type`, `online_date`, `offline_date`) VALUES
  -- Barcelona 400
  ('98e3cb1d9aea44ccb3b5fca3189a05b8', '1025036627f24b94a8dad3d4cc326a22', 1, 2, '2021-08-24', NULL),
  -- Málaga 400
  ('54da05f25f18480a9526776445d66ea7', '1025036627f24b94a8dad3d4cc326a22', 1, 2, '2021-08-24', NULL),
  -- Sevilla 400
  ('e1c13972fb4544cbab6e30ea84623a1b', '1025036627f24b94a8dad3d4cc326a22', 1, 2, '2021-08-24', NULL),
  -- Madrid 400
  ('739d96b8ba20458b9e0dea8f57580b27', '1025036627f24b94a8dad3d4cc326a22', 1, 2, '2021-08-24', NULL),
  ('50f2f7e0a8ce4802b1fe9eb51c232743', '1025036627f24b94a8dad3d4cc326a22', 1, 2, '2021-08-24', NULL),
  ('ad5bdbb73c0445da8992d17640941130', '1025036627f24b94a8dad3d4cc326a22', 1, 2, '2021-08-24', NULL),
  ('423f6f62a4bf4af7b4aa29864b315c4d', '1025036627f24b94a8dad3d4cc326a22', 1, 2, '2021-08-24', NULL);


-- New bays
INSERT INTO `bays`
  (`id_bay`,`id_model`,`action`,`name`,`number`,`id_voltage_level`) VALUES
  -- Barcelona 400
  ('844764097c5d47f084dd722194d5d782','1025036627f24b94a8dad3d4cc326a22',1,'Calle 8',1,'4c6f97d6e21a40aba03c62f8dd2d9979'),
  -- Sevilla 400
  ('8b8c03ea412e41679c5d8b5210343aac','1025036627f24b94a8dad3d4cc326a22',1,'Calle 7',1,'4c6f97d6e21a40aba03c62f8dd2d9979'),
  -- Malaga 400
  ('e897d805e3934d72ad21bb9b94688106','1025036627f24b94a8dad3d4cc326a22',1,'Calle 9',1,'4c6f97d6e21a40aba03c62f8dd2d9979'),
  -- Madrid 400,
  ('917256a0ffba4f02941e9c377d0b364d','1025036627f24b94a8dad3d4cc326a22',1,'Calle 1',1,'4c6f97d6e21a40aba03c62f8dd2d9979'),
  ('6495f9cd4f3841dbb56b2e394a682137','1025036627f24b94a8dad3d4cc326a22',1,'Calle 2',1,'4c6f97d6e21a40aba03c62f8dd2d9979'),
  ('df2c645ae84d4f9686580829e93b9f58','1025036627f24b94a8dad3d4cc326a22',1,'Calle 2',1,'4c6f97d6e21a40aba03c62f8dd2d9979'),
  ('ed106b9241d84c749a31617b6d8c8d3c','1025036627f24b94a8dad3d4cc326a22',1,'Calle 3',1,'4c6f97d6e21a40aba03c62f8dd2d9979');


-- declare bay/position relation
INSERT INTO `bays_positions`
  (`id_bay`, `id_position`, `id_model`, `action`) VALUES
  -- Málaga 400
  ('e897d805e3934d72ad21bb9b94688106', '54da05f25f18480a9526776445d66ea7', '1025036627f24b94a8dad3d4cc326a22', 1),
  -- Barcelona 400
  ('844764097c5d47f084dd722194d5d782', '98e3cb1d9aea44ccb3b5fca3189a05b8', '1025036627f24b94a8dad3d4cc326a22', 1),
  -- Sevilla 400
  ('8b8c03ea412e41679c5d8b5210343aac', 'e1c13972fb4544cbab6e30ea84623a1b', '1025036627f24b94a8dad3d4cc326a22', 1),
  -- Madrid 400
  ('917256a0ffba4f02941e9c377d0b364d', '739d96b8ba20458b9e0dea8f57580b27', '1025036627f24b94a8dad3d4cc326a22', 1),
  ('6495f9cd4f3841dbb56b2e394a682137', '50f2f7e0a8ce4802b1fe9eb51c232743', '1025036627f24b94a8dad3d4cc326a22', 1),
  ('df2c645ae84d4f9686580829e93b9f58', 'ad5bdbb73c0445da8992d17640941130', '1025036627f24b94a8dad3d4cc326a22', 1),
  ('ed106b9241d84c749a31617b6d8c8d3c', '423f6f62a4bf4af7b4aa29864b315c4d', '1025036627f24b94a8dad3d4cc326a22', 1);


-- Add new connectivity nodes
INSERT INTO `connectivity_nodes`
  (`id_connectivity_node`, `id_model`, `action`, `name`, `x`, `y`) VALUES
  -- Barcelona 400
  ('f4dd383721fb480da953668ce4d82a73', '1025036627f24b94a8dad3d4cc326a22', 1, 'c93', 0, 0),
  ('dedab31e41f0440ea976a2a80e7a1a55', '1025036627f24b94a8dad3d4cc326a22', 1, 'c94', 0, 0),
  ('3c467667469e4e74bc959347f276ec88', '1025036627f24b94a8dad3d4cc326a22', 1, 'c95', 0, 0),
  ('6f7f0fa6818b42b7b49cfc941d6e28bc', '1025036627f24b94a8dad3d4cc326a22', 1, 'c97', 0, 0),
  ('3c4fb7f1c51c4fe89b017a7b6f026015', '1025036627f24b94a8dad3d4cc326a22', 1, 'c98', 0, 0),
  -- Málaga 400
  ('c9f001ebc5fd49f29a266aeaabf57ea5', '1025036627f24b94a8dad3d4cc326a22', 1, 'c100', 0, 0),
  ('ec67f04e413e4cee86946e46698fcda2', '1025036627f24b94a8dad3d4cc326a22', 1, 'c101', 0, 0),
  ('db4456481faa433aafc5e1964e7859ec', '1025036627f24b94a8dad3d4cc326a22', 1, 'c102', 0, 0),
  ('fe32b465ec544c6fbd1529be81a0f0be', '1025036627f24b94a8dad3d4cc326a22', 1, 'c103', 0, 0),
  ('4012c3145db5486d839d4a9a95bd4245', '1025036627f24b94a8dad3d4cc326a22', 1, 'c104', 0, 0),
  -- Sevilla 400
  ('da551acfdee04496b9b36158fa1d8e8e', '1025036627f24b94a8dad3d4cc326a22', 1, 'c105', 0, 0),
  ('f713781117ae48d7b28160cbeaf0543d', '1025036627f24b94a8dad3d4cc326a22', 1, 'c106', 0, 0),
  ('6587914b5ebe45c682f4fa4f9e7042fa', '1025036627f24b94a8dad3d4cc326a22', 1, 'c107', 0, 0),
  ('24fa95168b2742a4a10249f5d53bb435', '1025036627f24b94a8dad3d4cc326a22', 1, 'c108', 0, 0),
  ('69115c21b9e14c0fb3772e39063d62b9', '1025036627f24b94a8dad3d4cc326a22', 1, 'c109', 0, 0),
  -- Madrid 400
  ('223a77faed704747ab7e2afa2987aa4e', '1025036627f24b94a8dad3d4cc326a22', 1, 'c110', 0, 0),
  ('5e4c1248e9964fdc9509f14ae1265ec3', '1025036627f24b94a8dad3d4cc326a22', 1, 'c111', 0, 0),
  ('a925657641a5453988eeb3e07efe69c5', '1025036627f24b94a8dad3d4cc326a22', 1, 'c112', 0, 0),
  ('41ac013626db473ebbc3e39b925ac33c', '1025036627f24b94a8dad3d4cc326a22', 1, 'c113', 0, 0),
  ('3d1457f1e9214ac48ce1ed1dde2460a6', '1025036627f24b94a8dad3d4cc326a22', 1, 'c114', 0, 0),
  ('86c638a851e34e2f8fc1a8e91beb72ba', '1025036627f24b94a8dad3d4cc326a22', 1, 'c115', 0, 0),
  ('d9f5fc7430254c4ba09d89e98458f024', '1025036627f24b94a8dad3d4cc326a22', 1, 'c116', 0, 0),
  ('2d11280ee3734a0085124b9f3a64c662', '1025036627f24b94a8dad3d4cc326a22', 1, 'c117', 0, 0),
  ('ae6421c1595a4f1ea8bd3cdf419dcb9a', '1025036627f24b94a8dad3d4cc326a22', 1, 'c118', 0, 0),
  ('f90ae0f584ed445c9f828b5851bfb147', '1025036627f24b94a8dad3d4cc326a22', 1, 'c119', 0, 0),
  ('8df224dce7be460fbc950704175573c8', '1025036627f24b94a8dad3d4cc326a22', 1, 'c120', 0, 0),
  ('1f484c146fff454cb14e7afc373104d9', '1025036627f24b94a8dad3d4cc326a22', 1, 'c121', 0, 0),
  ('ec7edbc828874842b9aa706392c5b7b9', '1025036627f24b94a8dad3d4cc326a22', 1, 'c122', 0, 0),
  ('d780b4b262c04bec837d478215d22aff', '1025036627f24b94a8dad3d4cc326a22', 1, 'c123', 0, 0),
  ('643489dfa6ec44f786c660dc409aee6b', '1025036627f24b94a8dad3d4cc326a22', 1, 'c124', 0, 0),
  ('7940c0a6eca64961b3c15667b2d2627a', '1025036627f24b94a8dad3d4cc326a22', 1, 'c125', 0, 0),
  ('c4ad2cdc7f4540ffbdbe458fb1c670c1', '1025036627f24b94a8dad3d4cc326a22', 1, 'c126', 0, 0),
  ('5aa79336b548418f8496f4710ffe6867', '1025036627f24b94a8dad3d4cc326a22', 1, 'c127', 0, 0),
  ('bf671c2be31840c7a8cbcb2897bc2ef8', '1025036627f24b94a8dad3d4cc326a22', 1, 'c128', 0, 0),
  ('c6c3749af2474b45b32b5920dfd13beb', '1025036627f24b94a8dad3d4cc326a22', 1, 'c129', 0, 0),
  ('61f374a131c345738a3446cd5a4cf37e', '1025036627f24b94a8dad3d4cc326a22', 1, 'c130', 0, 0),
  ('b2edbc833a104cc3af97307e9ed33158', '1025036627f24b94a8dad3d4cc326a22', 1, 'c131', 0, 0),
  ('049a5f4ce33242649fa3690033296c86', '1025036627f24b94a8dad3d4cc326a22', 1, 'c132', 0, 0),
  ('3cdee45202ef4791a420671cddf9add4', '1025036627f24b94a8dad3d4cc326a22', 1, 'c133', 0, 0),
  ('aff3472e362d4c6d8cf5263d41f6c259', '1025036627f24b94a8dad3d4cc326a22', 1, 'c134', 0, 0),
  ('9c9101e8d89b4e0b8bb2e1b09cf8c648', '1025036627f24b94a8dad3d4cc326a22', 1, 'c135', 0, 0),
  ('ac837501f9eb4350845f829335f34b88', '1025036627f24b94a8dad3d4cc326a22', 1, 'c136', 0, 0),
  ('e71bdad0c31345589675f8e9ad052565', '1025036627f24b94a8dad3d4cc326a22', 1, 'c137', 0, 0),
  ('5b681bd805814d24833abe153eed1e31', '1025036627f24b94a8dad3d4cc326a22', 1, 'c138', 0, 0);


-- declare connectivity nodes in voltage_level
INSERT INTO `connectivity_nodes_voltage_levels`
  (`id_connectivity_node`, `id_voltage_level`, `id_model`, `action`) VALUES
  -- Málaga 400
  ('c9f001ebc5fd49f29a266aeaabf57ea5', '4c6f97d6e21a40aba03c62f8dd2d9979', '1025036627f24b94a8dad3d4cc326a22', 1),
  ('ec67f04e413e4cee86946e46698fcda2', '4c6f97d6e21a40aba03c62f8dd2d9979', '1025036627f24b94a8dad3d4cc326a22', 1),
  ('db4456481faa433aafc5e1964e7859ec', '4c6f97d6e21a40aba03c62f8dd2d9979', '1025036627f24b94a8dad3d4cc326a22', 1),
  ('fe32b465ec544c6fbd1529be81a0f0be', '4c6f97d6e21a40aba03c62f8dd2d9979', '1025036627f24b94a8dad3d4cc326a22', 1),
  ('4012c3145db5486d839d4a9a95bd4245', '4c6f97d6e21a40aba03c62f8dd2d9979', '1025036627f24b94a8dad3d4cc326a22', 1),

  -- Barcelona 400
  ('f4dd383721fb480da953668ce4d82a73', '271f651a18754726b5cf54b6b34a03b6', '1025036627f24b94a8dad3d4cc326a22', 1),
  ('dedab31e41f0440ea976a2a80e7a1a55', '271f651a18754726b5cf54b6b34a03b6', '1025036627f24b94a8dad3d4cc326a22', 1),
  ('3c467667469e4e74bc959347f276ec88', '271f651a18754726b5cf54b6b34a03b6', '1025036627f24b94a8dad3d4cc326a22', 1),
  ('6f7f0fa6818b42b7b49cfc941d6e28bc', '271f651a18754726b5cf54b6b34a03b6', '1025036627f24b94a8dad3d4cc326a22', 1),
  ('3c4fb7f1c51c4fe89b017a7b6f026015', '271f651a18754726b5cf54b6b34a03b6', '1025036627f24b94a8dad3d4cc326a22', 1),

  -- Sevilla 400
  ('da551acfdee04496b9b36158fa1d8e8e', '48ce7abce09c4568bc28d86f7b20c486', '1025036627f24b94a8dad3d4cc326a22', 1),
  ('f713781117ae48d7b28160cbeaf0543d', '48ce7abce09c4568bc28d86f7b20c486', '1025036627f24b94a8dad3d4cc326a22', 1),
  ('6587914b5ebe45c682f4fa4f9e7042fa', '48ce7abce09c4568bc28d86f7b20c486', '1025036627f24b94a8dad3d4cc326a22', 1),
  ('24fa95168b2742a4a10249f5d53bb435', '48ce7abce09c4568bc28d86f7b20c486', '1025036627f24b94a8dad3d4cc326a22', 1),
  ('69115c21b9e14c0fb3772e39063d62b9', '48ce7abce09c4568bc28d86f7b20c486', '1025036627f24b94a8dad3d4cc326a22', 1),

  -- Madrid 400
  ('223a77faed704747ab7e2afa2987aa4e', '1b1cbdb8231942538363075623ff70ff', '1025036627f24b94a8dad3d4cc326a22', 1),
  ('5e4c1248e9964fdc9509f14ae1265ec3', '1b1cbdb8231942538363075623ff70ff', '1025036627f24b94a8dad3d4cc326a22', 1),
  ('a925657641a5453988eeb3e07efe69c5', '1b1cbdb8231942538363075623ff70ff', '1025036627f24b94a8dad3d4cc326a22', 1),
  ('41ac013626db473ebbc3e39b925ac33c', '1b1cbdb8231942538363075623ff70ff', '1025036627f24b94a8dad3d4cc326a22', 1),
  ('3d1457f1e9214ac48ce1ed1dde2460a6', '1b1cbdb8231942538363075623ff70ff', '1025036627f24b94a8dad3d4cc326a22', 1),
  ('86c638a851e34e2f8fc1a8e91beb72ba', '1b1cbdb8231942538363075623ff70ff', '1025036627f24b94a8dad3d4cc326a22', 1),
  ('d9f5fc7430254c4ba09d89e98458f024', '1b1cbdb8231942538363075623ff70ff', '1025036627f24b94a8dad3d4cc326a22', 1),
  ('2d11280ee3734a0085124b9f3a64c662', '1b1cbdb8231942538363075623ff70ff', '1025036627f24b94a8dad3d4cc326a22', 1),
  ('ae6421c1595a4f1ea8bd3cdf419dcb9a', '1b1cbdb8231942538363075623ff70ff', '1025036627f24b94a8dad3d4cc326a22', 1),
  ('f90ae0f584ed445c9f828b5851bfb147', '1b1cbdb8231942538363075623ff70ff', '1025036627f24b94a8dad3d4cc326a22', 1),
  ('8df224dce7be460fbc950704175573c8', '1b1cbdb8231942538363075623ff70ff', '1025036627f24b94a8dad3d4cc326a22', 1),
  ('1f484c146fff454cb14e7afc373104d9', '1b1cbdb8231942538363075623ff70ff', '1025036627f24b94a8dad3d4cc326a22', 1),
  ('ec7edbc828874842b9aa706392c5b7b9', '1b1cbdb8231942538363075623ff70ff', '1025036627f24b94a8dad3d4cc326a22', 1),
  ('d780b4b262c04bec837d478215d22aff', '1b1cbdb8231942538363075623ff70ff', '1025036627f24b94a8dad3d4cc326a22', 1),
  ('643489dfa6ec44f786c660dc409aee6b', '1b1cbdb8231942538363075623ff70ff', '1025036627f24b94a8dad3d4cc326a22', 1),
  ('7940c0a6eca64961b3c15667b2d2627a', '1b1cbdb8231942538363075623ff70ff', '1025036627f24b94a8dad3d4cc326a22', 1),
  ('c4ad2cdc7f4540ffbdbe458fb1c670c1', '1b1cbdb8231942538363075623ff70ff', '1025036627f24b94a8dad3d4cc326a22', 1),
  ('5aa79336b548418f8496f4710ffe6867', '1b1cbdb8231942538363075623ff70ff', '1025036627f24b94a8dad3d4cc326a22', 1),
  ('bf671c2be31840c7a8cbcb2897bc2ef8', '1b1cbdb8231942538363075623ff70ff', '1025036627f24b94a8dad3d4cc326a22', 1),
  ('c6c3749af2474b45b32b5920dfd13beb', '1b1cbdb8231942538363075623ff70ff', '1025036627f24b94a8dad3d4cc326a22', 1),
  ('61f374a131c345738a3446cd5a4cf37e', '1b1cbdb8231942538363075623ff70ff', '1025036627f24b94a8dad3d4cc326a22', 1),
  ('b2edbc833a104cc3af97307e9ed33158', '1b1cbdb8231942538363075623ff70ff', '1025036627f24b94a8dad3d4cc326a22', 1),
  ('049a5f4ce33242649fa3690033296c86', '1b1cbdb8231942538363075623ff70ff', '1025036627f24b94a8dad3d4cc326a22', 1),
  ('3cdee45202ef4791a420671cddf9add4', '1b1cbdb8231942538363075623ff70ff', '1025036627f24b94a8dad3d4cc326a22', 1),
  ('aff3472e362d4c6d8cf5263d41f6c259', '1b1cbdb8231942538363075623ff70ff', '1025036627f24b94a8dad3d4cc326a22', 1),
  ('9c9101e8d89b4e0b8bb2e1b09cf8c648', '1b1cbdb8231942538363075623ff70ff', '1025036627f24b94a8dad3d4cc326a22', 1),
  ('ac837501f9eb4350845f829335f34b88', '1b1cbdb8231942538363075623ff70ff', '1025036627f24b94a8dad3d4cc326a22', 1),
  ('e71bdad0c31345589675f8e9ad052565', '1b1cbdb8231942538363075623ff70ff', '1025036627f24b94a8dad3d4cc326a22', 1),
  ('5b681bd805814d24833abe153eed1e31', '1b1cbdb8231942538363075623ff70ff', '1025036627f24b94a8dad3d4cc326a22', 1);

-- declare witch connectiviy nodes are connected to bus bars
INSERT INTO `buses_connectivity_nodes`
  (`id_bus`, `id_connectivity_node`, `id_model`, `action`) VALUES
  -- Málaga 400
  ('d13a5876e22749e3acb5083b31f06dfc', 'c9f001ebc5fd49f29a266aeaabf57ea5', '1025036627f24b94a8dad3d4cc326a22', 1),
  ('46a53a056a3542eeb5e53591568463cf', '4012c3145db5486d839d4a9a95bd4245', '1025036627f24b94a8dad3d4cc326a22', 1),
  -- Barcelona 400
  ('10e008e3326e40eba379588e50af2eea', 'f4dd383721fb480da953668ce4d82a73', '1025036627f24b94a8dad3d4cc326a22', 1),
  ('1ddcf194ac1f48999ce0e5b58ed0e2f0', '3c467667469e4e74bc959347f276ec88', '1025036627f24b94a8dad3d4cc326a22', 1),
  -- Sevilla 400
  ('f939e7bcbe4c4df098e897806dab4f87', 'da551acfdee04496b9b36158fa1d8e8e', '1025036627f24b94a8dad3d4cc326a22', 1),
  ('0cd72bbb1a66449891630a0ad447b846', 'f713781117ae48d7b28160cbeaf0543d', '1025036627f24b94a8dad3d4cc326a22', 1),
  -- Madrid 400
  ('73b3b73e08c64844b6d9b5c0cf4b1490', '223a77faed704747ab7e2afa2987aa4e', '1025036627f24b94a8dad3d4cc326a22', 1),
  ('d9b147e417e543848679ecec75b5d57e', '5e4c1248e9964fdc9509f14ae1265ec3', '1025036627f24b94a8dad3d4cc326a22', 1),
  ('d9b147e417e543848679ecec75b5d57e', '8df224dce7be460fbc950704175573c8', '1025036627f24b94a8dad3d4cc326a22', 1),
  ('73b3b73e08c64844b6d9b5c0cf4b1490', '1f484c146fff454cb14e7afc373104d9', '1025036627f24b94a8dad3d4cc326a22', 1),
  ('0e16a47898234bb6b7c5933091bcd378', 'c4ad2cdc7f4540ffbdbe458fb1c670c1', '1025036627f24b94a8dad3d4cc326a22', 1),
  ('73b3b73e08c64844b6d9b5c0cf4b1490', 'c6c3749af2474b45b32b5920dfd13beb', '1025036627f24b94a8dad3d4cc326a22', 1),
  ('d9b147e417e543848679ecec75b5d57e', '61f374a131c345738a3446cd5a4cf37e', '1025036627f24b94a8dad3d4cc326a22', 1);

-- add new sections
INSERT INTO `sections`
  (`id_section`, `id_model`, `action`, `id_connectivity_node_1`, `id_connectivity_node_2`, `active`, `name`, `rating`, `id_rating_profile`, `contingency_factor1`, `contingency_factor2`, `contingency_factor3`, `online_date`, `offline_date`, `mttf`, `mttr`, `secondary_id`, `sequential`) VALUES
  -- Málaga 400
  ('57b81ad7aae44df89ac5088cc97a8e43', '1025036627f24b94a8dad3d4cc326a22', 1, 'c9f001ebc5fd49f29a266aeaabf57ea5', 'ec67f04e413e4cee86946e46698fcda2', 1, 's51', 9999, NULL, 1, 1, 1, '2021-08-24', NULL, NULL, NULL, NULL, 1),
  ('319e1e47ef2c4e12b23d0ad9c7d947da', '1025036627f24b94a8dad3d4cc326a22', 1, '4012c3145db5486d839d4a9a95bd4245', 'ec67f04e413e4cee86946e46698fcda2', 1, 's52', 9999, NULL, 1, 1, 1, '2021-08-24', NULL, NULL, NULL, NULL, 1),
  ('de00c905977a410b81e9bf61c1a7bdb4', '1025036627f24b94a8dad3d4cc326a22', 1, 'db4456481faa433aafc5e1964e7859ec', 'fe32b465ec544c6fbd1529be81a0f0be', 1, 's53', 9999, NULL, 1, 1, 1, '2021-08-24', NULL, NULL, NULL, NULL, 1),
  ('eba07dd465d341f8a08cd03941d3ce60', '1025036627f24b94a8dad3d4cc326a22', 1, 'ec67f04e413e4cee86946e46698fcda2', 'db4456481faa433aafc5e1964e7859ec', 1, 'i35', 9999, NULL, 1, 1, 1, '2021-08-24', NULL, NULL, NULL, NULL, 1),
  -- Barcelona 400
  ('c7c489e81e85430c882e61b75812a7e7', '1025036627f24b94a8dad3d4cc326a22', 1, 'f4dd383721fb480da953668ce4d82a73', 'dedab31e41f0440ea976a2a80e7a1a55', 1, 's47', 9999, NULL, 1, 1, 1, '2021-08-24', NULL, NULL, NULL, NULL, 1),
  ('ab05b6c7ca2749b0b380e72a19bfa295', '1025036627f24b94a8dad3d4cc326a22', 1, '3c467667469e4e74bc959347f276ec88', 'dedab31e41f0440ea976a2a80e7a1a55', 1, 's48', 9999, NULL, 1, 1, 1, '2021-08-24', NULL, NULL, NULL, NULL, 1),
  ('e2541175a601450784c13ac10bc4a617', '1025036627f24b94a8dad3d4cc326a22', 1, '3c4fb7f1c51c4fe89b017a7b6f026015', '6f7f0fa6818b42b7b49cfc941d6e28bc', 1, 's49', 9999, NULL, 1, 1, 1, '2021-08-24', NULL, NULL, NULL, NULL, 1),
  ('202a7ff9ab9949e7aece38bf0bb5e68c', '1025036627f24b94a8dad3d4cc326a22', 1, '6f7f0fa6818b42b7b49cfc941d6e28bc', 'dedab31e41f0440ea976a2a80e7a1a55', 1, 'i34', 9999, NULL, 1, 1, 1, '2021-08-24', NULL, NULL, NULL, NULL, 1),
  -- Sevilla 400
  ('143cce453a144db3b783cd4a1e8ba7d5', '1025036627f24b94a8dad3d4cc326a22', 1, 'da551acfdee04496b9b36158fa1d8e8e', '6587914b5ebe45c682f4fa4f9e7042fa', 1, 's54', 9999, NULL, 1, 1, 1, '2021-08-24', NULL, NULL, NULL, NULL, 1),
  ('893f4346be4c4dbca352750e7fb492cd', '1025036627f24b94a8dad3d4cc326a22', 1, 'f713781117ae48d7b28160cbeaf0543d', '6587914b5ebe45c682f4fa4f9e7042fa', 1, 's55', 9999, NULL, 1, 1, 1, '2021-08-24', NULL, NULL, NULL, NULL, 1),
  ('d6c3523a75354ada8a7ab6fb0ce9a573', '1025036627f24b94a8dad3d4cc326a22', 1, '24fa95168b2742a4a10249f5d53bb435', '69115c21b9e14c0fb3772e39063d62b9', 1, 's56', 9999, NULL, 1, 1, 1, '2021-08-24', NULL, NULL, NULL, NULL, 1),
  ('88d4bf34a72f443e8d358da2218755b1', '1025036627f24b94a8dad3d4cc326a22', 1, '24fa95168b2742a4a10249f5d53bb435', '6587914b5ebe45c682f4fa4f9e7042fa', 1, 'i36', 9999, NULL, 1, 1, 1, '2021-08-24', NULL, NULL, NULL, NULL, 1),
  -- Madrid 400
  ('e4efcbd3e89e4ec09e812dcfe67a94df', '1025036627f24b94a8dad3d4cc326a22', 1, '223a77faed704747ab7e2afa2987aa4e', 'a925657641a5453988eeb3e07efe69c5', 1, 's57', 9999, NULL, 1, 1, 1, '2021-08-24', NULL, NULL, NULL, NULL, 1),
  ('b7140c51b5904e19a83d7d7254c2a0c6', '1025036627f24b94a8dad3d4cc326a22', 1, '5e4c1248e9964fdc9509f14ae1265ec3', '41ac013626db473ebbc3e39b925ac33c', 1, 's58', 9999, NULL, 1, 1, 1, '2021-08-24', NULL, NULL, NULL, NULL, 1),
  ('350e7e72cd3b4d888e2ec3a69087741a', '1025036627f24b94a8dad3d4cc326a22', 1, '3d1457f1e9214ac48ce1ed1dde2460a6', 'd9f5fc7430254c4ba09d89e98458f024', 1, 's59', 9999, NULL, 1, 1, 1, '2021-08-24', NULL, NULL, NULL, NULL, 1),
  ('6ac076afbda54e0eaac395b5792e701c', '1025036627f24b94a8dad3d4cc326a22', 1, '86c638a851e34e2f8fc1a8e91beb72ba', 'd9f5fc7430254c4ba09d89e98458f024', 1, 's60', 9999, NULL, 1, 1, 1, '2021-08-24', NULL, NULL, NULL, NULL, 1),
  ('962240f1407b4589ac1c49e6ddf09704', '1025036627f24b94a8dad3d4cc326a22', 1, '2d11280ee3734a0085124b9f3a64c662', 'd9f5fc7430254c4ba09d89e98458f024', 1, 's61', 9999, NULL, 1, 1, 1, '2021-08-24', NULL, NULL, NULL, NULL, 1),
  ('91c81227c8cf4483a6fd3fb6f269a1b7', '1025036627f24b94a8dad3d4cc326a22', 1, 'ae6421c1595a4f1ea8bd3cdf419dcb9a', 'f90ae0f584ed445c9f828b5851bfb147', 1, 's62', 9999, NULL, 1, 1, 1, '2021-08-24', NULL, NULL, NULL, NULL, 1),
  ('1d6af0a15d594a8680f358516ea159b4', '1025036627f24b94a8dad3d4cc326a22', 1, 'ec7edbc828874842b9aa706392c5b7b9', '8df224dce7be460fbc950704175573c8', 1, 's63', 9999, NULL, 1, 1, 1, '2021-08-24', NULL, NULL, NULL, NULL, 1),
  ('05333fa068c54ee59051cf093bb43f39', '1025036627f24b94a8dad3d4cc326a22', 1, 'ec7edbc828874842b9aa706392c5b7b9', '1f484c146fff454cb14e7afc373104d9', 1, 's64', 9999, NULL, 1, 1, 1, '2021-08-24', NULL, NULL, NULL, NULL, 1),
  ('bb8585198f4f4a6c9828abbd7d2ff9f2', '1025036627f24b94a8dad3d4cc326a22', 1, '643489dfa6ec44f786c660dc409aee6b', 'd780b4b262c04bec837d478215d22aff', 1, 's65', 9999, NULL, 1, 1, 1, '2021-08-24', NULL, NULL, NULL, NULL, 1),
  ('f6698af47dbb437b88e01337a1710cb5', '1025036627f24b94a8dad3d4cc326a22', 1, '643489dfa6ec44f786c660dc409aee6b', '7940c0a6eca64961b3c15667b2d2627a', 1, 's66', 9999, NULL, 1, 1, 1, '2021-08-24', NULL, NULL, NULL, NULL, 1),
  ('e52de52296f14ca8b71f93188cfc1a62', '1025036627f24b94a8dad3d4cc326a22', 1, '5aa79336b548418f8496f4710ffe6867', 'd9f5fc7430254c4ba09d89e98458f024', 1, 's67', 9999, NULL, 1, 1, 1, '2021-08-24', NULL, NULL, NULL, NULL, 1),
  ('59a7e3f09b654043af21f61fe03407cd', '1025036627f24b94a8dad3d4cc326a22', 1, '643489dfa6ec44f786c660dc409aee6b', 'bf671c2be31840c7a8cbcb2897bc2ef8', 1, 's68', 9999, NULL, 1, 1, 1, '2021-08-24', NULL, NULL, NULL, NULL, 1),
  ('77e4441311ed458b8254cb1a739f5311', '1025036627f24b94a8dad3d4cc326a22', 1, 'ae6421c1595a4f1ea8bd3cdf419dcb9a', '643489dfa6ec44f786c660dc409aee6b', 1, 's69', 9999, NULL, 1, 1, 1, '2021-08-24', NULL, NULL, NULL, NULL, 1),
  ('f222bf96e75040c09246205768f20984', '1025036627f24b94a8dad3d4cc326a22', 1, '7940c0a6eca64961b3c15667b2d2627a', 'c4ad2cdc7f4540ffbdbe458fb1c670c1', 1, 's70', 9999, NULL, 1, 1, 1, '2021-08-24', NULL, NULL, NULL, NULL, 1),
  ('8f462899d27a403d9616f431264cc21c', '1025036627f24b94a8dad3d4cc326a22', 1, 'b2edbc833a104cc3af97307e9ed33158', 'c6c3749af2474b45b32b5920dfd13beb', 1, 's71', 9999, NULL, 1, 1, 1, '2021-08-24', NULL, NULL, NULL, NULL, 1),
  ('b9113f2273154c77a1e8a3e2e8a6aa14', '1025036627f24b94a8dad3d4cc326a22', 1, '049a5f4ce33242649fa3690033296c86', '61f374a131c345738a3446cd5a4cf37e', 1, 's72', 9999, NULL, 1, 1, 1, '2021-08-24', NULL, NULL, NULL, NULL, 1),
  ('6447eda0bbc9427183f2ce036cd9d6e9', '1025036627f24b94a8dad3d4cc326a22', 1, '9c9101e8d89b4e0b8bb2e1b09cf8c648', '3cdee45202ef4791a420671cddf9add4', 1, 's73', 9999, NULL, 1, 1, 1, '2021-08-24', NULL, NULL, NULL, NULL, 1),
  ('fdf8ec576c104932881c78dfb6e5907f', '1025036627f24b94a8dad3d4cc326a22', 1, '9c9101e8d89b4e0b8bb2e1b09cf8c648', 'aff3472e362d4c6d8cf5263d41f6c259', 1, 's74', 9999, NULL, 1, 1, 1, '2021-08-24', NULL, NULL, NULL, NULL, 1),
  ('394526a1bf9043a8aadfe0b4171360e3', '1025036627f24b94a8dad3d4cc326a22', 1, '9c9101e8d89b4e0b8bb2e1b09cf8c648', 'ac837501f9eb4350845f829335f34b88', 1, 's75', 9999, NULL, 1, 1, 1, '2021-08-24', NULL, NULL, NULL, NULL, 1),
  ('cd294ccc3f00475d90e476ccac14ac92', '1025036627f24b94a8dad3d4cc326a22', 1, 'e71bdad0c31345589675f8e9ad052565', '5b681bd805814d24833abe153eed1e31', 1, 's76', 9999, NULL, 1, 1, 1, '2021-08-24', NULL, NULL, NULL, NULL, 1),
  ('bee28c9c900f4b7293fd8930c36aabbe', '1025036627f24b94a8dad3d4cc326a22', 1, 'a925657641a5453988eeb3e07efe69c5', '3d1457f1e9214ac48ce1ed1dde2460a6', 1, 'i37', 9999, NULL, 1, 1, 1, '2021-08-24', NULL, NULL, NULL, NULL, 1),
  ('cca1bc3d2323426cb753d8fc4e400dcf', '1025036627f24b94a8dad3d4cc326a22', 1, '41ac013626db473ebbc3e39b925ac33c', '86c638a851e34e2f8fc1a8e91beb72ba', 1, 'i38', 9999, NULL, 1, 1, 1, '2021-08-24', NULL, NULL, NULL, NULL, 1),
  ('3eb33e42b3ed4834aa9fb5f0a6985058', '1025036627f24b94a8dad3d4cc326a22', 1, '2d11280ee3734a0085124b9f3a64c662', 'ae6421c1595a4f1ea8bd3cdf419dcb9a', 1, 'i39', 9999, NULL, 1, 1, 1, '2021-08-24', NULL, NULL, NULL, NULL, 1),
  ('35ba08d62441478a9d2d61bd76533504', '1025036627f24b94a8dad3d4cc326a22', 1, 'd780b4b262c04bec837d478215d22aff', 'ec7edbc828874842b9aa706392c5b7b9', 1, 'i40', 9999, NULL, 1, 1, 1, '2021-08-24', NULL, NULL, NULL, NULL, 1),
  ('6552cc62c56c4f0c83e15f7414b3fa24', '1025036627f24b94a8dad3d4cc326a22', 1, '5aa79336b548418f8496f4710ffe6867', 'bf671c2be31840c7a8cbcb2897bc2ef8', 1, 'i41', 9999, NULL, 1, 1, 1, '2021-08-24', NULL, NULL, NULL, NULL, 1),
  ('f234a0c1c3954ca8bd1998698a371821', '1025036627f24b94a8dad3d4cc326a22', 1, 'b2edbc833a104cc3af97307e9ed33158', '3cdee45202ef4791a420671cddf9add4', 1, 'i42', 9999, NULL, 1, 1, 1, '2021-08-24', NULL, NULL, NULL, NULL, 1),
  ('bcce252614d1429e976afdcb1ad9e664', '1025036627f24b94a8dad3d4cc326a22', 1, '049a5f4ce33242649fa3690033296c86', 'aff3472e362d4c6d8cf5263d41f6c259', 1, 'i43', 9999, NULL, 1, 1, 1, '2021-08-24', NULL, NULL, NULL, NULL, 1),
  ('2ae575aea81c458196545d2df5fd0626', '1025036627f24b94a8dad3d4cc326a22', 1, 'ac837501f9eb4350845f829335f34b88', 'e71bdad0c31345589675f8e9ad052565', 1, 'i44', 9999, NULL, 1, 1, 1, '2021-08-24', NULL, NULL, NULL, NULL, 1),
  -- L Madrid-Sevilla
  ('ab530b85d9d34f4894c2f16562c8c3cb', '1025036627f24b94a8dad3d4cc326a22', 1, '7940c0a6eca64961b3c15667b2d2627a', '69115c21b9e14c0fb3772e39063d62b9', 1, 'L7', 9999, NULL, 1, 1, 1, '2021-08-24', NULL, NULL, NULL, NULL, 1),
  -- L Madrid-Barcelona
  ('f1074c57789d4da1b18a3b2fbf137791', '1025036627f24b94a8dad3d4cc326a22', 1, 'f90ae0f584ed445c9f828b5851bfb147', '3c4fb7f1c51c4fe89b017a7b6f026015', 1, 'L8', 9999, NULL, 1, 1, 1, '2021-08-24', NULL, NULL, NULL, NULL, 1),
  -- L Madrid-Málaga
  ('eba91551c4cd4b1ead94875413792ce2', '1025036627f24b94a8dad3d4cc326a22', 1, '5b681bd805814d24833abe153eed1e31', 'fe32b465ec544c6fbd1529be81a0f0be', 1, 'L9', 9999, NULL, 1, 1, 1, '2021-08-24', NULL, NULL, NULL, NULL, 1);


-- Assign sections to positions
  INSERT INTO `positions_sections`
  (`id_position`, `id_section`, `id_model`, `action`) VALUES
  -- Málaga 400
  ('54da05f25f18480a9526776445d66ea7', '57b81ad7aae44df89ac5088cc97a8e43', '1025036627f24b94a8dad3d4cc326a22', 1),
  ('54da05f25f18480a9526776445d66ea7', '319e1e47ef2c4e12b23d0ad9c7d947da', '1025036627f24b94a8dad3d4cc326a22', 1),
  ('54da05f25f18480a9526776445d66ea7', 'de00c905977a410b81e9bf61c1a7bdb4', '1025036627f24b94a8dad3d4cc326a22', 1),
  ('54da05f25f18480a9526776445d66ea7', 'eba07dd465d341f8a08cd03941d3ce60', '1025036627f24b94a8dad3d4cc326a22', 1),
  -- Barcelona 400
  ('98e3cb1d9aea44ccb3b5fca3189a05b8', 'c7c489e81e85430c882e61b75812a7e7', '1025036627f24b94a8dad3d4cc326a22', 1),
  ('98e3cb1d9aea44ccb3b5fca3189a05b8', 'ab05b6c7ca2749b0b380e72a19bfa295', '1025036627f24b94a8dad3d4cc326a22', 1),
  ('98e3cb1d9aea44ccb3b5fca3189a05b8', 'e2541175a601450784c13ac10bc4a617', '1025036627f24b94a8dad3d4cc326a22', 1),
  ('98e3cb1d9aea44ccb3b5fca3189a05b8', '202a7ff9ab9949e7aece38bf0bb5e68c', '1025036627f24b94a8dad3d4cc326a22', 1),
  -- Sevilla 400
  ('e1c13972fb4544cbab6e30ea84623a1b', '143cce453a144db3b783cd4a1e8ba7d5', '1025036627f24b94a8dad3d4cc326a22', 1),
  ('e1c13972fb4544cbab6e30ea84623a1b', '893f4346be4c4dbca352750e7fb492cd', '1025036627f24b94a8dad3d4cc326a22', 1),
  ('e1c13972fb4544cbab6e30ea84623a1b', 'd6c3523a75354ada8a7ab6fb0ce9a573', '1025036627f24b94a8dad3d4cc326a22', 1),
  ('e1c13972fb4544cbab6e30ea84623a1b', '88d4bf34a72f443e8d358da2218755b1', '1025036627f24b94a8dad3d4cc326a22', 1),
  -- Madrid 400
  ('739d96b8ba20458b9e0dea8f57580b27', 'e4efcbd3e89e4ec09e812dcfe67a94df', '1025036627f24b94a8dad3d4cc326a22', 1), -- s57
  ('739d96b8ba20458b9e0dea8f57580b27', 'b7140c51b5904e19a83d7d7254c2a0c6', '1025036627f24b94a8dad3d4cc326a22', 1), -- s58
  ('739d96b8ba20458b9e0dea8f57580b27', '350e7e72cd3b4d888e2ec3a69087741a', '1025036627f24b94a8dad3d4cc326a22', 1), -- s59
  ('739d96b8ba20458b9e0dea8f57580b27', '6ac076afbda54e0eaac395b5792e701c', '1025036627f24b94a8dad3d4cc326a22', 1), -- s60
  ('739d96b8ba20458b9e0dea8f57580b27', '962240f1407b4589ac1c49e6ddf09704', '1025036627f24b94a8dad3d4cc326a22', 1), -- s61
  ('739d96b8ba20458b9e0dea8f57580b27', '91c81227c8cf4483a6fd3fb6f269a1b7', '1025036627f24b94a8dad3d4cc326a22', 1), -- s62
  ('50f2f7e0a8ce4802b1fe9eb51c232743', '1d6af0a15d594a8680f358516ea159b4', '1025036627f24b94a8dad3d4cc326a22', 1), -- s63
  ('50f2f7e0a8ce4802b1fe9eb51c232743', '05333fa068c54ee59051cf093bb43f39', '1025036627f24b94a8dad3d4cc326a22', 1), -- s64
  ('50f2f7e0a8ce4802b1fe9eb51c232743', 'bb8585198f4f4a6c9828abbd7d2ff9f2', '1025036627f24b94a8dad3d4cc326a22', 1), -- s65
  ('50f2f7e0a8ce4802b1fe9eb51c232743', 'f6698af47dbb437b88e01337a1710cb5', '1025036627f24b94a8dad3d4cc326a22', 1), -- s66
  ('ad5bdbb73c0445da8992d17640941130', 'e52de52296f14ca8b71f93188cfc1a62', '1025036627f24b94a8dad3d4cc326a22', 1), -- s67
  ('ad5bdbb73c0445da8992d17640941130', '59a7e3f09b654043af21f61fe03407cd', '1025036627f24b94a8dad3d4cc326a22', 1), -- s68
  ('ad5bdbb73c0445da8992d17640941130', '77e4441311ed458b8254cb1a739f5311', '1025036627f24b94a8dad3d4cc326a22', 1), -- s69
  ('50f2f7e0a8ce4802b1fe9eb51c232743', 'f222bf96e75040c09246205768f20984', '1025036627f24b94a8dad3d4cc326a22', 1), -- s70
  ('423f6f62a4bf4af7b4aa29864b315c4d', '8f462899d27a403d9616f431264cc21c', '1025036627f24b94a8dad3d4cc326a22', 1), -- s71
  ('423f6f62a4bf4af7b4aa29864b315c4d', 'b9113f2273154c77a1e8a3e2e8a6aa14', '1025036627f24b94a8dad3d4cc326a22', 1), -- s72
  ('423f6f62a4bf4af7b4aa29864b315c4d', '6447eda0bbc9427183f2ce036cd9d6e9', '1025036627f24b94a8dad3d4cc326a22', 1), -- s73
  ('423f6f62a4bf4af7b4aa29864b315c4d', 'fdf8ec576c104932881c78dfb6e5907f', '1025036627f24b94a8dad3d4cc326a22', 1), -- s74
  ('423f6f62a4bf4af7b4aa29864b315c4d', '394526a1bf9043a8aadfe0b4171360e3', '1025036627f24b94a8dad3d4cc326a22', 1), -- s75
  ('423f6f62a4bf4af7b4aa29864b315c4d', 'cd294ccc3f00475d90e476ccac14ac92', '1025036627f24b94a8dad3d4cc326a22', 1), -- s76
  ('739d96b8ba20458b9e0dea8f57580b27', 'bee28c9c900f4b7293fd8930c36aabbe', '1025036627f24b94a8dad3d4cc326a22', 1), -- i37
  ('739d96b8ba20458b9e0dea8f57580b27', 'cca1bc3d2323426cb753d8fc4e400dcf', '1025036627f24b94a8dad3d4cc326a22', 1), -- i38
  ('739d96b8ba20458b9e0dea8f57580b27', '3eb33e42b3ed4834aa9fb5f0a6985058', '1025036627f24b94a8dad3d4cc326a22', 1), -- i39
  ('50f2f7e0a8ce4802b1fe9eb51c232743', '35ba08d62441478a9d2d61bd76533504', '1025036627f24b94a8dad3d4cc326a22', 1), -- i40
  ('ad5bdbb73c0445da8992d17640941130', '6552cc62c56c4f0c83e15f7414b3fa24', '1025036627f24b94a8dad3d4cc326a22', 1), -- i41
  ('423f6f62a4bf4af7b4aa29864b315c4d', 'f234a0c1c3954ca8bd1998698a371821', '1025036627f24b94a8dad3d4cc326a22', 1), -- i42
  ('423f6f62a4bf4af7b4aa29864b315c4d', 'bcce252614d1429e976afdcb1ad9e664', '1025036627f24b94a8dad3d4cc326a22', 1), -- i43
  ('423f6f62a4bf4af7b4aa29864b315c4d', '2ae575aea81c458196545d2df5fd0626', '1025036627f24b94a8dad3d4cc326a22', 1); -- i44

-- declare power lines
INSERT INTO `assets`.`power_lines`
  (`id_line`, `id_model`, `action`, `name`, `online_date`, `offline_date`) VALUES 
  ('471ecc4ce32d4a5b9b6e996af5053a84', '1025036627f24b94a8dad3d4cc326a22', 1, 'PL7', '2021-08-24', NULL),
  ('dd0003153593492297448e083ff4c857', '1025036627f24b94a8dad3d4cc326a22', 1, 'PL8', '2021-08-24', NULL),
  ('f1b273271d0941e68a654109e8c4dbeb', '1025036627f24b94a8dad3d4cc326a22', 1, 'PL9', '2021-08-24', NULL);

-- declare sections with power lines and assign electrical parameters
INSERT INTO `assets`.`ac_line_sections`
  (`id_section`, `id_model`, `action`, `id_line`, `r0`, `x0`, `b0`, `r1`, `x1`, `b1`, `r2`, `x2`, `b2`, `length`, `sequential`) VALUES 
  ('ab530b85d9d34f4894c2f16562c8c3cb', '1025036627f24b94a8dad3d4cc326a22', 1, '471ecc4ce32d4a5b9b6e996af5053a84', 0.0020, 0.021, 0, 0, 0, 0, 0, 0, 0, 16, 1),
  ('f1074c57789d4da1b18a3b2fbf137791', '1025036627f24b94a8dad3d4cc326a22', 1, 'dd0003153593492297448e083ff4c857', 0.0040, 0.030, 0, 0, 0, 0, 0, 0, 0, 54, 1),
  ('eba91551c4cd4b1ead94875413792ce2', '1025036627f24b94a8dad3d4cc326a22', 1, 'f1b273271d0941e68a654109e8c4dbeb', 0.0035, 0.028, 0, 0, 0, 0, 0, 0, 0, 42, 1);


-- declare sections as switches and breakers
INSERT INTO `assets`.`switches`
  (`id_section`, `id_model`, `action`, `normal_state`, `switch_type`) VALUES
  -- Málaga 400
  ('57b81ad7aae44df89ac5088cc97a8e43', '1025036627f24b94a8dad3d4cc326a22', 1, 1, 0),
  ('319e1e47ef2c4e12b23d0ad9c7d947da', '1025036627f24b94a8dad3d4cc326a22', 1, 1, 0),
  ('de00c905977a410b81e9bf61c1a7bdb4', '1025036627f24b94a8dad3d4cc326a22', 1, 1, 0),
  ('eba07dd465d341f8a08cd03941d3ce60', '1025036627f24b94a8dad3d4cc326a22', 1, 1, 1),
  -- Barcelona 400
  ('c7c489e81e85430c882e61b75812a7e7', '1025036627f24b94a8dad3d4cc326a22', 1, 1, 0),
  ('ab05b6c7ca2749b0b380e72a19bfa295', '1025036627f24b94a8dad3d4cc326a22', 1, 1, 0),
  ('e2541175a601450784c13ac10bc4a617', '1025036627f24b94a8dad3d4cc326a22', 1, 1, 0),
  ('202a7ff9ab9949e7aece38bf0bb5e68c', '1025036627f24b94a8dad3d4cc326a22', 1, 1, 1),
  -- Barcelona 400
  ('143cce453a144db3b783cd4a1e8ba7d5', '1025036627f24b94a8dad3d4cc326a22', 1, 1, 0),
  ('893f4346be4c4dbca352750e7fb492cd', '1025036627f24b94a8dad3d4cc326a22', 1, 1, 0),
  ('d6c3523a75354ada8a7ab6fb0ce9a573', '1025036627f24b94a8dad3d4cc326a22', 1, 1, 0),
  ('88d4bf34a72f443e8d358da2218755b1', '1025036627f24b94a8dad3d4cc326a22', 1, 1, 1),
  -- Madrid 400
  ('e4efcbd3e89e4ec09e812dcfe67a94df', '1025036627f24b94a8dad3d4cc326a22', 1, 1, 0),
  ('b7140c51b5904e19a83d7d7254c2a0c6', '1025036627f24b94a8dad3d4cc326a22', 1, 1, 0),
  ('350e7e72cd3b4d888e2ec3a69087741a', '1025036627f24b94a8dad3d4cc326a22', 1, 1, 0),
  ('6ac076afbda54e0eaac395b5792e701c', '1025036627f24b94a8dad3d4cc326a22', 1, 1, 0),
  ('962240f1407b4589ac1c49e6ddf09704', '1025036627f24b94a8dad3d4cc326a22', 1, 1, 0),
  ('91c81227c8cf4483a6fd3fb6f269a1b7', '1025036627f24b94a8dad3d4cc326a22', 1, 1, 0),
  ('1d6af0a15d594a8680f358516ea159b4', '1025036627f24b94a8dad3d4cc326a22', 1, 1, 0),
  ('05333fa068c54ee59051cf093bb43f39', '1025036627f24b94a8dad3d4cc326a22', 1, 1, 0),
  ('bb8585198f4f4a6c9828abbd7d2ff9f2', '1025036627f24b94a8dad3d4cc326a22', 1, 1, 0),
  ('f6698af47dbb437b88e01337a1710cb5', '1025036627f24b94a8dad3d4cc326a22', 1, 1, 0),
  ('e52de52296f14ca8b71f93188cfc1a62', '1025036627f24b94a8dad3d4cc326a22', 1, 1, 0),
  ('59a7e3f09b654043af21f61fe03407cd', '1025036627f24b94a8dad3d4cc326a22', 1, 1, 0),
  ('77e4441311ed458b8254cb1a739f5311', '1025036627f24b94a8dad3d4cc326a22', 1, 1, 0),
  ('f222bf96e75040c09246205768f20984', '1025036627f24b94a8dad3d4cc326a22', 1, 1, 0),
  ('8f462899d27a403d9616f431264cc21c', '1025036627f24b94a8dad3d4cc326a22', 1, 1, 0),
  ('b9113f2273154c77a1e8a3e2e8a6aa14', '1025036627f24b94a8dad3d4cc326a22', 1, 1, 0),
  ('6447eda0bbc9427183f2ce036cd9d6e9', '1025036627f24b94a8dad3d4cc326a22', 1, 1, 0),
  ('fdf8ec576c104932881c78dfb6e5907f', '1025036627f24b94a8dad3d4cc326a22', 1, 1, 0),
  ('394526a1bf9043a8aadfe0b4171360e3', '1025036627f24b94a8dad3d4cc326a22', 1, 1, 0),
  ('cd294ccc3f00475d90e476ccac14ac92', '1025036627f24b94a8dad3d4cc326a22', 1, 1, 0),
  ('bee28c9c900f4b7293fd8930c36aabbe', '1025036627f24b94a8dad3d4cc326a22', 1, 1, 1),
  ('cca1bc3d2323426cb753d8fc4e400dcf', '1025036627f24b94a8dad3d4cc326a22', 1, 1, 1),
  ('3eb33e42b3ed4834aa9fb5f0a6985058', '1025036627f24b94a8dad3d4cc326a22', 1, 1, 1),
  ('35ba08d62441478a9d2d61bd76533504', '1025036627f24b94a8dad3d4cc326a22', 1, 1, 1),
  ('6552cc62c56c4f0c83e15f7414b3fa24', '1025036627f24b94a8dad3d4cc326a22', 1, 1, 1),
  ('f234a0c1c3954ca8bd1998698a371821', '1025036627f24b94a8dad3d4cc326a22', 1, 1, 1),
  ('bcce252614d1429e976afdcb1ad9e664', '1025036627f24b94a8dad3d4cc326a22', 1, 1, 1),
  ('2ae575aea81c458196545d2df5fd0626', '1025036627f24b94a8dad3d4cc326a22', 1, 1, 1);



-- ----
--  NEW Pamplona substation 
-- ----


-- New model
INSERT INTO `assets`.`models`
  (`id_model`, `name`, `valid_date`, `creation_date`, `created_by`, `comments`) VALUES
  ('5d3e9ade49a34e66bce4f54c6ae57d33', 'Red F', '2026-01-01','2021-10-28','admin', 'Nuevo parque configuración en anillo: Pamplona 400');

-- Assign model parent
INSERT INTO `models_models`
  (`id_model_parent`, `id_model_child`) VALUES
  ('1025036627f24b94a8dad3d4cc326a22','5d3e9ade49a34e66bce4f54c6ae57d33');


-- New substations
INSERT INTO `assets`.`substations`
  (`id_substation`, `id_model`, `action`, `id_zone`, `id_province`, `name`, `latitude`, `longitude`, `online_date`, `offline_date`, `id_bdi`, `comment`) VALUES
  -- Pamplona substation
  ('0204c755fd0a4f4fb612ea095e7c28cf', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, '95170261ec8b41c1a5ba0290e0f54b18', '1f1b2e23cdc64f23861b9fae0ffa98cb', 'Pamplona', '42.824196730655125', '-1.7163120800726583', '2021-11-03', Null, Null, 'Prueba de anillo');

-- New voltage level
INSERT INTO `assets`.`voltage_levels`
  (`id_voltage_level`, `id_model`, `action`, `id_substation`, `id_voltage_level_type`, `id_voltage_level_configuration`, `voltage`, `online_date`, `offline_date`, `id_bdi`, `comment`) VALUES
  -- Pamplona 400 voltage level
  ('d7ab0a31fb7a4f6c888b452b7153108e', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, '0204c755fd0a4f4fb612ea095e7c28cf', 'caa4c2041b594927862ad16765deb9e8', 'f890dd5c7bc54242816664fc55cff34b', 400, '2021-11-03', Null, Null, 'Parque 7, 400 kV');

-- New connectivity nodes
INSERT INTO `assets`.`connectivity_nodes`
  (`id_connectivity_node`, `id_model`, `action`, `name`, `x`, `y`) VALUES 

  -- Gijón 400 
  ('a0f6d1b1878f4efb8a519557d3e0467a', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 'c139', 0, 0),
  ('9c077d9fc5134f2cbbe95eae9c6256d4', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 'c140', 0, 0),
  ('6fd134ab2bd146f795f5da9c91ab0dd9', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 'c141', 0, 0),
  ('4c455a24e108417dae2faad169680601', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 'c142', 0, 0),
  ('a47ad85768f9492482efb1bd1419c0ad', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 'c143', 0, 0),  

  -- Madrid 400
  ('612f22a8af204b9a9a4c68f6e4813d4e', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 'c144', 0, 0),
  ('aaa3310fa86c4d9ca9ed47731c4aaf50', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 'c145', 0, 0),
  ('0b6f6da44c6c45ed96019ceb526c4d56', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 'c146', 0, 0),
  ('5065c6903fc1496994353fc723a16d4b', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 'c147', 0, 0),
  ('4e35c78016764e44b8ce7164892e23e5', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 'c148', 0, 0),

  -- Barcelona 400 
  ('0770b22bf8ad43e69d867cb01dd4f509', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 'c149', 0, 0),
  ('969f3941ef9b441aaf382027367e141c', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 'c150', 0, 0),
  ('e762f864be5e47d9bc3d9a54425cae42', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 'c151', 0, 0),
  ('9d3d13e14dde488b90bd2c3d16fa1b0b', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 'c152', 0, 0),
  ('da68d8f0ea7f4bab9b6152a9048aaed7', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 'c153', 0, 0),

  -- Pamplona 400 
  ('bdb49947578a4ac284c7b0bbd514bfa2', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 'c154', 0, 0),
  ('30d493a6a88240ac84fc62564621b20e', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 'c155', 0, 0),
  ('cf3869aa3d0a4c6a8675c7316bbba8c9', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 'c156', 0, 0),
  ('6f72b62a1f17431c82220a148000ccbb', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 'c157', 0, 0),
  ('edf27721b1424b83a2c39bc4391298fe', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 'c158', 0, 0),
  ('e8691afb7f6745e1a1b2dc77f1666a3f', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 'c159', 0, 0),
  ('76e7113e084d45bfad9536c8a48d935e', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 'c160', 0, 0),
  ('c78ac0bbc8e44976b1cc9be03f006d8b', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 'c161', 0, 0),
  ('aa717e99bf1c4b1bb2ad44e951cc38a9', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 'c162', 0, 0),
  ('9c774a12a9ab40399ce312dabbc5b7c7', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 'c163', 0, 0),
  ('b5fff0ecbe0d4a8e8318a48f3fddc8e5', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 'c164', 0, 0),
  ('343609873236435f855dd360b42886e3', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 'c165', 0, 0),
  ('6f732563670d4ed8b2e083384d9b6d7c', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 'c166', 0, 0),
  ('dfa72a97e2c94626a974e8786feb43bf', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 'c167', 0, 0),
  ('16e2c3dd87ff45f19c650bcc9848abf3', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 'c168', 0, 0);

-- declare connectivity nodes in voltage_level
INSERT INTO `assets`.`connectivity_nodes_voltage_levels`
  (`id_connectivity_node`, `id_voltage_level`, `id_model`, `action`) VALUES

  -- Gijón 400 
  ('a0f6d1b1878f4efb8a519557d3e0467a', '48ce7abce09c4568bc28d86f7b20c486', '5d3e9ade49a34e66bce4f54c6ae57d33', 1),
  ('9c077d9fc5134f2cbbe95eae9c6256d4', '48ce7abce09c4568bc28d86f7b20c486', '5d3e9ade49a34e66bce4f54c6ae57d33', 1),
  ('6fd134ab2bd146f795f5da9c91ab0dd9', '48ce7abce09c4568bc28d86f7b20c486', '5d3e9ade49a34e66bce4f54c6ae57d33', 1),
  ('a47ad85768f9492482efb1bd1419c0ad', '48ce7abce09c4568bc28d86f7b20c486', '5d3e9ade49a34e66bce4f54c6ae57d33', 1),  
  ('4c455a24e108417dae2faad169680601', '48ce7abce09c4568bc28d86f7b20c486', '5d3e9ade49a34e66bce4f54c6ae57d33', 1),

  -- Madrid 400
  ('612f22a8af204b9a9a4c68f6e4813d4e', '1b1cbdb8231942538363075623ff70ff', '5d3e9ade49a34e66bce4f54c6ae57d33', 1),
  ('aaa3310fa86c4d9ca9ed47731c4aaf50', '1b1cbdb8231942538363075623ff70ff', '5d3e9ade49a34e66bce4f54c6ae57d33', 1),
  ('0b6f6da44c6c45ed96019ceb526c4d56', '1b1cbdb8231942538363075623ff70ff', '5d3e9ade49a34e66bce4f54c6ae57d33', 1),
  ('5065c6903fc1496994353fc723a16d4b', '1b1cbdb8231942538363075623ff70ff', '5d3e9ade49a34e66bce4f54c6ae57d33', 1),
  ('4e35c78016764e44b8ce7164892e23e5', '1b1cbdb8231942538363075623ff70ff', '5d3e9ade49a34e66bce4f54c6ae57d33', 1),

  -- Barcelona 400 
  ('0770b22bf8ad43e69d867cb01dd4f509','271f651a18754726b5cf54b6b34a03b6', '5d3e9ade49a34e66bce4f54c6ae57d33', 1),
  ('969f3941ef9b441aaf382027367e141c','271f651a18754726b5cf54b6b34a03b6', '5d3e9ade49a34e66bce4f54c6ae57d33', 1),
  ('e762f864be5e47d9bc3d9a54425cae42','271f651a18754726b5cf54b6b34a03b6', '5d3e9ade49a34e66bce4f54c6ae57d33', 1),
  ('9d3d13e14dde488b90bd2c3d16fa1b0b','271f651a18754726b5cf54b6b34a03b6', '5d3e9ade49a34e66bce4f54c6ae57d33', 1),
  ('da68d8f0ea7f4bab9b6152a9048aaed7','271f651a18754726b5cf54b6b34a03b6', '5d3e9ade49a34e66bce4f54c6ae57d33', 1),

  -- Pamplona 400 
  ('bdb49947578a4ac284c7b0bbd514bfa2', 'd7ab0a31fb7a4f6c888b452b7153108e', '5d3e9ade49a34e66bce4f54c6ae57d33', 1),
  ('30d493a6a88240ac84fc62564621b20e', 'd7ab0a31fb7a4f6c888b452b7153108e', '5d3e9ade49a34e66bce4f54c6ae57d33', 1),
  ('cf3869aa3d0a4c6a8675c7316bbba8c9', 'd7ab0a31fb7a4f6c888b452b7153108e', '5d3e9ade49a34e66bce4f54c6ae57d33', 1),
  ('6f72b62a1f17431c82220a148000ccbb', 'd7ab0a31fb7a4f6c888b452b7153108e', '5d3e9ade49a34e66bce4f54c6ae57d33', 1),
  ('edf27721b1424b83a2c39bc4391298fe', 'd7ab0a31fb7a4f6c888b452b7153108e', '5d3e9ade49a34e66bce4f54c6ae57d33', 1),
  ('e8691afb7f6745e1a1b2dc77f1666a3f', 'd7ab0a31fb7a4f6c888b452b7153108e', '5d3e9ade49a34e66bce4f54c6ae57d33', 1),
  ('76e7113e084d45bfad9536c8a48d935e', 'd7ab0a31fb7a4f6c888b452b7153108e', '5d3e9ade49a34e66bce4f54c6ae57d33', 1),
  ('c78ac0bbc8e44976b1cc9be03f006d8b', 'd7ab0a31fb7a4f6c888b452b7153108e', '5d3e9ade49a34e66bce4f54c6ae57d33', 1),
  ('aa717e99bf1c4b1bb2ad44e951cc38a9', 'd7ab0a31fb7a4f6c888b452b7153108e', '5d3e9ade49a34e66bce4f54c6ae57d33', 1),
  ('9c774a12a9ab40399ce312dabbc5b7c7', 'd7ab0a31fb7a4f6c888b452b7153108e', '5d3e9ade49a34e66bce4f54c6ae57d33', 1),
  ('b5fff0ecbe0d4a8e8318a48f3fddc8e5', 'd7ab0a31fb7a4f6c888b452b7153108e', '5d3e9ade49a34e66bce4f54c6ae57d33', 1),
  ('343609873236435f855dd360b42886e3', 'd7ab0a31fb7a4f6c888b452b7153108e', '5d3e9ade49a34e66bce4f54c6ae57d33', 1),
  ('6f732563670d4ed8b2e083384d9b6d7c', 'd7ab0a31fb7a4f6c888b452b7153108e', '5d3e9ade49a34e66bce4f54c6ae57d33', 1),
  ('dfa72a97e2c94626a974e8786feb43bf', 'd7ab0a31fb7a4f6c888b452b7153108e', '5d3e9ade49a34e66bce4f54c6ae57d33', 1),
  ('16e2c3dd87ff45f19c650bcc9848abf3', 'd7ab0a31fb7a4f6c888b452b7153108e', '5d3e9ade49a34e66bce4f54c6ae57d33', 1);

  
-- declare witch connectiviy nodes are connected to bus bars
INSERT INTO `assets`.`buses_connectivity_nodes`
  (`id_bus`, `id_connectivity_node`, `id_model`, `action`) VALUES 

  -- Gijón 400
  ('f939e7bcbe4c4df098e897806dab4f87', '4c455a24e108417dae2faad169680601', '5d3e9ade49a34e66bce4f54c6ae57d33', 1), 
  ('0cd72bbb1a66449891630a0ad447b846', 'a47ad85768f9492482efb1bd1419c0ad', '5d3e9ade49a34e66bce4f54c6ae57d33', 1), 

  -- Barcelona 400
  ('10e008e3326e40eba379588e50af2eea', '9d3d13e14dde488b90bd2c3d16fa1b0b', '5d3e9ade49a34e66bce4f54c6ae57d33', 1), 
  ('1ddcf194ac1f48999ce0e5b58ed0e2f0', 'da68d8f0ea7f4bab9b6152a9048aaed7', '5d3e9ade49a34e66bce4f54c6ae57d33', 1), 

  -- Madrid 400
  ('d9b147e417e543848679ecec75b5d57e', '4e35c78016764e44b8ce7164892e23e5', '5d3e9ade49a34e66bce4f54c6ae57d33', 1), 
  ('73b3b73e08c64844b6d9b5c0cf4b1490', '5065c6903fc1496994353fc723a16d4b', '5d3e9ade49a34e66bce4f54c6ae57d33', 1);

  
-- add new sections
INSERT INTO `assets`.`sections`
  (`id_section`, `id_model`, `action`, `id_connectivity_node_1`, `id_connectivity_node_2`, `active`, `name`, `rating`, `id_rating_profile`, `contingency_factor1`, `contingency_factor2`, `contingency_factor3`, `online_date`, `offline_date`, `mttf`, `mttr`, `secondary_id`, `sequential`) VALUES
  
  -- Barcelona 400
  ('cef04ee0ad484a72ac201af5e93c7100', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, '0770b22bf8ad43e69d867cb01dd4f509', '969f3941ef9b441aaf382027367e141c', 1, 's83', 9999, NULL, 1, 1, 1, '2021-11-03', NULL, NULL, NULL, NULL, 1),  
  ('d9cd73d3d51f4dd09db8b19560ee7259', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 'e762f864be5e47d9bc3d9a54425cae42', '9d3d13e14dde488b90bd2c3d16fa1b0b', 1, 's84', 9999, NULL, 1, 1, 1, '2021-11-03', NULL, NULL, NULL, NULL, 1),  
  ('6b5092e9785c427fa7c991ef41a48db4', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 'e762f864be5e47d9bc3d9a54425cae42', 'da68d8f0ea7f4bab9b6152a9048aaed7', 1, 's85', 9999, NULL, 1, 1, 1, '2021-11-03', NULL, NULL, NULL, NULL, 1),  
  ('16390f917ef34e3180f77ff893965dfe', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, '969f3941ef9b441aaf382027367e141c', 'e762f864be5e47d9bc3d9a54425cae42', 1, 'i47', 9999, NULL, 1, 1, 1, '2021-11-03', NULL, NULL, NULL, NULL, 1),  

  -- Madrid 400
  ('581b56498a2f4024beeabca6ac4432c2', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, '612f22a8af204b9a9a4c68f6e4813d4e', 'aaa3310fa86c4d9ca9ed47731c4aaf50', 1, 's80', 9999, NULL, 1, 1, 1, '2021-11-03', NULL, NULL, NULL, NULL, 1),  
  ('fdc0226e0e684b4584a4a8820cca5625', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, '0b6f6da44c6c45ed96019ceb526c4d56', '5065c6903fc1496994353fc723a16d4b', 1, 's81', 9999, NULL, 1, 1, 1, '2021-11-03', NULL, NULL, NULL, NULL, 1),  
  ('a9c5efa5ea6a409da970f7b353267a7b', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, '0b6f6da44c6c45ed96019ceb526c4d56', '4e35c78016764e44b8ce7164892e23e5', 1, 's82', 9999, NULL, 1, 1, 1, '2021-11-03', NULL, NULL, NULL, NULL, 1),  
  ('3ef1159c62824b549524d5223e90bbb5', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 'aaa3310fa86c4d9ca9ed47731c4aaf50', '0b6f6da44c6c45ed96019ceb526c4d56', 1, 'i46', 9999, NULL, 1, 1, 1, '2021-11-03', NULL, NULL, NULL, NULL, 1),  

  -- Gijón 400
  ('35ee1e15e6a442dcbb4c0ae2498ce0bc', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 'a0f6d1b1878f4efb8a519557d3e0467a', '9c077d9fc5134f2cbbe95eae9c6256d4', 1, 's77', 9999, NULL, 1, 1, 1, '2021-11-03', NULL, NULL, NULL, NULL, 1),  
  ('a025d36698f442a5bcf84ff50bc3917a', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, '6fd134ab2bd146f795f5da9c91ab0dd9', '4c455a24e108417dae2faad169680601', 1, 's78', 9999, NULL, 1, 1, 1, '2021-11-03', NULL, NULL, NULL, NULL, 1),  
  ('0d3532b8343546fe800ef430a1ab4b24', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, '6fd134ab2bd146f795f5da9c91ab0dd9', 'a47ad85768f9492482efb1bd1419c0ad', 1, 's79', 9999, NULL, 1, 1, 1, '2021-11-03', NULL, NULL, NULL, NULL, 1),  
  ('31494c055e3442c6a26c1ba104065066', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, '9c077d9fc5134f2cbbe95eae9c6256d4', '6fd134ab2bd146f795f5da9c91ab0dd9', 1, 'i45', 9999, NULL, 1, 1, 1, '2021-11-03', NULL, NULL, NULL, NULL, 1),  

  -- Pamplona 400
  ('c9eb6a54a34f4ebd814e59a75bb9382a', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 'bdb49947578a4ac284c7b0bbd514bfa2', '30d493a6a88240ac84fc62564621b20e', 1, 's86', 9999, NULL, 1, 1, 1, '2021-11-03', NULL, NULL, NULL, NULL, 1),  
  ('004060a60cde456fa209cea8ebe7f397', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 'edf27721b1424b83a2c39bc4391298fe', 'dfa72a97e2c94626a974e8786feb43bf', 1, 's87', 9999, NULL, 1, 1, 1, '2021-11-03', NULL, NULL, NULL, NULL, 1),  
  ('ce883ba0c263413ea8e6f54e38896736', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 'c78ac0bbc8e44976b1cc9be03f006d8b', '16e2c3dd87ff45f19c650bcc9848abf3', 1, 's88', 9999, NULL, 1, 1, 1, '2021-11-03', NULL, NULL, NULL, NULL, 1),  
  ('efe3f1a30ada4982a3ad4d5cec8f0f66', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, '30d493a6a88240ac84fc62564621b20e', 'cf3869aa3d0a4c6a8675c7316bbba8c9', 1, 's89', 9999, NULL, 1, 1, 1, '2021-11-03', NULL, NULL, NULL, NULL, 1),  
  ('83f83c6f00c7492b96f2a113b6006d5f', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, '6f72b62a1f17431c82220a148000ccbb', 'edf27721b1424b83a2c39bc4391298fe', 1, 's90', 9999, NULL, 1, 1, 1, '2021-11-03', NULL, NULL, NULL, NULL, 1),  
  ('55fed787a0794f218214e275802669b6', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 'edf27721b1424b83a2c39bc4391298fe', 'e8691afb7f6745e1a1b2dc77f1666a3f', 1, 's91', 9999, NULL, 1, 1, 1, '2021-11-03', NULL, NULL, NULL, NULL, 1),  
  ('505c919c6a75462687378fbdbd1838c0', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, '76e7113e084d45bfad9536c8a48d935e', 'c78ac0bbc8e44976b1cc9be03f006d8b', 1, 's92', 9999, NULL, 1, 1, 1, '2021-11-03', NULL, NULL, NULL, NULL, 1),  
  ('376503daba7f4dcebdfc513608c16790', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 'c78ac0bbc8e44976b1cc9be03f006d8b', 'aa717e99bf1c4b1bb2ad44e951cc38a9', 1, 's93', 9999, NULL, 1, 1, 1, '2021-11-03', NULL, NULL, NULL, NULL, 1),  
  ('3a61ff554537472484bea0e76596f9c1', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, '9c774a12a9ab40399ce312dabbc5b7c7', 'b5fff0ecbe0d4a8e8318a48f3fddc8e5', 1, 's94', 9999, NULL, 1, 1, 1, '2021-11-03', NULL, NULL, NULL, NULL, 1),  
  ('2510d3e818634e79869d65826a8eeb5d', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 'b5fff0ecbe0d4a8e8318a48f3fddc8e5', '343609873236435f855dd360b42886e3', 1, 's95', 9999, NULL, 1, 1, 1, '2021-11-03', NULL, NULL, NULL, NULL, 1),  
  ('8970b0fcf8484d5e91dcdddff76116c8', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, '30d493a6a88240ac84fc62564621b20e', '6f732563670d4ed8b2e083384d9b6d7c', 1, 's96', 9999, NULL, 1, 1, 1, '2021-11-03', NULL, NULL, NULL, NULL, 1),  
  ('bfe97e21956d4329919527eaa685caec', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 'cf3869aa3d0a4c6a8675c7316bbba8c9', '6f72b62a1f17431c82220a148000ccbb', 1, 'i48', 9999, NULL, 1, 1, 1, '2021-11-03', NULL, NULL, NULL, NULL, 1),  
  ('fcea4ee6652b4172b6d698e5369e2eb2', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 'e8691afb7f6745e1a1b2dc77f1666a3f', '76e7113e084d45bfad9536c8a48d935e', 1, 'i49', 9999, NULL, 1, 1, 1, '2021-11-03', NULL, NULL, NULL, NULL, 1),  
  ('47049906a5e24c3ea5866706e8c6381d', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 'aa717e99bf1c4b1bb2ad44e951cc38a9', '9c774a12a9ab40399ce312dabbc5b7c7', 1, 'i50', 9999, NULL, 1, 1, 1, '2021-11-03', NULL, NULL, NULL, NULL, 1),  
  ('c2c516b57a4146a6b89e4e5a766a40db', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, '343609873236435f855dd360b42886e3', '6f732563670d4ed8b2e083384d9b6d7c', 1, 'i51', 9999, NULL, 1, 1, 1, '2021-11-03', NULL, NULL, NULL, NULL, 1),

  -- L10 Gijón-Málaga
  ('423f2e5c80824c3f9840b88070ac086b', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 'a0f6d1b1878f4efb8a519557d3e0467a', 'dfa72a97e2c94626a974e8786feb43bf', 1, 'L10', 9999, NULL, 1, 1, 1, '2021-11-03', NULL, NULL, NULL, NULL, 1),
 
  -- L11 Madrid-Pamplona
  ('0c5f91a58dde4707b0360c3b7c25df6b', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, '612f22a8af204b9a9a4c68f6e4813d4e', '16e2c3dd87ff45f19c650bcc9848abf3', 1, 'L11', 9999, NULL, 1, 1, 1, '2021-11-03', NULL, NULL, NULL, NULL, 1),
 
  -- L12 Barcelona-Pamplona
  ('80ef15b3428c4729b27d4efcdc081963', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, '0770b22bf8ad43e69d867cb01dd4f509', 'bdb49947578a4ac284c7b0bbd514bfa2', 1, 'L12', 9999, NULL, 1, 1, 1, '2021-11-03', NULL, NULL, NULL, NULL, 1);

--  New positions 
INSERT INTO `assets`.`positions`
  (`id_position`, `id_model`, `action`, `id_position_type`, `online_date`, `offline_date`) VALUES 
  
  -- Barcelona 400
  ('b05d02b2dbe8419b9c86345c18b3d078', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 2, '2021-11-03', NULL),

  -- Madrid 400
  ('559cec89030749828e91f751476f7b4a', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 2, '2021-11-03', NULL),

  -- Gijón 400
  ('b5fa10bbe7444e3eb2230cad6607f241', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 2, '2021-11-03', NULL),
  
  -- Pamplona 400
  ('5f73ec0bf7cf44f38f2180edd4afce09', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 2, '2021-11-03', NULL),
  ('113fd9b7fc5349e7984e4e4363b8bf7e', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 2, '2021-11-03', NULL),
  ('e21afc1941824c39ba0b3a73d306d9b6', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 2, '2021-11-03', NULL),
  ('de4a0b8a25f247d783ed532e61a73c0c', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 2, '2021-11-03', NULL),
  ('c5a45064b853452da68f4c0de45a45c8', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 2, '2021-11-03', NULL),
  ('ad58dc466c744afba624455fc1dcb06d', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 2, '2021-11-03', NULL),
  ('b7815c6c34b240088d46d3b76292b28a', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 2, '2021-11-03', NULL);

  
-- Assign sections to positions
  INSERT INTO `assets`.`positions_sections`
  (`id_position`, `id_section`, `id_model`, `action`) VALUES 

  -- Barcelona 400
  ('b05d02b2dbe8419b9c86345c18b3d078', 'cef04ee0ad484a72ac201af5e93c7100', '5d3e9ade49a34e66bce4f54c6ae57d33', 1),
  ('b05d02b2dbe8419b9c86345c18b3d078', 'd9cd73d3d51f4dd09db8b19560ee7259', '5d3e9ade49a34e66bce4f54c6ae57d33', 1),
  ('b05d02b2dbe8419b9c86345c18b3d078', '6b5092e9785c427fa7c991ef41a48db4', '5d3e9ade49a34e66bce4f54c6ae57d33', 1),
  ('b05d02b2dbe8419b9c86345c18b3d078', '16390f917ef34e3180f77ff893965dfe', '5d3e9ade49a34e66bce4f54c6ae57d33', 1),

  -- Madrid 400
  ('559cec89030749828e91f751476f7b4a', '581b56498a2f4024beeabca6ac4432c2', '5d3e9ade49a34e66bce4f54c6ae57d33', 1),
  ('559cec89030749828e91f751476f7b4a', 'fdc0226e0e684b4584a4a8820cca5625', '5d3e9ade49a34e66bce4f54c6ae57d33', 1),
  ('559cec89030749828e91f751476f7b4a', 'a9c5efa5ea6a409da970f7b353267a7b', '5d3e9ade49a34e66bce4f54c6ae57d33', 1),
  ('559cec89030749828e91f751476f7b4a', '3ef1159c62824b549524d5223e90bbb5', '5d3e9ade49a34e66bce4f54c6ae57d33', 1),
  
  -- Gijón 400
  ('b5fa10bbe7444e3eb2230cad6607f241', '35ee1e15e6a442dcbb4c0ae2498ce0bc', '5d3e9ade49a34e66bce4f54c6ae57d33', 1),
  ('b5fa10bbe7444e3eb2230cad6607f241', 'a025d36698f442a5bcf84ff50bc3917a', '5d3e9ade49a34e66bce4f54c6ae57d33', 1),
  ('b5fa10bbe7444e3eb2230cad6607f241', '0d3532b8343546fe800ef430a1ab4b24', '5d3e9ade49a34e66bce4f54c6ae57d33', 1),
  ('b5fa10bbe7444e3eb2230cad6607f241', '31494c055e3442c6a26c1ba104065066', '5d3e9ade49a34e66bce4f54c6ae57d33', 1),

  -- Pamplona 400
  ('5f73ec0bf7cf44f38f2180edd4afce09', 'c9eb6a54a34f4ebd814e59a75bb9382a', '5d3e9ade49a34e66bce4f54c6ae57d33', 1),
  ('113fd9b7fc5349e7984e4e4363b8bf7e', '004060a60cde456fa209cea8ebe7f397', '5d3e9ade49a34e66bce4f54c6ae57d33', 1),
  ('e21afc1941824c39ba0b3a73d306d9b6', 'ce883ba0c263413ea8e6f54e38896736', '5d3e9ade49a34e66bce4f54c6ae57d33', 1),
  ('de4a0b8a25f247d783ed532e61a73c0c', 'efe3f1a30ada4982a3ad4d5cec8f0f66', '5d3e9ade49a34e66bce4f54c6ae57d33', 1),
  ('de4a0b8a25f247d783ed532e61a73c0c', '83f83c6f00c7492b96f2a113b6006d5f', '5d3e9ade49a34e66bce4f54c6ae57d33', 1),
  ('de4a0b8a25f247d783ed532e61a73c0c', '55fed787a0794f218214e275802669b6', '5d3e9ade49a34e66bce4f54c6ae57d33', 1),
  ('c5a45064b853452da68f4c0de45a45c8', '505c919c6a75462687378fbdbd1838c0', '5d3e9ade49a34e66bce4f54c6ae57d33', 1),
  ('c5a45064b853452da68f4c0de45a45c8', '376503daba7f4dcebdfc513608c16790', '5d3e9ade49a34e66bce4f54c6ae57d33', 1),
  ('c5a45064b853452da68f4c0de45a45c8', '3a61ff554537472484bea0e76596f9c1', '5d3e9ade49a34e66bce4f54c6ae57d33', 1),
  ('ad58dc466c744afba624455fc1dcb06d', '2510d3e818634e79869d65826a8eeb5d', '5d3e9ade49a34e66bce4f54c6ae57d33', 1),
  ('ad58dc466c744afba624455fc1dcb06d', '8970b0fcf8484d5e91dcdddff76116c8', '5d3e9ade49a34e66bce4f54c6ae57d33', 1),
  ('ad58dc466c744afba624455fc1dcb06d', 'bfe97e21956d4329919527eaa685caec', '5d3e9ade49a34e66bce4f54c6ae57d33', 1),
  ('b7815c6c34b240088d46d3b76292b28a', 'fcea4ee6652b4172b6d698e5369e2eb2', '5d3e9ade49a34e66bce4f54c6ae57d33', 1),
  ('b7815c6c34b240088d46d3b76292b28a', '47049906a5e24c3ea5866706e8c6381d', '5d3e9ade49a34e66bce4f54c6ae57d33', 1),
  ('b7815c6c34b240088d46d3b76292b28a', 'c2c516b57a4146a6b89e4e5a766a40db', '5d3e9ade49a34e66bce4f54c6ae57d33', 1);

  -- declare sections as switches and breakers
INSERT INTO `assets`.`switches`
  (`id_section`, `id_model`, `action`, `normal_state`, `switch_type`) VALUES 

  -- Barcelona 400
  ('cef04ee0ad484a72ac201af5e93c7100', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 1, 0),
  ('d9cd73d3d51f4dd09db8b19560ee7259', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 1, 0),
  ('6b5092e9785c427fa7c991ef41a48db4', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 1, 0),
  ('16390f917ef34e3180f77ff893965dfe', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 1, 1),

  -- Madrid 400
  ('581b56498a2f4024beeabca6ac4432c2', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 1, 0),
  ('fdc0226e0e684b4584a4a8820cca5625', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 1, 0),
  ('a9c5efa5ea6a409da970f7b353267a7b', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 1, 0),
  ('3ef1159c62824b549524d5223e90bbb5', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 1, 1),

  -- Gijón 400
  ('35ee1e15e6a442dcbb4c0ae2498ce0bc', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 1, 0),
  ('a025d36698f442a5bcf84ff50bc3917a', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 1, 0),
  ('0d3532b8343546fe800ef430a1ab4b24', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 1, 0),
  ('31494c055e3442c6a26c1ba104065066', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 1, 1),

  -- Pamplona 400
  ('c9eb6a54a34f4ebd814e59a75bb9382a', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 1, 0),
  ('004060a60cde456fa209cea8ebe7f397', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 1, 0),
  ('ce883ba0c263413ea8e6f54e38896736', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 1, 0),
  ('efe3f1a30ada4982a3ad4d5cec8f0f66', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 1, 0),
  ('83f83c6f00c7492b96f2a113b6006d5f', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 1, 0),
  ('55fed787a0794f218214e275802669b6', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 1, 0),
  ('505c919c6a75462687378fbdbd1838c0', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 1, 0),
  ('376503daba7f4dcebdfc513608c16790', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 1, 0),
  ('3a61ff554537472484bea0e76596f9c1', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 1, 0),
  ('2510d3e818634e79869d65826a8eeb5d', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 1, 0),
  ('8970b0fcf8484d5e91dcdddff76116c8', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 1, 0),
  ('bfe97e21956d4329919527eaa685caec', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 1, 1),
  ('fcea4ee6652b4172b6d698e5369e2eb2', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 1, 1),
  ('47049906a5e24c3ea5866706e8c6381d', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 1, 1),
  ('c2c516b57a4146a6b89e4e5a766a40db', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 1, 1);

  
-- declare power lines
INSERT INTO `assets`.`power_lines`
  (`id_line`, `id_model`, `action`, `name`, `online_date`, `offline_date`) VALUES 
  ('326cf68c6afa4e9e92226bb98b3a1a9f', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 'PL10', '2021-11-03', NULL),
  ('8e1c3ed53e544661974cf0fd10648498', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 'PL11', '2021-11-03', NULL),
  ('2ad97ecfc70c492a84bbb435d70af5e7', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, 'PL12', '2021-11-03', NULL);


-- declare sections with power lines and assign electrical parameters
INSERT INTO `assets`.`ac_line_sections`
  (`id_section`, `id_model`, `action`, `id_line`, `r0`, `x0`, `b0`, `r1`, `x1`, `b1`, `r2`, `x2`, `b2`, `length`, `sequential`) VALUES 
  ('423f2e5c80824c3f9840b88070ac086b', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, '326cf68c6afa4e9e92226bb98b3a1a9f', 0.0039, 0.034, 0, 0, 0, 0, 0, 0, 0, 16, 1), -- L10
  ('0c5f91a58dde4707b0360c3b7c25df6b', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, '8e1c3ed53e544661974cf0fd10648498', 0.0036, 0.032, 0, 0, 0, 0, 0, 0, 0, 16, 1), -- L11
  ('80ef15b3428c4729b27d4efcdc081963', '5d3e9ade49a34e66bce4f54c6ae57d33', 1, '2ad97ecfc70c492a84bbb435d70af5e7', 0.0029, 0.031, 0, 0, 0, 0, 0, 0, 0, 16, 1); -- L12



-- ----
--  Split busbars in Gijon 400 voltage level (crear binudo) 
-- ----


-- New model
INSERT INTO `assets`.`models`
  (`id_model`, `name`, `valid_date`, `creation_date`, `created_by`, `comments`) VALUES
  ('e6860558acac4f88a4df332e192ca3cf', 'Red G', '2026-01-01','2021-11-03','admin','Gijón 400 convertido a binudo');

-- Assign model parent
INSERT INTO `models_models`
  (`id_model_parent`, `id_model_child`) VALUES
  ('5d3e9ade49a34e66bce4f54c6ae57d33','e6860558acac4f88a4df332e192ca3cf');

-- New bus bars
INSERT INTO `assets`.`buses`
  (`id_bus`, `id_model`, `action`, `name`, `x`, `y`, `rotation`, `is_dc`, `secondary_id`, `sequential`, `id_bdi`) VALUES 
  
  -- Gijón 400
  ('6ff8bc4e3033493a86eae0c325e6c07f', 'e6860558acac4f88a4df332e192ca3cf', 1, 'b13', 0, 0, 0, 0, Null, 1, Null),
  ('f4245131fbe34408b506881d875b4e34', 'e6860558acac4f88a4df332e192ca3cf', 1, 'b14', 0, 0, 0, 0, Null, 1, Null);

-- New connectivity nodes
INSERT INTO `assets`.`connectivity_nodes`
  (`id_connectivity_node`, `id_model`, `action`, `name`, `x`, `y`) VALUES 

  -- Gijón 400 
  ('d553b69613a34e5c9d7d4de15c5dc84a', 'e6860558acac4f88a4df332e192ca3cf', 1, 'c169', 0, 0),
  ('7dc974644e944ec9acb8cef0cd0899e5', 'e6860558acac4f88a4df332e192ca3cf', 1, 'c170', 0, 0),
  ('e07ef6030c1b4313ab28ff16b7eb633f', 'e6860558acac4f88a4df332e192ca3cf', 1, 'c171', 0, 0),
  ('05a4174310db45fa9bc9b3dee8934aae', 'e6860558acac4f88a4df332e192ca3cf', 1, 'c172', 0, 0),
  ('5eb7ab01a3854c3db1e23b4125ed81d4', 'e6860558acac4f88a4df332e192ca3cf', 1, 'c173', 0, 0),
  ('61ebc73bcc1d43eeb72f43e8da5b9e13', 'e6860558acac4f88a4df332e192ca3cf', 1, 'c174', 0, 0),
  ('f36a2aed57244bcc8b0d5d211a9c3c2c', 'e6860558acac4f88a4df332e192ca3cf', 1, 'c175', 0, 0),
  ('0fd422980b704254b076c610d66ec90b', 'e6860558acac4f88a4df332e192ca3cf', 1, 'c176', 0, 0);

  
-- declare connectivity nodes in voltage_level
INSERT INTO `assets`.`connectivity_nodes_voltage_levels`
  (`id_connectivity_node`, `id_voltage_level`, `id_model`, `action`) VALUES

  -- Gijón 400 
  ('d553b69613a34e5c9d7d4de15c5dc84a', '48ce7abce09c4568bc28d86f7b20c486', 'e6860558acac4f88a4df332e192ca3cf', 1),
  ('7dc974644e944ec9acb8cef0cd0899e5', '48ce7abce09c4568bc28d86f7b20c486', 'e6860558acac4f88a4df332e192ca3cf', 1),
  ('e07ef6030c1b4313ab28ff16b7eb633f', '48ce7abce09c4568bc28d86f7b20c486', 'e6860558acac4f88a4df332e192ca3cf', 1),
  ('05a4174310db45fa9bc9b3dee8934aae', '48ce7abce09c4568bc28d86f7b20c486', 'e6860558acac4f88a4df332e192ca3cf', 1),
  ('5eb7ab01a3854c3db1e23b4125ed81d4', '48ce7abce09c4568bc28d86f7b20c486', 'e6860558acac4f88a4df332e192ca3cf', 1),
  ('61ebc73bcc1d43eeb72f43e8da5b9e13', '48ce7abce09c4568bc28d86f7b20c486', 'e6860558acac4f88a4df332e192ca3cf', 1),
  ('f36a2aed57244bcc8b0d5d211a9c3c2c', '48ce7abce09c4568bc28d86f7b20c486', 'e6860558acac4f88a4df332e192ca3cf', 1),
  ('0fd422980b704254b076c610d66ec90b', '48ce7abce09c4568bc28d86f7b20c486', 'e6860558acac4f88a4df332e192ca3cf', 1);
  
-- add new sections
INSERT INTO `assets`.`sections`
  (`id_section`, `id_model`, `action`, `id_connectivity_node_1`, `id_connectivity_node_2`, `active`, `name`, `rating`, `id_rating_profile`, `contingency_factor1`, `contingency_factor2`, `contingency_factor3`, `online_date`, `offline_date`, `mttf`, `mttr`, `secondary_id`, `sequential`) VALUES
  
  -- Gijón 400
  ('f85be45d2605477185b236a0c95f1673', 'e6860558acac4f88a4df332e192ca3cf', 1, 'd553b69613a34e5c9d7d4de15c5dc84a', '7dc974644e944ec9acb8cef0cd0899e5', 1, 's97', 9999, NULL, 1, 1, 1, '2021-11-03', NULL, NULL, NULL, NULL, 1),  
  ('d6cbeaccc96a4a8ca7ce357f5479d309', 'e6860558acac4f88a4df332e192ca3cf', 1, 'e07ef6030c1b4313ab28ff16b7eb633f', '05a4174310db45fa9bc9b3dee8934aae', 1, 's98', 9999, NULL, 1, 1, 1, '2021-11-03', NULL, NULL, NULL, NULL, 1),  
  ('f2357afe268e487aafda7cca62e907eb', 'e6860558acac4f88a4df332e192ca3cf', 1, '7dc974644e944ec9acb8cef0cd0899e5', 'e07ef6030c1b4313ab28ff16b7eb633f', 1, 'i52', 9999, NULL, 1, 1, 1, '2021-11-03', NULL, NULL, NULL, NULL, 1),    
  ('51f278133c154e798ab86363ca5d8885', 'e6860558acac4f88a4df332e192ca3cf', 1, '5eb7ab01a3854c3db1e23b4125ed81d4', '61ebc73bcc1d43eeb72f43e8da5b9e13', 1, 's99', 9999, NULL, 1, 1, 1, '2021-11-03', NULL, NULL, NULL, NULL, 1),  
  ('474ffefd3320437a97b29a07ef0e80d7', 'e6860558acac4f88a4df332e192ca3cf', 1, 'f36a2aed57244bcc8b0d5d211a9c3c2c', '0fd422980b704254b076c610d66ec90b', 1, 's100', 9999, NULL, 1, 1, 1, '2021-11-03', NULL, NULL, NULL, NULL, 1),  
  ('d63fbce3cce74d968bc864995d719fcc', 'e6860558acac4f88a4df332e192ca3cf', 1, '61ebc73bcc1d43eeb72f43e8da5b9e13', 'f36a2aed57244bcc8b0d5d211a9c3c2c', 1, 'i53', 9999, NULL, 1, 1, 1, '2021-11-03', NULL, NULL, NULL, NULL, 1);  

--  New positions 
INSERT INTO `assets`.`positions`
  (`id_position`, `id_model`, `action`, `id_position_type`, `online_date`, `offline_date`) VALUES 
  
  -- Gijón 400
  ('2250b381da4349528d3ae2f774f9c43a', 'e6860558acac4f88a4df332e192ca3cf', 1, 2, '2021-11-03', NULL),
  ('064e9e584a524938be0f7da95f6daa2a', 'e6860558acac4f88a4df332e192ca3cf', 1, 2, '2021-11-03', NULL);


-- Assign sections to positions
  INSERT INTO `assets`.`positions_sections`
  (`id_position`, `id_section`, `id_model`, `action`) VALUES 

  -- Gijón 400
  ('2250b381da4349528d3ae2f774f9c43a', 'f85be45d2605477185b236a0c95f1673', 'e6860558acac4f88a4df332e192ca3cf', 1),
  ('2250b381da4349528d3ae2f774f9c43a', 'd6cbeaccc96a4a8ca7ce357f5479d309', 'e6860558acac4f88a4df332e192ca3cf', 1),
  ('2250b381da4349528d3ae2f774f9c43a', 'f2357afe268e487aafda7cca62e907eb', 'e6860558acac4f88a4df332e192ca3cf', 1),
  ('064e9e584a524938be0f7da95f6daa2a', '51f278133c154e798ab86363ca5d8885', 'e6860558acac4f88a4df332e192ca3cf', 1),
  ('064e9e584a524938be0f7da95f6daa2a', '474ffefd3320437a97b29a07ef0e80d7', 'e6860558acac4f88a4df332e192ca3cf', 1),
  ('064e9e584a524938be0f7da95f6daa2a', 'd63fbce3cce74d968bc864995d719fcc', 'e6860558acac4f88a4df332e192ca3cf', 1);


-- declare sections as switches and breakers
  INSERT INTO `assets`.`switches`
  (`id_section`, `id_model`, `action`, `normal_state`, `switch_type`) VALUES 

  -- Gijón 400
  ('f85be45d2605477185b236a0c95f1673', 'e6860558acac4f88a4df332e192ca3cf', 1, 1, 0),
  ('d6cbeaccc96a4a8ca7ce357f5479d309', 'e6860558acac4f88a4df332e192ca3cf', 1, 1, 0),
  ('f2357afe268e487aafda7cca62e907eb', 'e6860558acac4f88a4df332e192ca3cf', 1, 1, 1),
  ('51f278133c154e798ab86363ca5d8885', 'e6860558acac4f88a4df332e192ca3cf', 1, 1, 0),
  ('474ffefd3320437a97b29a07ef0e80d7', 'e6860558acac4f88a4df332e192ca3cf', 1, 1, 0),
  ('d63fbce3cce74d968bc864995d719fcc', 'e6860558acac4f88a4df332e192ca3cf', 1, 1, 1);

-- declare witch connectiviy nodes are connected to bus bars
  INSERT INTO `assets`.`buses_connectivity_nodes`
  (`id_bus`, `id_connectivity_node`, `id_model`, `action`) VALUES 

  -- Gijón 400 (add)
  ('0cd72bbb1a66449891630a0ad447b846', 'd553b69613a34e5c9d7d4de15c5dc84a', 'e6860558acac4f88a4df332e192ca3cf', 1), -- c169
  ('6ff8bc4e3033493a86eae0c325e6c07f', '05a4174310db45fa9bc9b3dee8934aae', 'e6860558acac4f88a4df332e192ca3cf', 1), -- c172
  ('f939e7bcbe4c4df098e897806dab4f87', '5eb7ab01a3854c3db1e23b4125ed81d4', 'e6860558acac4f88a4df332e192ca3cf', 1), -- c173
  ('f4245131fbe34408b506881d875b4e34', '0fd422980b704254b076c610d66ec90b', 'e6860558acac4f88a4df332e192ca3cf', 1), -- c176

  -- Gijón 400 (modify)
  ('f4245131fbe34408b506881d875b4e34', 'a936939693be4d8ca7213914fab7cb8f', 'e6860558acac4f88a4df332e192ca3cf', 0), -- c90
  ('f4245131fbe34408b506881d875b4e34', 'da551acfdee04496b9b36158fa1d8e8e', 'e6860558acac4f88a4df332e192ca3cf', 0), -- c105
  ('6ff8bc4e3033493a86eae0c325e6c07f', 'f713781117ae48d7b28160cbeaf0543d', 'e6860558acac4f88a4df332e192ca3cf', 0), -- c106
  ('f4245131fbe34408b506881d875b4e34', '4c455a24e108417dae2faad169680601', 'e6860558acac4f88a4df332e192ca3cf', 0), -- c142
  ('6ff8bc4e3033493a86eae0c325e6c07f', 'a47ad85768f9492482efb1bd1419c0ad', 'e6860558acac4f88a4df332e192ca3cf', 0); -- c143
  
  -- -- Gijón 400 (delete)
  -- ('f939e7bcbe4c4df098e897806dab4f87', 'a936939693be4d8ca7213914fab7cb8f', 'e6860558acac4f88a4df332e192ca3cf', -1), -- c90
  -- ('f939e7bcbe4c4df098e897806dab4f87', 'da551acfdee04496b9b36158fa1d8e8e', 'e6860558acac4f88a4df332e192ca3cf', -1), -- c105
  -- ('0cd72bbb1a66449891630a0ad447b846', 'f713781117ae48d7b28160cbeaf0543d', 'e6860558acac4f88a4df332e192ca3cf', -1), -- c106
  -- ('f939e7bcbe4c4df098e897806dab4f87', '4c455a24e108417dae2faad169680601', 'e6860558acac4f88a4df332e192ca3cf', -1), -- c142
  -- ('0cd72bbb1a66449891630a0ad447b846', 'a47ad85768f9492482efb1bd1419c0ad', 'e6860558acac4f88a4df332e192ca3cf', -1); -- c143

