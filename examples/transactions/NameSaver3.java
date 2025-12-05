
/**
 * Get next id number and insert at that position.
 *
 * @author T.Sergeant
 * @version for DB
 *
 * NOTE: We use the PostgreSQL sequences and next_val function to ensure we get
 * a unique id. This is the preferred way to solve this particular issue.
 *
 */
import java.sql.*;

class NameSaver3 implements Runnable {

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
			result = stmt.executeQuery("select nextval('tdemodb.names_name_id_seq')");
			result.next();
			my_id = result.getInt("nextval");

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
