-- Limit 

SELECT *
FROM employee_demographics
order by age desc
LIMIT 2, 1
;

-- Aliasing
SELECT gender, avg(age) as avg_age
FROM employee_demographics
group by gender
having avg(age) > 40
;

