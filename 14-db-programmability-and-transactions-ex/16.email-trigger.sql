-- ex.16 Emails Trigger

CREATE TABLE `notification_emails`(
`id` INT PRIMARY KEY AUTO_INCREMENT,
`recipient` INT NOT NULL,
`subject` VARCHAR(60) NOT NULL,
`body` VARCHAR(255) NOT NULL
);

DELIMITER ###

CREATE TRIGGER `tr_notification_emails`
AFTER INSERT 
ON `logs`
FOR EACH ROW
BEGIN
	INSERT INTO `notification_emails`(`recipient`, `subject`, `body`)
    VALUES (
    NEW.account_id,
    CONCAT('Balance change for account: ', NEW.account_id),
    CONCAT(
		'On ', 
        DATE_FORMAT(NOW(), '%b %d  %Y at %r'), 
		'your balance was changed from ',
		ROUND(NEW.old_sum, 2),  
		' to ',
		ROUND(NEW.new_sum, 2),
        '.'
    ));
END ###
