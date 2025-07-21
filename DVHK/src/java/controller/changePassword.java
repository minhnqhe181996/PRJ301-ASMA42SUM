/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.UserDAO;
import dao.changePasswordDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.security.MessageDigest;
import java.util.ArrayList;
import javax.xml.bind.DatatypeConverter;
import model.Users;

/**
 *
 * @author LENOVO
 */
public class changePassword extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet changePassword</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet changePassword at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Users user = (Users) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("Login");
        } else {
            RequestDispatcher rs = request.getRequestDispatcher("view/profile.jsp");
            rs.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Users user = (Users) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("Login");
            return;
        }

        response.setContentType("text/html;charset=UTF-8");
        String action = request.getParameter("action");

        if (action == null) {
            RequestDispatcher rs = request.getRequestDispatcher("view/profile.jsp");
            rs.forward(request, response);
            return;
        }

        if (action.equals("change")) {
            String oldPassword = request.getParameter("old");
            String newPassword = request.getParameter("new");
            String reNewPassword = request.getParameter("renew");

            // Kiểm tra các trường rỗng
            if (oldPassword == null || newPassword == null || reNewPassword == null ||
                oldPassword.trim().isEmpty() || newPassword.trim().isEmpty() || reNewPassword.trim().isEmpty()) {
                request.setAttribute("error", "All password fields are required.");
                forwardToProfile(request, response);
                return;
            }

            oldPassword = oldPassword.trim();
            newPassword = newPassword.trim();
            reNewPassword = reNewPassword.trim();

            // Kiểm tra mật khẩu mới và xác nhận mật khẩu mới có khớp không
            if (!newPassword.equals(reNewPassword)) {
                request.setAttribute("error", "New passwords do not match.");
                forwardToProfile(request, response);
                return;
            }

            // Validation mật khẩu mới
            String passwordError = validatePassword(newPassword);
            if (passwordError != null) {
                request.setAttribute("error", passwordError);
                forwardToProfile(request, response);
                return;
            }

            try {
                // Mã hóa mật khẩu cũ để so sánh
                String encryptedOldPassword = encryptPassword(oldPassword);

                // Kiểm tra mật khẩu cũ có đúng không
                if (!user.getPassword().equals(encryptedOldPassword)) {
                    request.setAttribute("error", "Incorrect current password.");
                    forwardToProfile(request, response);
                    return;
                }

                // Mã hóa mật khẩu mới
                String encryptedNewPassword = encryptPassword(newPassword);

                // Cập nhật mật khẩu
                Users updatedUser = changePasswordDAO.updateAccount(user, encryptedNewPassword);

                if (updatedUser != null) {
                    session.setAttribute("user", updatedUser); // Cập nhật session
                    request.setAttribute("success", "Password changed successfully.");
                } else {
                    request.setAttribute("error", "Password update failed.");
                }
            } catch (Exception e) {
                request.setAttribute("error", "An error occurred: " + e.getMessage());
            }
            forwardToProfile(request, response);
        }
    }

    // Hàm mã hóa mật khẩu bằng SHA-256
    private String encryptPassword(String password) throws Exception {
        MessageDigest md = MessageDigest.getInstance("SHA-256");
        byte[] hash = md.digest(password.getBytes("UTF-8"));
        return DatatypeConverter.printHexBinary(hash).toLowerCase();
    }

    // Hàm validation mật khẩu mới
    private String validatePassword(String password) {
        if (!password.matches("^(?=.*[A-Z])(?=.*\\d).{8,}$")) {
            return "Password must be at least 8 characters long, contain at least one uppercase letter and one number.";
        }
        return null; // Không có lỗi
    }

    // Hàm chuyển hướng đến profile.jsp
    private void forwardToProfile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher rs = request.getRequestDispatcher("view/profile.jsp");
        rs.forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet for changing user password with encryption";
    }
}