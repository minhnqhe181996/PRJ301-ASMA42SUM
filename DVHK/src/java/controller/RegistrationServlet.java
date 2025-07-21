/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.RegistrationsDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import model.Registrations;
import model.Users;

/**
 *
 * @author LENOVO
 */
public class RegistrationServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet RegistrationServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RegistrationServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //processRequest(request, response);
        HttpSession session = request.getSession();
        Users user = (Users) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("Login");
        } else {
            response.setContentType("text/html;charset=UTF-8");
            String action = request.getParameter("action");
            if (action == null) {
                RequestDispatcher rs = request.getRequestDispatcher("view/trang_user.jsp");
                rs.forward(request, response);
            } else if (action.equals("formtr")) {

                RequestDispatcher rs = request.getRequestDispatcher("view/formdk_tr.jsp");
                rs.forward(request, response);
            } else if (action.equals("formpr")) {

                RequestDispatcher rs = request.getRequestDispatcher("view/formdk_pr.jsp");
                rs.forward(request, response);
            } else if (action.equals("formlt")) {
                RequestDispatcher rs = request.getRequestDispatcher("view/formkb_lt.jsp");
                rs.forward(request, response);

            }

        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        // Lấy các tham số từ form
        String idCard = request.getParameter("id");
        String registrationType = request.getParameter("registerType");
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");
        String relationship = request.getParameter("relationship");
        String headOfHousehold = request.getParameter("headOfHousehold");
        String city = request.getParameter("city");
        String address = request.getParameter("address");
        String comments = request.getParameter("comment");
        String action = request.getParameter("action");

        // Xác định trang tiếp theo dựa trên action
        String nextPage;
        switch (action != null ? action : "") {
            case "thuong":
                nextPage = "view/formdk_pr.jsp";
                break;
            case "tam":
                nextPage = "view/formdk_tr.jsp";
                break;
            case "luu":
                nextPage = "view/formdk_lt.jsp";
                break;
            default:
                request.setAttribute("error", "Invalid action type");
                nextPage = "view/formdk_pr.jsp";
                forwardToPage(request, response, nextPage);
                return;
        }

        // Kiểm tra các tham số bắt buộc
        if (idCard == null || idCard.trim().isEmpty()
                || registrationType == null || registrationType.trim().isEmpty()
                || startDate == null || startDate.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng điền đầy đủ các trường bắt buộc (CCCD, kiểu đăng ký, ngày bắt đầu)");
            forwardToPage(request, response, nextPage);
            return;
        }

        // Định dạng và kiểm tra ngày tháng
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        dateFormat.setLenient(false);
        java.sql.Date sqlStartDate;
        java.sql.Date sqlEndDate = null;

        try {
            sqlStartDate = new java.sql.Date(dateFormat.parse(startDate).getTime());

            // Kiểm tra ngày hiện tại (ngày bắt đầu không được trước ngày hiện tại)
            java.util.Date currentDate = new java.util.Date();
            if (sqlStartDate.before(currentDate)) {
                request.setAttribute("error", "Ngày bắt đầu không thể là ngày trong quá khứ");
                forwardToPage(request, response, nextPage);
                return;
            }

            // Xử lý ngày kết thúc nếu có
            if (endDate != null && !endDate.trim().isEmpty()) {
                sqlEndDate = new java.sql.Date(dateFormat.parse(endDate).getTime());
                if (sqlEndDate.before(sqlStartDate)) {
                    request.setAttribute("error", "Ngày kết thúc không thể trước ngày bắt đầu");
                    forwardToPage(request, response, nextPage);
                    return;
                }
            }
        } catch (ParseException ex) {
            request.setAttribute("error", "Định dạng ngày không hợp lệ. Vui lòng sử dụng định dạng yyyy-MM-dd");
            forwardToPage(request, response, nextPage);
            return;
        }

        // Tạo đối tượng Registrations và thêm vào cơ sở dữ liệu
        try {
            Registrations account = new Registrations(idCard, registrationType, sqlStartDate, sqlEndDate,
                    relationship, headOfHousehold, address, city, comments);
            account = RegistrationsDAO.addAccount(account);

            if (account != null) {
                request.setAttribute("account", account);
                request.setAttribute("success", "Đăng ký thành công!");
            } else {
                request.setAttribute("error", "Đã xảy ra lỗi khi đăng ký. Vui lòng thử lại.");
            }
        } catch (Exception e) {
            request.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
        }

        // Chuyển hướng về trang tương ứng
        forwardToPage(request, response, nextPage);
    }

    private void forwardToPage(HttpServletRequest request, HttpServletResponse response, String page)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher(page);
        dispatcher.forward(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
