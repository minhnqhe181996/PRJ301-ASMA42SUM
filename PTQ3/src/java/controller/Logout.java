/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

public class Logout extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate(); // invalidating session
        }

        out.println("<!DOCTYPE html>");
        out.println("<html>");
        out.println("<head>");
        out.println("<title>Logout</title>");
        out.println("</head>");
        out.println("<body>");
        out.println("<h2>Bạn đã đăng xuất thành công!</h2>");
        out.println("<p><a href='index.html'>Quay lại trang chủ</a></p>");
        out.println("<p><a href='sessionCounter.jsp'>Xem số lượng phiên làm việc</a></p>");
        out.println("</body>");
        out.println("</html>");

        out.close();
    }
}
