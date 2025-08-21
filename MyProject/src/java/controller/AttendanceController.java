package controller;

import dal.AttendanceDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import model.Account; // bạn đã có Account và lưu trong session khi login
import model.Attendance;

@WebServlet(name = "AttendanceController", urlPatterns = {"/attendance"})
public class AttendanceController extends HttpServlet {

	private AttendanceDAO dao = new AttendanceDAO();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Account acc = (Account) req.getSession().getAttribute("account");
		if (acc == null) {
			resp.sendRedirect("login");
			return;
		}
		try {
			Attendance today = dao.getByEmployeeAndDate(acc.getEmployeeId(), LocalDate.now());
			if (today != null) {
				req.setAttribute("checkinTime", today.getCheckIn());
				req.setAttribute("checkoutTime", today.getCheckOut());
				req.setAttribute("workingHours", today.getWorkingHours());
			}
		} catch (Exception ignored) {
		}
		req.getRequestDispatcher("Attendance.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Account acc = (Account) req.getSession().getAttribute("account"); // bạn đã set khi login
		if (acc == null) {
			resp.sendRedirect("login");
			return;
		}
		String action = req.getParameter("action"); // "in" hoặc "out"
		try {
			if ("in".equals(action)) {
				dao.checkIn(acc.getEmployeeId(), LocalDateTime.now(), req.getParameter("notes"));
				req.setAttribute("msg", "Checked in thành công!");
			} else if ("out".equals(action)) {
				dao.checkOut(acc.getEmployeeId(), LocalDateTime.now());
				req.setAttribute("msg", "Checked out thành công!");
			}
		} catch (Exception e) {
			req.setAttribute("error", e.getMessage());
		}
		doGet(req, resp);
	}
}
