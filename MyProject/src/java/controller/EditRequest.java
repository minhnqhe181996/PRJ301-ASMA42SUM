/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import dal.RequestDAO;
import model.Request;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Date;

/**
 *
 * @author quang
 */
public class EditRequest extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int ID = Integer.parseInt(req.getParameter("id"));
            String reason = req.getParameter("reason");
            String dateFrom = req.getParameter("dateFrom");
            String dateTo = req.getParameter("dateTo");
            // Date dateFromParsed = Date.valueOf(dateFrom);
            // Date dateToParsed = Date.valueOf(dateTo);

            // các thông tin khác nếu có
            Request updatedRequest = new Request();
            updatedRequest.setId(ID);
            updatedRequest.setReason(reason);
            updatedRequest.setDateFrom(Date.valueOf(dateFrom));
            updatedRequest.setDateTo(Date.valueOf(dateTo));

            // Set thêm các trương khác nếu cần
            RequestDAO requestDAO = new RequestDAO();
            requestDAO.updateRequest(updatedRequest);

            resp.sendRedirect("View"); // Chuyển hướng về trang danh sách yêu cầu
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String ID = req.getParameter("id");
        if (ID == null || ID.isEmpty()) {
            int id = Integer.parseInt(ID);
            RequestDAO requestDAO = new RequestDAO();
            Request request = requestDAO.getReuestbyId(id);
            req.setAttribute("request", request);
            req.getRequestDispatcher("EditFrom.jsp").forward(req, resp);
        } else {
            // Nếu không có ID, chuyển hướng về trang chủ   
            resp.sendRedirect("View");
        }
    }
}
