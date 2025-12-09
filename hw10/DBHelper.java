
/**
 * Class to provide a connect command.
 *
 * @author  Terry Sergeant
 * @version 08 Dec 2025
 *
*/

import java.sql.*;
import java.io.*;
import java.util.Scanner;

public class DBHelper {
   /**
    * Connects to the database.
    *
    * @param infile Name of the configuration file.
    *
    * <pre>
    * The input file is a simple text file that contains exactly four lines:
    *   1. JDBC URL of account/server to which to connect
    *   2. Name of PostgreSQL database to which to connect
    *   3. Password for the account/database
    * For example:
    * jdbc:postgresql://localhost:5432/mydb
    * student
    * devpass
    * </pre>
    */
   public static Connection connect(String infile) {
      Connection con = null;
      try {
         BufferedReader dbCredFile = new BufferedReader(new FileReader(infile));
         con = DriverManager.getConnection(dbCredFile.readLine(), dbCredFile.readLine(), dbCredFile.readLine());
         dbCredFile.close();
      } catch (IOException e) {
         System.err.print("Unable to load database information file: '" + infile + "'\n");
         System.exit(1);
      } catch (SQLException e) {
         System.err.print("Unable to connect to the database\n");
         System.err.println(e);
         System.exit(3);
      }
      return con;
   }
}
