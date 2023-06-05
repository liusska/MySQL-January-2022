-- 03. Town Names Starting With

DELIMITER ###
CREATE PROCEDURE usp_get_towns_starting_with(str VARCHAR(10))
BEGIN
	SELECT `name` 
	FROM `towns`
	WHERE `name` LIKE concat(str,'%')
    ORDER BY `name`;
END ###

CALL usp_get_towns_starting_with('b')