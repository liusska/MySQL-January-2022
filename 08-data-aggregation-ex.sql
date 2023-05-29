-- ex.01
SELECT count(*) AS `count` FROM `wizzard_deposits`;

-- ex.02
SELECT max(`magic_wand_size`) AS `longest_magic_wand` 
FROM `wizzard_deposits`;


-- ex.03
SELECT
	`deposit_group`,
	max(`magic_wand_size`) AS `longest_magic_wand` 
FROM `wizzard_deposits`
GROUP BY `deposit_group`
ORDER BY `longest_magic_wand`, `deposit_group`;

-- ex.04
SELECT
	`deposit_group`
FROM `wizzard_deposits`
GROUP BY `deposit_group`
ORDER BY min(`magic_wand_size`)
LIMIT 1;

-- ex.05
SELECT
	`deposit_group`,
    sum(`deposit_amount`) AS `total_sum`
FROM `wizzard_deposits`
GROUP BY `deposit_group`
ORDER BY `total_sum`;

-- ex.06
SELECT
	`deposit_group`,
    sum(`deposit_amount`) AS `total_sum`
FROM `wizzard_deposits`
WHERE `magic_wand_creator`='Ollivander family'
GROUP BY `deposit_group`
HAVING `total_sum` < 150000
ORDER BY `total_sum` DESC;

-- ex.07
SELECT
	`deposit_group`,
    sum(`deposit_amount`) AS `total_sum`
FROM `wizzard_deposits`
WHERE `magic_wand_creator`='Ollivander family'
GROUP BY `deposit_group`
ORDER BY `deposit_group` ASC;

-- ex.08
SELECT
	`deposit_group`,
    `magic_wand_creator`,
    min(`deposit_charge`) AS `min_deposit_charge`
FROM `wizzard_deposits`
GROUP BY `deposit_group`, `magic_wand_creator`
ORDER BY `magic_wand_creator`, `deposit_group`;

-- ex.09
SELECT
	CASE 
		WHEN `age` >= 0 AND `age` <= 10 THEN '[0-10]'
		WHEN `age` >= 11 AND `age` <= 20 THEN '[11-20]'
		WHEN `age` >= 21 AND `age` <= 30 THEN '[21-30]'
		WHEN `age` >= 31 AND `age` <= 40 THEN '[31-40]'
        WHEN `age` >= 41 AND `age` <= 50 THEN '[41-50]'
        WHEN `age` >= 51 AND `age` <= 60 THEN '[51-60]'
		WHEN `age` >= 61 THEN '[61+]'
	END AS `age_group`,
	count(`age`) AS `wizzard_count` 
 FROM `wizzard_deposits`
 GROUP BY `age_group`
 ORDER BY `wizzard_count`;
 
 -- ex.10
SELECT substring(`first_name`,1,1) as `first_letter`
FROM `wizzard_deposits`
WHERE `deposit_group`='Troll Chest'
GROUP BY `first_letter`
ORDER BY `first_letter`;

 -- ex.11
 SELECT 
	`deposit_group`,
	`is_deposit_expired`,
    avg(`deposit_interest`) AS `average_interest`
FROM `wizzard_deposits`
WHERE `deposit_start_date` > '1985-01-01'
GROUP BY `deposit_group`, `is_deposit_expired`
ORDER BY `deposit_group` DESC, `is_deposit_expired` ASC;

-- ex.12
SELECT 
	`department_id`,
	min(`salary`) AS `minimum_salary`
FROM `employees`
WHERE `department_id` IN (2, 5, 7) AND `hire_date` > '2000-01-01'
GROUP BY `department_id`
ORDER BY `department_id` ASC;

-- ex.13
SELECT `department_id`, 
	if(`department_id`=1,
		avg(`salary`) + 5000,
        avg(`salary`)
        ) AS `avg_salary`
FROM `employees`
WHERE `salary` > 30000 AND `manager_id`!= 42
GROUP BY `department_id`
ORDER BY `department_id`;

 -- ex.14
 SELECT 
	`department_id`,
	max(`salary`) AS `max_salary`
FROM `employees` 
GROUP BY `department_id`
HAVING `max_salary` NOT BETWEEN 30000 and 70000
ORDER BY `department_id` ASC;

-- ex.15
SELECT count(*)
FROM `employees`
WHERE `manager_id` is NULL;

-- ex.16*
SELECT `department_id`,
	(SELECT DISTINCT`salary` 
	FROM `employees` AS t2
    WHERE t1.`department_id` = t2.`department_id`
    ORDER BY `salary` DESC
    LIMIT 2, 1) AS `third_highest_salary`
FROM `employees` as t1
GROUP BY `department_id`
HAVING `third_highest_salary` IS NOT NULL
ORDER BY `department_id`;

-- ex.17**

-- ex.18
SELECT
	`department_id`,
	sum(`salary`) AS `total_salary`
FROM `employees`
GROUP BY `department_id`
ORDER BY `department_id`;
    
