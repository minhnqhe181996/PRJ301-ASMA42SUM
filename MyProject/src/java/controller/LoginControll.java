package controller;

import dal.AccountDAO;
import model.Account;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class LoginControll extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        AccountDAO accountDAO = new AccountDAO();
        Account account = accountDAO.validateUser(username, password);
        if (account != null) {
            // Successful login
            HttpSession session = request.getSession();
            session.setAttribute("account", account);
            response.sendRedirect("home.jsp"); // Redirect to home page or dashboard
        } else {
            // Failed login
            request.setAttribute("error", "Invalid username or password");
            RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
            rd.forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
        rd.forward(request, response);
    }
}
