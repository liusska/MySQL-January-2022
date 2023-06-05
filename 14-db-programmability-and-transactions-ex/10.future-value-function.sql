-- 10. Future Value Function

CREATE FUNCTION ufn_calculate_future_value(i DECIMAL(19,4), r DOUBLE, t INT)
RETURNS DECIMAL(19,4)
DETERMINISTIC
RETURN (
	i * (pow(1 + r, t))
);

SELECT ufn_calculate_future_value(1000, 0.5, 5)