# MongoDB Setup Steps

## Overview

In theory everything provided in the db_homework repo should work out-of-the-box.
Here are some things to check before we walk through the rest.
1. From your terminal move to the root directory of your workspace/repo and execute:
```
docker compose ps
```
2. This should show three containers running, one of which is mongocontainer.
3. If mongocontainer is not running then start it with:
```
docker compose up --build
```
4. Then re-check to verify mongocontainer is running

---

## Try Out the Scripts
- We will be working in the examples/mongo directory
- Read the file: 1_SCRIPT_EXPLANATION.md

### Test Out mongoshell
- Execute the mongoshell script with no parameters
- This should connect you to the container and give you a prompt showing you are in the test database.

### Test Out mongorun
- Execute the mongorun script with these parameters: albums albumdb.js
- Once you are connnected to the container type: view_albums()
- Then run the other two functions: view_albums2() and view_albums3()
- You should be seing meaningful output.

### Load Some Data
- Move your attention to the examples/mongo/json directory.
- Read the README.md file to see how the mongoload script works.
- Use these commands to load some data (use .sh in MacOS):
```
./mongoload.ps1 starwars people sw_people.json
./mongoload.ps1 starwars films sw_films.json
```
- Feel free to load the other star wars data if you want (but not needed)
- Make sure it is all working by using:
```
cd ..
./mongoshell.ps1 starwars
```
- Then try: db.films.find()
- You should see a list of films


### Play With Some Commands
- Using mongoshell to connect to the albums database created earlier.
- Take time to play around with various database commands, including, but not limited to:
	show dbs
	use dbname
	show collections
	db.colname.find()
	db.colname.find().pretty
	db.colname.insertOne()
	db.colname.insertMany()
	db.colname.deleteOne()
	db.colname.deleteMany()
	db.colname.updateOne()
	db.colname.updateMany()

### Create Your Own Script
- Create a mongo script called myFirst.js and in it put commands that will:
  1. delete all entries in a collection called inventory
  2. add (to the inventory collection) the values found here:
     examples/mongo/json/inventory.json
  3. print (using .pretty()) the contents of the inventory collection found in
     the database called first.

- Run myFirst.js using: ./mongorun.ps1 first myFirst.js
- Verify that this script is running without error using that command.
