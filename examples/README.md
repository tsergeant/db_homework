# Examples

This directory provides a variety of examples and other code that will be used throughout the semester.
---

## jdbc
Examples of how to connect a Java program to a database:
- DBDemo1.java
- ...
- DBDemo6.java

A sample credential file used by the programs above
- example.env

The JDBC driver file
- postgresql-42.7.8.jar

A script (.ps1 for windows and .sh for Linux/Mac) for running java programs from the command-line
- runjava.ps1
- runjava.sh

---

## mongo
Instructions for getting setup to use MongoDB and an example
- 0_MONGO_SETUP.md
- albumdb.js

Scripts for interacting with MongoDB and an explanation of them
- 1_SCRIPT_EXPLANATION.md
- mongoshell.ps1
- mongoshell.sh
- runmongo.ps1
- runmongo.sh

A directory of various databases we will can use for examples and scripts for loading them
- json

---

## plpgsql
Examples of stored procedures and triggers
- stored1.sql
- ...
- stored6.sql
- trigger.sql

---

## sql
SQL commands to establish various databases in separate schemas
- airlinedb.sql
- ...
- integritydb.sql

Scripts for running these files from the CLI
- runsql.ps1
- runsql.sh

---

## transactions
Example code for utilizing transactions in a concurrent environment
- README.md (yes, read it)

The drivers are named
- Transaction1.java (doesn't protect critical section)
- Transaction2.java (works)
- Transaction3.java (works better)

The concurrent code corresponding to each driver
- NameSaver1.java
- NameSaver2.java
- NameSaver3.java

Support files
- example.env
- tdemodb.sql

