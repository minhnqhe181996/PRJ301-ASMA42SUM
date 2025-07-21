/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.util.ArrayList;
import model.Households;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author LENOVO
 */
public class HouseholdDAO {

    public static ArrayList<Households> getHouseholds() {
        ArrayList<Households> households = new ArrayList<Households>();
        DBContext db = DBContext.getInstance();
        // them doan nay de xem loi ket noi o DBContext khong (chu yeu duong dan, tai khoan, mat khau)

        try {
            String sql = """
            select *
            from Households
            """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Households household = new Households(
                        rs.getInt("HouseholdID"),
                        rs.getString("HeadOfHouseholdID"),
                        rs.getString("Address"),
                        rs.getDate("CreatedDate")
                );
                households.add(household);
            }
        } catch (Exception e) {
            // them doan nay de test xem loi o cau lenh SQL khong?

            return null; // return null;
        }
        if (households.isEmpty()) {
            return null;
        } else {
            return households;
        }
    }

    public Households getHouseholdByHead(String headOfHouseholdID) {
        DBContext db = DBContext.getInstance();
        try {
            String sql = "SELECT HouseholdID, Address FROM Households WHERE HeadOfHouseholdID = ?";
            PreparedStatement stmt = db.getConnection().prepareStatement(sql);
            stmt.setString(1, headOfHouseholdID);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Households household = new Households();
                household.setHouseholdID(rs.getInt("HouseholdID"));
                household.setHeadOfHouseholdID(headOfHouseholdID);
                household.setAddress(rs.getString("Address"));
                return household;
            }
            return null;
        } catch (Exception e) {
            System.out.println("Error checking head: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    // Cập nhật địa chỉ hộ khẩu
    public boolean updateHouseholdAddress(int householdID, String newAddress) {
        DBContext db = DBContext.getInstance();
        try {
            String sql = "UPDATE Households SET Address = ? WHERE HouseholdID = ?";
            PreparedStatement stmt = db.getConnection().prepareStatement(sql);
            stmt.setString(1, newAddress);
            stmt.setInt(2, householdID);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            System.out.println("Error updating household: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // Xóa thành viên khỏi hộ khẩu cũ
    public boolean removeMemberFromHousehold(String idCard) {
        DBContext db = DBContext.getInstance();
        try {
            String sql = "DELETE FROM HouseholdMembers WHERE IDCard = ?";
            PreparedStatement stmt = db.getConnection().prepareStatement(sql);
            stmt.setString(1, idCard);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            System.out.println("Error removing member: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // Tạo hộ khẩu mới và trả về HouseholdID
    public int createNewHousehold(String headOfHouseholdID, String address) {
        DBContext db = DBContext.getInstance();
        try {
            String sql = """
                INSERT INTO Households (HeadOfHouseholdID, Address, CreatedDate)
                VALUES (?, ?, GETDATE())
            """;
            PreparedStatement stmt = db.getConnection().prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
            stmt.setString(1, headOfHouseholdID);
            stmt.setString(2, address);
            stmt.executeUpdate();

            ResultSet rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            }
            return -1;
        } catch (Exception e) {
            System.out.println("Error creating household: " + e.getMessage());
            e.printStackTrace();
            return -1;
        }
    }

    // Thêm thành viên vào hộ khẩu
    public boolean addMemberToHousehold(int householdID, String idCard, String relationship) {
        DBContext db = DBContext.getInstance();
        try {
            String sql = """
                INSERT INTO HouseholdMembers (HouseholdID, IDCard, Relationship)
                VALUES (?, ?, ?)
            """;
            PreparedStatement stmt = db.getConnection().prepareStatement(sql);
            stmt.setInt(1, householdID);
            stmt.setString(2, idCard);
            stmt.setString(3, relationship);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            System.out.println("Error adding member: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

//    public static Households getHouseholdByHeadID(String headOfHouseholdID) {
//        DBContext db = DBContext.getInstance();
//        String sql = "SELECT * FROM Households WHERE HeadOfHouseholdID = ?";
//        try {
//            PreparedStatement ps = db.getConnection().prepareStatement(sql);
//            ps.setString(1, headOfHouseholdID);
//            ResultSet rs = ps.executeQuery();
//            if (rs.next()) {
//                return new Households(
//                        rs.getInt("HouseholdID"),
//                        rs.getString("HeadOfHouseholdID"),
//                        rs.getString("Address"),
//                        rs.getDate("CreatedDate")
//                );
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        return null;
//    }

//    public static Households getHouseholdByAddress(String address) {
//        DBContext db = DBContext.getInstance();
//        String sql = "SELECT * FROM Households WHERE Address = ?";
//        try {
//            PreparedStatement ps = db.getConnection().prepareStatement(sql);
//            ps.setString(1, address);
//            ResultSet rs = ps.executeQuery();
//            if (rs.next()) {
//                return new Households(
//                        rs.getInt("HouseholdID"),
//                        rs.getString("HeadOfHouseholdID"),
//                        rs.getString("Address"),
//                        rs.getDate("CreatedDate")
//                );
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        return null;
//    }
    
    public static Households getHouseholdById(int householdID) {
        DBContext db = DBContext.getInstance();
        String sql = "SELECT * FROM Households WHERE HouseholdID = ?";
        try {
            PreparedStatement ps = db.getConnection().prepareStatement(sql);
            ps.setInt(1, householdID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Households(
                    rs.getInt("HouseholdID"),
                    rs.getString("HeadOfHouseholdID"),
                    rs.getString("Address"),
                    rs.getDate("CreatedDate")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public static Households getHouseholdByHeadID(String headOfHouseholdID) {
        DBContext db = DBContext.getInstance();
        String sql = "SELECT * FROM Households WHERE HeadOfHouseholdID = ?";
        try {
            PreparedStatement ps = db.getConnection().prepareStatement(sql);
            ps.setString(1, headOfHouseholdID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Households(
                    rs.getInt("HouseholdID"),
                    rs.getString("HeadOfHouseholdID"),
                    rs.getString("Address"),
                    rs.getDate("CreatedDate")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public static Households getHouseholdByAddress(String address) {
        DBContext db = DBContext.getInstance();
        String sql = "SELECT * FROM Households WHERE Address = ?";
        try {
            PreparedStatement ps = db.getConnection().prepareStatement(sql);
            ps.setString(1, address);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Households(
                    rs.getInt("HouseholdID"),
                    rs.getString("HeadOfHouseholdID"),
                    rs.getString("Address"),
                    rs.getDate("CreatedDate")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
