Planned Usage:
0) Be sure to install tdemodb.sql to establish the needed table.
1) Walk through v1 code. Note the sleep command in NameSaver1.java.
2) Reduce sleep to 1 second ... then remove sleep command and see how errors increase.
3) Note time elapsed in main when sleep command is removed.

4) Walk through v2 code that uses tdemodb. No sleep command (i.e., lots of
	conflicts) yet it gives the right answer.
5) Note time elapsed in main.

6) Walk through v3 code that uses next_val(). No sleep command (i.e., lots of
	conflicts) yet it gives the right answer.
7) Note time elapsed in main.

------------------------------------------------------------------------------------

This program uses example.env credentials and assumes:
	schema: tdemodb
	table: names

------------------------------------------------------------------------------------

This directory contains the following programs:

CodeTimer.java
	- Helper for timing code.

DBHelper.java
	- Helper for connecting to database.

------------------------------------------------------

Transaction1.java
	- A driver that times code
	- Connects to mydb and deletes all entries from tdemodb.names table
	- Then creates multiple NameSaver threads and runs them

NameSaver1.java
	- Connects to mydb database
	- Looks up max id number
	- Add 1 to number and stores thread name to tdemodb.names table using
	  the specified id number

------------------------------------------------------

Transaction2.java
	- A driver that times code
	- Connects to mydb and deletes all entries from tdemodb.names table
	- Then creates multiple NameSaver2 threads and runs them

NameSaver2.java
	- Connects to mydb database
	- Starts transaction
	- Looks up max id number
	- Add 1 to number and stores thread name to tdemodb.names table using
	  the specified id number
	- Commits transaction

------------------------------------------------------

Transaction3.java
	- A driver that times code
	- Connects to mydb and deletes all entries from tdemodb.names table
	- Then creates multiple NameSaver3 threads and runs them

NameSaver3.java
	- Connects to mydb database
	- Calls next_val to get id number
	- Stores thread name to tdemodb.names table using the specified id
	  number


