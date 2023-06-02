-- 03. Employees Promotion by ID
DELIMITER ###
CREATE PROCEDURE usp_raise_salary_by_id(id INT)
BEGIN
	START TRANSACTION;
	IF(	
		(SELECT count(employee_id) 
        FROM employees
        WHERE employee_id = id) >0
    ) 
	THEN 
		UPDATE employees SET salary = salary *1.05 
		WHERE employee_id = id;
        COMMIT;
	ELSE 
		ROLLBACK;
	END IF; 
END ###
