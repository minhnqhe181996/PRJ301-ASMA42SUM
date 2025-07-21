package dao;

import java.util.ArrayList;
import model.Registrations;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Date;

public class RegistrationsDAO {

    public static ArrayList<Registrations> getRegistrations() {
        ArrayList<Registrations> registrations = new ArrayList<>();
        DBContext db = DBContext.getInstance();

        try {
            String sql = """
                SELECT r.*, u.FirstName, u.LastName
                FROM Registrations r
                LEFT JOIN Users u ON r.IDCard = u.IDCard
            """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Registrations reg = new Registrations(
                        rs.getInt("RegistrationID"),
                        rs.getString("IDCard"),
                        rs.getString("RegistrationType"),
                        rs.getDate("StartDate"),
                        rs.getDate("EndDate"),
                        rs.getString("Status"),
                        rs.getString("Relationship"),
                        rs.getString("HeadOfHouseholdID"),
                        rs.getString("ApprovedBy"),
                        rs.getString("Address"),
                        rs.getString("City"),
                        rs.getString("Comments"),
                        rs.getTimestamp("CreatedDate"),
                        rs.getString("FirstName"),
                        rs.getString("LastName")
                );
                registrations.add(reg);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
        return registrations.isEmpty() ? null : registrations;
    }

   public static void checkAndNotifyExpiredRegistrations() {
    String query = "SELECT RegistrationID, IDCard, RegistrationType, EndDate, Address, City " +
                   "FROM Registrations " +
                   "WHERE RegistrationType IN ('Temporary', 'TemporaryStay') " +
                   "AND Status = 'Approved' " +
                   "AND EndDate IS NOT NULL " +
                   "AND EndDate <= ?";
    Date currentDate = new Date();
    DBContext db = DBContext.getInstance();

    try (PreparedStatement ps = db.getConnection().prepareStatement(query)) {
        ps.setDate(1, new java.sql.Date(currentDate.getTime()));
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            String idCard = rs.getString("IDCard");
            String registrationType = rs.getString("RegistrationType");
            Date endDate = rs.getDate("EndDate");
            String address = rs.getString("Address");
            String city = rs.getString("City");

            // Kiểm tra xem thông báo đã được gửi chưa (tránh gửi trùng)
            if (!NotificationDAO.hasNotificationForExpiredRegistration(idCard, registrationType, endDate)) {
                String message = "Your " + registrationType.toLowerCase() + 
                                " registration at " + address + ", " + city + 
                                " has expired on " + endDate + ". Please renew if necessary.";
                NotificationDAO.addNotification1(idCard, message);
            }
        }
    } catch (Exception e) {
        System.err.println("Error checking expired registrations");
        e.printStackTrace();
    }
}
    public static ArrayList<Registrations> getRegistrationForUser(String idCard) {
        ArrayList<Registrations> registrations = new ArrayList<>();
        DBContext db = DBContext.getInstance();

        String sql = """
            SELECT r.*, u.FirstName, u.LastName
            FROM Registrations r
            LEFT JOIN Users u ON r.IDCard = u.IDCard
            WHERE r.Status IN ('Approved', 'Rejected','Pending')
            AND r.IDCard = ?
        """;

        try (PreparedStatement statement = db.getConnection().prepareStatement(sql)) {
            statement.setString(1, idCard);
            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    Registrations reg = new Registrations(
                            rs.getInt("RegistrationID"),
                            rs.getString("IDCard"),
                            rs.getString("RegistrationType"),
                            rs.getDate("StartDate"),
                            rs.getDate("EndDate"),
                            rs.getString("Status"),
                            rs.getString("Relationship"),
                            rs.getString("HeadOfHouseholdID"),
                            rs.getString("ApprovedBy"),
                            rs.getString("Address"),
                            rs.getString("City"),
                            rs.getString("Comments"),
                            rs.getTimestamp("CreatedDate"),
                            rs.getString("FirstName"),
                            rs.getString("LastName")
                    );
                    registrations.add(reg);
                }
            }
        } catch (Exception e) {
            System.err.println("Error retrieving registrations for ID: " + idCard);
            e.printStackTrace();
            return registrations; // Trả về danh sách rỗng thay vì null
        }
        return registrations;
    }

    public static Registrations addAccount(Registrations account) {
        DBContext db = DBContext.getInstance();
        try {
            // Kiểm tra dữ liệu bắt buộc
            if (account.getAddress() == null || account.getAddress().trim().isEmpty()
                    || account.getCity() == null || account.getCity().trim().isEmpty()) {
                throw new IllegalArgumentException("Address and City are required for registration.");
            }

            String sql = """
                INSERT INTO Registrations (IDCard, RegistrationType, StartDate, EndDate, Relationship, HeadOfHouseholdID, Address, City, Comments)
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
            """;
            try (PreparedStatement statement = db.getConnection().prepareStatement(sql)) {
                statement.setString(1, account.getIDCard());
                statement.setString(2, account.getRegistrationType());
                statement.setDate(3, new java.sql.Date(account.getStartDate().getTime()));
                if (account.getEndDate() != null) {
                    statement.setDate(4, new java.sql.Date(account.getEndDate().getTime()));
                } else {
                    statement.setNull(4, java.sql.Types.DATE);
                }
                statement.setString(5, account.getRelationship());
                statement.setString(6, account.getHeadOfHouseholdID());
                statement.setString(7, account.getAddress());
                statement.setString(8, account.getCity());
                statement.setString(9, account.getComments());

                int rs = statement.executeUpdate();
                return rs > 0 ? account : null;
            }
        } catch (Exception e) {
            System.out.println("Error adding registration: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

//    public static Registrations updateRegistrationStatus(Registrations registrations) {
//        DBContext db = DBContext.getInstance();
//        try {
//            String sql = """
//                UPDATE Registrations
//                SET Status = ?, ApprovedBy = ?
//                WHERE RegistrationID = ?
//            """;
//            try (PreparedStatement statement = db.getConnection().prepareStatement(sql)) {
//                statement.setString(1, registrations.getStatus());
//                statement.setString(2, registrations.getApprovedBy());
//                statement.setInt(3, registrations.getRegistrationID());
//
//                int rs = statement.executeUpdate();
//                return rs > 0 ? registrations : null;
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//            return null;
//        }
//    }
//    public static Registrations getRegistrationById(int registrationID) {
//        DBContext db = DBContext.getInstance();
//        try {
//            String sql = """
//                SELECT IDCard, HeadOfHouseholdID, Address, City, Relationship, RegistrationType, Status
//                FROM Registrations
//                WHERE RegistrationID = ?
//            """;
//            PreparedStatement stmt = db.getConnection().prepareStatement(sql);
//            stmt.setInt(1, registrationID);
//            ResultSet rs = stmt.executeQuery();
//
//            if (rs.next()) {
//                Registrations reg = new Registrations();
//                reg.setRegistrationID(registrationID);
//                reg.setIDCard(rs.getString("IDCard"));
//                reg.setHeadOfHouseholdID(rs.getString("HeadOfHouseholdID"));
//                reg.setAddress(rs.getString("Address"));
//                reg.setCity(rs.getString("City"));
//                reg.setRelationship(rs.getString("Relationship"));
//                reg.setRegistrationType(rs.getString("RegistrationType"));
//                reg.setStatus(rs.getString("Status"));
//                return reg;
//            }
//            return null;
//        } catch (Exception e) {
//            System.out.println("Error fetching registration: " + e.getMessage());
//            e.printStackTrace();
//            return null;
//        }
//    }
    public static Registrations getRegById(int registrationID) {
        DBContext db = DBContext.getInstance();
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            String sql = """
            SELECT r.*, u.FirstName, u.LastName
            FROM Registrations r
            LEFT JOIN Users u ON r.IDCard = u.IDCard             
            WHERE RegistrationID = ?
        """;
            stmt = db.getConnection().prepareStatement(sql);
            stmt.setInt(1, registrationID);
            rs = stmt.executeQuery();

            if (rs.next()) {
                Registrations reg = new Registrations(
                        rs.getInt("RegistrationID"),
                        rs.getString("IDCard"),
                        rs.getString("RegistrationType"),
                        rs.getDate("StartDate"),
                        rs.getDate("EndDate"),
                        rs.getString("Status"),
                        rs.getString("Relationship"),
                        rs.getString("HeadOfHouseholdID"),
                        rs.getString("ApprovedBy"),
                        rs.getString("Address"),
                        rs.getString("City"),
                        rs.getString("Comments"),
                        rs.getTimestamp("CreatedDate"),
                        rs.getString("FirstName"),
                        rs.getString("LastName")
                );
                return reg; // Trả về đối tượng reg nếu tìm thấy
            }
            return null; // Trả về null nếu không tìm thấy bản ghi

        } catch (Exception e) {
            System.out.println("Error fetching registration: " + e.getMessage());
            e.printStackTrace();
            return null;
        } finally {
            // Đóng tài nguyên
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                // Không đóng db.getConnection() nếu DBContext quản lý kết nối
            } catch (Exception e) {
                System.out.println("Error closing resources: " + e.getMessage());
            }
        }
    }

//    public static boolean updateHouseholdOnPermanentRegistration(int registrationID) {
//        DBContext db = DBContext.getInstance();
//        try {
//            String selectRegistrationSql = """
//                SELECT IDCard, HeadOfHouseholdID, Address, Relationship
//                FROM Registrations
//                WHERE RegistrationID = ? AND RegistrationType = 'Permanent' AND Status = 'Approved'
//            """;
//            PreparedStatement selectStmt = db.getConnection().prepareStatement(selectRegistrationSql);
//            selectStmt.setInt(1, registrationID);
//            ResultSet rs = selectStmt.executeQuery();
//
//            if (rs.next()) {
//                String userIDCard = rs.getString("IDCard");
//                String newHeadOfHouseholdID = rs.getString("HeadOfHouseholdID");
//                String newAddress = rs.getString("Address");
//                String relationship = rs.getString("Relationship");
//
//                String checkHeadSql = "SELECT HouseholdID FROM Households WHERE HeadOfHouseholdID = ?";
//                PreparedStatement checkHeadStmt = db.getConnection().prepareStatement(checkHeadSql);
//                checkHeadStmt.setString(1, userIDCard);
//                ResultSet headRs = checkHeadStmt.executeQuery();
//
//                if (headRs.next()) {
//                    int householdID = headRs.getInt("HouseholdID");
//                    String updateHouseholdSql = "UPDATE Households SET Address = ? WHERE HouseholdID = ?";
//                    PreparedStatement updateStmt = db.getConnection().prepareStatement(updateHouseholdSql);
//                    updateStmt.setString(1, newAddress);
//                    updateStmt.setInt(2, householdID);
//                    updateStmt.executeUpdate();
//                } else {
//                    String deleteMemberSql = "DELETE FROM HouseholdMembers WHERE IDCard = ?";
//                    PreparedStatement deleteStmt = db.getConnection().prepareStatement(deleteMemberSql);
//                    deleteStmt.setString(1, userIDCard);
//                    deleteStmt.executeUpdate();
//
//                    if (userIDCard.equals(newHeadOfHouseholdID)) {
//                        String insertHouseholdSql = """
//                            INSERT INTO Households (HeadOfHouseholdID, Address, CreatedDate)
//                            VALUES (?, ?, GETDATE())
//                        """;
//                        PreparedStatement insertHouseholdStmt = db.getConnection().prepareStatement(insertHouseholdSql,
//                                PreparedStatement.RETURN_GENERATED_KEYS);
//                        insertHouseholdStmt.setString(1, userIDCard);
//                        insertHouseholdStmt.setString(2, newAddress);
//                        insertHouseholdStmt.executeUpdate();
//
//                        ResultSet generatedKeys = insertHouseholdStmt.getGeneratedKeys();
//                        int newHouseholdID = 0;
//                        if (generatedKeys.next()) {
//                            newHouseholdID = generatedKeys.getInt(1);
//                        }
//
//                        String insertMemberSql = """
//                            INSERT INTO HouseholdMembers (HouseholdID, IDCard, Relationship)
//                            VALUES (?, ?, 'Head')
//                        """;
//                        PreparedStatement insertMemberStmt = db.getConnection().prepareStatement(insertMemberSql);
//                        insertMemberStmt.setInt(1, newHouseholdID);
//                        insertMemberStmt.setString(2, userIDCard);
//                        insertMemberStmt.executeUpdate();
//                    } else {
//                        String findHouseholdSql = "SELECT HouseholdID FROM Households WHERE HeadOfHouseholdID = ?";
//                        PreparedStatement findStmt = db.getConnection().prepareStatement(findHouseholdSql);
//                        findStmt.setString(1, newHeadOfHouseholdID);
//                        ResultSet findRs = findStmt.executeQuery();
//
//                        if (findRs.next()) {
//                            int existingHouseholdID = findRs.getInt("HouseholdID");
//                            String insertMemberSql = """
//                                INSERT INTO HouseholdMembers (HouseholdID, IDCard, Relationship)
//                                VALUES (?, ?, ?)
//                            """;
//                            PreparedStatement insertMemberStmt = db.getConnection().prepareStatement(insertMemberSql);
//                            insertMemberStmt.setInt(1, existingHouseholdID);
//                            insertMemberStmt.setString(2, userIDCard);
//                            insertMemberStmt.setString(3, relationship);
//                            insertMemberStmt.executeUpdate();
//                        } else {
//                            System.out.println("HeadOfHouseholdID not found: " + newHeadOfHouseholdID);
//                            return false;
//                        }
//                    }
//                }
//                return true;
//            } else {
//                System.out.println("Registration not found or not approved: " + registrationID);
//                return false;
//            }
//        } catch (Exception e) {
//            System.out.println("Database error: " + e.getMessage());
//            e.printStackTrace();
//            return false;
//        }
//    }
    public static Registrations getAccountsById(int accountId) {
        DBContext db = DBContext.getInstance();
        try {
            String sql = """
                SELECT *
                FROM Registrations
                WHERE RegistrationID = ?
            """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, accountId);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                return new Registrations(
                        rs.getInt("RegistrationID"),
                        rs.getString("IDCard"),
                        rs.getString("RegistrationType"),
                        rs.getDate("StartDate"),
                        rs.getDate("EndDate"),
                        rs.getString("Status"),
                        rs.getString("Relationship"),
                        rs.getString("HeadOfHouseholdID"),
                        rs.getString("ApprovedBy"),
                        rs.getString("Address"),
                        rs.getString("City"),
                        rs.getString("Comments"),
                        rs.getTimestamp("CreatedDate")
                );
            }
            return null;
        } catch (Exception e) {
            System.out.println("Error fetching account: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    public static boolean deleteRegistration(int registrationId) {
        DBContext db = DBContext.getInstance();
        try {
            String sql = "DELETE FROM Registrations WHERE RegistrationID = ?";
            PreparedStatement stmt = db.getConnection().prepareStatement(sql);
            stmt.setInt(1, registrationId);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            System.out.println("Error deleting registration: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public static void main(String[] args) {
        Registrations u = RegistrationsDAO.getRegById(58);
        System.out.println(u);
    }

    public static ArrayList<Registrations> getPendingRegistrationsByType(String type) {
        ArrayList<Registrations> list = new ArrayList<>();
        DBContext db = DBContext.getInstance();
        String sql = "SELECT * FROM Registrations WHERE RegistrationType = ? AND Status = 'Pending'";
        try {
            PreparedStatement stmt = db.getConnection().prepareStatement(sql);
            stmt.setString(1, type);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(new Registrations(
                        rs.getInt("RegistrationID"),
                        rs.getString("IDCard"),
                        rs.getString("RegistrationType"),
                        rs.getDate("StartDate"),
                        rs.getString("Status"),
                        rs.getString("Relationship"),
                        rs.getString("HeadOfHouseholdID"),
                        rs.getString("ApprovedBy"),
                        rs.getString("Address"),
                        rs.getString("City"),
                        rs.getString("Comments"),
                        rs.getTimestamp("CreatedDate")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public static ArrayList<Registrations> getPendingRegistrations() {
        DBContext db = DBContext.getInstance();
        ArrayList<Registrations> list = new ArrayList<>();
        String sql = "SELECT * FROM Registrations WHERE Status = 'Pending'";
        try {
            PreparedStatement ps = db.getConnection().prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Registrations reg = new Registrations();
                reg.setRegistrationID(rs.getInt("RegistrationID"));
                reg.setIDCard(rs.getString("IDCard"));
                reg.setRegistrationType(rs.getString("RegistrationType"));
                reg.setStartDate(rs.getDate("StartDate"));
                reg.setEndDate(rs.getDate("EndDate"));
                reg.setStatus(rs.getString("Status"));
                reg.setAddress(rs.getString("Address"));
                reg.setCity(rs.getString("City"));
                reg.setRelationship(rs.getString("Relationship"));
                reg.setHeadOfHouseholdID(rs.getString("HeadOfHouseholdID"));
                reg.setApprovedBy(rs.getString("ApprovedBy"));
                reg.setComments(rs.getString("Comments"));
                reg.setCreatedDate(rs.getTimestamp("CreatedDate"));
                list.add(reg);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public static ArrayList<Registrations> getRegistrationsByIDCard(String idCard) {
        DBContext db = DBContext.getInstance();
        ArrayList<Registrations> list = new ArrayList<>();
        String sql = "SELECT * FROM Registrations WHERE IDCard = ?";
        try {
            PreparedStatement ps = db.getConnection().prepareStatement(sql);
            ps.setString(1, idCard);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Registrations reg = new Registrations();
                reg.setRegistrationID(rs.getInt("RegistrationID"));
                reg.setIDCard(rs.getString("IDCard"));
                reg.setRegistrationType(rs.getString("RegistrationType"));
                reg.setStartDate(rs.getDate("StartDate"));
                reg.setEndDate(rs.getDate("EndDate"));
                reg.setStatus(rs.getString("Status"));
                reg.setAddress(rs.getString("Address"));
                reg.setCity(rs.getString("City"));
                reg.setRelationship(rs.getString("Relationship"));
                reg.setHeadOfHouseholdID(rs.getString("HeadOfHouseholdID"));
                reg.setApprovedBy(rs.getString("ApprovedBy"));
                reg.setComments(rs.getString("Comments"));
                reg.setCreatedDate(rs.getTimestamp("CreatedDate"));
                list.add(reg);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public static Registrations getRegistrationById(int regId) {
        DBContext db = DBContext.getInstance();
        String sql = "SELECT * FROM Registrations WHERE RegistrationID = ?";
        try {
            PreparedStatement stmt = db.getConnection().prepareStatement(sql);
            stmt.setInt(1, regId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new Registrations(
                        rs.getInt("RegistrationID"),
                        rs.getString("IDCard"),
                        rs.getString("RegistrationType"),
                        rs.getDate("StartDate"),
                        rs.getString("Status"),
                        rs.getString("Relationship"),
                        rs.getString("HeadOfHouseholdID"),
                        rs.getString("ApprovedBy"),
                        rs.getString("Address"),
                        rs.getString("City"),
                        rs.getString("Comments"),
                        rs.getTimestamp("CreatedDate")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public static Registrations updateRegistrationStatus(Registrations reg) {
        DBContext db = DBContext.getInstance();
        String sql = "UPDATE Registrations SET Status = ?, ApprovedBy = ? WHERE RegistrationID = ?";
        try {
            PreparedStatement stmt = db.getConnection().prepareStatement(sql);
            stmt.setString(1, reg.getStatus());
            stmt.setString(2, reg.getApprovedBy());
            stmt.setInt(3, reg.getRegistrationID());
            int rows = stmt.executeUpdate();
            return rows > 0 ? reg : null;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static int getUniqueProcessedUsersCount(String city) {
        DBContext db = DBContext.getInstance();
        String sql;
        if (city == null || city.isEmpty()) {
            sql = "SELECT COUNT(DISTINCT IDCard) AS UniqueCount FROM Registrations WHERE Status IN ('Approved', 'Rejected')";
        } else {
            sql = "SELECT COUNT(DISTINCT IDCard) AS UniqueCount FROM Registrations WHERE Status IN ('Approved', 'Rejected') AND City = ?";
        }
        try {
            PreparedStatement ps = db.getConnection().prepareStatement(sql);
            if (city != null && !city.isEmpty()) {
                ps.setString(1, city);
                System.out.println("Querying processed users for city: " + city);
            } else {
                System.out.println("Querying processed users for all cities");
            }
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int count = rs.getInt("UniqueCount");
                System.out.println("Processed Users Count: " + count);
                return count;
            }
            return 0; // Trả về 0 nếu không có kết quả
        } catch (Exception e) {
            System.out.println("Error in getUniqueProcessedUsersCount: " + e.getMessage());
            e.printStackTrace();
            return 0;
        }
    }
    
   

    public static int getUniqueRegistrantsCount(String city) {
        DBContext db = DBContext.getInstance();
        String sql;
        if (city == null || city.isEmpty()) {
            sql = "SELECT COUNT(DISTINCT IDCard) AS UniqueCount FROM Registrations";
        } else {
            sql = "SELECT COUNT(DISTINCT IDCard) AS UniqueCount FROM Registrations WHERE City = ?";
        }
        try {
            PreparedStatement ps = db.getConnection().prepareStatement(sql);
            if (city != null && !city.isEmpty()) {
                ps.setString(1, city);
                System.out.println("Querying total users for city: " + city);
            } else {
                System.out.println("Querying total users for all cities");
            }
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int count = rs.getInt("UniqueCount");
                System.out.println("Total Users Count: " + count);
                return count;
            }
        } catch (Exception e) {
            System.out.println("Error in getUniqueRegistrantsCount: " + e.getMessage());
            e.printStackTrace();
        }
        System.out.println("Returning 0 for total users due to no result or error");
        return 0;
    }

    public static int getUniqueUsersByStatus(String status, String city) {
        DBContext db = DBContext.getInstance();
        String sql;
        if (city == null || city.isEmpty()) {
            sql = "SELECT COUNT(DISTINCT IDCard) AS UniqueCount FROM Registrations WHERE Status = ?";
        } else {
            sql = "SELECT COUNT(DISTINCT IDCard) AS UniqueCount FROM Registrations WHERE Status = ? AND City = ?";
        }
        try {
            PreparedStatement ps = db.getConnection().prepareStatement(sql);
            ps.setString(1, status);
            if (city != null && !city.isEmpty()) {
                ps.setString(2, city);
                System.out.println("Querying " + status + " users for city: " + city);
            } else {
                System.out.println("Querying " + status + " users for all cities");
            }
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int count = rs.getInt("UniqueCount");
                System.out.println(status + " Users Count: " + count);
                return count;
            }
        } catch (Exception e) {
            System.out.println("Error in getUniqueUsersByStatus: " + e.getMessage());
            e.printStackTrace();
        }
        System.out.println("Returning 0 for " + status + " users due to no result or error");
        return 0;
    }

    public static Registrations updateRegistrationStatusWithComments(Registrations reg, String comments) {
        DBContext db = DBContext.getInstance();
        String sql = "UPDATE Registrations SET Status = ?, ApprovedBy = ?, Comments = ? WHERE RegistrationID = ?";
        try {
            PreparedStatement stmt = db.getConnection().prepareStatement(sql);
            stmt.setString(1, reg.getStatus());
            stmt.setString(2, reg.getApprovedBy());
            stmt.setString(3, comments);
            stmt.setInt(4, reg.getRegistrationID());
            int rows = stmt.executeUpdate();
            return rows > 0 ? reg : null;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static boolean updateHouseholdOnPermanentRegistration(int registrationID) {
        DBContext db = DBContext.getInstance();
        try {
            String selectRegistrationSql = """
                SELECT IDCard, HeadOfHouseholdID, Address, Relationship
                FROM Registrations
                WHERE RegistrationID = ? AND RegistrationType = 'Permanent' AND Status = 'Approved'
            """;
            PreparedStatement selectStmt = db.getConnection().prepareStatement(selectRegistrationSql);
            selectStmt.setInt(1, registrationID);
            ResultSet rs = selectStmt.executeQuery();

            if (rs.next()) {
                String userIDCard = rs.getString("IDCard");
                String newHeadOfHouseholdID = rs.getString("HeadOfHouseholdID");
                String newAddress = rs.getString("Address");
                String relationship = rs.getString("Relationship");

                String checkHeadSql = "SELECT HouseholdID FROM Households WHERE HeadOfHouseholdID = ?";
                PreparedStatement checkHeadStmt = db.getConnection().prepareStatement(checkHeadSql);
                checkHeadStmt.setString(1, userIDCard);
                ResultSet headRs = checkHeadStmt.executeQuery();

                if (headRs.next()) {
                    int householdID = headRs.getInt("HouseholdID");
                    String updateHouseholdSql = "UPDATE Households SET Address = ? WHERE HouseholdID = ?";
                    PreparedStatement updateStmt = db.getConnection().prepareStatement(updateHouseholdSql);
                    updateStmt.setString(1, newAddress);
                    updateStmt.setInt(2, householdID);
                    updateStmt.executeUpdate();
                } else {
                    String deleteMemberSql = "DELETE FROM HouseholdMembers WHERE IDCard = ?";
                    PreparedStatement deleteStmt = db.getConnection().prepareStatement(deleteMemberSql);
                    deleteStmt.setString(1, userIDCard);
                    deleteStmt.executeUpdate();

                    if (userIDCard.equals(newHeadOfHouseholdID)) {
                        String insertHouseholdSql = """
                            INSERT INTO Households (HeadOfHouseholdID, Address, CreatedDate)
                            VALUES (?, ?, GETDATE())
                        """;
                        PreparedStatement insertHouseholdStmt = db.getConnection().prepareStatement(insertHouseholdSql,
                                PreparedStatement.RETURN_GENERATED_KEYS);
                        insertHouseholdStmt.setString(1, userIDCard);
                        insertHouseholdStmt.setString(2, newAddress);
                        insertHouseholdStmt.executeUpdate();

                        ResultSet generatedKeys = insertHouseholdStmt.getGeneratedKeys();
                        int newHouseholdID = 0;
                        if (generatedKeys.next()) {
                            newHouseholdID = generatedKeys.getInt(1);
                        }

                        String insertMemberSql = """
                            INSERT INTO HouseholdMembers (HouseholdID, IDCard, Relationship)
                            VALUES (?, ?, 'Head')
                        """;
                        PreparedStatement insertMemberStmt = db.getConnection().prepareStatement(insertMemberSql);
                        insertMemberStmt.setInt(1, newHouseholdID);
                        insertMemberStmt.setString(2, userIDCard);
                        insertMemberStmt.executeUpdate();
                    } else {
                        String findHouseholdSql = "SELECT HouseholdID FROM Households WHERE HeadOfHouseholdID = ?";
                        PreparedStatement findStmt = db.getConnection().prepareStatement(findHouseholdSql);
                        findStmt.setString(1, newHeadOfHouseholdID);
                        ResultSet findRs = findStmt.executeQuery();

                        if (findRs.next()) {
                            int existingHouseholdID = findRs.getInt("HouseholdID");
                            String insertMemberSql = """
                                INSERT INTO HouseholdMembers (HouseholdID, IDCard, Relationship)
                                VALUES (?, ?, ?)
                            """;
                            PreparedStatement insertMemberStmt = db.getConnection().prepareStatement(insertMemberSql);
                            insertMemberStmt.setInt(1, existingHouseholdID);
                            insertMemberStmt.setString(2, userIDCard);
                            insertMemberStmt.setString(3, relationship);
                            insertMemberStmt.executeUpdate();
                        } else {
                            System.out.println("HeadOfHouseholdID not found: " + newHeadOfHouseholdID);
                            return false;
                        }
                    }
                }
                return true;
            } else {
                System.out.println("Registration not found or not approved: " + registrationID);
                return false;
            }
        } catch (Exception e) {
            System.out.println("Database error: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public static ArrayList<Registrations> getProcessedRegistrations() {
        DBContext db = DBContext.getInstance();
        ArrayList<Registrations> list = new ArrayList<>();
        String sql = "SELECT * FROM Registrations WHERE Status IN ('Approved', 'Rejected')";
        try {
            PreparedStatement ps = db.getConnection().prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Registrations reg = new Registrations();
                reg.setRegistrationID(rs.getInt("RegistrationID"));
                reg.setIDCard(rs.getString("IDCard"));
                reg.setRegistrationType(rs.getString("RegistrationType"));
                reg.setStartDate(rs.getTimestamp("StartDate"));
                reg.setEndDate(rs.getTimestamp("EndDate"));
                reg.setStatus(rs.getString("Status"));
                reg.setAddress(rs.getString("Address"));
                reg.setCity(rs.getString("City"));
                reg.setRelationship(rs.getString("Relationship"));
                reg.setHeadOfHouseholdID(rs.getString("HeadOfHouseholdID"));
                reg.setApprovedBy(rs.getString("ApprovedBy"));
                reg.setComments(rs.getString("Comments"));
                reg.setCreatedDate(rs.getTimestamp("CreatedDate"));
                list.add(reg);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public static ArrayList<Registrations> getApprovedRegistrations() {
        DBContext db = DBContext.getInstance();
        ArrayList<Registrations> list = new ArrayList<>();
        String sql = "SELECT * FROM Registrations WHERE Status = 'Approved'";
        try {
            PreparedStatement ps = db.getConnection().prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Registrations reg = new Registrations();
                reg.setRegistrationID(rs.getInt("RegistrationID"));
                reg.setIDCard(rs.getString("IDCard"));
                reg.setRegistrationType(rs.getString("RegistrationType"));
                reg.setStartDate(rs.getTimestamp("StartDate"));
                reg.setEndDate(rs.getTimestamp("EndDate"));
                reg.setStatus(rs.getString("Status"));
                reg.setAddress(rs.getString("Address"));
                reg.setCity(rs.getString("City"));
                reg.setRelationship(rs.getString("Relationship"));
                reg.setHeadOfHouseholdID(rs.getString("HeadOfHouseholdID"));
                reg.setApprovedBy(rs.getString("ApprovedBy"));
                reg.setComments(rs.getString("Comments"));
                reg.setCreatedDate(rs.getTimestamp("CreatedDate"));
                list.add(reg);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
