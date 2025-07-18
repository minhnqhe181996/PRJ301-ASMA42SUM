package controller;

import model.Account;
import dal.RequestDAO;
import model.Account;
import model.Request;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class RequestController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Kiểm tra đăng nhập
        HttpSession session = req.getSession();
        Account acc = (Account) session.getAttribute("account");
        if (acc == null) {
            resp.sendRedirect("Login.jsp");
            return;
        }

        // Nhận dữ liệu từ form
        String DateFrom = req.getParameter("fromDate");
        String DateTo = req.getParameter("toDate");
        String Reason = req.getParameter("reason");

        List<String> error = new ArrayList<>();
        if (Reason == null || DateTo == null || DateFrom == null) {
            error.add("Dữ liệu không hợp lệ, vui lòng kiểm tra lại.");
            req.getRequestDispatcher("Form.jsp").forward(req, resp);
        }
        Date datefrom = Date.valueOf(DateFrom);
        Date dateto = Date.valueOf(DateTo);
        Date now = Date.valueOf(LocalDate.now());

        // Nếu không có lỗi về chuỗi rỗng thì tiếp tục kiểm tra ngày
        if (datefrom.after(dateto)) {
            error.add("Ngày bắt đầu nghỉ không thể sau ngày kết thúc nghỉ.");

        }
        if (dateto.before(now)) {
            error.add("Ngày kết thúc nghỉ không thể là quá khứ.");

        }
        if (datefrom.before(now)) {
            error.add("Ngày bắt đầu nghỉ không thể là quá khứ.");

        }
        if (dateto.before(datefrom)) {
            error.add("Ngày kết thúc nghỉ không thể trước ngày bắt đầu nghỉ.");
        }
        if (!error.isEmpty()) {
            req.setAttribute("error", error);
            req.getRequestDispatcher("Form.jsp").forward(req, resp);

        } else {
            RequestDAO requestdao = new RequestDAO();
            Request re = new Request(0, acc.getEmployeeId(), dateto, datefrom, now, Reason, "Pending");
            requestdao.insert(re);
            resp.sendRedirect("Home");
        }

    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.sendRedirect("Form.jsp"); // Có thể chuyển hướng hoặc chưa dùng
    }

}
