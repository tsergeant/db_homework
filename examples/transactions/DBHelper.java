
/**
 * Class for providing a static helper connect function.
 *
 * @author	Terry Sergeant
 * @version for DB
*/

import java.sql.*;
import java.io.*;

public class DBHelper {
	/**
	 * Read specified datafile and attempt to connect to the database.
	 *
	 * <pre>
	 * The input file is a simple text file that contains exactly three lines:
	 *	 1. JDBC URL of account/server to which to connect
	 *	 2. Name of PostgreSQL database to which to connect
	 *	 3. Password for the account/database
	 * For example:
	 * jdbc:postgresql://localhost:5432/mydb
	 * student
	 * devpass
	 * </pre>
	 *
	 * @param infile Name of the configuration file.
	 * @return Connection object
	 */
	public static Connection connect(String infile) {
		Connection con = null;

		try {
			BufferedReader envFile = new BufferedReader(new FileReader(infile));
			con = DriverManager.getConnection(envFile.readLine(), envFile.readLine(), envFile.readLine());
			envFile.close();
		} catch (IOException e) {
			System.err.print("Unable to load database information file: '" + infile + "'\n");
		} catch (SQLException e) {
			System.err.print("Unable to connect to the database\n");
		}

		return con;
	}
}
