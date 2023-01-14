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
            String stored = "{call countJobs (?, ?)}";
            CallableStatement callCountJobs = con.prepareCall(stored);
            String rec_username = "n_tri";
            callCountJobs.setString(1, rec_username);
            callCountJobs.registerOutParameter(2, java.sql.Types.INTEGER);
            callCountJobs.execute();
            int count = callCountJobs.getInt(2);
            System.out.println("Recruiter with username " + rec_username + " is responsible for " + count + " jobs.");
        } catch (SQLException ex) {
           ex.printStackTrace();
        }finally{
        if (con != null)
        try { con.close();}
        catch (SQLException ex) {}
        }
    }
}