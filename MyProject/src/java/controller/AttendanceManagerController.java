package controller;

import dal.AttendanceDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.time.LocalDate;
import java.util.*;
import model.Account;
import model.Attendance;

@WebServlet(name = "AttendanceManagerController", urlPatterns = {"/attendance/manage"})
public class AttendanceManagerController extends HttpServlet {

	private AttendanceDAO dao = new AttendanceDAO();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Account acc = (Account) req.getSession().getAttribute("account");
		if (acc == null) {
			resp.sendRedirect("../login");
			return;
		}

		LocalDate from = req.getParameter("from") == null || req.getParameter("from").isEmpty()
				? LocalDate.now().minusDays(7)
				: LocalDate.parse(req.getParameter("from"));
		LocalDate to = req.getParameter("to") == null || req.getParameter("to").isEmpty()
				? LocalDate.now()
				: LocalDate.parse(req.getParameter("to"));

		try {
			List<Attendance> list = dao.listByManager(acc.getEmployeeId(), from, to);
			req.setAttribute("list", list);
			req.setAttribute("from", from);
			req.setAttribute("to", to);

			// Compute manager stats
			req.setAttribute("totalRecords", list == null ? 0 : list.size());
			int uniqueEmployees = (int) list.stream().map(Attendance::getEmployeeId).distinct().count();
			req.setAttribute("uniqueEmployees", uniqueEmployees);
			LocalDate today = LocalDate.now();
			int presentToday = (int) list.stream()
					.filter(a -> a.getWorkDate() != null)
					.filter(a -> a.getWorkDate().toInstant().atZone(java.time.ZoneId.systemDefault()).toLocalDate().equals(today))
					.filter(a -> a.getCheckIn() != null)
					.map(Attendance::getEmployeeId)
					.distinct()
					.count();
			req.setAttribute("presentToday", presentToday);

			// Average working hours (HH:mm) over records with both in/out
			long[] total = list.stream()
					.filter(a -> a.getCheckIn() != null && a.getCheckOut() != null)
					.mapToLong(a -> a.getCheckOut().getTime() - a.getCheckIn().getTime())
					.toArray();
			String avgWorkingHours = "0:00";
			if (total.length > 0) {
				long sum = 0L;
				for (long v : total) sum += v;
				long avgMs = sum / total.length;
				long totalSeconds = avgMs / 1000;
				long hours = totalSeconds / 3600;
				long minutes = (totalSeconds % 3600) / 60;
				avgWorkingHours = String.format("%02d:%02d", hours, minutes);
			}
			req.setAttribute("avgWorkingHours", avgWorkingHours);
		} catch (Exception e) {
			req.setAttribute("error", e.getMessage());
		}
		req.getRequestDispatcher("/AttendanceManage.jsp").forward(req, resp);
	}
}
