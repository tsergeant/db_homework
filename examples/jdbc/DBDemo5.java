
/*
** Demonstrates how to reset the internal statement pointer
*/
import java.sql.*;
import java.io.*;
import java.util.*;

public class DBDemo5 {
  public static void main(String args[]) throws SQLException {
    Connection con;
    Statement stmt;
    ResultSet result;

    con = connect("example.env"); // read connection params & connect
    stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
    stmt.executeUpdate("set search_path to albumdb");

    result = stmt.executeQuery("select * from artist");
    while (result.next()) {
      System.out.println(result.getString("id")); // field name notation
      System.out.println(result.getString("name"));
      System.out.println(result.getString(3)); // positional notation
    }

    result.absolute(0);
    while (result.next()) {
      System.out.println(result.getString("id")); // field name notation
      System.out.println(result.getString("name"));
      System.out.println(result.getString(3)); // positional notation
    }

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
