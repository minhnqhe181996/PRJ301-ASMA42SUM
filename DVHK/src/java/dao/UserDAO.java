/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.util.ArrayList;
import model.Users;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author LENOVO
 */
public class UserDAO {

    public static ArrayList<Users> getUsers() {
        ArrayList<Users> users = new ArrayList<Users>();
        DBContext db = DBContext.getInstance();
        // them doan nay de xem loi ket noi o DBContext khong (chu yeu duong dan, tai khoan, mat khau)

        try {
            String sql = """
            select *
            from Users
            """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Users user = new Users(
                        rs.getString("IDCard"),
                        rs.getString("FirstName"),
                        rs.getString("LastName"),
                        rs.getString("Gender"),
                        rs.getString("City"),
                        rs.getString("Email"),
                        rs.getString("Password"),
                        rs.getInt("RoleID"),
                        rs.getString("PhoneNumber"),
                        rs.getString("Address")
                );
                users.add(user);
            }
        } catch (Exception e) {
            // them doan nay de test xem loi o cau lenh SQL khong?

            return null; // return null;
        }
        if (users.isEmpty()) {
            return null;
        } else {
            return users;
        }
    }
    public static boolean updateUserProfile(Users user) {
        DBContext db = DBContext.getInstance();
        
        try {
            String sql = "UPDATE Users SET FirstName = ?, LastName = ?, Gender = ?, " +
                        "PhoneNumber = ?, Email = ?, Address = ?, City = ? " +
                        "WHERE IDCard = ?";
            
            PreparedStatement pstmt = db.getConnection().prepareStatement(sql);
            
            pstmt.setString(1, user.getFirstName());
            pstmt.setString(2, user.getLastName());
            pstmt.setString(3, user.getGender());
            pstmt.setString(4, user.getPhoneNumber());
            pstmt.setString(5, user.getEmail());
            pstmt.setString(6, user.getAddress());
            pstmt.setString(7, user.getCity());
            pstmt.setString(8, user.getIDCard());

            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (Exception e) {
            e.printStackTrace(); // In lỗi để debug
            return false; // Trả về false nếu có lỗi
        }
    }


    
    public static int getPoliceCount() {
        DBContext db = DBContext.getInstance();
        String sql = "SELECT COUNT(*) AS PoliceCount FROM Users WHERE RoleID = 2";
        try {
            PreparedStatement ps = db.getConnection().prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int count = rs.getInt("PoliceCount");
                System.out.println("Total Police Count: " + count);
                return count;
            }
            return 0;
        } catch (Exception e) {
            System.out.println("Error in getPoliceCount: " + e.getMessage());
            e.printStackTrace();
            return 0;
        }
    }

    public static ArrayList<Users> getUserss() {
        ArrayList<Users> users = new ArrayList<Users>();
        DBContext db = DBContext.getInstance();
        // them doan nay de xem loi ket noi o DBContext khong (chu yeu duong dan, tai khoan, mat khau)

        try {
            String sql = """
            select *
            from Users
            """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Users user = new Users(
                        rs.getString("IDCard"),
                        rs.getString("FirstName"),
                        rs.getString("LastName"),
                        rs.getString("Gender"),
                        rs.getString("City"),
                        rs.getString("Email"),
                        rs.getString("Password"),
                        rs.getString("PhoneNumber"),
                        rs.getString("Address")
                );
                users.add(user);
            }
        } catch (Exception e) {
            // them doan nay de test xem loi o cau lenh SQL khong?

            return null; // return null;
        }
        if (users.isEmpty()) {
            return null;
        } else {
            return users;
        }
    }

    public static Users getUsers(String IDCard, String password) {
        ArrayList<Users> users = new ArrayList<Users>();
        DBContext db = DBContext.getInstance();
        // them doan nay de xem loi ket noi o DBContext khong (chu yeu duong dan, tai khoan, mat khau)

        try {
            String sql = """
            select *
            from Users
             where IDCard=? and Password=? 
            """;
            PreparedStatement statment = db.getConnection().prepareStatement(sql); // (3)
            statment.setString(1, IDCard); // (4)
            statment.setString(2, password);

            ResultSet rs = statment.executeQuery(); // (5)
            while (rs.next()) { // (6)
                Users user = new Users(
                        rs.getString("IDCard"),
                        rs.getString("FirstName"),
                        rs.getString("LastName"),
                        rs.getString("Gender"),
                        rs.getString("City"),
                        rs.getString("Email"),
                        rs.getString("Password"),
                        rs.getInt("RoleID"),
                        rs.getString("PhoneNumber"),
                        rs.getString("Address")
                );
                users.add(user);
            }
        } catch (Exception e) {
            // them doan nay de test xem loi o cau lenh SQL khong?

            return null; // return null;
        }
        if (users.isEmpty()) {
            return null;
        } else {
            return users.get(0);
        }
    }

    public static ArrayList<Users> searchInf(String IDCard) {
        DBContext db = DBContext.getInstance();
        ArrayList<Users> userList = new ArrayList<>();

        try {
            String sql = """
        SELECT * 
        FROM Users 
        WHERE IDCard = ?
        """;

            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, IDCard);

            ResultSet rs = statement.executeQuery();
            while (rs.next()) { // Dùng while để đảm bảo lấy tất cả kết quả (dù thường chỉ có 1)
                Users user = new Users(
                        rs.getString("IDCard"),
                        rs.getString("FirstName"),
                        rs.getString("LastName"),
                        rs.getString("Gender"),
                        rs.getString("City"),
                        rs.getString("Email"),
                        rs.getString("Password"),
                        rs.getInt("RoleID"),
                        rs.getString("PhoneNumber"),
                        rs.getString("Address")
                );
                userList.add(user); // Thêm user vào danh sách
            }

        } catch (Exception e) {
            e.printStackTrace(); // In lỗi ra console để dễ debug
        }

        return userList; // Trả về danh sách user (có thể rỗng nếu không tìm thấy)
    }

    public static Users addUser(Users users) {
        DBContext db = DBContext.getInstance(); // (1)
        int rs = 0;
        try {
            String sql = """
           INSERT INTO Users (IDCard, FirstName, LastName, Gender, City, Email, Password, RoleID, PhoneNumber, Address) 
                         VALUES (?, ?, ?,?,?,?,?,?,?,?)
            """; // (2)

            try (PreparedStatement statement = db.getConnection().prepareStatement(sql)) {
                statement.setString(1, users.getIDCard());
                statement.setString(2, users.getFirstName());
                statement.setString(3, users.getLastName());
                statement.setString(4, users.getGender());
                statement.setString(5, users.getCity());
                statement.setString(6, users.getEmail());
                statement.setString(7, users.getPassword());
                statement.setInt(8, users.getRoleID());
                statement.setString(9, users.getPhoneNumber());
                statement.setString(10, users.getAddress());

                rs = statement.executeUpdate();
            }

        } catch (Exception e) {
            return null;
        }
        if (rs == 0) {
            return null;
        } else {
            return users;
        }
    }

    public static ArrayList<Users> getUserIncludeRole() {
        ArrayList<Users> users = new ArrayList<Users>();
        DBContext db = DBContext.getInstance();
        // them doan nay de xem loi ket noi o DBContext khong (chu yeu duong dan, tai khoan, mat khau)

        try {
            String sql = """
            select s.IDCard,s.FirstName,s.LastName,s.Gender,s.City,s.Email,s.Password,r.RoleName,s.PhoneNumber,s.Address,s.RoleID
            from Users s
            join Roles r on s.RoleID=r.RoleID
            """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Users user = new Users();
                user.setIDCard(rs.getString("IDCard"));
                user.setFirstName(rs.getString("FirstName"));
                user.setLastName(rs.getString("LastName"));
                user.setGender(rs.getString("Gender"));
                user.setCity(rs.getString("City"));
                user.setEmail(rs.getString("Email"));
                user.setPassword(rs.getString("Password"));
                user.setPhoneNumber(rs.getString("PhoneNumber"));
                user.setAddress(rs.getString("Address"));
                user.setRoleName(rs.getString("RoleName"));
                user.setRoleID(rs.getInt("RoleID"));

                users.add(user);
            }
        } catch (Exception e) {
            // them doan nay de test xem loi o cau lenh SQL khong?

            return null; // return null;
        }
        if (users.isEmpty()) {
            return null;
        } else {
            return users;
        }
    }

    public static boolean updateUserAddressAndcity(String idCard, String address, String city) {
        DBContext db = DBContext.getInstance();
        try {
            String sql = "UPDATE Users SET Address = ?, City = ? WHERE IDCard = ?";
            PreparedStatement stmt = db.getConnection().prepareStatement(sql);
            stmt.setString(1, address);
            stmt.setString(2, city);
            stmt.setString(3, idCard);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            System.out.println("Error updating user address and city: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // Ví dụ phương thức lấy thông tin người dùng (nếu cần)
    public static Users getUserByIdCard(String idCard) {
        DBContext db = DBContext.getInstance();
        try {
            String sql = "SELECT * FROM Users WHERE IDCard = ?";
            PreparedStatement stmt = db.getConnection().prepareStatement(sql);
            stmt.setString(1, idCard);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new Users(
                        rs.getString("IDCard"),
                        rs.getString("FirstName"),
                        rs.getString("LastName"),
                        rs.getString("Gender"),
                        rs.getString("City"),
                        rs.getString("Email"),
                        rs.getString("Password"),
                        rs.getInt("RoleID"),
                        rs.getString("PhoneNumber"),
                        rs.getString("Address")
                );
            }
            return null;
        } catch (Exception e) {
            System.out.println("Error fetching user: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    public static boolean checkEmailExists(String email) {
        DBContext db = DBContext.getInstance();
        try {
            String sql = "SELECT COUNT(*) FROM Users WHERE Email = ?";
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, email);

            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                int count = rs.getInt(1);
                return count > 0;
            }
        } catch (Exception e) {
            System.out.println("Error checking email existence: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }
    public static boolean checkPhoneExists(String phone) {
        DBContext db = DBContext.getInstance();
        try {
            String sql = "SELECT COUNT(*) FROM Users WHERE Phone = ?";
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, phone);

            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                int count = rs.getInt(1);
                return count > 0;
            }
        } catch (Exception e) {
            System.out.println("Error checking Phone existence: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }
    public static boolean checkIDCardExists(String IDCard) {
        DBContext db = DBContext.getInstance();
        try {
            String sql = "SELECT COUNT(*) FROM Users WHERE IDCard= ?";
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, IDCard);

            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                int count = rs.getInt(1);
                return count > 0;
            }
        } catch (Exception e) {
            System.out.println("Error checking ID existence: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    public String generateRandomPassword(int length) {
        String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()";
        StringBuilder sb = new StringBuilder();
        java.util.Random random = new java.util.Random();

        for (int i = 0; i < length; i++) {
            int index = random.nextInt(chars.length());
            sb.append(chars.charAt(index));
        }

        return sb.toString();
    }

    public  boolean updatePassword(String email, String newPassword) {
        DBContext db = DBContext.getInstance();
        try {
            String sql = "UPDATE Users SET Password = ? WHERE Email = ?";
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, newPassword);
            statement.setString(2, email);

            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            System.out.println("Error updating password: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public static boolean updateRole(Users user) {
        DBContext db = DBContext.getInstance();
        try {
            String sql = """
                UPDATE Users 
                SET RoleID = ?
                WHERE IDCard = ?
                """;

            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, user.getRoleID());
            statement.setString(2, user.getIDCard());

            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public static boolean deleteUser(String idCard) {
        DBContext db = DBContext.getInstance();
        try {
            // Bắt đầu transaction để đảm bảo tất cả các xóa đều thành công hoặc rollback nếu có lỗi
            db.getConnection().setAutoCommit(false);

            // Xóa các bảng phụ thuộc trước (theo thứ tự ngược của khóa ngoại)
            // 1. Xóa Logs
            String sqlLogs = "DELETE FROM Logs WHERE IDCard = ?";
            PreparedStatement stmtLogs = db.getConnection().prepareStatement(sqlLogs);
            stmtLogs.setString(1, idCard);
            stmtLogs.executeUpdate();

            // 2. Xóa Notifications
            String sqlNotifications = "DELETE FROM Notifications WHERE IDCard = ?";
            PreparedStatement stmtNotifications = db.getConnection().prepareStatement(sqlNotifications);
            stmtNotifications.setString(1, idCard);
            stmtNotifications.executeUpdate();

            // 3. Xóa HouseholdMembers
            String sqlHouseholdMembers = "DELETE FROM HouseholdMembers WHERE IDCard = ?";
            PreparedStatement stmtHouseholdMembers = db.getConnection().prepareStatement(sqlHouseholdMembers);
            stmtHouseholdMembers.setString(1, idCard);
            stmtHouseholdMembers.executeUpdate();

            // 4. Xóa Registrations
            String sqlRegistrations = "DELETE FROM Registrations WHERE IDCard = ?";
            PreparedStatement stmtRegistrations = db.getConnection().prepareStatement(sqlRegistrations);
            stmtRegistrations.setString(1, idCard);
            stmtRegistrations.executeUpdate();

            // 5. Xóa Households (nếu người dùng là HeadOfHouseholdID)
            String sqlHouseholds = "DELETE FROM Households WHERE HeadOfHouseholdID = ?";
            PreparedStatement stmtHouseholds = db.getConnection().prepareStatement(sqlHouseholds);
            stmtHouseholds.setString(1, idCard);
            stmtHouseholds.executeUpdate();

            // 6. Cuối cùng xóa Users
            String sqlUsers = "DELETE FROM Users WHERE IDCard = ?";
            PreparedStatement stmtUsers = db.getConnection().prepareStatement(sqlUsers);
            stmtUsers.setString(1, idCard);
            int rowsAffected = stmtUsers.executeUpdate();

            // Commit transaction nếu tất cả thành công
            db.getConnection().commit();
            return rowsAffected > 0;

        } catch (Exception e) {
            // Rollback nếu có lỗi
            try {
                db.getConnection().rollback();
            } catch (Exception rollbackEx) {
                rollbackEx.printStackTrace();
            }
            e.printStackTrace();
            return false;
        } finally {
            // Đặt lại auto-commit về true
            try {
                db.getConnection().setAutoCommit(true);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    public static int getTotalUsersCount() {
        DBContext db = DBContext.getInstance();
        String sql = "SELECT COUNT(*) AS TotalCount FROM Users";
        try {
            PreparedStatement ps = db.getConnection().prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int count = rs.getInt("TotalCount");
                System.out.println("Total Users Count (Admin): " + count);
                return count;
            }
        } catch (Exception e) {
            System.out.println("Error in getTotalUsersCount: " + e.getMessage());
            e.printStackTrace();
        }
        System.out.println("Returning 0 for total users due to no result or error");
        return 0;
    }

    // Đếm số người dùng Citizen theo thành phố (dành cho Police)
    public static int getCitizenCountByCity(String city) {
        DBContext db = DBContext.getInstance();
        String sql = "SELECT COUNT(*) AS CitizenCount FROM Users WHERE RoleID = 1 AND City = ?";
        try {
            PreparedStatement ps = db.getConnection().prepareStatement(sql);
            ps.setString(1, city);
            System.out.println("Querying citizens for city: " + city);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int count = rs.getInt("CitizenCount");
                System.out.println("Citizen Count for " + city + ": " + count);
                return count;
            }
        } catch (Exception e) {
            System.out.println("Error in getCitizenCountByCity: " + e.getMessage());
            e.printStackTrace();
        }
        System.out.println("Returning 0 for citizens in " + city + " due to no result or error");
        return 0;
    }

    public static Users getUserByIDCard(String idCard) {
        DBContext db = DBContext.getInstance();
        String sql = "SELECT * FROM Users WHERE IDCard = ?";
        try {
            PreparedStatement stmt = db.getConnection().prepareStatement(sql);
            stmt.setString(1, idCard);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new Users(
                        rs.getString("IDCard"),
                        rs.getString("FirstName"),
                        rs.getString("LastName"),
                        rs.getString("City"),
                        rs.getInt("RoleID"),
                        rs.getString("Address")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public static boolean updateUserAddressAndCity(String idCard, String address, String city) {
        DBContext db = DBContext.getInstance();
        String sql = "UPDATE Users SET Address = ?, City = ? WHERE IDCard = ?";
        try {
            PreparedStatement stmt = db.getConnection().prepareStatement(sql);
            stmt.setString(1, address);
            stmt.setString(2, city);
            stmt.setString(3, idCard);
            int rows = stmt.executeUpdate();
            return rows > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public static boolean isEmailExists(String email, String excludeIdCard) {
        DBContext db = DBContext.getInstance();
        String sql = "SELECT IDCard FROM Users WHERE Email = ? AND IDCard != ?";
        try {
            PreparedStatement pstmt = db.getConnection().prepareStatement(sql);
            pstmt.setString(1, email);
            pstmt.setString(2, excludeIdCard);
            ResultSet rs = pstmt.executeQuery();
            boolean exists = rs.next();
            rs.close();
            pstmt.close();
            return exists;
        } catch (Exception e) {
            e.printStackTrace();
            return false; // Trả về false nếu có lỗi
        }
    }

    // Kiểm tra số điện thoại có tồn tại không (trừ user hiện tại)
    public static boolean isPhoneExists(String phoneNumber, String excludeIdCard) {
        DBContext db = DBContext.getInstance();
        String sql = "SELECT IDCard FROM Users WHERE PhoneNumber = ? AND IDCard != ?";
        try {
            PreparedStatement pstmt = db.getConnection().prepareStatement(sql);
            pstmt.setString(1, phoneNumber);
            pstmt.setString(2, excludeIdCard);
            ResultSet rs = pstmt.executeQuery();
            boolean exists = rs.next();
            rs.close();
            pstmt.close();
            return exists;
        } catch (Exception e) {
            e.printStackTrace();
            return false; // Trả về false nếu có lỗi
        }
    }

    // Cập nhật thông tin user
    public static boolean updateUser(String idCard, String firstName, String lastName, String gender,
            String phoneNumber, String email, String address, String city) {
        DBContext db = DBContext.getInstance();
        String sql = "UPDATE Users SET FirstName = ?, LastName = ?, Gender = ?, "
                + "PhoneNumber = ?, Email = ?, Address = ?, City = ? WHERE IDCard = ?";
        try {
            PreparedStatement stmt = db.getConnection().prepareStatement(sql);
            stmt.setString(1, firstName);
            stmt.setString(2, lastName);
            stmt.setString(3, gender);
            stmt.setString(4, phoneNumber);
            stmt.setString(5, email);
            stmt.setString(6, address);
            stmt.setString(7, city);
            stmt.setString(8, idCard);

            int rowsAffected = stmt.executeUpdate();
            stmt.close();
            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false; // Trả về false nếu có lỗi
        }
    }
}
