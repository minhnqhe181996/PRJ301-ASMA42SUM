package controller;

import dal.RequestDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class DeleteRequest extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        RequestDAO dao = new RequestDAO();
        if (request.getParameter("id") == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing id parameter");
            return;
        }
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            dao.DeleteById(id);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid id format");
            return;
        }
        dao.DeleteById(id);
        response.sendRedirect("RequestViewController");
    }
}
