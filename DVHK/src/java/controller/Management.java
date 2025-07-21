/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.HouseholdMembersDAO;
import dao.RegistrationsDAO;
import dao.UserDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import model.HouseholdMembers;
import model.Registrations;
import model.Users;

/**
 *
 * @author LENOVO
 */
public class Management extends HttpServlet {

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
            out.println("<title>Servlet Management</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Management at " + request.getContextPath() + "</h1>");
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

        String id = request.getParameter("id");
        if (user == null) {
            response.sendRedirect("Login");
        } else {
            response.setContentType("text/html;charset=UTF-8");
            ArrayList<Users> account = UserDAO.getUsers();
            ArrayList<Registrations> list = RegistrationsDAO.getRegistrations();
            String action = request.getParameter("action");

            if (action == null) {
                int roleId = user.getRoleID();
                String city = (roleId == 2) ? user.getCity() : null;
                System.out.println("User RoleID: " + roleId + ", City: " + city);
                int totalUsersCount = 0;
                int policeCount = 0; // Thêm biến cho số cảnh sát
                if (roleId == 3) {
                    totalUsersCount = UserDAO.getTotalUsersCount();
                    policeCount = UserDAO.getPoliceCount(); // Lấy tổng số cảnh sát
                } else if (roleId == 2) { // Police
                    totalUsersCount = UserDAO.getCitizenCountByCity(city);
                } else {
                    System.out.println("Unauthorized role: " + roleId);
                    response.sendRedirect("Unauthorized");
                    return;
                }

                int pendingUsersCount = RegistrationsDAO.getUniqueUsersByStatus("Pending", city);
                int processedUsersCount = RegistrationsDAO.getUniqueProcessedUsersCount(city);

                System.out.println("Pending Users: " + pendingUsersCount);
                System.out.println("Processed Users: " + processedUsersCount);

                request.setAttribute("totalUsersCount", totalUsersCount);
                request.setAttribute("pendingUsersCount", pendingUsersCount);
                request.setAttribute("processedUsersCount", processedUsersCount);
                request.setAttribute("policeCount", policeCount); // Thêm attribute cho số cảnh sát

                RequestDispatcher rs = request.getRequestDispatcher("view/trang_police.jsp");
                rs.forward(request, response);
            } else if (action.equals("viewpr")) {
                RequestDispatcher rs = request.getRequestDispatcher("view/profile.jsp");
                rs.forward(request, response);
            } else if (action.equals("table_citizen")) {
                int roleId = user.getRoleID();
                ArrayList<Users> citizenList = new ArrayList<>();
                ArrayList<Users> policeList = new ArrayList<>();
                ArrayList<Users> adminList = new ArrayList<>();

                if (roleId == 2) { // Police
                    String city = user.getCity();
                    for (Users u : account) {
                        if (u.getRoleID() == 1 && u.getCity().equals(city)) { // roleID = 1 là Citizen
                            citizenList.add(u);
                        }
                    }
                    System.out.println("Filtered citizens for Police in city " + city + ": " + citizenList.size());
                } else if (roleId == 3) { // Admin
                    for (Users u : account) {
                        if (u.getRoleID() == 1) { // Citizen
                            citizenList.add(u);
                        } else if (u.getRoleID() == 2) { // Police
                            policeList.add(u);
                        } else if (u.getRoleID() == 3) { // Admin
                            adminList.add(u);
                        }
                    }
                    System.out.println("Total citizens for Admin: " + citizenList.size());
                    System.out.println("Total police for Admin: " + policeList.size());
                    System.out.println("Total admins for Admin: " + adminList.size());
                } else {
                    response.sendRedirect("Unauthorized");
                    return;
                }

                request.setAttribute("citizenList", citizenList);
                request.setAttribute("policeList", policeList);
                request.setAttribute("adminList", adminList);
                RequestDispatcher rs = request.getRequestDispatcher("view/citizen_management.jsp");
                rs.forward(request, response);
            } else if (action.equals("relist")) {
                // Lọc danh sách đăng ký theo vai trò và City
                ArrayList<Registrations> filteredList = new ArrayList<>();
                if (user.getRoleID() == 3) { // Admin thấy tất cả
                    filteredList = list;
                } else if (user.getRoleID() == 2) { // Police chỉ thấy cùng City
                    String userCity = user.getCity();
                    for (Registrations reg : list) {
                        if (reg.getCity().equals(userCity)) {
                            filteredList.add(reg);
                        }
                    }
                }
                request.setAttribute("list", filteredList);
                RequestDispatcher rs = request.getRequestDispatcher("view/registrationList.jsp");
                rs.forward(request, response);
            } else if (action.equals("add")) {
                RequestDispatcher rs = request.getRequestDispatcher("view/add_user.jsp");
                rs.forward(request, response);
            } else if (action.equals("inf_user")) {
                RequestDispatcher rs = request.getRequestDispatcher("view/thongtin_user.jsp");
                rs.forward(request, response);
            } else if (action.equals("account")) {
                RequestDispatcher rs = request.getRequestDispatcher("view/list_account.jsp");
                rs.forward(request, response);

            } else if (action.equals("danhsach")) {

                HouseholdMembersDAO householdDAO = new HouseholdMembersDAO();
                List<HouseholdMembers> households;

                if (user.getRoleID() == 3) { // Admin (RoleID = 3)
                    households = householdDAO.getAllHouseholds(); // Admin xem tất cả
                } else if (user.getRoleID() == 2) { // Police (RoleID = 2)
                    households = householdDAO.getHouseholdsByCity(user.getCity()); // Cảnh sát chỉ xem theo thành phố
                } else {
                    response.sendRedirect("access-denied.jsp"); // Không có quyền truy cập
                    return;
                }

                // Đặt danh sách hộ khẩu vào request để JSP hiển thị
                request.setAttribute("households", households);
                RequestDispatcher rs = request.getRequestDispatcher("view/danhsachhk.jsp");
                rs.forward(request, response);

            } else if (action != null && action.equals("delete") && id != null) {
                try {
                    boolean isDeleted = UserDAO.deleteUser(id);
                    if (isDeleted) {
                        session.setAttribute("success", "Xóa người dùng có ID: " + id + " thành công!");
                    } else {
                        session.setAttribute("error", "Không thể xóa người dùng có ID: " + id);
                    }
                } catch (Exception e) {
                    session.setAttribute("error", "Lỗi khi xóa người dùng: " + e.getMessage());
                }
                request.getRequestDispatcher("view/list_account.jsp").forward(request, response);
                return;
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
        processRequest(request, response);
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
