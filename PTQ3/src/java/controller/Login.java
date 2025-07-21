/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

public class Login extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String n = request.getParameter("username");
        
        HttpSession session = request.getSession();
        session.setAttribute("uname", n);
        ServletContext ctx = getServletContext(); // retrieving data from ServletContext object
        int t = (Integer) ctx.getAttribute("totalusers");
        int c = (Integer) ctx.getAttribute("currentusers");
        
        out.println("<!DOCTYPE html>");
        out.println("<html>");
        out.println("<head>");
        out.println("<title>Welcome</title>");
        out.println("<meta charset='UTF-8'>");
        out.println("<style>");
        out.println("body { font-family: Arial, sans-serif; margin: 40px; background-color: #f4f4f4; }");
        out.println(".container { background: white; padding: 20px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }");
        out.println("h1 { color: #333; }");
        out.println(".stats { background: #e8f5e8; padding: 15px; border-radius: 5px; margin: 20px 0; }");
        out.println("a { color: #007bff; text-decoration: none; }");
        out.println("a:hover { text-decoration: underline; }");
        out.println("</style>");
        out.println("</head>");
        out.println("<body>");
        out.println("<div class='container'>");
        out.println("<h1>Chào mừng " + n + "!</h1>");
        out.println("<div class='stats'>");
        out.println("<h3>Thống kê phiên làm việc:</h3>");
        out.println("<p><strong>Tổng số người dùng đã truy cập:</strong> " + t + "</p>");
        out.println("<p><strong>Số người dùng hiện tại:</strong> " + c + "</p>");
        out.println("</div>");
        out.println("<p><a href='Logout'>Đăng xuất</a></p>");
        out.println("<p><a href='sessionCounter.jsp'>Xem trang đếm phiên</a></p>");
        out.println("<p><a href='index.html'>Quay lại trang chủ</a></p>");
        out.println("</div>");
        out.println("</body>");
        out.println("</html>");
        
        out.close();
    }
}
