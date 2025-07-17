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
public class LogoutController extends HttpServlet{

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
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
        super.doGet(req, resp); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/OverriddenMethodBody
    }
    

}
