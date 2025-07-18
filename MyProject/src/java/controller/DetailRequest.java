/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import dal.RequestDAO;
import model.Account;
import model.Request;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.time.DayOfWeek;
import java.util.List;

/**
 *
 * @author quang
 */
public class DetailRequest extends HttpServlet {

    protected void processRequest(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        processRequest(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Account account = (Account) session.getAttribute("account");
        if (account == null) {
            resp.sendRedirect("login");
            return;
        }
        // Lấy tham số id trên URL : detailRequest?id=1
        String ID = req.getParameter("id");
        System.out.println("Received ID: " + ID);
        if (ID == null || ID.isEmpty()) {
            // Nếu không có ID, chuyển hướng về trang chủ
            resp.sendRedirect("home");
            return;
        }

        int id = Integer.parseInt(ID);
        RequestDAO requestDAO = new RequestDAO();
        Request request = requestDAO.getOneReuestbyId(id, account.getEmployeeId());

        if (request == null) {
            //Nếu không tìm thấy đơn, quay về danh sách
            System.out.println("Error: Request not found for ID: " + id);
            resp.sendRedirect("home");
            return;
        }

        // đưa Request lên attribure "detail"
        req.setAttribute("detail", request);

        // Forward đến trang detail.jsp
        req.getRequestDispatcher("detail.jsp").forward(req, resp);
    }

}
