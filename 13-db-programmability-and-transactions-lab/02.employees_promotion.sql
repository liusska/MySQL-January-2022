-- ex.02 Employees Promotion
DELIMITER ###
CREATE PROCEDURE usp_raise_salaries(department_name VARCHAR(50))
BEGIN 
    UPDATE `employees` AS e
    JOIN `departments` AS d
		ON e.`department_id` = d.`department_id`
	SET e.`salary` = e.`salary` * 1.05
	WHERE d.`name` = department_name;
END ###

CALL usp_raise_salaries('Finance') ###

SELECT e.`employee_id`,  e.`salary`
FROM `employees` AS e
JOIN `departments` AS d
	ON e.`department_id` = d.`department_id`
WHERE d.`name` = 'Finance'
ORDER BY e.`first_name`, `salary`;
