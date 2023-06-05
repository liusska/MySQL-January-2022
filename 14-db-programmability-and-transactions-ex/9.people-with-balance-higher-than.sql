-- 09. People with Balance Higher Than

DELIMITER ###

CREATE PROCEDURE usp_get_holders_with_balance_higher_than(num DECIMAL(19,4))
BEGIN 
	SELECT ah.`first_name`, ah.`last_name`
	FROM `account_holders` AS ah
	JOIN `accounts` AS a
		ON a.`account_holder_id` = ah.`id`
	GROUP BY `account_holder_id`
    HAVING sum(`balance`) > num
    ORDER BY ah.`id`;
END ###

CALL usp_get_holders_with_balance_higher_than(7000)