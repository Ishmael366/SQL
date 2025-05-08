-- Joins

SELECT *
FROM employee_demographics;

SELECT *
FROM employee_salary;

-- Inner Join (Joins tables on specified column of same value)
SELECT dem.employee_id, age, occupation
FROM employee_demographics AS dem
inner join employee_salary AS sal
	on dem.employee_id = sal.employee_id
;

-- Outer Join (Left takes all from left table & returns only matches from right, vice versa for Right)
SELECT *
FROM employee_demographics AS dem
right join employee_salary AS sal
	on dem.employee_id = sal.employee_id
;

-- Self Join (Ties table to itself)
SELECT emp1.employee_id AS emp_santa,
emp1.first_name as first_name_santa,
emp1.last_name as last_name_santa,
emp2.employee_id AS emp_name,
emp2.first_name as first_name_emp,
emp2.last_name as last_name_emp
from employee_salary emp1
join employee_salary emp2
	on emp1.employee_id + 1 = emp2.employee_id
;

-- Joining Multiple tables
SELECT *
FROM employee_demographics AS dem
inner join employee_salary AS sal
	on dem.employee_id = sal.employee_id
inner join parks_departments as pd
	on sal.dept_id = pd.department_id
;

select *
from parks_departments;


