/*
Navicat MySQL Data Transfer

Source Server         : local
Source Server Version : 50731
Source Host           : localhost:3306
Source Database       : dspmonitor

Target Server Type    : MYSQL
Target Server Version : 50731
File Encoding         : 65001

Date: 2022-06-06 21:01:56
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `pwd` varchar(100) DEFAULT NULL,
  `is_super` smallint(6) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL,
  `addtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `role_id` (`role_id`),
  KEY `ix_admin_addtime` (`addtime`),
  CONSTRAINT `admin_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('1', 'dxs', 'pbkdf2:sha256:50000$F1ZE4r9j$74f27183b391a85a3330dfaaccdbe15d564847b4b525247ce5ac5501050659d5', '0', '1', '2022-06-02 09:50:37');
INSERT INTO `admin` VALUES ('6', 'admin', 'pbkdf2:sha256:50000$xtMlKfLe$3939dbb5ba67a01850315bd0e9f89114a1ca96856a0ec18946eeb9b175268587', '0', '1', '2022-06-06 21:00:10');

-- ----------------------------
-- Table structure for adminlog
-- ----------------------------
DROP TABLE IF EXISTS `adminlog`;
CREATE TABLE `adminlog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_id` int(11) DEFAULT NULL,
  `ip` varchar(100) DEFAULT NULL,
  `addtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `admin_id` (`admin_id`),
  KEY `ix_adminlog_addtime` (`addtime`),
  CONSTRAINT `adminlog_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `admin` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of adminlog
-- ----------------------------
INSERT INTO `adminlog` VALUES ('1', '1', '127.0.0.1', '2022-06-02 09:52:05');
INSERT INTO `adminlog` VALUES ('2', '1', '127.0.0.1', '2022-06-02 09:52:59');
INSERT INTO `adminlog` VALUES ('3', '1', '127.0.0.1', '2022-06-02 15:43:33');
INSERT INTO `adminlog` VALUES ('4', '1', '127.0.0.1', '2022-06-02 15:45:32');
INSERT INTO `adminlog` VALUES ('5', '1', '127.0.0.1', '2022-06-06 09:45:04');
INSERT INTO `adminlog` VALUES ('6', '1', '127.0.0.1', '2022-06-06 20:05:17');
INSERT INTO `adminlog` VALUES ('7', '6', '127.0.0.1', '2022-06-06 21:01:15');

-- ----------------------------
-- Table structure for alembic_version
-- ----------------------------
DROP TABLE IF EXISTS `alembic_version`;
CREATE TABLE `alembic_version` (
  `version_num` varchar(32) NOT NULL,
  PRIMARY KEY (`version_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of alembic_version
-- ----------------------------
INSERT INTO `alembic_version` VALUES ('69c79e79783a');

-- ----------------------------
-- Table structure for auth
-- ----------------------------
DROP TABLE IF EXISTS `auth`;
CREATE TABLE `auth` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `addtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `url` (`url`),
  KEY `ix_auth_addtime` (`addtime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth
-- ----------------------------

-- ----------------------------
-- Table structure for cameras
-- ----------------------------
DROP TABLE IF EXISTS `cameras`;
CREATE TABLE `cameras` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `camera_type` varchar(200) NOT NULL,
  `ip_addr` varchar(200) NOT NULL,
  `rstp_port` int(11) NOT NULL,
  `camera_status` int(11) NOT NULL,
  `addtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ip_addr` (`ip_addr`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of cameras
-- ----------------------------
INSERT INTO `cameras` VALUES ('2', 'DS-2CD5A26EFWD-IZ', '114.213.214.44', '554', '0', '2022-06-06 15:25:49');
INSERT INTO `cameras` VALUES ('3', 'DS-2CD3T47EWDV3-L', '114.213.214.241', '554', '0', '2022-06-06 20:49:38');

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` text,
  `movie_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `addtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `movie_id` (`movie_id`),
  KEY `user_id` (`user_id`),
  KEY `ix_comment_addtime` (`addtime`),
  CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`movie_id`) REFERENCES `movie` (`id`),
  CONSTRAINT `comment_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of comment
-- ----------------------------

-- ----------------------------
-- Table structure for movie
-- ----------------------------
DROP TABLE IF EXISTS `movie`;
CREATE TABLE `movie` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `info` text,
  `logo` varchar(255) DEFAULT NULL,
  `star` smallint(6) DEFAULT NULL,
  `playnum` bigint(20) DEFAULT NULL,
  `commentnum` bigint(20) DEFAULT NULL,
  `tag_id` int(11) DEFAULT NULL,
  `area` varchar(255) DEFAULT NULL,
  `release_time` date DEFAULT NULL,
  `length` varchar(100) DEFAULT NULL,
  `addtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`),
  UNIQUE KEY `url` (`url`),
  UNIQUE KEY `logo` (`logo`),
  KEY `tag_id` (`tag_id`),
  KEY `ix_movie_addtime` (`addtime`),
  CONSTRAINT `movie_ibfk_1` FOREIGN KEY (`tag_id`) REFERENCES `tag` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of movie
-- ----------------------------

-- ----------------------------
-- Table structure for moviecol
-- ----------------------------
DROP TABLE IF EXISTS `moviecol`;
CREATE TABLE `moviecol` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `movie_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `addtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `movie_id` (`movie_id`),
  KEY `user_id` (`user_id`),
  KEY `ix_moviecol_addtime` (`addtime`),
  CONSTRAINT `moviecol_ibfk_1` FOREIGN KEY (`movie_id`) REFERENCES `movie` (`id`),
  CONSTRAINT `moviecol_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of moviecol
-- ----------------------------

-- ----------------------------
-- Table structure for oplog
-- ----------------------------
DROP TABLE IF EXISTS `oplog`;
CREATE TABLE `oplog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_id` int(11) DEFAULT NULL,
  `ip` varchar(100) DEFAULT NULL,
  `reason` varchar(600) DEFAULT NULL,
  `addtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `admin_id` (`admin_id`),
  KEY `ix_oplog_addtime` (`addtime`),
  CONSTRAINT `oplog_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `admin` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of oplog
-- ----------------------------
INSERT INTO `oplog` VALUES ('1', '1', '127.0.0.1', '删除摄像头:[114.213.214.241]', '2022-06-06 15:28:30');
INSERT INTO `oplog` VALUES ('2', '1', '127.0.0.1', '删除摄像头:[114.213.214.250]', '2022-06-06 20:12:14');
INSERT INTO `oplog` VALUES ('3', '1', '127.0.0.1', '删除摄像头:[114.213.214.77]', '2022-06-06 20:22:55');
INSERT INTO `oplog` VALUES ('4', '1', '127.0.0.1', '删除摄像头:[114.213.214.444]', '2022-06-06 20:49:24');

-- ----------------------------
-- Table structure for preview
-- ----------------------------
DROP TABLE IF EXISTS `preview`;
CREATE TABLE `preview` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `addtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`),
  UNIQUE KEY `logo` (`logo`),
  KEY `ix_preview_addtime` (`addtime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of preview
-- ----------------------------

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `auths` varchar(600) DEFAULT NULL,
  `addtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `ix_role_addtime` (`addtime`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('1', '超级管理员', '', '2022-06-02 09:50:37');

-- ----------------------------
-- Table structure for tag
-- ----------------------------
DROP TABLE IF EXISTS `tag`;
CREATE TABLE `tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `addtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `ix_tag_addtime` (`addtime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tag
-- ----------------------------

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `pwd` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(11) DEFAULT NULL,
  `info` text,
  `face` varchar(255) DEFAULT NULL,
  `addtime` datetime DEFAULT NULL,
  `uuid` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `phone` (`phone`),
  UNIQUE KEY `face` (`face`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `ix_user_addtime` (`addtime`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('2', '阿尼亚今晚吃什么', 'pbkdf2:sha256:50000$LckvUjXz$d01a1a474c7a92f138cef4e99ba8193e46320cc7328ab1c14e507bdc32dd6a98', '978548365@qq.com', '13955810102', null, null, '2022-05-14 09:53:28', 'e132c12f063f4dd98a85e03af75e126e');

-- ----------------------------
-- Table structure for userlog
-- ----------------------------
DROP TABLE IF EXISTS `userlog`;
CREATE TABLE `userlog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `ip` varchar(100) DEFAULT NULL,
  `addtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `ix_userlog_addtime` (`addtime`),
  CONSTRAINT `userlog_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of userlog
-- ----------------------------
INSERT INTO `userlog` VALUES ('3', '2', '127.0.0.1', '2022-05-14 09:53:44');
INSERT INTO `userlog` VALUES ('4', '2', '127.0.0.1', '2022-05-14 09:58:15');
INSERT INTO `userlog` VALUES ('5', '2', '127.0.0.1', '2022-05-30 09:47:07');
