CREATE DATABASE minions;
USE minions;

/* 01. Create Tables */
CREATE TABLE minions(
	id INT(11) PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    age INT(11)  DEFAULT NULL
);

CREATE TABLE towns(
	id INT(11) PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL
);

/* 02. Alter Minions Table */

ALTER TABLE minions
ADD COLUMN town_id INT(11);

ALTER TABLE minions
ADD CONSTRAINT fk_minions_towns FOREIGN KEY(town_id) REFERENCES towns(id);

/* 03.Insert Records in Both Tables */

INSERT INTO `towns`
	(`id`,`name`)
VALUES
	(1,'Sofia'),
    (2,'Plovdiv'),
    (3,'Varna');
    
INSERT INTO `minions`
	(`id`,`name`,`age`,`town_id`)
VALUES
	(1,'Kevin',22,1),
    (2,'Bob',15,3),
    (3,'Steward',NULL,2);
    
    /* 04. Truncate Table Minions */
    TRUNCATE TABLE `minions`;
    
    /* 05. Drop All Tables */
DROP TABLE `minions`;
DROP TABLE `towns`;
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
CREATE SCHEMA `Movies`;

CREATE TABLE `directors` (
`id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
`director_name` VARCHAR(50) NOT NULL,
`notes` TEXT(65535));

CREATE TABLE `genres`(
`id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
`genre_name` VARCHAR(50) NOT NULL,
`notes` TEXT(65535));

CREATE TABLE `categories`(
`id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
`category_name` VARCHAR(50) NOT NULL,
`notes` TEXT(65535));

CREATE TABLE `movies` (
`id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
`title` VARCHAR(50) NOT NULL,
`director_id` INT NOT NULL,
FOREIGN KEY(`director_id`) REFERENCES `directors` (`id`),
`copyright_year` DATE,
`length` INT,
`genre_id` INT NOT NULL,
`category_id` INT NOT NULL,
`rating` FLOAT(2, 1),
`notes` TEXT(65535)
);

INSERT INTO `directors` (`director_name`, `notes`) 
VALUES ('Tarantino', 'kjdsc'),
		('Coppola', NULL),
        ('Scorsese', NULL),
        ('Spielberg', NULL),
        ('Hitchcock', NULL);
        
INSERT INTO `genres` (`genre_name`, `notes`)
VALUES ('Documentary', 'jhdscj'), 
		('Thriller', NULL),
        ('Mystery', NULL),
        ('Action', NULL),
        ('Horror', NULL);
        
INSERT INTO `categories` (`category_name`, `notes`)
VALUES ('Action', 'sdkjsd'),
		('Adventure', NULL),
        ('Comedy', 'kjds'),
        ('Crime', NULL),
        ('Historical', NULL);
        
INSERT INTO `movies` (`title`, `director_id`, `genre_id`, `category_id`, `rating`)
VALUES ('Inglorious Bastards', 1, 4, 3, 2.5),
		('The Rainmaker', 2, 2, 5, 1.5),
        ('Goodfellas', 3, 4, 4, 5.5),
        ('Raiders of the Lost Ark', 4, 4, 2, 1.5),
        ('Dial M for Murder', 5, 3, 4, 1.6);
CREATE DATABASE `soft_uni`;

USE `soft_uni`;

/* 14. Create SoftUni Database */

CREATE TABLE `towns` (
	`id` INT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT,
	`name` VARCHAR(30) NOT NULL,
	CONSTRAINT `pk_towns` PRIMARY KEY (`id`)
);

CREATE TABLE `addresses` (
	`id` INT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT,
	`address_text` VARCHAR(30) NOT NULL,
	`town_id` INT UNSIGNED,
	CONSTRAINT `pk_addresses` PRIMARY KEY (`id`),
	CONSTRAINT `fk_addresses_towns` FOREIGN KEY (`town_id`)
		REFERENCES `towns` (`id`)
);

CREATE TABLE `departments` (
	`id` INT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT,
	`name` VARCHAR(30) NOT NULL,
	CONSTRAINT `pk_departments` PRIMARY KEY (`id`)
);

CREATE TABLE `employees` (
	`id` INT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT,
	`first_name` VARCHAR(30) NOT NULL,
	`middle_name` VARCHAR(30),
	`last_name` VARCHAR(30) NOT NULL,
	`job_title` VARCHAR(30) NOT NULL,
	`department_id` INT UNSIGNED,
	`hire_date` DATE,
	`salary` DOUBLE(10 , 4 ),
	`address_id` INT UNSIGNED,
	CONSTRAINT `pk_employees` PRIMARY KEY (`id`),
	CONSTRAINT `fk_employees_departments` FOREIGN KEY (`department_id`)
		REFERENCES `departments` (`id`),
	CONSTRAINT `fk_employees_addresses` FOREIGN KEY (`address_id`)
		REFERENCES `addresses` (`id`)
);

INSERT INTO `towns` 
		(`name`)
    VALUES 
		('Sofia'), ('Plovdiv'), ('Varna'), ('Burgas');

INSERT INTO `departments` 
		(`name`) 
	VALUES
		('Engineering'),
		('Sales'),
		('Marketing'),
		('Software Development'),
		('Quality Assurance');

INSERT INTO `employees`
		(`first_name`, `middle_name`, `last_name`, `job_title`, `department_id`, `hire_date`, `salary`)
	VALUES
		('Ivan', 'Ivanov', 'Ivanov', '.NET Developer', 4, '2013-02-01', 3500.00),
		('Petar', 'Petrov', 'Petrov', 'Senior Engineer', 1, '2004-03-02', 4000.00),
		('Maria', 'Petrova', 'Ivanova', 'Intern', 5, '2016-08-28', 525.25),
		('Georgi', 'Terziev', 'Ivanov', 'CEO', 2, '2007-12-09', 3000.00),
		('Peter', 'Pan', 'Pan', 'Intern', 3, '2016-08-28', 599.88);
        
        
SELECT * FROM `towns`;
SELECT * FROM `departments`;
SELECT * FROM `employees`;


  
SELECT * FROM `towns` ORDER BY `name`;

SELECT * FROM `departments` ORDER BY `name`;

SELECT * FROM `employees` ORDER BY `salary` DESC;

SELECT `name` FROM `towns` ORDER BY `name`;

SELECT `name` FROM `departments` ORDER BY `name`;

SELECT `first_name`, `last_name`, `job_title`, `salary` FROM `employees` ORDER BY `salary` DESC;


UPDATE `employees` SET `salary` = `salary` * 1.1;

SELECT `salary`FROM `employees`;


UPDATE `payments` 
SET  `tax_rate` = `tax_rate` * 0.97;

SELECT `tax_rate` FROM `payments`;

