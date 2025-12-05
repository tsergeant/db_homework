/**
 * Calculate sum of two parameters.
 *
 * @author  T.Sergeant
 * @version for DB class
 *
 * Demonstrates basic syntax to create a function, passing parameters,
 * returning a value, and declaring a variable.
 *
 * SELECT * FROM sum(5,7);
 *
*/
CREATE OR REPLACE FUNCTION funsum (a INTEGER, b INTEGER) RETURNS INTEGER AS $$
DECLARE
	answer INTEGER;
BEGIN
	answer:= a + b;
	RETURN answer;
END;
$$ LANGUAGE plpgsql;
