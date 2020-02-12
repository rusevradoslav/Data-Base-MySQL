use ruk_database;
create schema ruk_database
create table branches
(
    id   int primary key auto_increment,
    name varchar(30) not null unique
);
create table employees
(

    id         int primary key auto_increment,
    first_name varchar(20)    not null,
    last_name  varchar(20)    not null,
    salary     decimal(10, 2) not null,
    started_on date,
    branch_id  int            not null,
    constraint fk_emp_branch
        foreign key (branch_id) references branches (id)

);

create table clients
(
    id        int primary key auto_increment,
    full_name varchar(50) not null,
    age       int         not null

);

create table employees_clients
(
    employee_id int,
    client_id   int,
    constraint fk_employees_clients_emp
        foreign key (employee_id) references employees (id),
    constraint fk_employees_clients_clients
        foreign key (client_id) references clients (id)
);
create table bank_accounts
(
    id             int primary key auto_increment,
    account_number varchar(10) not null,
    balance        decimal(10, 2),
    client_id      int         not null unique,
    constraint fk_bank_accounts_clients
        foreign key (client_id) references clients (id)

);
create table cards
(
    id              int primary key auto_increment,
    card_number     varchar(19) not null,
    card_status     varchar(7)  not null,
    bank_account_id int         not null,
    constraint fk_cards_bank_account
        foreign key (bank_account_id) references bank_accounts (id)

);


insert into cards(card_number, card_status, bank_account_id)(
    select reverse(full_name), 'Active', id
    from clients
    where id between 191 and 200
);

update employees_clients as ec
set ec.employee_id = (
    select ecc.employee_id
    from (select *from employees_clients) as ecc
    group by employee_id
    order by count(ecc.client_id) asc, ecc.employee_id asc
    limit 1
)
where ec.employee_id = ec.client_id
;
#04.	Delete
delete emp
from employees as emp
         left join employees_clients as ec
                   on ec.employee_id = emp.id
where ec.client_id is null;

#05.	Clients
select id, full_name
from clients
order by id;

#06.	Newbies
select e.id,
       concat(first_name, ' ', last_name),
       concat('$', e.salary),
       e.started_on
from employees as e
where e.salary >= 100000
  and e.started_on > '2018-01-01'
order by salary desc, id asc
;

#07.	Cards against Humanity

select c.id, concat(card_number, ' : ', full_name)
from cards as c
         left join bank_accounts ba on c.bank_account_id = ba.id
         left join clients cl on ba.client_id = cl.id
order by id desc;

#08.Top 5 Employees
select concat(e.first_name, ' ', e.last_name) as full_name,
       started_on,
       count(ec.client_id)                    as count
from employees as e
         join employees_clients ec on e.id = ec.employee_id
group by e.id
order by count desc, e.id
limit 5;

#09.	Branch cards
select b.name, count(c2.id) as count_of_cards
from branches as b
         left join employees e on b.id = e.branch_id
         left join employees_clients ec on e.id = ec.employee_id
         left join clients c on ec.client_id = c.id
         left join bank_accounts ba on c.id = ba.client_id
         left join cards c2 on ba.id = c2.bank_account_id
group by b.name
order by count_of_cards desc, b.name;

#10.	Extract client cards counts


DELIMITER $$

CREATE FUNCTION udf_client_cards_count(given_name VARCHAR(30))
    RETURNS int
    DETERMINISTIC
BEGIN
    declare result int;
    set result =
            (select count(c.id)
             from clients as cl
                      join bank_accounts ba on cl.id = ba.client_id
                      join cards c on ba.id = c.bank_account_id
             where full_name = given_name);

    return result;
END $$

DELIMITER ;

select udf_client_cards_count('Baxy David');
drop function udf_client_cards_count;

#11.	Extract Client Info

DELIMITER //
CREATE PROCEDURE udp_clientinfo(given_full_name varchar(50))
BEGIN
    select c.full_name, c.age, ba.account_number, concat('$', ba.balance)
    from clients as c
             join bank_accounts ba on c.id = ba.client_id
    where full_name = given_full_name;
END //

DELIMITER ;

call udp_clientinfo('Hunter Wesgate');

drop procedure udp_clientinfo