/*
Navicat MySQL Data Transfer

Source Server         : J
Source Server Version : 50628
Source Host           : gz-cdb-9pis4q35.sql.tencentcdb.com:62520
Source Database       : t4-boot

Target Server Type    : MYSQL
Target Server Version : 50628
File Encoding         : 65001

Date: 2020-06-18 21:41:00
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for example_common
-- ----------------------------
DROP TABLE IF EXISTS `example_common`;
CREATE TABLE `example_common` (
  `id` varchar(32) NOT NULL,
  `str` varchar(150) NOT NULL COMMENT '字符串查询',
  `txt` text NOT NULL COMMENT '长文本查询',
  `num` int(4) NOT NULL COMMENT '数字类型查询',
  `query_date` date DEFAULT NULL COMMENT '日期查询',
  `query_date_time` datetime DEFAULT NULL COMMENT '日期时间查询',
  `query_time` time DEFAULT NULL COMMENT '时间查询',
  `create_by` varchar(32) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `update_by` varchar(32) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='通用示例';

-- ----------------------------
-- Records of example_common
-- ----------------------------
INSERT INTO `example_common` VALUES ('efd3ecaedc1ce8dccb374c10723b2ce0', '测试字符串', '测试字符串测试字符串测试字符串测试字符串测试字符串测试字符串测试字符串测试字符串测试字符串测试字符串测试字符串测试字符串测试字符串测试字符串测试字符串测试字符串测试字符串测试字符串测试字符串测试字符串测试字符串测试字符串测试字符串测试字符串', '707', '2020-03-12', '2020-03-31 22:25:51', '22:19:37', 'admin', '2020-03-31 22:23:19', 'admin', '2020-03-31 22:23:20');

-- ----------------------------
-- Table structure for sup_message
-- ----------------------------
DROP TABLE IF EXISTS `sup_message`;
CREATE TABLE `sup_message` (
  `id` varchar(32) NOT NULL COMMENT 'ID',
  `title` varchar(100) DEFAULT NULL COMMENT '消息标题',
  `message_type` tinyint(1) NOT NULL COMMENT '发送方式：1短信 2邮件 3微信 4站内信 ',
  `target` varchar(100) NOT NULL COMMENT '接收人',
  `param` varchar(1000) DEFAULT NULL COMMENT '动态参数：Json格式',
  `content` longtext NOT NULL COMMENT '内容',
  `send_time` datetime NOT NULL COMMENT '推送时间',
  `send_num` int(11) NOT NULL DEFAULT '0' COMMENT '发送次数 超过5次不再发送',
  `send_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '推送状态 0未推送 1推送成功 2推送失败 -1失败不再发送',
  `send_result` varchar(255) DEFAULT NULL COMMENT '推送失败原因',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `tenant_id` varchar(32) CHARACTER SET utf8mb4 DEFAULT '-1' COMMENT '租户ID',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人登录名称',
  `create_time` datetime DEFAULT NULL COMMENT '创建日期',
  `update_by` varchar(32) DEFAULT NULL COMMENT '更新人登录名称',
  `update_time` datetime DEFAULT NULL COMMENT '更新日期',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `index_type` (`message_type`) USING BTREE,
  KEY `index_target` (`target`) USING BTREE,
  KEY `index_status` (`send_status`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='消息列表';

-- ----------------------------
-- Records of sup_message
-- ----------------------------

-- ----------------------------
-- Table structure for sup_message_template
-- ----------------------------
DROP TABLE IF EXISTS `sup_message_template`;
CREATE TABLE `sup_message_template` (
  `id` varchar(32) NOT NULL COMMENT '主键',
  `template_code` varchar(32) NOT NULL COMMENT '模板CODE',
  `template_name` varchar(50) DEFAULT NULL COMMENT '模板标题',
  `template_type` tinyint(2) NOT NULL COMMENT '模板类型：1短信 2邮件 3微信 4站内信',
  `template_content` longtext COMMENT '模板内容',
  `tenant_id` varchar(32) CHARACTER SET utf8mb4 DEFAULT '-1' COMMENT '租户ID',
  `create_time` datetime DEFAULT NULL COMMENT '创建日期',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人登录名称',
  `update_time` datetime DEFAULT NULL COMMENT '更新日期',
  `update_by` varchar(32) DEFAULT NULL COMMENT '更新人登录名称',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_templatecode` (`template_code`,`tenant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='消息模板';

-- ----------------------------
-- Records of sup_message_template
-- ----------------------------
INSERT INTO `sup_message_template` VALUES ('775c4c1f38389540d7132abe1557cc7f', 'PHONE-CAPTCHA', '用户手机验证码', '1', '{\"signName\":\"LTBS\",\"code\":\"SMS_186942404\"}', '-1', '2020-04-08 17:11:47', 'TeaR', '0000-00-00 00:00:00', '');
INSERT INTO `sup_message_template` VALUES ('875c4c1f38389540d7132abe1557cc7f', 'EMAIL-CAPTCHA', '${username},您的验证码【T4Cloud】', '2', '${username},您的验证码为${code}，三十分钟内有效，请妥善保管。【T4Cloud】', '-1', '2020-04-08 15:08:35', 'admin', '0000-00-00 00:00:00', '');
INSERT INTO `sup_message_template` VALUES ('f6f311e79c573b3a8652b386cd9b7390', 'TEST', '${username}，T4Cloud验证码', '2', 'hi，${username}，请妥善保管您的动态密码${code}，有效期为30分钟。', '-1', '2020-03-26 17:57:18', 'admin', '2020-04-21 16:01:38', 'demo');

-- ----------------------------
-- Table structure for sup_resource
-- ----------------------------
DROP TABLE IF EXISTS `sup_resource`;
CREATE TABLE `sup_resource` (
  `id` varchar(32) NOT NULL COMMENT '主键id',
  `name` varchar(100) NOT NULL COMMENT '资源名称',
  `path` varchar(500) NOT NULL COMMENT '相对路径',
  `url` varchar(1000) NOT NULL COMMENT '完整资源路径',
  `bucket` varchar(50) DEFAULT NULL COMMENT '桶名',
  `mime_type` varchar(50) DEFAULT NULL COMMENT '资源类型',
  `policy` tinyint(2) NOT NULL DEFAULT '1' COMMENT '权限策略（1-公开，2-私有）',
  `expire_time` datetime DEFAULT NULL COMMENT '失效时间',
  `count` int(8) NOT NULL DEFAULT '0' COMMENT '总访问次数',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) DEFAULT NULL COMMENT '最后访问人',
  `update_time` datetime DEFAULT NULL COMMENT '最后访问时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `path` (`path`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='资源管理表';

-- ----------------------------
-- Records of sup_resource
-- ----------------------------
INSERT INTO `sup_resource` VALUES ('948474245fcc99b7febb0ffd00e4f24a', 'Kids.jpg', '/open/admin/2020/Kids_1592384149291.jpg', 'http://139.224.227.28:18030/t4cloud/open/admin/2020/Kids_1592384149291.jpg', 't4cloud', 'image/jpeg', '1', '2020-07-17 16:55:49', '3', 'admin', '2020-06-17 16:55:50', 'admin', '2020-06-17 16:55:54');
INSERT INTO `sup_resource` VALUES ('fc132bb5a87ea8d30423368edcac5e0e', '905fdc367b7f37f222aef0adaeedd2ad.jpg', '/open/admin/2020/905fdc367b7f37f222aef0adaeedd2ad_1592384201125.jpg', 'http://139.224.227.28:18030/t4cloud/open/admin/2020/905fdc367b7f37f222aef0adaeedd2ad_1592384201125.jpg', 't4cloud', 'image/jpeg', '1', '2020-07-17 16:56:41', '18', 'admin', '2020-06-17 16:56:41', null, '2020-06-18 21:21:37');

-- ----------------------------
-- Table structure for sys_company
-- ----------------------------
DROP TABLE IF EXISTS `sys_company`;
CREATE TABLE `sys_company` (
  `id` varchar(32) NOT NULL COMMENT 'ID',
  `name` varchar(100) NOT NULL COMMENT '公司名',
  `name_en` varchar(500) DEFAULT NULL COMMENT '英文名',
  `name_abbr` varchar(500) DEFAULT NULL COMMENT '公司名缩写',
  `description` text COMMENT '描述',
  `phone` varchar(32) DEFAULT NULL COMMENT '联系方式',
  `fax` varchar(32) DEFAULT NULL COMMENT '传真',
  `address` varchar(300) DEFAULT NULL COMMENT '地址',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `status` tinyint(1) DEFAULT NULL COMMENT '状态',
  `tenant_id` varchar(640) CHARACTER SET utf8mb4 DEFAULT '-1' COMMENT '租户ID',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建日期',
  `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新日期',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='公司表';

-- ----------------------------
-- Records of sys_company
-- ----------------------------
INSERT INTO `sys_company` VALUES ('-1', 'T4Cloud', 'T4Cloud', 'T.4.C', '微服务快速开发框架', '178xxxx1004', '178xxxx1004', '上海', '开源组织', '1', '-1', 'TeaR', '2020-04-15 11:38:43', 'admin', '2020-04-15 12:07:26');

-- ----------------------------
-- Table structure for sys_dict
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE `sys_dict` (
  `id` varchar(32) CHARACTER SET utf8 NOT NULL,
  `name` varchar(100) CHARACTER SET utf8 NOT NULL COMMENT '字典名称',
  `code` varchar(100) CHARACTER SET utf8 NOT NULL COMMENT '字典编码',
  `description` text CHARACTER SET utf8 COMMENT '描述',
  `status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '删除状态',
  `create_by` varchar(32) CHARACTER SET utf8 DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) CHARACTER SET utf8 DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `indextable_dict_code` (`code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='字典';

-- ----------------------------
-- Records of sys_dict
-- ----------------------------
INSERT INTO `sys_dict` VALUES ('049d8f8d39bfed55fe8d6ccd317c9e78', '消息类型', 'msg_template_type', '', '1', 'admin', '2020-03-26 17:35:59', 'admin', '2020-03-31 22:06:22');
INSERT INTO `sys_dict` VALUES ('1', '通用状态', 'common_status', '通用状态', '1', 'TeaR', '2019-02-09 13:17:15', 'admin', '2020-03-15 19:55:24');
INSERT INTO `sys_dict` VALUES ('1117af12dec6f9ed3adf81a4b0fc3b3b', '日志类型', 'log_type', '', '1', 'admin', '2020-03-27 14:13:00', '', '0000-00-00 00:00:00');
INSERT INTO `sys_dict` VALUES ('1ba37859b072ead1bc8daa03cad669f3', '资源策略', 'policy_type', '', '1', 'admin', '2020-03-26 11:20:08', '', '0000-00-00 00:00:00');
INSERT INTO `sys_dict` VALUES ('2', '性别', 'gender', '性别', '1', 'TeaR', '2020-03-04 14:13:28', 'admin', '2020-03-15 20:37:41');
INSERT INTO `sys_dict` VALUES ('26405b1615e6646eb670f34de100dd80', '权限类型', 'menu_type', '', '1', 'admin', '2020-04-14 17:33:20', '', '0000-00-00 00:00:00');
INSERT INTO `sys_dict` VALUES ('84290353c8b63fb5f76a949cf976890b', '打开方式', 'open_type', '', '1', 'admin', '2020-03-17 21:19:38', '', '0000-00-00 00:00:00');
INSERT INTO `sys_dict` VALUES ('ad2cce5a0c32d8efbd72b718534bcfb4', '消息发送状态', 'msg_send_status', '', '1', 'admin', '2020-03-31 18:26:33', '', '0000-00-00 00:00:00');
INSERT INTO `sys_dict` VALUES ('c6b035b3df1bd679ebe1f943c68aed78', '操作类型', 'operate_type', '', '1', 'admin', '2020-03-27 14:19:09', '', '0000-00-00 00:00:00');
INSERT INTO `sys_dict` VALUES ('d8259873aece0de66f404a3ef5ff5881', '通用结果', 'common_valid', '', '1', 'admin', '2020-03-27 14:22:11', '', '0000-00-00 00:00:00');
INSERT INTO `sys_dict` VALUES ('ea1805d1916382d77c72502300ce17ff', '微信配置类型', 'we_code_type', '', '1', 'admin', '2020-04-27 17:36:49', '', '0000-00-00 00:00:00');
INSERT INTO `sys_dict` VALUES ('ed77389295a5d4c90c9ade1b2671c336', '隐藏', 'hidden', '', '1', 'admin', '2020-03-17 21:15:16', 'admin', '2020-03-17 21:15:29');

-- ----------------------------
-- Table structure for sys_dict_value
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_value`;
CREATE TABLE `sys_dict_value` (
  `id` varchar(32) CHARACTER SET utf8 NOT NULL,
  `dict_id` varchar(32) CHARACTER SET utf8 DEFAULT NULL COMMENT '字典id',
  `text` varchar(100) CHARACTER SET utf8 DEFAULT NULL COMMENT '字典项文本',
  `value` int(10) DEFAULT NULL COMMENT '字典项值',
  `description` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '描述',
  `position` int(10) DEFAULT NULL COMMENT '排序',
  `status` tinyint(2) DEFAULT NULL COMMENT '状态（1启用 0不启用）',
  `create_by` varchar(32) CHARACTER SET utf8 DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_by` varchar(32) CHARACTER SET utf8 DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `key_uni` (`dict_id`,`value`) USING BTREE,
  KEY `index_table_dict_id` (`dict_id`) USING BTREE,
  KEY `index_table_sort_order` (`position`) USING BTREE,
  KEY `index_table_dict_status` (`status`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='字典详细值';

-- ----------------------------
-- Records of sys_dict_value
-- ----------------------------
INSERT INTO `sys_dict_value` VALUES ('01dff238bc819fa50bc86d8ee56c9b05', 'd8259873aece0de66f404a3ef5ff5881', '异常', '0', '', '0', '1', 'admin', '2020-03-27 14:22:28', '', '0000-00-00 00:00:00');
INSERT INTO `sys_dict_value` VALUES ('05915cf6352322cf6b312422d669556d', '84290353c8b63fb5f76a949cf976890b', '新标签打开', '1', '', '10', '1', 'admin', '2020-03-17 21:20:20', '', '0000-00-00 00:00:00');
INSERT INTO `sys_dict_value` VALUES ('1', '1', '生效', '1', '', '1', '1', 'TeaR', '2019-02-09 13:18:47', 'admin', '2020-03-15 20:37:31');
INSERT INTO `sys_dict_value` VALUES ('1753abc515ca2d18ad4d9e1c29d1d27d', 'ad2cce5a0c32d8efbd72b718534bcfb4', '停止发送', '-1', '', '-1', '1', 'admin', '2020-03-31 18:27:39', '', '0000-00-00 00:00:00');
INSERT INTO `sys_dict_value` VALUES ('197ca6841779dd9b8d028d81e4ab3f5c', 'ed77389295a5d4c90c9ade1b2671c336', '隐藏', '0', '', '10', '1', 'admin', '2020-03-17 21:16:11', 'admin', '2020-03-26 10:24:52');
INSERT INTO `sys_dict_value` VALUES ('2', '1', '失效', '0', '', '2', '1', 'TeaR', '2019-02-09 13:18:47', '', '0000-00-00 00:00:00');
INSERT INTO `sys_dict_value` VALUES ('28fa16682964ccb0e792020d153d3197', '1117af12dec6f9ed3adf81a4b0fc3b3b', '用户操作', '3', '', '3', '1', 'admin', '2020-03-27 14:13:29', '', '0000-00-00 00:00:00');
INSERT INTO `sys_dict_value` VALUES ('4', '2', '男', '1', '', '1', '1', 'TeaR', '2020-03-04 14:14:44', 'admin', '2020-03-26 10:25:23');
INSERT INTO `sys_dict_value` VALUES ('408974ceb7cb2bfc8fd36248c91f5504', 'd8259873aece0de66f404a3ef5ff5881', '正常', '1', '', '1', '1', 'admin', '2020-03-27 14:22:21', '', '0000-00-00 00:00:00');
INSERT INTO `sys_dict_value` VALUES ('4abf5aee23a3d29d1607ed04abe00d6f', 'ad2cce5a0c32d8efbd72b718534bcfb4', '推送成功', '1', '', '1', '1', 'admin', '2020-03-31 18:27:11', '', '0000-00-00 00:00:00');
INSERT INTO `sys_dict_value` VALUES ('4e4d3dcf8e89da8410a1a5e2f7ff1695', 'c6b035b3df1bd679ebe1f943c68aed78', '查', '4', '', '4', '1', 'admin', '2020-03-27 14:21:11', '', '0000-00-00 00:00:00');
INSERT INTO `sys_dict_value` VALUES ('5', '2', '女', '2', '', '2', '1', 'TeaR', '2020-03-04 14:14:44', '', '0000-00-00 00:00:00');
INSERT INTO `sys_dict_value` VALUES ('5ec67b8617b5944efed297be465e810b', '049d8f8d39bfed55fe8d6ccd317c9e78', '邮件', '2', '', '2', '1', 'admin', '2020-03-26 17:36:27', 'admin', '2020-04-01 12:24:24');
INSERT INTO `sys_dict_value` VALUES ('6a9cb93f261616fa58464506ba9d1e0a', 'ad2cce5a0c32d8efbd72b718534bcfb4', '推送失败', '2', '', '2', '1', 'admin', '2020-03-31 18:27:19', '', '0000-00-00 00:00:00');
INSERT INTO `sys_dict_value` VALUES ('74400d676a33ddbd4a2573ae0652f2b6', 'c6b035b3df1bd679ebe1f943c68aed78', '删', '2', '', '2', '0', 'admin', '2020-03-27 14:20:15', 'admin', '2020-03-30 18:31:10');
INSERT INTO `sys_dict_value` VALUES ('745c2eae51ccc41e6cda1be80484515e', '1ba37859b072ead1bc8daa03cad669f3', '公开', '1', '', '1', '1', 'admin', '2020-03-26 11:20:26', '', '0000-00-00 00:00:00');
INSERT INTO `sys_dict_value` VALUES ('77c0b3c95e8ed92fa98883b5ed133d34', '1117af12dec6f9ed3adf81a4b0fc3b3b', '登录日志', '2', '', '2', '1', 'admin', '2020-03-27 14:13:18', '', '0000-00-00 00:00:00');
INSERT INTO `sys_dict_value` VALUES ('7aff90e0935fac2e02b92fa36d371f38', '1117af12dec6f9ed3adf81a4b0fc3b3b', '定时任务', '4', '', '4', '1', 'admin', '2020-03-27 14:13:35', '', '0000-00-00 00:00:00');
INSERT INTO `sys_dict_value` VALUES ('85c9c15c5c4af870efa9965cc87b1f9d', '1117af12dec6f9ed3adf81a4b0fc3b3b', 'MQ日志', '5', '', '5', '1', 'admin', '2020-03-30 14:35:05', '', '0000-00-00 00:00:00');
INSERT INTO `sys_dict_value` VALUES ('86635d15e33c382229ec955d17cab2af', 'ed77389295a5d4c90c9ade1b2671c336', '展示', '1', '', '10', '1', 'admin', '2020-03-17 21:16:20', '', '0000-00-00 00:00:00');
INSERT INTO `sys_dict_value` VALUES ('8e7d06da5f809b8f3f55c5a5ca3493ca', '049d8f8d39bfed55fe8d6ccd317c9e78', '微信', '3', '', '3', '0', 'admin', '2020-03-31 23:22:43', 'admin', '2020-04-01 12:24:27');
INSERT INTO `sys_dict_value` VALUES ('953b4afc3a12a866bed18b8d9cbfa983', 'c6b035b3df1bd679ebe1f943c68aed78', '改', '3', '', '3', '1', 'admin', '2020-03-27 14:20:21', '', '0000-00-00 00:00:00');
INSERT INTO `sys_dict_value` VALUES ('99bd02975d1e446044fc6f6fe91494df', 'ea1805d1916382d77c72502300ce17ff', '微信公众号', '1', '', '1', '1', 'admin', '2020-04-27 17:37:11', '', '0000-00-00 00:00:00');
INSERT INTO `sys_dict_value` VALUES ('ad673c2106e04f2dfe04e4d2b6e4bc0f', '1117af12dec6f9ed3adf81a4b0fc3b3b', '其他日志', '6', '', '6', '1', 'admin', '2020-03-27 14:13:41', 'admin', '2020-03-30 14:34:55');
INSERT INTO `sys_dict_value` VALUES ('b787884dc3fc099fd7236e9ad3cc60b1', '049d8f8d39bfed55fe8d6ccd317c9e78', '站内信', '4', '', '4', '0', 'admin', '2020-03-31 23:23:07', 'admin', '2020-04-01 12:24:31');
INSERT INTO `sys_dict_value` VALUES ('cb9956370eb22276f9a5d26b211c67fe', 'b4222c4ab58f2d51586dcaab5226f7b5', '开启', '1', '', '1', '1', 'admin', '2020-04-16 18:28:09', '', '0000-00-00 00:00:00');
INSERT INTO `sys_dict_value` VALUES ('cec4d7deccec648416d069e9046730ff', '1ba37859b072ead1bc8daa03cad669f3', '私有', '2', '', '2', '1', 'admin', '2020-03-26 11:20:32', '', '0000-00-00 00:00:00');
INSERT INTO `sys_dict_value` VALUES ('d69854f5f233fab4c198e67f97d41d1f', 'ad2cce5a0c32d8efbd72b718534bcfb4', '待推送', '0', '', '0', '1', 'admin', '2020-03-31 18:27:00', 'admin', '2020-03-31 23:21:25');
INSERT INTO `sys_dict_value` VALUES ('d71d1657a2706d5d6b4e4dea573587de', 'c6b035b3df1bd679ebe1f943c68aed78', '增', '1', '', '1', '1', 'admin', '2020-03-27 14:20:09', '', '0000-00-00 00:00:00');
INSERT INTO `sys_dict_value` VALUES ('db3b414925124232e8ec15780a7b9563', '049d8f8d39bfed55fe8d6ccd317c9e78', '短信', '1', '', '1', '1', 'admin', '2020-03-26 17:36:17', 'admin', '2020-05-11 17:30:30');
INSERT INTO `sys_dict_value` VALUES ('dc8067157547cb491115aef50d9be6c0', '84290353c8b63fb5f76a949cf976890b', '页面内打开', '0', '', '10', '1', 'admin', '2020-03-17 21:20:10', '', '0000-00-00 00:00:00');
INSERT INTO `sys_dict_value` VALUES ('e72362771956e9b7fbff56963945c8f5', '1117af12dec6f9ed3adf81a4b0fc3b3b', '管理员操作', '1', '', '1', '1', 'admin', '2020-03-27 14:13:12', '', '0000-00-00 00:00:00');
INSERT INTO `sys_dict_value` VALUES ('ea01e1c04c56e1a9de77340f0f074dac', '26405b1615e6646eb670f34de100dd80', '按钮', '2', '', '2', '1', 'admin', '2020-04-14 17:33:46', '', '0000-00-00 00:00:00');
INSERT INTO `sys_dict_value` VALUES ('fcad0268ffcdc5a1d43c128f9a3eebda', 'b4222c4ab58f2d51586dcaab5226f7b5', '关闭', '0', '', '0', '1', 'admin', '2020-04-16 18:28:17', '', '0000-00-00 00:00:00');
INSERT INTO `sys_dict_value` VALUES ('fe858aae02b3df9497c0d21745de9624', '26405b1615e6646eb670f34de100dd80', '菜单', '0', '', '0', '1', 'admin', '2020-04-14 17:33:38', '', '0000-00-00 00:00:00');

-- ----------------------------
-- Table structure for sys_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE `sys_log` (
  `id` varchar(32) CHARACTER SET utf8 NOT NULL,
  `log_type` tinyint(2) DEFAULT NULL COMMENT '日志类型（1-管理员操作，2-登录日志，3-用户操作，4-定时任务，5-其他日志）',
  `log_content` varchar(100) DEFAULT NULL COMMENT '日志内容',
  `operate_type` tinyint(2) DEFAULT NULL COMMENT '操作类型(1-增，2-删，3-改，4-查)',
  `result` longtext COMMENT '操作结果记录',
  `result_type` tinyint(2) DEFAULT NULL COMMENT '是否异常（0-异常，1-正常）',
  `user_id` varchar(32) CHARACTER SET utf8 DEFAULT NULL COMMENT '操作用户账号',
  `username` varchar(100) CHARACTER SET utf8 DEFAULT NULL COMMENT '操作用户名称',
  `ip` varchar(100) CHARACTER SET utf8 DEFAULT NULL COMMENT 'IP',
  `method` varchar(500) CHARACTER SET utf8 DEFAULT NULL COMMENT '请求java方法',
  `request_url` varchar(255) DEFAULT NULL COMMENT '请求路径',
  `request_param` longtext COMMENT '请求参数',
  `request_type` varchar(10) CHARACTER SET utf8 DEFAULT NULL COMMENT '请求类型',
  `cost_time` bigint(20) DEFAULT NULL COMMENT '耗时',
  `tenant_id` varchar(32) DEFAULT '-1' COMMENT '租户ID',
  `create_by` varchar(32) CHARACTER SET utf8 DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) CHARACTER SET utf8 DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `index_table_user_id` (`user_id`) USING BTREE,
  KEY `index_logt_ype` (`log_type`) USING BTREE,
  KEY `index_operate_type` (`operate_type`) USING BTREE,
  KEY `index_log_type` (`create_time`) USING BTREE,
  KEY `index_logt_ype_and_operate_type` (`log_type`,`operate_type`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='系统日志表';

-- ----------------------------
-- Records of sys_log
-- ----------------------------
INSERT INTO `sys_log` VALUES ('51d80d022be8f0b8febad9020a6bbd40', '4', 'Redis监控任务', '3', null, '1', null, null, null, 'com.t4cloud.boot.core.service.job.RedisActuatorJob.saveRedisLiveInfo()', null, '[]', null, '12', '-7', '直接入库', '2020-06-18 21:41:00', null, null);

-- ----------------------------
-- Table structure for sys_permission
-- ----------------------------
DROP TABLE IF EXISTS `sys_permission`;
CREATE TABLE `sys_permission` (
  `id` varchar(32) NOT NULL COMMENT '主键id',
  `parent_id` varchar(32) DEFAULT NULL COMMENT '父id',
  `name` varchar(100) NOT NULL COMMENT '菜单标题',
  `url` varchar(255) DEFAULT NULL COMMENT '路径',
  `open_type` tinyint(2) DEFAULT NULL COMMENT '打开方式（0-框架内打开，1-新的页面打开）',
  `component` varchar(255) DEFAULT NULL COMMENT '组件',
  `menu_type` int(11) NOT NULL COMMENT '菜单类型(0:一级菜单; 1:子菜单:2:按钮权限)',
  `perms` varchar(255) DEFAULT NULL COMMENT '权限编码',
  `sort_no` double(8,2) NOT NULL DEFAULT '10.00' COMMENT '菜单排序',
  `icon` varchar(100) DEFAULT NULL COMMENT '菜单图标',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  `hidden` tinyint(2) DEFAULT '1' COMMENT '隐藏路由: 0-隐藏,1-展示',
  `status` tinyint(2) DEFAULT NULL COMMENT '按钮权限状态(0无效1有效)',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `index_prem_pid` (`parent_id`) USING BTREE,
  KEY `index_prem_sort_no` (`sort_no`) USING BTREE,
  KEY `index_menu_type` (`menu_type`) USING BTREE,
  KEY `index_menu_hidden` (`hidden`) USING BTREE,
  KEY `index_menu_status` (`status`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='菜单权限表';

-- ----------------------------
-- Records of sys_permission
-- ----------------------------
INSERT INTO `sys_permission` VALUES ('1227815647354331142', '154e80d6a31e578d2eaa8c4634b3e8da', '菜单权限', '/system/SysPermissionList', '0', 'system/SysPermissionList', '0', '', '9.00', 'el-icon-help', '菜单权限表-菜单', '1', '1', 'T4Cloud', '2020-02-13 12:44:16', 'admin', '2020-03-25 17:41:35');
INSERT INTO `sys_permission` VALUES ('1227815647354331143', '1227815647354331142', '菜单权限表_新增', '', null, '', '2', 'system:SysPermission:ADD', '11.00', 'el-icon-circle-plus-outline', '菜单权限表-新增按钮', '1', '1', 'T4Cloud', '2020-02-13 12:44:16', '', '0000-00-00 00:00:00');
INSERT INTO `sys_permission` VALUES ('1227815647354331144', '1227815647354331142', '菜单权限表_修改', '', null, '', '2', 'system:SysPermission:EDIT', '11.00', 'el-icon-edit', '菜单权限表-编辑按钮', '1', '1', 'T4Cloud', '2020-02-13 12:44:16', '', '0000-00-00 00:00:00');
INSERT INTO `sys_permission` VALUES ('1227815647354331145', '1227815647354331142', '菜单权限表_删除', '', null, '', '2', 'system:SysPermission:DELETE', '11.00', 'el-icon-delete', '菜单权限表-删除按钮', '1', '1', 'T4Cloud', '2020-02-13 12:44:16', '', '0000-00-00 00:00:00');
INSERT INTO `sys_permission` VALUES ('1227815647354331146', '1227815647354331142', '菜单权限表_查看', '', null, '', '2', 'system:SysPermission:VIEW', '11.00', 'el-icon-view', '菜单权限表-详情按钮', '1', '1', 'T4Cloud', '2020-02-13 12:44:16', '', '0000-00-00 00:00:00');
INSERT INTO `sys_permission` VALUES ('1227815647354331147', '1227815647354331142', '菜单权限表_导入', '', null, '', '2', 'system:SysPermission:IMPORT', '11.00', 'el-icon-upload2', '菜单权限表_导入', '1', '1', 'T4Cloud', '2020-02-13 12:44:16', '', '0000-00-00 00:00:00');
INSERT INTO `sys_permission` VALUES ('1227815647354331148', '1227815647354331142', '菜单权限表_导出', '', '0', '', '2', 'system:SysPermission:EXPORT', '11.00', 'el-icon-download', '菜单权限表_导出', '1', '1', 'T4Cloud', '2020-02-13 12:44:16', 'admin', '2020-03-20 11:02:34');
INSERT INTO `sys_permission` VALUES ('1230085853179052039', '154e80d6a31e578d2eaa8c4634b3e8da', '用户管理', '/user/SysUserList', '0', 'user/SysUserList', '0', '', '7.00', 'el-icon-user', '用户表-菜单', '1', '1', 'T4Cloud', '2020-02-19 19:08:35', 'admin', '2020-03-25 17:41:15');
INSERT INTO `sys_permission` VALUES ('1230085853179052040', '1230085853179052039', '用户表_新增', '', null, '', '2', 'user:SysUser:ADD', '11.00', 'el-icon-circle-plus-outline', '用户表-新增按钮', '1', '1', 'T4Cloud', '2020-02-19 19:08:35', '', '0000-00-00 00:00:00');
INSERT INTO `sys_permission` VALUES ('1230085853179052041', '1230085853179052039', '用户表_修改', '', null, '', '2', 'user:SysUser:EDIT', '12.00', 'el-icon-edit', '用户表-编辑按钮', '1', '1', 'T4Cloud', '2020-02-19 19:08:35', '', '0000-00-00 00:00:00');
INSERT INTO `sys_permission` VALUES ('1230085853179052042', '1230085853179052039', '用户表_删除', '', null, '', '2', 'user:SysUser:DELETE', '13.00', 'el-icon-delete', '用户表-删除按钮', '1', '1', 'T4Cloud', '2020-02-19 19:08:35', '', '0000-00-00 00:00:00');
INSERT INTO `sys_permission` VALUES ('1230085853179052043', '1230085853179052039', '用户表_查看', '', null, '', '2', 'user:SysUser:VIEW', '14.00', 'el-icon-view', '用户表-详情按钮', '1', '1', 'T4Cloud', '2020-02-19 19:08:35', '', '0000-00-00 00:00:00');
INSERT INTO `sys_permission` VALUES ('1230768750940712972', '154e80d6a31e578d2eaa8c4634b3e8da', '角色管理', '/system/SysRole', '0', 'system/SysRoleList', '0', '', '10.00', 'el-icon-view', '角色表-菜单', '1', '1', 'T4Cloud', '2020-02-21 16:19:29', 'admin', '2020-03-17 21:27:54');
INSERT INTO `sys_permission` VALUES ('1230768750940712974', '1230768750940712972', '角色表_修改', '', null, '', '2', 'system:SysRole:EDIT', '12.00', 'el-icon-edit', '角色表-编辑按钮', '1', '1', 'T4Cloud', '2020-02-21 16:19:30', '', '0000-00-00 00:00:00');
INSERT INTO `sys_permission` VALUES ('1230768750940712975', '1230768750940712972', '角色表_删除', '', null, '', '2', 'system:SysRole:DELETE', '13.00', 'el-icon-delete', '角色表-删除按钮', '1', '1', 'T4Cloud', '2020-02-21 16:19:30', '', '0000-00-00 00:00:00');
INSERT INTO `sys_permission` VALUES ('1231177799351967764', '1230085853179052039', '用户表_导出', '', null, '', '2', 'user:SysUser:EXPORT', '15.00', 'el-icon-download', '用户表-导出按钮', '1', '1', 'T4Cloud', '2020-02-22 19:24:15', '', '0000-00-00 00:00:00');
INSERT INTO `sys_permission` VALUES ('1231177799351967765', '1230085853179052039', '用户表_导入', '', null, '', '2', 'user:SysUser:IMPORT', '16.00', 'el-icon-upload2', '用户表-导入按钮', '1', '1', 'T4Cloud', '2020-02-22 19:24:15', '', '0000-00-00 00:00:00');
INSERT INTO `sys_permission` VALUES ('1231551481274441743', 'cc17035564771bb76b216fa2d1b7c2bd', '文件资源', '/support/SupResource', '0', 'support/SupResourceList', '0', '', '12.00', 'el-icon-picture-outline', '资源管理表-菜单', '1', '1', 'TeaR', '2020-02-23 20:09:19', 'admin', '2020-03-31 17:21:55');
INSERT INTO `sys_permission` VALUES ('1231551481274441744', '1231551481274441743', '资源管理表_新增', '', '0', '', '2', 'support:SupResource:ADD', '11.00', 'el-icon-circle-plus-outline', '资源管理表-新增按钮', '1', '1', 'TeaR', '2020-02-23 20:09:19', 'admin', '2020-03-06 23:17:13');
INSERT INTO `sys_permission` VALUES ('1231551481274441745', '1231551481274441743', '资源管理表_修改', '', '0', '', '2', 'support:SupResource:EDIT', '12.00', 'el-icon-edit', '资源管理表-编辑按钮', '1', '1', 'TeaR', '2020-02-23 20:09:19', 'admin', '2020-03-06 23:17:31');
INSERT INTO `sys_permission` VALUES ('1231551481274441746', '1231551481274441743', '资源管理表_删除', '', '0', '', '2', 'support:SupResource:DELETE', '13.00', 'el-icon-delete', '资源管理表-删除按钮', '1', '1', 'TeaR', '2020-02-23 20:09:19', 'admin', '2020-03-06 23:17:17');
INSERT INTO `sys_permission` VALUES ('1231551481274441747', '1231551481274441743', '资源管理表_查看', '', null, '', '2', 'support:SupResource:VIEW', '14.00', 'el-icon-view', '资源管理表-详情按钮', '1', '1', 'TeaR', '2020-02-23 20:09:19', '', '0000-00-00 00:00:00');
INSERT INTO `sys_permission` VALUES ('1231551481274441748', '1231551481274441743', '资源管理表_导出', '', '0', '', '2', 'support:SupResource:EXPORT', '15.00', 'el-icon-download', '资源管理表-导出按钮', '1', '1', 'TeaR', '2020-02-23 20:09:19', 'admin', '2020-03-06 23:17:38');
INSERT INTO `sys_permission` VALUES ('1231551481274441749', '1231551481274441743', '资源管理表_导入', '', '0', '', '2', 'support:SupResource:IMPORT', '16.00', 'el-icon-upload2', '资源管理表-导入按钮', '1', '1', 'TeaR', '2020-02-23 20:09:19', 'admin', '2020-03-06 23:17:42');
INSERT INTO `sys_permission` VALUES ('1232984097794093071', '1230768750940712972', '用户角色表', '/system/SysUserRole', '0', 'system/SysUserRoleList', '0', '', '20.00', '', '用户角色表-菜单', '0', '1', 'TeaR', '2020-02-27 19:02:01', 'admin', '2020-03-17 21:45:43');
INSERT INTO `sys_permission` VALUES ('1232984097794093074', '1232984097794093071', '用户角色表_编辑', '', '0', '', '2', 'system:SysUserRole:EDIT', '13.00', 'el-icon-delete', '用户角色表-删除按钮', '1', '1', 'TeaR', '2020-02-27 19:02:02', 'admin', '2020-03-17 21:43:47');
INSERT INTO `sys_permission` VALUES ('1232984097794093075', '1232984097794093071', '用户角色表_查看', '', null, '', '2', 'system:SysUserRole:VIEW', '14.00', 'el-icon-view', '用户角色表-详情按钮', '1', '1', 'TeaR', '2020-02-27 19:02:02', '', '0000-00-00 00:00:00');
INSERT INTO `sys_permission` VALUES ('1235980066630438927', '154e80d6a31e578d2eaa8c4634b3e8da', '字典管理', '/system/SysDict', '0', 'system/SysDictList', '0', '', '8.00', 'el-icon-s-operation', '字典-菜单', '1', '1', 'TeaR', '2020-03-07 01:28:01', 'admin', '2020-03-25 17:41:40');
INSERT INTO `sys_permission` VALUES ('1235980066630438928', '1235980066630438927', '字典_新增', '', null, '', '2', 'system:SysDict:ADD', '11.00', 'el-icon-circle-plus-outline', '字典-新增按钮', '1', '1', 'TeaR', '2020-03-07 01:28:01', '', '0000-00-00 00:00:00');
INSERT INTO `sys_permission` VALUES ('1235980066630438929', '1235980066630438927', '字典_修改', '', null, '', '2', 'system:SysDict:EDIT', '12.00', 'el-icon-edit', '字典-编辑按钮', '1', '1', 'TeaR', '2020-03-07 01:28:01', '', '0000-00-00 00:00:00');
INSERT INTO `sys_permission` VALUES ('1235980066630438930', '1235980066630438927', '字典_删除', '', null, '', '2', 'system:SysDict:DELETE', '13.00', 'el-icon-delete', '字典-删除按钮', '1', '1', 'TeaR', '2020-03-07 01:28:01', '', '0000-00-00 00:00:00');
INSERT INTO `sys_permission` VALUES ('1235980066630438931', '1235980066630438927', '字典_查看', '', null, '', '2', 'system:SysDict:VIEW', '14.00', 'el-icon-view', '字典-详情按钮', '1', '1', 'TeaR', '2020-03-07 01:28:01', '', '0000-00-00 00:00:00');
INSERT INTO `sys_permission` VALUES ('1235980066630438932', '1235980066630438927', '字典_导出', '', null, '', '2', 'system:SysDict:EXPORT', '15.00', 'el-icon-download', '字典-导出按钮', '1', '1', 'TeaR', '2020-03-07 01:28:01', '', '0000-00-00 00:00:00');
INSERT INTO `sys_permission` VALUES ('1235980066630438933', '1235980066630438927', '字典_导入', '', null, '', '2', 'system:SysDict:IMPORT', '16.00', 'el-icon-upload2', '字典-导入按钮', '1', '1', 'TeaR', '2020-03-07 01:28:01', '', '0000-00-00 00:00:00');
INSERT INTO `sys_permission` VALUES ('1238371494773977103', '1235980066630438927', '字典详细值', '/system/SysDictValue', '0', 'system/SysDictValueList', '0', '', '10.00', '', '字典详细值-菜单', '0', '1', 'TeaR', '2020-03-13 16:11:01', 'admin', '2020-03-15 20:36:49');
INSERT INTO `sys_permission` VALUES ('1238371494773977104', '1238371494773977103', '字典详细值_新增', '', null, '', '2', 'system:SysDictValue:ADD', '11.00', 'el-icon-circle-plus-outline', '字典详细值-新增按钮', '1', '1', 'TeaR', '2020-03-13 16:11:01', '', '0000-00-00 00:00:00');
INSERT INTO `sys_permission` VALUES ('1238371494773977105', '1238371494773977103', '字典详细值_修改', '', null, '', '2', 'system:SysDictValue:EDIT', '12.00', 'el-icon-edit', '字典详细值-编辑按钮', '1', '1', 'TeaR', '2020-03-13 16:11:01', '', '0000-00-00 00:00:00');
INSERT INTO `sys_permission` VALUES ('1238371494773977106', '1238371494773977103', '字典详细值_删除', '', null, '', '2', 'system:SysDictValue:DELETE', '13.00', 'el-icon-delete', '字典详细值-删除按钮', '1', '1', 'TeaR', '2020-03-13 16:11:01', '', '0000-00-00 00:00:00');
INSERT INTO `sys_permission` VALUES ('1238371494773977107', '1238371494773977103', '字典详细值_查看', '', null, '', '2', 'system:SysDictValue:VIEW', '14.00', 'el-icon-view', '字典详细值-详情按钮', '1', '1', 'TeaR', '2020-03-13 16:11:01', '', '0000-00-00 00:00:00');
INSERT INTO `sys_permission` VALUES ('1238371494773977108', '1238371494773977103', '字典详细值_导出', '', null, '', '2', 'system:SysDictValue:EXPORT', '15.00', 'el-icon-download', '字典详细值-导出按钮', '1', '1', 'TeaR', '2020-03-13 16:11:01', '', '0000-00-00 00:00:00');
INSERT INTO `sys_permission` VALUES ('1238371494773977109', '1238371494773977103', '字典详细值_导入', '', null, '', '2', 'system:SysDictValue:IMPORT', '16.00', 'el-icon-upload2', '字典详细值-导入按钮', '1', '1', 'TeaR', '2020-03-13 16:11:01', '', '0000-00-00 00:00:00');
INSERT INTO `sys_permission` VALUES ('1239437792124612623', '98384c71fd73ba6e421a7795525b7457', '模板管理', '/support/SupMessageTemplate', '0', 'support/SupMessageTemplateList', '0', '', '6.00', 'el-icon-postcard', '消息模板-菜单', '1', '1', 'TeaR', '2020-03-16 14:27:37', 'admin', '2020-03-31 18:21:19');
INSERT INTO `sys_permission` VALUES ('1239437792124612624', '1239437792124612623', '消息模板_新增', '', null, '', '2', 'support:SupMessageTemplate:ADD', '11.00', 'el-icon-circle-plus-outline', '消息模板-新增按钮', '1', '1', 'TeaR', '2020-03-16 14:27:38', '', '0000-00-00 00:00:00');
INSERT INTO `sys_permission` VALUES ('1239437792124612625', '1239437792124612623', '消息模板_修改', '', null, '', '2', 'support:SupMessageTemplate:EDIT', '12.00', 'el-icon-edit', '消息模板-编辑按钮', '1', '1', 'TeaR', '2020-03-16 14:27:38', '', '0000-00-00 00:00:00');
INSERT INTO `sys_permission` VALUES ('1239437792124612626', '1239437792124612623', '消息模板_删除', '', null, '', '2', 'support:SupMessageTemplate:DELETE', '13.00', 'el-icon-delete', '消息模板-删除按钮', '1', '1', 'TeaR', '2020-03-16 14:27:38', '', '0000-00-00 00:00:00');
INSERT INTO `sys_permission` VALUES ('1239437792124612627', '1239437792124612623', '消息模板_查看', '', null, '', '2', 'support:SupMessageTemplate:VIEW', '14.00', 'el-icon-view', '消息模板-详情按钮', '1', '1', 'TeaR', '2020-03-16 14:27:38', '', '0000-00-00 00:00:00');
INSERT INTO `sys_permission` VALUES ('1239437792124612628', '1239437792124612623', '消息模板_导出', '', null, '', '2', 'support:SupMessageTemplate:EXPORT', '15.00', 'el-icon-download', '消息模板-导出按钮', '1', '1', 'TeaR', '2020-03-16 14:27:38', '', '0000-00-00 00:00:00');
INSERT INTO `sys_permission` VALUES ('1239437792124612629', '1239437792124612623', '消息模板_导入', '', null, '', '2', 'support:SupMessageTemplate:IMPORT', '16.00', 'el-icon-upload2', '消息模板-导入按钮', '1', '1', 'TeaR', '2020-03-16 14:27:38', '', '0000-00-00 00:00:00');
INSERT INTO `sys_permission` VALUES ('1239531890134290447', '1230768750940712972', '角色权限表', '/system/SysRolePermission', '0', 'system/SysRolePermissionList', '0', '', '21.00', '', '角色权限表-菜单', '0', '1', 'TeaR', '2020-03-16 20:40:26', 'admin', '2020-03-17 21:45:47');
INSERT INTO `sys_permission` VALUES ('1239531890134290449', '1239531890134290447', '角色权限表_修改', '', '0', '', '2', 'system:SysRolePermission:EDIT', '18.00', 'el-icon-delete', '角色权限表-编辑按钮', '1', '1', 'TeaR', '2020-03-16 20:40:26', 'admin', '2020-03-17 21:42:10');
INSERT INTO `sys_permission` VALUES ('1239531890134290453', '1239531890134290447', '角色权限表_查看', '', null, '', '2', 'system:SysRolePermission:VIEW', '16.00', 'el-icon-view', '角色权限表-查看权限', '1', '1', 'TeaR', '2020-03-16 20:40:26', '', '0000-00-00 00:00:00');
INSERT INTO `sys_permission` VALUES ('1243420115904008208', 'cc17035564771bb76b216fa2d1b7c2bd', '日志查看', '/support/SysLog', '0', 'support/SysLogList', '0', '', '11.00', 'el-icon-info', '系统日志表-菜单', '1', '1', 'TeaR', '2020-03-27 14:11:17', 'admin', '2020-03-27 14:52:00');
INSERT INTO `sys_permission` VALUES ('1243420115904008209', '1243420115904008208', '系统日志表_新增', '', null, '', '2', 'support:SysLog:ADD', '11.00', 'el-icon-circle-plus-outline', '系统日志表-新增按钮', '1', '1', 'TeaR', '2020-03-27 14:11:17', '', '0000-00-00 00:00:00');
INSERT INTO `sys_permission` VALUES ('1243420115904008210', '1243420115904008208', '系统日志表_修改', '', null, '', '2', 'support:SysLog:EDIT', '12.00', 'el-icon-edit', '系统日志表-编辑按钮', '1', '1', 'TeaR', '2020-03-27 14:11:17', '', '0000-00-00 00:00:00');
INSERT INTO `sys_permission` VALUES ('1243420115904008211', '1243420115904008208', '系统日志表_删除', '', null, '', '2', 'support:SysLog:DELETE', '13.00', 'el-icon-delete', '系统日志表-删除按钮', '1', '1', 'TeaR', '2020-03-27 14:11:17', '', '0000-00-00 00:00:00');
INSERT INTO `sys_permission` VALUES ('1243420115904008212', '1243420115904008208', '系统日志表_查看', '', null, '', '2', 'support:SysLog:VIEW', '14.00', 'el-icon-view', '系统日志表-详情按钮', '1', '1', 'TeaR', '2020-03-27 14:11:18', '', '0000-00-00 00:00:00');
INSERT INTO `sys_permission` VALUES ('1243420115904008213', '1243420115904008208', '系统日志表_导出', '', null, '', '2', 'support:SysLog:EXPORT', '15.00', 'el-icon-download', '系统日志表-导出按钮', '1', '1', 'TeaR', '2020-03-27 14:11:18', '', '0000-00-00 00:00:00');
INSERT INTO `sys_permission` VALUES ('1243420115904008214', '1243420115904008208', '系统日志表_导入', '', null, '', '2', 'support:SysLog:IMPORT', '16.00', 'el-icon-upload2', '系统日志表-导入按钮', '1', '1', 'TeaR', '2020-03-27 14:11:18', '', '0000-00-00 00:00:00');
INSERT INTO `sys_permission` VALUES ('1244832822171615248', '36c11c8b34db218f5fb4894e91e9a5d2', '通用示例', '/user/ExampleCommon', '0', 'user/ExampleCommonList', '0', '', '10.00', 'el-icon-s-cooperation', '通用示例-菜单', '1', '1', 'TeaR', '2020-03-31 11:46:00', 'admin', '2020-03-31 11:48:51');
INSERT INTO `sys_permission` VALUES ('1244832822171615249', '1244832822171615248', '通用示例_新增', '', null, '', '2', 'user:ExampleCommon:ADD', '11.00', 'el-icon-circle-plus-outline', '通用示例-新增按钮', '1', '1', 'TeaR', '2020-03-31 11:46:00', '', '0000-00-00 00:00:00');
INSERT INTO `sys_permission` VALUES ('1244832822171615250', '1244832822171615248', '通用示例_修改', '', null, '', '2', 'user:ExampleCommon:EDIT', '12.00', 'el-icon-edit', '通用示例-编辑按钮', '1', '1', 'TeaR', '2020-03-31 11:46:00', '', '0000-00-00 00:00:00');
INSERT INTO `sys_permission` VALUES ('1244832822171615251', '1244832822171615248', '通用示例_删除', '', null, '', '2', 'user:ExampleCommon:DELETE', '13.00', 'el-icon-delete', '通用示例-删除按钮', '1', '1', 'TeaR', '2020-03-31 11:46:00', '', '0000-00-00 00:00:00');
INSERT INTO `sys_permission` VALUES ('1244832822171615252', '1244832822171615248', '通用示例_查看', '', null, '', '2', 'user:ExampleCommon:VIEW', '14.00', 'el-icon-view', '通用示例-详情按钮', '1', '1', 'TeaR', '2020-03-31 11:46:00', '', '0000-00-00 00:00:00');
INSERT INTO `sys_permission` VALUES ('1244832822171615253', '1244832822171615248', '通用示例_导出', '', null, '', '2', 'user:ExampleCommon:EXPORT', '15.00', 'el-icon-download', '通用示例-导出按钮', '1', '1', 'TeaR', '2020-03-31 11:46:00', '', '0000-00-00 00:00:00');
INSERT INTO `sys_permission` VALUES ('1244832822171615254', '1244832822171615248', '通用示例_导入', '', null, '', '2', 'user:ExampleCommon:IMPORT', '16.00', 'el-icon-upload2', '通用示例-导入按钮', '1', '1', 'TeaR', '2020-03-31 11:46:00', '', '0000-00-00 00:00:00');
INSERT INTO `sys_permission` VALUES ('1244931937098338319', '98384c71fd73ba6e421a7795525b7457', '消息列表', '/support/SupMessage', '0', 'support/SupMessageList', '0', '', '5.00', 'el-icon-message', '消息列表-菜单', '1', '1', 'TeaR', '2020-03-31 18:19:50', 'admin', '2020-03-31 18:22:03');
INSERT INTO `sys_permission` VALUES ('1244931937098338320', '1244931937098338319', '消息列表_新增', '', null, '', '2', 'support:SupMessage:ADD', '11.00', 'el-icon-circle-plus-outline', '消息列表-新增按钮', '1', '1', 'TeaR', '2020-03-31 18:19:50', '', '0000-00-00 00:00:00');
INSERT INTO `sys_permission` VALUES ('1244931937098338321', '1244931937098338319', '消息列表_修改', '', null, '', '2', 'support:SupMessage:EDIT', '12.00', 'el-icon-edit', '消息列表-编辑按钮', '1', '1', 'TeaR', '2020-03-31 18:19:50', '', '0000-00-00 00:00:00');
INSERT INTO `sys_permission` VALUES ('1244931937098338322', '1244931937098338319', '消息列表_删除', '', null, '', '2', 'support:SupMessage:DELETE', '13.00', 'el-icon-delete', '消息列表-删除按钮', '1', '1', 'TeaR', '2020-03-31 18:19:50', '', '0000-00-00 00:00:00');
INSERT INTO `sys_permission` VALUES ('1244931937098338323', '1244931937098338319', '消息列表_查看', '', null, '', '2', 'support:SupMessage:VIEW', '14.00', 'el-icon-view', '消息列表-详情按钮', '1', '1', 'TeaR', '2020-03-31 18:19:50', '', '0000-00-00 00:00:00');
INSERT INTO `sys_permission` VALUES ('1244931937098338324', '1244931937098338319', '消息列表_导出', '', null, '', '2', 'support:SupMessage:EXPORT', '15.00', 'el-icon-download', '消息列表-导出按钮', '1', '1', 'TeaR', '2020-03-31 18:19:50', '', '0000-00-00 00:00:00');
INSERT INTO `sys_permission` VALUES ('1244931937098338325', '1244931937098338319', '消息列表_导入', '', null, '', '2', 'support:SupMessage:IMPORT', '16.00', 'el-icon-upload2', '消息列表-导入按钮', '1', '1', 'TeaR', '2020-03-31 18:19:50', '', '0000-00-00 00:00:00');
INSERT INTO `sys_permission` VALUES ('1250259609349386255', '154e80d6a31e578d2eaa8c4634b3e8da', '公司管理', '/system/SysCompany', '0', 'system/SysCompanyList', '0', '', '11.00', 'el-icon-office-building', '公司表-菜单', '1', '1', 'TeaR', '2020-04-15 11:08:28', 'admin', '2020-04-15 11:29:21');
INSERT INTO `sys_permission` VALUES ('1250259609349386256', '1250259609349386255', '公司表_新增', '', null, '', '2', 'system:SysCompany:ADD', '11.00', 'el-icon-circle-plus-outline', '公司表-新增按钮', '1', '1', 'TeaR', '2020-04-15 11:08:28', '', '0000-00-00 00:00:00');
INSERT INTO `sys_permission` VALUES ('1250259609349386257', '1250259609349386255', '公司表_修改', '', null, '', '2', 'system:SysCompany:EDIT', '12.00', 'el-icon-edit', '公司表-编辑按钮', '1', '1', 'TeaR', '2020-04-15 11:08:28', '', '0000-00-00 00:00:00');
INSERT INTO `sys_permission` VALUES ('1250259609349386258', '1250259609349386255', '公司表_删除', '', null, '', '2', 'system:SysCompany:DELETE', '13.00', 'el-icon-delete', '公司表-删除按钮', '1', '1', 'TeaR', '2020-04-15 11:08:28', '', '0000-00-00 00:00:00');
INSERT INTO `sys_permission` VALUES ('1250259609349386259', '1250259609349386255', '公司表_查看', '', null, '', '2', 'system:SysCompany:VIEW', '14.00', 'el-icon-view', '公司表-详情按钮', '1', '1', 'TeaR', '2020-04-15 11:08:28', '', '0000-00-00 00:00:00');
INSERT INTO `sys_permission` VALUES ('1250259609349386260', '1250259609349386255', '公司表_导出', '', null, '', '2', 'system:SysCompany:EXPORT', '15.00', 'el-icon-download', '公司表-导出按钮', '1', '1', 'TeaR', '2020-04-15 11:08:29', '', '0000-00-00 00:00:00');
INSERT INTO `sys_permission` VALUES ('1250259609349386261', '1250259609349386255', '公司表_导入', '', null, '', '2', 'system:SysCompany:IMPORT', '16.00', 'el-icon-upload2', '公司表-导入按钮', '1', '1', 'TeaR', '2020-04-15 11:08:29', '', '0000-00-00 00:00:00');
INSERT INTO `sys_permission` VALUES ('1250300634419757072', '1250259609349386255', '用户公司表', '/system/SysUserCompany', '0', 'system/SysUserCompanyList', '0', '', '17.00', '', '用户公司表-菜单', '0', '1', 'TeaR', '2020-04-15 13:54:29', 'admin', '2020-04-16 17:02:01');
INSERT INTO `sys_permission` VALUES ('1250300634419757074', '1250300634419757072', '用户公司表_修改', '', null, '', '2', 'system:SysUserCompany:EDIT', '12.00', 'el-icon-edit', '用户公司表-编辑按钮', '1', '1', 'TeaR', '2020-04-15 13:54:29', '', '0000-00-00 00:00:00');
INSERT INTO `sys_permission` VALUES ('1250300634419757075', '1250300634419757072', '用户公司表_删除', '', null, '', '2', 'system:SysUserCompany:DELETE', '13.00', 'el-icon-delete', '用户公司表-删除按钮', '1', '1', 'TeaR', '2020-04-15 13:54:29', '', '0000-00-00 00:00:00');
INSERT INTO `sys_permission` VALUES ('1250300634419757076', '1250300634419757072', '用户公司表_查看', '', null, '', '2', 'system:SysUserCompany:VIEW', '14.00', 'el-icon-view', '用户公司表-详情按钮', '1', '1', 'TeaR', '2020-04-15 13:54:29', '', '0000-00-00 00:00:00');
INSERT INTO `sys_permission` VALUES ('1254322398585970703', '5df96be678e347e3fdab6ce43668a64f', '微信配置', '/weChat/WechatConfig', '0', 'wechat/WechatConfigList', '0', '', '12.00', 'el-icons-weixin', '微信秘钥配置-菜单', '1', '1', 'TeaR', '2020-04-26 16:13:27', 'admin', '2020-05-22 16:32:31');
INSERT INTO `sys_permission` VALUES ('1254322398585970704', '1254322398585970703', '微信秘钥配置_新增', '', null, '', '2', 'weChat:WechatConfig:ADD', '11.00', 'el-icon-circle-plus-outline', '微信秘钥配置-新增按钮', '1', '1', 'TeaR', '2020-04-26 16:13:27', '', '0000-00-00 00:00:00');
INSERT INTO `sys_permission` VALUES ('1254322398585970705', '1254322398585970703', '微信秘钥配置_修改', '', null, '', '2', 'weChat:WechatConfig:EDIT', '12.00', 'el-icon-edit', '微信秘钥配置-编辑按钮', '1', '1', 'TeaR', '2020-04-26 16:13:27', '', '0000-00-00 00:00:00');
INSERT INTO `sys_permission` VALUES ('1254322398585970706', '1254322398585970703', '微信秘钥配置_删除', '', null, '', '2', 'weChat:WechatConfig:DELETE', '13.00', 'el-icon-delete', '微信秘钥配置-删除按钮', '1', '1', 'TeaR', '2020-04-26 16:13:27', '', '0000-00-00 00:00:00');
INSERT INTO `sys_permission` VALUES ('1254322398585970707', '1254322398585970703', '微信秘钥配置_查看', '', null, '', '2', 'weChat:WechatConfig:VIEW', '14.00', 'el-icon-view', '微信秘钥配置-详情按钮', '1', '1', 'TeaR', '2020-04-26 16:13:27', '', '0000-00-00 00:00:00');
INSERT INTO `sys_permission` VALUES ('1254322398585970708', '1254322398585970703', '微信秘钥配置_导出', '', null, '', '2', 'weChat:WechatConfig:EXPORT', '15.00', 'el-icon-download', '微信秘钥配置-导出按钮', '1', '1', 'TeaR', '2020-04-26 16:13:27', '', '0000-00-00 00:00:00');
INSERT INTO `sys_permission` VALUES ('1254322398585970709', '1254322398585970703', '微信秘钥配置_导入', '', null, '', '2', 'weChat:WechatConfig:IMPORT', '16.00', 'el-icon-upload2', '微信秘钥配置-导入按钮', '1', '1', 'TeaR', '2020-04-26 16:13:27', '', '0000-00-00 00:00:00');
INSERT INTO `sys_permission` VALUES ('154e80d6a31e578d2eaa8c4634b3e8da', '', '系统设置', '/system', '0', '', '0', '', '10.00', 'el-icon-setting', '', '1', '1', 'admin', '2020-03-04 00:22:48', 'admin', '2020-03-31 17:45:04');
INSERT INTO `sys_permission` VALUES ('26d525cc2f53f2a82d5aa98936d40381', 'e1bbd3d6df87333f0b46b880e81b4e0c', '测试', '/test/test', '0', '/test/test', '2', '', '13.00', 'el-icon-user-solid', '', '1', '1', 'admin', '2020-02-25 14:33:52', 'admin', '2020-02-27 16:29:59');
INSERT INTO `sys_permission` VALUES ('36c11c8b34db218f5fb4894e91e9a5d2', '', '开发示例', '/example', '0', '', '0', '', '14.00', 'el-icon-question', '', '1', '1', 'admin', '2020-03-31 11:48:24', 'admin', '2020-03-31 11:48:33');
INSERT INTO `sys_permission` VALUES ('38293aa9317d52dfa2ab182a8ad1f35d', '38293aa9317d52dfa2ab182a8ad1f35d', 'test', 'test/test', '0', 'test/test', '0', '', '0.00', 'el-icon-user', '', '0', '1', 'admin', '2020-02-27 16:59:25', 'admin', '2020-02-27 17:05:17');
INSERT INTO `sys_permission` VALUES ('5224609085e98cebd3535c7453155f25', 'fcf943e4d0a36b3e4d66d047d011f2a3', '新增', '', '0', '', '2', 'test:test:ADD', '2.00', '', '', '0', '0', 'admin', '2020-03-02 16:41:13', 'admin', '2020-03-15 22:51:33');
INSERT INTO `sys_permission` VALUES ('5b1bea5d3c5b970662f190de94364216', '1230768750940712972', '角色_导出', '', '0', '', '2', 'system:SysRole:EXPORT', '15.00', 'el-icon-download', '角色_导出', '1', '1', 'admin', '2020-03-17 21:45:38', 'admin', '2020-03-17 21:47:11');
INSERT INTO `sys_permission` VALUES ('5df96be678e347e3fdab6ce43668a64f', '', 'APP通用', '/app', '0', '', '0', '', '6.00', 'el-icon-mobile', '', '1', '1', 'admin', '2020-04-17 12:07:44', 'admin', '2020-05-21 11:15:03');
INSERT INTO `sys_permission` VALUES ('64f27a6691edc85a3e2507735c3dd553', '1230768750940712972', '角色_导入', '', '0', '', '2', 'system:SysRole:IMPORT', '14.00', 'el-icon-upload2', '角色_导入', '1', '1', 'admin', '2020-03-17 21:44:39', 'admin', '2020-03-17 21:45:08');
INSERT INTO `sys_permission` VALUES ('675e20a84748ebcd23d61817d4d82183', 'a02944e79cda77f8426044775a98348a', '网易', 'https://www.163.com/', '0', '', '0', '', '0.00', 'el-icons-wangyi', '', '1', '1', 'admin', '2020-03-26 13:38:33', 'admin', '2020-05-22 16:34:00');
INSERT INTO `sys_permission` VALUES ('98384c71fd73ba6e421a7795525b7457', '', '消息中心', '/message', '0', '', '0', '', '9.00', 'el-icon-chat-dot-square', '', '1', '1', 'admin', '2020-03-16 14:32:09', 'admin', '2020-03-16 15:06:54');
INSERT INTO `sys_permission` VALUES ('9b67244387f654d6fe3f5b5fdcc88927', 'cc17035564771bb76b216fa2d1b7c2bd', '实时性能', '/support/monitor', '0', 'support/Monitor', '0', '', '10.00', 'el-icon-s-operation', '', '1', '1', 'admin', '2020-03-05 11:17:54', 'admin', '2020-03-05 18:51:59');
INSERT INTO `sys_permission` VALUES ('a02944e79cda77f8426044775a98348a', '', '友情外链', '/link', '0', '', '0', '', '12.00', 'el-icon-s-management', '', '1', '1', 'admin', '2020-03-26 17:24:09', 'admin', '2020-03-30 10:16:57');
INSERT INTO `sys_permission` VALUES ('b9f6737ceb8ac97db76e3d28a52eadab', '1230768750940712972', '角色_查看', '', '0', '', '2', 'system:SysRole:VIEW', '1.00', 'el-icon-view', '角色_查看', '1', '1', 'admin', '2020-03-17 21:36:02', '', '0000-00-00 00:00:00');
INSERT INTO `sys_permission` VALUES ('bf53dd9fd060cf81bbe858904dba3771', 'a02944e79cda77f8426044775a98348a', '百度', 'http://www.baidu.com', '0', '', '0', '', '0.00', 'el-icons-baidu', '', '1', '1', 'admin', '2020-03-17 21:23:22', 'admin', '2020-05-22 16:33:53');
INSERT INTO `sys_permission` VALUES ('cc17035564771bb76b216fa2d1b7c2bd', '', '资源监控', '/support', '0', '', '0', '', '11.00', 'el-icon-s-cooperation', '', '1', '1', 'admin', '2020-03-05 18:35:55', 'admin', '2020-03-05 18:51:25');
INSERT INTO `sys_permission` VALUES ('e1bbd3d6df87333f0b46b880e81b4e0c', '26d525cc2f53f2a82d5aa98936d40381', '子菜单', 'test/test/zi', '0', 'test/test/zi', '0', '', '0.00', 'el-icon-eleme', '', '0', '0', 'admin', '2020-02-26 16:03:15', 'admin', '2020-02-27 16:22:07');
INSERT INTO `sys_permission` VALUES ('faa6e3006784bfba0d467cd9b6452a5b', '1230768750940712972', '角色_新增', '', '0', '', '2', 'system:SysRole:ADD', '0.00', 'el-icon-circle-plus-outline', '角色_新增', '1', '1', 'admin', '2020-03-17 21:35:28', 'admin', '2020-03-17 21:38:35');
INSERT INTO `sys_permission` VALUES ('fcf943e4d0a36b3e4d66d047d011f2a3', '', '测试菜单', 'test-1', '0', 'test/test/zi', '0', '', '13.00', 'el-icon-help', '', '0', '1', 'admin', '2020-03-04 15:06:29', 'admin', '2020-03-08 23:22:23');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `id` varchar(32) NOT NULL COMMENT '主键id',
  `role_name` varchar(200) DEFAULT NULL COMMENT '角色名称',
  `role_code` varchar(100) NOT NULL COMMENT '角色编码',
  `description` tinytext COMMENT '描述',
  `tenant_id` varchar(32) CHARACTER SET utf8mb4 DEFAULT '-1' COMMENT '租户ID',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uniq_sys_role_role_code` (`role_code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='角色表';

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('1', '超级管理员', 'SUPER-ADMIN', '', '-1', 'TeaR', '2020-02-12 13:56:36', 'admin', '2020-03-04 10:37:10');
INSERT INTO `sys_role` VALUES ('2', '管理员', 'ADMIN', '', '-1', 'TeaR', '2020-02-12 23:40:48', 'admin', '2020-04-08 17:12:27');
INSERT INTO `sys_role` VALUES ('985c0bdd920309c089c200fb0cc9186a', '演示账号', 'DEMO', '', '-1', 'admin', '2020-04-21 15:37:43', '', '0000-00-00 00:00:00');

-- ----------------------------
-- Table structure for sys_role_permission
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_permission`;
CREATE TABLE `sys_role_permission` (
  `id` varchar(32) NOT NULL,
  `role_id` varchar(32) DEFAULT NULL COMMENT '角色id',
  `permission_id` varchar(32) DEFAULT NULL COMMENT '权限id',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `index_group_role_per_id` (`role_id`,`permission_id`) USING BTREE,
  KEY `index_group_role_id` (`role_id`) USING BTREE,
  KEY `index_group_per_id` (`permission_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='角色权限表';

-- ----------------------------
-- Records of sys_role_permission
-- ----------------------------
INSERT INTO `sys_role_permission` VALUES ('015', '2', '1227815647354331142', 'TeaR', '2020-02-13 12:45:27', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('016', '2', '1227815647354331143', 'TeaR', '2020-02-13 12:45:27', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('017', '2', '1227815647354331144', 'TeaR', '2020-02-13 12:45:27', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('018', '2', '1227815647354331145', 'TeaR', '2020-02-13 12:45:27', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('019', '2', '1227815647354331146', 'TeaR', '2020-02-13 12:45:27', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('020', '2', '1230085853179052039', 'TeaR', '2020-02-19 19:12:35', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('024', '2', '1230085853179052043', 'TeaR', '2020-02-19 19:12:35', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('025', '2', '154e80d6a31e578d2eaa8c4634b3e8da', 'TeaR', '2020-02-27 19:02:02', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('026', '2', 'fcf943e4d0a36b3e4d66d047d011f2a3', 'TeaR', '2020-02-27 19:02:02', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('027', '2', '9b67244387f654d6fe3f5b5fdcc88927', 'TeaR', '2020-03-05 13:34:53', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('028', '2', 'cc17035564771bb76b216fa2d1b7c2bd', 'TeaR', '2020-03-05 18:39:37', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('03843a44f5a7df9250503b99f255458d', '2', '5df96be678e347e3fdab6ce43668a64f', 'admin', '2020-04-17 13:57:06', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('03a0138cffd6c5e49368f0a812b87f84', '2', '1227815647354331148', 'admin', '2020-03-17 21:59:04', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('072d59750d5c1479cecdef5aba0d677f', '985c0bdd920309c089c200fb0cc9186a', 'b9f6737ceb8ac97db76e3d28a52eadab', 'admin', '2020-04-21 15:39:19', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('0c6677ae56ea8ae612c02060e8aa2c2c', '985c0bdd920309c089c200fb0cc9186a', '1244931937098338323', 'admin', '2020-04-21 15:39:19', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('0fc01025c43ae18341656baf29aba3c8', '1', '1227815647354331143', 'admin', '2020-03-17 17:17:51', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('121d97ff3be385a6ef96e4dce4ce2312', '985c0bdd920309c089c200fb0cc9186a', '1250998909288439809', 'admin', '2020-04-21 15:39:19', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1230768750940712977', '2', '1230768750940712972', 'T4Cloud', '2020-02-21 16:19:30', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1230768750940712979', '2', '1230768750940712974', 'T4Cloud', '2020-02-21 16:19:30', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1230768750940712980', '2', '1230768750940712975', 'T4Cloud', '2020-02-21 16:19:30', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1231551481274441750', '2', '1231551481274441743', 'TeaR', '2020-02-23 20:09:19', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1231551481274441751', '2', '1231551481274441744', 'TeaR', '2020-02-23 20:09:19', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1231551481274441752', '2', '1231551481274441745', 'TeaR', '2020-02-23 20:09:19', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1231551481274441753', '2', '1231551481274441746', 'TeaR', '2020-02-23 20:09:19', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1231551481274441754', '2', '1231551481274441747', 'TeaR', '2020-02-23 20:09:19', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1231551481274441755', '2', '1231551481274441748', 'TeaR', '2020-02-23 20:09:20', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1231551481274441756', '2', '1231551481274441749', 'TeaR', '2020-02-23 20:09:20', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1232984097794093078', '2', '1232984097794093071', 'TeaR', '2020-02-27 19:02:02', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1232984097794093081', '2', '1232984097794093074', 'TeaR', '2020-02-27 19:02:02', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1232984097794093082', '2', '1232984097794093075', 'TeaR', '2020-02-27 19:02:02', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1235980066630438934', '2', '1235980066630438927', 'TeaR', '2020-03-07 01:28:01', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1235980066630438935', '2', '1235980066630438928', 'TeaR', '2020-03-07 01:28:01', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1235980066630438936', '2', '1235980066630438929', 'TeaR', '2020-03-07 01:28:01', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1235980066630438937', '2', '1235980066630438930', 'TeaR', '2020-03-07 01:28:01', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1235980066630438938', '2', '1235980066630438931', 'TeaR', '2020-03-07 01:28:01', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1235980066630438939', '2', '1235980066630438932', 'TeaR', '2020-03-07 01:28:02', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1235980066630438940', '2', '1235980066630438933', 'TeaR', '2020-03-07 01:28:02', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1238371494773977110', '2', '1238371494773977103', 'TeaR', '2020-03-13 16:11:01', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1238371494773977111', '2', '1238371494773977104', 'TeaR', '2020-03-13 16:11:01', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1238371494773977112', '2', '1238371494773977105', 'TeaR', '2020-03-13 16:11:02', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1238371494773977113', '2', '1238371494773977106', 'TeaR', '2020-03-13 16:11:02', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1238371494773977114', '2', '1238371494773977107', 'TeaR', '2020-03-13 16:11:02', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1238371494773977115', '2', '1238371494773977108', 'TeaR', '2020-03-13 16:11:02', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1238371494773977116', '2', '1238371494773977109', 'TeaR', '2020-03-13 16:11:02', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1239437792124612631', '2', '1239437792124612624', 'TeaR', '2020-03-16 14:27:38', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1239437792124612632', '2', '1239437792124612625', 'TeaR', '2020-03-16 14:27:38', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1239437792124612633', '2', '1239437792124612626', 'TeaR', '2020-03-16 14:27:38', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1239437792124612634', '2', '1239437792124612627', 'TeaR', '2020-03-16 14:27:38', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1239437792124612635', '2', '1239437792124612628', 'TeaR', '2020-03-16 14:27:38', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1239437792124612636', '2', '1239437792124612629', 'TeaR', '2020-03-16 14:27:38', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1239437792124612637', '2', '98384c71fd73ba6e421a7795525b7457', 'TeaR', '2020-03-16 14:27:38', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1239531890134290454', '2', '1239531890134290447', 'TeaR', '2020-03-16 20:40:26', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1239531890134290456', '2', '1239531890134290449', 'TeaR', '2020-03-16 20:40:26', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1239531890134290460', '2', '1239531890134290453', 'TeaR', '2020-03-16 20:40:26', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1243420115904008215', '2', '1243420115904008208', 'TeaR', '2020-03-27 14:11:18', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1243420115904008216', '2', '1243420115904008209', 'TeaR', '2020-03-27 14:11:18', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1243420115904008217', '2', '1243420115904008210', 'TeaR', '2020-03-27 14:11:18', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1243420115904008218', '2', '1243420115904008211', 'TeaR', '2020-03-27 14:11:18', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1243420115904008219', '2', '1243420115904008212', 'TeaR', '2020-03-27 14:11:18', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1243420115904008220', '2', '1243420115904008213', 'TeaR', '2020-03-27 14:11:18', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1243420115904008221', '2', '1243420115904008214', 'TeaR', '2020-03-27 14:11:18', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1244832822171615255', '2', '1244832822171615248', 'TeaR', '2020-03-31 11:46:00', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1244832822171615256', '2', '1244832822171615249', 'TeaR', '2020-03-31 11:46:00', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1244832822171615257', '2', '1244832822171615250', 'TeaR', '2020-03-31 11:46:00', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1244832822171615258', '2', '1244832822171615251', 'TeaR', '2020-03-31 11:46:00', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1244832822171615259', '2', '1244832822171615252', 'TeaR', '2020-03-31 11:46:00', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1244832822171615260', '2', '1244832822171615253', 'TeaR', '2020-03-31 11:46:00', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1244832822171615261', '2', '1244832822171615254', 'TeaR', '2020-03-31 11:46:00', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1244931937098338326', '2', '1244931937098338319', 'TeaR', '2020-03-31 18:19:50', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1244931937098338327', '2', '1244931937098338320', 'TeaR', '2020-03-31 18:19:50', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1244931937098338328', '2', '1244931937098338321', 'TeaR', '2020-03-31 18:19:50', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1244931937098338329', '2', '1244931937098338322', 'TeaR', '2020-03-31 18:19:50', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1244931937098338330', '2', '1244931937098338323', 'TeaR', '2020-03-31 18:19:50', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1244931937098338331', '2', '1244931937098338324', 'TeaR', '2020-03-31 18:19:51', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1244931937098338332', '2', '1244931937098338325', 'TeaR', '2020-03-31 18:19:51', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1246748197888012311', '2', '1246748197888012304', 'TeaR', '2020-04-05 18:36:08', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1246748197888012312', '2', '1246748197888012305', 'TeaR', '2020-04-05 18:36:08', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1246748197888012313', '2', '1246748197888012306', 'TeaR', '2020-04-05 18:36:08', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1246748197888012314', '2', '1246748197888012307', 'TeaR', '2020-04-05 18:36:08', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1246748197888012315', '2', '1246748197888012308', 'TeaR', '2020-04-05 18:36:08', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1246748197888012316', '2', '1246748197888012309', 'TeaR', '2020-04-05 18:36:08', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1246748197888012317', '2', '1246748197888012310', 'TeaR', '2020-04-05 18:36:08', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1250259609349386262', '2', '1250259609349386255', 'TeaR', '2020-04-15 11:08:29', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1250259609349386263', '2', '1250259609349386256', 'TeaR', '2020-04-15 11:08:29', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1250259609349386264', '2', '1250259609349386257', 'TeaR', '2020-04-15 11:08:29', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1250259609349386265', '2', '1250259609349386258', 'TeaR', '2020-04-15 11:08:29', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1250259609349386266', '2', '1250259609349386259', 'TeaR', '2020-04-15 11:08:29', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1250259609349386267', '2', '1250259609349386260', 'TeaR', '2020-04-15 11:08:29', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1250259609349386268', '2', '1250259609349386261', 'TeaR', '2020-04-15 11:08:29', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1250300634419757079', '2', '1250300634419757072', 'TeaR', '2020-04-15 13:54:29', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1250300634419757081', '2', '1250300634419757074', 'TeaR', '2020-04-15 13:54:29', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1250300634419757082', '2', '1250300634419757075', 'TeaR', '2020-04-15 13:54:29', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1250300634419757083', '2', '1250300634419757076', 'TeaR', '2020-04-15 13:54:29', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1250722488183799830', '2', '1250722488183799823', 'TeaR', '2020-04-16 17:48:23', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1250722488183799831', '2', '1250722488183799824', 'TeaR', '2020-04-16 17:48:24', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1250722488183799832', '2', '1250722488183799825', 'TeaR', '2020-04-16 17:48:24', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1250722488183799833', '2', '1250722488183799826', 'TeaR', '2020-04-16 17:48:24', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1250722488183799834', '2', '1250722488183799827', 'TeaR', '2020-04-16 17:48:24', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1250722488183799835', '2', '1250722488183799828', 'TeaR', '2020-04-16 17:48:24', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1250722488183799836', '2', '1250722488183799829', 'TeaR', '2020-04-16 17:48:24', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1250791064667193367', '2', '1250791064667193360', 'TeaR', '2020-04-16 22:20:26', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1250791064667193368', '2', '1250791064667193361', 'TeaR', '2020-04-16 22:20:26', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1250791064667193369', '2', '1250791064667193362', 'TeaR', '2020-04-16 22:20:27', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1250791064667193370', '2', '1250791064667193363', 'TeaR', '2020-04-16 22:20:27', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1250791064667193371', '2', '1250791064667193364', 'TeaR', '2020-04-16 22:20:27', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1250791064667193372', '2', '1250791064667193365', 'TeaR', '2020-04-16 22:20:27', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1250791064667193373', '2', '1250791064667193366', 'TeaR', '2020-04-16 22:20:27', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1251830627578781718', '2', '1251830627578781711', 'TeaR', '2020-04-19 19:11:35', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1251830627578781719', '2', '1251830627578781712', 'TeaR', '2020-04-19 19:11:35', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1251830627578781720', '2', '1251830627578781713', 'TeaR', '2020-04-19 19:11:35', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1251830627578781721', '2', '1251830627578781714', 'TeaR', '2020-04-19 19:11:35', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1251830627578781722', '2', '1251830627578781715', 'TeaR', '2020-04-19 19:11:35', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1251830627578781723', '2', '1251830627578781716', 'TeaR', '2020-04-19 19:11:35', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1251830627578781724', '2', '1251830627578781717', 'TeaR', '2020-04-19 19:11:35', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1252082710953451543', '2', '1252082710953451536', 'TeaR', '2020-04-20 11:53:52', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1252082710953451544', '2', '1252082710953451537', 'TeaR', '2020-04-20 11:53:52', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1252082710953451545', '2', '1252082710953451538', 'TeaR', '2020-04-20 11:53:52', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1252082710953451546', '2', '1252082710953451539', 'TeaR', '2020-04-20 11:53:52', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1252082710953451547', '2', '1252082710953451540', 'TeaR', '2020-04-20 11:53:52', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1252082710953451548', '2', '1252082710953451541', 'TeaR', '2020-04-20 11:53:52', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1252082710953451549', '2', '1252082710953451542', 'TeaR', '2020-04-20 11:53:52', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1252514749347282966', '2', '1252514749347282959', 'TeaR', '2020-04-21 16:29:51', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1252514749347282968', '2', '1252514749347282961', 'TeaR', '2020-04-21 16:29:51', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1252514749347282969', '2', '1252514749347282962', 'TeaR', '2020-04-21 16:29:51', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1252514749347282970', '2', '1252514749347282963', 'TeaR', '2020-04-21 16:29:51', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1253153604828213270', '2', '1253153604828213263', 'TeaR', '2020-04-23 10:48:53', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1253153604828213271', '2', '1253153604828213264', 'TeaR', '2020-04-23 10:48:53', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1253153604828213272', '2', '1253153604828213265', 'TeaR', '2020-04-23 10:48:53', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1253153604828213273', '2', '1253153604828213266', 'TeaR', '2020-04-23 10:48:53', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1253153604828213274', '2', '1253153604828213267', 'TeaR', '2020-04-23 10:48:53', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1253153604828213275', '2', '1253153604828213268', 'TeaR', '2020-04-23 10:48:53', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1253153604828213276', '2', '1253153604828213269', 'TeaR', '2020-04-23 10:48:53', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1253165211276926999', '2', '1253165211276926992', 'TeaR', '2020-04-23 11:35:05', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1253165211276927000', '2', '1253165211276926993', 'TeaR', '2020-04-23 11:35:05', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1253165211276927001', '2', '1253165211276926994', 'TeaR', '2020-04-23 11:35:05', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1253165211276927002', '2', '1253165211276926995', 'TeaR', '2020-04-23 11:35:05', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1253165211276927003', '2', '1253165211276926996', 'TeaR', '2020-04-23 11:35:05', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1253165211276927004', '2', '1253165211276926997', 'TeaR', '2020-04-23 11:35:05', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1253165211276927005', '2', '1253165211276926998', 'TeaR', '2020-04-23 11:35:05', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1253213114586468374', '2', '1253213114586468367', 'TeaR', '2020-04-23 14:45:08', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1253213114586468375', '2', '1253213114586468368', 'TeaR', '2020-04-23 14:45:08', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1253213114586468376', '2', '1253213114586468369', 'TeaR', '2020-04-23 14:45:08', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1253213114586468377', '2', '1253213114586468370', 'TeaR', '2020-04-23 14:45:08', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1253213114586468378', '2', '1253213114586468371', 'TeaR', '2020-04-23 14:45:08', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1253213114586468379', '2', '1253213114586468372', 'TeaR', '2020-04-23 14:45:08', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1253213114586468380', '2', '1253213114586468373', 'TeaR', '2020-04-23 14:45:08', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1254322398585970710', '2', '1254322398585970703', 'TeaR', '2020-04-26 16:13:27', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1254322398585970711', '2', '1254322398585970704', 'TeaR', '2020-04-26 16:13:27', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1254322398585970712', '2', '1254322398585970705', 'TeaR', '2020-04-26 16:13:27', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1254322398585970713', '2', '1254322398585970706', 'TeaR', '2020-04-26 16:13:27', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1254322398585970714', '2', '1254322398585970707', 'TeaR', '2020-04-26 16:13:27', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1254322398585970715', '2', '1254322398585970708', 'TeaR', '2020-04-26 16:13:28', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1254322398585970716', '2', '1254322398585970709', 'TeaR', '2020-04-26 16:13:28', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1255067032744386582', '2', '1255067032744386575', 'TeaR', '2020-04-28 17:31:25', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1255067032744386583', '2', '1255067032744386576', 'TeaR', '2020-04-28 17:31:25', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1255067032744386584', '2', '1255067032744386577', 'TeaR', '2020-04-28 17:31:25', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1255067032744386585', '2', '1255067032744386578', 'TeaR', '2020-04-28 17:31:25', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1255067032744386586', '2', '1255067032744386579', 'TeaR', '2020-04-28 17:31:25', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1255067032744386587', '2', '1255067032744386580', 'TeaR', '2020-04-28 17:31:25', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1255067032744386588', '2', '1255067032744386581', 'TeaR', '2020-04-28 17:31:25', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1258043966175625239', '2', '1258043966175625232', 'TeaR', '2020-05-06 22:43:31', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1258043966175625240', '2', '1258043966175625233', 'TeaR', '2020-05-06 22:43:31', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1258043966175625241', '2', '1258043966175625234', 'TeaR', '2020-05-06 22:43:31', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1258043966175625242', '2', '1258043966175625235', 'TeaR', '2020-05-06 22:43:31', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1258043966175625243', '2', '1258043966175625236', 'TeaR', '2020-05-06 22:43:31', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1258043966175625244', '2', '1258043966175625237', 'TeaR', '2020-05-06 22:43:32', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1258043966175625245', '2', '1258043966175625238', 'TeaR', '2020-05-06 22:43:32', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1258619121651265558', '2', '1258619121651265551', 'TeaR', '2020-05-08 12:48:22', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1258619121651265559', '2', '1258619121651265552', 'TeaR', '2020-05-08 12:48:22', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1258619121651265560', '2', '1258619121651265553', 'TeaR', '2020-05-08 12:48:22', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1258619121651265561', '2', '1258619121651265554', 'TeaR', '2020-05-08 12:48:22', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1258619121651265562', '2', '1258619121651265555', 'TeaR', '2020-05-08 12:48:22', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1258619121651265563', '2', '1258619121651265556', 'TeaR', '2020-05-08 12:48:22', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1258619121651265564', '2', '1258619121651265557', 'TeaR', '2020-05-08 12:48:22', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1258956335534923799', '2', '1258956335534923792', 'TeaR', '2020-05-09 11:06:09', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1258956335534923800', '2', '1258956335534923793', 'TeaR', '2020-05-09 11:06:09', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1258956335534923801', '2', '1258956335534923794', 'TeaR', '2020-05-09 11:06:09', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1258956335534923802', '2', '1258956335534923795', 'TeaR', '2020-05-09 11:06:09', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1258956335534923803', '2', '1258956335534923796', 'TeaR', '2020-05-09 11:06:10', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1258956335534923804', '2', '1258956335534923797', 'TeaR', '2020-05-09 11:06:10', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1258956335534923805', '2', '1258956335534923798', 'TeaR', '2020-05-09 11:06:10', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1263005826269417494', '2', '1263005826269417487', 'TeaR', '2020-05-20 15:17:44', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1263005826269417495', '2', '1263005826269417488', 'TeaR', '2020-05-20 15:17:44', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1263005826269417496', '2', '1263005826269417489', 'TeaR', '2020-05-20 15:17:44', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1263005826269417497', '2', '1263005826269417490', 'TeaR', '2020-05-20 15:17:44', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1263005826269417498', '2', '1263005826269417491', 'TeaR', '2020-05-20 15:17:44', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1263005826269417499', '2', '1263005826269417492', 'TeaR', '2020-05-20 15:17:44', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1263005826269417500', '2', '1263005826269417493', 'TeaR', '2020-05-20 15:17:44', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1263358010043473943', '2', '1263358010043473936', 'TeaR', '2020-05-21 14:37:17', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1263358010043473944', '2', '1263358010043473937', 'TeaR', '2020-05-21 14:37:17', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1263358010043473945', '2', '1263358010043473938', 'TeaR', '2020-05-21 14:37:17', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1263358010043473946', '2', '1263358010043473939', 'TeaR', '2020-05-21 14:37:17', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1263358010043473947', '2', '1263358010043473940', 'TeaR', '2020-05-21 14:37:17', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1263358010043473948', '2', '1263358010043473941', 'TeaR', '2020-05-21 14:37:17', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1263358010043473949', '2', '1263358010043473942', 'TeaR', '2020-05-21 14:37:17', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1263764456665088022', '2', '1263764456665088015', 'TeaR', '2020-05-22 17:31:56', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1263764456665088023', '2', '1263764456665088016', 'TeaR', '2020-05-22 17:31:56', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1263764456665088024', '2', '1263764456665088017', 'TeaR', '2020-05-22 17:31:56', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1263764456665088025', '2', '1263764456665088018', 'TeaR', '2020-05-22 17:31:56', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1263764456665088026', '2', '1263764456665088019', 'TeaR', '2020-05-22 17:31:56', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1263764456665088027', '2', '1263764456665088020', 'TeaR', '2020-05-22 17:31:56', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1263764456665088028', '2', '1263764456665088021', 'TeaR', '2020-05-22 17:31:57', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('1584d150847b110ce7122344a3959fa1', '985c0bdd920309c089c200fb0cc9186a', '1239437792124612623', 'admin', '2020-04-21 15:39:19', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('19226949eb16dd1c5a440a655262120c', '1', '1227815647354331147', 'admin', '2020-04-14 17:17:41', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('206f7e2053894af50b0593503b63eecd', '2', '1231177799351967764', 'admin', '2020-03-17 20:45:03', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('298c9ca430bd537105164536405759dd', '2', '1230085853179052041', 'admin', '2020-03-17 20:45:03', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('31a36beaf79b0484bad40b46115558ac', '1', '1227815647354331146', 'admin', '2020-03-17 17:17:51', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('31feab9a0b5cda90d03f771ffd0bea42', '1', '1228186789386715144', 'admin', '2020-04-14 17:18:28', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('32b21173b7930c7f92b239f57336e545', '1', '1228186789386715143', 'admin', '2020-04-14 17:18:28', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('35cd1a3e5a2839040d863fee9934493d', '2', 'eec3e8cdcf7bce53f4d38dcc443e6b62', 'TeaR', '2020-04-17 11:42:48', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('35e21e48292b20ffd5ea24254f8357da', '985c0bdd920309c089c200fb0cc9186a', '1250300634419757076', 'admin', '2020-04-21 15:39:19', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('37905b05c64a4dc154840397b9095bdf', '2', '38b893902c20bc3be8cda64b83395d6c', 'admin', '2020-04-20 16:38:58', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('37a88f01426c99eb63699d4c069bd53d', '985c0bdd920309c089c200fb0cc9186a', '1243420115904008208', 'admin', '2020-04-21 15:39:19', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('3897dcf7c6025985de86d404231fb7a3', '985c0bdd920309c089c200fb0cc9186a', '1252082710953451536', 'admin', '2020-04-21 15:39:19', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('3c06a2f0b994b12265cd824adc19c4cc', '985c0bdd920309c089c200fb0cc9186a', '1239531890134290453', 'admin', '2020-04-21 15:39:19', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('4067e4c59c32f8e4dbab5f2ef106a01f', '1', '1227815647354331145', 'admin', '2020-03-17 17:17:51', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('446d11e1ffc3b5428cab145e2a46be1d', '985c0bdd920309c089c200fb0cc9186a', '1235980066630438927', 'admin', '2020-04-21 15:39:19', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('4651743c046c4a8c8f92fcf8b34dc42f', '985c0bdd920309c089c200fb0cc9186a', '1243420115904008212', 'admin', '2020-04-21 15:39:19', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('468a99ff5d91688b2028c00943de4ebb', '1', '1232984097794093071', 'admin', '2020-04-14 17:17:11', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('4b34468d59ad0691b79698e312917ace', '2', '1250998909288439815', 'admin', '2020-04-17 13:57:06', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('4df67bac30958e0f33f5392be389307a', '2', '1231177799351967765', 'admin', '2020-03-17 20:45:03', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('4ee1ba6b246b0234ece70fd18c437dbe', '2', '675e20a84748ebcd23d61817d4d82183', 'admin', '2020-03-26 13:38:41', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('509d618ffee3dc2a5bd1cb5b0ad6ce06', '2', '1250998909288439814', 'admin', '2020-04-17 13:57:06', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('53f0f66a117035efed94ea15151221bc', '985c0bdd920309c089c200fb0cc9186a', '1227815647354331142', 'admin', '2020-04-21 15:39:19', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('54271231b9dcc8692e7875b63933f34d', '1', 'b9f6737ceb8ac97db76e3d28a52eadab', 'admin', '2020-04-14 17:17:11', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('5451a0fb4ce4acd63d6cae06275b7f94', '985c0bdd920309c089c200fb0cc9186a', '675e20a84748ebcd23d61817d4d82183', 'admin', '2020-04-21 15:39:19', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('56b3b76e86f4ac12f196236b4734b89c', '2', '1239437792124612623', 'admin', '2020-03-17 20:39:32', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('5790885dbc0ece3aeb7c0c39ee0f6031', '985c0bdd920309c089c200fb0cc9186a', '1244832822171615248', 'admin', '2020-04-21 15:39:19', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('61f8577dc9fcf03acb14160f7bf0bc1c', '985c0bdd920309c089c200fb0cc9186a', '1235980066630438931', 'admin', '2020-04-21 15:39:19', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('6a1b4c6167f08827eb8be3d516bdc852', '1', '1230768750940712975', 'admin', '2020-04-14 17:17:11', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('6c28ed049a427b0768c770561587d373', '2', '1250998909288439813', 'admin', '2020-04-17 13:57:06', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('6d3189900411c89f2664b4f614febb00', '1', '1239531890134290453', 'admin', '2020-03-17 20:45:48', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('725a05eeca6b90efc82ad5c8738233c3', '985c0bdd920309c089c200fb0cc9186a', '1250998909288439813', 'admin', '2020-04-21 15:39:19', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('726e78b3128025d6d78650dcaafd4cbe', '985c0bdd920309c089c200fb0cc9186a', '1231551481274441743', 'admin', '2020-04-21 15:39:19', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('7460cf20f3e28171beb4d4f9f6666d48', '985c0bdd920309c089c200fb0cc9186a', '1239437792124612627', 'admin', '2020-04-21 15:39:19', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('74fa05756c9a1f9dcafef0fc61ce5d92', '2', '1230085853179052040', 'admin', '2020-03-17 20:45:03', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('78fd5c260fc5206b0a3f8fdbd3da0e7a', '2', '1250998909288439811', 'admin', '2020-04-17 13:57:06', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('792977664dfe601825c52b3f2fd09b1b', '2', '36c11c8b34db218f5fb4894e91e9a5d2', 'admin', '2020-03-31 11:49:06', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('7a6effaff31798340f40c639c3a27e0e', '2', '64f27a6691edc85a3e2507735c3dd553', 'admin', '2020-03-17 21:46:26', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('7e74579d4e6299371d4faca0ac865ded', '1', '154e80d6a31e578d2eaa8c4634b3e8da', 'admin', '2020-04-14 17:17:41', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('8068c6279909de5bb2149f8b89b1ff6a', '985c0bdd920309c089c200fb0cc9186a', '1244931937098338319', 'admin', '2020-04-21 15:39:19', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('81ebbf9f467e12c0e4769ef41cfffe9a', '985c0bdd920309c089c200fb0cc9186a', '1250300634419757072', 'admin', '2020-04-21 15:39:19', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('8412d766b34096a0bae16547c86a106e', '985c0bdd920309c089c200fb0cc9186a', 'bf53dd9fd060cf81bbe858904dba3771', 'admin', '2020-04-21 15:39:19', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('8505fb41bc9fbbbdcd4e87b798d4492e', '1', '1230768750940712974', 'admin', '2020-04-14 17:17:11', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('869ba1147f00d9ea29ccd4da9da9a287', '2', '1250998909288439809', 'admin', '2020-04-17 13:57:06', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('897212c4ff2780ff9c4dac21a9034b19', '985c0bdd920309c089c200fb0cc9186a', '1231551481274441747', 'admin', '2020-04-21 15:39:19', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('8a4e4bd1382e7056acf51603d0d7d921', '1', '1230768750940712972', 'admin', '2020-04-14 17:17:11', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('8d26a317a02ced3b4171cacbe78a1ed8', '985c0bdd920309c089c200fb0cc9186a', '9b67244387f654d6fe3f5b5fdcc88927', 'admin', '2020-04-21 15:39:19', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('8d70ceee20e29e28026e6209dcab3e51', '1', '1239531890134290449', 'admin', '2020-04-14 17:17:11', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('8dcde5b3fc6b9c0ec9e74b32e9505dcc', '2', '5b1bea5d3c5b970662f190de94364216', 'admin', '2020-03-17 21:46:26', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('8e1ff3d5a6a3517d45872995fd16d89f', '985c0bdd920309c089c200fb0cc9186a', '1244832822171615250', 'admin', '2020-04-21 15:39:19', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('8e39976813d0c2778a87e4fad04d1cf6', '1', '1227815647354331148', 'admin', '2020-04-14 17:17:41', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('8e4fdfd904afadd762f50d1d339bc83d', '985c0bdd920309c089c200fb0cc9186a', '1230768750940712972', 'admin', '2020-04-21 15:39:19', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('9023534768220ccfe03fc197b3af39f6', '1', '64f27a6691edc85a3e2507735c3dd553', 'admin', '2020-04-14 17:17:11', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('90fd2d166794c64dc1ba501ec120950c', '985c0bdd920309c089c200fb0cc9186a', '1230085853179052043', 'admin', '2020-04-21 15:39:19', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('929c33e018cf7f4aba3cc4c7106f0d09', '985c0bdd920309c089c200fb0cc9186a', '3be3edf35f70bd0e8922615392240523', 'admin', '2020-04-21 15:39:19', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('96c3054551364e26bcc46998bac732ee', '1', '1232984097794093074', 'admin', '2020-04-14 17:17:11', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('a231fffd309de4a362fca648ee7fa531', '985c0bdd920309c089c200fb0cc9186a', '1230085853179052039', 'admin', '2020-04-21 15:39:19', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('a5ef30c790a42a3e32e57d251b0c8259', '985c0bdd920309c089c200fb0cc9186a', '1239531890134290447', 'admin', '2020-04-21 15:39:19', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('a663899aec41d451d862eeb3f1ec78be', '985c0bdd920309c089c200fb0cc9186a', '1252082710953451540', 'admin', '2020-04-21 15:39:19', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('abb1a3b0d6967e4f6a609b0aed238db3', '985c0bdd920309c089c200fb0cc9186a', '1250259609349386259', 'admin', '2020-04-21 15:39:19', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('acab97fea93aefab770c6302146cb11c', '2', '1227815647354331147', 'admin', '2020-03-17 21:59:04', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('ad6efd6100adf274f05994025d99e609', '1', '1232984097794093075', 'admin', '2020-04-14 17:17:11', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('b01e4539d5ae3e8e4496c1b4ce3b8cdc', '985c0bdd920309c089c200fb0cc9186a', '36c11c8b34db218f5fb4894e91e9a5d2', 'admin', '2020-04-21 15:39:19', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('b2fe266d2ac1a36ec5bd9a02edb7ba54', '985c0bdd920309c089c200fb0cc9186a', '1244832822171615253', 'admin', '2020-04-21 15:39:19', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('b3af415b5b667da438fb9458bfa7ee95', '985c0bdd920309c089c200fb0cc9186a', '1238371494773977103', 'admin', '2020-04-21 15:39:19', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('b6303550eec6402c6b289e5a71b571b9', '1', '1239531890134290447', 'admin', '2020-04-14 17:17:11', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('b6cbf7f381e038caa2286caa8f4b298a', '2', 'b1ca2c7f7e9b2b49a5200a7c8e1f88a9', 'admin', '2020-04-16 17:21:18', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('b966e3598fce7ecc1167b5516b4b94c1', '985c0bdd920309c089c200fb0cc9186a', '1244832822171615254', 'admin', '2020-04-21 15:39:19', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('b9f6737ceb8ac97db76e3d28a52eadab', '2', 'b9f6737ceb8ac97db76e3d28a52eadab', 'TeaR', '2020-03-17 21:23:32', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('bb7f9773f7e95cea91f3197cd7f81f7f', '2', '1250998909288439812', 'admin', '2020-04-17 13:57:06', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('c090f2a19a3000ec0818b80350e1e683', '985c0bdd920309c089c200fb0cc9186a', '1244832822171615252', 'admin', '2020-04-21 15:39:19', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('c1aaa8beef0b3077734615283484e70a', '1', '5b1bea5d3c5b970662f190de94364216', 'admin', '2020-04-14 17:17:11', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('c6a180f4f63ac6474b7eaaf13def7c63', '1', '1228186789386715145', 'admin', '2020-04-14 17:18:28', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('c7cbcfa7c5303af0cef8043b90ca3e89', '985c0bdd920309c089c200fb0cc9186a', '1232984097794093071', 'admin', '2020-04-21 15:39:19', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('c9430f47c97c70001a568564457c9859', '985c0bdd920309c089c200fb0cc9186a', '1250259609349386255', 'admin', '2020-04-21 15:39:19', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('c96db9fcc63f4b5cf904e5e2093b4098', '985c0bdd920309c089c200fb0cc9186a', '1232984097794093075', 'admin', '2020-04-21 15:39:19', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('c9f73e5ec960eb10a786c78227fe3295', '2', '1250998909288439810', 'admin', '2020-04-17 13:57:06', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('cdcfb671e72c05fd70d2c68aed5d42dc', '985c0bdd920309c089c200fb0cc9186a', '1244832822171615249', 'admin', '2020-04-21 15:39:19', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('cddfaf27258a080db0c7ef2172375ccc', '985c0bdd920309c089c200fb0cc9186a', '1244832822171615251', 'admin', '2020-04-21 15:39:19', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('d44da5478568cd591d58ea1fca31be32', '985c0bdd920309c089c200fb0cc9186a', '1238371494773977107', 'admin', '2020-04-21 15:39:19', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('db678a9ec084d46cc37cad85eee443ed', '985c0bdd920309c089c200fb0cc9186a', '5df96be678e347e3fdab6ce43668a64f', 'admin', '2020-04-21 15:39:19', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('ddc43ba267bbc707ac314cd42d681a30', '1', 'faa6e3006784bfba0d467cd9b6452a5b', 'admin', '2020-04-14 17:17:11', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('dfcb82c11d747cf4397703ce5e1cafcf', '985c0bdd920309c089c200fb0cc9186a', '1227815647354331146', 'admin', '2020-04-21 15:39:19', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('e0d957c55345747cf1e2762fe609e428', '1', '1227815647354331142', 'admin', '2020-03-17 17:17:51', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('e1050d5e9e79b5e7207d7d08ab76bd65', '2', '1230085853179052042', 'admin', '2020-03-17 20:45:03', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('e3fb0d51eed5f21356099fb3ac6413aa', '985c0bdd920309c089c200fb0cc9186a', 'a02944e79cda77f8426044775a98348a', 'admin', '2020-04-21 15:39:19', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('ecb5cc5f1fc48f51763eaba6bc340481', '1', '1227815647354331144', 'admin', '2020-03-17 17:17:51', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('ee7a361c5886f5d7c496f4eb7eafae4b', '985c0bdd920309c089c200fb0cc9186a', '98384c71fd73ba6e421a7795525b7457', 'admin', '2020-04-21 15:39:19', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('f02d32af539d5e37102bef4ed63988eb', '985c0bdd920309c089c200fb0cc9186a', 'cc17035564771bb76b216fa2d1b7c2bd', 'admin', '2020-04-21 15:39:19', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('f13fbdcb0ec612fce7a1e5e4da851c88', '1', '1228186789386715146', 'admin', '2020-04-14 17:18:28', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('faa6e3006784bfba0d467cd9b6452a5b', '2', 'faa6e3006784bfba0d467cd9b6452a5b', 'TeaR', '2020-03-17 21:23:32', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('fbfb413178330f63495fb2173e987b66', '2', 'a02944e79cda77f8426044775a98348a', 'admin', '2020-03-30 10:17:29', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('fc3e4c2305bd27e6dcb95cef719c58b3', '2', 'bf53dd9fd060cf81bbe858904dba3771', 'admin', '2020-03-17 21:23:32', '', '0000-00-00 00:00:00');
INSERT INTO `sys_role_permission` VALUES ('fc4dfeee24aec297904e5e4a003bfa93', '985c0bdd920309c089c200fb0cc9186a', '154e80d6a31e578d2eaa8c4634b3e8da', 'admin', '2020-04-21 15:39:19', '', '0000-00-00 00:00:00');

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `id` varchar(32) CHARACTER SET utf8 NOT NULL COMMENT '主键id',
  `username` varchar(32) CHARACTER SET utf8 NOT NULL COMMENT '登录账号',
  `realname` varchar(100) DEFAULT NULL COMMENT '真实姓名',
  `password` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '密码',
  `salt` varchar(45) CHARACTER SET utf8 DEFAULT NULL COMMENT 'md5密码盐',
  `work_no` varchar(100) CHARACTER SET utf8 NOT NULL COMMENT '工号，唯一键',
  `avatar` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '头像',
  `birthday` datetime DEFAULT NULL COMMENT '生日',
  `gender` tinyint(2) DEFAULT NULL COMMENT '性别(0-默认未知,1-男,2-女)',
  `email` varchar(45) CHARACTER SET utf8 DEFAULT NULL COMMENT '电子邮件',
  `phone` varchar(11) CHARACTER SET utf8 DEFAULT NULL COMMENT '电话',
  `post` varchar(100) CHARACTER SET utf8 DEFAULT NULL COMMENT '职务，关联职务表',
  `id_card` varchar(18) CHARACTER SET utf8 DEFAULT NULL COMMENT '身份证号',
  `address` varchar(500) CHARACTER SET utf8 DEFAULT NULL COMMENT '住址',
  `status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '性别(1-正常,2-冻结)',
  `tenant_id` varchar(640) NOT NULL COMMENT '租户ID',
  `create_by` varchar(32) CHARACTER SET utf8 DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) CHARACTER SET utf8 DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `index_user_name` (`username`,`tenant_id`) USING BTREE,
  UNIQUE KEY `uniq_sys_user_work_no` (`work_no`,`tenant_id`) USING BTREE,
  KEY `index_user_status` (`status`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='用户表';

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('1', 'TeaR', 'TeaR', '700961d246e6ddf1', 'SDFyT0h3', '001', 'https://git.t4cloud.com/img/favicon.png', '2018-12-05 00:00:00', '2', 'zqr.it@t4cloud.com', '17800001111', '', '', '上海市浦东新区陆家嘴', '1', '-1', 'TeaR', '2017-05-02 21:26:48', 'admin', '2020-03-18 11:17:06');
INSERT INTO `sys_user` VALUES ('14f10842654c1e343ec2447462fc3a8d', 'admin', '管理员', 'cb362cfeefbf3d8d', 'RCGTeGiH', '002', 'fc132bb5a87ea8d30423368edcac5e0e', '0000-00-00 00:00:00', '1', 'TEAR1', '', '', '', '', '1', '-1', 'TeaR', '2017-05-02 21:26:48', 'admin', '2020-06-18 21:21:29');

-- ----------------------------
-- Table structure for sys_user_company
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_company`;
CREATE TABLE `sys_user_company` (
  `id` varchar(32) NOT NULL COMMENT '主键id',
  `user_id` varchar(32) DEFAULT NULL COMMENT '用户id',
  `company_id` varchar(32) DEFAULT NULL COMMENT '公司id',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `index_user_id` (`user_id`) USING BTREE,
  KEY `index_company_id` (`company_id`) USING BTREE,
  KEY `index_user_and_company` (`user_id`,`company_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='用户公司表';

-- ----------------------------
-- Records of sys_user_company
-- ----------------------------
INSERT INTO `sys_user_company` VALUES ('1', '1', '-1', 'TeaR', '2020-04-15 16:21:21', '', '0000-00-00 00:00:00');
INSERT INTO `sys_user_company` VALUES ('105e551d5801db08e900af8cbcfacdeb', '14f10842654c1e343ec2447462fc3a8d', '-1', 'admin', '2020-04-16 16:53:17', '', '0000-00-00 00:00:00');

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role` (
  `id` varchar(32) NOT NULL COMMENT '主键id',
  `user_id` varchar(32) DEFAULT NULL COMMENT '用户id',
  `role_id` varchar(32) DEFAULT NULL COMMENT '角色id',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `index2_groupuu_user_id` (`user_id`) USING BTREE,
  KEY `index2_groupuu_ole_id` (`role_id`) USING BTREE,
  KEY `index2_groupuu_useridandroleid` (`user_id`,`role_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='用户角色表';

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES ('', '14f10842654c1e343ec2447462fc3a8d', '2', null, null, null, null);
INSERT INTO `sys_user_role` VALUES ('1', '1', '2', 'TeaR', '2020-03-23 23:54:06', '', '0000-00-00 00:00:00');

-- ----------------------------
-- Table structure for sys_user_third
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_third`;
CREATE TABLE `sys_user_third` (
  `id` varchar(32) NOT NULL COMMENT '自增长主键',
  `out_id` varchar(32) DEFAULT NULL COMMENT '用户外部ID',
  `in_id` varchar(32) DEFAULT NULL COMMENT '用户内部ID',
  `access_token` varchar(255) DEFAULT NULL COMMENT '用户外部token(密码)',
  `img` varchar(255) DEFAULT NULL COMMENT '用户头像',
  `phone` varchar(255) DEFAULT NULL COMMENT '用户编码',
  `nick_name` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '用户昵称',
  `gender` varchar(255) DEFAULT NULL COMMENT '用户性别',
  `email` varchar(255) DEFAULT NULL COMMENT '绑定邮箱',
  `login_type` varchar(20) NOT NULL COMMENT '用户平台种类 WX|QQ|WEB',
  `express` datetime DEFAULT NULL COMMENT '过期时间',
  `tenant_id` varchar(64) DEFAULT NULL COMMENT '租户ID',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '删除状态(0-正常,1-已删除)',
  `reamrk` varchar(255) DEFAULT NULL COMMENT '备注信息)',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_type` (`out_id`,`login_type`) COMMENT '外部ID和平台类型的统一'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='用户第三方登录数据';

-- ----------------------------
-- Records of sys_user_third
-- ----------------------------

-- ----------------------------
-- Table structure for wechat_config
-- ----------------------------
DROP TABLE IF EXISTS `wechat_config`;
CREATE TABLE `wechat_config` (
  `id` varchar(32) NOT NULL COMMENT '主键id',
  `code` tinyint(2) NOT NULL COMMENT '编号（可以用来区分同一应用下的公众号、小程序、H5等）',
  `name` varchar(200) DEFAULT NULL COMMENT '应用名称',
  `app_id` varchar(32) NOT NULL COMMENT 'WX APPID',
  `secret` varchar(200) DEFAULT NULL COMMENT '对应的secret',
  `tenant_id` varchar(32) CHARACTER SET utf8mb4 NOT NULL DEFAULT '-1' COMMENT '租户ID',
  `status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '状态(1-正常,0-删除)',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uni_code` (`code`,`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='微信秘钥配置';

-- ----------------------------
-- Records of wechat_config
-- ----------------------------
