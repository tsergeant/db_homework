To use these scripts on csci.hsutx.edu do the following steps:

0) Log into your account on csci.hsutx.edu

1) Change into your working directory (create if needed):
	cd
	mkdir mongo
	cd mongo

2) Download the scripts into that directory:
	wget https://josephus.sergeantservices.com/classes/db/source/mongo/scripts/mongoexec
	wget https://josephus.sergeantservices.com/classes/db/source/mongo/scripts/mongoload
	wget https://josephus.sergeantservices.com/classes/db/source/mongo/scripts/mongoshell

3) Mark the scripts as executable (and not readable by others):
   chmod 700 mongoexec
   chmod 700 mongoload
   chmod 700 mongoshell

4) Use a text editor (vim or nano) to put your username, password, uri, and host value in
   the placeholders at the top of each file.

5) Make sure you have whitelisted the csci.hstux.edu IP (209.165.224.128/32) in
   your account at https://cloud.mongodb.com/ (under the Network Access Menu).

6) To run the scripts put ./ in front of the script name. Test each script as follows:

	(a)
	./mongoshell
	This should connect to your MongoDB server in the cloud and give you a shell prompt.
	Type "exit" to disconnect and return to the command-line.
	NOTE: For a number of homework assignments you'll find it useful to open two connections
	to csci.hsutx.edu. In the first you'll run this script. In the other you'll issue
	other commands.

	(b)
	To test mongoexec download make-album.mongo
		wget https://josephus.sergeantservices.com/classes/db/source/mongo/make-album.mongo

	Then run the script and specify the name of the new file:
		./mongoexec make-album.mongo

	(c)
	To test mongoload download movies.json:
		wget https://josephus.sergeantservices.com/classes/db/source/mongo/json/movies.json

	Then run the script to create a movies collection in the demo database:
		./mongoload demo movies movies.json


The difference between mongoexec and mongoload:
	mongoexec takes a document containing a series of mongo shell commands, connects
		to the test database and then runs those commands.

	mongoload takes a database name, a collection name, and a JSON file containing a
		single JSON array of documents. It imports all of the documents in the file
		into the specified database and collection.
