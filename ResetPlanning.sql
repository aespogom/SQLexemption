DROP DATABASE IF EXISTS `planning`;
CREATE DATABASE  IF NOT EXISTS `planning` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `planning`;
-- MySQL dump 10.13  Distrib 8.0.25, for Win64 (x86_64)
--
-- Host: 217.182.172.82    Database: planning
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
-- Table structure for table `releases`
--
DROP TABLE IF EXISTS `releases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `releases` (
  `id_release` varchar(32) NOT NULL,
  `name` varchar(256) DEFAULT NULL,
  `valid_date` date DEFAULT NULL,
  `creation_date` date DEFAULT NULL,
  `created_by` varchar(256) DEFAULT NULL,
  `comments` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`id_release`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;



--
-- Table structure for table `energy_studies`
--
DROP TABLE IF EXISTS `energy_studies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `energy_studies` (
  `id_energy_study` varchar(32) NOT NULL,
  `id_release` varchar(32) NOT NULL,
  `action` tinyint(4) NOT NULL DEFAULT 0,
  `necessary_power` double DEFAULT 0,
  `redispatched_energy` double DEFAULT 0,
  `renewables_energy` double DEFAULT 0,
  `losses_energy` double DEFAULT 0,
  `unserved_energy_base` double DEFAULT 0,
  `unserved_energy_contingency` double DEFAULT 0,
  `co2_emissions` double DEFAULT 0,
  `cost_variable_energy` double DEFAULT 0,
  `cost_variable_resdispatch` double DEFAULT 0,
  `cost_marginal_average` double DEFAULT 0,
  `cost_congestion_redispatch` double DEFAULT 0,
  `cost_market_redispatch` double DEFAULT 0,
  `cost_renewable_energy` double DEFAULT 0,
  `cost_losses_energy` double DEFAULT 0,
  `comments` varchar(256) DEFAULT 0,
  PRIMARY KEY (`id_energy_study`, `id_release`),
  CONSTRAINT `fk_energy_studies_releases` FOREIGN KEY (`id_release`) REFERENCES `releases` (`id_release`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `study_drivers`
--
DROP TABLE IF EXISTS `decition_drivers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `decition_drivers` (
  `id_decition_driver` varchar(32) NOT NULL,
  `id_release` varchar(32) NOT NULL,
  `action` tinyint(4) NOT NULL DEFAULT 0,
  `national_plan_contribution` tinyint(4) NOT NULL DEFAULT 0,
  `renewables_maximization` tinyint(4) NOT NULL DEFAULT 0,
  `renewables_resources` tinyint(4) NOT NULL DEFAULT 0,
  `security_supply` tinyint(4) NOT NULL DEFAULT 0,
  `environment_respect` tinyint(4) NOT NULL DEFAULT 0,
  `congestion_avoidment` tinyint(4) NOT NULL DEFAULT 0,
  `energy_efficiency` tinyint(4) NOT NULL DEFAULT 0,
  `current_network_use` tinyint(4) NOT NULL DEFAULT 0,
  `losses_avoidment` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_decition_driver`, `id_release`),
  CONSTRAINT `fk_decition_drivers_releases` FOREIGN KEY (`id_release`) REFERENCES `releases` (`id_release`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `study_drivers`
--
DROP TABLE IF EXISTS `actuation_impacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `actuation_impacts` (
  `id_actuation_impact` varchar(32) NOT NULL,
  `id_release` varchar(32) NOT NULL,
  `action` tinyint(4) NOT NULL DEFAULT 0,
  `social_impact` tinyint(4) NOT NULL DEFAULT 0,
  `environment_inpact` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_actuation_impact`, `id_release`),
  CONSTRAINT `fk_actuation_impacts_releases` FOREIGN KEY (`id_release`) REFERENCES `releases` (`id_release`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;



--
-- Table structure for table `investment_inputs`
--
DROP TABLE IF EXISTS `investment_profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `investment_profiles` (
  `id_investment_profile` varchar(32) NOT NULL,
  `id_release` varchar(32) NOT NULL,
  `action` tinyint(4) NOT NULL DEFAULT 0,
  `cost_unserved_energy` double NOT NULL DEFAULT 0,
  `cost_generation` double NOT NULL DEFAULT 0,
  `cost_om_generation`double NOT NULL DEFAULT 0,
  `retribution_years_equipment` double NOT NULL DEFAULT 0,
  `retribution_years_generation` double NOT NULL DEFAULT 0,
  `residual_value` double NOT NULL DEFAULT 0,
  `discount_rate` double NOT NULL DEFAULT 0,
  `transport_rate` double NOT NULL DEFAULT 0,
  `generation_rate` double NOT NULL DEFAULT 0,
  `inflaction_rate` double NOT NULL DEFAULT 0,
  `standard_updater` double NOT NULL DEFAULT 0,
  `failure_probability` double NOT NULL DEFAULT 0,
  `years_delay` double NOT NULL DEFAULT 0,
  `compute_unserved_energy` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id_investment_profile`, `id_release`),
  CONSTRAINT `fk_investment_profiles_releases` FOREIGN KEY (`id_release`) REFERENCES `releases` (`id_release`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `investment_inputs`
--
DROP TABLE IF EXISTS `project_costs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_costs` (
  `id_project_cost` varchar(32) NOT NULL,
  `id_release` varchar(32) NOT NULL,
  `action` tinyint(4) NOT NULL DEFAULT 0,
  `capex` double NOT NULL DEFAULT 0,
  `opex` double NOT NULL DEFAULT 0,
  `delayed_capex` double NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_project_cost`, `id_release`),
  CONSTRAINT `fk_project_costs_releases` FOREIGN KEY (`id_release`) REFERENCES `releases` (`id_release`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `investment_inputs`
--
DROP TABLE IF EXISTS `publication_datasheets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `data_shpublication_datasheetseets` (
  `id_publication_datasheet` varchar(32) NOT NULL,
  `id_release` varchar(32) NOT NULL,
  `action` tinyint(4) NOT NULL DEFAULT 0,
  `chapter` varchar(32) DEFAULT NULL,
  `title` varchar(32) DEFAULT NULL,
  `code` varchar(12) DEFAULT NULL,
  `motivation_code` varchar(12) DEFAULT NULL,
  `description` varchar(128) DEFAULT NULL,
  `extended_description` varchar(256) DEFAULT NULL,
  `motivation` varchar(256) DEFAULT NULL,
  `alvernatives` varchar(256) DEFAULT NULL,
  `project_comments` varchar(256) DEFAULT NULL,
  `inversion_comments` varchar(256) DEFAULT NULL,
  `capex_comments` varchar(256) DEFAULT NULL,
  `physical_units_comments` varchar(256) DEFAULT NULL,
  `target_date` varchar(12) DEFAULT NULL,
  `european_dimension` tinyint(4) DEFAULT 0,
  PRIMARY KEY (`id_publication_datasheet`, `id_release`),
  CONSTRAINT `fk_publication_datasheets_releases` FOREIGN KEY (`id_release`) REFERENCES `releases` (`id_release`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `investment_inputs`
--
DROP TABLE IF EXISTS `actuations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `actuations` (
  `id_actuation` varchar(32) NOT NULL,
  `id_release` varchar(32) NOT NULL,
  `action` tinyint(4) NOT NULL DEFAULT 0,
  `id_decition_driver` varchar(32) NOT NULL,
  `id_actuation_impact` varchar(32) NOT NULL,
  `id_energy_study_reference` varchar(32) NOT NULL,
  `id_energy_study_target` varchar(32) NOT NULL,
  `id_investment_profile` varchar(32) NOT NULL,
  PRIMARY KEY (`id_actuation`, `id_release`),
  CONSTRAINT `fk_actuations_releases` FOREIGN KEY (`id_release`) REFERENCES `releases` (`id_release`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_actuations_decition_drivers` FOREIGN KEY (`id_decition_driver`) REFERENCES `decition_drivers` (`id_decition_driver`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_actuations_actuation_impacts` FOREIGN KEY (`id_actuation_impact`) REFERENCES `actuation_impacts` (`id_actuation_impact`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_actuations_energy_studies_reference` FOREIGN KEY (`id_energy_study_reference`) REFERENCES `energy_studies` (`id_energy_study`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_actuations_energy_studies_target` FOREIGN KEY (`id_energy_study_target`) REFERENCES `energy_studies` (`id_energy_study`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_actuations_investment_profiles` FOREIGN KEY (`id_investment_profile`) REFERENCES `investment_profiles` (`id_investment_profile`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

