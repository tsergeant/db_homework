/**
 * Display all prime numbers less than or equal to n.
 *
 * @author  T.Sergeant
 * @version For DB class
 *
 * Demonstrates one version of FOR loop. Shows how to use RAISE for
 * generating debugging output. Shows how to returns multiple results
 * via SETOF and RETURN NEXT.
 *
 * SELECT * FROM show_primes(12);
 *
*/
CREATE OR REPLACE FUNCTION show_primes(n INTEGER) RETURNS SETOF INTEGER AS $$
DECLARE
	i        INTEGER;
	j        INTEGER;
	is_prime BOOLEAN;
BEGIN
	RETURN NEXT 2;
	FOR i IN 3 .. n LOOP
		is_prime:= TRUE;
		FOR j IN 2 .. TRUNC(SQRT(i)) LOOP
			IF i%j = 0 THEN
				is_prime:= FALSE;
			END IF;
		END LOOP;
		IF is_prime THEN
			RETURN NEXT i;
		END IF;
	END LOOP;
END;
$$ LANGUAGE plpgsql;
