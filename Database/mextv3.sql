/*
SQLyog Ultimate v12.5.1 (32 bit)
MySQL - 11.0.4-MariaDB : Database - mextv3
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`mextv3` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;

USE `mextv3`;

/*Table structure for table `classes` */

DROP TABLE IF EXISTS `classes`;

CREATE TABLE `classes` (
  `ItemID` int(11) unsigned NOT NULL,
  `Category` char(2) NOT NULL,
  `Description` text NOT NULL,
  `ManaRegenerationMethods` text NOT NULL,
  `StatsDescription` text NOT NULL,
  PRIMARY KEY (`ItemID`),
  CONSTRAINT `fk_classes_itemid` FOREIGN KEY (`ItemID`) REFERENCES `items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

/*Data for the table `classes` */

insert  into `classes`(`ItemID`,`Category`,`Description`,`ManaRegenerationMethods`,`StatsDescription`) values 
(2,'M1','Alpha Pirate are quick-moving, deadly fighters. They prey on any weakness in their opponent, while using poisons and evasive footwork to their advantage.','Alpha Pirate gain mana when they:\r\n,-Strike an enemy in combat (more effective on crits)\r\n,-Dodge any attack (restores HP as well)','Alpha Pirate favor Dexterity and Strength');

/*Table structure for table `enhancements` */

DROP TABLE IF EXISTS `enhancements`;

CREATE TABLE `enhancements` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(32) NOT NULL,
  `PatternID` int(11) unsigned NOT NULL DEFAULT 1,
  `Rarity` tinyint(3) unsigned NOT NULL,
  `DPS` smallint(4) unsigned NOT NULL,
  `Level` tinyint(3) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `fk_enhancements_patternid` (`PatternID`),
  CONSTRAINT `fk_enhancements_patternid` FOREIGN KEY (`PatternID`) REFERENCES `enhancements_patterns` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1958 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

/*Data for the table `enhancements` */

insert  into `enhancements`(`id`,`Name`,`PatternID`,`Rarity`,`DPS`,`Level`) values 
(1957,'Adventurer',1,1,63,1);

/*Table structure for table `enhancements_patterns` */

DROP TABLE IF EXISTS `enhancements_patterns`;

CREATE TABLE `enhancements_patterns` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(32) NOT NULL,
  `Desc` varchar(4) NOT NULL,
  `Wisdom` tinyint(2) unsigned NOT NULL,
  `Strength` tinyint(2) unsigned NOT NULL,
  `Luck` tinyint(2) unsigned NOT NULL,
  `Dexterity` tinyint(2) unsigned NOT NULL,
  `Endurance` tinyint(2) unsigned NOT NULL,
  `Intelligence` tinyint(2) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

/*Data for the table `enhancements_patterns` */

insert  into `enhancements_patterns`(`id`,`Name`,`Desc`,`Wisdom`,`Strength`,`Luck`,`Dexterity`,`Endurance`,`Intelligence`) values 
(1,'Adventurer','none',16,16,0,16,18,16);

/*Table structure for table `factions` */

DROP TABLE IF EXISTS `factions`;

CREATE TABLE `factions` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

/*Data for the table `factions` */

insert  into `factions`(`id`,`Name`) values 
(1,'None');

/*Table structure for table `guilds` */

DROP TABLE IF EXISTS `guilds`;

CREATE TABLE `guilds` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(64) NOT NULL,
  `MessageOfTheDay` varchar(512) NOT NULL,
  `MaxMembers` tinyint(3) unsigned NOT NULL DEFAULT 15,
  `HallSize` tinyint(2) unsigned NOT NULL DEFAULT 1,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

/*Data for the table `guilds` */

/*Table structure for table `guilds_halls` */

DROP TABLE IF EXISTS `guilds_halls`;

CREATE TABLE `guilds_halls` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `GuildID` int(11) unsigned NOT NULL,
  `Linkage` varchar(64) NOT NULL,
  `Cell` varchar(16) NOT NULL,
  `X` double(7,2) NOT NULL DEFAULT 0.00,
  `Y` double(7,2) NOT NULL DEFAULT 0.00,
  `Interior` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_guildhalls_guildid` (`GuildID`),
  CONSTRAINT `fk_guildhalls_guildid` FOREIGN KEY (`GuildID`) REFERENCES `guilds` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

/*Data for the table `guilds_halls` */

/*Table structure for table `guilds_halls_buildings` */

DROP TABLE IF EXISTS `guilds_halls_buildings`;

CREATE TABLE `guilds_halls_buildings` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `HallID` int(11) unsigned NOT NULL,
  `ItemID` int(11) unsigned NOT NULL,
  `Slot` tinyint(2) NOT NULL DEFAULT 1,
  `Size` tinyint(2) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `fk_hallbuidling_hallid` (`HallID`),
  KEY `fk_hallbuilding_itemid` (`ItemID`),
  CONSTRAINT `fk_hallbuidling_hallid` FOREIGN KEY (`HallID`) REFERENCES `guilds_halls` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_hallbuilding_itemid` FOREIGN KEY (`ItemID`) REFERENCES `guilds_inventory` (`ItemID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

/*Data for the table `guilds_halls_buildings` */

/*Table structure for table `guilds_halls_connections` */

DROP TABLE IF EXISTS `guilds_halls_connections`;

CREATE TABLE `guilds_halls_connections` (
  `HallID` int(11) unsigned NOT NULL,
  `Pad` varchar(16) NOT NULL,
  `Cell` varchar(16) NOT NULL,
  `PadPosition` varchar(16) NOT NULL,
  KEY `fk_guildhallcon_hallid` (`HallID`),
  CONSTRAINT `fk_guildhallcon_hallid` FOREIGN KEY (`HallID`) REFERENCES `guilds_halls` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

/*Data for the table `guilds_halls_connections` */

/*Table structure for table `guilds_inventory` */

DROP TABLE IF EXISTS `guilds_inventory`;

CREATE TABLE `guilds_inventory` (
  `GuildID` int(11) unsigned NOT NULL,
  `ItemID` int(11) unsigned NOT NULL,
  `UserID` int(11) unsigned NOT NULL,
  PRIMARY KEY (`GuildID`,`ItemID`,`UserID`),
  KEY `fk_guildinv_itemid` (`ItemID`),
  KEY `fk_guildinv_userid` (`UserID`),
  CONSTRAINT `fk_guildinv_guildid` FOREIGN KEY (`GuildID`) REFERENCES `guilds` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_guildinv_itemid` FOREIGN KEY (`ItemID`) REFERENCES `items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_guildinv_userid` FOREIGN KEY (`UserID`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

/*Data for the table `guilds_inventory` */

/*Table structure for table `hairs` */

DROP TABLE IF EXISTS `hairs`;

CREATE TABLE `hairs` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Gender` char(1) NOT NULL,
  `Name` varchar(16) NOT NULL,
  `File` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=84 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

/*Data for the table `hairs` */

insert  into `hairs`(`id`,`Gender`,`Name`,`File`) values 
(52,'M','Default','hair/M/Default.swf'),
(83,'F','Bangs2Long','hair/F/Bangs2Long.swf');

/*Table structure for table `hairs_shops` */

DROP TABLE IF EXISTS `hairs_shops`;

CREATE TABLE `hairs_shops` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

/*Data for the table `hairs_shops` */

/*Table structure for table `hairs_shops_items` */

DROP TABLE IF EXISTS `hairs_shops_items`;

CREATE TABLE `hairs_shops_items` (
  `Gender` char(1) NOT NULL DEFAULT 'M',
  `ShopID` int(11) unsigned NOT NULL,
  `HairID` int(11) unsigned NOT NULL,
  PRIMARY KEY (`Gender`,`ShopID`,`HairID`),
  KEY `fk_hairshopitems_hairid` (`HairID`),
  KEY `fk_hairshopitems_shopid` (`ShopID`),
  CONSTRAINT `fk_hairshopitems_hairid` FOREIGN KEY (`HairID`) REFERENCES `hairs` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_hairshopitems_shopid` FOREIGN KEY (`ShopID`) REFERENCES `hairs_shops` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

/*Data for the table `hairs_shops_items` */

/*Table structure for table `items` */

DROP TABLE IF EXISTS `items`;

CREATE TABLE `items` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(60) NOT NULL,
  `Description` text NOT NULL,
  `Type` varchar(16) NOT NULL,
  `Element` varchar(16) NOT NULL DEFAULT 'None',
  `File` varchar(64) NOT NULL,
  `Link` varchar(64) NOT NULL,
  `Icon` varchar(16) NOT NULL,
  `Equipment` varchar(6) NOT NULL,
  `Level` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `DPS` smallint(6) unsigned NOT NULL DEFAULT 100,
  `Range` smallint(6) unsigned NOT NULL DEFAULT 100,
  `Rarity` tinyint(3) unsigned NOT NULL DEFAULT 10,
  `Cost` int(11) unsigned NOT NULL DEFAULT 0,
  `Quantity` smallint(4) unsigned NOT NULL DEFAULT 1,
  `Stack` smallint(4) unsigned NOT NULL DEFAULT 1,
  `Coins` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `Temporary` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `Upgrade` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `Staff` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `EnhID` int(11) unsigned DEFAULT NULL,
  `FactionID` int(11) unsigned DEFAULT NULL,
  `ReqReputation` mediumint(6) unsigned NOT NULL DEFAULT 0,
  `ReqClassID` int(11) unsigned DEFAULT NULL,
  `ReqClassPoints` mediumint(6) unsigned NOT NULL DEFAULT 0,
  `ReqQuests` varchar(64) NOT NULL DEFAULT '',
  `QuestStringIndex` tinyint(3) NOT NULL DEFAULT -1,
  `QuestStringValue` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `Meta` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_items_enhid` (`EnhID`),
  KEY `fk_items_factionid` (`FactionID`),
  KEY `fk_items_reqclassid` (`ReqClassID`),
  CONSTRAINT `fk_items_enhid` FOREIGN KEY (`EnhID`) REFERENCES `enhancements` (`id`),
  CONSTRAINT `fk_items_factionid` FOREIGN KEY (`FactionID`) REFERENCES `factions` (`id`),
  CONSTRAINT `fk_items_reqclassid` FOREIGN KEY (`ReqClassID`) REFERENCES `classes` (`ItemID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

/*Data for the table `items` */

insert  into `items`(`id`,`Name`,`Description`,`Type`,`Element`,`File`,`Link`,`Icon`,`Equipment`,`Level`,`DPS`,`Range`,`Rarity`,`Cost`,`Quantity`,`Stack`,`Coins`,`Temporary`,`Upgrade`,`Staff`,`EnhID`,`FactionID`,`ReqReputation`,`ReqClassID`,`ReqClassPoints`,`ReqQuests`,`QuestStringIndex`,`QuestStringValue`,`Meta`) values 
(1,'Onyx Star Sword','','Sword','None','items/swords/starswordblackorig.swf','starswordblackorig','iwsword','Weapon',1,100,100,75,0,1,1,0,0,0,0,1957,1,0,NULL,0,'',-1,0,NULL),
(2,'Classic Alpha Pirate','','Classes','None','pirate2_skin.swf','Pirate2','iiclass','ar',1,100,100,10,0,1,1,0,0,0,0,1957,1,0,NULL,0,'',-1,0,NULL),
(3,'Ranger Hat','','Helm','None','items/helms/rangerhat.swf','RangerHat','iihelm','he',1,100,100,10,0,1,1,0,0,0,0,1957,1,0,NULL,0,'',-1,0,NULL),
(4,'Unarmed','','Sword','None','items/maces/Blank-11Jun11.swf','Unarmed','iwmace','Weapon',1,100,100,10,0,1,1,0,0,0,0,1957,1,0,NULL,0,'',-1,0,NULL),
(5,'Item','','Item','None','','','iibag','None',1,100,100,10,100,1,100,0,0,0,0,1957,1,0,NULL,0,'',-1,0,NULL);

/*Table structure for table `items_requirements` */

DROP TABLE IF EXISTS `items_requirements`;

CREATE TABLE `items_requirements` (
  `ItemID` int(11) unsigned NOT NULL,
  `ReqItemID` int(11) unsigned NOT NULL,
  `Quantity` smallint(6) unsigned NOT NULL,
  PRIMARY KEY (`ItemID`,`ReqItemID`),
  KEY `fk_itemrequirement_reqitemid` (`ReqItemID`),
  CONSTRAINT `fk_itemrequirement_itemid` FOREIGN KEY (`ItemID`) REFERENCES `items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_itemrequirement_reqitemid` FOREIGN KEY (`ReqItemID`) REFERENCES `items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

/*Data for the table `items_requirements` */

insert  into `items_requirements`(`ItemID`,`ReqItemID`,`Quantity`) values 
(3,5,2),
(5,5,5);

/*Table structure for table `maps` */

DROP TABLE IF EXISTS `maps`;

CREATE TABLE `maps` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(32) NOT NULL,
  `File` varchar(128) NOT NULL,
  `MaxPlayers` tinyint(3) unsigned NOT NULL DEFAULT 6,
  `ReqLevel` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `Upgrade` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `Staff` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `PvP` tinyint(1) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

/*Data for the table `maps` */

insert  into `maps`(`id`,`Name`,`File`,`MaxPlayers`,`ReqLevel`,`Upgrade`,`Staff`,`PvP`) values 
(1,'limbo','town-limbo.swf',6,0,0,0,0),
(2,'faroff','Battleon/town-Battleon-27Dec21.swf',6,0,0,0,0),
(3,'newbie','Intro/town-Newbie-6Jan12.swf',6,0,0,0,0);

/*Table structure for table `maps_cells` */

DROP TABLE IF EXISTS `maps_cells`;

CREATE TABLE `maps_cells` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `MapID` int(11) unsigned NOT NULL,
  `Frame` varchar(16) NOT NULL,
  `Pad` varchar(16) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_MAPID` (`MapID`),
  CONSTRAINT `FK_MAPID` FOREIGN KEY (`MapID`) REFERENCES `maps` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

/*Data for the table `maps_cells` */

/*Table structure for table `maps_items` */

DROP TABLE IF EXISTS `maps_items`;

CREATE TABLE `maps_items` (
  `MapID` int(11) unsigned NOT NULL,
  `ItemID` int(11) unsigned NOT NULL,
  PRIMARY KEY (`MapID`,`ItemID`),
  KEY `fk_mapitem_itemid` (`ItemID`),
  CONSTRAINT `fk_mapitem_itemid` FOREIGN KEY (`ItemID`) REFERENCES `items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_mapitem_mapid` FOREIGN KEY (`MapID`) REFERENCES `maps` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

/*Data for the table `maps_items` */

/*Table structure for table `maps_monsters` */

DROP TABLE IF EXISTS `maps_monsters`;

CREATE TABLE `maps_monsters` (
  `MapID` int(11) unsigned NOT NULL,
  `MonsterID` int(11) unsigned NOT NULL,
  `MonMapID` int(11) unsigned NOT NULL,
  `Frame` varchar(16) NOT NULL,
  PRIMARY KEY (`MapID`,`MonsterID`,`MonMapID`,`Frame`),
  KEY `fk_mapmonsters_monid` (`MonsterID`),
  CONSTRAINT `fk_mapmonsters_mapid` FOREIGN KEY (`MapID`) REFERENCES `maps` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_mapmonsters_monid` FOREIGN KEY (`MonsterID`) REFERENCES `monsters` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

/*Data for the table `maps_monsters` */

/*Table structure for table `monsters` */

DROP TABLE IF EXISTS `monsters`;

CREATE TABLE `monsters` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(16) NOT NULL,
  `Race` varchar(16) NOT NULL,
  `File` varchar(128) NOT NULL,
  `Linkage` varchar(32) NOT NULL,
  `Element` varchar(8) NOT NULL,
  `Level` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `Health` int(11) unsigned NOT NULL DEFAULT 1000,
  `Mana` int(11) unsigned NOT NULL DEFAULT 100,
  `Gold` int(11) unsigned NOT NULL DEFAULT 100,
  `Experience` int(11) unsigned NOT NULL DEFAULT 100,
  `Reputation` int(11) unsigned NOT NULL DEFAULT 100,
  `DPS` int(11) unsigned NOT NULL DEFAULT 100,
  `TeamID` tinyint(1) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

/*Data for the table `monsters` */

/*Table structure for table `monsters_drops` */

DROP TABLE IF EXISTS `monsters_drops`;

CREATE TABLE `monsters_drops` (
  `MonsterID` int(11) unsigned NOT NULL,
  `ItemID` int(11) unsigned NOT NULL,
  `Chance` decimal(7,2) unsigned NOT NULL DEFAULT 1.00,
  `Quantity` int(11) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`MonsterID`,`ItemID`),
  KEY `fk_mondrops_itemid` (`ItemID`),
  CONSTRAINT `fk_mondrops_itemid` FOREIGN KEY (`ItemID`) REFERENCES `items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_mondrops_monsterid` FOREIGN KEY (`MonsterID`) REFERENCES `monsters` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

/*Data for the table `monsters_drops` */

/*Table structure for table `monsters_skills` */

DROP TABLE IF EXISTS `monsters_skills`;

CREATE TABLE `monsters_skills` (
  `MonsterID` int(11) unsigned NOT NULL,
  `SkillID` int(11) unsigned NOT NULL,
  PRIMARY KEY (`MonsterID`,`SkillID`),
  KEY `SkillID` (`SkillID`),
  CONSTRAINT `monsters_skills_ibfk_1` FOREIGN KEY (`MonsterID`) REFERENCES `monsters` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `monsters_skills_ibfk_2` FOREIGN KEY (`SkillID`) REFERENCES `skills` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

/*Data for the table `monsters_skills` */

/*Table structure for table `quests` */

DROP TABLE IF EXISTS `quests`;

CREATE TABLE `quests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `FactionID` int(11) unsigned NOT NULL DEFAULT 1,
  `ReqReputation` int(11) unsigned NOT NULL DEFAULT 0,
  `ReqClassID` int(11) unsigned DEFAULT NULL,
  `ReqClassPoints` int(11) unsigned NOT NULL DEFAULT 0,
  `Name` varchar(64) NOT NULL,
  `Description` text NOT NULL,
  `EndText` text NOT NULL,
  `Experience` int(11) unsigned NOT NULL DEFAULT 0,
  `Gold` int(11) unsigned NOT NULL DEFAULT 0,
  `Reputation` int(11) unsigned NOT NULL DEFAULT 0,
  `ClassPoints` int(11) unsigned NOT NULL DEFAULT 0,
  `RewardType` char(1) NOT NULL DEFAULT 'S',
  `Level` tinyint(3) NOT NULL DEFAULT 1,
  `Upgrade` tinyint(1) NOT NULL DEFAULT 0,
  `Once` tinyint(1) NOT NULL DEFAULT 0,
  `Slot` int(11) NOT NULL DEFAULT -1,
  `Value` int(11) unsigned NOT NULL DEFAULT 0,
  `Field` char(3) NOT NULL DEFAULT '',
  `Index` int(11) NOT NULL DEFAULT -1,
  PRIMARY KEY (`id`),
  KEY `fk_quests_factionid` (`FactionID`),
  KEY `fk_quests_classid` (`ReqClassID`),
  CONSTRAINT `fk_quests_classid` FOREIGN KEY (`ReqClassID`) REFERENCES `classes` (`ItemID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_quests_factionid` FOREIGN KEY (`FactionID`) REFERENCES `factions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=411 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

/*Data for the table `quests` */

insert  into `quests`(`id`,`FactionID`,`ReqReputation`,`ReqClassID`,`ReqClassPoints`,`Name`,`Description`,`EndText`,`Experience`,`Gold`,`Reputation`,`ClassPoints`,`RewardType`,`Level`,`Upgrade`,`Once`,`Slot`,`Value`,`Field`,`Index`) values 
(410,1,0,NULL,0,'Test','test','wow',1,2,0,3,'S',1,0,0,-1,0,'',-1);

/*Table structure for table `quests_locations` */

DROP TABLE IF EXISTS `quests_locations`;

CREATE TABLE `quests_locations` (
  `QuestID` int(11) NOT NULL,
  `MapID` int(11) unsigned NOT NULL,
  PRIMARY KEY (`QuestID`,`MapID`),
  KEY `fk_quesloc_mapid` (`MapID`),
  CONSTRAINT `fk_quesloc_mapid` FOREIGN KEY (`MapID`) REFERENCES `maps` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_quesloc_questid` FOREIGN KEY (`QuestID`) REFERENCES `quests` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

/*Data for the table `quests_locations` */

/*Table structure for table `quests_requirements` */

DROP TABLE IF EXISTS `quests_requirements`;

CREATE TABLE `quests_requirements` (
  `QuestID` int(11) NOT NULL,
  `ItemID` int(11) unsigned NOT NULL,
  `Quantity` int(11) DEFAULT 1,
  PRIMARY KEY (`QuestID`,`ItemID`),
  KEY `fk_questreq_itemid` (`ItemID`),
  CONSTRAINT `fk_questreq_itemid` FOREIGN KEY (`ItemID`) REFERENCES `items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_questreq_questid` FOREIGN KEY (`QuestID`) REFERENCES `quests` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

/*Data for the table `quests_requirements` */

insert  into `quests_requirements`(`QuestID`,`ItemID`,`Quantity`) values 
(410,5,5);

/*Table structure for table `quests_rewards` */

DROP TABLE IF EXISTS `quests_rewards`;

CREATE TABLE `quests_rewards` (
  `QuestID` int(11) NOT NULL,
  `ItemID` int(11) unsigned NOT NULL,
  `Quantity` int(11) unsigned NOT NULL DEFAULT 1,
  KEY `fk_questrewards_questid` (`QuestID`),
  KEY `fk_questrewards_itemid` (`ItemID`),
  CONSTRAINT `fk_questrewards_itemid` FOREIGN KEY (`ItemID`) REFERENCES `items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_questrewards_questid` FOREIGN KEY (`QuestID`) REFERENCES `quests` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

/*Data for the table `quests_rewards` */

insert  into `quests_rewards`(`QuestID`,`ItemID`,`Quantity`) values 
(410,5,10);

/*Table structure for table `servers` */

DROP TABLE IF EXISTS `servers`;

CREATE TABLE `servers` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(64) NOT NULL DEFAULT 'Server',
  `IP` char(15) NOT NULL DEFAULT '0.0.0.0',
  `Online` tinyint(1) NOT NULL DEFAULT 0,
  `Upgrade` tinyint(1) NOT NULL DEFAULT 0,
  `Chat` tinyint(1) NOT NULL DEFAULT 2,
  `Count` mediumint(4) NOT NULL DEFAULT 0,
  `Max` mediumint(4) NOT NULL DEFAULT 500,
  `MOTD` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

/*Data for the table `servers` */

insert  into `servers`(`id`,`Name`,`IP`,`Online`,`Upgrade`,`Chat`,`Count`,`Max`,`MOTD`) values 
(1,'Server','127.0.0.1',1,0,2,1,500,''),
(2,'PTR','127.0.0.1',0,0,2,0,500,'');

/*Table structure for table `settings_login` */

DROP TABLE IF EXISTS `settings_login`;

CREATE TABLE `settings_login` (
  `name` varchar(50) NOT NULL DEFAULT '',
  `value` varchar(50) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

/*Data for the table `settings_login` */

insert  into `settings_login`(`name`,`value`) values 
('gMenu','dynamic-gameMenu-17Jan22.swf'),
('sAssets','Assets_20240227.swf'),
('sBG','Generic2.swf'),
('sBook','news/spiderbook3.swf'),
('sFile','~Game3086.swf'),
('sLoader','~Loader3.swf'),
('sTitle','Dark Birthday'),
('sVersion','R0033'),
('sMap','news/Map-UI_r38.swf'),
('iMaxBagSlots','450'),
('iMaxBankSlots','650'),
('iMaxHouseSlots','250'),
('iMaxGuildMembers','350'),
('iMaxFriends','240'),
('sNews','568'),
('sCharCreate','Register.swf');

/*Table structure for table `settings_rates` */

DROP TABLE IF EXISTS `settings_rates`;

CREATE TABLE `settings_rates` (
  `name` varchar(50) NOT NULL DEFAULT '',
  `value` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

/*Data for the table `settings_rates` */

insert  into `settings_rates`(`name`,`value`) values 
('baseBlock','0'),
('baseBlockValue','0.7'),
('baseCrit','0.05'),
('baseCritValue','1.5'),
('baseDodge','0.04'),
('baseEventValue','0.05'),
('baseHaste','0'),
('baseHit','0'),
('baseMiss','0.1'),
('baseParry','0.03'),
('baseResistValue','0.7'),
('bigNumberBase','8'),
('curveExponent','0.66'),
('GstBase','12'),
('GstGoal','572'),
('GstRatio','5.6'),
('intAPtoDPS','10'),
('intHPperEND','5'),
('intLevelCap','100'),
('intLevelMax','100'),
('intMPperWIS','5'),
('intSPtoDPS','10'),
('modRating','3'),
('PCDPSMod','0.85'),
('PChpBase1','360'),
('PChpBase100','2000'),
('PChpDelta','1640'),
('PChpGoal1','400'),
('PChpGoal100','4000'),
('PCmpBase1','100'),
('PCmpBase100','2000'),
('PCmpDelta','900'),
('PCstBase','15'),
('PCstGoal','762'),
('PCstRatio','7.47'),
('resistRating','17'),
('statsExponent','1');

/*Table structure for table `shops` */

DROP TABLE IF EXISTS `shops`;

CREATE TABLE `shops` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(32) NOT NULL,
  `House` tinyint(1) NOT NULL DEFAULT 0,
  `Upgrade` tinyint(1) NOT NULL DEFAULT 0,
  `Staff` tinyint(1) NOT NULL DEFAULT 0,
  `Limited` tinyint(1) NOT NULL DEFAULT 0,
  `Field` varchar(8) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

/*Data for the table `shops` */

insert  into `shops`(`id`,`Name`,`House`,`Upgrade`,`Staff`,`Limited`,`Field`) values 
(101,'AC Shop',0,0,0,0,'');

/*Table structure for table `shops_items` */

DROP TABLE IF EXISTS `shops_items`;

CREATE TABLE `shops_items` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ShopID` int(11) NOT NULL,
  `ItemID` int(11) unsigned NOT NULL,
  `QuantityRemain` int(11) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `fk_shopitems_shopid` (`ShopID`),
  KEY `fk_shopitems_itemid` (`ItemID`),
  CONSTRAINT `fk_shopitems_itemid` FOREIGN KEY (`ItemID`) REFERENCES `items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_shopitems_shopid` FOREIGN KEY (`ShopID`) REFERENCES `shops` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

/*Data for the table `shops_items` */

insert  into `shops_items`(`id`,`ShopID`,`ItemID`,`QuantityRemain`) values 
(1,101,3,0),
(2,101,4,0),
(3,101,5,0);

/*Table structure for table `shops_locations` */

DROP TABLE IF EXISTS `shops_locations`;

CREATE TABLE `shops_locations` (
  `ShopID` int(11) NOT NULL,
  `MapID` int(11) unsigned NOT NULL,
  PRIMARY KEY (`ShopID`,`MapID`),
  KEY `fk_shoploc_mapid` (`MapID`),
  CONSTRAINT `fk_shoploc_mapid` FOREIGN KEY (`MapID`) REFERENCES `maps` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_shoploc_shopid` FOREIGN KEY (`ShopID`) REFERENCES `shops` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

/*Data for the table `shops_locations` */

/*Table structure for table `skills` */

DROP TABLE IF EXISTS `skills`;

CREATE TABLE `skills` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ItemID` int(11) unsigned NOT NULL,
  `AuraID` int(11) unsigned DEFAULT NULL,
  `Name` varchar(32) NOT NULL,
  `Animation` varchar(64) NOT NULL,
  `Description` text NOT NULL,
  `Damage` decimal(7,2) NOT NULL DEFAULT 1.00,
  `Mana` smallint(3) NOT NULL,
  `Icon` varchar(32) NOT NULL,
  `Range` smallint(3) unsigned NOT NULL DEFAULT 808,
  `Dsrc` varchar(16) NOT NULL,
  `Reference` char(2) NOT NULL,
  `Target` char(1) NOT NULL,
  `Effects` char(1) NOT NULL,
  `Type` varchar(7) NOT NULL,
  `Strl` varchar(32) NOT NULL,
  `Cooldown` int(11) unsigned NOT NULL,
  `HitTargets` tinyint(2) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `fk_skills_auraid` (`AuraID`),
  KEY `fk_skills_classid` (`ItemID`),
  CONSTRAINT `fk_skills_auraid` FOREIGN KEY (`AuraID`) REFERENCES `skills_auras` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_skills_itemid` FOREIGN KEY (`ItemID`) REFERENCES `items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

/*Data for the table `skills` */

insert  into `skills`(`id`,`ItemID`,`AuraID`,`Name`,`Animation`,`Description`,`Damage`,`Mana`,`Icon`,`Range`,`Dsrc`,`Reference`,`Target`,`Effects`,`Type`,`Strl`,`Cooldown`,`HitTargets`) values 
(1,2,NULL,'Auto Attack','Attack1,Attack2','A strong attack known only to disciplined fighters. Damage dealt is based on weapon damage.',1.10,0,'iwd1',301,'AP2','aa','h','m','aa','',2000,1),
(2,2,1,'Viper\'s Kiss','Attack4','Instantly cause 80% weapon damage, and apply a poison dealing additional damage over 7s',0.80,10,'isp1',505,'AP2','a1','h','m','p','',3000,1),
(3,2,NULL,'Opportunity\'s Strike','Stab','Deals damage based on how much time is left on your application of Viper\'s Kiss (less time means higher damage)',1.25,10,'iiclass,imc1',301,'Thief1','a2','h','m','p','',4000,1),
(4,2,NULL,'Stiletto','Attack3','Deals moderate damage, and applies Concealed Blade, causing your attacks to do more damage the lower your target\'s HP is (if below 40%) for 20 seconds',0.80,20,'iwdagger',301,'AP2','a3','h','m','p','',60000,1),
(5,2,2,'Footwork','Bow','Increases your haste and chance to dodge by 30% for 15 seconds',0.00,20,'imp1,imf1',301,'','a4','s','m','p','',32000,1);

/*Table structure for table `skills_auras` */

DROP TABLE IF EXISTS `skills_auras`;

CREATE TABLE `skills_auras` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(32) NOT NULL,
  `Duration` tinyint(2) NOT NULL DEFAULT 6,
  `Category` varchar(8) NOT NULL,
  `DamageIncrease` decimal(7,2) NOT NULL DEFAULT 0.00,
  `DamageTakenDecrease` decimal(7,2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

/*Data for the table `skills_auras` */

insert  into `skills_auras`(`id`,`Name`,`Duration`,`Category`,`DamageIncrease`,`DamageTakenDecrease`) values 
(1,'Viper\'s Kiss',7,'d',0.00,0.00),
(2,'Footwork',15,'',0.00,0.00);

/*Table structure for table `skills_auras_effects` */

DROP TABLE IF EXISTS `skills_auras_effects`;

CREATE TABLE `skills_auras_effects` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `AuraID` int(11) unsigned NOT NULL,
  `Stat` char(3) NOT NULL,
  `Value` decimal(7,2) NOT NULL DEFAULT 0.00,
  `Type` char(1) NOT NULL DEFAULT '+',
  PRIMARY KEY (`id`),
  KEY `fk_auraeffects_auraid` (`AuraID`),
  CONSTRAINT `fk_auraeffects_auraid` FOREIGN KEY (`AuraID`) REFERENCES `skills_auras` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

/*Data for the table `skills_auras_effects` */

insert  into `skills_auras_effects`(`id`,`AuraID`,`Stat`,`Value`,`Type`) values 
(1,2,'tdo',0.30,'+'),
(2,2,'tha',0.30,'+');

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(32) NOT NULL,
  `Hash` char(17) NOT NULL,
  `HairID` int(11) unsigned NOT NULL,
  `Access` tinyint(2) unsigned NOT NULL DEFAULT 1,
  `ActivationFlag` tinyint(1) unsigned NOT NULL DEFAULT 5,
  `PermamuteFlag` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `Country` char(2) NOT NULL DEFAULT 'xx',
  `Age` tinyint(2) unsigned NOT NULL,
  `Gender` char(1) NOT NULL,
  `Email` varchar(64) NOT NULL,
  `Level` tinyint(2) unsigned NOT NULL DEFAULT 1,
  `Gold` int(11) unsigned NOT NULL DEFAULT 0,
  `Coins` int(11) unsigned NOT NULL DEFAULT 0,
  `Exp` int(11) unsigned NOT NULL DEFAULT 0,
  `ColorHair` char(6) NOT NULL DEFAULT '000000',
  `ColorSkin` char(6) NOT NULL DEFAULT '000000',
  `ColorEye` char(6) NOT NULL DEFAULT '000000',
  `ColorBase` char(6) NOT NULL DEFAULT '000000',
  `ColorTrim` char(6) NOT NULL DEFAULT '000000',
  `ColorAccessory` char(6) NOT NULL DEFAULT '000000',
  `SlotsBag` smallint(5) unsigned NOT NULL DEFAULT 40,
  `SlotsBank` smallint(5) unsigned NOT NULL DEFAULT 0,
  `SlotsHouse` smallint(5) unsigned NOT NULL DEFAULT 20,
  `DateCreated` datetime NOT NULL DEFAULT current_timestamp(),
  `LastLogin` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `CpBoostExpire` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `RepBoostExpire` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `GoldBoostExpire` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `ExpBoostExpire` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `UpgradeExpire` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `UpgradeDays` smallint(3) NOT NULL DEFAULT 0,
  `Upgraded` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `Achievement` smallint(5) unsigned NOT NULL DEFAULT 0,
  `Settings` smallint(5) unsigned NOT NULL DEFAULT 0,
  `Quests` char(100) NOT NULL DEFAULT '0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000',
  `Quests2` char(100) NOT NULL DEFAULT '0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000',
  `DailyQuests0` smallint(5) unsigned NOT NULL DEFAULT 0,
  `DailyQuests1` smallint(5) unsigned NOT NULL DEFAULT 0,
  `DailyQuests2` smallint(5) unsigned NOT NULL DEFAULT 0,
  `MonthlyQuests0` smallint(5) unsigned NOT NULL DEFAULT 0,
  `LastArea` varchar(64) NOT NULL DEFAULT 'faroff-1|Enter|Spawn',
  `CurrentServer` varchar(16) NOT NULL DEFAULT 'Offline',
  `HouseInfo` text NOT NULL,
  `KillCount` int(10) unsigned NOT NULL DEFAULT 0,
  `DeathCount` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `fk_users_hairid` (`HairID`),
  CONSTRAINT `fk_users_hairid` FOREIGN KEY (`HairID`) REFERENCES `hairs` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

/*Data for the table `users` */

/*Table structure for table `users_factions` */

DROP TABLE IF EXISTS `users_factions`;

CREATE TABLE `users_factions` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `UserID` int(11) unsigned NOT NULL,
  `FactionID` int(11) unsigned NOT NULL,
  `Reputation` mediumint(6) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UserID` (`UserID`,`FactionID`),
  KEY `fk_userfactions_factionid` (`FactionID`),
  CONSTRAINT `fk_userfactions_factionid` FOREIGN KEY (`FactionID`) REFERENCES `factions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_userfactions_userid` FOREIGN KEY (`UserID`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

/*Data for the table `users_factions` */

/*Table structure for table `users_friends` */

DROP TABLE IF EXISTS `users_friends`;

CREATE TABLE `users_friends` (
  `UserID` int(11) unsigned NOT NULL,
  `FriendID` int(11) unsigned NOT NULL,
  PRIMARY KEY (`UserID`,`FriendID`),
  KEY `fk_friends_friendid` (`FriendID`),
  CONSTRAINT `fk_friends_friendid` FOREIGN KEY (`FriendID`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_friends_userid` FOREIGN KEY (`UserID`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

/*Data for the table `users_friends` */

/*Table structure for table `users_guilds` */

DROP TABLE IF EXISTS `users_guilds`;

CREATE TABLE `users_guilds` (
  `GuildID` int(11) unsigned NOT NULL,
  `UserID` int(11) unsigned NOT NULL,
  `Rank` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`GuildID`,`UserID`),
  KEY `fk_userguilds_userid` (`UserID`),
  CONSTRAINT `fk_userguilds_guildid` FOREIGN KEY (`GuildID`) REFERENCES `guilds` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_userguilds_userid` FOREIGN KEY (`UserID`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

/*Data for the table `users_guilds` */

/*Table structure for table `users_items` */

DROP TABLE IF EXISTS `users_items`;

CREATE TABLE `users_items` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `UserID` int(11) unsigned NOT NULL,
  `ItemID` int(11) unsigned NOT NULL,
  `EnhID` int(11) unsigned NOT NULL,
  `Equipped` tinyint(1) unsigned NOT NULL,
  `Quantity` mediumint(6) unsigned NOT NULL,
  `Bank` tinyint(1) unsigned NOT NULL,
  `DatePurchased` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `uid_itemid` (`ItemID`,`UserID`),
  KEY `fk_useritems_enhid` (`EnhID`),
  KEY `fk_useritems_userid` (`UserID`),
  CONSTRAINT `fk_useritems_enhid` FOREIGN KEY (`EnhID`) REFERENCES `enhancements` (`id`),
  CONSTRAINT `fk_useritems_itemid` FOREIGN KEY (`ItemID`) REFERENCES `items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_useritems_userid` FOREIGN KEY (`UserID`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

/*Data for the table `users_items` */

/*Table structure for table `users_logs` */

DROP TABLE IF EXISTS `users_logs`;

CREATE TABLE `users_logs` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `UserID` int(11) unsigned NOT NULL,
  `Violation` varchar(64) NOT NULL,
  `Details` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_userlogs_userid` (`UserID`),
  CONSTRAINT `fk_userlogs_userid` FOREIGN KEY (`UserID`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

/*Data for the table `users_logs` */

/* Trigger structure for table `guilds` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `NewGuild` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `NewGuild` AFTER INSERT ON `guilds` FOR EACH ROW BEGIN
	INSERT INTO guilds_halls (GuildID, Linkage, Cell, X, Y, Interior) VALUES (NEW.id, 'fr1', 'Enter', '0', '0', '|||');
    END */$$


DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
