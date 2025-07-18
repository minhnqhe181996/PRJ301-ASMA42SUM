/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import dal.AccountDAO;
import dal.DBContext;
import jakarta.servlet.http.HttpSession;
import java.io.PrintWriter;
import model.Account;
import java.sql.*;

/**
 *
 * @author quang
 */
public class HomeController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        processRequest(req, resp);

    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Kiểm tra đăng nhập từ session
        HttpSession session = req.getSession();
        Account acc = (Account) session.getAttribute("account");
        if (acc == null) {
            resp.sendRedirect("login");
        } else {
            switch (acc.getRoleId()) {
                case 1:
                    session.setAttribute("managerId", acc.getEmployeeId());
                    req.getRequestDispatcher("Admin.jsp").forward(req, resp);
                    break;
                case 2:
                    req.getRequestDispatcher("Management.jsp").forward(req, resp);
                    break;
                case 3:
                    req.getRequestDispatcher("Employee.jsp").forward(req, resp);
                    break;
            }
        }

    }

    protected void processRequest(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = resp.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet HomeController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet HomeController at " + req.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }
}
