#1.Subqueries and JOINs - Lab
select employee_id, concat(first_name, ' ', last_name), d.department_id, d.name
from departments as d
         join employees e on e.employee_id = d.manager_id
order by employee_id
limit 5;


#2. Towns and Addresses
select t.town_id, t.name, a.address_text
from towns as t
         join addresses a on t.town_id = a.town_id
where t.name in ('San Francisco', 'Sofia', 'Carnation')
order by town_id, address_id;

#3.	Employees Without Managers
select e.employee_id,e.first_name,e.last_name,d.department_id,e.salary
from employees as e
join departments d on e.department_id = d.department_id
where e.manager_id is null;

#4.	Higher Salary
select count(*) from employees
where salary> (select avg(salary) from employees);