-- Having vs Where

SELECT gender, AVG(age)
FROM employee_demographics
group by gender
HAVING AVG(age) > 40
;
