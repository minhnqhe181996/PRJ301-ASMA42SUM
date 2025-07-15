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
import model.Account;
import java.sql.*;

/**
 *
 * @author quang
 */
public class HomeController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/OverriddenMethodBody
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Kiểm tra đăng nhập từ session
        HttpSession session = req.getSession(false);
        Account account = null;
        if (session != null) {
            account = (Account) session.getAttribute("account");
        }
        if (account == null) {
            resp.sendRedirect("Login.jsp");
            return;
        }
        // Điều hướng theo roleId
        int roleId = account.getRoleId();
        switch (roleId) {
            case 1:
                resp.sendRedirect("Admin.jsp");
                break;
            case 2:
                resp.sendRedirect("Management.jsp");
                break;
            case 3:
                resp.sendRedirect("Employee.jsp");
                break;
            default:
                resp.sendRedirect("Login.jsp");
                break;
        }

    }
}