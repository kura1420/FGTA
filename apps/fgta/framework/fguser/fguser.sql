-- SET FOREIGN_KEY_CHECKS=0;

-- drop table if exists `fgt_user`;
-- drop table if exists `fgt_usergroups`;


CREATE TABLE IF NOT EXISTS `fgt_user` (
	`user_id` varchar(14) NOT NULL , 
	`user_name` varchar(30)  , 
	`user_fullname` varchar(90)  , 
	`user_email` varchar(150)  , 
	`user_password` varchar(255)  , 
	`group_id` varchar(13) NOT NULL , 
	`user_disabled` tinyint(1) NOT NULL DEFAULT 0, 
	`_createby` varchar(14) NOT NULL , 
	`_createdate` datetime NOT NULL DEFAULT current_timestamp(), 
	`_modifyby` varchar(14)  , 
	`_modifydate` datetime  , 
	PRIMARY KEY (`user_id`)
) 
ENGINE=InnoDB
COMMENT='Daftar User';


ALTER TABLE `fgt_user` ADD COLUMN IF NOT EXISTS  `user_name` varchar(30)   AFTER `user_id`;
ALTER TABLE `fgt_user` ADD COLUMN IF NOT EXISTS  `user_fullname` varchar(90)   AFTER `user_name`;
ALTER TABLE `fgt_user` ADD COLUMN IF NOT EXISTS  `user_email` varchar(150)   AFTER `user_fullname`;
ALTER TABLE `fgt_user` ADD COLUMN IF NOT EXISTS  `user_password` varchar(255)   AFTER `user_email`;
ALTER TABLE `fgt_user` ADD COLUMN IF NOT EXISTS  `group_id` varchar(13) NOT NULL  AFTER `user_password`;
ALTER TABLE `fgt_user` ADD COLUMN IF NOT EXISTS  `user_disabled` tinyint(1) NOT NULL DEFAULT 0 AFTER `group_id`;


ALTER TABLE `fgt_user` MODIFY COLUMN IF EXISTS  `user_name` varchar(30)   AFTER `user_id`;
ALTER TABLE `fgt_user` MODIFY COLUMN IF EXISTS  `user_fullname` varchar(90)   AFTER `user_name`;
ALTER TABLE `fgt_user` MODIFY COLUMN IF EXISTS  `user_email` varchar(150)   AFTER `user_fullname`;
ALTER TABLE `fgt_user` MODIFY COLUMN IF EXISTS  `user_password` varchar(255)   AFTER `user_email`;
ALTER TABLE `fgt_user` MODIFY COLUMN IF EXISTS  `group_id` varchar(13) NOT NULL  AFTER `user_password`;
ALTER TABLE `fgt_user` MODIFY COLUMN IF EXISTS  `user_disabled` tinyint(1) NOT NULL DEFAULT 0 AFTER `group_id`;



ALTER TABLE `fgt_user` ADD KEY IF NOT EXISTS `group_id` (`group_id`);

ALTER TABLE `fgt_user` ADD CONSTRAINT `fk_fgt_user_fgt_group` FOREIGN KEY IF NOT EXISTS  (`group_id`) REFERENCES `fgt_group` (`group_id`);





CREATE TABLE IF NOT EXISTS `fgt_usergroups` (
	`usergroups_id` varchar(14) NOT NULL , 
	`usergroups_isdisabled` tinyint(1) NOT NULL DEFAULT 0, 
	`group_id` varchar(13) NOT NULL , 
	`user_id` varchar(14) NOT NULL , 
	`_createby` varchar(14) NOT NULL , 
	`_createdate` datetime NOT NULL DEFAULT current_timestamp(), 
	`_modifyby` varchar(14)  , 
	`_modifydate` datetime  , 
	PRIMARY KEY (`usergroups_id`)
) 
ENGINE=InnoDB
COMMENT='Group yang dipunyai user, selain group utamanya';


ALTER TABLE `fgt_usergroups` ADD COLUMN IF NOT EXISTS  `usergroups_isdisabled` tinyint(1) NOT NULL DEFAULT 0 AFTER `usergroups_id`;
ALTER TABLE `fgt_usergroups` ADD COLUMN IF NOT EXISTS  `group_id` varchar(13) NOT NULL  AFTER `usergroups_isdisabled`;
ALTER TABLE `fgt_usergroups` ADD COLUMN IF NOT EXISTS  `user_id` varchar(14) NOT NULL  AFTER `group_id`;


ALTER TABLE `fgt_usergroups` MODIFY COLUMN IF EXISTS  `usergroups_isdisabled` tinyint(1) NOT NULL DEFAULT 0 AFTER `usergroups_id`;
ALTER TABLE `fgt_usergroups` MODIFY COLUMN IF EXISTS  `group_id` varchar(13) NOT NULL  AFTER `usergroups_isdisabled`;
ALTER TABLE `fgt_usergroups` MODIFY COLUMN IF EXISTS  `user_id` varchar(14) NOT NULL  AFTER `group_id`;



ALTER TABLE `fgt_usergroups` ADD KEY IF NOT EXISTS `group_id` (`group_id`);
ALTER TABLE `fgt_usergroups` ADD KEY IF NOT EXISTS `user_id` (`user_id`);

ALTER TABLE `fgt_usergroups` ADD CONSTRAINT `fk_fgt_usergroups_fgt_group` FOREIGN KEY IF NOT EXISTS  (`group_id`) REFERENCES `fgt_group` (`group_id`);
ALTER TABLE `fgt_usergroups` ADD CONSTRAINT `fk_fgt_usergroups_fgt_user` FOREIGN KEY IF NOT EXISTS (`user_id`) REFERENCES `fgt_user` (`user_id`);





