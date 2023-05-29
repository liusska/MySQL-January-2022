USE `hotel`;

-- ex.1
SELECT * from `employees`
ORDER BY `id`;

-- ex.2
SELECT CONCAT(`first_name`, ' ',  `last_name`) AS `full_name`, `job_title`, `salary` 
    FROM `employees`
WHERE `salary` > 1000;

-- ex.3
UPDATE `employees`
SET `salary` = `salary` + 100
WHERE `job_title`='Manager';
SELECT `salary` from `employees`;

-- ex.4
SELECT * FROM `employees`
ORDER BY `salary` DESC LIMIT 1;

-- ex.5
SELECT * FROM `employees`
WHERE `salary` >= 1000 AND `department_id`=4;

-- ex.6
DELETE FROM `employees`
WHERE `department_id`=1 OR `department_id`=2;
SELECT * FROM `employees`
ORDER BY `id`