/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.HouseholdDAO;
import dao.HouseholdMembersDAO;
import dao.NotificationDAO;
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
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import model.HouseholdMembers;
import model.Households;
import model.Registrations;
import model.Users;

/**
 *
 * @author LENOVO
 */
public class PermanentRegistrationProcess extends HttpServlet {

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
            out.println("<title>Servlet PermanentRegistrationProcess</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet PermanentRegistrationProcess at " + request.getContextPath() + "</h1>");
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
    private static final SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Users user = (Users) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("Login");
            return;
        }

        ArrayList<Registrations> pendingRequests = RegistrationsDAO.getPendingRegistrations();
        ArrayList<Registrations> filteredList = filterRegistrationsByUser(user, pendingRequests);
        request.setAttribute("pendingRequests", filteredList);
        RequestDispatcher rs = request.getRequestDispatcher("view/permanentRegistrationProcess.jsp");
        rs.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Users user = (Users) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("Login");
            return;
        }

        String action = request.getParameter("action");
        response.setContentType("text/plain;charset=UTF-8");
        PrintWriter out = response.getWriter();

        if ("verifyCitizen".equals(action)) {
            verifyCitizen(request, response, user, out);
        } else if ("approve".equals(action)) {
            approveRequest(request, response, user, out);
        } else if ("reject".equals(action)) {
            rejectRequest(request, response, user, out);
        } else {
            out.write("Invalid action");
        }
    }

    private void verifyCitizen(HttpServletRequest request, HttpServletResponse response, Users user, PrintWriter out)
            throws ServletException, IOException {
        String idCard = request.getParameter("idCard");
        Users citizen = UserDAO.getUserByIDCard(idCard);
        ArrayList<Registrations> citizenRequests = RegistrationsDAO.getRegistrationsByIDCard(idCard);
        ArrayList<HouseholdMembers> householdMembers = HouseholdMembersDAO.getHouseholdMembersByIDCard(idCard);

        if (citizen == null) {
            request.setAttribute("verifyResult", "Citizen not found in Users table.");
        } else {
            StringBuilder result = new StringBuilder("Citizen found: " + citizen.getFirstName() + " " + citizen.getLastName());

            // Kiểm tra thông tin hộ khẩu
            result.append("<br><strong>Household Information:</strong>");
            if (householdMembers.isEmpty()) {
                result.append("<br>No household found for this citizen.");
            } else {
                result.append("<ul>");
                for (HouseholdMembers member : householdMembers) {
                    Households household = HouseholdDAO.getHouseholdById(member.getHouseholdID());
                    Users headOfHousehold = UserDAO.getUserByIDCard(household.getHeadOfHouseholdID());
                    String headName = (headOfHousehold != null)
                            ? headOfHousehold.getFirstName() + " " + headOfHousehold.getLastName()
                            : "Unknown";
                    String headCity = (headOfHousehold != null && headOfHousehold.getCity() != null)
                            ? headOfHousehold.getCity()
                            : "Not specified";

                    result.append("<li>")
                            .append("Household ID: ").append(household.getHouseholdID())
                            .append(", Head of Household ID: ").append(household.getHeadOfHouseholdID())
                            .append(" (Name: ").append(headName).append(")")
                            .append(", City: ").append(headCity)
                            .append(", Relationship: ").append(member.getRelationship())
                            .append(", Address: ").append(household.getAddress())
                            .append(", Created Date: ").append(household.getCreatedDate() != null ? DATE_FORMAT.format(household.getCreatedDate()) : "N/A")
                            .append("</li>");
                }
                result.append("</ul>");
            }

            // Hiển thị thông tin yêu cầu đăng ký
            result.append("<br><strong>Pending Requests:</strong>");
            if (citizenRequests.isEmpty()) {
                result.append("<br>No registration requests found.");
            } else {
                result.append("<ul>");
                for (Registrations reg : citizenRequests) {
                    if ("Pending".equals(reg.getStatus())) {
                        Users headOfHousehold = UserDAO.getUserByIDCard(reg.getHeadOfHouseholdID());
                        String headOfHouseholdInfo = (headOfHousehold != null)
                                ? headOfHousehold.getFirstName() + " " + headOfHousehold.getLastName()
                                : "Not found in Users table";
                        String headCity = (headOfHousehold != null && headOfHousehold.getCity() != null)
                                ? headOfHousehold.getCity()
                                : "Not specified";

                        result.append("<li>")
                                .append("ID: ").append(reg.getRegistrationID())
                                .append(", Type: ").append(reg.getRegistrationType())
                                .append(", Start Date: ").append(reg.getStartDate() != null ? DATE_FORMAT.format(reg.getStartDate()) : "N/A")
                                .append(", End Date: ").append(reg.getEndDate() != null ? DATE_FORMAT.format(reg.getEndDate()) : "N/A")
                                .append(", Status: ").append(reg.getStatus())
                                .append(", Address: ").append(reg.getAddress())
                                .append(", City: ").append(reg.getCity() != null ? reg.getCity() : "Not specified")
                                .append(", Relationship: ").append(reg.getRelationship())
                                .append(", Head of Household ID: ").append(reg.getHeadOfHouseholdID())
                                .append(" (Name: ").append(headOfHouseholdInfo).append(")")
                                .append(", Head of Household City: ").append(headCity)
                                .append(", Approved By: ").append(reg.getApprovedBy() != null ? reg.getApprovedBy() : "N/A")
                                .append(", Comments: ").append(reg.getComments() != null ? reg.getComments() : "N/A")
                                .append(", Created Date: ").append(reg.getCreatedDate() != null ? DATE_FORMAT.format(reg.getCreatedDate()) : "N/A")
                                .append("</li>");

                        // So sánh thành phố đăng ký với thành phố của chủ hộ
                        if ("Permanent".equals(reg.getRegistrationType()) && !reg.getIDCard().equals(reg.getHeadOfHouseholdID())) {
                            if (reg.getCity() != null && headCity != null && !reg.getCity().equals(headCity)) {
                                result.append("<span style='color: red;'>Warning: Registration city (")
                                        .append(reg.getCity())
                                        .append(") does not match Head of Household's city (")
                                        .append(headCity)
                                        .append(")</span>");
                            } else if (reg.getCity() == null || headCity == null) {
                                result.append("<span style='color: orange;'>Warning: Missing city information for comparison</span>");
                            } else {
                                result.append("<span style='color: green;'>Note: Registration city matches Head of Household's city</span>");
                            }
                        }
                    }
                }
                result.append("</ul>");
            }

            request.setAttribute("verifyResult", result.toString());
        }
        doGet(request, response);
    }

    private void approveRequest(HttpServletRequest request, HttpServletResponse response, Users user, PrintWriter out) {
        String registrationId = request.getParameter("registrationId");
        try {
            int regId = Integer.parseInt(registrationId);
            Registrations reg = RegistrationsDAO.getRegistrationById(regId);
            if (reg == null || !reg.getStatus().equals("Pending")) {
                out.write("Invalid or non-pending registration");
                return;
            }
            if (user.getRoleID() == 2 && !reg.getCity().equals(user.getCity())) {
                out.write("You can only approve registrations in your city");
                return;
            }

            Users citizen = UserDAO.getUserByIDCard(reg.getIDCard());
            if (citizen == null) {
                out.write("Citizen not found in Users table");
                return;
            }

            Users headOfHousehold = UserDAO.getUserByIDCard(reg.getHeadOfHouseholdID());
            if (headOfHousehold == null && !reg.getIDCard().equals(reg.getHeadOfHouseholdID())) {
                out.write("Head of Household not found in Users table");
                return;
            }

            // Kiểm tra thành phố đăng ký mới với thành phố của chủ hộ (nếu không phải chủ hộ)
            if ("Permanent".equals(reg.getRegistrationType()) && !reg.getIDCard().equals(reg.getHeadOfHouseholdID())) {
                if (reg.getCity() == null || headOfHousehold.getCity() == null) {
                    out.write("City information is missing for citizen or head of household");
                    return;
                }
                if (!reg.getCity().equals(headOfHousehold.getCity())) {
                    out.write("The registration city (" + reg.getCity()
                            + ") does not match the Head of Household's city (" + headOfHousehold.getCity() + ")");
                    return;
                }
            }

            if (reg.getAddress() == null || reg.getAddress().trim().isEmpty()) {
                out.write("Address is missing in registration");
                return;
            }

            if ("Permanent".equals(reg.getRegistrationType())) {
                if (reg.getIDCard().equals(reg.getHeadOfHouseholdID())) {
                    Households existingHousehold = HouseholdDAO.getHouseholdByAddress(reg.getAddress());
                    if (existingHousehold != null && !existingHousehold.getHeadOfHouseholdID().equals(reg.getIDCard())) {
                        out.write("This address is already registered by another household (HouseholdID: " + existingHousehold.getHouseholdID() + ")");
                        return;
                    }
                } else {
                    Households household = HouseholdDAO.getHouseholdByHeadID(reg.getHeadOfHouseholdID());
                    if (household != null && !household.getAddress().equals(reg.getAddress())) {
                        out.write("Address does not match the Head of Household's registered address: " + household.getAddress());
                        return;
                    }
                }
            }

            Registrations updatedReg = RegistrationsDAO.updateRegistrationStatus(
                    new Registrations(regId, "Approved", user.getIDCard()));
            if (updatedReg != null) {
                if ("Permanent".equals(reg.getRegistrationType())) {
                    // Cập nhật địa chỉ và thành phố cho người đăng ký
                    UserDAO.updateUserAddressAndCity(reg.getIDCard(), reg.getAddress(), reg.getCity());
                    RegistrationsDAO.updateHouseholdOnPermanentRegistration(regId);

                    // Nếu người đăng ký là chủ hộ, cập nhật cho tất cả thành viên trong hộ
                    if (reg.getIDCard().equals(reg.getHeadOfHouseholdID())) {
                        Households household = HouseholdDAO.getHouseholdByHeadID(reg.getHeadOfHouseholdID());
                        if (household != null) {
                            ArrayList<HouseholdMembers> members = HouseholdMembersDAO.getHouseholdMembersByHouseholdID(household.getHouseholdID());
                            for (HouseholdMembers member : members) {
                                // Cập nhật địa chỉ và thành phố cho từng thành viên
                                UserDAO.updateUserAddressAndCity(member.getIDCard(), reg.getAddress(), reg.getCity());
                                // Gửi thông báo cho thành viên
                                NotificationDAO.addNotification(member.getIDCard(),
                                        "Your residence address and city have been updated to " + reg.getAddress() + ", " + reg.getCity()
                                        + " due to the head of household's permanent registration approval.");
                            }
                        }
                    }
                }
                NotificationDAO.addNotification(reg.getIDCard(), "Your " + reg.getRegistrationType().toLowerCase() + " residence registration has been approved.");
                out.write("success");
            } else {
                out.write("Failed to approve");
            }
        } catch (Exception e) {
            out.write("Error: " + e.getMessage());
        }
    }

    private void rejectRequest(HttpServletRequest request, HttpServletResponse response, Users user, PrintWriter out) {
        String registrationId = request.getParameter("registrationId");
        String comments = request.getParameter("comments");
        try {
            int regId = Integer.parseInt(registrationId);
            Registrations reg = RegistrationsDAO.getRegistrationById(regId);
            if (reg == null || !reg.getStatus().equals("Pending")) {
                out.write("Invalid or non-pending registration");
                return;
            }
            if (user.getRoleID() == 2 && !reg.getCity().equals(user.getCity())) {
                out.write("You can only reject registrations in your city");
                return;
            }

            Registrations updatedReg = RegistrationsDAO.updateRegistrationStatusWithComments(
                    new Registrations(regId, "Rejected", user.getIDCard()), comments);
            if (updatedReg != null) {
                NotificationDAO.addNotification(reg.getIDCard(), "Your " + reg.getRegistrationType().toLowerCase() + " residence registration was rejected. Reason: " + comments);
                out.write("success");
            } else {
                out.write("Failed to reject");
            }
        } catch (Exception e) {
            out.write("Error: " + e.getMessage());
        }
    }

    private ArrayList<Registrations> filterRegistrationsByUser(Users user, ArrayList<Registrations> fullList) {
        ArrayList<Registrations> filteredList = new ArrayList<>();
        if (user.getRoleID() == 3) { // Admin sees all
            filteredList = fullList;
        } else if (user.getRoleID() == 2) { // Police sees only their city
            String userCity = user.getCity();
            for (Registrations reg : fullList) {
                if (reg.getCity() != null && reg.getCity().equals(userCity)) {
                    filteredList.add(reg);
                }
            }
        }
        return filteredList;
    }
}
