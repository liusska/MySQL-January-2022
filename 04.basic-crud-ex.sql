-- ex.01
SELECT * FROM `departments`
ORDER BY `department_id` ASC;

-- ex.02
SELECT DISTINCT `name` FROM  `departments`;

-- ex.3
SELECT `first_name`, `last_name`, `salary` 
FROM `employees`
ORDER BY `employee_id` ASC;

-- ex.4
SELECT `first_name`, `middle_name`, `last_name` 
FROM `employees`
ORDER BY `employee_id` ASC;

-- ex.05
SELECT concat(`first_name`, '.', `last_name`, '@softuni.bg') 
AS `full_email_addres`
FROM `employees`;

-- ex.06
SELECT DISTINCT `salary` FROM `employees`;

-- ex.07
SELECT * FROM `employees`
WHERE `job_title`='Sales Representative';

-- ex.08
SELECT `first_name`, `last_name`, `job_title` 
FROM `employees`
WHERE `salary` BETWEEN 20000 AND 30000
ORDER BY `employee_id`;

-- ex.09
SELECT concat_ws(' ', `first_name`, `middle_name`, `last_name`) 
AS 'Full Name'
FROM `employees`
WHERE `salary` IN (25000, 14000, 12500, 23600);

-- ex.10
SELECT `first_name`, `last_name` FROM `employees`
WHERE `manager_id` IS NULL;

-- ex.11
SELECT `first_name`, `last_name`, `salary` FROM `employees`
WHERE `salary`>50000
ORDER BY `salary` DESC;

-- ex.12
SELECT `first_name`, `last_name` FROM `employees`
ORDER BY `salary` DESC LIMIT 5;

-- ex.13
SELECT `first_name`, `last_name` FROM `employees`
WHERE `department_id` NOT IN (4);

-- ex.14
SELECT * FROM `employees`
ORDER BY 
	`salary` DESC, 
    `first_name` ASC, 
    `last_name` DESC, 
    `middle_name` ASC;

-- ex.15
CREATE VIEW `v_employees_salaries` AS
SELECT `first_name`, `last_name`, `salary` 
FROM `employees`;

-- ex.16
CREATE VIEW `v_employees_job_titles` AS 
SELECT concat_ws(' ', `first_name`, `middle_name`, `last_name`) AS 'full_name',
	`job_title`
FROM `employees`;

-- ex.17
SELECT DISTINCT `job_title` from `employees`
ORDER BY `job_title` ASC;

-- ex.18
CREATE VIEW `v_first_projects` AS
SELECT * FROM `projects` 
ORDER BY `start_date` ASC LIMIT 10;
SELECT * FROM `v_first_projects` 
ORDER BY `start_date`, `name`, `project_id`;

-- ex.19
SELECT `first_name`, `last_name`, `hire_date` FROM `employees`
ORDER BY `hire_date` DESC LIMIT 7;

-- ex.20
UPDATE `employees`
SET `salary`=`salary` * 1.12
WHERE `department_id` in (1, 2, 4, 11);
SELECT `salary` from `employees`;

-- ex.21
SELECT `peak_name` FROM `peaks`
ORDER BY `peak_name` ASC;

-- ex.22
CREATE VIEW `v_biggest_countries_by_population` AS
SELECT `country_name`, `population` FROM `countries`
WHERE `continent_code`='EU'
ORDER BY `population` DESC LIMIT 30;
SELECT * FROM `v_biggest_countries_by_population`
ORDER BY `population` DESC, `country_name` ASC;

-- ex.23 !!!!
SELECT `country_name`, `country_code`, 
    if(
		`currency_code`='EUR', 
		'Euro',
		'Not Euro'
        ) AS 'currency'
FROM `countries`
ORDER BY `country_name` ASC;

-- ex.24
SELECT `name` FROM `characters`
ORDER BY `name`;