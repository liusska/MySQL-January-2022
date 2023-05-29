CREATE DATABASE `gamebar`;
USE `gamebar`;

-- ex.1
CREATE TABLE `employees` (
	`id` INT PRIMARY KEY AUTO_INCREMENT,
    `first_name` VARCHAR(30) NOT NULL,
    `last_name` VARCHAR(30) NOT NULL
);
CREATE TABLE `categories` (
	`id` INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(30) NOT NULL
);
CREATE TABLE `products` (
	`id` INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL,
    `category_id` INT NOT NULL
);

-- ex.2
INSERT INTO `employees` (`first_name`, `last_name`) 
VALUES 
	('Test1', 'Testov1'),
    ('Test2', 'Testov2'),
    ('Test3', 'Testov3');

-- ex.3
ALTER TABLE `employees`
ADD COLUMN `middle_name` VARCHAR(30);

-- ex.4
ALTER TABLE `products`
ADD CONSTRAINT `fk_products_categories`
FOREIGN KEY `products`(`category_id`) REFERENCES `categories`(`id`);

-- ex.5
ALTER TABLE `employees`
MODIFY COLUMN `middle_name` VARCHAR(100);

  