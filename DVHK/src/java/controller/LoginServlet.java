package controller;

import dao.UserDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.security.MessageDigest;
import javax.xml.bind.DatatypeConverter;
import model.Users;

public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Users user = (Users) session.getAttribute("user");

        if (user == null) {
            RequestDispatcher rs = request.getRequestDispatcher("view/login.jsp");
            rs.forward(request, response);
        } else {
            // Kiểm tra vai trò của người dùng
            switch (user.getRoleID()) {
                case 1:
                    response.sendRedirect("User"); // Vai trò người dùng bình thường
                    break;
                case 2:
                case 3:
                    response.sendRedirect("Management"); // Vai trò quản lý hoặc admin
                    break;
                default:
                    session.invalidate();
                    request.setAttribute("error", "Unauthorized access!");
                    forwardToLogin(request, response);
                    break;
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String userId = request.getParameter("userid");
        String password = request.getParameter("password");

        // Validate input
        if (userId == null || password == null || userId.trim().isEmpty() || password.trim().isEmpty()) {
            request.setAttribute("error", "Username and password must not be empty!");
            forwardToLogin(request, response);
            return;
        }

        userId = userId.trim();
        password = password.trim();

        try {
            // Mã hóa mật khẩu nhập vào
            String encryptedPassword = encryptPassword(password);

            // Authenticate user với mật khẩu đã mã hóa
            Users account = UserDAO.getUsers(userId, encryptedPassword);
            if (account == null) {
                request.setAttribute("error", "Username and password do not match!");
                request.setAttribute("name", userId);
                forwardToLogin(request, response);
            } else {
                HttpSession session = request.getSession();
                session.setAttribute("user", account);

                // Redirect based on role
                switch (account.getRoleID()) {
                    case 1 ->
                        response.sendRedirect("User");
                    case 2 ->
                        response.sendRedirect("Management");
                    case 3 ->
                        response.sendRedirect("Management");
                    default -> {
                        session.invalidate();
                        request.setAttribute("error", "Unauthorized access!");
                        forwardToLogin(request, response);
                    }
                }
            }
        } catch (Exception e) {
            request.setAttribute("error", "An error occurred: " + e.getMessage());
            forwardToLogin(request, response);
        }
    }

    // Hàm mã hóa mật khẩu sử dụng SHA-256
    private String encryptPassword(String password) throws Exception {
        MessageDigest md = MessageDigest.getInstance("SHA-256");
        byte[] hash = md.digest(password.getBytes("UTF-8"));
        return DatatypeConverter.printHexBinary(hash).toLowerCase();
    }

    private void forwardToLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher rs = request.getRequestDispatcher("view/login.jsp");
        rs.forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Login Servlet handles user authentication with encrypted password";
    }
}
