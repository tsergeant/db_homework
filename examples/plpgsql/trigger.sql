DROP schema trigger_demo CASCADE;
CREATE schema trigger_demo;
SET SEARCH_PATH TO trigger_demo;

CREATE TABLE cust
(
	cust_id    SERIAL PRIMARY KEY,
	cust_name  VARCHAR(30) NOT NULL,
	balance    DECIMAL(10,2)
);

CREATE TABLE cust_archive
(
	cust_id    INTEGER,
	cust_name  VARCHAR(30) NOT NULL,
	balance    DECIMAL(10,2),
	who        VARCHAR(50),
	tstamp     TIMESTAMP,
	operation  VARCHAR(10)
);

CREATE FUNCTION archive_cust() RETURNS TRIGGER AS $$
BEGIN
	IF TG_OP = 'DELETE' THEN
		INSERT INTO cust_archive VALUES(OLD.cust_id,OLD.cust_name,OLD.balance,CURRENT_USER,now(),TG_OP);
	ELSE
		INSERT INTO cust_archive VALUES(NEW.cust_id,NEW.cust_name,NEW.balance,CURRENT_USER,now(),TG_OP);
	END IF;
	RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER archive_cust_data AFTER INSERT OR UPDATE OR DELETE ON cust
	FOR EACH ROW EXECUTE PROCEDURE archive_cust();
