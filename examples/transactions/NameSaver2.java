
/**
 * Get next id number and insert at that position.
 *
 * @author T.Sergeant
 * @version for DB
 *
 * NOTE: We use the PostgreSQL LOCK command which will cause the specified table
 * to be locked using the specified mode until the transaction in which the lock
 * command was specified ends at which time the table is automatically unlocked.
 *
 * Accepted Lock Modes:
 *		See: https://www.postgresql.org/docs/9.4/explicit-locking.html
 *		ACCESS SHARE
 *		ROW SHARE
 *		ROW EXCLUSIVE
 *		SHARE UPDATE EXCLUSIVE
 *		SHARE
 *		SHARE ROW EXCLUSIVE
 *		EXCLUSIVE
 *		ACCESS EXCLUSIVE
 *			- most restrictive lock which conflicts with all other locks
 */
import java.sql.*;

class NameSaver2 implements Runnable {

	public void run() {
		Thread me = Thread.currentThread();
		int my_id;
		PreparedStatement pstmt;
		ResultSet result;
		Connection con;
		Statement stmt;

		try {
			// Notice, this version does not use/require sleeping to spread out
			// requests. The exclusive write lock keeps the transactions from
			// writing over one another.

			con = DBHelper.connect("example.env");
			stmt = con.createStatement();
			stmt.executeUpdate("BEGIN TRANSACTION");
			// Lock must appear in a transaction
			stmt.executeUpdate("LOCK TABLE tdemodb.names IN ACCESS EXCLUSIVE MODE");
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
			stmt.executeUpdate("COMMIT");
			// NOTE: lock is automatically released at the end of the transaction
			con.close();
		} catch (Exception e) {
			System.out.println(e);
		}
	}
}
