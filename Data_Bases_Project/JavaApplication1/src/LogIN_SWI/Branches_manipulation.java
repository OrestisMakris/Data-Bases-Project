package LogIN_SWI;

import java.awt.EventQueue;
import java.sql.*;
import javax.swing.JOptionPane;
import javax.swing.table.DefaultTableModel;


public class Branches_manipulation extends javax.swing.JFrame {


    public Branches_manipulation() throws SQLException {
        initComponents();
        Connect();
        table_load();
        table_load2();
    }
    
    Connection con;
    PreparedStatement pst;

    public void Connect() throws SQLException {

      String DB_URL = "jdbc:mysql://localhost:3306/travel_agency?useSSL = false";
      String USERNAME = "root";
      String PASSWORD = "123456789987654321";
      try{
          con = DriverManager.getConnection(DB_URL, USERNAME, PASSWORD);
        }catch (SQLException e){
          System.out.println(e.getMessage());
        }
    
    }
    
    public void table_load() throws SQLException {
      Statement st = con.createStatement();
      String table_sql = "SELECT br_code , br_street , br_num , br_city ,ph_number FROM branch INNER JOIN phones ON br_code = ph_br_code ";
      ResultSet rs = st.executeQuery(table_sql);
      
      while(rs.next()){
          
          String br_code = String.valueOf(rs.getInt("br_code"));
          String br_street= rs.getString("br_street");
          String br_num = String.valueOf(rs.getInt("br_num"));
          String br_city = rs.getString("br_city");

          String tbData[] = {br_code , br_street, br_num , br_city };
          
          DefaultTableModel tblModel = (DefaultTableModel)jTable2.getModel();
          tblModel.addRow(tbData); 
      }
    }
    
    public void table_load2() throws SQLException {
      Statement st = con.createStatement();
      String table_sql = "SELECT ph_br_code, ph_number FROM phones  ";
      ResultSet rs = st.executeQuery(table_sql);
      
      while(rs.next()){
          
          String br_code = String.valueOf(rs.getInt("ph_br_code"));
          String ph_number = rs.getString("ph_number");
          
          String tbData[] = {br_code ,ph_number};
          
          DefaultTableModel tblModel = (DefaultTableModel)jTable4.getModel();
          tblModel.addRow(tbData); 
      }
    }
    
    
    
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jLabel2 = new javax.swing.JLabel();
        buttonGroup1 = new javax.swing.ButtonGroup();
        jToggleButton1 = new javax.swing.JToggleButton();
        jTable1 = new javax.swing.JTable();
        jScrollPane2 = new javax.swing.JScrollPane();
        jTable3 = new javax.swing.JTable();
        jPanel2 = new javax.swing.JPanel();
        jLabel1 = new javax.swing.JLabel();
        jPanel3 = new javax.swing.JPanel();
        jLabel4 = new javax.swing.JLabel();
        jLabel5 = new javax.swing.JLabel();
        jLabel6 = new javax.swing.JLabel();
        jLabel7 = new javax.swing.JLabel();
        NumberField = new javax.swing.JTextField();
        PhoneField = new javax.swing.JTextField();
        NameField = new javax.swing.JTextField();
        CityField = new javax.swing.JTextField();
        SaveButton = new javax.swing.JButton();
        ClearButton = new javax.swing.JButton();
        jPanel1 = new javax.swing.JPanel();
        jLabel10 = new javax.swing.JLabel();
        SearchField = new javax.swing.JTextField();
        DeleteButton = new javax.swing.JButton();
        UpdateButton2 = new javax.swing.JButton();
        jScrollPane1 = new javax.swing.JScrollPane();
        jTable2 = new javax.swing.JTable();
        jScrollPane3 = new javax.swing.JScrollPane();
        jTable4 = new javax.swing.JTable();
        ExitButton = new javax.swing.JButton();

        jLabel2.setText("jLabel2");

        jToggleButton1.setText("jToggleButton1");

        jTable1.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {
                {null, null, null, null},
                {null, null, null, null},
                {null, null, null, null},
                {null, null, null, null}
            },
            new String [] {
                "Title 1", "Title 2", "Title 3", "Title 4"
            }
        ));

        jTable3.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {
                {null, null, null, null},
                {null, null, null, null},
                {null, null, null, null},
                {null, null, null, null}
            },
            new String [] {
                "Title 1", "Title 2", "Title 3", "Title 4"
            }
        ));
        jScrollPane2.setViewportView(jTable3);

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);

        jLabel1.setFont(new java.awt.Font("Segoe UI", 0, 36)); // NOI18N
        jLabel1.setText("Branches");

        jPanel3.setBorder(javax.swing.BorderFactory.createTitledBorder(null, "Add Branch", javax.swing.border.TitledBorder.DEFAULT_JUSTIFICATION, javax.swing.border.TitledBorder.DEFAULT_POSITION, new java.awt.Font("Segoe UI", 0, 24))); // NOI18N

        jLabel4.setFont(new java.awt.Font("Segoe UI", 0, 20)); // NOI18N
        jLabel4.setText("Street Name");

        jLabel5.setFont(new java.awt.Font("Segoe UI", 0, 20)); // NOI18N
        jLabel5.setText("Street Number");

        jLabel6.setFont(new java.awt.Font("Segoe UI", 0, 20)); // NOI18N
        jLabel6.setText("City");

        jLabel7.setFont(new java.awt.Font("Segoe UI", 0, 20)); // NOI18N
        jLabel7.setText("Phone");

        NumberField.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                NumberFieldActionPerformed(evt);
            }
        });

        PhoneField.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                PhoneFieldActionPerformed(evt);
            }
        });

        CityField.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                CityFieldActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout jPanel3Layout = new javax.swing.GroupLayout(jPanel3);
        jPanel3.setLayout(jPanel3Layout);
        jPanel3Layout.setHorizontalGroup(
            jPanel3Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel3Layout.createSequentialGroup()
                .addGap(25, 25, 25)
                .addGroup(jPanel3Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                    .addComponent(jLabel5)
                    .addComponent(jLabel7, javax.swing.GroupLayout.PREFERRED_SIZE, 106, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jLabel6, javax.swing.GroupLayout.PREFERRED_SIZE, 106, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jLabel4, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addGroup(jPanel3Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                    .addComponent(CityField, javax.swing.GroupLayout.DEFAULT_SIZE, 350, Short.MAX_VALUE)
                    .addComponent(PhoneField, javax.swing.GroupLayout.Alignment.TRAILING)
                    .addComponent(NumberField)
                    .addComponent(NameField, javax.swing.GroupLayout.Alignment.TRAILING))
                .addGap(31, 31, 31))
        );
        jPanel3Layout.setVerticalGroup(
            jPanel3Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel3Layout.createSequentialGroup()
                .addGap(16, 16, 16)
                .addGroup(jPanel3Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel4)
                    .addComponent(NameField, javax.swing.GroupLayout.DEFAULT_SIZE, 34, Short.MAX_VALUE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addGroup(jPanel3Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel5)
                    .addComponent(NumberField, javax.swing.GroupLayout.DEFAULT_SIZE, 34, Short.MAX_VALUE))
                .addGap(17, 17, 17)
                .addGroup(jPanel3Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel6)
                    .addComponent(CityField, javax.swing.GroupLayout.DEFAULT_SIZE, 34, Short.MAX_VALUE))
                .addGap(18, 18, 18)
                .addGroup(jPanel3Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel7)
                    .addComponent(PhoneField, javax.swing.GroupLayout.DEFAULT_SIZE, 34, Short.MAX_VALUE))
                .addContainerGap(24, Short.MAX_VALUE))
        );

        SaveButton.setFont(new java.awt.Font("Segoe UI", 0, 27)); // NOI18N
        SaveButton.setText("Save");
        SaveButton.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                SaveButtonActionPerformed(evt);
            }
        });

        ClearButton.setFont(new java.awt.Font("Segoe UI", 0, 22)); // NOI18N
        ClearButton.setText("Clear");
        ClearButton.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                ClearButtonActionPerformed(evt);
            }
        });

        jPanel1.setBorder(javax.swing.BorderFactory.createTitledBorder(null, "Search", javax.swing.border.TitledBorder.DEFAULT_JUSTIFICATION, javax.swing.border.TitledBorder.DEFAULT_POSITION, new java.awt.Font("Segoe UI", 0, 22))); // NOI18N

        jLabel10.setFont(new java.awt.Font("Segoe UI", 0, 20)); // NOI18N
        jLabel10.setText("ID Number");

        SearchField.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                SearchFieldActionPerformed(evt);
            }
        });
        SearchField.addKeyListener(new java.awt.event.KeyAdapter() {
            public void keyReleased(java.awt.event.KeyEvent evt) {
                SearchFieldKeyReleased(evt);
            }
        });

        javax.swing.GroupLayout jPanel1Layout = new javax.swing.GroupLayout(jPanel1);
        jPanel1.setLayout(jPanel1Layout);
        jPanel1Layout.setHorizontalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addGap(32, 32, 32)
                .addComponent(jLabel10, javax.swing.GroupLayout.PREFERRED_SIZE, 109, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(26, 26, 26)
                .addComponent(SearchField, javax.swing.GroupLayout.PREFERRED_SIZE, 368, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(38, Short.MAX_VALUE))
        );
        jPanel1Layout.setVerticalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addGap(15, 15, 15)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel10)
                    .addComponent(SearchField, javax.swing.GroupLayout.PREFERRED_SIZE, 33, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addContainerGap(20, Short.MAX_VALUE))
        );

        DeleteButton.setFont(new java.awt.Font("Segoe UI", 0, 22)); // NOI18N
        DeleteButton.setText("Delete");
        DeleteButton.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                DeleteButtonActionPerformed(evt);
            }
        });

        UpdateButton2.setFont(new java.awt.Font("Segoe UI", 0, 22)); // NOI18N
        UpdateButton2.setText("Update");
        UpdateButton2.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                UpdateButton2ActionPerformed(evt);
            }
        });

        jTable2.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {

            },
            new String [] {
                "Branch Code", "Street", "Number", "City"
            }
        ) {
            boolean[] canEdit = new boolean [] {
                false, false, false, false
            };

            public boolean isCellEditable(int rowIndex, int columnIndex) {
                return canEdit [columnIndex];
            }
        });
        jTable2.setToolTipText("");
        jTable2.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                jTable2MouseClicked(evt);
            }
        });
        jScrollPane1.setViewportView(jTable2);

        jTable4.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {
                {null, null},
                {null, null},
                {null, null},
                {null, null}
            },
            new String [] {
                "Branch Code", "Phone"
            }
        ) {
            boolean[] canEdit = new boolean [] {
                false, false
            };

            public boolean isCellEditable(int rowIndex, int columnIndex) {
                return canEdit [columnIndex];
            }
        });
        jTable4.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                jTable4MouseClicked(evt);
            }
        });
        jScrollPane3.setViewportView(jTable4);

        ExitButton.setFont(new java.awt.Font("Segoe UI", 0, 20)); // NOI18N
        ExitButton.setText("Exit");
        ExitButton.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                ExitButtonActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout jPanel2Layout = new javax.swing.GroupLayout(jPanel2);
        jPanel2.setLayout(jPanel2Layout);
        jPanel2Layout.setHorizontalGroup(
            jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel2Layout.createSequentialGroup()
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(jPanel2Layout.createSequentialGroup()
                        .addGap(34, 34, 34)
                        .addComponent(jLabel1, javax.swing.GroupLayout.PREFERRED_SIZE, 562, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(5, 5, 5))
                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel2Layout.createSequentialGroup()
                        .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                            .addComponent(jPanel1, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                            .addComponent(jPanel3, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel2Layout.createSequentialGroup()
                                .addGap(11, 11, 11)
                                .addComponent(SaveButton, javax.swing.GroupLayout.PREFERRED_SIZE, 140, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                                .addComponent(UpdateButton2, javax.swing.GroupLayout.PREFERRED_SIZE, 126, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addGap(75, 75, 75)
                                .addComponent(DeleteButton, javax.swing.GroupLayout.PREFERRED_SIZE, 126, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addGap(34, 34, 34)))))
                .addGap(18, 18, 18)
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jScrollPane3, javax.swing.GroupLayout.PREFERRED_SIZE, 486, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addGroup(jPanel2Layout.createSequentialGroup()
                        .addGap(23, 23, 23)
                        .addComponent(ClearButton, javax.swing.GroupLayout.PREFERRED_SIZE, 126, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(148, 148, 148)
                        .addComponent(ExitButton, javax.swing.GroupLayout.PREFERRED_SIZE, 126, javax.swing.GroupLayout.PREFERRED_SIZE)))
                .addGap(184, 184, 184))
        );
        jPanel2Layout.setVerticalGroup(
            jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel2Layout.createSequentialGroup()
                .addComponent(jLabel1, javax.swing.GroupLayout.PREFERRED_SIZE, 49, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(jPanel2Layout.createSequentialGroup()
                        .addGap(18, 18, 18)
                        .addComponent(jPanel3, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel2Layout.createSequentialGroup()
                        .addGap(33, 33, 33)
                        .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, 247, javax.swing.GroupLayout.PREFERRED_SIZE)))
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(jPanel2Layout.createSequentialGroup()
                        .addGap(18, 18, 18)
                        .addComponent(jPanel1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel2Layout.createSequentialGroup()
                        .addGap(23, 23, 23)
                        .addComponent(jScrollPane3, javax.swing.GroupLayout.PREFERRED_SIZE, 101, javax.swing.GroupLayout.PREFERRED_SIZE)))
                .addGap(18, 18, 18)
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                        .addComponent(ClearButton, javax.swing.GroupLayout.PREFERRED_SIZE, 89, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addComponent(ExitButton, javax.swing.GroupLayout.PREFERRED_SIZE, 89, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addComponent(DeleteButton, javax.swing.GroupLayout.PREFERRED_SIZE, 90, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(UpdateButton2, javax.swing.GroupLayout.PREFERRED_SIZE, 90, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(SaveButton, javax.swing.GroupLayout.PREFERRED_SIZE, 89, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addContainerGap(21, Short.MAX_VALUE))
        );

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addComponent(jPanel2, javax.swing.GroupLayout.PREFERRED_SIZE, 1069, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(14, Short.MAX_VALUE))
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addComponent(jPanel2, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void jTable2MouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_jTable2MouseClicked

        DefaultTableModel model = (DefaultTableModel)jTable2.getModel();
        int selectedRowIndex = jTable2.getSelectedRow();
        SearchField.setText(model.getValueAt(selectedRowIndex ,0 ).toString());
        NameField.setText(model.getValueAt(selectedRowIndex ,1 ).toString());
        NumberField.setText(model.getValueAt(selectedRowIndex ,2 ).toString());
        CityField.setText(model.getValueAt(selectedRowIndex ,3 ).toString());
        PhoneField.setText(model.getValueAt(selectedRowIndex ,4 ).toString());

    }//GEN-LAST:event_jTable2MouseClicked

    private void UpdateButton2ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_UpdateButton2ActionPerformed

        String   br_street , br_num , br_city , ph_number ,sear;

          br_street= NameField.getText();
          br_num = NumberField.getText();
          br_city = CityField.getText();
          sear = SearchField.getText();
          ph_number = PhoneField.getText();

        try{

            pst= con.prepareStatement("update branch set  br_street = ? , br_num = ? , br_city = ? WHERE br_code =?");
            pst.setString(1,br_street);
            pst.setString(2,br_num);
            pst.setString(3,br_city);
            pst.setString(4,sear);
            pst.executeUpdate();
            pst= con.prepareStatement("update phone set ph_number=?  WHERE ph_br_code =?");
            pst.setString(1,ph_number);
            pst.setString(2,sear);
            pst.executeUpdate();
          
            JOptionPane.showMessageDialog(null , "Record Update!!");
            
            jTable2.setModel(new DefaultTableModel(null , new String[]{"Branch Code", "Street","City"}));
            jTable4.setModel(new DefaultTableModel(null , new String[]{"Branch Code", "Phones"}));
            table_load();
            table_load2(); 
            NameField.setText("");
            NumberField.setText("");
            CityField.setText("");
            PhoneField.setText("");
            SearchField.setText("");
            NameField.requestFocus();
        }catch(SQLException e){
            System.out.println(e.getMessage());
        }
    }//GEN-LAST:event_UpdateButton2ActionPerformed

    private void DeleteButtonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_DeleteButtonActionPerformed
        String srid;

        srid = SearchField.getText();

        try{

            pst= con.prepareStatement("delete from worker WHERE wrk_AT =?");
            pst.setString(1,srid);
            pst.executeUpdate();
            JOptionPane.showMessageDialog(null , "Record Deleted!!");
            jTable2.setModel(new DefaultTableModel(null , new String[]{"Worker AT", "Name","Last Name","Salary","Branch Code","Admin Type","Diploma"}));
            table_load();
            NameField.setText("");
            NumberField.setText("");
            CityField.setText("");
            PhoneField.setText("");
            BranchField.setText("");
            DiplomaField.setText("");
            SearchField.setText("");
            NameField.requestFocus();
        }catch(SQLException e){
            System.out.println(e.getMessage());
        }
    }//GEN-LAST:event_DeleteButtonActionPerformed

    private void SearchFieldKeyReleased(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_SearchFieldKeyReleased

        try{

            String wrk_AT = SearchField.getText();

            pst = con.prepareStatement("SELECT wrk_AT , wrk_name,wrk_lname,wrk_salary,wrk_br_code,adm_type,adm_diploma FROM worker INNER JOIN manages ON  mng_adm_AT = wrk_AT INNER JOIN admin ON adm_AT =  wrk_AT WHERE wrk_AT = ?");
            pst.setString(1 , wrk_AT);
            ResultSet rs = pst.executeQuery();

            if(rs.next() == true)
            {
                String AT = rs.getString(1);
                String name = rs.getString(2);
                String lname = rs.getString(3);
                String salary = rs.getString(4);
                String code = rs.getString(5);
                String type = rs.getString(6);
                String diploma = rs.getString(7);

                NameField.setText(name);
                NumberField.setText(lname);
                CityField.setText(AT);
                PhoneField.setText(salary);
                BranchField.setText(code);
                DiplomaField.setText(diploma);
                for (int i = 0 ; i < RoleBox.getItemCount(); i++){
                    if(RoleBox.getItemAt(i).toString().equalsIgnoreCase(type)){
                        RoleBox.setSelectedIndex(i);
                    }
                }
            }else{

                NameField.setText("");
                NumberField.setText("");
                CityField.setText("");
                PhoneField.setText("");
                BranchField.setText("");
                DiplomaField.setText("");

            }

        }catch(SQLException e){
            System.out.println(e.getMessage());
        }
    }//GEN-LAST:event_SearchFieldKeyReleased

    private void SearchFieldActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_SearchFieldActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_SearchFieldActionPerformed

    private void ClearButtonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_ClearButtonActionPerformed
        table_load();
        NameField.setText("");
        NumberField.setText("");
        CityField.setText("");
        PhoneField.setText("");
        BranchField.setText("");
        DiplomaField.setText("");
    }//GEN-LAST:event_ClearButtonActionPerformed

    private void ExitButtonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_ExitButtonActionPerformed
        System.exit(0);
    }//GEN-LAST:event_ExitButtonActionPerformed

    private void SaveButtonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_SaveButtonActionPerformed

        String name , lname , id , salary , brcode ,diploma , role ;

        name = NameField.getText();
        lname =NumberField.getText();
        id = CityField.getText();
        salary = PhoneField.getText();
        brcode = BranchField.getText();
        diploma = DiplomaField.getText();
        role = RoleBox.getSelectedItem().toString();

        try{

            pst= con.prepareStatement("insert into worker(wrk_AT,wrk_name,wrk_lname,wrk_salary,wrk_br_code)values(?,?,?,?,?)");
            pst.setString(1,id);
            pst.setString(2,name);
            pst.setString(3,lname);
            pst.setString(4,salary);
            pst.setString(5,brcode);
            pst.executeUpdate();
            pst= con.prepareStatement("insert into admin (adm_AT,adm_type,adm_diploma)values(?,?,?)");
            pst.setString(1,id);
            pst.setString(2,role);
            pst.setString(3,diploma);
            pst.executeUpdate();
            pst= con.prepareStatement("insert into manages (mng_adm_AT,mng_br_code)values(?,?)");
            pst.setString(1,id);
            pst.setString(2,brcode);
            pst.executeUpdate();
            JOptionPane.showMessageDialog(null , "Record Addedd!!");
            jTable2.setModel(new DefaultTableModel(null , new String[]{"Worker AT", "Name","Last Name","Salary","Branch Code","Admin Type","Diploma"}));
            table_load();
            NameField.setText("");
            NumberField.setText("");
            CityField.setText("");
            PhoneField.setText("");
            BranchField.setText("");
            DiplomaField.setText("");
            NameField.requestFocus();
        }catch(SQLException e){
            System.out.println(e.getMessage());
        }
    }//GEN-LAST:event_SaveButtonActionPerformed

    private void CityFieldActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_CityFieldActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_CityFieldActionPerformed

    private void PhoneFieldActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_PhoneFieldActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_PhoneFieldActionPerformed

    private void NumberFieldActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_NumberFieldActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_NumberFieldActionPerformed

    private void jTable4MouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_jTable4MouseClicked
        DefaultTableModel model = (DefaultTableModel)jTable4.getModel();
        int selectedRowIndex = jTable4.getSelectedRow();
        
        PhoneField.setText(model.getValueAt(selectedRowIndex ,1 ).toString());
    }//GEN-LAST:event_jTable4MouseClicked

    /**
     * @param args the command line arguments
     */
    public static void main(String args[]) {
        /* Set the Nimbus look and feel */
        //<editor-fold defaultstate="collapsed" desc=" Look and feel setting code (optional) ">
        /* If Nimbus (introduced in Java SE 6) is not available, stay with the default look and feel.
         * For details see http://download.oracle.com/javase/tutorial/uiswing/lookandfeel/plaf.html 
         */
        try {
            for (javax.swing.UIManager.LookAndFeelInfo info : javax.swing.UIManager.getInstalledLookAndFeels()) {
                if ("Nimbus".equals(info.getName())) {
                    javax.swing.UIManager.setLookAndFeel(info.getClassName());
                    break;
                }
            }
        } catch (ClassNotFoundException ex) {
            java.util.logging.Logger.getLogger(Branches_manipulation.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(Branches_manipulation.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(Branches_manipulation.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(Branches_manipulation.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                new Branches_manipulation().setVisible(true);
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JTextField CityField;
    private javax.swing.JButton ClearButton;
    private javax.swing.JButton DeleteButton;
    private javax.swing.JButton ExitButton;
    private javax.swing.JTextField NameField;
    private javax.swing.JTextField NumberField;
    private javax.swing.JTextField PhoneField;
    private javax.swing.JButton SaveButton;
    private javax.swing.JTextField SearchField;
    private javax.swing.JButton UpdateButton2;
    private javax.swing.ButtonGroup buttonGroup1;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JLabel jLabel10;
    private javax.swing.JLabel jLabel2;
    private javax.swing.JLabel jLabel4;
    private javax.swing.JLabel jLabel5;
    private javax.swing.JLabel jLabel6;
    private javax.swing.JLabel jLabel7;
    private javax.swing.JPanel jPanel1;
    private javax.swing.JPanel jPanel2;
    private javax.swing.JPanel jPanel3;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JScrollPane jScrollPane2;
    private javax.swing.JScrollPane jScrollPane3;
    private javax.swing.JTable jTable1;
    private javax.swing.JTable jTable2;
    private javax.swing.JTable jTable3;
    private javax.swing.JTable jTable4;
    private javax.swing.JToggleButton jToggleButton1;
    // End of variables declaration//GEN-END:variables
}
