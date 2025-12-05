
/**
 * Get next id number and insert at that position.
 *
 * @author T.Sergeant
 * @version for DB
 *
 * NOTE: In default state we have threads sleep randomly 0 to 10 seconds to
 * spread them out in time. It is quite possible that there will be no
 * conflicts. This simulates 10 requests in 10 seconds.
 *
 * If we shorten range 0 to 1 second we will likely see some conflicts. This
 * simulated 10 requests in 1 second.
 *
 * If we remove the sleep statement it will simulate 10 requests at about the
 * same time ... lots of conflicts!
 *
 */
import java.sql.*;

class NameSaver1 implements Runnable {

	public void run() {
		Thread me = Thread.currentThread();
		int my_id;
		PreparedStatement pstmt;
		ResultSet result;
		Connection con;
		Statement stmt;

		try {
			// This command will cause threads to sleep for random times (0 to 10
			// seconds) with the goal of spreading them out a bit.
			// Thread.sleep((int) (Math.random()*10000.0));

			con = DBHelper.connect("example.env");
			stmt = con.createStatement();
			result = stmt.executeQuery("SELECT MAX(name_id) FROM tdemodb.names");
			if (result.next()) {
				my_id = result.getInt(1) + 1;
			} else {
				my_id = 1;
			}

			System.out.println("I am " + me.getName() + " and I am inserting my name using id: " + my_id);
			pstmt = con.prepareStatement("INSERT INTO tdemodb.names (name_id, name) VALUES (?, ?)");
			pstmt.setInt(1, my_id);
			pstmt.setString(2, me.getName());
			pstmt.executeUpdate();
			con.close();
		} catch (Exception e) {
			System.out.println(e);
		}
	}
}
