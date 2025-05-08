-- String Function

select length('skyfall');

select first_name, length(first_name)
from employee_demographics
order by 2
;


-- Upper and Lower
select upper('sky');
select lower('sky');

select first_name, upper(first_name)
from employee_demographics
;



-- Trim
select trim('      sky     ');
select ltrim('      sky     ');
select rtrim('      sky     ');



-- Substring
select first_name, 
left(first_name, 4),
right(first_name, 4),
substring(first_name, 3, 2),
birth_date,
substring(birth_date, 6, 2) as birth_month
from employee_demographics;



-- Replace
select first_name, replace(first_name, 'a', 'z')
from employee_demographics;



-- Locate
select locate ('x', 'Alexander');

select first_name, locate('An', first_name)
from employee_demographics;



-- Concat
select first_name, last_name,
CONCAT(first_name, ' ', last_name) as full_name
from employee_demographics;
