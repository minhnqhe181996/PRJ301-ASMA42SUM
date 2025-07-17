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
import model.Account;
import java.sql.*;
/**
 *
 * @author quang
 */
import jakarta.servlet.http.HttpSession;

public class LoginControll extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        String u = req.getParameter("username");
        String p = req.getParameter("password");

        AccountDAO accountDAO = new AccountDAO();
        Account acc = accountDAO.validateUser(u, p);

        if (acc == null) {
            resp.sendRedirect("Login.jsp?error=1");
        } else {
            HttpSession session = req.getSession();
            session.setAttribute("account", acc);
            resp.sendRedirect("Home");
        }

    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("Login.jsp").forward(req, resp);

    }

}
