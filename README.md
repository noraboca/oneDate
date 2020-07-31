# oneDate

// DB set (mysql 8.0 사용)


CREATE SCHEMA `onedate` DEFAULT CHARACTER SET utf8 ;

CREATE TABLE user ( idx int(11) NOT NULL AUTO_INCREMENT, name varchar(32) NOT NULL, gender varchar(32) NOT NULL, interested_gender varchar(32) NOT NULL, details varchar(200) DEFAULT NULL, id varchar(32) NOT NULL, email varchar(100) DEFAULT NULL, reg_date timestamp NULL DEFAULT CURRENT_TIMESTAMP, birth_day timestamp NOT NULL DEFAULT '0000-00-00 00:00:00', main_photo_src varchar(300) NOT NULL, sub1_photo_src varchar(300) DEFAULT NULL, sub2_photo_src varchar(300) DEFAULT NULL, sub3_photo_src varchar(300) DEFAULT NULL, sub4_photo_src varchar(300) DEFAULT NULL, password varchar(45) NOT NULL, phone varchar(45) DEFAULT NULL, address varchar(45) DEFAULT NULL, sms int(11) DEFAULT NULL, hobby varchar(100) DEFAULT NULL, PRIMARY KEY (idx), UNIQUE KEY id_UNIQUE (id) ) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;

CREATE TABLE matched_user ( idx int(11) NOT NULL AUTO_INCREMENT, user_idx int(11) DEFAULT NULL, matched_user_id varchar(32) NOT NULL, PRIMARY KEY (idx), KEY fk_user_idx_idx (user_idx), CONSTRAINT fk_user_idx FOREIGN KEY (user_idx) REFERENCES user (idx) ON DELETE NO ACTION ON UPDATE NO ACTION ) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

CREATE TABLE likes ( idx int(11) NOT NULL AUTO_INCREMENT, who int(11) DEFAULT NULL, whom int(11) DEFAULT NULL, PRIMARY KEY (idx) ) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

CREATE TABLE message ( idx int(11) NOT NULL AUTO_INCREMENT, text varchar(1000) NOT NULL, ts timestamp NULL DEFAULT CURRENT_TIMESTAMP, user_send varchar(32) DEFAULT NULL, user_receive varchar(32) DEFAULT NULL, PRIMARY KEY (idx) ) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8;

