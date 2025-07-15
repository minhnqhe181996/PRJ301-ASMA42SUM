package controller;

import dal.RequestDAO;
import model.Request;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class RequestViewController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("account") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        int employeeId = ((model.Account)session.getAttribute("account")).getEmployeeId();
        RequestDAO dao = new RequestDAO();
        List<Request> requests = dao.getRequestbyEmployeeId(employeeId);
        request.setAttribute("requests", requests);
        RequestDispatcher rd = request.getRequestDispatcher("View.jsp");
        rd.forward(request, response);
    }
}
