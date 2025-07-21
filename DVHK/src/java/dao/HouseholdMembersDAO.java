/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.util.ArrayList;
import model.HouseholdMembers;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import model.Households;

/**
 *
 * @author LENOVO
 */
public class HouseholdMembersDAO {

    public static ArrayList<HouseholdMembers> getAllHouseholdMembers() {
        ArrayList<HouseholdMembers> members = new ArrayList<>();
        DBContext db = DBContext.getInstance();

        try {
            String sql = "SELECT * FROM HouseholdMembers";
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                HouseholdMembers member = new HouseholdMembers(
                        rs.getInt("MemberID"),
                        rs.getInt("HouseholdID"),
                        rs.getString("UserID"),
                        rs.getString("Relationship")
                );
                members.add(member);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }

        return members.isEmpty() ? null : members;
    }

    public static List<HouseholdMembers> getAllHouseholds() {
        List<HouseholdMembers> households = new ArrayList<>();
        DBContext db = DBContext.getInstance();

        String query = "SELECT h.HouseholdID, h.HeadOfHouseholdID, u.FirstName, u.LastName, h.Address, h.CreatedDate, "
                + "hm.IDCard, um.FirstName AS memberFirstName, um.LastName AS memberLastName, hm.Relationship "
                + "FROM Households h "
                + "JOIN Users u ON h.HeadOfHouseholdID = u.IDCard "
                + "LEFT JOIN HouseholdMembers hm ON h.HouseholdID = hm.HouseholdID "
                + "LEFT JOIN Users um ON hm.IDCard = um.IDCard";

        try {
            PreparedStatement ps = db.getConnection().prepareStatement(query);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                HouseholdMembers household = new HouseholdMembers();
                household.setHouseholdID(rs.getInt("HouseholdID"));
                household.setHeadOfHouseholdID(rs.getString("HeadOfHouseholdID"));
                household.setFirstName(rs.getString("FirstName"));
                household.setLastName(rs.getString("LastName"));
                household.setAddress(rs.getString("Address"));
                household.setCreatedDate(rs.getDate("CreatedDate"));
                household.setIDCard(rs.getString("IDCard"));
                household.setMemberFirstName(rs.getString("memberFirstName"));
                household.setMemberLastName(rs.getString("memberLastName"));
                household.setRelationship(rs.getString("Relationship"));
                households.add(household);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null; // Trả về null nếu có lỗi, đồng bộ với getAllHouseholdMembers
        }

        return households.isEmpty() ? null : households; // Đồng bộ logic trả về
    }

    // Lấy hộ khẩu theo thành phố
    public static List<HouseholdMembers> getHouseholdsByCity(String city) {
        List<HouseholdMembers> households = new ArrayList<>();
        DBContext db = DBContext.getInstance();

        String query = "SELECT h.HouseholdID, h.HeadOfHouseholdID, u.FirstName, u.LastName, h.Address, h.CreatedDate, "
                + "hm.IDCard, um.FirstName AS memberFirstName, um.LastName AS memberLastName, hm.Relationship "
                + "FROM Households h "
                + "JOIN Users u ON h.HeadOfHouseholdID = u.IDCard "
                + "LEFT JOIN HouseholdMembers hm ON h.HouseholdID = hm.HouseholdID "
                + "LEFT JOIN Users um ON hm.IDCard = um.IDCard "
                + "WHERE u.City = ?";

        try {
            PreparedStatement ps = db.getConnection().prepareStatement(query);
            ps.setString(1, city);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                HouseholdMembers household = new HouseholdMembers();
                household.setHouseholdID(rs.getInt("HouseholdID"));
                household.setHeadOfHouseholdID(rs.getString("HeadOfHouseholdID"));
                household.setFirstName(rs.getString("FirstName"));
                household.setLastName(rs.getString("LastName"));
                household.setAddress(rs.getString("Address"));
                household.setCreatedDate(rs.getDate("CreatedDate"));
                household.setIDCard(rs.getString("IDCard"));
                household.setMemberFirstName(rs.getString("memberFirstName"));
                household.setMemberLastName(rs.getString("memberLastName"));
                household.setRelationship(rs.getString("Relationship"));
                households.add(household);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null; // Trả về null nếu có lỗi
        }

        return households.isEmpty() ? null : households; // Đồng bộ logic trả về
    }


public static ArrayList<HouseholdMembers> getHouseholdMembersByHouseholdID(int householdID) {
        ArrayList<HouseholdMembers> members = new ArrayList<>();
        DBContext db = DBContext.getInstance();

        try {
            String sql = "SELECT MemberID, HouseholdID, IDCard, Relationship FROM HouseholdMembers WHERE HouseholdID = ?";
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, householdID);
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                HouseholdMembers member = new HouseholdMembers(
                        rs.getInt("MemberID"),
                        rs.getInt("HouseholdID"),
                        rs.getString("IDCard"), // Sử dụng "IDCard" thay vì "UserID" để đúng với bảng của bạn
                        rs.getString("Relationship")
                );
                members.add(member);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null; // Trả về null nếu có lỗi
        }

        return members.isEmpty() ? null : members; // Trả về null nếu danh sách rỗng, ngược lại trả về danh sách
    }

    public static ArrayList<Households> getHouseholds() {
        ArrayList<Households> households = new ArrayList<>();
        DBContext db = DBContext.getInstance();

        try {
            String sql = """
            SELECT 
                                h.HouseholdID, h.HeadOfHouseholdID, h.Address, h.CreatedDate,
                                u_head.FirstName AS HeadFirstName, u_head.LastName AS HeadLastName,
                                hm.IDCard AS MemberIDCard, hm.Relationship,
                                u_member.FirstName AS MemberFirstName, u_member.LastName AS MemberLastName
                            FROM Households h
                            left JOIN Users u_head ON h.HeadOfHouseholdID = u_head.IDCard
                            left join HouseholdMembers hm ON h.HouseholdID = hm.HouseholdID
                            left JOIN Users u_member ON hm.IDCard = u_member.IDCard
        """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Households household = new Households(
                        rs.getInt("HouseholdID"),
                        rs.getString("HeadOfHouseholdID"),
                        rs.getString("Address"),
                        rs.getDate("CreatedDate"),
                        rs.getString("MemberIDCard"),
                        rs.getString("Relationship"),
                        rs.getString("HeadFirstName"),
                        rs.getString("HeadLastName"),
                        rs.getString("MemberFirstName"),
                        rs.getString("MemberLastName")
                );
                households.add(household);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
        return households.isEmpty() ? null : households;
    }

    public static HouseholdMembers addAccount(HouseholdMembers account) {
        DBContext db = DBContext.getInstance(); // (1)
        int rs = 0;
        try {
            String sql = """
            insert into HouseholdMembers(HouseholdID, IDCard, Relationship)
            values (?, ?, ?)
            """; // (2)

            PreparedStatement statment = db.getConnection().prepareStatement(sql); // (3)
            statment.setInt(1, account.getHouseholdID());
            statment.setString(2, account.getIDCard());
            statment.setString(3, account.getRelationship());
            rs = statment.executeUpdate(); // (5)

        } catch (Exception e) {
            return null;
        }
        if (rs == 0) {
            return null;
        } else {
            return account;
        }
    }

    public static ArrayList<HouseholdMembers> getHouseholdMembersByIDCard(String idCard) {
        DBContext db = DBContext.getInstance();
        ArrayList<HouseholdMembers> list = new ArrayList<>();
        String sql = "SELECT * FROM HouseholdMembers WHERE IDCard = ?";
        try {
            PreparedStatement ps = db.getConnection().prepareStatement(sql);
            ps.setString(1, idCard);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                HouseholdMembers member = new HouseholdMembers();
                member.setMemberID(rs.getInt("MemberID"));
                member.setHouseholdID(rs.getInt("HouseholdID"));
                member.setIDCard(rs.getString("IDCard"));
                member.setRelationship(rs.getString("Relationship"));
                list.add(member);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
