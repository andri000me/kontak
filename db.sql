/*
SQLyog Ultimate
MySQL - 5.5.65-MariaDB : Database - db_sipa
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`db_sipa` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `db_sipa`;

/*Table structure for table `ea_appointments` */

CREATE TABLE `ea_appointments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `jml_peserta` int(11) DEFAULT NULL,
  `peserta` text,
  `surat_permohonan` text,
  `book_datetime` datetime DEFAULT NULL,
  `start_datetime` datetime DEFAULT NULL,
  `end_datetime` datetime DEFAULT NULL,
  `notes` text,
  `hash` text,
  `is_unavailable` tinyint(4) DEFAULT '0',
  `id_users_provider` int(11) DEFAULT NULL,
  `id_users_customer` int(11) DEFAULT NULL,
  `id_services` int(11) DEFAULT NULL,
  `id_google_calendar` text,
  PRIMARY KEY (`id`),
  KEY `id_users_customer` (`id_users_customer`),
  KEY `id_services` (`id_services`),
  KEY `id_users_provider` (`id_users_provider`),
  CONSTRAINT `appointments_services` FOREIGN KEY (`id_services`) REFERENCES `ea_services` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `appointments_users_customer` FOREIGN KEY (`id_users_customer`) REFERENCES `ea_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `appointments_users_provider` FOREIGN KEY (`id_users_provider`) REFERENCES `ea_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

/*Data for the table `ea_appointments` */

insert  into `ea_appointments`(`id`,`jml_peserta`,`peserta`,`surat_permohonan`,`book_datetime`,`start_datetime`,`end_datetime`,`notes`,`hash`,`is_unavailable`,`id_users_provider`,`id_users_customer`,`id_services`,`id_google_calendar`) values (4,NULL,NULL,NULL,'2020-07-08 16:55:09','2020-07-10 09:00:00','2020-07-10 10:00:00','Koordinasi persiapan perpanjangan Nota Kesepahaman Bersama','5772d0b6bb77358ab954a2276f37a809',0,6,7,3,NULL);
insert  into `ea_appointments`(`id`,`jml_peserta`,`peserta`,`surat_permohonan`,`book_datetime`,`start_datetime`,`end_datetime`,`notes`,`hash`,`is_unavailable`,`id_users_provider`,`id_users_customer`,`id_services`,`id_google_calendar`) values (9,NULL,NULL,NULL,'2020-07-10 10:20:09','2020-07-31 00:00:00','2020-07-31 23:59:00','LIBUR HARI RAYA IDUL ADHA',NULL,1,6,NULL,NULL,NULL);

/*Table structure for table `ea_migrations` */

CREATE TABLE `ea_migrations` (
  `version` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `ea_migrations` */

insert  into `ea_migrations`(`version`) values (12);

/*Table structure for table `ea_roles` */

CREATE TABLE `ea_roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(256) DEFAULT NULL,
  `slug` varchar(256) DEFAULT NULL,
  `is_admin` tinyint(4) DEFAULT NULL,
  `appointments` int(11) DEFAULT NULL,
  `customers` int(11) DEFAULT NULL,
  `services` int(11) DEFAULT NULL,
  `users` int(11) DEFAULT NULL,
  `system_settings` int(11) DEFAULT NULL,
  `user_settings` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Data for the table `ea_roles` */

insert  into `ea_roles`(`id`,`name`,`slug`,`is_admin`,`appointments`,`customers`,`services`,`users`,`system_settings`,`user_settings`) values (1,'Administrator','admin',1,15,15,15,15,15,15);
insert  into `ea_roles`(`id`,`name`,`slug`,`is_admin`,`appointments`,`customers`,`services`,`users`,`system_settings`,`user_settings`) values (2,'Provider','provider',0,15,15,0,0,0,15);
insert  into `ea_roles`(`id`,`name`,`slug`,`is_admin`,`appointments`,`customers`,`services`,`users`,`system_settings`,`user_settings`) values (3,'Customer','customer',0,0,0,0,0,0,0);
insert  into `ea_roles`(`id`,`name`,`slug`,`is_admin`,`appointments`,`customers`,`services`,`users`,`system_settings`,`user_settings`) values (4,'Secretary','secretary',0,15,15,0,0,0,15);

/*Table structure for table `ea_secretaries_providers` */

CREATE TABLE `ea_secretaries_providers` (
  `id_users_secretary` int(11) NOT NULL,
  `id_users_provider` int(11) NOT NULL,
  PRIMARY KEY (`id_users_secretary`,`id_users_provider`),
  KEY `id_users_secretary` (`id_users_secretary`),
  KEY `id_users_provider` (`id_users_provider`),
  CONSTRAINT `secretaries_users_provider` FOREIGN KEY (`id_users_provider`) REFERENCES `ea_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `secretaries_users_secretary` FOREIGN KEY (`id_users_secretary`) REFERENCES `ea_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `ea_secretaries_providers` */

insert  into `ea_secretaries_providers`(`id_users_secretary`,`id_users_provider`) values (9,2);
insert  into `ea_secretaries_providers`(`id_users_secretary`,`id_users_provider`) values (9,6);
insert  into `ea_secretaries_providers`(`id_users_secretary`,`id_users_provider`) values (9,8);

/*Table structure for table `ea_service_categories` */

CREATE TABLE `ea_service_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(256) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `ea_service_categories` */

insert  into `ea_service_categories`(`id`,`name`,`description`) values (1,'Kepaniteran','Layanan Kepaniteraan Pengadilan TInggi Bandung');
insert  into `ea_service_categories`(`id`,`name`,`description`) values (2,'Kesekretariatan','');

/*Table structure for table `ea_services` */

CREATE TABLE `ea_services` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(256) DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `currency` varchar(32) DEFAULT NULL,
  `description` text,
  `availabilities_type` varchar(32) DEFAULT 'flexible',
  `attendants_number` int(11) DEFAULT '1',
  `id_service_categories` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_service_categories` (`id_service_categories`),
  CONSTRAINT `services_service_categories` FOREIGN KEY (`id_service_categories`) REFERENCES `ea_service_categories` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

/*Data for the table `ea_services` */

insert  into `ea_services`(`id`,`name`,`duration`,`price`,`currency`,`description`,`availabilities_type`,`attendants_number`,`id_service_categories`) values (2,'Pengambilan Sumpah Advokat / Pengacara',60,0.00,'','','flexible',40,1);
insert  into `ea_services`(`id`,`name`,`duration`,`price`,`currency`,`description`,`availabilities_type`,`attendants_number`,`id_service_categories`) values (3,'Audiensi',60,0.00,'','Audiensi','flexible',7,1);
insert  into `ea_services`(`id`,`name`,`duration`,`price`,`currency`,`description`,`availabilities_type`,`attendants_number`,`id_service_categories`) values (4,'Teleconference',60,0.00,'','','flexible',10,1);
insert  into `ea_services`(`id`,`name`,`duration`,`price`,`currency`,`description`,`availabilities_type`,`attendants_number`,`id_service_categories`) values (5,'Studi',60,0.00,'','','flexible',40,NULL);
insert  into `ea_services`(`id`,`name`,`duration`,`price`,`currency`,`description`,`availabilities_type`,`attendants_number`,`id_service_categories`) values (6,'Konsultasi / Klinik ZI dan APM',120,0.00,'','','flexible',10,2);

/*Table structure for table `ea_services_providers` */

CREATE TABLE `ea_services_providers` (
  `id_users` int(11) NOT NULL,
  `id_services` int(11) NOT NULL,
  PRIMARY KEY (`id_users`,`id_services`),
  KEY `id_services` (`id_services`),
  CONSTRAINT `services_providers_services` FOREIGN KEY (`id_services`) REFERENCES `ea_services` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `services_providers_users_provider` FOREIGN KEY (`id_users`) REFERENCES `ea_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `ea_services_providers` */

insert  into `ea_services_providers`(`id_users`,`id_services`) values (2,2);
insert  into `ea_services_providers`(`id_users`,`id_services`) values (2,3);
insert  into `ea_services_providers`(`id_users`,`id_services`) values (6,2);
insert  into `ea_services_providers`(`id_users`,`id_services`) values (6,3);
insert  into `ea_services_providers`(`id_users`,`id_services`) values (6,4);
insert  into `ea_services_providers`(`id_users`,`id_services`) values (8,3);
insert  into `ea_services_providers`(`id_users`,`id_services`) values (8,4);
insert  into `ea_services_providers`(`id_users`,`id_services`) values (8,5);
insert  into `ea_services_providers`(`id_users`,`id_services`) values (8,6);

/*Table structure for table `ea_settings` */

CREATE TABLE `ea_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(512) DEFAULT NULL,
  `value` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

/*Data for the table `ea_settings` */

insert  into `ea_settings`(`id`,`name`,`value`) values (1,'company_working_plan','{\"sunday\":{\"start\":\"09:00\",\"end\":\"18:00\",\"breaks\":[{\"start\":\"11:20\",\"end\":\"11:30\"},{\"start\":\"14:30\",\"end\":\"15:00\"}]},\"monday\":{\"start\":\"08:00\",\"end\":\"16:30\",\"breaks\":[{\"start\":\"11:20\",\"end\":\"11:30\"},{\"start\":\"14:30\",\"end\":\"15:00\"}]},\"tuesday\":{\"start\":\"08:00\",\"end\":\"16:30\",\"breaks\":[{\"start\":\"11:20\",\"end\":\"11:30\"},{\"start\":\"14:30\",\"end\":\"15:00\"}]},\"wednesday\":{\"start\":\"08:00\",\"end\":\"16:30\",\"breaks\":[{\"start\":\"11:20\",\"end\":\"11:30\"},{\"start\":\"14:30\",\"end\":\"15:00\"}]},\"thursday\":{\"start\":\"08:00\",\"end\":\"16:30\",\"breaks\":[{\"start\":\"11:20\",\"end\":\"11:30\"},{\"start\":\"14:30\",\"end\":\"15:00\"}]},\"friday\":{\"start\":\"08:00\",\"end\":\"16:30\",\"breaks\":[{\"start\":\"11:20\",\"end\":\"11:30\"},{\"start\":\"14:30\",\"end\":\"15:00\"}]},\"saturday\":{\"start\":\"07:00\",\"end\":\"16:30\",\"breaks\":[{\"start\":\"11:20\",\"end\":\"11:30\"},{\"start\":\"14:30\",\"end\":\"15:00\"}]}}');
insert  into `ea_settings`(`id`,`name`,`value`) values (2,'book_advance_timeout','30');
insert  into `ea_settings`(`id`,`name`,`value`) values (3,'google_analytics_code','');
insert  into `ea_settings`(`id`,`name`,`value`) values (4,'customer_notifications','1');
insert  into `ea_settings`(`id`,`name`,`value`) values (5,'date_format','DMY');
insert  into `ea_settings`(`id`,`name`,`value`) values (6,'time_format','military');
insert  into `ea_settings`(`id`,`name`,`value`) values (7,'require_captcha','0');
insert  into `ea_settings`(`id`,`name`,`value`) values (8,'display_cookie_notice','0');
insert  into `ea_settings`(`id`,`name`,`value`) values (9,'cookie_notice_content','Cookie notice content.');
insert  into `ea_settings`(`id`,`name`,`value`) values (10,'display_terms_and_conditions','0');
insert  into `ea_settings`(`id`,`name`,`value`) values (11,'terms_and_conditions_content','Terms and conditions content.');
insert  into `ea_settings`(`id`,`name`,`value`) values (12,'display_privacy_policy','0');
insert  into `ea_settings`(`id`,`name`,`value`) values (13,'privacy_policy_content','Privacy policy content.');
insert  into `ea_settings`(`id`,`name`,`value`) values (14,'company_name','Pengadilan Tinggi Bandung');
insert  into `ea_settings`(`id`,`name`,`value`) values (15,'company_email','info@pt-bandung.go.id');
insert  into `ea_settings`(`id`,`name`,`value`) values (16,'company_link','pt-bandung.go.id');

/*Table structure for table `ea_user_settings` */

CREATE TABLE `ea_user_settings` (
  `id_users` int(11) NOT NULL,
  `username` varchar(256) DEFAULT NULL,
  `password` varchar(512) DEFAULT NULL,
  `salt` varchar(512) DEFAULT NULL,
  `working_plan` text,
  `notifications` tinyint(4) DEFAULT '0',
  `google_sync` tinyint(4) DEFAULT '0',
  `google_token` text,
  `google_calendar` varchar(128) DEFAULT NULL,
  `sync_past_days` int(11) DEFAULT '5',
  `sync_future_days` int(11) DEFAULT '5',
  `calendar_view` varchar(32) DEFAULT 'default',
  PRIMARY KEY (`id_users`),
  CONSTRAINT `user_settings_users` FOREIGN KEY (`id_users`) REFERENCES `ea_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `ea_user_settings` */

insert  into `ea_user_settings`(`id_users`,`username`,`password`,`salt`,`working_plan`,`notifications`,`google_sync`,`google_token`,`google_calendar`,`sync_past_days`,`sync_future_days`,`calendar_view`) values (1,'admin','dd0d7f52c9300d30c27e417acd9c13487ac4b7f906ce8285ba0b2edb39d8fb15','8af610179e0f9a1a092b54fddfd9667e949d8d280bb52205ed5e017fc900217a',NULL,0,0,NULL,NULL,5,5,'default');
insert  into `ea_user_settings`(`id_users`,`username`,`password`,`salt`,`working_plan`,`notifications`,`google_sync`,`google_token`,`google_calendar`,`sync_past_days`,`sync_future_days`,`calendar_view`) values (2,'panitera','62a0036e945242fe3a85f116a792dca5d7b9be776187a2396db511e4fb679950','024c7488e31d60a0379803d350cd0d841c5b052a027e28ef0e34ee7846ac798a','{\"sunday\":null,\"monday\":{\"start\":\"08:00\",\"end\":\"15:00\",\"breaks\":[{\"start\":\"12:00\",\"end\":\"13:00\"}]},\"tuesday\":{\"start\":\"08:00\",\"end\":\"15:00\",\"breaks\":[{\"start\":\"12:00\",\"end\":\"13:00\"}]},\"wednesday\":{\"start\":\"08:00\",\"end\":\"15:00\",\"breaks\":[{\"start\":\"12:00\",\"end\":\"13:00\"}]},\"thursday\":{\"start\":\"08:00\",\"end\":\"15:00\",\"breaks\":[{\"start\":\"12:00\",\"end\":\"13:00\"}]},\"friday\":{\"start\":\"08:00\",\"end\":\"15:00\",\"breaks\":[{\"start\":\"11:30\",\"end\":\"13:00\"}]},\"saturday\":null}',0,0,NULL,NULL,5,5,'default');
insert  into `ea_user_settings`(`id_users`,`username`,`password`,`salt`,`working_plan`,`notifications`,`google_sync`,`google_token`,`google_calendar`,`sync_past_days`,`sync_future_days`,`calendar_view`) values (6,'kpt','0a70f8efe3dedb25808ec229eaf6974aeaddf5556b5898cefb10a2e82812469d','e1ab18da0c1c5a700df33739e555b88446b5108d7bce5082ec419dffc55d1c65','{\"sunday\":{\"start\":\"08:00\",\"end\":\"16:30\",\"breaks\":[{\"start\":\"11:20\",\"end\":\"11:30\"},{\"start\":\"14:30\",\"end\":\"15:00\"}]},\"monday\":{\"start\":\"08:00\",\"end\":\"16:30\",\"breaks\":[{\"start\":\"11:20\",\"end\":\"11:30\"},{\"start\":\"14:30\",\"end\":\"15:00\"}]},\"tuesday\":{\"start\":\"08:00\",\"end\":\"16:30\",\"breaks\":[{\"start\":\"11:20\",\"end\":\"11:30\"},{\"start\":\"14:30\",\"end\":\"15:00\"}]},\"wednesday\":{\"start\":\"08:00\",\"end\":\"16:30\",\"breaks\":[{\"start\":\"11:20\",\"end\":\"11:30\"},{\"start\":\"14:30\",\"end\":\"15:00\"}]},\"thursday\":{\"start\":\"08:00\",\"end\":\"16:30\",\"breaks\":[{\"start\":\"11:20\",\"end\":\"11:30\"},{\"start\":\"14:30\",\"end\":\"15:00\"}]},\"friday\":{\"start\":\"08:00\",\"end\":\"16:30\",\"breaks\":[{\"start\":\"11:20\",\"end\":\"11:30\"},{\"start\":\"14:30\",\"end\":\"15:00\"}]},\"saturday\":{\"start\":\"07:00\",\"end\":\"16:30\",\"breaks\":[{\"start\":\"11:20\",\"end\":\"11:30\"},{\"start\":\"14:30\",\"end\":\"15:00\"}]}}',0,0,NULL,NULL,5,5,'table');
insert  into `ea_user_settings`(`id_users`,`username`,`password`,`salt`,`working_plan`,`notifications`,`google_sync`,`google_token`,`google_calendar`,`sync_past_days`,`sync_future_days`,`calendar_view`) values (8,'sekretarispt','5faf9b51852cdb7812fbbbe45c1dd5d7dfffcb32e0f0828058ca85960608362b','a072f720ae9b27c605c14832d2182c7ccbb49bafcdae171a73bafcfb35cb7e04','{\"sunday\":{\"start\":\"09:00\",\"end\":\"18:00\",\"breaks\":[{\"start\":\"11:20\",\"end\":\"11:30\"},{\"start\":\"14:30\",\"end\":\"15:00\"}]},\"monday\":{\"start\":\"08:00\",\"end\":\"16:30\",\"breaks\":[{\"start\":\"11:20\",\"end\":\"11:30\"},{\"start\":\"14:30\",\"end\":\"15:00\"}]},\"tuesday\":{\"start\":\"08:00\",\"end\":\"16:30\",\"breaks\":[{\"start\":\"11:20\",\"end\":\"11:30\"},{\"start\":\"14:30\",\"end\":\"15:00\"}]},\"wednesday\":{\"start\":\"08:00\",\"end\":\"16:30\",\"breaks\":[{\"start\":\"11:20\",\"end\":\"11:30\"},{\"start\":\"14:30\",\"end\":\"15:00\"}]},\"thursday\":{\"start\":\"08:00\",\"end\":\"16:30\",\"breaks\":[{\"start\":\"11:20\",\"end\":\"11:30\"},{\"start\":\"14:30\",\"end\":\"15:00\"}]},\"friday\":{\"start\":\"08:00\",\"end\":\"16:30\",\"breaks\":[{\"start\":\"11:20\",\"end\":\"11:30\"},{\"start\":\"14:30\",\"end\":\"15:00\"}]},\"saturday\":{\"start\":\"07:00\",\"end\":\"16:30\",\"breaks\":[{\"start\":\"11:20\",\"end\":\"11:30\"},{\"start\":\"14:30\",\"end\":\"15:00\"}]}}',1,0,NULL,NULL,5,5,'default');
insert  into `ea_user_settings`(`id_users`,`username`,`password`,`salt`,`working_plan`,`notifications`,`google_sync`,`google_token`,`google_calendar`,`sync_past_days`,`sync_future_days`,`calendar_view`) values (9,'tiaartia','cdf4261777dc6d54b06090f12346785680085ac4955e26901ace7dd7601d396e','f3cf4a812621f38ad72b499021930fe41a485c2d05baeb774194cd0d9a0192db',NULL,1,0,NULL,NULL,5,5,'default');

/*Table structure for table `ea_users` */

CREATE TABLE `ea_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(256) DEFAULT NULL,
  `last_name` varchar(512) DEFAULT NULL,
  `email` varchar(512) DEFAULT NULL,
  `mobile_number` varchar(128) DEFAULT NULL,
  `phone_number` varchar(128) DEFAULT NULL,
  `address` varchar(256) DEFAULT NULL,
  `city` varchar(256) DEFAULT NULL,
  `state` varchar(128) DEFAULT NULL,
  `zip_code` varchar(64) DEFAULT NULL,
  `notes` text,
  `id_roles` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_roles` (`id_roles`),
  CONSTRAINT `users_roles` FOREIGN KEY (`id_roles`) REFERENCES `ea_roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

/*Data for the table `ea_users` */

insert  into `ea_users`(`id`,`first_name`,`last_name`,`email`,`mobile_number`,`phone_number`,`address`,`city`,`state`,`zip_code`,`notes`,`id_roles`) values (1,'administrator','Pengadilan Tinggi Bandung','admin@mail.com','','02287832124','Jl. Cimuncang No.21 D','Bandung','Jawa Barat','','',1);
insert  into `ea_users`(`id`,`first_name`,`last_name`,`email`,`mobile_number`,`phone_number`,`address`,`city`,`state`,`zip_code`,`notes`,`id_roles`) values (2,'Panitera','Pengadilan Tinggi','panitera@mail.com','','0123456789','','','','','',2);
insert  into `ea_users`(`id`,`first_name`,`last_name`,`email`,`mobile_number`,`phone_number`,`address`,`city`,`state`,`zip_code`,`notes`,`id_roles`) values (6,'Ketua','Pengadilan Tinggi','info@pt-bandung.go.id','-','022-87832124','Jl. Cimuncang No.21 D','Bandung','Jawa Baarat','','',2);
insert  into `ea_users`(`id`,`first_name`,`last_name`,`email`,`mobile_number`,`phone_number`,`address`,`city`,`state`,`zip_code`,`notes`,`id_roles`) values (7,'Prio Wijayanto','BHP Jakarta, Kemenkumham DKI Jakarta','priobhp@gmail.com',NULL,'081291334131','Jl. MT. Haryono No.24, Cawang Atas','Jakarta Timur',NULL,'13630',NULL,3);
insert  into `ea_users`(`id`,`first_name`,`last_name`,`email`,`mobile_number`,`phone_number`,`address`,`city`,`state`,`zip_code`,`notes`,`id_roles`) values (8,'Sekretaris','Pengadilan Tinggi','sekretaris@pt-bandung.go.id','-','022-87832124','Jl. Cimuncang No.21 D','Bandung','Jawa Barat','','',2);
insert  into `ea_users`(`id`,`first_name`,`last_name`,`email`,`mobile_number`,`phone_number`,`address`,`city`,`state`,`zip_code`,`notes`,`id_roles`) values (9,'Artia Irianti, A.Md.','Pengadilan TInggi','artia@pt-bandung.go.id','085860064575','085860064575','JL. Cimuncang No.21 D','Bandung','Jawa Barat','','',4);
insert  into `ea_users`(`id`,`first_name`,`last_name`,`email`,`mobile_number`,`phone_number`,`address`,`city`,`state`,`zip_code`,`notes`,`id_roles`) values (10,'artia','tes','artiairianti11@gmail.com',NULL,'085860064575','bandung','bandung',NULL,'4015','diundur',3);
insert  into `ea_users`(`id`,`first_name`,`last_name`,`email`,`mobile_number`,`phone_number`,`address`,`city`,`state`,`zip_code`,`notes`,`id_roles`) values (11,'wisnu /AAI','AAI','www.wisnubanget@yahoo.co.id',NULL,'085222210916','jakarta','jakarta',NULL,'43280',NULL,3);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
