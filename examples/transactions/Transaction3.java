
/**
 * Demonstrates how to create multiple threads in Java.
 *
 * @author	Terry Sergeant
 * @version for DS
 *
*/

import java.sql.*;

public class Transaction3 {
	public static void main(String[] args) throws Exception {
		final int NUM_CONNECTIONS = 10;
		CodeTimer timer = new CodeTimer();
		Thread[] spool = new Thread[NUM_CONNECTIONS];
		Connection con;
		Statement stmt;
		int i;

		timer.start();
		con = DBHelper.connect("example.env");
		stmt = con.createStatement();
		stmt.executeUpdate("DELETE FROM tdemodb.names");
		con.close();

		// create the threads
		for (i = 0; i < NUM_CONNECTIONS; i++)
			spool[i] = new Thread(new NameSaver3());

		// start the threads
		for (i = 0; i < NUM_CONNECTIONS; i++)
			spool[i].start();

		// wait for the threads to finish
		for (i = 0; i < NUM_CONNECTIONS; i++)
			spool[i].join();

		timer.stop();
		System.out.println("Time elapsed: " + timer);
	}
}
