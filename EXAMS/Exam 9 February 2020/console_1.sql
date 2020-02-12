create database fsd;
use fsd;
drop database fsd;
#01.	Table Design
create table coaches
(
    id          int primary key auto_increment,
    first_name  varchar(10) not null,
    last_name   varchar(20) not null,
    salary      decimal(10, 2)       default 0,
    coach_level int         not null default 0

);

create table skills_data
(
    id        int primary key auto_increment,
    dribbling int default 0,
    pace      int default 0,
    passing   int default 0,
    shooting  int default 0,
    speed     int default 0,
    strength  int default 0
);
create table countries
(
    id   int primary key auto_increment,
    name varchar(45) not null
);
create table towns
(
    id         int primary key auto_increment,
    name       varchar(45) not null,
    country_id int         not null,
    constraint fk_towns_country
        foreign key (country_id) references countries (id)

);
create table stadiums
(
    id       int primary key auto_increment,
    name     varchar(45) not null,
    capacity int         not null,
    town_id  int         not null,
    constraint fk_stadiums_town
        foreign key (town_id) references towns (id)
);
create table teams
(
    id          int primary key auto_increment,
    name        varchar(45) not null,
    established date        not null,
    fan_base    bigint      not null default 0,
    stadium_id  int         not null,
    constraint fk_teams_stadium
        foreign key (stadium_id) references stadiums (id)

);
create table players
(
    id             int primary key auto_increment,
    first_name     varchar(10)                 not null,
    last_name      varchar(20)                 not null,
    age            int            default 0    not null,
    position       char(1)                     not null,
    salary         decimal(10, 2) default 0.00 not null,
    hire_date      datetime,
    skills_data_id int                         not null,
    team_id        int,

    constraint fk_players_skills
        foreign key (skills_data_id) references skills_data (id),
    constraint fk_players_teams
        foreign key (team_id) references teams (id)

);
create table players_coaches
(
    player_id int,
    coach_id  int,
    constraint pk_played_coaches primary key (player_id, coach_id),
    constraint fk_players_coaches_players
        foreign key (player_id) references players (id),
    constraint fk_players_coaches_coaches
        foreign key (coach_id) references coaches (id)

);

#02.	Insert
insert into coaches(first_name, last_name, salary, coach_level)
select p.first_name, p.last_name, salary * 2, char_length(p.first_name)
from players as p
where p.age >= 45;
#bachka

#03.	Update
update coaches as c
set coach_level = coach_level + 1
where id in (select coach_id from players_coaches)
  and c.first_name like 'A%';
#bachka

#04.	Delete
delete
from players
where age >= 45;
#bachka
#5 Players
select first_name, age, salary
from players
order by salary desc;
#bachka

#06.	Young offense players without contract
select p.id, concat(first_name, ' ', last_name), age, position, hire_date
from players as p
         join skills_data sd on p.skills_data_id = sd.id
where age < 23
  and position = 'A'
  and hire_date is null
  and strength > 50
order by salary, age;
#bachka

#07.	Detail info for all teams
select t.name, t.established, t.fan_base, count(p.id) as count_players
from teams as t
         left join players p on t.id = p.team_id
group by t.id
order by count_players desc, fan_base desc;
#bachka
#08.	The fastest player by towns
select max(sd.speed) max_speed, t2.name as town_name
from skills_data as sd
         right join players p on sd.id = p.skills_data_id
         right join teams t on p.team_id = t.id
         right join stadiums s on t.stadium_id = s.id
         right join towns t2 on s.town_id = t2.id
where t.name != 'Devify'
group by t2.name
order by max_speed desc, town_name;

#09.	Total salaries and players by country

select c.name, count(p.id) as total_count_of_players, sum(salary) total_sum_of_salaries
from players as p
         right join teams t on p.team_id = t.id
         right join stadiums s on t.stadium_id = s.id
         right join towns t2 on s.town_id = t2.id
         right join countries c on t2.country_id = c.id
group by c.name
order by total_count_of_players desc, c.name;

#10.	Find all players that play on stadium

DELIMITER $$

CREATE FUNCTION udf_stadium_players_count(stadium_name VARCHAR(30))
    RETURNS int
    DETERMINISTIC
BEGIN
    declare result int;
    set result = (select count(p.id)
                  from players as p
                           join teams t on p.team_id = t.id
                           join stadiums s on t.stadium_id = s.id
                  where s.name = stadium_name);
    return result;
END $$

DELIMITER ;

SELECT udf_stadium_players_count('Jaxworks') as `count`;
SELECT udf_stadium_players_count ('Linklinks') as `count`;

DELIMITER //

CREATE PROCEDURE udp_find_playmaker(min_dribble_points int, team_name varchar(45))
BEGIN
    select concat(p.first_name, ' ', p.last_name) AS full_name, p.age, p.salary, sd.dribbling, sd.speed, t.name
    from players as p
    join teams t on p.team_id = t.id
    join skills_data sd on p.skills_data_id = sd.id
    where t.name = team_name
      and sd.dribbling > min_dribble_points
      and sd.speed > (select avg(speed) from skills_data)
    order by sd.speed desc
    limit 1
    ;
END //

DELIMITER ;

call udp_find_playmaker(20, 'Skyble');
drop procedure  udp_find_playmaker