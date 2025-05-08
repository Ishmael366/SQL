-- Unions

select first_name, last_name
from employee_demographics
union
select first_name, last_name
from employee_salary
;

select first_name, last_name, 'Old Man' as Label
from employee_demographics
where age > 40 and gender = 'male'
union
select first_name, last_name, 'Old Lady' as Label
from employee_demographics
where age > 40 and gender = 'female'
union
select first_name, last_name, 'Highly Paid Employee' as Label
from employee_salary
where salary > 70000
order by first_name, last_name
;

