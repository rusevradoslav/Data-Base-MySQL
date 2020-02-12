#1. Count Employees by Town
DELIMITER  $$
CREATE FUNCTION ufn_count_employees_by_town(town_name VARCHAR(20))
    RETURNS DOUBLE
    deterministic

BEGIN

    DECLARE e_count DOUBLE;

    SET e_count = (SELECT COUNT(employee_id)
                   FROM employees AS e

                            INNER JOIN addresses AS a ON a.address_id = e.address_id

                            INNER JOIN towns AS t ON t.town_id = a.town_id

                   WHERE t.name = town_name);

    RETURN e_count;

END;
$$
delimiter ;
select ufn_count_employees_by_town('Sofia');

#2. Employees Promotion

DELIMITER $$

CREATE PROCEDURE usp_raise_salaries(department_name varchar(50))
BEGIN


    update employees as e
        join departments d on e.department_id = d.department_id
    set salary = salary * 1.05
    where d.name = department_name;

END
$$
DELIMITER ;

CALL usp_raise_salaries('Sales');

#3. Employees Promotion By ID
delimiter  $$

create procedure usp_raise_salary_by_id(id int)
begin
    start transaction;
    case
        when ((select count(employee_id)
               from employees as e
               where employee_id like id) <> 1)
            then rollback;
        else update employees as e
             set salary = salary * 1.05
             where e.employee_id = id;

        end case;
end
$$
delimiter ;

call usp_raise_salary_by_id(2);

#4. Triggered
Create table deleted_employees
(
    employee_id  int primary key auto_increment,
    first_name   varchar(255) not null,
    last_name    varchar(255) not null,
    middle_name  varchar(255) not null,
    job_title    varchar(255) not null,
    department_id int(20),
    salary       double       not null
);
delimiter $$
CREATE TRIGGER tr_deleted_employees

    AFTER DELETE

    ON employees

    FOR EACH ROW

BEGIN

    INSERT INTO deleted_employees
    (first_name,last_name,middle_name,job_title,department_id,salary)

    VALUES(OLD.first_name,OLD.last_name,OLD.middle_name,OLD.job_title,OLD.department_id,OLD.salary);

END;

$$
DELIMITER ;


