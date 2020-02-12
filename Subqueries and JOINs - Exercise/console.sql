use soft_uni;
#01. Employee Address
select e.employee_id, e.job_title, a.address_id, a.address_text
from employees as e
         join addresses a on e.address_id = a.address_id
order by a.address_id
limit 5;

#2.	Addresses with Towns
select e.first_name, e.last_name, t.name, a.address_text
from employees as e
         join addresses a on e.address_id = a.address_id
         join towns t on a.town_id = t.town_id
order by first_name, last_name
limit 5;

#3.	Sales Employee
select e.employee_id, e.first_name, e.last_name, d.name
from employees as e
         join departments d on e.department_id = d.department_id
where d.name = 'Sales'
order by employee_id desc;

#4.	Employee Departments
select e.employee_id, e.first_name, e.salary as salary, d.name
from employees as e
         left join departments d on e.department_id = d.department_id
where e.salary > 15000
order by d.department_id desc;

#5.	Employees Without Project
select e.employee_id, e.first_name
from employees as e
         left join employees_projects ep on e.employee_id = ep.employee_id
where project_id is null
order by employee_id desc
limit 3;

#6.	Employees Hired After
select e.first_name, e.last_name, e.hire_date, d.name as dept_name
from employees as e
         join departments d on e.department_id = d.department_id
where e.hire_date > 1999 - 01 - 01
  and d.name in ('Sales', 'Finance')
order by hire_date;

#7.	Employees with Project
select e.employee_id, e.first_name, p.name
from employees e
         join employees_projects ep on e.employee_id = ep.employee_id
         join projects p on ep.project_id = p.project_id
where date(p.start_date) > 2002 - 08 - 13
  and p.end_date is null
order by first_name, p.name
limit 5;

#8.	Employee 24
select e.employee_id,
       e.first_name,
       (case
            when year(p.start_date) > 2004 then null
            else p.name
           end) as project_name
from employees as e
         join employees_projects ep on e.employee_id = ep.employee_id
         join projects p on ep.project_id = p.project_id
where e.employee_id = 24
order by project_name;

#9.	Employee Manager
select e.employee_id, e.first_name, e.manager_id, m.first_name
from employees as e
         join employees m on e.manager_id = m.employee_id
where m.employee_id in (3, 7)
order by e.first_name;

#10.	Employee Summary
select e.employee_id
     , concat(e.first_name, ' ', e.last_name) as employee_name
     , concat(m.first_name, ' ', m.last_name) as manager_name
     , d.name
from employees as e
         join employees m on e.manager_id = m.employee_id
         left join departments d on e.department_id = d.department_id
order by e.employee_id
limit 5;

#11.	Min Average Salary
select avg(salary) as min_avg_salary
from employees
group by department_id
order by avg(salary) asc
limit 1;

use geography;

#12. Highest Peaks in Bulgaria
select c.country_code, m.mountain_range, p.peak_name, p.elevation
from countries as c
         join mountains_countries mc on c.country_code = mc.country_code
         join mountains m on mc.mountain_id = m.id
         join peaks p on m.id = p.mountain_id
where p.elevation > 2835
  and mc.country_code = 'BG'
order by p.elevation desc;

#13. Count Mountain Ranges
select mc.country_code, count(m.mountain_range) as mountain_range
from mountains_countries as mc
         join mountains m on mc.mountain_id = m.id
where country_code in ('BG', 'US', 'RU')
group by mc.country_code
order by mountain_range desc;

#14.	Countries with Rivers
select c.country_name, r.river_name
from countries as c
         left join countries_rivers cr on c.country_code = cr.country_code
         left join rivers r on cr.river_id = r.id
where continent_code = 'AF'
order by c.country_name
limit 5;

#15. *Continents and Currencies
SELECT c.`continent_code`, c.`currency_code`, count(*) AS 'currency_usage'
FROM `countries` AS `c`
GROUP BY c.`continent_code` , c.`currency_code`
HAVING `currency_usage` > 1 AND `currency_usage` = (
    SELECT count(*) AS `count` FROM `countries` AS `c2`
    WHERE `c2`.`continent_code` = c.`continent_code`
    GROUP BY `c2`.`currency_code`
    ORDER BY `count` DESC
    LIMIT 1)
ORDER BY c.`continent_code` , c.`continent_code`;

#16. Countries without any Mountains
select count(c.country_code)AS country_count from countries as c
left join mountains_countries mc on c.country_code = mc.country_code
where mountain_id is null ;

#17.  Highest Peak and Longest River by Country
select c.country_name,max(p.elevation)as highest_peak_elevation , max(r.length) as highest_river_lenght from countries as c
join mountains_countries mc on c.country_code = mc.country_code
left join mountains m on mc.mountain_id = m.id
left join peaks p on m.id = p.mountain_id
join countries_rivers cr on c.country_code = cr.country_code
left join rivers r on cr.river_id = r.id
group by c.country_name
order by highest_peak_elevation desc ,highest_river_lenght desc
limit 5

