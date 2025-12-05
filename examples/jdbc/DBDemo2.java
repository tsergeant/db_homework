
/*
** Demonstrates code to get information from the user.
*/
import java.sql.*;

public class DBDemo2 {
  public static void main(String args[]) throws SQLException {

    String database = "mydb";
    String url = "jdbc:postgresql://localhost:5432/" + database;
    String username = "student";
    String password = "devpass";

    Connection con;
    Statement stmt;
    ResultSet result;

    con = DriverManager.getConnection(url, username, password);
    System.out.print("Connection to database'" + database + "' established.\n");

    stmt = con.createStatement();
    stmt.executeUpdate("set search_path to albumdb");

    result = stmt.executeQuery("select * from artist");
    while (result.next()) {
      System.out.println(result.getString("id")); // field name notation
      System.out.println(result.getString("name"));
      System.out.println(result.getString(3)); // positional notation
      System.out.println();
    }
    con.close(); // close connection to username
  }
}
