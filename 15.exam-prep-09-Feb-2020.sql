-- DATA DEFINITION LANGUAGE (DDL) 

CREATE SCHEMA `fsd`;
USE `fsd`;

-- 01. Table Design

CREATE TABLE `countries` (
	`id` INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(45) NOT NULL
);

CREATE TABLE `towns` (
	`id` INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(45) NOT NULL,
    `country_id` INT NOT NULL,
    CONSTRAINT `fk_towns_countries`
		FOREIGN KEY(`country_id`)
		REFERENCES `countries`(`id`)
);

CREATE TABLE `stadiums` (
	`id` INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(45) NOT NULL,
    `capacity` INT NOT NULL,
    `town_id` INT NOT NULL,
    CONSTRAINT `fk_stadiums_towns`
		FOREIGN KEY(`town_id`)
		REFERENCES `towns`(`id`)
);

CREATE TABLE `teams` (
`id` INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(45) NOT NULL,
`established` DATE NOT NULL,
`fan_base` BIGINT,
`stadium_id` INT,
CONSTRAINT `fk_teams_stadiums`
    FOREIGN KEY(`stadium_id`)
    REFERENCES `stadiums`(`id`)
);

CREATE TABLE `skills_data` (
	`id` INT PRIMARY KEY AUTO_INCREMENT,
    `dribbling` INT DEFAULT 0,
    `pace` INT DEFAULT 0,
    `passing` INT DEFAULT 0,
    `shooting` INT DEFAULT 0,
    `speed` INT DEFAULT 0,
    `strength` INT DEFAULT 0
);

CREATE TABLE `players` (
	`id` INT PRIMARY KEY AUTO_INCREMENT,
	`first_name` VARCHAR(10) NOT NULL,
	`last_name` VARCHAR(20) NOT NULL,
	`age` INT NOT NULL DEFAULT 0,
    `position` CHAR(1) NOT NULL,
	`salary` DECIMAL(10,2) NOT NULL DEFAULT 0,
	`hire_date` DATETIME,
	`skills_data_id` INT NOT NULL,
    `team_id` INT,
    CONSTRAINT `fk_players_skills_data`
		FOREIGN KEY(`skills_data_id`)
		REFERENCES `skills_data`(`id`),
	CONSTRAINT `fk_players_teams`
		FOREIGN KEY(`team_id`)
		REFERENCES `teams`(`id`)
);

CREATE TABLE `coaches` (
	`id` INT PRIMARY KEY AUTO_INCREMENT,
	`first_name` VARCHAR(10) NOT NULL,
	`last_name` VARCHAR(20) NOT NULL,
	`salary` DECIMAL(10,2) NOT NULL DEFAULT 0,
	`coach_level` INT NOT NULL DEFAULT 0
);

CREATE TABLE `players_coaches` (
	`player_id` INT,
    `coach_id` INT,
    CONSTRAINT `pk_players_coaches`
		PRIMARY KEY (`player_id`, `coach_id`),
    CONSTRAINT `fk_players_coaches_players`
		FOREIGN KEY(`player_id`)
		REFERENCES `players`(`id`),
	CONSTRAINT `fk_players_coaches_coaches`
		FOREIGN KEY(`coach_id`)
		REFERENCES `coaches`(`id`)
);

--  DATA MANIPULATION LANGUAGE (DML)

-- ex.02 Insert

INSERT INTO `coaches`(`first_name`, `last_name`, `salary`, `coach_level`)
SELECT 
		`first_name`,
		`last_name`, 
        `salary` * 2, 
        CHAR_LENGTH(`first_name`)
	FROM `players`
    WHERE `age` >= 45;
    
-- ex.03 Update
UPDATE `coaches`
SET `coach_level` = `coach_level` + 1
WHERE `first_name` LIKE 'A%'
	AND (
		SELECT COUNT(*) 
		FROM `players_coaches` 
		WHERE coach_id = id ) > 0;
        
-- ex. 04 Delete
DELETE FROM `players`
WHERE `age` >= 45;


-- QUERYING

-- 05. Players
SELECT `first_name`, `age`, `salary`
FROM `players`
ORDER BY `salary` DESC;

-- 06. Young offense players without contract
SELECT 
	p.`id`,
	concat(p.`first_name`, ' ', p.`last_name`) AS `full_name`,
	p.`age`,
    p.`position`,
    p.`hire_date`
FROM `players` AS p
JOIN `skills_data` AS sd
	ON p.`skills_data_id` = sd.`id`
WHERE 
	`age` < 23 AND 
    `position` = 'A' AND 
    `hire_date` IS NULL AND 
    sd.`strength` > 50
ORDER BY `salary` ASC, `age`;

-- 07. Detail info for all teams
SELECT 
	t.`name`, 
    t.`established`, 
    t.`fan_base`, 
    (
		SELECT count(*)
		FROM `players` AS p
		WHERE t.`id` = p.`team_id`
    ) AS `players_count`
FROM `teams` AS t
ORDER BY `players_count` DESC, `fan_base` DESC;

-- 08 The fastest player by towns
SELECT max(sd.`speed`) AS max_speed, t.`name` 
FROM `towns` AS t
LEFT JOIN `stadiums` AS s
	ON s.`town_id` = t.`id`
LEFT JOIN `teams` AS te
	ON te.`stadium_id` = s.`id`
LEFT JOIN `players` AS p
	ON te.`id` = p.`team_id`
LEFT JOIN `skills_data` AS sd
	ON sd.`id` = p.`skills_data_id`
WHERE te.`name` != 'Devify'
GROUP BY t.`name`
ORDER BY `max_speed` DESC, t.`name` ASC;

-- ex.09 Total salaries and players by country
SELECT 
	c.`name`, 
    count(p.`id`) AS `total_count_of_players`, 
	sum(p.`salary`) AS `total_sum_of_salaries`
FROM `countries` AS c
LEFT JOIN `towns` AS t
	ON t.`country_id` = c.`id`    
LEFT JOIN `stadiums` AS s
	ON s.`town_id` = t.`id`
LEFT JOIN `teams` AS te
	ON te.`stadium_id` = s.`id`
LEFT JOIN `players` AS p
	ON te.`id` = p.`team_id`
GROUP BY c.`name`
ORDER BY `total_count_of_players` DESC, c.`name` ASC;

-- ex.10 Find all players that play on stadium

DELIMITER ###
CREATE FUNCTION udf_stadium_players_count(stadium_name VARCHAR(30))
RETURNS INT
DETERMINISTIC
BEGIN
	RETURN (
		    
SELECT 
		count(p.`id`) AS `count`
		FROM `stadiums` AS s
		LEFT JOIN `teams` AS t
			ON t.`stadium_id` = s.`id`
		LEFT JOIN `players` AS p
			ON t.`id` = p.`team_id`
		WHERE s.`name` =  stadium_name
		GROUP BY s.`name`
		);
END ###
    
SELECT udf_stadium_players_count ('Jaxworks') as `count`; 

-- ex.11 Find good playmaker by teams
DELIMITER ###
CREATE PROCEDURE udp_find_playmaker(
	min_dribble_points INT, team_name VARCHAR(45))
BEGIN
	SELECT 
		concat(p.`first_name`, ' ', p.`last_name`) AS `full_name`,
		p.`age`,
		p.`salary`,
		sd.`dribbling`,
		sd.`speed`,
		t.`name`
	FROM `teams` AS t
	JOIN `players` AS p
		ON p.`team_id` = t.`id`
	JOIN `skills_data` AS sd
		ON p.`skills_data_id` = sd.`id`
	WHERE 
		sd.`dribbling` > min_dribble_points AND 
		t.`name` = team_name AND
		sd.`speed` > (SELECT AVG(`speed`) FROM `skills_data`)
	ORDER BY sd.`speed` DESC
	LIMIT 1;
END ###

CALL udp_find_playmaker (20, 'Skyble');

