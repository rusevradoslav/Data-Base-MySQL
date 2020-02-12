SELECT first_name, last_name , salary  FROM employees;

#2
SELECT first_name, middle_name, last_name   FROM employees;

#3
SELECT * FROM employees; 

#4
SELECT salary FROM employees;

#5
SELECT concat(first_name,'.',last_name,'@softuni.bg' ) AS full_email_address FROM employees;
SELECT * FROM employees; 

 #6
SELECT DISTINCT salary FROM employees;

#7
SELECT * FROM employees
WHERE job_title = 'Sales Representative';

#8
SELECT first_name, last_name , job_title  FROM employees
WHERE salary BETWEEN 20000 AND 30000;

#9
SELECT concat(first_name,' ',middle_name,' ',last_name) AS 'Full Name' FROM employees
WHERE salary IN (25000, 14000, 12500 , 23600);

#10
SELECT first_name, last_name FROM employees
WHERE manager_id is null;

#11
SELECT first_name, last_name , salary FROM employees
WHERE salary > 50000 
ORDER BY salary DESC;

#12
SELECT first_name, last_name FROM employees
ORDER BY salary DESC 
LIMIT 5 ;

#13
SELECT first_name, last_name FROM employees
WHERE department_id != 4;

#14
SELECT * FROM employees
ORDER BY salary desc, first_name, last_name desc , middle_name ;

#15
CREATE VIEW v_employees_salaries AS SELECT first_name, last_name , salary FROM employees;

#16 
CREATE VIEW `v_employees_job_titles` AS
    SELECT CONCAT_WS(' ',employee.first_name,
	IF(employee.middle_name IS NULL,'',employee.middle_name),employee.last_name) AS 'Full Name',
        employee.job_title
    FROM `employees` AS employee;
    
#17
SELECT DISTINCT job_title FROM employees
ORDER BY job_title;

#18
SELECT * from projects 
order by `start_date`,`name`,`project_id`
limit 10;

#19
SELECT   first_name, last_name, hire_date FROM employees
order by hire_date desc
limit 7;

#20
update employees
set `salary` = `salary`* 1.12
where department_id in (1, 2, 3 ,4 ,11);

select salary from employees;



SELECT country_name,country_code,
    IF(currency_code = 'EUR','Euro','Not Euro') AS 'currency'
FROM`countries` AS country
ORDER BY country_name;

SELECT country.country_name, country.population
FROM `countries` AS country
WHERE country.continent_code = 'EU'
ORDER BY country.population DESC , country.country_name
LIMIT 30;



