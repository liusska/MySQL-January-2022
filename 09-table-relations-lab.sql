-- ex.01 Mountains and Peaks
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

-- ex.02 Trip Organization
SELECT 
	v.`driver_id`,
    v.`vehicle_type` ,
	concat(c.`first_name`,' ', c.`last_name`) AS `driver_name`
FROM `campers` AS c
	JOIN `vehicles` AS v
    ON v.`driver_id` = c.`id`;
    
-- ex.03 3.	SoftUni Hiking
SELECT r.`starting_point`, r.`end_point`, r.`leader_id`,
	concat(c.`first_name`,' ', c.`last_name`) AS `leader_name`
FROM `routes` AS r
JOIN `campers` AS c
ON c.`id` = r.`leader_id`;

-- ex.04 Delete Mountains
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

-- ex.05 Project Management DB*
CREATE DATABASE `project_management`;
USE `project_management`;

CREATE TABLE `clients` (
`id` INT PRIMARY KEY AUTO_INCREMENT,
`client_name` VARCHAR(100)
);

CREATE TABLE `projects` (
`id` INT PRIMARY KEY AUTO_INCREMENT,
`client_id` INT,
`project_lead_id` INT,
CONSTRAINT `fk_projects_clients`
	FOREIGN KEY (`client_id`)
	REFERENCES `clients`(`id`)
);

CREATE TABLE `employees` (
`id` INT PRIMARY KEY AUTO_INCREMENT,
`first_name` VARCHAR(30),
`last_name` VARCHAR(30),
`project_id` INT,
CONSTRAINT `fk_employees_projects`
	FOREIGN KEY (`project_id`)
	REFERENCES `projects`(`id`)
);

ALTER TABLE `projects`
ADD CONSTRAINT `fk_projects_employees`
FOREIGN KEY (`project_lead_id`)
REFERENCES `employees`(`id`);

