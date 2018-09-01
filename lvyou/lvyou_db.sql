-- phpMyAdmin SQL Dump
-- version 3.0.1.1
-- http://www.phpmyadmin.net
--
-- 服务器版本: 5.1.29
-- PHP 版本: 5.2.6

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

-- --------------------------------------------------------

-- ----------------------------
-- Table structure for `admin`
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `username` varchar(20) NOT NULL DEFAULT '',
  `password` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_admin
-- ----------------------------
INSERT INTO `admin` VALUES ('a', 'a'); 

CREATE TABLE IF NOT EXISTS `t_userInfo` (
  `user_name` varchar(20)  NOT NULL COMMENT 'user_name',
  `password` varchar(20)  NOT NULL COMMENT '登录密码',
  `name` varchar(20)  NOT NULL COMMENT '姓名',
  `sex` varchar(4)  NOT NULL COMMENT '性别',
  `userPhoto` varchar(60)  NOT NULL COMMENT '用户照片',
  `birthday` varchar(20)  NULL COMMENT '出生日期',
  `telephone` varchar(20)  NOT NULL COMMENT '联系电话',
  `address` varchar(50)  NOT NULL COMMENT '家庭地址',
  PRIMARY KEY (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `t_scenicType` (
  `typeId` int(11) NOT NULL AUTO_INCREMENT COMMENT '类型id',
  `typeName` varchar(20)  NOT NULL COMMENT '类别名称',
  PRIMARY KEY (`typeId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_city` (
  `cityNo` varchar(20)  NOT NULL COMMENT 'cityNo',
  `cityName` varchar(20)  NOT NULL COMMENT '城市名称',
  PRIMARY KEY (`cityNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `t_scenic` (
  `scenicId` int(11) NOT NULL AUTO_INCREMENT COMMENT '景区id',
  `cityObj` varchar(20)  NOT NULL COMMENT '所在城市',
  `scenicTypeObj` int(11) NOT NULL COMMENT '景点类型',
  `dengji` varchar(20)  NOT NULL COMMENT '景点等级',
  `scenicName` varchar(30)  NOT NULL COMMENT '景点名称',
  `scenicPhoto` varchar(60)  NOT NULL COMMENT '景区图片',
  `scenicDesc` varchar(2000)  NOT NULL COMMENT '景点介绍',
  `price` float NOT NULL COMMENT '门票价格',
  `openTime` varchar(30)  NOT NULL COMMENT '开放时间',
  `address` varchar(60)  NOT NULL COMMENT '景点地址',
  PRIMARY KEY (`scenicId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_comment` (
  `commentId` int(11) NOT NULL AUTO_INCREMENT COMMENT '评论id',
  `scenicObj` int(11) NOT NULL COMMENT '被评景点',
  `commentContent` varchar(30)  NOT NULL COMMENT '评论内容',
  `userObj` varchar(20)  NOT NULL COMMENT '评论人',
  `commentTime` varchar(20)  NULL COMMENT '评论时间',
  PRIMARY KEY (`commentId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_orderInfo` (
  `orderId` int(11) NOT NULL AUTO_INCREMENT COMMENT '订单id',
  `scenicObj` int(11) NOT NULL COMMENT '预定景点',
  `orderDate` varchar(20)  NULL COMMENT '预定日期',
  `price` float NOT NULL COMMENT '预定价格',
  `userObj` varchar(20)  NOT NULL COMMENT '预定用户',
  `orderTime` varchar(20)  NULL COMMENT '下单时间',
  `shState` varchar(20)  NOT NULL COMMENT '审核状态',
  PRIMARY KEY (`orderId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_leaveWord` (
  `leaveWordId` int(11) NOT NULL AUTO_INCREMENT COMMENT '留言id',
  `title` varchar(40)  NOT NULL COMMENT '标题',
  `leaveContent` varchar(2000)  NOT NULL COMMENT '留言内容',
  `addTime` varchar(20)  NULL COMMENT '留言时间',
  `userObj` varchar(20)  NOT NULL COMMENT '留言人',
  `replyContent` varchar(2000)  NULL COMMENT '回复内容',
  `replyTime` varchar(20)  NULL COMMENT '回复时间',
  PRIMARY KEY (`leaveWordId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

ALTER TABLE t_scenic ADD CONSTRAINT FOREIGN KEY (cityObj) REFERENCES t_city(cityNo);
ALTER TABLE t_scenic ADD CONSTRAINT FOREIGN KEY (scenicTypeObj) REFERENCES t_scenicType(typeId);
ALTER TABLE t_comment ADD CONSTRAINT FOREIGN KEY (scenicObj) REFERENCES t_scenic(scenicId);
ALTER TABLE t_comment ADD CONSTRAINT FOREIGN KEY (userObj) REFERENCES t_userInfo(user_name);
ALTER TABLE t_orderInfo ADD CONSTRAINT FOREIGN KEY (scenicObj) REFERENCES t_scenic(scenicId);
ALTER TABLE t_orderInfo ADD CONSTRAINT FOREIGN KEY (userObj) REFERENCES t_userInfo(user_name);
ALTER TABLE t_leaveWord ADD CONSTRAINT FOREIGN KEY (userObj) REFERENCES t_userInfo(user_name);


