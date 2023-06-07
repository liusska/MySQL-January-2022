-- DATA DEFINITION LANGUAGE (DDL) 

CREATE SCHEMA `insta`;
USE `insta`;
SET SQL_SAFE_UPDATES = 0;

-- 01.	Table Design

CREATE TABLE `photos` (
	`id` INT PRIMARY KEY AUTO_INCREMENT,
    `description` TEXT NOT NULL,
    `date` DATETIME NOT NULL,
    `views` INT NOT NULL DEFAULT 0
);

CREATE TABLE `comments` (
	`id` INT PRIMARY KEY AUTO_INCREMENT,
    `comment` VARCHAR(255) NOT NULL,
    `date` DATETIME NOT NULL,
    `photo_id` INT NOT NULL,
    CONSTRAINT `fk_comments_photos`
		FOREIGN KEY (`photo_id`)
		REFERENCES `photos`(`id`)
);

CREATE TABLE `users` (
	`id` INT PRIMARY KEY AUTO_INCREMENT,
    `username` VARCHAR(30) NOT NULL UNIQUE,
    `password` VARCHAR(30) NOT NULL,
    `email` VARCHAR(50) NOT NULL,
    `gender` CHAR(1) NOT NULL,
    `age` INT NOT NULL,
    `job_title` VARCHAR(40) NOT NULL,
    `ip` VARCHAR(30) NOT NULL
);

CREATE TABLE `users_photos` (
	`user_id` INT,
    `photo_id` INT,
    CONSTRAINT `fk_users_photos_photos`
		FOREIGN KEY (`photo_id`)
		REFERENCES `photos`(`id`),
	CONSTRAINT `fk_users_photos_users`
		FOREIGN KEY (`user_id`)
		REFERENCES `users`(`id`)
);

CREATE TABLE `likes` (
	`id` INT PRIMARY KEY AUTO_INCREMENT,
    `photo_id` INT,
    `user_id` INT,
    CONSTRAINT `fk_likes_photos`
		FOREIGN KEY (`photo_id`)
		REFERENCES `photos`(`id`),
	CONSTRAINT `fk_likes_users`
		FOREIGN KEY (`user_id`)
		REFERENCES `users`(`id`)
);


CREATE TABLE `addresses` (
	`id` INT PRIMARY KEY AUTO_INCREMENT,
    `address` VARCHAR(30) NOT NULL,
    `town` VARCHAR(30) NOT NULL,
    `country` VARCHAR(30) NOT NULL,
    `user_id` INT NOT NULL,
	CONSTRAINT `fk_addresses_users`
		FOREIGN KEY (`user_id`)
		REFERENCES `users`(`id`)
);

--  DATA MANIPULATION LANGUAGE (DML)

-- ex.02 INSERT
INSERT INTO `addresses` (`address`, `town`, `country`, `user_id`)
SELECT `username`, `password`, `ip`, `age`
FROM `users`
WHERE `gender` = 'M';

-- ex. 03 Update
UPDATE `addresses`
SET `country` = (CASE 
	WHEN `country` LIKE 'B%' THEN 'Blocked'
    WHEN `country` LIKE 'T%' THEN 'Test'
    WHEN `country` LIKE 'P%' THEN 'In Progress'
    ELSE `country`
    END)
WHERE `country` IS NOT NULL;

-- ex. 03 Delete
DELETE FROM `addresses`
WHERE `id` % 3 = 0;

-- QUERYING

-- ex.05 Users
SELECT 
	`username`,
	`gender`,
	`age`
FROM `users` 
ORDER BY `age` DESC, `username` ASC;

-- 06 Extract 5 Most Commented Photos
SELECT 
	p.`id`,
	p.`date`,
	p.`description`,
	count(c.`id`) AS `commentsCount`
FROM `photos` AS p
JOIN `comments` AS c
	ON p.`id` = c.`photo_id`
GROUP BY p.`id`
ORDER BY `commentsCount` DESC, `id` ASC
LIMIT 5;

-- ex.07 Lucky Users
SELECT 
	concat(`id`, ' ', `username`) AS `id_username`,
	`email`
FROM `users` AS u
JOIN `users_photos` AS up
	ON up.`user_id` = u.`id`
WHERE up.`user_id` = up.`photo_id`
ORDER BY u.`id` ASC;

-- ex.08 Count Likes and Comments
SELECT 
	p.`id`,
	count(DISTINCT l.`id`) AS `likes_count`,
    count(DISTINCT c.`id`) AS `comments_count`
FROM `photos` AS p
LEFT JOIN `likes` AS l
	ON p.`id` = l.`photo_id`
LEFT JOIN `comments` AS c
	ON c.`photo_id` = p.`id`
GROUP BY p.`id`
ORDER BY `likes_count` DESC, `comments_count` DESC, p.`id` ASC;

-- ex.09 
SELECT 
	CONCAT(SUBSTRING(`description`, 1, 30), '...')AS `summary`,
	`date`
FROM `photos`
WHERE DAY(`date`) = 10
ORDER BY `date` DESC;

-- PROGRAMMABILITY

-- ex.10 Get User’s Photos Count

DELIMITER ###
CREATE FUNCTION udf_users_photos_count(username VARCHAR(30)) 
RETURNS INT
BEGIN
	RETURN (
		SELECT COUNT(*) AS photosCount
		FROM `users` AS u
		JOIN `users_photos` AS up
			ON u.`id` = up.`user_id`
		WHERE u.`username` = username
	);
END ###

SELECT udf_users_photos_count('ssantryd') AS photosCount;

-- ex.11 Increase User Age
DELIMITER ###
CREATE PROCEDURE udp_modify_user(address VARCHAR(30), town VARCHAR(30))
BEGIN
	IF ((SELECT u.`username`
		FROM `users` AS u
		JOIN `addresses` AS a
		ON u.`id` = a.`user_id`
		WHERE a.`address` = address AND a.`town` = town) IS NOT NULL)
    THEN  
		UPDATE `users`AS u
		JOIN `addresses` AS aa
			ON u.`id` = aa.`user_id`
        SET u.`age` = u.`age` + 10    
		WHERE aa.`address` = address AND aa.`town` = town;
	END IF;
END ###

CALL udp_modify_user ('ygeratt0', '3rPO8dv0H');
SELECT u.username, u.email,u.gender,u.age,u.job_title FROM users AS u
WHERE u.username = 'eblagden21';
