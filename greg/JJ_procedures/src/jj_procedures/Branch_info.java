/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/GUIForms/JFrame.java to edit this template
 */
package jj_procedures;

import java.sql.*;
import javax.swing.table.*;

/**
 *
 * @author iason
 */
public class Branch_info extends javax.swing.JFrame {
   private Connection conn;
   private DefaultTableModel tmodel1;
   private DefaultTableModel tmodel2;
    
    public Branch_info() {
        initComponents();
        connect();
    }
    
    private void connect()
    {
        try{
            //connect to the database 
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/travel_agency?useSSL = false", "root", "giagia12");
        }catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    private int branch_info()
    {
        try{
            //create statement object
            CallableStatement stmt = conn.prepareCall("{call branch_info()}");

            //execute procedure
            stmt.execute();

            //process the results
            ResultSet rs = stmt.getResultSet();
            if(rs == null)
            {
                return -1;
            }
            ResultSetMetaData metaData = rs.getMetaData();
            int columnCount = metaData.getColumnCount();
            
            //prosthetw tis sthles tou sql pianaka sto TableModel mono gia tin prwti klisi tou procedure
            if(tmodel1.getColumnCount() == 0)
            {
                tmodel1.addColumn("Branch code");
                tmodel1.addColumn("Street");
                tmodel1.addColumn("Number");
                tmodel1.addColumn("City");
                tmodel1.addColumn("Admin name");
                tmodel1.addColumn("Admin last name");
                tmodel1.addColumn("Total of reservations");
                tmodel1.addColumn("Income");       
            }
            
            //prosthetw tis grammes tou pinaka
            Object[] row;
            while (rs.next()) 
            {
                row = new Object[columnCount];
                for (int i = 1; i <= columnCount; i++) 
                {
                    row[i - 1] = rs.getObject(i);
                }
                tmodel1.addRow(row);
            }
            //process the next result set(s) epeidi to stored procedure dinei pollous pinakes
            while (stmt.getMoreResults()) 
            {
                rs = stmt.getResultSet();
                while (rs.next()) 
                {
                    row = new Object[columnCount];
                    for (int i = 1; i <= columnCount; i++) 
                    {
                        row[i - 1] = rs.getObject(i);
                    }
                    tmodel1.addRow(row);
                }
            }
            
            //close the resources
            rs.close();
            stmt.close();
            
            return 0; //an den yparxei exception return 0 
        }
        catch (SQLException e) 
        {
            e.printStackTrace();
            return 1; //an yparxei exception return 1
        }
    }
    
    private int branch_employees()
    {
       try{
            Statement stmt = conn.createStatement();
            
            ResultSet rs = stmt.executeQuery("SELECT br_code,wrk_name,wrk_lname,wrk_salary,(SELECT SUM(wrk_salary) from worker WHERE wrk_br_code=br_code) AS 'Total salaries' FROM worker INNER JOIN branch ON br_code=wrk_br_code;");
       
            if(rs == null)
            {
                return -1;
            }
            ResultSetMetaData metaData = rs.getMetaData();
            int columnCount = metaData.getColumnCount();
            
            //prosthetw tis sthles tou sql pianaka sto TableModel mono gia tin prwti klisi tou procedure
            if(tmodel2.getColumnCount() == 0)
            {
                tmodel2.addColumn("Branch code");
                tmodel2.addColumn("Worker name");
                tmodel2.addColumn("Worker last name");
                tmodel2.addColumn("Worker salary");
                tmodel2.addColumn("Total branch salaries");       
            }
            
            //prosthetw tis grammes tou pinaka
            Object[] row;
            while (rs.next()) 
            {
                row = new Object[columnCount];
                for (int i = 1; i <= columnCount; i++) 
                {
                    row[i - 1] = rs.getObject(i);
                }
                tmodel2.addRow(row);
            }
            
            //close the resources
            rs.close();
            stmt.close();
            
            return 0; //an den yparxei exception return 0 
        }
        catch (SQLException e) 
        {
            e.printStackTrace();
            return 1; //an yparxei exception return 1
        } 
    }

    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jButton1 = new javax.swing.JButton();
        jScrollPane1 = new javax.swing.JScrollPane();
        jTable1 = new javax.swing.JTable();
        jButton2 = new javax.swing.JButton();
        jButton3 = new javax.swing.JButton();
        jButton4 = new javax.swing.JButton();
        jScrollPane2 = new javax.swing.JScrollPane();
        jTable2 = new javax.swing.JTable();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);

        jButton1.setFont(new java.awt.Font("Segoe UI", 1, 18)); // NOI18N
        jButton1.setText("Get branch info");
        jButton1.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButton1ActionPerformed(evt);
            }
        });

        jTable1.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {
                {},
                {},
                {},
                {}
            },
            new String [] {

            }
        ));
        jScrollPane1.setViewportView(jTable1);

        jButton2.setFont(new java.awt.Font("Segoe UI", 1, 18)); // NOI18N
        jButton2.setText("Get branch employees");
        jButton2.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButton2ActionPerformed(evt);
            }
        });

        jButton3.setFont(new java.awt.Font("Segoe UI", 1, 18)); // NOI18N
        jButton3.setText("Clear");
        jButton3.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButton3ActionPerformed(evt);
            }
        });

        jButton4.setFont(new java.awt.Font("Segoe UI", 1, 18)); // NOI18N
        jButton4.setText("Clear");
        jButton4.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButton4ActionPerformed(evt);
            }
        });

        jTable2.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {
                {},
                {},
                {},
                {}
            },
            new String [] {

            }
        ));
        jScrollPane2.setViewportView(jTable2);

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(jButton2, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.DEFAULT_SIZE, 228, Short.MAX_VALUE)
                    .addComponent(jButton3, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addComponent(jButton1, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addComponent(jButton4, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(jScrollPane1, javax.swing.GroupLayout.DEFAULT_SIZE, 770, Short.MAX_VALUE)
                    .addComponent(jScrollPane2))
                .addContainerGap())
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                    .addGroup(layout.createSequentialGroup()
                        .addGap(16, 16, 16)
                        .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, 309, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addGroup(javax.swing.GroupLayout.Alignment.LEADING, layout.createSequentialGroup()
                        .addGap(81, 81, 81)
                        .addComponent(jButton1, javax.swing.GroupLayout.PREFERRED_SIZE, 71, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(39, 39, 39)
                        .addComponent(jButton3, javax.swing.GroupLayout.PREFERRED_SIZE, 71, javax.swing.GroupLayout.PREFERRED_SIZE)))
                .addGap(63, 63, 63)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(layout.createSequentialGroup()
                        .addGap(81, 81, 81)
                        .addComponent(jButton2, javax.swing.GroupLayout.PREFERRED_SIZE, 71, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(39, 39, 39)
                        .addComponent(jButton4, javax.swing.GroupLayout.PREFERRED_SIZE, 71, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addComponent(jScrollPane2, javax.swing.GroupLayout.PREFERRED_SIZE, 309, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addContainerGap(50, Short.MAX_VALUE))
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void jButton1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jButton1ActionPerformed
        // TODO add your handling code here:
        tmodel1 = new DefaultTableModel();
        
        
        if(branch_info()==0)
        {
        jTable1.setModel(tmodel1);
        }
    }//GEN-LAST:event_jButton1ActionPerformed

    private void jButton2ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jButton2ActionPerformed
        // TODO add your handling code here:
        tmodel2 = new DefaultTableModel();
        
        if(branch_employees()==0)
        {
        jTable2.setModel(tmodel2);
        }
    }//GEN-LAST:event_jButton2ActionPerformed

    private void jButton3ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jButton3ActionPerformed
        // TODO add your handling code here:
        DefaultTableModel model = new DefaultTableModel();
        jTable1.setModel(model);
    }//GEN-LAST:event_jButton3ActionPerformed

    private void jButton4ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jButton4ActionPerformed
        // TODO add your handling code here:
        DefaultTableModel model = new DefaultTableModel();
        jTable2.setModel(model);
    }//GEN-LAST:event_jButton4ActionPerformed

    /**
     * @param args the command line arguments
     */
    public static void main(String args[]) {
        /* Set the Nimbus look and feel */

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                new Branch_info().setVisible(true);
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton jButton1;
    private javax.swing.JButton jButton2;
    private javax.swing.JButton jButton3;
    private javax.swing.JButton jButton4;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JScrollPane jScrollPane2;
    private javax.swing.JTable jTable1;
    private javax.swing.JTable jTable2;
    // End of variables declaration//GEN-END:variables
}
