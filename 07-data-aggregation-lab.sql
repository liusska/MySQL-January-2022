-- ex.01 Departments Info
SELECT `department_id`, count(`department_id`)
FROM `employees` AS e
GROUP BY e.`department_id`;

-- ex.02 Average Salary
SELECT `department_id`, round(avg(`salary`), 2) AS `Average Salary`
FROM `employees` AS e
GROUP BY e.`department_id`
ORDER BY e.`department_id`;

-- ex.03 Min Salary
SELECT `department_id`, round(min(`salary`), 2) AS `min_salary`
FROM `employees` AS e
GROUP BY e.`department_id`
HAVING `min_salary` > 800
ORDER BY e.`department_id`;

-- ex.04 Appetizers Count
SELECT count(`category_id`) as `appetizers_count` FROM `products`
WHERE `category_id` = 2 and `price` > 8;

-- ex.05 Menu Prices
SELECT `category_id`, 
	round(avg(`price`), 2) AS `avg_price`,
    min(`price`) AS `cheapest_product`,
	max(`price`) AS `most_expensive_product`
FROM `products`
GROUP BY `category_id`;


