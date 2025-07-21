package dal;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DBContext {

    public Connection connection;

    public DBContext() {
        String url = "jdbc:sqlserver://localhost:1433;databaseName=EmployeeManagement;encrypt=true;trustServerCertificate=true";
        String username = "sa";
        String password = "123";

        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            connection = DriverManager.getConnection(url, username, password);
            System.out.println("Connected to database successfully.");
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, "JDBC Driver not found", ex);
        } catch (SQLException ex) {
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, "Connection failed", ex);
        }
    }

    public static void main(String[] args) {
        new DBContext(); // Test connection
    }
}
