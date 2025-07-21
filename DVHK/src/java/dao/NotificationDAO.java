package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import model.Notifications;

public class NotificationDAO {

    public static ArrayList<Notifications> getNotificationsByUser(String idCard) {
        ArrayList<Notifications> notifications = new ArrayList<>();
        DBContext db = DBContext.getInstance();

        try {
            String sql = """
                SELECT *
                FROM Notifications 
                WHERE IDCard = ?
                ORDER BY SentDate DESC
                """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, idCard);
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                Notifications notification = new Notifications(
                        rs.getInt("NotificationID"),
                        rs.getString("IDCard"),
                        rs.getString("Message"),
                        rs.getTimestamp("SentDate"),
                        rs.getBoolean("IsRead")
                );
                notifications.add(notification);
            }
            // Trả về danh sách, kể cả khi rỗng, thay vì null
            return notifications;

        } catch (SQLException e) {
            e.printStackTrace(); // In lỗi ra console để debug
            return new ArrayList<>(); // Trả về danh sách rỗng thay vì null khi có lỗi
        } finally {
            // Đảm bảo đóng tài nguyên nếu cần (tùy thuộc vào DBContext)
            // Nếu DBContext không tự quản lý đóng connection, thêm logic đóng ở đây
        }
    }

    

// Kiểm tra xem đã gửi thông báo cho đăng ký hết hạn này chưa
    public static boolean hasNotificationForExpiredRegistration(String idCard, String registrationType, Date endDate) {
        String query = "SELECT COUNT(*) FROM Notifications "
                + "WHERE IDCard = ? AND Message LIKE ? AND SentDate >= ?";
        DBContext db = DBContext.getInstance();

        try (PreparedStatement ps = db.getConnection().prepareStatement(query)) {
            ps.setString(1, idCard);
            ps.setString(2, "%" + registrationType.toLowerCase() + " registration%expired on " + endDate + "%");
            ps.setDate(3, new java.sql.Date(endDate.getTime()));
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            System.err.println("Error checking notification for ID: " + idCard);
            e.printStackTrace();
        }
        return false;
    }

    public static boolean markAsRead(int notificationId) {
        DBContext db = DBContext.getInstance();

        try {
            String sql = """
                UPDATE Notifications 
                SET IsRead = 1 
                WHERE NotificationID = ?
                """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, notificationId);
            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace(); // In lỗi để debug
            return false;
        }
    }

    public static boolean sendNotification(String idCard, String message) {
        DBContext db = DBContext.getInstance();
        String sql = "INSERT INTO Notifications (IDCard, Message) VALUES (?, ?)";

        try (PreparedStatement statement = db.getConnection().prepareStatement(sql)) {
            statement.setString(1, idCard);
            statement.setString(2, message);
            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error in sendNotification: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public static String getIDCardFromRegistrationId(String registrationId) {
        DBContext db = DBContext.getInstance();
        String sql = "SELECT IDCard FROM Registrations WHERE RegistrationID = ?";

        try (PreparedStatement statement = db.getConnection().prepareStatement(sql)) {
            // Nếu RegistrationID trong DB là int, chuyển đổi String sang int
            statement.setInt(1, Integer.parseInt(registrationId));
            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    String idCard = rs.getString("IDCard");
                    return idCard != null && !idCard.isEmpty() ? idCard : null;
                }
                return null;
            }
        } catch (NumberFormatException e) {
            System.err.println("Invalid registrationId format: " + registrationId);
            return null;
        } catch (SQLException e) {
            System.err.println("Error in getIDCardFromRegistrationId: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    public static boolean addNotification(String idCard, String message) {
        DBContext db = DBContext.getInstance();
        String sql = "INSERT INTO Notifications (IDCard, Message, SentDate, IsRead) VALUES (?, ?, GETDATE(), 0)";

        try (PreparedStatement stmt = db.getConnection().prepareStatement(sql)) {
            stmt.setString(1, idCard);
            stmt.setString(2, message);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0; // Trả về true nếu thêm thành công
        } catch (SQLException e) {
            System.out.println("Error adding notification: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    public static void addNotification1(String idCard, String message) {
        String query = "INSERT INTO Notifications (IDCard, Message, SentDate, IsRead) "
                + "VALUES (?, ?, GETDATE(), 0)";
        DBContext db = DBContext.getInstance();

        try (PreparedStatement ps = db.getConnection().prepareStatement(query)) {
            ps.setString(1, idCard);
            ps.setString(2, message);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Error adding notification for ID: " + idCard);
            e.printStackTrace();
        }
    }

}
