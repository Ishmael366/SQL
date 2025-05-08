# -- 1. Which three departments had the highest satisfaction scores, and which three had the lowest satisfaction scores?
SELECT
	dept,
round(avg(satisfaction_level),2) as avg_satisfaction
FROM hr_happiness.`employee attrition`
Group by 1
Order by 2 desc;

#-- 2. What is the relationship between salary and satisfaction score?
Select
	distinct salary
FROM hr_happiness.`employee attrition`;

# -- 'low'
# -- 'medium'
# -- 'high'

Select
	salary,
    round(avg(satisfaction_level),2) as avg_satisfaction
FROM hr_happiness.`employee attrition`
group by 1
order by 2;


# -- 3. How did the top two and bottom two depts perform in the following arears
# -- 'support'
# -- 'management' top_dept

# -- 'hr'
# -- 'accounting' lower_dept
# -- a. last_evaluation

# -- b. number_project

# -- c. average_montly_hours

# -- d. time_spend_company
Select
    Case
     when dept in ('support', 'management') then 'top_dept'
     when dept in ('hr', 'accounting') then 'lower_dept'
	end as top_bot,
    round(avg(last_evaluation),2) as avg_last_evaluation,
    round(avg(number_project),1) as avg_projects,
    avg(average_montly_hours) as hours_worked,
    avg(time_spend_company) as time_at_company
FROM hr_happiness.`employee attrition`
where dept in ('support', 'management','hr', 'accounting')
group by 1
;


# -- d. time_spend_company

# -- e. Work_accident

# -- f. promotion_last_5years
Select
    Case
     when dept in ('support', 'management') then 'top_dept'
     when dept in ('hr', 'accounting') then 'lower_dept'
	end as top_bot,
    count(`Emp ID`) as number_of_emp,
    round(avg(last_evaluation),2) as avg_last_evaluation,
    round(avg(number_project),1) as avg_projects,
    round(avg(average_montly_hours),2) as hours_worked,
    round(avg(time_spend_company),2) as time_at_company,
    round(avg(Work_accident),2) as avg_num_accidents,
    round(avg(promotion_last_5years),2) as avg_num_proms
FROM hr_happiness.`employee attrition`
where dept in ('support', 'management','hr', 'accounting')
group by 1
;
