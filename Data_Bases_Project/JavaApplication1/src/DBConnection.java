import java.sql.*;
public class DBConnection {
    private static final String DB_URL = "jdbc:mariadb://localhost:3306/erecruit";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "0r35t1s21802Makr1s!";
    private static Connection con;
    public static void main(String[] args) {
        try {
            con = DriverManager.getConnection(DB_URL, USERNAME, PASSWORD);
            // countJobs(IN rec_username VARCHAR(12), OUT totalJobs INT)
          
        } catch (SQLException ex) {
        }finally{
        if (con != null)
        try { con.close();}
        catch (SQLException ex) {}
        }
    }
}