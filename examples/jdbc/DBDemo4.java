
/*
** Demonstrates using ResultSetMetaData to extract information about a
** table.
*/
import java.sql.*;
import java.io.*;
import java.util.*;

public class DBDemo4 {
  public static void main(String args[]) throws SQLException {
    Connection con;
    Statement stmt;
    ResultSet result;
    ResultSetMetaData info;
    int i, n;

    con = connect("example.env"); // read connection params & connect
    stmt = con.createStatement();
    stmt.executeUpdate("set search_path to albumdb,public");

    result = stmt.executeQuery("select * from artist");
    info = result.getMetaData();
    n = info.getColumnCount();

    result.next();
    for (i = 1; i <= n; i++)
      System.out.printf("%-25s", info.getColumnName(i));
    System.out.print("\n");
    for (i = 1; i <= n; i++)
      System.out.printf("%-25s", info.getColumnTypeName(i));
    System.out.print("\n");

    do {
      for (i = 1; i <= n; i++)
        System.out.printf("%-25s", result.getString(i));
      System.out.print("\n");
    } while (result.next());
    con.close(); // close connection to database
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
