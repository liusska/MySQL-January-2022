-- ex.01 Count Employees by Town
DELIMITER ###ufn_count_employees_by_town
CREATE FUNCTION ufn_count_employees_by_town(town_name VARCHAR(20))
RETURNS INT
DETERMINISTIC
BEGIN
	RETURN
    (SELECT count(`employee_id`)
	FROM `employees` AS e
	JOIN `addresses` AS a
		ON e.`address_id` = a.`address_id`
	JOIN `towns` AS t
		ON t.`town_id` = a.`town_id`
	WHERE t.`name` = town_name);
END;

SELECT ufn_count_employees_by_town('Sofia');
