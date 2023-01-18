/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author Greg
 */
import java.sql.*;

public class StoredProcedure {
    public static void main(String[] args) {
        try {
            //sundesi stin vasi 
            Connection conn = DriverManager.getConnection("jdbc:mysql://hostname:port/travel_agency", "root@localhost", "giagia12");

            // Step 2: Create a statement object
            CallableStatement stmt = conn.prepareCall("{call search_trip(?, ?, ?)}");

            // Step 3: Set any necessary input parameters
            stmt.setInt(1, 5); //brach_code = 1
            stmt.setString(2, "2022-12-05 12:30:00"); //start_date = 2022-12-05 12:30:0
            stmt.setString(3, "2023-06-12 18:30:00"); //end_date = 2023-06-12 18:30:00
            

            // Step 4: Execute the stored procedure
            stmt.execute();

            // Step 5: Process the result set (if any)
            ResultSet rs = stmt.getResultSet();
            while (rs.next()) {
                System.out.println(rs.getString("Trip Id"));
            }

            // Step 6: Close the resources
            rs.close();
            stmt.close();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}

