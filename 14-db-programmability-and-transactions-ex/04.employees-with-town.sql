-- 04. Employees from Town

DELIMITER ###
CREATE PROCEDURE usp_get_employees_from_town(city VARCHAR(20))
BEGIN
	SELECT e.`first_name`, e.`last_name`
	FROM `employees` AS e
	JOIN `addresses` AS a
		ON a.`address_id` = e.`address_id`
	JOIN `towns` AS t
		ON a.`town_id` = t.`town_id`
	WHERE t.`name` = city
    ORDER BY e.`first_name`, e.`last_name`,  e.`employee_id`;
END ###

CALL usp_get_employees_from_town('Sofia')