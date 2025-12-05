drop schema albumdb cascade;

create schema albumdb;

set search_path to albumdb;

create table artist (
   id serial,
   name varchar(30),
   hometown varchar(30),
   primary key (id)
);

create table genre (id serial, name varchar(30), primary key (id));

create table album (
   artist_id int not null,
   title varchar(50) not null,
   year char(4),
   genre_id int,
   primary key (artist_id, title),
   foreign key (artist_id) references artist (id),
   foreign key (genre_id) references genre (id)
);

insert into artist
values (default, 'Dog Man', 'Coyote, Wyoming');

insert into artist
values (
      default,
      'The Computing Whiners',
      'Seattle, Washington'
   );

insert into artist
values (default, 'Soul Screech', 'Boston, Alabama');

insert into genre
values (default, 'Rock');

insert into genre
values (default, 'Pop');

insert into genre
values (default, 'Jazz');

insert into album
values (1, 'Howling Knights', '2003', 3);

insert into album
values (1, 'Woof, Woof to You Too!', '2004', 2);

insert into album
values (1, 'Puppy Love', '2005', 3);

insert into album
values (2, 'Are You My Motherboard?', '2003', 1);

insert into album
values (2, 'CPU Burnin''', '2005', 1);

insert into album
values (3, 'Stop the Pounding in My Brain', '2003', 1);
