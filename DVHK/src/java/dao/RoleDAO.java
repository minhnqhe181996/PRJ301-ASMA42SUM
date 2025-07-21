/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.util.ArrayList;
import model.Roles;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author LENOVO
 */
public class RoleDAO {
    public static ArrayList<Roles> getRole(){
        ArrayList<Roles> roles = new ArrayList<Roles>();
        DBContext db = DBContext.getInstance();
        // them doan nay de xem loi ket noi o DBContext khong (chu yeu duong dan, tai khoan, mat khau)

        try {
            String sql = """
            select *
            from Roles
            """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Roles role = new Roles(
                        
                        rs.getInt("RoleID"),
                        rs.getString("RoleName")
                        
                );
                roles.add(role);
            }
        } catch (Exception e) {
            // them doan nay de test xem loi o cau lenh SQL khong?

            return null; // return null;
        }
        if (roles.isEmpty()) {
            return null;
        } else {
            return roles;
        }
    }
     
}
