-- ex.1
SELECT `title` FROM `books`
WHERE substring(`title`, 1, 3)='The';

-- ex.2
SELECT replace(`title`, 'The', '***') AS 'title'
FROM `books`
WHERE substring(`title`, 1, 3)='The';

-- ex.3
SELECT round(sum(`cost`), 2) AS 'total' FROM `books`;

-- ex.4
SELECT 
	concat_ws(' ', `first_name`, `last_name`) AS 'Full Name',
    timestampdiff(day, `born`, `died`) as 'Days Lived'
FROM `authors`;

-- ex.5
SELECT `title` FROM `books`
WHERE substring(`title`, 1, 12)='Harry Potter'
ORDER BY `id`;