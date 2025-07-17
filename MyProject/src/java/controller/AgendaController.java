package controller;

import dal.EmployeeDAO;
import dal.RequestDAO;
import model.Account;
import model.Employee;
import model.Request;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.temporal.TemporalAdjusters;
import java.time.temporal.WeekFields;
import java.util.*;
import java.util.stream.Collectors;

public class AgendaController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp); // Gọi lại GET khi POST
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Account acc = (Account) session.getAttribute("account");
        if (acc == null) {
            resp.sendRedirect("Login.jsp");
            return;
        }

        // Lấy tuần và năm
        LocalDate now = LocalDate.now();
        String weekNumberParam = req.getParameter("weekNumber");
        String yearParam = req.getParameter("year");
        int currentWeek = now.get(WeekFields.of(Locale.getDefault()).weekOfYear());
        int currentYear = now.getYear();

        int weekNumber = (weekNumberParam != null && !weekNumberParam.trim().isEmpty())
                ? Integer.parseInt(weekNumberParam)
                : currentWeek;
        int year = (yearParam != null && !yearParam.trim().isEmpty())
                ? Integer.parseInt(yearParam)
                : currentYear;

        // Lấy danh sách nhân viên
        EmployeeDAO empDao = new EmployeeDAO();
        List<Employee> employees;
        if (acc.getRoleId() == 1) {
            employees = empDao.getAllEmployees(); // admin
        } else {
            Integer managerIdObj = (Integer) session.getAttribute("managerId");
            if (managerIdObj == null) {
                resp.sendRedirect("Login.jsp");
                return;
            }
            employees = empDao.getEmployeeByManagerId(managerIdObj);
        }

        // Lọc các request Approved
        RequestDAO reqDao = new RequestDAO();
        List<Request> allRequests = reqDao.getAllRequest();
        List<Request> filteredRequests = new ArrayList<>();

        for (Request request : allRequests) {
            if ("Approved".equalsIgnoreCase(request.getStatus())) {
                for (Employee emp : employees) {
                    if (request.getEmployeeId() == emp.getId()) {
                        filteredRequests.add(request);
                        break;
                    }
                }
            }
        }

        // Lấy ngày trong tuần
        List<LocalDate> fullWeekDays = getWeekDays(weekNumber, year);
        List<LocalDate> weekDays = fullWeekDays;

        String fromDateStr = req.getParameter("fromDate");
        String toDateStr = req.getParameter("toDate");
        if (fromDateStr != null && toDateStr != null && !fromDateStr.isEmpty() && !toDateStr.isEmpty()) {
            LocalDate fromDate = LocalDate.parse(fromDateStr);
            LocalDate toDate = LocalDate.parse(toDateStr);
            weekDays = fullWeekDays.stream()
                    .filter(d -> !d.isBefore(fromDate) && !d.isAfter(toDate))
                    .collect(Collectors.toList());
            req.setAttribute("fromDate", fromDateStr);
            req.setAttribute("toDate", toDateStr);
        }

        // Tạo map theo dõi trạng thái đi làm/nghỉ
        Map<Integer, Map<LocalDate, String>> attendanceMap = new HashMap<>();
        for (Employee emp : employees) {
            Map<LocalDate, String> dailyStatus = new HashMap<>();
            for (LocalDate d : fullWeekDays) {
                dailyStatus.put(d, "V"); // V: đi làm
            }

            for (Request request : filteredRequests) {
                if (request.getEmployeeId() == emp.getId()) {
                    LocalDate reqFrom = request.getDateFrom().toLocalDate();
                    LocalDate reqTo = request.getDateTo().toLocalDate();
                    for (LocalDate d : fullWeekDays) {
                        if (!d.isBefore(reqFrom) && !d.isAfter(reqTo)) {
                            dailyStatus.put(d, "X"); // X: nghỉ
                        }
                    }
                }
            }
            attendanceMap.put(emp.getId(), dailyStatus);
        }

        // Truyền dữ liệu cho JSP
        req.setAttribute("employees", employees);
        req.setAttribute("weekDays", weekDays);
        req.setAttribute("attendanceMap", attendanceMap);
        req.setAttribute("weekNumber", weekNumber);
        req.setAttribute("year", year);

        req.getRequestDispatcher("Agenda.jsp").forward(req, resp);
    }

    // ✅ Hàm tính ngày trong tuần từ số tuần + năm
    private List<LocalDate> getWeekDays(int weekNumber, int year) {
        LocalDate firstDayOfYear = LocalDate.of(year, 1, 1);
        LocalDate firstMonday = firstDayOfYear.with(TemporalAdjusters.nextOrSame(DayOfWeek.MONDAY));
        LocalDate weekStart = firstMonday.plusWeeks(weekNumber - 1);
        List<LocalDate> days = new ArrayList<>();
        for (int i = 0; i < 7; i++) {
            days.add(weekStart.plusDays(i));
        }
        return days;
    }
}
