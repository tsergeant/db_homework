
/*
** Demonstrates code to load driver and to establish a connection.
*/
import java.sql.*;

public class DBDemo1 {
  public static void main(String args[]) throws SQLException {
    String database = "mydb";
    String url = "jdbc:postgresql://localhost:5432/" + database;
    String username = "student";
    String password = "devpass";

    Connection con = DriverManager.getConnection(url, username, password);
    System.out.print("Connection to database '" + database + "' established.\n");
    con.close(); // close connection to database
    System.out.print("Connection to database '" + database + "' closed.\n");
  }
}
