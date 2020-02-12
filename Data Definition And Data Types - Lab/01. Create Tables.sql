create schema gamebar;
create table employees (
id integer(11) primary key auto_increment,
first_name  varchar(255) not NULL ,
second_name varchar(255) not NULL
);

CREATE TABLE categories(
	id INT(11) PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE products(
	id INT(11) PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    category_id INT(11) NOT NULL
    
);
