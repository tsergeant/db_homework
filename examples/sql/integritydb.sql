/* Play with integrity contstraints, etc. */
set search_path to integrity,public;

drop table album;
drop table artist;
drop table genre;


create table artist (
        id              serial,
        name            varchar(30), 
        hometown        varchar(30),
        primary key (id)
);

create table genre (
        id              serial,
        name            varchar(30), 
        primary key (id)
);

create table album (
        artist_id       int not null default 0,  /* default to 'Unknown'*/
        title           varchar(50) not null, 
        year            char(4) default date_part('year',current_date),
        genre_id        int,
        primary key (artist_id,title),
        /*foreign key (artist_id) references artist(id),*/
        /*foreign key (artist_id) references artist(id) on delete set * default,*/
        foreign key (artist_id) references artist(id) 
          on delete cascade on update cascade,
        foreign key (genre_id) references genre(id)
);

/*insert into artist values(0,'Unknown Artist','Unknown Hometown');*/
insert into artist values(default,'Dog Man','Coyote, Wyoming');
insert into artist values(default,'The Computing Whiners','Seattle, Washington');
insert into artist values(default,'Soul Screech','Boston, Alabama');

insert into genre values(default,'Rock');
insert into genre values(default,'Pop');
insert into genre values(default,'Jazz');

insert into album values(1,'Howling Knights','2003',3);
insert into album values(1,'Woof, Woof to You Too!','2004',2);
insert into album values(1,'Puppy Love','2005',3);
insert into album values(2,'Are You My Motherboard?','2003',1);
insert into album values(2,'CPU Burnin\'','2005',1);
insert into album values(3,'Stop the Pounding in My Brain',default,1);
/* NOTE: use of default value for year */

select artist.name as "Artist Name", artist.hometown as "Artist Hometown",
album.title as "Title", album.year as "Year", genre.name as "Genre"
from album,artist,genre
where album.artist_id=artist.id and album.genre_id=genre.id
order by artist.name, album.year desc;

select album.title, album.year, artist.name, artist.hometown, genre.name
from album,artist,genre
where album.artist_id=artist.id and album.genre_id=genre.id and album.year='2003'
order by artist.name, album.year desc;


/*
In default handling of violations of referential integrity these

delete table artist where id=1;
update album set artist_id=4 where title='Puppy Love'

produce:

ERROR:  insert or update on table "album" violates foreign key constraint
"album_artist_id_fkey"
DETAIL:  Key (artist_id)=(4) is not present in table "artist".
*/

/* 
If we specify 
  foreign key (artist_id) references artist(id) on delete set null
in the create statement then we get

ERROR:  null value in column "artist_id" violates not-null constraint
CONTEXT:  SQL statement "UPDATE ONLY "integrity"."album" SET "artist_id" =
NULL WHERE "artist_id" = $1"

b/c we said that artist id cannot be null ... of course we can relax the
restraint if we want to ... I say that but when I tried it the field
was still listed as not null!  That is because it claims to be a foreign
key of a field that is not allowed to be null ... therefore, it cannot be
null!
*/

/* 
If we specify 

  foreign key (artist_id) references artist(id) on delete set default

and modify the table so that

        artist_id       int not null default 0, 
AND

we create an entry in the artist table whose id is (0,'Unknown','Unknown')

THEN

delete table artist where id=1;

will remove 'Dog Man' from the artist list and will change 3 entries in
the album table so that they are listed as the new 'Unknown' author
*/


/* If we specify

   foreign key (artist_id) references artist(id) 
          on delete cascade on update cascade,

THEN
  update artist set id=5 where id=1

will
  * modify 'Dog Man' in artist table to have an id of 5
  * modify artist_id in 3 rows in album table to match the new id

Of course,

  delete from artist where id=1

  * will delete four rows (1 from artist and 3 from album)
*/

/*
NOTE: 

  delete from album where id=3

will not cause any problems or any deletion from artist ...
*/
