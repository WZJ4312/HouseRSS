/*
Navicat MySQL Data Transfer

Source Server         : renxu
Source Server Version : 50644
Source Host           : 127.0.0.1:3306
Source Database       : houserss

Target Server Type    : MYSQL
Target Server Version : 50644
File Encoding         : 65001

Date: 2019-06-02 14:09:23
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for houserss_deletehouse
-- ----------------------------
DROP TABLE IF EXISTS `houserss_deletehouse`;
CREATE TABLE `houserss_deletehouse` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) DEFAULT NULL,
  `houseId` int(11) DEFAULT NULL,
  `deleteDate` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of houserss_deletehouse
-- ----------------------------
INSERT INTO `houserss_deletehouse` VALUES ('13', '2', '10', '2019-05-06');

-- ----------------------------
-- Table structure for houserss_house
-- ----------------------------
DROP TABLE IF EXISTS `houserss_house`;
CREATE TABLE `houserss_house` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sellType` int(11) DEFAULT NULL,
  `zone` varchar(11) DEFAULT NULL,
  `houseType` int(11) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `orientation` int(11) DEFAULT NULL,
  `floor` int(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `decorateType` int(11) DEFAULT NULL,
  `decoration` varchar(255) DEFAULT NULL,
  `isHide` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `area` int(11) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `userId` int(11) DEFAULT NULL,
  `imageInfos` text,
  `publishDate` varchar(255) DEFAULT NULL,
  `reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of houserss_house
-- ----------------------------
INSERT INTO `houserss_house` VALUES ('10', '1', '北京_西城区', '0', '1', '0', '1', 'test', '0', 'test', '0', '3', '1', 'test', '2', 'upload\\2019-05-06\\2_66a123a1-5294-457e-9181-712d0749f1b2.jpg', '2019-05-06', null);
INSERT INTO `houserss_house` VALUES ('11', '0', '北京_东城区', '0', '5000', '0', '6', '明日嘉园出租一居室，价格可商量', '0', '地段好，位置佳', '0', '1', '10', '北京市海淀区中关村街道1号', '2', 'upload\\2019-06-02\\2_e86f5968-7a00-4ed2-b4cb-31d45b17a4d9.jpg', '2019-06-02', null);

-- ----------------------------
-- Table structure for houserss_houselog
-- ----------------------------
DROP TABLE IF EXISTS `houserss_houselog`;
CREATE TABLE `houserss_houselog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `houseId` int(11) DEFAULT NULL,
  `eventId` int(11) DEFAULT NULL,
  `logDate` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of houserss_houselog
-- ----------------------------
INSERT INTO `houserss_houselog` VALUES ('16', '10', '0', '2019-05-06');
INSERT INTO `houserss_houselog` VALUES ('17', '11', '0', '2019-06-02');

-- ----------------------------
-- Table structure for houserss_reportinfo
-- ----------------------------
DROP TABLE IF EXISTS `houserss_reportinfo`;
CREATE TABLE `houserss_reportinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reporterId` int(11) DEFAULT NULL,
  `reportederId` int(11) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `reportDate` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `isSuccess` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of houserss_reportinfo
-- ----------------------------
INSERT INTO `houserss_reportinfo` VALUES ('14', '2', '2', '0', '2019-05-06', 'test', '0', '1');
INSERT INTO `houserss_reportinfo` VALUES ('15', '2', '10', '1', '2019-05-06', 'test', '1', '1');

-- ----------------------------
-- Table structure for houserss_user
-- ----------------------------
DROP TABLE IF EXISTS `houserss_user`;
CREATE TABLE `houserss_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `status` int(255) DEFAULT NULL,
  `roleType` int(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of houserss_user
-- ----------------------------
INSERT INTO `houserss_user` VALUES ('1', 'admin', '管理员', '8D223A2A35C5A05467F1FF10537C7915', '88888888@qq.com', '110', '0', '1');
INSERT INTO `houserss_user` VALUES ('2', 'cw', 'cw', '149C8AF75CD7190FDA10210906427EA2', '99999999@qq.com', '99999', '0', '0');

-- ----------------------------
-- Table structure for houserss_userlog
-- ----------------------------
DROP TABLE IF EXISTS `houserss_userlog`;
CREATE TABLE `houserss_userlog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) DEFAULT NULL,
  `eventId` int(11) DEFAULT NULL,
  `logDate` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of houserss_userlog
-- ----------------------------
INSERT INTO `houserss_userlog` VALUES ('36', '2', '0', '2019-05-06');
INSERT INTO `houserss_userlog` VALUES ('37', '1', '0', '2019-05-06');
INSERT INTO `houserss_userlog` VALUES ('38', '2', '0', '2019-05-06');
INSERT INTO `houserss_userlog` VALUES ('39', '2', '0', '2019-05-06');
INSERT INTO `houserss_userlog` VALUES ('40', '1', '0', '2019-05-06');
INSERT INTO `houserss_userlog` VALUES ('41', '2', '0', '2019-05-06');
INSERT INTO `houserss_userlog` VALUES ('42', '1', '0', '2019-05-06');
INSERT INTO `houserss_userlog` VALUES ('43', '2', '0', '2019-05-06');
INSERT INTO `houserss_userlog` VALUES ('44', '2', '0', '2019-06-02');
INSERT INTO `houserss_userlog` VALUES ('45', '1', '0', '2019-06-02');
