/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.RequestDAO;
import model.Account;
import model.RequestDTO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;

/**
 *
 * @author quang
 */
public class RequestMNM extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession();
        Account account = (Account) session.getAttribute("account");
        if (account == null) {
            resp.sendRedirect("login");
        } else if (account.getRoleId() == 3) {
            req.getRequestDispatcher("Employee.jsp").forward(req, resp);

        }
        RequestDAO dao = new RequestDAO();
        List<RequestDTO> requestList = dao.getRequestbyManagerID(account.getEmployeeId());
        req.setAttribute("requests", requestList);
        req.getRequestDispatcher("ViewMNM.jsp").forward(req, resp);

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
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");

        // 2. Lấy tham số từ form
        String sst = request.getParameter("status");  // "Approve" hoặc "Reject"
        String Id = request.getParameter("Id");

        // 3. Kiểm tra và xử lý
        if (sst != null && Id != null) {
            int id = Integer.parseInt(Id);

            // Gọi DAO cập nhật status
            RequestDAO dao = new RequestDAO();
            if ("Approve".equalsIgnoreCase(sst)) {
                dao.UpdateStatusRequest("Approved", id);
            } else if ("Reject".equalsIgnoreCase(sst)) {
                dao.UpdateStatusRequest("Rejected", id);
            }
        }

        // 4. Quay lại doGet để load danh sách mới
        response.sendRedirect("Management");

    }

}
