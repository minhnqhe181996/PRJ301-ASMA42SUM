package controller;

import dal.RequestDAO;
import model.RequestDTO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class RequestMNM extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int managerId = Integer.parseInt(request.getParameter("managerId"));
        RequestDAO dao = new RequestDAO();
        List<RequestDTO> requests = dao.getRequestbyManagerID(managerId);
        request.setAttribute("requests", requests);
        RequestDispatcher rd = request.getRequestDispatcher("ManagerView.jsp");
        rd.forward(request, response);
    }
}
