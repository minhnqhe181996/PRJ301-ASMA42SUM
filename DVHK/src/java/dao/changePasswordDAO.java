/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import model.Users;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author LENOVO
 */
public class changePasswordDAO {

    public static Users updateAccount(Users account, String newPassword) {
    DBContext db = DBContext.getInstance();
    int rs = 0;
    try {
        String sql = """
            UPDATE Users 
            SET Password = ?
            WHERE IDCard = ? 
            AND Password = ?"""; // Added old password verification
        
        PreparedStatement statement = db.getConnection().prepareStatement(sql);
        statement.setString(1, newPassword);        // New password
        statement.setString(2, account.getIDCard()); // IDCard
        statement.setString(3, account.getPassword()); // Old password verification
        
        rs = statement.executeUpdate();
        
        if (rs > 0) {
            account.setPassword(newPassword); // Update the object if successful
            return account;
        }
        return null;
    } catch (Exception e) {
        e.printStackTrace();
        return null;
    }
}
}
