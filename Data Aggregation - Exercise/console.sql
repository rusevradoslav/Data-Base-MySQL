use gringotts;


#01. Records’ Count
select count(id) as count
from wizzard_deposits;

#2.	 Longest Magic Wand
select max(magic_wand_size) as longest_magic_wand
from wizzard_deposits;

#3. Longest Magic Wand Per Deposit Groups
select deposit_group,
       max(magic_wand_size) as longest_magic_wand
from wizzard_deposits
group by deposit_group
order by longest_magic_wand, deposit_group;

#4. Smallest Deposit Group Per Magic Wand Size*
select deposit_group
from wizzard_deposits
having min(magic_wand_size)
;

#5.	 Deposits Sum
select deposit_group,
       sum(deposit_amount) as total_sum
from wizzard_deposits
group by deposit_group
order by total_sum;

#6. Deposits Sum for Ollivander Family
select deposit_group,
       sum(deposit_amount) as total_sum
from wizzard_deposits
where magic_wand_creator = 'Ollivander family'
group by deposit_group
order by total_sum;

#7.	Deposits Filter
select deposit_group,
       sum(deposit_amount) as total_sum
from wizzard_deposits
where magic_wand_creator = 'Ollivander family'
group by deposit_group
having total_sum < 150000
order by total_sum desc
;
#8. Deposit Charge
select deposit_group,
       magic_wand_creator,
       min(deposit_charge) as min_deposit_charge
from wizzard_deposits
group by deposit_group,
         magic_wand_creator
order by magic_wand_creator, deposit_group;

#9. Age Groups
select (CASE
            WHEN age between 0 and 10 THEN '[0-10]'
            WHEN age between 11 and 20 THEN '[11-20]'
            WHEN age between 21 and 30 THEN '[21-30]'
            WHEN age between 31 and 40 THEN '[31-40]'
            WHEN age between 41 and 50 THEN '[41-50]'
            WHEN age between 51 and 60 THEN '[51-60]'
            WHEN age > 60 THEN '[61+]'
    end)        as age_group,
       count(*) as wizard_count
from wizzard_deposits
group by age_group
order by age_group;

#10. First Letter
select left(first_name, 1) as first_letter
from wizzard_deposits
where deposit_group = 'Troll Chest'
group by first_letter
order by first_letter
;

#11.	Average Interest
select deposit_group, is_deposit_expired, avg(deposit_interest)
from wizzard_deposits
where deposit_start_date > '1985-01-01'
group by deposit_group, is_deposit_expired
order by deposit_group desc, is_deposit_expired;

#12.	Rich Wizard, Poor Wizard*


use soft_uni;
#13.	 Employees Minimum Salaries
select department_id, min(salary) as min_salary
from employees
where hire_date > '2000-01-01'
  and department_id in (2, 5, 7)
group by department_id
order by department_id;

#14.	Employees Average Salaries
create table hpe as
select *
from employees
where salary > 30000
  and manager_id != 42;

update hpe
set salary= salary + 5000
where department_id = 1;

select department_id, avg(salary) as avg_salary
from hpe
group by department_id
order by department_id;


#15. Employees Maximum Salaries
select department_id, max(salary) as max_salary
from employees
group by department_id
having max_salary not between 30000 and 70000;

#16.	Employees Count Salaries
select count(salary)
from employees
where manager_id is null;

#17.	3rd Highest Salary*
SELECT department_id,
       (SELECT DISTINCT e2.`salary`
        FROM employees AS e2
        WHERE e2.`department_id` = e1.`department_id`
        ORDER BY e2.`salary` DESC
        LIMIT 2 , 1) AS third_highest_salary
FROM employees AS e1
GROUP BY department_id
HAVING third_highest_salary IS NOT NULL;

#18.	 Salary Challenge**
select e1.first_name, e1.last_name, e1.department_id
from employees as e1
where e1.salary > (
    select avg(salary)
    from employees as e2
    where e2.department_id = e1.department_id
    group by e1.department_id
)
order by department_id, employee_id
limit 10;

#19.	Departments Total Salaries
select e1.department_id,
       (
           select sum(salary)
           from employees as e2
           where e1.department_id = e2.department_id
           order by e2.department_id
       )
from employees as e1
group by department_id;