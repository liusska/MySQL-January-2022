-- ex. 01 Employee Address
SELECT e.`employee_id`, e.`job_title`, a.`address_id`, a.`address_text`
FROM `employees` AS e
INNER JOIN `addresses` AS a
	ON a.`address_id` = e.`address_id`
ORDER BY e.`address_id` ASC
LIMIT 5;

-- ex.02 2.	Addresses with Towns
SELECT e.`first_name`, e.`last_name`, t.`name`, a.`address_text`
FROM `employees` AS e
INNER JOIN `addresses` AS a
	ON a.`address_id` = e.`address_id`
INNER JOIN `towns` AS t
	ON t.`town_id` = a.`town_id`
ORDER BY e.`first_name` ASC, e.`last_name`
LIMIT 5;

-- ex.03 3.	Sales Employee
SELECT e.`employee_id`, e.`first_name`, e.`last_name`, d.`name`
FROM `employees` AS e
INNER JOIN `departments` AS d
	ON e.`department_id` = d.`department_id`
WHERE d.`name` = 'Sales'
ORDER BY e.`employee_id` DESC;

-- ex.04 Employee Departments
SELECT e.`employee_id`, e.`first_name`, e.`salary`, d.`name`
FROM `employees` AS e
INNER JOIN `departments` AS d
	ON e.`department_id` = d.`department_id`
WHERE e.`salary` > 15000
ORDER BY d.`department_id` DESC
LIMIT 5;

-- ex.05 Employees Without Project
SELECT e.`employee_id`, e.`first_name`
FROM `employees` AS e
LEFT JOIN `employees_projects` AS ep
	ON ep.`employee_id` = e.`employee_id`
WHERE ep.`project_id` IS NULL
ORDER BY e.`employee_id` DESC
LIMIT 3;

-- ex.06 Employees Hired After
SELECT e.`first_name`, e.`last_name`, e.`hire_date`, d.`name`
FROM `employees` AS e
INNER JOIN `departments` AS d
	ON e.`department_id` = d.`department_id`
WHERE d.`name` IN ('Finance', 'Sales') AND e.`hire_date` > '1999-01-01'
ORDER BY e.`hire_date` ASC;

-- ex.07 Employees with Project
SELECT e.`employee_id`, e.`first_name`, p.`name`
FROM `employees` AS e
INNER JOIN `employees_projects` AS ep
	ON ep.`employee_id` = e.`employee_id`
INNER JOIN `projects` AS p
	ON ep.`project_id` = p.`project_id`
WHERE DATE(p.`start_date`) > '2002-08-13' and p.`end_date` IS NULL
ORDER BY e.`first_name`, p.`name`
LIMIT 5;

-- ex.08 Employee 24
SELECT e.`employee_id`, e.`first_name`, 
	if( year(p.`start_date`) >= 2005,
		p.`name` = NULL, 
		p.`name`
	)
FROM `employees` AS e
INNER JOIN `employees_projects` AS ep
	ON ep.`employee_id` = e.`employee_id`
INNER JOIN `projects` AS p
	ON ep.`project_id` = p.`project_id`
WHERE e.`employee_id` = 24
ORDER BY p.`name`;

-- ex.09 Employee Manager
SELECT e.`employee_id`, e.`first_name`, e.`manager_id`, m.`first_name`
FROM `employees` AS e
JOIN `employees` AS m
	ON e.`manager_id` = m.`employee_id`
WHERE e.`manager_id` IN (3, 7)
ORDER BY e.`first_name` ASC;

-- ex.10 Employee Summary
SELECT
	e.`employee_id`, 	
	concat_ws(' ', e.`first_name`, e.`last_name`) AS `employee_name`,
	concat_ws(' ', m.`first_name`, m.`last_name`) AS `manager_name`, 
	d.`name`
FROM `employees` AS e
JOIN `employees` AS m
	ON e.`manager_id` = m.`employee_id`
JOIN `departments` AS d
	ON e.`department_id` = d.`department_id`
ORDER BY e.`employee_id` ASC
LIMIT 5;

-- ex.11 Min Average Salary
SELECT avg(`salary`) AS `min_avg_salary`
FROM `employees`
GROUP BY `department_id`
ORDER BY `min_avg_salary` 
LIMIT 1;

-- ex.12 Highest Peaks in Bulgaria
SELECT c.`country_code`, m.`mountain_range`, p.`peak_name`, p.`elevation`
FROM `countries` AS c
JOIN `mountains_countries` AS mc
	ON c.`country_code` = mc.`country_code`
JOIN `mountains` AS m
	ON m.`id` = mc.`mountain_id`    
JOIN `peaks` AS p
	ON m.`id` = p.`mountain_id`  
WHERE c.`country_code` = 'BG' and p.`elevation` > 2835
ORDER BY p.`elevation` DESC;

-- ex.13 Count Mountain Ranges
SELECT c.`country_code`, count(m.`mountain_range`)
FROM `countries` AS c
JOIN `mountains_countries` AS mc
	ON c.`country_code` = mc.`country_code`
JOIN `mountains` AS m
	ON m.`id` = mc.`mountain_id`    
GROUP BY c.`country_code`
HAVING c.`country_code` in ('BG', 'RU', 'US')
ORDER BY count(m.`mountain_range`) DESC;

-- ex.14 Countries with Rivers
SELECT c.`country_name`, r.`river_name`
FROM `countries` AS c
LEFT JOIN `countries_rivers` AS cr
	ON c.`country_code` = cr.`country_code`
LEFT JOIN `rivers` AS r
	ON r.`id` = cr.`river_id`
WHERE c.`continent_code` = 'AF'
ORDER BY c.`country_name`
LIMIT 5;

-- ex.15 *Continents and Currencies
SELECT c.`continent_code`, c.`currency_code`, count(*) AS `currency_usage`
FROM `countries` AS c
GROUP BY c.`continent_code`, c.`currency_code`
HAVING `currency_usage` > 1 AND 
	`currency_usage` = (
		SELECT count(*) AS `most_used_currency`
		FROM `countries` AS c2
        WHERE c2.`continent_code` = c.`continent_code`
        GROUP BY c2.`currency_code`
		ORDER BY `most_used_currency` DESC
        LIMIT 1)
ORDER BY c.`continent_code`, c.`currency_code`;

-- ex. 16 Countries Without Any Mountains
SELECT count(c.`country_code`) AS `country_count`
FROM `countries` AS c
LEFT JOIN `mountains_countries` AS mc
	ON c.`country_code` = mc.`country_code`
WHERE mc.`mountain_id` IS NULL;

-- ex.17 Highest Peak and Longest River by Country
SELECT c.`country_name`, 
	max(p.`elevation`) AS `highest_peak_elevation`,
    max(r.`length`) AS `longest_river_length`
FROM `countries` AS c
JOIN `mountains_countries` AS mc
	ON c.`country_code` = mc.`country_code`   
JOIN `peaks` AS p
	ON mc.`mountain_id` = p.`mountain_id`  
JOIN `countries_rivers` AS cr
	ON c.`country_code` = cr.`country_code`
JOIN `rivers` AS r
	ON r.`id` = cr.`river_id`
GROUP BY c.`country_name`
ORDER BY 
	`highest_peak_elevation` DESC,  
    `longest_river_length` DESC, 
    c.`country_name`
LIMIT 5;
