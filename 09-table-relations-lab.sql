-- ex.01
CREATE TABLE `mountains` (
	`id` INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50)
);

CREATE TABLE `peaks` (
	`id` INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50),
    `mountain_id` INT
);

ALTER TABLE `peaks`
ADD CONSTRAINT `fk_peaks_mountains`
FOREIGN KEY (`mountain_id`)
REFERENCES `mountains`(`id`);

DROP TABLE `peaks`;

-- ex.02
SELECT 
	v.`driver_id`,
    v.`vehicle_type` ,
	concat(c.`first_name`,' ', c.`last_name`) AS `driver_name`
FROM `campers` AS c
	JOIN `vehicles` AS v
    ON v.`driver_id` = c.`id`;
    
-- ex.03
SELECT r.`starting_point`, r.`end_point`, r.`leader_id`,
	concat(c.`first_name`,' ', c.`last_name`) AS `leader_name`
FROM `routes` AS r
JOIN `campers` AS c
ON c.`id` = r.`leader_id`;

-- ex.04
CREATE TABLE `mountains` (
	`id` INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50)
);
CREATE TABLE `peaks` (
	`id` INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50),
    `mountain_id` INT,
    CONSTRAINT `fk_peaks_mountains`
	FOREIGN KEY (`mountain_id`)
	REFERENCES `mountains`(`id`)
    ON DELETE CASCADE
);