/**
 * Use a loop to return numbers from 1 to n.
 *
 * @author  T.Sergeant
 * @version For DB class
 *
 * Demonstrates one version of FOR loop. Shows how to use RAISE for
 * generating debugging output. Shows how to returns multiple results
 * via SETOF and RETURN NEXT.
 *
 * SELECT * FROM demo_for(12);
 *
*/
CREATE OR REPLACE FUNCTION demo_for(n INTEGER) RETURNS SETOF INTEGER AS $$
DECLARE
	i      INTEGER;
BEGIN
	FOR i IN 1 .. n LOOP
		RAISE NOTICE 'i is %',i;
		RETURN NEXT i;
	END LOOP;
END;
$$ LANGUAGE plpgsql;
