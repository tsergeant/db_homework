drop table equipment;
drop table aircraft;
drop table can_fly;
drop table plane;
drop table pilot;
drop table assigned_to;
drop table booked_on;
drop table departure;
drop table flight;
drop table employee;
drop table person;

			   /* person entity set */

create table person (
	name		varchar(15) not null,
	address		varchar(15) not null,
	phone		varchar(12),	/* optional */
	primary key (name)
);


			  /* employee entity set */

create table employee (
	name		varchar(15) not null,
	salary		number(10,2),
	emp_no		smallint unique not null,
	primary key (name),
	foreign key (name) references person(name)
);

			    /* pilot entity set */

create table pilot (
	emp_no		smallint unique,
	foreign key (emp_no) references employee(emp_no)
);

			    /* plane entity set */

create table plane (
	maker		varchar(15) not null,
	model_no	varchar(15) not null,
	primary key (model_no)
);

			  /* aircraft entity set */

create table aircraft (			/* subsumes type */
	serial_no	smallint not null,
	model_no	varchar(15) not null,
	primary key (serial_no, model_no),
	foreign key (model_no) references plane(model_no)
);

			   /* flight entity set */

create table flight (
	num		smallint not null,
	origin		varchar(3),
	dest		varchar(3),
	dep_time	varchar(5),
	arr_time	varchar(5),
	primary key (num)
);

			  /* departure entity set */

create table departure (		/* subsumes instance_of */
	dep_date	varchar(6) not null,
	num		smallint not null,
	primary key (dep_date, num),
	foreign key (num) references flight(num)
);

		      /* booked_on relationship sets */

create table booked_on (
	name		varchar(15) not null,
	dep_date	varchar(6) not null,
	num		smallint not null,
	primary key (name, dep_date, num),
	foreign key (dep_date, num) references departure(dep_date, num)
);

		     /* assigned_to relationship sets */

create table assigned_to (
	emp_no		smallint not null,
	dep_date	varchar(6) not null,
	num		smallint not null,
	primary key (emp_no, dep_date, num),
	foreign key (emp_no) references employee(emp_no),
	foreign key (dep_date, num) references departure(dep_date, num)
);

		       /* can_fly relationship sets */

create table can_fly (
	emp_no		smallint not null,
	model_no	varchar(15) not null,
	primary key (emp_no, model_no),
	foreign key (emp_no) references employee(emp_no),
	foreign key (model_no) references plane(model_no)
);

		       /* equipment relationship set */

create table equipment (
	dep_date	varchar(6) not null,
	num		smallint not null,
	serial_no	smallint not null,
	model_no	varchar(15) not null,
	primary key (dep_date, num, serial_no, model_no),
	foreign key (dep_date, num) references departure(dep_date, num),
	foreign key (serial_no, model_no) references 
		aircraft(serial_no, model_no)
);

			      /* Populate DB */

insert into person
values ('Smith',	'123 Elm St.',		'801-556-2239');
insert into person
values ('Jones',	'234 Oak St.',		'801-552-2943');
insert into person
values ('Peters',	'345 Pine St.',		'801-393-2230');
insert into person
values ('Green',	'435 Alder St.',	'801-933-2320');
insert into person
values ('Rowe',		'348 Elder St.',	'801-343-2320');
insert into person
values ('Phillips',	'395 Pine St.',		'801-323-2320');
insert into person
values ('Gates',	'285 Kapok St.',	'801-493-2203');
insert into person
values ('Clark',	'223 Easy St.',		'801-193-2320');
insert into person
values ('Warnock',	'775 Main St.',		'801-303-2222');
insert into person
values ('Hooper',	'456 Maple St.',	'313-912-2101');
insert into person
values ('Edwards',	'567 Spruce St.',	'801-228-6729');
insert into person
values ('Majeris',	'678 Willow St.',	null);
insert into person
values ('MacBride',	'789 Fir St.',		null);

insert into employee
values ('Jones',	50000.00,	1001);
insert into employee
values ('Peters',	45000.00,	1002);
insert into employee
values ('Rowe',		35000.00,	1003);
insert into employee
values ('Phillips',	25000.00,	1004);
insert into employee
values ('Gates',	5000000.00,	1005);
insert into employee
values ('Clark',	150000.00,	1006);
insert into employee
values ('Warnock',	500000.00,	1007);

insert into pilot	values (1001);
insert into pilot	values (1002);
insert into pilot	values (1003);

insert into plane	values ('Boeing',	'B727');
insert into plane	values ('Boeing',	'B747');
insert into plane	values ('Boeing',	'B757');
insert into plane	values ('MD',		'DC9');
insert into plane	values ('MD',		'DC10');
insert into plane	values ('Airbus',	'A310');
insert into plane	values ('Airbus',	'A320');
insert into plane	values ('Airbus',	'A330');
insert into plane	values ('Airbus',	'A340');

insert into aircraft	values (11,		'B727');
insert into aircraft	values (13,		'B727');
insert into aircraft	values (10,		'B747');
insert into aircraft	values (13,		'B747');
insert into aircraft	values (22,		'B757');
insert into aircraft	values (93,		'B757');
insert into aircraft	values (21,		'DC9');
insert into aircraft	values (22,		'DC9');
insert into aircraft	values (23,		'DC9');
insert into aircraft	values (24,		'DC9');
insert into aircraft	values (21,		'DC10');
insert into aircraft	values (70,		'A310');
insert into aircraft	values (80,		'A320');

insert into flight
values (100,	'SLC',	'BOS',	'08:00',	'17:50');
insert into flight
values (206,	'DFW',	'STL',	'09:00',	'11:40');
insert into flight
values (334,	'ORD',	'MIA',	'12:00',	'14:14');
insert into flight
values (335,	'MIA',	'ORD',	'15:00',	'17:14');
insert into flight
values (336,	'ORD',	'MIA',	'18:00',	'20:14');
insert into flight
values (337,	'MIA',	'ORD',	'20:30',	'23:53');
insert into flight
values (121,	'STL',	'SLC',	'07:00',	'09:13');
insert into flight
values (122,	'STL',	'YYV',	'08:30',	'10:19');
insert into flight
values (330,	'JFK',	'YYV',	'16:00',	'18:53');
insert into flight
values (991,	'BOS',	'ORD',	'17:00',	'18:22');
insert into flight
values (394,	'DFW',	'MIA',	'19:00',	'21:30');
insert into flight
values (395,	'MIA',	'DFW',	'21:00',	'23:43');
insert into flight
values (449,	'CDG',	'DEN',	'10:00',	'19:29');
insert into flight
values (930,	'YYV',	'DCA',	'13:00',	'16:10');
insert into flight
values (931,	'DCA',	'YYV',	'17:00',	'18:10');
insert into flight
values (932,	'DCA',	'YYV',	'18:00',	'19:10');
insert into flight
values (112,	'DCA',	'DEN',	'14:00',	'18:07');

insert into departure	values ('Oct 31',	100);
insert into departure	values ('Oct 31',	112);
insert into departure	values ('Oct 31',	206);
insert into departure	values ('Oct 31',	334);
insert into departure	values ('Oct 31',	335);
insert into departure	values ('Oct 31',	337);
insert into departure	values ('Oct 31',	449);
insert into departure	values ('Nov  1',	100);
insert into departure	values ('Nov  1',	112);
insert into departure	values ('Nov  1',	206);
insert into departure	values ('Nov  1',	334);
insert into departure	values ('Nov  1',	395);
insert into departure	values ('Nov  1',	991);

insert into booked_on	values ('Smith',	'Oct 31',	100);
insert into booked_on	values ('Green',	'Oct 31',	206);
insert into booked_on	values ('Hooper',	'Oct 31',	334);
insert into booked_on	values ('Edwards',	'Oct 31',	449);
insert into booked_on	values ('MacBride',	'Nov  1',	991);
insert into booked_on	values ('Gates',	'Nov  1',	991);
insert into booked_on	values ('Rowe',		'Nov  1',	100);
insert into booked_on	values ('Clark',	'Nov  1',	100);
insert into booked_on	values ('Phillips',	'Oct 31',	449);
insert into booked_on	values ('Warnock',	'Oct 31',	449);
insert into booked_on	values ('Smith',	'Nov  1',	991);
insert into booked_on	values ('Peters',	'Nov  1',	100);

insert into assigned_to	values (1001,		'Oct 31',	100);
insert into assigned_to	values (1002,		'Oct 31',	100);
insert into assigned_to	values (1003,		'Oct 31',	100);
insert into assigned_to	values (1004,		'Oct 31',	100);
insert into assigned_to	values (1007,		'Oct 31',	206);
insert into assigned_to	values (1003,		'Oct 31',	337);
insert into assigned_to	values (1004,		'Oct 31',	337);
insert into assigned_to	values (1005,		'Oct 31',	337);
insert into assigned_to	values (1006,		'Oct 31',	337);
insert into assigned_to	values (1001,		'Nov  1',	100);
insert into assigned_to	values (1002,		'Nov  1',	100);
insert into assigned_to	values (1006,		'Nov  1',	991);
insert into assigned_to	values (1007,		'Nov  1',	991);
insert into assigned_to	values (1007,		'Nov  1',	112);

insert into can_fly	values (1001,	'B727');
insert into can_fly	values (1001,	'B747');
insert into can_fly	values (1001,	'DC10');
insert into can_fly	values (1002,	'DC9');
insert into can_fly	values (1002,	'A340');
insert into can_fly	values (1002,	'B757');
insert into can_fly	values (1002,	'A320');
insert into can_fly	values (1003,	'A310');
insert into can_fly	values (1003,	'DC9');

insert into equipment	values ('Oct 31',	100,	11,	'B727');
insert into equipment	values ('Oct 31',	206,	13,	'B727');
insert into equipment	values ('Oct 31',	112,	11,	'B727');
insert into equipment	values ('Oct 31',	337,	24,	'DC9');
insert into equipment	values ('Nov  1',	991,	22,	'B757');
insert into equipment	values ('Nov  1',	112,	21,	'DC10');
