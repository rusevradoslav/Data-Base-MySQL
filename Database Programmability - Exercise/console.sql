#1.	Employees with Salary Above 35000
USE soft_uni;
DELIMITER $$

CREATE PROCEDURE usp_get_employees_salary_above_35000()
BEGIN
    select first_name, last_name
    from employees
    where salary > 35000
    order by first_name, last_name, employee_id;
END $$

DELIMITER ;
call usp_get_employees_salary_above_35000();

#2.	Employees with Salary Above Number

DELIMITER $$

CREATE PROCEDURE usp_get_employees_salary_above(given_salary double)
BEGIN
    SELECT first_name, last_name
    FROM employees
    where salary >= given_salary
    order by first_name, last_name, employee_id;
END $$

DELIMITER ;

call usp_get_employees_salary_above(10000);

#3.	Town Names Starting With

DELIMITER $$
CREATE PROCEDURE usp_get_towns_starting_with(given_str varchar(20))
BEGIN
    SELECT name
    FROM towns as t
    where name like concat(given_str, '%')
    order by name;
END $$
DELIMITER ;


CALL usp_get_towns_starting_with('Sof');
drop procedure usp_get_towns_starting_with;

#4.	Employees from Town
DELIMITER $$
CREATE PROCEDURE usp_get_employees_from_town(town_name varchar(20))
BEGIN
    SELECT first_name, last_name
    FROM employees as e
             join addresses a on e.address_id = a.address_id
             join towns t on a.town_id = t.town_id
    where t.name like town_name
    order by e.first_name, e.last_name;
END;
$$
DELIMITER ;
call usp_get_employees_from_town('Sofia');
drop procedure usp_get_employees_from_town;
#5.	Salary Level Function
DELIMITER $$

CREATE FUNCTION ufn_get_salary_level(given_salary double)
    returns varchar(20)
    DETERMINISTIC

BEGIN
    declare result varchar(20);
    case
        when given_salary < 30000 then return result := 'low';
        when given_salary between 30000 and 50000 then set result := 'average';
        when given_salary > 50000 then set result := 'high';
        end case;

end
$$
DELIMITER ;

select ufn_get_salary_level(4000.0);
drop function ufn_get_salary_level;

#6.	Employees by Salary Level
DELIMITER $$

CREATE procedure usp_get_employees_by_salary_level(salary_level varchar(20))
BEGIN

    SELECT e.first_name, e.last_name
    FROM `employees` AS e
    WHERE e.salary < 30000 AND salary_level = 'low'
       OR e.salary >= 30000 AND e.salary <= 50000 AND salary_level = 'average'
       OR e.salary > 50000 AND salary_level = 'high'
    ORDER BY e.first_name DESC, e.last_name DESC;


end
$$
DELIMITER ;

CALL usp_get_employees_by_salary_level('low');
CALL usp_get_employees_by_salary_level('average');
CALL usp_get_employees_by_salary_level('high');

#7.	Define Function
DELIMITER $$
CREATE FUNCTION ufn_is_word_comprised(set_of_letters varchar(50), word varchar(50))
    RETURNS bit
    deterministic
    return word REGEXP (concat('^[', set_of_letters, ']+$'));
$$
DELIMITER
;
drop function ufn_is_word_comprised;
SELECT ufn_is_word_comprised('oistmiahf', 'Sofia');
SELECT ufn_is_word_comprised('oistmiahf', 'halves');
SELECT ufn_is_word_comprised('bobr', 'Rob');
SELECT ufn_is_word_comprised('pppp', 'Guy');


use bank;
#08. Find Full Name
DELIMITER $$
CREATE PROCEDURE usp_get_holders_full_name()
BEGIN
    SELECT CONCAT(h.first_name, ' ', h.last_name) AS 'full_name'
    FROM `account_holders` AS h
             JOIN
         (SELECT DISTINCT a.account_holder_id
          FROM `accounts` AS a) as a ON h.id = a.account_holder_id
    ORDER BY `full_name`;
END $$

DELIMITER ;
CALL usp_get_holders_full_name();

#9.	People with Balance Higher Than

DELIMITER $$
CREATE PROCEDURE usp_get_holders_with_balance_higher_than(g_balance DECIMAL(19, 4))
BEGIN
    select ah.first_name, ah.last_name
    from account_holders as ah
             join accounts as a on ah.id = a.account_holder_id
    group by a.account_holder_id
    having sum(a.balance) > g_balance
    order by a.account_holder_id;

END;
$$

DELIMITER ;

call usp_get_holders_with_balance_higher_than(7000);
drop PROCEDURE usp_get_holders_with_balance_higher_than
;
#10. Future Value Function
delimiter $$
create function ufn_calculate_future_value(initial_sum double,
                                           interest_rate double,
                                           number_years int)
    returns double
    deterministic
begin
    declare result double;
    set result := initial_sum * (pow((1 + interest_rate), number_years));
    return result;
end $$

drop function ufn_calculate_future_value;
select ufn_calculate_future_value(1000, 0.1, 5);

#11.	Calculating Interest

delimiter $$
create procedure usp_calculate_future_value_for_account(account_id int, interest_rate double)
begin
    select a.id,
           h.first_name,
           h.last_name,
           a.balance,
           round(ufn_calculate_future_value(a.balance, interest_rate, 5), 4) as balance_in_5_years
    from account_holders as h
             join accounts as a on h.id = a.account_holder_id
    where a.id = account_id;
end $$
delimiter ;
CALL usp_calculate_future_value_for_account(1, 0.1);
drop procedure usp_calculate_future_value_for_account;

#12.Deposit Money
DELIMITER //

CREATE PROCEDURE usp_deposit_money(account_id int, money_amount decimal(19, 4))
BEGIN
    case
        when money_amount > 0 then start transaction;
        end case;

    update accounts as a2
    set a2.balance = a2.balance + money_amount
    where a2.id = account_id;

    case
        when (select a.balance
              from accounts as a
              where a.id = account_id) < 0 then rollback ;
        else commit ;
        end case;
END
//

DELIMITER ;

call usp_deposit_money(1, 10);
drop procedure usp_deposit_money;
SELECT a.id AS 'account_id',
       a.account_holder_id,
       a.balance
FROM `accounts` AS a
WHERE a.id = 1;


#13.	Withdraw Money
DELIMITER //

CREATE PROCEDURE usp_withdraw_money(account_id int, money_amount decimal(19, 4))
BEGIN
    if (money_amount > 0) then
        start transaction ;


        update accounts as a2
        set balance=balance - money_amount
        where a2.id = account_id;

        if (select a.balance
            from accounts as a
            where a.id = account_id) - money_amount < 0 then
            rollback;
        else
            commit ;
        end if;
    end if;
END
//

DELIMITER ;
CALL usp_withdraw_money(1, 10);

SELECT a.id AS 'account_id',
       a.account_holder_id,
       a.balance
FROM `accounts` AS a
WHERE a.id = 1;


#14.	Money Transfer
delimiter $$
create procedure usp_transfer_money(from_account_id int, to_account_id int, amount decimal(19, 4))
begin
    if ((select a.id
         from accounts as a
         where from_account_id = a.id
        ) is not null
        and
        (select a.id
         from accounts as a
         where to_account_id = a.id
        ) is not null
        and
        from_account_id <> to_account_id
        and (select a2.balance
             from accounts as a2
             where a2.id = from_account_id) - amount > 0
        ) THEN
        START TRANSACTION;
        update accounts
        set balance=balance - amount
        where id = from_account_id;

        update accounts
        set balance=balance + amount
        where id = to_account_id;


        if (select a.balance
            from accounts as a
            where a.id = from_account_id) < 0 then
            rollback ;
        else
            commit ;
        end if;
    end if;

end
$$

CALL usp_transfer_money(1, 2, 10);
CALL usp_transfer_money(2, 1, 10);
SELECT
    a.id AS 'account_id', a.account_holder_id, a.balance
FROM
    `accounts` AS a
WHERE
        a.id IN (1 , 2);

drop procedure usp_transfer_money;

# 17.	Emails Trigger
CREATE TABLE `logs` (
                        log_id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
                        account_id INT(11) NOT NULL,
                        old_sum DECIMAL(19, 4) NOT NULL,
                        new_sum DECIMAL(19, 4) NOT NULL
);

DELIMITER $$
CREATE TRIGGER `tr_balance_updated`
    AFTER UPDATE ON `accounts`
    FOR EACH ROW
BEGIN
    IF OLD.balance <> NEW.balance THEN
        INSERT INTO `logs`
        (`account_id`, `old_sum`, `new_sum`)
        VALUES (OLD.id, OLD.balance, NEW.balance);
    END IF;
END $$
DELIMITER ;

CALL usp_transfer_money(1, 2, 10);
CALL usp_transfer_money(2, 1, 10);

SELECT * FROM `logs`;


CREATE TABLE `notification_emails` (
                                       `id` INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
                                       `recipient` INT(11) NOT NULL,
                                       `subject` VARCHAR(50) NOT NULL,
                                       `body` VARCHAR(255) NOT NULL
);

use bank;
DELIMITER $$
CREATE TRIGGER `tr_notification_emails`
    AFTER INSERT ON `logs`
    FOR EACH ROW
BEGIN
    INSERT INTO `notification_emails`
    (`recipient`, `subject`, `body`)
    VALUES (
               NEW.account_id,
               CONCAT('Balance change for account: ', NEW.account_id),
               CONCAT('On ', DATE_FORMAT(NOW(), '%b %d %Y at %r'), ' your balance was changed from ', ROUND(NEW.old_sum, 2), ' to ', ROUND(NEW.new_sum, 2), '.'));
END $$
DELIMITER ;

SELECT * FROM `notification_emails`;

DROP TRIGGER IF EXISTS `bank`.tr_notification_emails;
DROP TABLE IF EXISTS `notification_emails`;
