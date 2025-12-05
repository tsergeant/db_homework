--DROP SCHEMA bankdb CASCADE;
CREATE SCHEMA bankdb;
SET SEARCH_PATH TO bankdb;

CREATE TABLE bank_account (
	account_id SERIAL,
	owner_ssn  VARCHAR(12) NOT NULL,
	owner_name VARCHAR(200) NOT NULL,
	balance    NUMERIC(12,2) NOT NULL DEFAULT 0.00,
	PRIMARY KEY(account_id)
);
