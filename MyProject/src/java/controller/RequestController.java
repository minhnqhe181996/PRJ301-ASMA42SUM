package controller;

import dal.RequestDAO;
import model.Request;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Date;

public class RequestController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int employeeId = Integer.parseInt(request.getParameter("employeeId"));
        Date dateFrom = Date.valueOf(request.getParameter("dateFrom"));
        Date dateTo = Date.valueOf(request.getParameter("dateTo"));
        String reason = request.getParameter("reason");
        String status = "Pending";
        Request req = new Request(0, employeeId, dateTo, dateFrom, new Date(System.currentTimeMillis()), reason, status);
        RequestDAO dao = new RequestDAO();
        dao.insert(req);
        response.sendRedirect("RequestViewController"); // Redirect to view after insert
    }
}
