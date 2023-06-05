-- 07. Define Function

DELIMITER ###

	CREATE FUNCTION ufn_is_word_comprised(set_of_letters VARCHAR(50), word VARCHAR(50))
	RETURNS INT
	DETERMINISTIC
	BEGIN
		RETURN (
			word REGEXP (concat('^[', set_of_letters, ']+$'))
		);
	END ###

SELECT ufn_is_word_comprised('oistmiahf', 'Sofia')