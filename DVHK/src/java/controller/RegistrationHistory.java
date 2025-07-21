/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.RegistrationsDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import model.Registrations;
import model.Users;

/**
 *
 * @author LENOVO
 */
public class RegistrationHistory extends HttpServlet {

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
            out.println("<title>Servlet RegistrationHistory</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RegistrationHistory at " + request.getContextPath() + "</h1>");
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
            return;
        }

        // Lấy danh sách các đăng ký đã xử lý (Approved hoặc Rejected)
        ArrayList<Registrations> processedRegistrations = RegistrationsDAO.getProcessedRegistrations();
        ArrayList<Registrations> filteredList = filterRegistrationsByUser(user, processedRegistrations);

        request.setAttribute("processedRegistrations", filteredList);
        RequestDispatcher rs = request.getRequestDispatcher("view/registrationHistory.jsp");
        rs.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response); // Nếu có POST, xử lý giống GET
    }

    private ArrayList<Registrations> filterRegistrationsByUser(Users user, ArrayList<Registrations> fullList) {
        ArrayList<Registrations> filteredList = new ArrayList<>();
        if (user.getRoleID() == 3) { // Admin thấy tất cả
            filteredList = fullList;
        } else if (user.getRoleID() == 2) { // Police chỉ thấy của thành phố mình
            String userCity = user.getCity();
            for (Registrations reg : fullList) {
                if (reg.getCity() != null && reg.getCity().equals(userCity)) {
                    filteredList.add(reg);
                }
            }
        }
        return filteredList;
    }
}
