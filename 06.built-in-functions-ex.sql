-- ex.01 Find Names of All Employees by First Name
SELECT `first_name`, `last_name`
FROM `employees`
WHERE substring(`first_name`, 1, 2)='Sa'
ORDER BY `employee_id`;


-- ex.02 Find Names of All Employees by Last Name
SELECT `first_name`, `last_name`
FROM `employees`
WHERE locate('ei', `last_name`)!=0
ORDER BY `employee_id`;

-- ex.03 Find First Names of All Employees
SELECT `first_name` FROM `employees`
WHERE `department_id` IN (3, 10) 
	AND year(`hire_date`) BETWEEN 1995 AND 2005
ORDER BY `employee_id`;

-- ex.04 Find All Employees Except Engineers
SELECT `first_name`, `last_name` FROM `employees`
WHERE lower(`job_title`) NOT LIKE '%engineer%'
ORDER BY `employee_id`;

-- ex.05 Find Towns with Name Length
SELECT `name` from `towns`
WHERE char_length(`name`) IN (5,6)
ORDER BY `name`;

-- ex.06 Find Towns Starting With
SELECT * from `towns`
WHERE substring(`name`, 1, 1) IN ('M', 'K', 'B', 'E')
ORDER BY `name`;

-- ex.07 Find Towns Not Starting With
SELECT * from `towns`
WHERE substring(`name`, 1, 1) NOT IN ('R', 'B', 'D')
ORDER BY `name`;

-- ex.08 Create View Employees Hired After 2000 Year
CREATE VIEW `v_employees_hired_after_2000` AS
	SELECT `first_name`, `last_name` 
FROM `employees`
WHERE year(`hire_date`) > 2000;
SELECT * FROM `v_employees_hired_after_2000`;

-- ex. 09 Length of Last Name
SELECT `first_name`, `last_name` FROM `employees`
WHERE char_length(`last_name`)=5
ORDER BY `employee_id`;

-- ex.10 Countries Holding 'A' 3 or More Times
SELECT `country_name`, `iso_code` 
FROM `countries`
WHERE lower(`country_name`) LIKE '%a%a%a%'
ORDER BY `iso_code`;

-- ex.11 Mix of Peak and River Names
SELECT `peak_name`, `river_name`, LOWER(CONCAT(`peak_name`, SUBSTRING(`river_name`, 2))) AS `obtained_mix`
FROM `peaks` p
JOIN `rivers` r ON SUBSTRING(p.peak_name, -1) = SUBSTRING(r.river_name, 1, 1)
ORDER BY `obtained_mix`;


-- ex.12 Games from 2011 and 2012 Year
SELECT `name`, DATE_FORMAT(`start`, '%Y-%m-%d') AS `start_date`
FROM `games`
WHERE year(`start`) BETWEEN 2011 AND 2012 
ORDER BY `start`, `name` LIMIT 50;

-- ex.13 User Email Providers
SELECT `user_name`, substring(`email`, locate( '@', `email`)+1) AS `email_provider`
FROM `users`
ORDER BY `email_provider`, `user_name`;

-- ex.14 Get Users with IP Address Like Pattern
SELECT `user_name`, `ip_address` FROM `users`
WHERE `ip_address` LIKE "___.1%.%.___"
ORDER BY `user_name` ASC;

-- ex.15 Show All Games with Duration and Part of the Day
SELECT `name`,
  CASE
    WHEN HOUR(`start`) >= 0 AND HOUR(`start`) < 12 THEN 'Morning'
    WHEN HOUR(`start`) >= 12 AND HOUR(`start`) < 18 THEN 'Afternoon'
    WHEN HOUR(`start`) >= 18 AND HOUR(`start`) < 24 THEN 'Evening'
  END AS 'Part of the Day',
  CASE 
	WHEN `duration` <= 3 THEN 'Extra Short'
    WHEN `duration` > 3 AND `duration` <= 6 THEN 'Short'
    WHEN `duration` > 6 AND `duration` <= 10 THEN 'Long'
    ELSE 'Extra Long'
  END AS `duration`
FROM
  `games`;
  
-- ex.16 Orders Table
 SELECT `product_name`, `order_date`,
	date_add(`order_date`, INTERVAL 3 DAY) AS `pay_due`,
    date_add(`order_date`, INTERVAL 1 MONTH) AS `deliver_due`
FROM `orders`