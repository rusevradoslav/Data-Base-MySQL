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
