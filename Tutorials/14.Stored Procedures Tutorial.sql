-- Stored Procedures (Good for storing complex queries and simplifying code)
-- Similar to classes/functions in code

create procedure large_salaries()
select *
from employee_salary
where salary >= 50000;

call large_salaries();


-- Using Delimiters
delimiter $$
create procedure large_salaries2()
begin
	select *
	from employee_salary
	where salary >= 50000;
	select *
	from employee_salary
	where salary >= 100000;
end $$
delimiter ;

call new_procedure();


-- Parameters
delimiter $$
create procedure large_salaries3(p_huggymuffin int)
begin
	select salary
	from employee_salary
	where employee_id = p_huggymuffin;
end $$
delimiter ;

call large_salaries3(1)