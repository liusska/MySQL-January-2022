-- ex.0
CREATE DATABASE `minions`;
USE `minions`;

-- ex.1 Create Tables
CREATE TABLE `minions` (
`id` INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(30),
`age` INT
);
CREATE TABLE `towns` (
`id` INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(30)
);

ALTER TABLE `towns`
CHANGE COLUMN `town_id` `id` INT;

-- ex.2 Alter Minions Table
ALTER TABLE `minions`
ADD COLUMN `town_id` INT,
ADD CONSTRAINT `fk_minions_towns` 
FOREIGN KEY `minions`(`town_id`)
REFERENCES `towns`(`id`);

-- ex.3 Insert Records in Both Tables
INSERT INTO `towns` (`id`,`name`)
VALUES
	('1', 'Sofia'),
	('2', 'Plovdiv'),
	('3', 'Varna');
INSERT INTO `minions` (`id`,`name`,`age`,`town_id`)
VALUES 
	('1','Kevin', '22', '1'),
	('2','Bob', '15', '2'),
	('3','Steward', '22', '3');
    
-- ex.4 Truncate Table Minions
TRUNCATE TABLE `minions`;

-- ex.5 Drop All Tables
DROP TABLE `minions`;
DROP TABLE `towns`;

-- ex.6 Create Table People
CREATE TABLE `people`(
`id` INT AUTO_INCREMENT PRIMARY KEY,
`name` VARCHAR(200) NOT NULL,
`picture` BLOB,
`height` DOUBLE,
`weight` DOUBLE,
`gender` CHAR(1) NOT NULL,
`birthdate` DATE NOT NULL,
`biography` TEXT
);
INSERT INTO `people`(`id`,`name`,`picture`,`height`, `weight`, `gender`,`birthdate`,`biography`)
VALUES
	('1','name1','1','120.5','48.00','f','2020-11-20','asdasdasdddd'),
    ('2','name2','2','120.5','48.00','m','2020-11-21','asdasdasdddd'),
    ('3','name3','3','120.5','48.00','f','2020-11-22','asdasdasdddd'),
    ('4','name4','4','120.5','48.00','m','2020-11-23','asdasdasdddd'),
    ('5','name5','5','120.5','48.00','f','2020-11-24','asdasdasdddd');

-- ex.7 Create Table Users
CREATE TABLE `users`(
`id` INT AUTO_INCREMENT PRIMARY KEY,
`username` VARCHAR(30) UNIQUE NOT NULL,
`password` VARCHAR(26) NOT NULL,
`profile_picture` BLOB,
`last_login_time` DATETIME,
`is_deleted` BOOLEAN
);
INSERT INTO `users`(`id`,`username`,`password`)
VALUES
	('1','name1','asdasdasdddd'),
    ('2','name2','asdasdasdddd'),
    ('3','name3','asdasdasdddd'),
    ('4','name4','asdasdasdddd'),
    ('5','name5','asdasdasdddd');

-- ex.8. Change Primary Key
ALTER TABLE `users`
DROP PRIMARY KEY,
ADD CONSTRAINT `pk_users`
PRIMARY KEY `users`(`id`, `username`);

-- ex.9 Set Default Value of a Field
ALTER TABLE `users`
CHANGE COLUMN `last_login_time` `last_login_time` DATETIME DEFAULT NOW();

-- ex.10 Set Unique Field
ALTER TABLE `users`
DROP PRIMARY KEY,
ADD CONSTRAINT `pk_users`
PRIMARY KEY `users`(`id`),
CHANGE COLUMN `username` `username` VARCHAR(30) UNIQUE;


-- ex.11 Movies Database
CREATE DATABASE `movies`;
USE `movies`;

CREATE TABLE `directors` (
`id` INT PRIMARY KEY AUTO_INCREMENT, 
`director_name` VARCHAR(50) NOT NULL, 
`notes` TEXT);
INSERT INTO `directors` (`director_name`)
VALUES 
	('Test Test1'),
	('Test Test2'),
    ('Test Test3'),
    ('Test Test4'),
    ('Test Test5');


CREATE TABLE `genres` (
`id` INT PRIMARY KEY AUTO_INCREMENT, 
`genre_name` VARCHAR(50) NOT NULL, 
`notes` TEXT);
INSERT INTO `genres` (`genre_name`)
VALUES 
	('Test Test1'),
	('Test Test2'),
    ('Test Test3'),
    ('Test Test4'),
    ('Test Test5');

CREATE TABLE `categories` (
`id` INT PRIMARY KEY AUTO_INCREMENT, 
`category_name` VARCHAR(50) NOT NULL, 
`notes` TEXT);
INSERT INTO `categories` (`category_name`)
VALUES 
	('Test Test1'),
	('Test Test2'),
    ('Test Test3'),
    ('Test Test4'),
    ('Test Test5');


CREATE TABLE `movies` (
`id` INT PRIMARY KEY AUTO_INCREMENT, 
`title` VARCHAR(100) NOT NULL, 
`director_id` INT, 
`copyright_year` INT, 
`length` DOUBLE, 
`genre_id` INT, 
`category_id` INT, 
`rating` DOUBLE, 
`notes` TEXT);
INSERT INTO `movies` (`title`)
VALUES 
	('Test Test1'),
	('Test Test2'),
    ('Test Test3'),
    ('Test Test4'),
    ('Test Test5');

-- ex.12 Car Rental Database
CREATE DATABASE `car`;
USE `car`;

CREATE TABLE `categories` (
`id` INT PRIMARY KEY AUTO_INCREMENT, 
`category` VARCHAR(30), 
`daily_rate` DOUBLE(2,1), 
`weekly_rate` DOUBLE(2,1), 
`monthly_rate` DOUBLE(2,1), 
`weekend_rate`  DOUBLE(2,1)
);
INSERT INTO `categories`(`category`)
VALUES 
	('TestName1'),
	('TestName2'),
	('TestName3');
    
CREATE TABLE `cars` (
`id` INT PRIMARY KEY AUTO_INCREMENT, 
`plate_number` VARCHAR(10) NOT NULL, 
`make` DATE,
`model` VARCHAR(30) NOT NULL, 
`car_year` INT, 
`category_id` INT , 
`doors` INT, 
`picture` BLOB, 
`car_condition` TEXT, 
`available` BOOLEAN,
CONSTRAINT `fk_cars_category`
FOREIGN KEY cars(`id`) REFERENCES categories(`id`)
);
INSERT INTO `cars`(`plate_number`, `model`, `category_id`)
VALUES 
	('AS2223SS', 'Opel', 1),
    ('DD2223SS', 'Mazda', 5),
	('A85223SS', 'Audi', 2);

CREATE TABLE `employees` (
`id` INT PRIMARY KEY AUTO_INCREMENT, 
`first_name` VARCHAR(40) NOT NULL,
`last_name` VARCHAR(40) NOT NULL, 
`title` VARCHAR(40) NOT NULL, 
`notes` TEXT);

INSERT INTO `employees`(`first_name`, `last_name`, `title`)
VALUES 
	('Ivan0', 'test0', 'Test0'),
    ('Ivan1', 'test1', 'Test1'),
	('Ivan2', 'test2', 'Test2');
    
CREATE TABLE `customers` 
(`id` INT PRIMARY KEY AUTO_INCREMENT, 
`driver_licence_number` INT(6) NOT NULL UNIQUE, 
`full_name` VARCHAR(31) NOT NULL, 
`address` VARCHAR(31) , 
`city` VARCHAR(31), 
`zip_code` VARCHAR(10), 
`notes` TEXT
);

INSERT INTO `customers` (`driver_licence_number`, `full_name`)
VALUES 
	(23456, 'test0 Test0'),
    (23451, 'test1 Test1'),
	(33499, 'test2Test2');

CREATE TABLE `rental_orders` 
(`id` INT PRIMARY KEY AUTO_INCREMENT, 
`employee_id` INT NOT NULL, 
`customer_id` INT NOT NULL, 
`car_id` INT NOT NULL, 
`car_condition` TEXT, 
`tank_level` INT, 
`kilometrage_start` INT, 
`kilometrage_end` INT, 
`total_kilometrage` INT, 
`start_date` DATE, 
`end_date` DATE, 
`total_days` INT, 
`rate_applied` DOUBLE, 
`tax_rate` DOUBLE, 
`order_status` BOOLEAN, 
`notes` TEXT
-- CONSTRAINT `fk_rental_orders_emplyee` 
-- FOREIGN KEY `rental_orders`(`employee_id`) REFERENCES `employees`(`id`),
-- CONSTRAINT `fk_rental_orders_customer` 
-- FOREIGN KEY `rental_orders`(`customer_id`) REFERENCES `customers`(`id`),
-- CONSTRAINT `fk_rental_orders_car` 
-- FOREIGN KEY `rental_orders`(`car_id`) REFERENCES `cars`(`id`)
);
    
INSERT INTO `rental_orders` (`employee_id`, `customer_id`, `car_id`)
VALUES 
	(1, 2, 3),
	(1, 2, 3),
	(1, 3, 2);
    
-- ex.13 Basic Insert
CREATE DATABASE `soft_uni`;
USE `soft_uni`;

CREATE TABLE `towns` (
`id` INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(30) NOT NULL
);
INSERT INTO `towns` (`name`)
VALUES 
	('Sofia'),
	('Plovdiv'),
	('Varna'),
	('Burgas');
    
CREATE TABLE `addresses` (
`id` INT PRIMARY KEY AUTO_INCREMENT,
`address` VARCHAR(200),
`text` TEXT,
`town_id` INT,
CONSTRAINT `fk_addresses_towns`
FOREIGN KEY `addresses`(`town_id`) REFERENCES `towns`(`id`)
);

CREATE TABLE `departments` (
`id` INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(30) NOT NULL
);
INSERT INTO `departments` (`name`)
VALUES 
	('Engineering'),
    ('Sales'),
    ('Marketing'),
    ('Software Development'),
    ('Quality Assurance');

CREATE TABLE `employees` (
	`id` INT PRIMARY KEY AUTO_INCREMENT, 
	`first_name` VARCHAR(200) NOT NULL, 
	`middle_name` VARCHAR(200), 
	`last_name`  VARCHAR(200) NOT NULL, 
	`job_title` VARCHAR(50) NOT NULL, 
	`department_id` INT, 
	`hire_date` DATE, 
	`salary` DECIMAL, 
	`address_id` INT,
	CONSTRAINT `fk_employees_departments`
	FOREIGN KEY `employees`(`department_id`) REFERENCES `departments`(`id`),
    CONSTRAINT `fk_employees_addresses`
	FOREIGN KEY `employees`(`address_id`) REFERENCES `addresses`(`id`)
);

INSERT INTO `employees` (`first_name`, `middle_name`, `last_name`, `job_title`, 
	`department_id`, `hire_date`, `salary`)
VALUES 
	('Ivan', 'Ivanov', 'Ivanov','.NET Developer', 4, '2013-02-01',	3500.00),
	('Petar', 'Petrov', 'Petrov', 'Senior Engineer', 1, '2004-03-02', 4000.00),
    ('Maria', 'Petrova', 'Ivanova',	'Intern', 5, '2016-08-28', 525.25),
    ('Georgi', 'Terziev', 'Ivanov',	'CEO', 2,	'2007-12-09', 3000.00),
    ('Peter', 'Pan', 'Pan',	'Intern', 3,'2016-08-28', 599.88);

-- ex.14 Basic Select All Fields
SELECT * FROM `towns`;
SELECT * FROM `departments`;
SELECT * FROM `employees`;

-- ex.15 Basic Select All Fields and Order Them
SELECT * FROM `towns`
ORDER BY `name`;
SELECT * FROM `departments`
ORDER BY `name`;
SELECT * FROM `employees`
ORDER BY  `salary` DESC;

-- ex.16 Basic Select Some Fields
SELECT `name` FROM `towns`
ORDER BY `name`;
SELECT `name` FROM `departments`
ORDER BY `name`;
SELECT `first_name`, `last_name`, `job_title`, `salary` FROM `employees`
ORDER BY  `salary` DESC;

-- ex.17 Increase Employees Salary
UPDATE `employees`
SET `salary` = `salary` * 1.10;
SELECT `salary` FROM `employees`;

-- ex.18 Delete All Records
DELETE FROM `occupancies`






