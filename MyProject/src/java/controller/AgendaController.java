
package controller;

import jakarta.servlet.annotation.WebServlet;

import dal.ScheduleDAO;
import model.AgendaDTO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "AgendaController", urlPatterns = {"/agenda"})
public class AgendaController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ScheduleDAO dao = new ScheduleDAO();
        List<AgendaDTO> agendaList = dao.getAllAgenda();
        request.setAttribute("agendaList", agendaList);
        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/Agenda.jsp");
        rd.forward(request, response);
    }
}
