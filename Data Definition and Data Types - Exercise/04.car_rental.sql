create schema car_rental;


create table categories (
id int not null primary key auto_increment, 
category varchar(250) not null, 
daily_rate float , 
weekly_rate float, 
monthly_rate float, 
weekend_rate float );

create table cars (
id int not null primary key auto_increment , 
plate_number varchar(255) not null,
make  varchar(255) not null , 
model  varchar(255) not null, 
car_year int, 
category_id int , 
doors int, 
picture blob, 
car_condition varchar(255), 
available boolean);

create table employees (
id int not null primary key auto_increment, 
first_name varchar(255) not null, 
last_name varchar(255) not null, 
title varchar(255) not null, 
notes text);

CREATE TABLE customers (
`id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
`driver_licence_number`INT,
`full_name` VARCHAR(255),
`address` VARCHAR(255),
`city` VARCHAR(255),
`zip_code`INT,
`notes` TEXT);

create table rental_orders (
id INT NOT NULL PRIMARY KEY AUTO_INCREMENT, 
employee_id INT , 
customer_id INT , 
car_id int , 
car_condition varchar(255) not null, 
tank_level varchar(255) not null, 
kilometrage_start int, 
kilometrage_end int, 
total_kilometrage int, 
start_date date, 
end_date date, 
total_days int, 
rate_applied float, 
tax_rate float, 
order_status varchar(255), 
notes text);

INSERT INTO `categories`
	(`category`, `daily_rate`, `weekly_rate`, `monthly_rate`, `weekend_rate`)
VALUES
	('Compact',15.6,90.4,300.9,25.3),
    ('SUV',30.3,150.8,500.1,45.67),
    ('Limousine',45.8,250.4,850.6,75.7);

INSERT INTO `cars` 
	(`plate_number`, `make`, `model`, `car_year`, `category_id`, `doors`, `picture`, `car_condition`, `available`)
VALUES
	('A8972KB','VW','Polo',2017,1,4,'ima snimka','Excellent condition',1),
    ('CB3462AA','Audi','A3',2018,2,5,'ima snimka','Brand new',0),
    ('CB3783CH','Audi','A8',2017,3,4,'ima snimka','Brand new',1);

INSERT INTO `employees` 
	(`first_name`, `last_name`, `title`)
VALUES
	('Qnko','Halilov', 'Office director'),
    ('Pesho','Peshev', 'Order processing'), 
    ('Gosho','Goshev', 'Car Managment');
    
INSERT INTO `customers` 
	(`driver_licence_number`, `full_name`, `city`)
VALUES
	(456635892, 'Chefo Chefov','Varna'),
    (326373434, 'Mama Goshka','Milioni'),
    (120958035, 'Bai Ivan','Poduene');
    
INSERT INTO `rental_orders`
	(`employee_id`, `customer_id`, `car_id`, `order_status`)
VALUES
	(2,1,3,1),
    (1,2,2,0),
    (3,3,1,1);
	create schema car_rental;


create table categories (
id int not null primary key auto_increment, 
category varchar(250) not null, 
daily_rate float , 
weekly_rate float, 
monthly_rate float, 
weekend_rate float );

create table cars (
id int not null primary key auto_increment , 
plate_number varchar(255) not null,
make  varchar(255) not null , 
model  varchar(255) not null, 
car_year int, 
category_id int , 
doors int, 
picture blob, 
car_condition varchar(255), 
available boolean);

create table employees (
id int not null primary key auto_increment, 
first_name varchar(255) not null, 
last_name varchar(255) not null, 
title varchar(255) not null, 
notes text);

CREATE TABLE customers (
`id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
`driver_licence_number`INT,
`full_name` VARCHAR(255),
`address` VARCHAR(255),
`city` VARCHAR(255),
`zip_code`INT,
`notes` TEXT);

create table rental_orders (
id INT NOT NULL PRIMARY KEY AUTO_INCREMENT, 
employee_id INT , 
customer_id INT , 
car_id int , 
car_condition varchar(255) not null, 
tank_level varchar(255) not null, 
kilometrage_start int, 
kilometrage_end int, 
total_kilometrage int, 
start_date date, 
end_date date, 
total_days int, 
rate_applied float, 
tax_rate float, 
order_status varchar(255), 
notes text);

INSERT INTO `categories`
	(`category`, `daily_rate`, `weekly_rate`, `monthly_rate`, `weekend_rate`)
VALUES
	('Compact',15.6,90.4,300.9,25.3),
    ('SUV',30.3,150.8,500.1,45.67),
    ('Limousine',45.8,250.4,850.6,75.7);

INSERT INTO `cars` 
	(`plate_number`, `make`, `model`, `car_year`, `category_id`, `doors`, `picture`, `car_condition`, `available`)
VALUES
	('A8972KB','VW','Polo',2017,1,4,'ima snimka','Excellent condition',1),
    ('CB3462AA','Audi','A3',2018,2,5,'ima snimka','Brand new',0),
    ('CB3783CH','Audi','A8',2017,3,4,'ima snimka','Brand new',1);

INSERT INTO `employees` 
	(`first_name`, `last_name`, `title`)
VALUES
	('Qnko','Halilov', 'Office director'),
    ('Pesho','Peshev', 'Order processing'), 
    ('Gosho','Goshev', 'Car Managment');
    
INSERT INTO `customers` 
	(`driver_licence_number`, `full_name`, `city`)
VALUES
	(456635892, 'Chefo Chefov','Varna'),
    (326373434, 'Mama Goshka','Milioni'),
    (120958035, 'Bai Ivan','Poduene');
    
INSERT INTO `rental_orders`
	(`employee_id`, `customer_id`, `car_id`, `order_status`)
VALUES
	(2,1,3,1),
    (1,2,2,0),
    (3,3,1,1);