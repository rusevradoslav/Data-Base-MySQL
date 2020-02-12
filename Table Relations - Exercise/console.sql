#01. One-To-One Relationship
CREATE TABLE `passports`
(
    `passport_id`     INT PRIMARY KEY,
    `passport_number` VARCHAR(20) UNIQUE NOT NULL
);

CREATE TABLE `persons`
(
    `person_id`   INT PRIMARY KEY AUTO_INCREMENT,
    `first_name`  VARCHAR(20)    NOT NULL,
    `salary`      DECIMAL(10, 2) NOT NULL,
    `passport_id` INT UNIQUE,
    CONSTRAINT `fk_person_passport` FOREIGN KEY (`passport_id`) REFERENCES `passports` (`passport_id`)
);

INSERT INTO `passports`
VALUES (101, 'N34FG21B'),
       (102, 'K65LO4R7'),
       (103, 'ZE657QP2');

INSERT INTO `persons` (`first_name`, `salary`, `passport_id`)
VALUES ('Roberto', 43300.00, 102),
       ('Tom', 56100.00, 103),
       ('Yana', 60200.00, 101);


#02. One-To-Many Relationship
CREATE TABLE `manufacturers`
(
    `manufacturer_id` INT PRIMARY KEY AUTO_INCREMENT,
    `name`            VARCHAR(20) NOT NULL,
    `established_on`  DATE
);

CREATE TABLE `models`
(
    `model_id`        INT PRIMARY KEY,
    `name`            VARCHAR(20) NOT NULL,
    `manufacturer_id` INT         NOT NULL,
    CONSTRAINT `fk_models_manufacturers`
        FOREIGN KEY (`manufacturer_id`)
            REFERENCES `manufacturers` (`manufacturer_id`)
);


INSERT INTO `manufacturers` (`name`, `established_on`)
VALUES ('BMW', '1916-03-01'),
       ('Tesla', '2003-01-01'),
       ('Lada', '1966-05-01');

INSERT INTO `models`
VALUES (101, 'X1', 1),
       (102, 'i6', 1),
       (103, 'Model S', 2),
       (104, 'Model X', 2),
       (105, 'Model 3', 2),
       (106, 'Nova', 3);

#03. Many-To-Many Relationship
CREATE TABLE `students`
(
    student_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name       VARCHAR(45)
);
CREATE TABLE `exams`
(
    exam_id int primary key,
    name    varchar(45) not null
);

insert into students
values (1, 'Mila'),
       (2, 'Toni'),
       (3, 'Ron');

insert into exams
values (101, 'Spring MVC'),
       (102, 'Neo4j'),
       (103, 'Oracle 11g');


create table students_exams
(
    student_id int,
    exam_id    int,
    constraint pk_student_exams
        primary key (student_id, exam_id),


    constraint fk_students_exams_exams
        foreign key (exam_id)
            references exams (exam_id),


    constraint fk_students_exams_students
        foreign key (student_id)
            references students (student_id)

);


INSERT INTO `students_exams`
VALUES (1, 101),
       (1, 102),
       (2, 101),
       (3, 103),
       (2, 102),
       (2, 103);

#4.	Self-Referencing

create table teachers
(
    teacher_id int primary key,
    name       varchar(45) not null,
    manager_id int references teachers (teacher_id)
);

insert into teachers
values (101, 'John', null),
       (102, 'Maya', 105),
       (103, 'Silvia', 106),
       (104, 'Ted', 105),
       (105, 'Mark', 101),
       (106, 'Greta', 101);

ALTER table teachers
    add constraint fk_manager_teacher
        foreign key (manager_id)
            references teachers (teacher_id);

#5.	Online Store Database
create table cities
(
    city_id int(11) primary key auto_increment,
    name    varchar(50)
);

create table customers
(
    customer_id int(11) primary key auto_increment,
    name        varchar(50),
    birthday    date,
    city_id     int(11),
    constraint fk_customer_city
        foreign key (city_id)
            references cities (city_id)

);

create table orders
(
    order_id    int(11) primary key auto_increment,
    customer_id int(11),
    constraint fk_order_customer
        foreign key (customer_id)
            references customers (customer_id)
);

create table item_types
(
    item_type_id int(11) primary key,
    name         varchar(50)
);

create table items
(
    item_id      int(11) primary key auto_increment,
    name         varchar(50),
    item_type_id int(11),
    constraint fk_item_item_types
        foreign key (item_type_id)
            references item_types (item_type_id)
);


create table order_items
(
    order_id int(11),
    item_id  int(11),
    constraint pk_order_item
        primary key (order_id, item_id),


    constraint fk_order_items_orders
        foreign key (order_id)
            references orders (order_id),


    constraint fk_order_items_items
        foreign key (item_id)
            references items (item_id)
);






#6.	University Database
create table majors
(
    major_id int(11) primary key auto_increment,
    name     varchar(50) not null
);

create table students
(
    student_id     int(11) primary key auto_increment,
    student_number varchar(12)not null ,
    student_name   varchar(50)not null ,
    major_id       int,
    constraint fk_students_major
        foreign key (major_id)
            references majors (major_id)

);

create table payments
(
    payment_id     int(11) primary key auto_increment,
    payment_date   date not null ,
    payment_amount decimal(8, 2) not null ,
    student_id     int,
    constraint fk_payments_students
        foreign key (student_id)
            references students (student_id)

);

create table subjects
(
    subject_id   int(11) primary key auto_increment,
    subject_name varchar(50) not null
);

create table agenda
(
    student_id int(11) not null ,
    subject_id  int(11) not null ,
    constraint pk_student_subject
        primary key (student_id, subject_id),


    constraint fk_agenda_student_id
        foreign key (student_id)
            references students (student_id),


    constraint fk_agenda_subject_id
        foreign key (subject_id)
            references subjects (subject_id)
);

select mountain_range, peak_name,elevation from peaks as p
join mountains m on p.mountain_id = m.id
where mountain_range = 'Rila'
order by elevation desc
;