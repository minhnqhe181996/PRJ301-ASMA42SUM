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
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import model.Users;

/**
 *
 * @author LENOVO
 */
public class EditAccount extends HttpServlet {

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
            out.println("<title>Servlet EditAccount</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditAccount at " + request.getContextPath() + "</h1>");
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Users currentUser = (Users) session.getAttribute("user");

        // Kiểm tra nếu người dùng chưa đăng nhập
        if (currentUser == null) {
            response.sendRedirect("Login");
            return;
        }

        // Lấy thông tin từ form
        String idCard = request.getParameter("idCard");
        String roleIdStr = request.getParameter("roleId");

        try {
            // Chuyển đổi roleId từ String sang int
            int roleId = Integer.parseInt(roleIdStr);

            // Tạo object Users chỉ với thông tin cần thiết
            Users userToUpdate = new Users();
            userToUpdate.setIDCard(idCard);
            userToUpdate.setRoleID(roleId);

            // Gọi UserDAO để cập nhật role
            boolean isUpdated = UserDAO.updateRole(userToUpdate);

            if (isUpdated) {
                session.setAttribute("success", "User role updated successfully!");

                // Nếu cập nhật role của chính người dùng hiện tại
                if (currentUser.getIDCard().equals(idCard)) {
                    currentUser.setRoleID(roleId);
                    session.setAttribute("user", currentUser);
                }
            } else {
                session.setAttribute("error", "Failed to update user role!");
            }

        } catch (NumberFormatException e) {
            session.setAttribute("error", "Invalid role ID format!");
        } catch (Exception e) {
            session.setAttribute("error", "An error occurred: " + e.getMessage());
            e.printStackTrace();
        }

        // Redirect về trang quản lý tài khoản
         RequestDispatcher rs = request.getRequestDispatcher("view/list_account.jsp");
                rs.forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet for updating user role";
    }
}
