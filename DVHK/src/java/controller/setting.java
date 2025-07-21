package controller;

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
import java.util.ArrayList;
import model.Registrations;
import model.Users;

public class setting extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Users user = (Users) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("Login");
            return;
        }

        response.setContentType("text/html;charset=UTF-8");
        ArrayList<Registrations> list = RegistrationsDAO.getRegistrations();
        String action = request.getParameter("action");
        String registrationId = request.getParameter("registrationId");

        // Lọc danh sách theo RoleID và City
        ArrayList<Registrations> filteredList = filterRegistrationsByUser(user, list);

        if (action == null) {
            request.setAttribute("list", filteredList);
            RequestDispatcher rs = request.getRequestDispatcher("view/registrationList.jsp");
            rs.forward(request, response);
        } else if ("reject".equals(action) && registrationId != null) {
            processReject(request, response, user, registrationId, filteredList);
        } else if ("delete".equals(action) && registrationId != null) {
            processDelete(request, response, user, registrationId, filteredList);
        }
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

        response.setContentType("text/plain;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String action = request.getParameter("action");

        if ("approve".equals(action)) {
            processApprove(request, response, user, out);
        } else if ("sendNotification".equals(action)) {
            processSendNotification(request, response, user, out);
        } else {
            out.write("Invalid request action.");
        }
    }

    private void processApprove(HttpServletRequest request, HttpServletResponse response, Users user, PrintWriter out) {
        String registrationId = request.getParameter("registrationId");
        String registrationType = request.getParameter("registrationType");

        if (registrationId == null || registrationType == null) {
            out.write("Invalid input: Registration ID or type is missing");
            return;
        }

        try {
            int regId = Integer.parseInt(registrationId);
            Registrations reg = RegistrationsDAO.getRegistrationById(regId);

            if (reg == null) {
                out.write("Registration not found for ID: " + regId);
                return;
            }

            if (user.getRoleID() == 2 && !reg.getCity().equals(user.getCity())) {
                out.write("You can only approve registrations in your city: " + user.getCity());
                return;
            }

            Registrations updatedReg = RegistrationsDAO.updateRegistrationStatus(
                    new Registrations(regId, "Approved", user.getIDCard()));
            if (updatedReg != null) {
                if ("Permanent".equalsIgnoreCase(registrationType)) {
                    if (reg.getAddress() == null || reg.getAddress().trim().isEmpty()
                            || reg.getCity() == null || reg.getCity().trim().isEmpty()) {
                        out.write("Address or City is missing in registration data");
                        return;
                    }

                    boolean userUpdated = UserDAO.updateUserAddressAndCity(
                            reg.getIDCard(), reg.getAddress(), reg.getCity());
                    if (!userUpdated) {
                        out.write("Failed to update user address and city");
                        return;
                    }

                    boolean householdUpdated = RegistrationsDAO.updateHouseholdOnPermanentRegistration(regId);
                    if (!householdUpdated) {
                        out.write("Failed to update household for Permanent registration");
                        return;
                    }
                }
                out.write("success");
            } else {
                out.write("Failed to approve registration ID: " + regId);
            }
        } catch (NumberFormatException e) {
            out.write("Invalid registration ID format: " + registrationId);
        } catch (Exception e) {
            out.write("Error approving registration: " + e.getMessage());
            e.printStackTrace();
        }
    }

    private void processSendNotification(HttpServletRequest request, HttpServletResponse response, Users user, PrintWriter out) {
        String registrationId = request.getParameter("registrationId");
        String message = request.getParameter("message");

        if (registrationId == null || message == null || message.trim().isEmpty()) {
            out.write("Invalid input: Registration ID or message is missing or empty");
            return;
        }

        try {
            int regId = Integer.parseInt(registrationId);
            Registrations reg = RegistrationsDAO.getRegistrationById(regId);

            if (reg == null) {
                out.write("Registration not found for ID: " + regId);
                return;
            }

            if (user.getRoleID() == 2 && !reg.getCity().equals(user.getCity())) {
                out.write("You can only send notifications for registrations in your city: " + user.getCity());
                return;
            }

            if (reg.getIDCard() == null || reg.getIDCard().trim().isEmpty()) {
                out.write("Invalid IDCard in registration data");
                return;
            }

            boolean success = NotificationDAO.addNotification(reg.getIDCard(), message);
            if (success) {
                out.write("success");
            } else {
                out.write("Failed to send notification to database");
            }
        } catch (NumberFormatException e) {
            out.write("Invalid registration ID format: " + registrationId);
        } catch (Exception e) {
            out.write("Error sending notification: " + e.getMessage());
            e.printStackTrace();
        }
    }

    private void processReject(HttpServletRequest request, HttpServletResponse response, Users user,
            String registrationId, ArrayList<Registrations> filteredList) throws ServletException, IOException {
        try {
            int regId = Integer.parseInt(registrationId);
            Registrations reg = RegistrationsDAO.getRegistrationById(regId);

            if (reg == null) {
                request.setAttribute("error", "Registration not found for ID: " + regId);
            } else if (user.getRoleID() == 2 && !reg.getCity().equals(user.getCity())) {
                request.setAttribute("error", "You can only reject registrations in your city: " + user.getCity());
            } else {
                Registrations updatedReg = RegistrationsDAO.updateRegistrationStatus(
                        new Registrations(regId, "Rejected", user.getIDCard()));
                if (updatedReg != null) {
                    filteredList = filterRegistrationsByUser(user, RegistrationsDAO.getRegistrations());
                } else {
                    request.setAttribute("error", "Failed to reject registration ID: " + regId);
                }
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid registration ID format: " + registrationId);
        }
        request.setAttribute("list", filteredList);
        RequestDispatcher rs = request.getRequestDispatcher("view/registrationList.jsp");
        rs.forward(request, response);
    }

    private void processDelete(HttpServletRequest request, HttpServletResponse response, Users user,
            String registrationId, ArrayList<Registrations> filteredList) throws ServletException, IOException {
        try {
            int regId = Integer.parseInt(registrationId);
            Registrations reg = RegistrationsDAO.getRegistrationById(regId);

            if (reg == null) {
                request.setAttribute("error", "Registration not found for ID: " + regId);
            } else if (user.getRoleID() == 2 && !reg.getCity().equals(user.getCity())) {
                request.setAttribute("error", "You can only delete registrations in your city: " + user.getCity());
            } else {
                boolean deleteSuccess = RegistrationsDAO.deleteRegistration(regId);
                if (deleteSuccess) {
                    filteredList = filterRegistrationsByUser(user, RegistrationsDAO.getRegistrations());
                } else {
                    request.setAttribute("error", "Failed to delete registration ID: " + regId);
                }
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid registration ID format: " + registrationId);
        }
        request.setAttribute("list", filteredList);
        RequestDispatcher rs = request.getRequestDispatcher("view/registrationList.jsp");
        rs.forward(request, response);
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

    @Override
    public String getServletInfo() {
        return "Handles registration settings, approvals, and notifications";
    }
}
