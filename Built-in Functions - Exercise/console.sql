use soft_uni ;

#1.	Find Names of All Employees by First Name
SELECT first_name,
       last_name
FROM employees
WHERE first_name LIKE 'Sa%'
ORDER BY employee_id;

#2.	Find Names of All Employees by Last Name
SELECT first_name,
       last_name
FROM employees
WHERE last_name LIKE '%ei%'
ORDER BY employee_id;

#3.	Find First Names of All Employees
SELECT first_name
FROM employees
WHERE department_id IN (3, 10)
  AND hire_date BETWEEN '1995-01-01 00:00:00' AND '2005-12-31 23:59:00'
ORDER BY employee_id;

#4.	Find All Employees Except Engineers
SELECT first_name,
       last_name
FROM employees
WHERE job_title NOT LIKE '%engineer%'
ORDER BY employee_id;

# 5.	Find Towns with Name Length
select name
from towns
where char_length(name) = 5
   or char_length(name) = 6
order by name asc;

#6.	 Find Towns Starting With
select town_id, name
from towns
where name like 'M%'
   or name like 'K%'
   or name like 'B%'
   or name like 'E%'
order by name asc;

#7.	 Find Towns Not Starting With
select town_id, name
from towns
where name not like 'R%'
  and name not like 'D%'
  and name not like 'B%'
order by name asc;

#8.	Create View Employees Hired After 2000 Year
create view v_employees_hired_after_2000 as
SELECT first_name,
       last_name
FROM employees
where  hire_date BETWEEN '2001-01-01 00:00:00' AND localtimestamp;

#9.Length of Last Name
use geography;
#10.Countries Holding ‘A’ 3 or More Times
select country_name, iso_code
from countries
where country_name like '%a%a%a%'
order by iso_code;

#11.Mix of Peak and River Names
select peak_name , river_name, lower(concat(peak_name,substr(river_name,2))) as mix
from rivers,peaks
where right(peak_name,1) = left(river_name,1)
order by mix;

use diablo
#12.Games from 2011 and 2012 Year
select name, date_format(start, '%Y-%m-%d')
from games
where YEAR(start) between 2011 and 2012
order by start, name
limit 50;
#13. User Email Providers
select user_name, substr(email, locate('@', email) + 1) as 'Email Provider'
from users
order by `Email Provider`, user_name;
# 14Get Users with IP Address Like Pattern
SELECT user_name, ip_address
FROM users
WHERE ip_address LIKE '___.1%.%.___'
ORDER BY user_name;
#15. Show All Games with Duration and Part of the Day
select name,
       (CASE
            WHEN HOUR(start) BETWEEN 0 AND 11 THEN 'Morning'
            WHEN HOUR(start) BETWEEN 12 AND 17 THEN 'Afternoon'
            WHEN HOUR(start) BETWEEN 18 AND 24 THEN 'Evening'
           END
           ) as 'Part of the Day',
       (CASE
            WHEN duration BETWEEN 0 AND 3 THEN 'Extra Short'
            WHEN duration BETWEEN 4 AND 6 THEN 'Short'
            WHEN duration BETWEEN 7 AND 10 THEN 'Long'
            else 'Extra Long'
           END
           ) as 'Duration'
from games;

use orders;
#16.Orders Table
select product_name as 'Product',
       order_date as 'Date Ordered',
       date_add(order_date , interval 3 day ) as 'Pay Due',
       date_add(order_date , interval 1 month ) as 'Delivery Due'
from orders;


