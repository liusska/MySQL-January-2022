-- ex.1 Find Book Titles
SELECT `title` FROM `books`
WHERE substring(`title`, 1, 3)='The';

-- ex.2 Replace Titles
SELECT replace(`title`, 'The', '***') AS 'title'
FROM `books`
WHERE substring(`title`, 1, 3)='The';

-- ex.3 Sum Cost of All Books
SELECT round(sum(`cost`), 2) AS 'total' FROM `books`;

-- ex.4 Days Lived
SELECT 
	concat_ws(' ', `first_name`, `last_name`) AS 'Full Name',
    timestampdiff(day, `born`, `died`) as 'Days Lived'
FROM `authors`;

-- ex.5 Harry Potter Books
SELECT `title` FROM `books`
WHERE substring(`title`, 1, 12)='Harry Potter'
ORDER BY `id`;