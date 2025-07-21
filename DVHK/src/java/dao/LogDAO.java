/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.util.ArrayList;
import model.Logs;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author LENOVO
 */
public class LogDAO {
    public static ArrayList<Logs> getLogs() {
        ArrayList<Logs> logs = new ArrayList<>();
        DBContext db = DBContext.getInstance();
        
        try {
            String sql = "SELECT * FROM Logs";
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            
            while (rs.next()) {
                Logs log = new Logs(
                    rs.getInt("LogID"),
                        rs.getInt("UserID"),
                        rs.getString("Action"),
                        rs.getTimestamp("Timestamp")
                );
                logs.add(log);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
        
        return logs.isEmpty() ? null : logs;
    }
}
