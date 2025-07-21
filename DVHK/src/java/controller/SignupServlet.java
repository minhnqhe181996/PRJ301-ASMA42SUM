/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.UserDAO;
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
public class SignupServlet extends HttpServlet {

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
            out.println("<title>Servlet SignupServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SignupServlet at " + request.getContextPath() + "</h1>");
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
        processRequest(request, response);
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
        // Lấy dữ liệu từ form
        String idCard = request.getParameter("idCard");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String gender = request.getParameter("gender");
        String city = request.getParameter("city");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phoneNumber = request.getParameter("phoneNumber");
        String address = request.getParameter("address");
        int roleId = 1; // RoleID mặc định là 1 (Citizen)

        // Validation các trường
        String errorMessage = validateInput(idCard, firstName, lastName, gender, city, address, phoneNumber, email, password);
        if (errorMessage != null) {
            request.setAttribute("error", errorMessage);
            request.getRequestDispatcher("view/signup.jsp").forward(request, response);
            return;
        }

        try {
            // Mã hóa mật khẩu
            String encryptedPass = encryptPassword(password);

            // Tạo đối tượng User với mật khẩu đã mã hóa
            Users user = new Users(idCard, firstName, lastName, gender, city, email, encryptedPass, roleId, phoneNumber, address);

            // Thêm người dùng vào cơ sở dữ liệu
            Users result = UserDAO.addUser(user);

            if (result != null) {
                // Thành công, chuyển hướng về trang đăng nhập
                response.sendRedirect(request.getContextPath() + "/Login");
            } else {
                // Thất bại, trả về trang đăng ký với thông báo lỗi
                request.setAttribute("error", "Registration failed. Please check your details (ID Card, Email, or Phone Number might already exist).");
                request.getRequestDispatcher("view/signup.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("view/signup.jsp").forward(request, response);
        }
    }

    // Hàm mã hóa mật khẩu sử dụng SHA-256
    private String encryptPassword(String password) throws Exception {
        MessageDigest md = MessageDigest.getInstance("SHA-256");
        byte[] hash = md.digest(password.getBytes("UTF-8"));
        return DatatypeConverter.printHexBinary(hash).toLowerCase();
    }

    // Hàm validation các trường nhập vào
    private String validateInput(String idCard, String firstName, String lastName, String gender,
            String city, String address, String phoneNumber, String email, String password) {
        // Kiểm tra rỗng
        if (idCard == null || idCard.trim().isEmpty()) {
            return "ID Card is required.";
        }
        if (firstName == null || firstName.trim().isEmpty()) {
            return "First name is required.";
        }
        if (lastName == null || lastName.trim().isEmpty()) {
            return "Last name is required.";
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
        if (phoneNumber == null || phoneNumber.trim().isEmpty()) {
            return "Phone number is required.";
        }
        if (email == null || email.trim().isEmpty()) {
            return "Email is required.";
        }
        if (password == null || password.trim().isEmpty()) {
            return "Password is required.";
        }

        // Validation định dạng
        // IDCard: 9 hoặc 12 chữ số (CMND/CCCD Việt Nam)
        if (!idCard.matches("^\\d{9}$|^\\d{12}$")) {
            return "ID Card must be 9 or 12 digits.";
        }
        if (UserDAO.checkIDCardExists(idCard)) {
            return "ID Card already exists.";
        }

        // Email: Định dạng hợp lệ và kiểm tra trùng
        if (!email.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$")) {
            return "Invalid email format.";
        }
        if (UserDAO.checkEmailExists(email)) {
            return "Email already exists.";
        }

        // Phone: 10 hoặc 11 số, bắt đầu bằng 0
        if (!phoneNumber.matches("^0\\d{9,10}$")) {
            return "Phone number must be 10 or 11 digits and start with 0.";
        }
        if (UserDAO.checkPhoneExists(phoneNumber)) {
            return "Phone number already exists.";
        }

        // Password: Tối thiểu 8 ký tự, có ít nhất 1 chữ cái in hoa và 1 số
        if (!password.matches("^(?=.*[A-Z])(?=.*\\d).{8,}$")) {
            return "Password must be at least 8 characters long, contain at least one uppercase letter and one number.";
        }

        return null; // Không có lỗi
    }

    @Override
    public String getServletInfo() {
        return "Servlet for user signup with encrypted password and validation";
    }
}