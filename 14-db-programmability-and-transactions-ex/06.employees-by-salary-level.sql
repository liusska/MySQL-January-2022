-- 06. Employees by Salary Level

DELIMITER ###
CREATE PROCEDURE usp_get_employees_by_salary_level(salary_level VARCHAR(7))
BEGIN
	SELECT e.`first_name`, e.`last_name`
	FROM `employees` AS e
	WHERE ufn_get_salary_level(e.`salary`) = salary_level
	ORDER BY e.`first_name` DESC, e.`last_name` DESC;
END ###

CALL usp_get_employees_by_salary_level('High')