-- Temp Tables (Storing intermediate results for complex queries, 
-- Manipulating data before insertion into permanent table)

create temporary table temp_table
(first_name varchar(50),
last_name varchar(50),
favorite_movie varchar(100)
);

insert into temp_table
values('Alex', 'Freberg', 'Lord of the Rings');

select *
from temp_table;



select * 
from employee_salary;

create temporary table salary_over_50k
select *
from employee_salary
where salary >= 50000;

select *
from salary_over_50k;


