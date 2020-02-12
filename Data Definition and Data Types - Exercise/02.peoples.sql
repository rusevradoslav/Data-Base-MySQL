create database peoples;

CREATE TABLE people(
id INT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,
name VARCHAR(200) NOT NULL,
picture BLOB,
height FLOAT(2),
weight FLOAT(2),
gender CHAR NOT NULL CHECK (gender = 'm' OR gender='f'),
birthdate DATE NOT NULL ,
biography varchar(800)
);

INSERT INTO `people`
(`id`,`name`,`picture`,`height`,`weight`,`gender`,`birthdate`,`biography`)
VALUES
(1, 'Pesho', NULL, 2.5, 3.5, 'm', "1990-10-10", NULL),
(2, 'Bob', NULL, 2.4, 1.5, 'm', '1990-12-17', NULL),
(3, 'Stew', NULL, 2.7, 1.5, 'm', '1955-10-18', NULL),
(4, 'John', NULL, 2.8, 3.5, 'm', '1985-1-5', NULL),
(5, 'Alex', NULL, 5.5, 3.5, 'm', '1932-7-5', NULL);


create table users(
id int not null primary key auto_increment,
username varchar(30) unique not null,
password varchar(26) not null,
profile_picture blob,
last_login_time timestamp, 
is_deleted boolean
);

INSERT INTO `users`
(`id`,
`username`,
`password`,
`profile_picture`,
`last_login_time`,
`is_deleted`)
VALUES
(1, 'Pesho', 'jsdsdn', NULL, '0000-00-00 00:00:00', FALSE),
(2, 'Bob', 'thbdfb', NULL, '0000-00-00 00:00:00', TRUE),
(3, 'Stew', 'Fbdbz', NULL, '0000-00-00 00:00:00', FALSE),
(4, 'John', 'jsd', NULL, '0000-00-00 00:00:00', TRUE),
(5, 'Alex', 'dhsh', NULL, '0000-00-00 00:00:00', FALSE);


ALTER TABLE `users` MODIFY `id` INT NOT NULL;
ALTER TABLE `users` DROP PRIMARY KEY;
ALTER TABLE `users` ADD `pk_users` VARCHAR(50);

ALTER TABLE `users`
ADD CONSTRAINT `pk_users` primary key(`id`,`username`);


ALTER TABLE `users` 
MODIFY COLUMN `last_login_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

ALTER TABLE `users`
DROP PRIMARY KEY,

ADD CONSTRAINT pk_id
PRIMARY KEY(id),

ADD CONSTRAINT uq_username
UNIQUE(username);

