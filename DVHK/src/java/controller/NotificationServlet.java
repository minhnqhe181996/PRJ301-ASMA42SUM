/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.NotificationDAO;
import dao.RegistrationsDAO;
import dao.UserDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import model.Notifications;
import model.Registrations;
import model.Users;

/**
 *
 * @author LENOVO
 */
public class NotificationServlet extends HttpServlet {

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
            out.println("<title>Servlet NotificationServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet NotificationServlet at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession();
        Users user = (Users) session.getAttribute("user");

        // Kiểm tra xem người dùng đã đăng nhập chưa
        if (user == null) {
            response.sendRedirect("Login");
            return;
        }

        try {
            // Lấy danh sách thông báo cho người dùng hiện tại
            ArrayList<Notifications> notifications = NotificationDAO.getNotificationsByUser(user.getIDCard());
            request.setAttribute("notifications", notifications);
            ArrayList<Registrations> registrationses = RegistrationsDAO.getRegistrationForUser(user.getIDCard());
            request.setAttribute("list", registrationses);
            // Chuyển tiếp đến trang JSP hiển thị thông báo
            RequestDispatcher dispatcher = request.getRequestDispatcher("view/notification.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            // Xử lý lỗi nếu có
            request.setAttribute("error", "Đã xảy ra lỗi khi tải thông báo: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("view/notification.jsp");
            dispatcher.forward(request, response);
        }
    }

    /**
     * Xử lý yêu cầu POST để đánh dấu thông báo là đã đọc
     *
     * @param request
     * @param response
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Users user = (Users) session.getAttribute("user");

        // Kiểm tra xem người dùng đã đăng nhập chưa
        if (user == null) {
            response.sendRedirect("Login");
            return;
        }

        try {
            // Lấy ID thông báo từ request
            String notificationIdStr = request.getParameter("notificationId");
            if (notificationIdStr != null && !notificationIdStr.isEmpty()) {
                int notificationId = Integer.parseInt(notificationIdStr);

                // Cập nhật trạng thái thông báo
                boolean success = NotificationDAO.markAsRead(notificationId);

                if (!success) {
                    request.setAttribute("error", "Không thể đánh dấu thông báo là đã đọc");
                }
            } else {
                request.setAttribute("error", "ID thông báo không hợp lệ");
            }

            // Lấy lại danh sách thông báo mới nhất
            ArrayList<Notifications> notifications = NotificationDAO.getNotificationsByUser(user.getIDCard());
            request.setAttribute("notifications", notifications);
            ArrayList<Registrations> registrationses = RegistrationsDAO.getRegistrationForUser(user.getIDCard());
            request.setAttribute("list", registrationses);
            // Chuyển tiếp về trang thông báo
            RequestDispatcher dispatcher = request.getRequestDispatcher("view/notification.jsp");
            dispatcher.forward(request, response);

        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID thông báo không đúng định dạng");
            ArrayList<Notifications> notifications = NotificationDAO.getNotificationsByUser(user.getIDCard());
            request.setAttribute("notifications", notifications);
            RequestDispatcher dispatcher = request.getRequestDispatcher("view/notification.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Đã xảy ra lỗi: " + e.getMessage());
            ArrayList<Notifications> notifications = NotificationDAO.getNotificationsByUser(user.getIDCard());
            request.setAttribute("notifications", notifications);
            RequestDispatcher dispatcher = request.getRequestDispatcher("view/notification.jsp");
            dispatcher.forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet xử lý các yêu cầu liên quan đến thông báo người dùng";
    }
}
