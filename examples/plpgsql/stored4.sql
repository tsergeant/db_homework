/**
 * Display average book length and standard deviation of book lengths
 * grouped by publisher.
 *
 * @author  T.Sergeant
 * @version For DB class
 *
 * NOTE: PostgreSQL actually provides a built-in aggregate function for
 * calculating standard deviation. We calculate it manually here to show
 * how to execute a query in PL/PGSQL and cycle through its results and to
 * produce a query as a result of the function.
 *
 * To calculate standard deviation we first must know the mean ... then we
 * sum the squares of the differences between the mean and each value. Then
 * we divide the sum by the number of values and then take the square root.
 *
 * SELECT * FROM book_lengths();
 *
 * Before creating function, define the return type:

DROP FUNCTION book_lengths();
DROP TYPE return_type;
CREATE TYPE return_type AS (
	publisher_id       INTEGER,
	name               VARCHAR,
	average            FLOAT,
	standard_deviation FLOAT
);

*/

CREATE OR REPLACE FUNCTION book_lengths() RETURNS SETOF return_type AS $$
DECLARE
   result   return_type;
   count    INTEGER;
   sum      FLOAT;
   npages   INTEGER;
BEGIN
   FOR result IN
         (SELECT publisher_id,name,AVG(num_pages),0.0 AS standard_deviation
            FROM book JOIN publisher USING (publisher_id) GROUP BY publisher_id,name ORDER BY name) LOOP
      sum:= 0.0;
      count:= 0;
      FOR npages IN SELECT num_pages AS INTEGER FROM book WHERE publisher_id = result.publisher_id LOOP
			IF npages IS NOT NULL THEN
				sum:= sum + (npages-result.average)^2.0;
				count:= count + 1;
			END IF;
      END LOOP;
      result.standard_deviation= sqrt(sum/count);

      RETURN NEXT result;
   END LOOP;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM book_lengths();
