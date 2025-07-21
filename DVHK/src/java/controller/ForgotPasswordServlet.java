/*
 * Click nbfs://SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import EmailService.EmailSender;

import dao.UserDAO;
import jakarta.mail.MessagingException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.security.MessageDigest;

import javax.xml.bind.DatatypeConverter;
import dao.DBContext;

/**
 *
 * @author LENOVO
 */
public class ForgotPasswordServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("view/re_password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String email = request.getParameter("email");

        // Validate email
        if (email == null || email.trim().isEmpty() || !email.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$")) {
            request.setAttribute("error", "Please enter a valid email address.");
            request.getRequestDispatcher("view/re_password.jsp").forward(request, response);
            return;
        }

        email = email.trim();
        UserDAO userDAO = new UserDAO();

        // Kiểm tra email có tồn tại không
        if (!userDAO.checkEmailExists(email)) {
            request.setAttribute("error", "Email does not exist in our system.");
            request.getRequestDispatcher("view/re_password.jsp").forward(request, response);
            return;
        }

        try {
            // Tạo mật khẩu ngẫu nhiên mới
            String newPassword = generateRandomPassword(10);
            String encryptedNewPassword = encryptPassword(newPassword);

            // Cập nhật mật khẩu mới (đã mã hóa) vào database
            boolean updated = userDAO.updatePassword(email, encryptedNewPassword);

            if (updated) {
                // Chuẩn bị nội dung email (không gửi mật khẩu thô)
                String subject = "Yêu cầu đặt lại mật khẩu";
                String content = "Xin chào,\n\n"
                        + "Chúng tôi đã nhận được yêu cầu đặt lại mật khẩu của bạn. Mật khẩu mới đã được tạo:\n\n"
                        + newPassword + "\n\n"
                        + "Vui lòng đăng nhập bằng mật khẩu này và đổi mật khẩu ngay sau khi đăng nhập để đảm bảo bảo mật.\n\n"
                        + "Trân trọng,\nHệ thống quản lý cư dân";

                // Cấu hình và gửi email
                String senderEmail = "trandat14072005@gmail.com"; // Thay bằng email của bạn
                String senderPassword = "sdnf tphz vsqu qtba"; // Mật khẩu ứng dụng Gmail

                EmailSender emailSender = new EmailSender(senderEmail, senderPassword);
                emailSender.sendEmail(email, subject, content);

                // Chuyển hướng đến trang thông báo thành công
                request.setAttribute("message", "Một email chứa mật khẩu mới đã được gửi đến địa chỉ email của bạn.");
                request.getRequestDispatcher("view/resetpass.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Không thể cập nhật mật khẩu. Vui lòng thử lại sau.");
                request.getRequestDispatcher("view/re_password.jsp").forward(request, response);
            }
        } catch (MessagingException e) {
            request.setAttribute("error", "Không thể gửi email đặt lại mật khẩu. Vui lòng thử lại sau.");
            request.getRequestDispatcher("view/re_password.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Đã xảy ra lỗi: " + e.getMessage());
            request.getRequestDispatcher("view/re_password.jsp").forward(request, response);
        }
    }

    // Hàm mã hóa mật khẩu bằng SHA-256
    private String encryptPassword(String password) throws Exception {
        MessageDigest md = MessageDigest.getInstance("SHA-256");
        byte[] hash = md.digest(password.getBytes("UTF-8"));
        return DatatypeConverter.printHexBinary(hash).toLowerCase();
    }

    // Hàm tạo mật khẩu ngẫu nhiên
    private String generateRandomPassword(int length) {
        String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()";
        StringBuilder sb = new StringBuilder();
        java.util.Random random = new java.util.Random();

        for (int i = 0; i < length; i++) {
            int index = random.nextInt(chars.length());
            sb.append(chars.charAt(index));
        }
        return sb.toString();
    }

    // Hàm cập nhật mật khẩu (tách từ UserDAO)
    public boolean updatePassword(String email, String encryptedNewPassword) {
        DBContext db = DBContext.getInstance();
        try {
            String sql = "UPDATE Users SET Password = ? WHERE Email = ?";
            java.sql.PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, encryptedNewPassword); // Lưu mật khẩu đã mã hóa
            statement.setString(2, email);

            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            System.err.println("Error updating password: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // Hàm kiểm tra email tồn tại (tách từ UserDAO)
    public boolean checkEmailExists(String email) {
        DBContext db = DBContext.getInstance();
        try {
            String sql = "SELECT COUNT(*) FROM Users WHERE Email = ?";
            java.sql.PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, email);
            java.sql.ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
            return false;
        } catch (Exception e) {
            System.err.println("Error checking email: " + e.getMessage());
            return false;
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet for handling forgot password requests with encrypted password";
    }
}
