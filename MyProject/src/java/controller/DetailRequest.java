package controller;

import dal.RequestDAO;
import model.Request;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class DetailRequest extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        RequestDAO dao = new RequestDAO();
        Request req = dao.getReuestbyId(id);
        request.setAttribute("request", req);
        RequestDispatcher rd = request.getRequestDispatcher("Detail.jsp");
        rd.forward(request, response);
    }
}
