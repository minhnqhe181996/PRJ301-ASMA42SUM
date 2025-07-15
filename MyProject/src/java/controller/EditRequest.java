package controller;

import dal.RequestDAO;
import model.Request;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Date;

public class EditRequest extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        RequestDAO dao = new RequestDAO();
        Request req = dao.getRequestById(id); // Fixed method name
        request.setAttribute("request", req);
        RequestDispatcher rd = request.getRequestDispatcher("EditForm.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        int employeeId = Integer.parseInt(request.getParameter("employeeId"));
        Date dateFrom = Date.valueOf(request.getParameter("dateFrom"));
        Date dateTo = Date.valueOf(request.getParameter("dateTo"));
        String reason = request.getParameter("reason");
        String status = request.getParameter("status");
        Request req = new Request(id, employeeId, dateTo, dateFrom, new Date(System.currentTimeMillis()), reason, status);
        RequestDAO dao = new RequestDAO();
        dao.updateRequest(req); // Fixed method name
        response.sendRedirect("RequestViewController");
    }
}
