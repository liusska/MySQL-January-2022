CREATE TABLE `logs` (
	`log_id` INT PRIMARY KEY AUTO_INCREMENT,
	`account_id` INT NULL,
	`old_sum` DECIMAL(19, 4) NOT NULL,
	`new_sum` DECIMAL(19, 4) NOT NULL
);

DELIMITER ###
CREATE TRIGGER tr_balance_update
AFTER UPDATE 
ON `accounts`
FOR EACH ROW
BEGIN
	IF OLD.balance <> NEW.balance THEN
		INSERT INTO `logs` (`account_id`, `old_sum`, `new_sum`)
		VALUES (OLD.id, OLD.balance, NEW.balance);
	END IF;

END ###