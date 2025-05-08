-- Triggers and Events
-- Actions that automatically occur when a specific event/function is called on a table

-- Triggers happen when events take place
select *
from employee_demographics;

select *
from employee_salary;



delimiter $$
create trigger employee_insert
	after insert on employee_salary
    for each row
begin
	insert into employee_demographics (employee_id, first_name, last_name)
	values (new.employee_id, new.first_name,new. last_name);
end $$
delimiter ;

insert into employee_salary (employee_id, first_name, last_name, occupation,
salary, dept_id) 
values(13, 'Jean-Ralph', 'Saperstein', 'Entertainment CEO', 1000000, NULL);



-- Events happen when scheduled
delimiter $$
create event delete_retirees
on schedule every 5 second
do
begin
	delete
	from employee_demographics
    where age >= 60;
end $$
delimiter ;

select *
from employee_demographics;


