#1.	 Mountains and Peaks
create table mountains
(
    id   int(8) primary key auto_increment not null,
    name varchar(45)
);

create table peaks
(
    id          int(8) primary key auto_increment not null,
    name        varchar(45),
    mountain_id int,
    constraint peek_to_mountain
        foreign key (mountain_id)
            references mountains (id)
on delete cascade

);

#2.	 Trip Organization
select driver_id, vehicle_type, concat(c.first_name, ' ', c.last_name) as driver_name
from vehicles as v
         join campers c on v.driver_id = c.id
;


#3.	SoftUni Hiking
select r.starting_point, r.end_point, c.id as leader_id, concat(c.first_name, ' ', c.last_name) as leader_name
from routes as r
         join campers c on r.leader_id = c.id;

#4.	Delete Mountains
create table mountains
(
    id   int(8) primary key auto_increment not null,
    name varchar(45)
);

create table peaks
(
    id          int(8) primary key auto_increment not null,
    name        varchar(45),
    mountain_id int,
    constraint fk_peek_mountain
        foreign key (mountain_id)
            references mountains (id)
            on delete cascade

);
