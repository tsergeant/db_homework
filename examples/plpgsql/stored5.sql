/**
 * Consolidate duplicate authors under a single author id.
 *
 * @author  T.Sergeant
 * @version For DB class
 *
 * This function operates under the assumption that any authors with
 * matching first and last names are really the same person. This function
 * would make sense if sometimes a separate author id is accidently created
 * for an author so that their books are listed separately. This function
 * will find duplicate name and move all the books to be under a single
 * name. The rest of the duplicate names are deleted.
 *
 * The function produces a list of authors that were consolidated.
 *
 * SELECT * FROM consolidate_authors();
 *
*/

CREATE OR REPLACE FUNCTION consolidate_authors() RETURNS SETOF author AS $$
DECLARE
   result   RECORD;
   keep_id  INTEGER;
BEGIN
   FOR result IN
			(SELECT 0 AS author_id,firstname,lastname FROM author
			GROUP BY firstname,lastname HAVING COUNT(author_id)>1) LOOP
		SELECT author_id FROM author WHERE lastname=result.lastname AND firstname=result.firstname LIMIT 1 INTO keep_id;
		UPDATE book SET author_id=keep_id WHERE author_id
			IN (SELECT author_id FROM author WHERE lastname=result.lastname AND firstname=result.firstname);
		DELETE FROM author WHERE lastname=result.lastname AND firstname=result.firstname AND author_id<>keep_id;
		--RAISE NOTICE 'Keeping % as author_id for % %',keep_id,result.firstname,result.lastname;
		result.author_id:= keep_id;
      RETURN NEXT result;
   END LOOP;
END;
$$ LANGUAGE plpgsql;

