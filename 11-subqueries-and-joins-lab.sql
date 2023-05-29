-- ex.01 Managers
SELECT 
	e.`employee_id`, 
	concat_ws(' ', e.`first_name`, e.`last_name`) AS `full_name`,
	d.`department_id`,
    d.`name` AS `department_name`
FROM `employees` AS e 
RIGHT JOIN `departments` AS d
	ON e.`employee_id` = d.`manager_id`
ORDER BY e.`employee_id`
LIMIT 5;

-- ex.02 Towns Addresses
SELECT t.`town_id`, t.`name`, a.`address_text`
FROM `towns` AS t
JOIN `addresses` AS a
	ON t.`town_id` = a.`town_id`
WHERE t.`name` IN ('San Francisco', 'Sofia', 'Carnation')
ORDER BY `town_id`, `address_id`;

-- ex.03 Employees Without Managers
SELECT `employee_id`, `first_name`, `last_name`, `department_id`, `salary`
FROM `employees` 
WHERE `manager_id` IS NULL;

-- ex.04 Higher Salary
SELECT count(*) FROM `employees`
WHERE 
	`salary` > (SELECT AVG(`salary`) FROM `employees`);
