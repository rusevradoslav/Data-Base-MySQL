create database hotel ;


CREATE TABLE `employees` (
`id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
`first_name` VARCHAR(100),
`last_name` VARCHAR(100),
`title` VARCHAR(100),
`notes`TEXT);

create table customers (
account_number int primary key not null auto_increment, 
first_name varchar(100) not null, 
last_name varchar(100) not null, 
phone_number varchar(30) , 
emergency_name varchar(100), 
emergency_number int , 
notes text);

create table room_status (
room_status varchar(100) not null primary key, 
notes text);

create table room_types (
room_type varchar(100) not null primary key, 
notes text );

create table bed_types  (
bed_type  varchar(100) not null primary key, 
notes text );

create table rooms (
room_number int primary key not null auto_increment, 
room_type varchar(100) not null, 
bed_type varchar(100) not null, 
rate decimal, 
room_status varchar(100) not null, 
notes text);

create table payments (
id int primary key not null auto_increment , 
employee_id int , 
payment_date date, 
account_number varchar(100) , 
first_date_occupied date, 
last_date_occupied date, 
total_days int , 
amount_charged decimal, 
tax_rate float, 
tax_amount float , 
payment_total decimal(8,2), 
notes text);
create table occupancies (
id int primary key not null auto_increment ,
 employee_id int , 
 date_occupied date,
 account_number varchar(100),
 room_number int ,
 rate_applied float, 
 phone_charge float,
 notes text );
 create database hotel ;


CREATE TABLE `employees` (
`id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
`first_name` VARCHAR(100),
`last_name` VARCHAR(100),
`title` VARCHAR(100),
`notes`TEXT);

create table customers (
account_number int primary key not null auto_increment, 
first_name varchar(100) not null, 
last_name varchar(100) not null, 
phone_number varchar(30) , 
emergency_name varchar(100), 
emergency_number int , 
notes text);

create table room_status (
room_status varchar(100) not null primary key, 
notes text);

create table room_types (
room_type varchar(100) not null primary key, 
notes text );

create table bed_types  (
bed_type  varchar(100) not null primary key, 
notes text );

create table rooms (
room_number int primary key not null auto_increment, 
room_type varchar(100) not null, 
bed_type varchar(100) not null, 
rate decimal, 
room_status varchar(100) not null, 
notes text);

create table payments (
id int primary key not null auto_increment , 
employee_id int , 
payment_date date, 
account_number varchar(100) , 
first_date_occupied date, 
last_date_occupied date, 
total_days int , 
amount_charged decimal, 
tax_rate float, 
tax_amount float , 
payment_total decimal(8,2), 
notes text);
create table occupancies (
id int primary key not null auto_increment ,
 employee_id int , 
 date_occupied date,
 account_number varchar(100),
 room_number int ,
 rate_applied float, 
 phone_charge float,
 notes text );