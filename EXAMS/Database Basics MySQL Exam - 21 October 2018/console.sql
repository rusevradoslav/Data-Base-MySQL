use colonial_journey_management_system_db;
create database colonial_journey_management_system_db;
drop database colonial_journey_management_system_db
#1.	Section: Database Overview
create table planets
(
    id   int primary key auto_increment,
    name varchar(30) not null
);

create table spaceports
(
    id        int primary key auto_increment,
    name      varchar(50) not null,
    planet_id int,
    constraint fk_spaceports_planets
        foreign key (planet_id)
            references planets (id)

);

create table spaceships
(
    id               int primary key auto_increment,
    name             varchar(50) not null,
    manufacturer     varchar(30) not null,
    light_speed_rate int default 0
);

create table colonists
(
    id         int primary key auto_increment,
    first_name varchar(20) not null,
    last_name  varchar(20) not null,
    ucn        char(10)    not null unique,
    birth_date date        not null

);

create table journeys
(
    id                       int primary key auto_increment,
    journey_start            datetime not null,
    journey_end              datetime not null,
    purpose                  enum ('Medical', 'Technical' , 'Educational', 'Military'),
    destination_spaceport_id int,
    spaceship_id             int,
    constraint fk_journeys_spacesport
        foreign key (destination_spaceport_id)
            references spaceports (id),
    constraint fk_journeys_spaceships
        foreign key (spaceship_id)
            references spaceships (id)

);


create table travel_cards
(
    id                 int primary key auto_increment,
    card_number        varchar(10),
    job_during_journey enum ('Pilot' , 'Engineer' , 'Trooper' , 'Cleaner' , 'Cook'),
    colonist_id        int,
    journey_id         int,
    constraint fk_travel_cards_colonist
        foreign key (colonist_id) references colonists (id),
    constraint fk_travel_cards_journeys
        foreign key (journey_id) references journeys (id)

);
#01.	Data Insertion
insert into travel_cards(card_number, job_during_journey, colonist_id, journey_id)
SELECT (case
            when c.birth_date > '1980-01-01' then concat(year(birth_date), DAY(birth_date), left(ucn, 4))
            else concat(year(birth_date), month(birth_date), right(ucn, 4))
    end),
       (case
            when c.id % 2 = 0 then 'Pilot'
            when c.id % 3 = 0 then 'Cook'
            else 'Engineer'
           end),
       c.id,
       left(ucn, 1)
from colonists as c
where c.id between 96 and 100;

#02.	Data Update
update journeys as j
set purpose := (case
                    when j.id % 2 = 0 then 'Medical'
                    when j.id % 3 = 0 then 'Technical'
                    when j.id % 5 = 0 then 'Educational'
                    when j.id % 7 = 0 then 'Military'
                    else purpose
    end
    )
where id not in (1);

#03.	Data Deletion
delete
from colonists
where id not in (select tc.colonist_id from travel_cards as tc);

#04.Extract all travel cards
select card_number, job_during_journey
from travel_cards
group by card_number
order by card_number;

#05. Extract all colonists
select id, concat(first_name, ' ', last_name), ucn
from colonists
order by first_name, last_name, id;

#06.	Extract all military journeys
select id, journey_start, journey_end
from journeys
where purpose = 'Military'
order by journey_start;

#07.	Extract all pilots
select c.id, concat(first_name, ' ', last_name) as fulll_name
from colonists as c
         join travel_cards tc on c.id = tc.colonist_id
where tc.job_during_journey = 'Pilot'
order by id;

#08.	Count all colonists that are on technical journey
select count(c.id)
from colonists as c
         join travel_cards tc on c.id = tc.colonist_id
         join journeys j on tc.journey_id = j.id
where j.purpose = 'Technical';

#9 Extract the fastest spaceship
select sh.name, sp.name
from spaceports as sp
         join journeys j on sp.id = j.destination_spaceport_id
         join spaceships sh on j.spaceship_id = sh.id
order by sh.light_speed_rate desc
limit 1;

#10.Extract spaceships with pilots younger than 30 years
select sh.name, sh.manufacturer
from spaceships as sh
         join journeys j on sh.id = j.spaceship_id
         join travel_cards tc on j.id = tc.journey_id
         join colonists c on tc.colonist_id = c.id
where (birth_date between '1990-01-01' and '2019-12-01')
  and job_during_journey = 'Pilot'#'2019-01-01' '2018-12-31'
group by sh.name, sh.manufacturer
order by sh.name;

#11. Extract all educational mission planets and spaceports
select p.name, sp.name
from planets as p
         join spaceports sp on p.id = sp.planet_id
         join journeys j on sp.id = j.destination_spaceport_id
where purpose = 'Educational'
order by sp.name desc;

#12. Extract all planets and their journey count
select p.name, count(j.id) as count
from planets as p
         join spaceports s on p.id = s.planet_id
         join journeys j on s.id = j.destination_spaceport_id
group by p.name
order by count desc, p.name asc;


#13.Extract the shortest journey
select j.id, p.name, sp.name, j.purpose
from journeys as j
         join spaceports sp on j.destination_spaceport_id = sp.id
         join planets p on sp.planet_id = p.id
ORDER BY datediff(j.journey_end, j.journey_start)
limit 1;

# 14.order by timestampdiff(journey_end,journey_start)
select tc.job_during_journey
from travel_cards as tc
         join journeys j on tc.journey_id = j.id
order by datediff(j.journey_end, j.journey_start) desc
limit 1;


#15. Get colonists count
DELIMITER $$

CREATE FUNCTION udf_count_colonists_by_destination_planet(planet_name VARCHAR(30))
    RETURNS integer
    DETERMINISTIC
BEGIN
    declare result integer;
    set result := (
        select count(c.id)
        from colonists as c
                 join travel_cards tc on c.id = tc.colonist_id
                 join journeys j on tc.journey_id = j.id
                 join spaceports s on j.destination_spaceport_id = s.id
                 join planets p on s.planet_id = p.id
        where p.name = planet_name
    );
    return result;
END $$

DELIMITER ;


SELECT p.name, udf_count_colonists_by_destination_planet('Otroyphus') AS count
FROM planets AS p
WHERE p.name = 'Otroyphus';

#16. Modify spaceship
DELIMITER //

CREATE PROCEDURE udp_modify_spaceship_light_speed_rate(spaceship_name VARCHAR(50), light_speed_rate_increse INT(11))
BEGIN
    IF ((SELECT count(ss.`name`) as `count`
         FROM `spaceships` AS `ss`
         WHERE ss.`name` = `spaceship_name`) > 0)
    THEN
        UPDATE `spaceships` as `ss`
        SET ss.`light_speed_rate` = ss.`light_speed_rate` + `light_speed_rate_increse`
        WHERE ss.`name` = `spaceship_name`;
    ELSE
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT  = 'Spaceship you are trying to modify does not exists.';
end if;
END //

DELIMITER ;

 