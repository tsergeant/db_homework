--DROP SCHEMA tdemodb CASCADE;
CREATE SCHEMA tdemodb;
SET SEARCH_PATH TO tdemodb;

CREATE TABLE names (
	name_id SERIAL,
	name VARCHAR(200),
	PRIMARY KEY(name_id)
);
