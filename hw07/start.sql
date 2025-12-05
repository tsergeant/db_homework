
DROP SCHEMA hoteldb CASCADE;
CREATE SCHEMA hoteldb;
SET SEARCH_PATH TO hoteldb;

CREATE TABLE room (
	room_num      INTEGER,
	max_occupancy SMALLINT,
	cost          DECIMAL(6,2)
);

INSERT INTO room VALUES(100,4,139.99);
INSERT INTO room VALUES(101,2,89.99);
INSERT INTO room VALUES(102,2,89.99);
INSERT INTO room VALUES(103,2,89.99);
INSERT INTO room VALUES(104,2,89.99);
INSERT INTO room VALUES(104,3,99.99);
INSERT INTO room VALUES(105,20,139.99);
INSERT INTO room VALUES(200,4,139.99);
INSERT INTO room VALUES(201,2,89.99);
INSERT INTO room VALUES(202,2,89.99);
INSERT INTO room VALUES(203,2,89.99);
INSERT INTO room VALUES(204,NULL,NULL);
INSERT INTO room VALUES(205,20,139.99);

CREATE TABLE customer (
	customer_id SERIAL,
	lastname    VARCHAR(30),
	firstname   VARCHAR(30)
);
INSERT INTO customer VALUES(default,'Smith','Fred');
INSERT INTO customer VALUES(default,'Jones','Mary');
INSERT INTO customer VALUES(default,'Andy','Williams');
INSERT INTO customer VALUES(default,'Amy','Michaels');
INSERT INTO customer VALUES(1,'Smith','Mike');
INSERT INTO customer VALUES(default,'Doe');
INSERT INTO customer VALUES(default);
INSERT INTO customer VALUES(default,NULL,'James');

CREATE TABLE payment_method (
	payment_method_id SERIAL,
	card_type         VARCHAR(30),
	card_number       VARCHAR(30),
	expiration_date   DATE,
	card_code         VARCHAR(10)
);
INSERT INTO payment_method VALUES(default,'Mastercard','1234567890','2018-12-31','123');
INSERT INTO payment_method VALUES(default,'Mastercard','2345678901','2019-03-31','234');
INSERT INTO payment_method VALUES(default,'Visa','3456789012','2017-06-30','345');
INSERT INTO payment_method VALUES(default,'American Express','4567890123','2020-01-31','456');
INSERT INTO payment_method VALUES(default,'Mastercard','5678901234','2020-02-29','cool');
INSERT INTO payment_method VALUES(default,'Mastercard','1234567890','2018-12-31','345');
INSERT INTO payment_method VALUES(default,'Mastercard','1234567890','2020-03-31',NULL);
INSERT INTO payment_method VALUES(1,'Visa');

CREATE TABLE reservation (
	reservation_id    SERIAL,
	rdate             DATE,
	customer_id       INTEGER,
	payment_method_id INTEGER
);
INSERT INTO reservation VALUES(default,'2017-10-10',1,1);
INSERT INTO reservation VALUES(default,'2017-10-10',2,2);
INSERT INTO reservation VALUES(default,'2017-10-11',3,3);
INSERT INTO reservation VALUES(default,'2017-10-12',3,3);
INSERT INTO reservation VALUES(default,'2017-10-12',20,4);
INSERT INTO reservation VALUES(default,'2017-10-12',3,50);

CREATE TABLE room_reservation (
	reservation_id INTEGER,
	room_num       INTEGER
);


INSERT INTO room_reservation VALUES(1,100);
INSERT INTO room_reservation VALUES(1,101);
INSERT INTO room_reservation VALUES(1,102);
INSERT INTO room_reservation VALUES(1,105);

INSERT INTO room_reservation VALUES(2,200);
INSERT INTO room_reservation VALUES(2,201);
INSERT INTO room_reservation VALUES(2,201);
INSERT INTO room_reservation VALUES(3,5);

