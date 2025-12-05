
/*
** Demonstrates a PreparedStatement and handling SQL injection.
*/
import java.sql.*;
import java.util.Scanner;
import java.io.*;

public class DBDemo6 {
	public static void main(String args[])
			throws ClassNotFoundException, SQLException {
		Scanner kb = new Scanner(System.in);
		String artistName;
		PreparedStatement pstmt;
		Statement stmt;
		ResultSet result;
		Connection con = connect("example.env");

		stmt = con.createStatement();
		stmt.executeUpdate("set search_path to albumdb");

		System.out.print("Enter name of artist: ");
		artistName = kb.nextLine();
		stmt.executeUpdate("INSERT INTO artist (id,name,hometown) VALUES(default,'" + artistName + "','Abilene, TX')");
		// pstmt= con.prepareStatement("INSERT INTO artist (id,name,hometown)
		// VALUES(default,?,'Abilene, TX')");
		// pstmt= con.prepareStatement("INSERT INTO artist (id,name,hometown)
		// VALUES(default,'"+artistName+"','Abilene, TX')");
		// pstmt.setString(1,artistName);
		// pstmt.executeUpdate();

		result = stmt.executeQuery("select * from artist");
		while (result.next()) {
			System.out.println(result.getString("id")); // field name notation
			System.out.println(result.getString("name"));
			System.out.println(result.getString(3)); // positional notation
			System.out.println();
		}
		con.close(); // close connection to username
	}

	public static Connection connect(String infile) {
		Connection con = null;
		String str;

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
