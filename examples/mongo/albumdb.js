// to load use: ./mongorun.ps1 albums albumdb.js
db.artist.drop();
db.album.drop();

db.artist.insertOne({ name: "Dog Man", hometown: "Coyote, Wyoming" });
db.artist.insertOne({ name: "The Computering Whiners", hometown: "Seattle, Washington" });
db.artist.insertOne({ name: "Soul Screech", hometown: "Boston, Alabama" });
var artists = db.artist.find().toArray();
print("-------------------------------");
print(artists[0]);
print("-------------------------------");

db.album.insertOne({ artist_id: artists[0]._id, title: "Howling Knights", year: 2003, genre: ["Jazz", "Soul"] });
db.album.insertOne({ artist_id: artists[0]._id, title: "Woof, Woof to You Too!", year: 2004, genre: ["Pop"] });
db.album.insertOne({ artist_id: artists[0]._id, title: "Puppy Love", year: 2005, genre: ["Jazz"] });
db.album.insertOne({ artist_id: artists[1]._id, title: "Are You My Motherboard?", year: 2003, genre: ["Rock", "Pop"] });
db.album.insertOne({ artist_id: artists[1]._id, title: "CPU Burnin'", year: 2005, genre: ["Rock"] });
db.album.insertOne({ artist_id: artists[2]._id, title: "Stop the Pounding in My Brain", year: 2003, genre: ["Rock", "Heavy Metal"] });

// joining tables must be done programmatically ...
function view_albums() {
	print("Welcome to view albums");
	const albums = db.album.find().sort({ title: 1 }).toArray();

	for (let i = 0; i < albums.length; i++) {
		const artist = db.artist.findOne({ _id: albums[i].artist_id });
		print(albums[i].title + " " + albums[i].year + " by " + artist.name + " (" + albums[i].genre + ")");
	}
}


// or like this
function view_albums2() {
	print("Welcome to view albums 2");
	db.album.find().sort({ title: 1 }).forEach(album => {
		const artist = db.artist.findOne({ _id: album.artist_id });
		print(album.title + " " + album.year + " by " + artist.name + " (" + album.genre + ")");
	});
}

// or use aggregate pipeline
function view_albums3() {
	const result = db.album.aggregate([
		{
			$lookup: {
				from: "artist",              // collection to join
				localField: "artist_id",     // field in album
				foreignField: "_id",         // field in artist
				as: "artist"                 // output array
			}
		},
		{
			$unwind: "$artist"             // turn [artist] into artist object
		},
		{
			$sort: { title: 1 }            // optional, matches your example
		},
		{
			$project: {
				_id: 0,
				title: 1,
				year: 1,
				genre: 1,
				artist: "$artist.name",
				hometown: "$artist.hometown"
			}
		}
	]);
	print(result);
}
