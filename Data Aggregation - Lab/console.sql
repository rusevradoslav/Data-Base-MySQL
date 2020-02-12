use restaurant;
#1.	 Departments Info
select department_id, count(id) as 'Number of employees'
from employees
group by department_id;

#2.	Average Salary
select department_id, round(avg(salary), 2) as 'Average Salary'
from employees
group by department_id;

#3.	 Min Salary
select department_id, round(min(salary), 2) as 'Min Salary'
from employees
group by department_id
having `Min Salary` > 800;

#4.	 Appetizers Count
select count(category_id)
from products
where category_id = 2
  and price > 8;

#5.	 Menu Prices
select category_id,
       round(avg(price), 2) as 'Average Price',
       round(min(price), 2) as 'Min Price',
       round(max(price), 2) as 'Max Price'
from products
group by category_id;

