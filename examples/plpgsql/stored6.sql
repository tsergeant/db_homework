/**
 * A trigger and function that will keep a log of books that were deleted
 * (along with who did the deleting).
 *
 * @author  T.Sergeant
 * @version For DB class
 *
 *
*/


--DROP TRIGGER delete_book_trigger;

CREATE OR REPLACE FUNCTION track_deleted_book() RETURNS TRIGGER AS $$
BEGIN
	INSERT INTO deleted_book VALUES(OLD.isbn,OLD.title,OLD.author_id,OLD.num_pages,OLD.publisher_id,OLD.year,NOW(),CURRENT_USER);
	RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER delete_book_trigger AFTER DELETE ON book
	FOR EACH ROW EXECUTE PROCEDURE track_deleted_book();

