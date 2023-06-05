-- 05. Salary Level Function
DELIMITER ###
CREATE FUNCTION ufn_get_salary_level(salary DOUBLE(19, 4))
RETURNS VARCHAR(7)
DETERMINISTIC
BEGIN
	RETURN (CASE 
				WHEN salary < 30000 THEN 'Low'
				WHEN salary <= 50000 THEN 'Average'
				WHEN salary > 50000 THEN 'High'
			END);
END ###

SELECT ufn_get_salary_level(13500)