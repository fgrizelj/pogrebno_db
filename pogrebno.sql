-- Adminer 4.7.6 MySQL dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

CREATE TABLE `departed` (
  `id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(25) NOT NULL DEFAULT '',
  `last_name` varchar(25) NOT NULL DEFAULT '',
  `nick_name` varchar(25) NOT NULL DEFAULT '',
  `death_date` date DEFAULT NULL,
  `burial_date` date DEFAULT NULL,
  `object_id` smallint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_departed_object_id` (`object_id`),
  CONSTRAINT `fk_departed_object_id` FOREIGN KEY (`object_id`) REFERENCES `objects` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `invoice_descs` (
  `id` smallint NOT NULL AUTO_INCREMENT,
  `invoice_desc` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `invoices` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `invoice_date` date NOT NULL,
  `debt` bigint NOT NULL,
  `credit` bigint NOT NULL,
  `subject_id` smallint NOT NULL,
  `invoice_desc_id` smallint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_invoice_invoice_desc_id` (`invoice_desc_id`),
  KEY `fk_invoice_subject_id` (`subject_id`),
  CONSTRAINT `fk_invoice_invoice_desc_id` FOREIGN KEY (`invoice_desc_id`) REFERENCES `invoice_descs` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_invoice_subject_id` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `object_types` (
  `id` smallint NOT NULL AUTO_INCREMENT,
  `object_type` varchar(25) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `objects` (
  `id` smallint NOT NULL AUTO_INCREMENT,
  `field` varchar(10) NOT NULL,
  `location` smallint NOT NULL,
  `object_type_id` smallint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_object_object_type_id` (`object_type_id`),
  CONSTRAINT `fk_object_object_type_id` FOREIGN KEY (`object_type_id`) REFERENCES `object_types` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `subject_object_map` (
  `id` smallint NOT NULL AUTO_INCREMENT,
  `subject_id` smallint NOT NULL,
  `object_id` smallint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_subject_to_object_object_id` (`object_id`),
  KEY `fk_subject_to_object_subject_id` (`subject_id`),
  CONSTRAINT `fk_subject_to_object_object_id` FOREIGN KEY (`object_id`) REFERENCES `objects` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_subject_to_object_subject_id` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `subject_types` (
  `id` smallint NOT NULL AUTO_INCREMENT,
  `subject_type` varchar(25) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `subjects` (
  `id` smallint NOT NULL AUTO_INCREMENT,
  `first_name` varchar(25) NOT NULL DEFAULT '',
  `last_name` varchar(25) NOT NULL DEFAULT '',
  `nick_name` varchar(25) NOT NULL DEFAULT '',
  `address` varchar(45) NOT NULL DEFAULT '',
  `city` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `mob` varchar(25) NOT NULL DEFAULT '',
  `email` varchar(25) NOT NULL DEFAULT '',
  `subject_type_id` smallint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_subject_subject_type_id` (`subject_type_id`),
  CONSTRAINT `fk_subject_subject_type_id` FOREIGN KEY (`subject_type_id`) REFERENCES `subject_types` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `transfers` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `transfer_date` date NOT NULL,
  `debt` bigint NOT NULL,
  `credit` bigint NOT NULL,
  `invoice_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_transfer_invoice_id` (`invoice_id`),
  CONSTRAINT `fk_transfer_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- 2021-02-27 19:07:46
