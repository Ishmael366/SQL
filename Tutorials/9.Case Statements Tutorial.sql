-- Case Statements

select first_name, 
last_name,
age,
case 
	when age <= 30 then 'YOUNG'
    when age between 31 and 50 then 'OLD'
    when age >= 50 then 'ON DEATHS DOOR'
end as Age_Bracket
from employee_demographics;



-- Pay Increase and Bonus
-- <50000 = 5 percent
-- >50000 = 7 percent
-- Finance = 10 percent
select first_name,
last_name, 
salary as Old_salary,
case
	when salary < 50000 then salary + (salary * .05)
    when salary > 50000 then salary + (salary * .07)
    when dept_id = 6 then salary + (salary * .1)
end as New_Salary
from employee_salary;

