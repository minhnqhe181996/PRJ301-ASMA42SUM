/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.UserDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.security.MessageDigest;
import javax.xml.bind.DatatypeConverter;
import model.Users;

/**
 *
 * @author LENOVO
 */
public class adduser extends HttpServlet {

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
            out.println("<title>Servlet adduser</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet adduser at " + request.getContextPath() + "</h1>");
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
        request.getRequestDispatcher("view/add_user.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        // Lấy các tham số từ request
        String id = request.getParameter("id");
        String fname = request.getParameter("fname");
        String lname = request.getParameter("lname");
        String role = request.getParameter("role");
        String gender = request.getParameter("gender");
        String city = request.getParameter("city");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String pass = request.getParameter("pass");

        // Kiểm tra action
        if (action == null || !action.equals("add")) {
            request.setAttribute("error", "Invalid action.");
            request.getRequestDispatcher("view/add_user.jsp").forward(request, response);
            return;
        }

        // Validation các trường
        String errorMessage = validateInput(id, fname, lname, role, gender, city, address, phone, email, pass);
        if (errorMessage != null) {
            request.setAttribute("error", errorMessage);
            request.getRequestDispatcher("view/add_user.jsp").forward(request, response);
            return;
        }

        try {
            // Mã hóa mật khẩu
            String encryptedPass = encryptPassword(pass);

            // Tạo đối tượng Users với mật khẩu đã mã hóa
            Users user = new Users(id, fname, lname, gender, city, email, encryptedPass, Integer.parseInt(role), phone, address);
            user = UserDAO.addUser(user);

            if (user != null) {
                request.setAttribute("success", "User added successfully!");
                request.setAttribute("account", user);
                RequestDispatcher rs = request.getRequestDispatcher("view/add_user.jsp");
                rs.forward(request, response);
            } else {
                request.setAttribute("error", "Could not add user.");
                request.getRequestDispatcher("view/add_user.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid role ID format.");
            request.getRequestDispatcher("view/add_user.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("view/add_user.jsp").forward(request, response);
        }
    }

    // Hàm mã hóa mật khẩu sử dụng SHA-256
    private String encryptPassword(String password) throws Exception {
        MessageDigest md = MessageDigest.getInstance("SHA-256");
        byte[] hash = md.digest(password.getBytes("UTF-8"));
        return DatatypeConverter.printHexBinary(hash).toLowerCase();
    }

    // Hàm validation các trường nhập vào
    private String validateInput(String id, String fname, String lname, String role, String gender,
            String city, String address, String phone, String email, String pass) {
        // Kiểm tra rỗng
        if (id == null || id.trim().isEmpty()) {
            return "ID is required.";
        }
        if (fname == null || fname.trim().isEmpty()) {
            return "First name is required.";
        }
        if (lname == null || lname.trim().isEmpty()) {
            return "Last name is required.";
        }
        if (role == null || role.trim().isEmpty()) {
            return "Role is required.";
        }
        if (gender == null || gender.trim().isEmpty()) {
            return "Gender is required.";
        }
        if (city == null || city.trim().isEmpty()) {
            return "City is required.";
        }
        if (address == null || address.trim().isEmpty()) {
            return "Address is required.";
        }
        if (phone == null || phone.trim().isEmpty()) {
            return "Phone is required.";
        }
        if (email == null || email.trim().isEmpty()) {
            return "Email is required.";
        }
        if (pass == null || pass.trim().isEmpty()) {
            return "Password is required.";
        }

        // Validation định dạng
        // IDCard: Giả sử là số CMND/CCCD 9 hoặc 12 chữ số
        if (!id.matches("^\\d{9}$|^\\d{12}$")) {
            return "IDCard must be 9 or 12 digits.";
        }
        // Kiểm tra IDCard đã tồn tại chưa
        if (UserDAO.checkIDCardExists(id)) {
            return "IDCard already exists.";
        }

        // Email: Định dạng email hợp lệ và kiểm tra trùng lặp
        if (!email.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$")) {
            return "Invalid email format.";
        }
        if (UserDAO.checkEmailExists(email)) {
            return "Email already exists.";
        }

        // Phone: 10 hoặc 11 số, bắt đầu bằng 0
        if (!phone.matches("^0\\d{9,10}$")) {
            return "Phone number must be 10 or 11 digits and start with 0.";
        }
        if (UserDAO.checkPhoneExists(phone)) {
            return "Phone number already exists.";
        }

        // Password: Tối thiểu 8 ký tự, có ít nhất 1 chữ cái in hoa, 1 số
        if (!pass.matches("^(?=.*[A-Z])(?=.*\\d).{8,}$")) {
            return "Password must be at least 8 characters long, contain at least one uppercase letter and one number.";
        }

        // Role: Phải là số hợp lệ (1, 2, hoặc 3 dựa trên database)
        try {
            int roleId = Integer.parseInt(role);
            if (roleId < 1 || roleId > 3) {
                return "Role must be 1 (Citizen), 2 (Police), or 3 (Admin).";
            }
        } catch (NumberFormatException e) {
            return "Role must be a valid number.";
        }

        return null; // Không có lỗi
    }

    @Override
    public String getServletInfo() {
        return "Servlet for adding new users with encrypted password";
    }
}
