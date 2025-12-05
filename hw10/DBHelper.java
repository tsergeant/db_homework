/**
 * Class for providing a static helper connect function.
 *
 * @author	Terry Sergeant
 * @version for DB
*/

import java.sql.*;
import java.io.*;
import java.util.Scanner;

public class DBHelper
{
	/**
	 * Read specified datafile and attempt to connect to the database.
	 *
	 * <pre>
	 * The input file is a simple text file that contains exactly four lines:
	 *	 1. name of PostgreSQL JDBC driver
	 *	 2. JDBC URL of account/server to which to connect
	 *	 3. Name of PostgreSQL database to which to connect
	 *	 4. Password for the account/database
	 * For example:
	 * org.postgresql.Driver
	 * jdbc:postgresql://josephus.hsutx.edu/sergeant
	 * sergeant
	 * notmypassword
	 * </pre>
	 *
	 * @param infile Name of the configuration file.
	 * @return Connection object
	*/
	public static Connection connect(String infile)
	{
		try {
			Scanner s= new Scanner(new BufferedReader(new FileReader(infile)));
			s.useDelimiter("\n");
			Class.forName(s.next());
			return DriverManager.getConnection(s.next(),s.next(),s.next());
		}
		catch (FileNotFoundException e) {
			System.err.print("Unable to load database information file: '"+infile+"'\n");
		}
		catch (ClassNotFoundException e) {
			System.err.print("Unable to load database driver\n");
		}
		catch (SQLException e) {
			System.err.print("Unable to connect to the database\n");
		}
		catch (Exception e) {
			System.err.print("Unexpected Error\n");
		}
		return null;
	}
}
