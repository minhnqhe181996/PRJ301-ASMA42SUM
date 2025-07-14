/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import model.Account;
import model.AgendaDTO;
import model.Employee;
import model.Request;
import model.RequestDTO;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Date;


public class EmployeeDAO extends DBContext {

    public List<Employee> getEmployeeByManagerId(int ManagerId) {
        List<Employee> list = new ArrayList<>();
        String sql = "SELECT Id, Name, Dob, Email, Phone, ParentEmployee FROM Employee WHERE ParentEmployee=?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, ManagerId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Employee e = new Employee();
                e.setId(rs.getInt("Id"));
                e.setName(rs.getString("Name"));
                e.setDob(rs.getDate("Dob"));
                e.setEmail(rs.getString("Email"));
                e.setPhone(rs.getString("Phone"));
                e.setParentemployee(rs.getInt("ParentEmployee"));
                list.add(e);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Employee> getAllEmployees() {
        List<Employee> list = new ArrayList<>();
        String sql = "SELECT Id, Name, Dob, Email, Phone, ParentEmployee FROM Employee";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Employee e = new Employee();
                e.setId(rs.getInt("Id"));
                e.setName(rs.getString("Name"));
                e.setDob(rs.getDate("Dob"));
                e.setEmail(rs.getString("Email"));
                e.setPhone(rs.getString("Phone"));
                e.setParentemployee(rs.getInt("ParentEmployee"));
                list.add(e);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<AgendaDTO> getAgendaByEmployeeId(int employeeId, Date dateFrom, Date dateTo) {
        List<AgendaDTO> agendaList = new ArrayList<>();
        String sqlEmp = "SELECT Id, Name FROM Employee WHERE ParentEmployee = ?";
        try (PreparedStatement stEmp = connection.prepareStatement(sqlEmp)) {
            stEmp.setInt(1, employeeId);
            ResultSet rsEmp = stEmp.executeQuery();
            while (rsEmp.next()) {
                AgendaDTO agenda = new AgendaDTO();
                agenda.seteId(rsEmp.getInt("Id"));
                agenda.seteName(rsEmp.getString("Name"));
                agenda.setRequests(getAgendabyEmpolyeeId(rsEmp.getInt("Id"), dateFrom, dateTo));
                agendaList.add(agenda);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return agendaList;
    }

    private List<RequestDTO> getAgendabyEmpolyeeId(int employeeId, Date dateFrom, Date dateTo) {
        List<RequestDTO> requestList = new ArrayList<>();
        String sqlReq = "SELECT r.Id, r.DateCreate, r.DateFrom, r.DateTo, r.Reason, r.Status, r.EmployeeId, e.Name as eName "
                + "FROM Request r JOIN Employee e ON r.EmployeeId = e.Id "
                + "WHERE r.EmployeeId = ? AND r.Status = 'Approved' AND r.DateFrom >= ? AND r.DateTo <= ?";
        try (PreparedStatement stReq = connection.prepareStatement(sqlReq)) {
            stReq.setInt(1, employeeId);
            stReq.setDate(2, new java.sql.Date(dateFrom.getTime()));
            stReq.setDate(3, new java.sql.Date(dateTo.getTime()));
            ResultSet rsReq = stReq.executeQuery();
            while (rsReq.next()) {
                RequestDTO req = new RequestDTO();
                req.setId(rsReq.getInt("Id"));
                req.setDateCreate(rsReq.getDate("DateCreate"));
                req.setDateFrom(rsReq.getDate("DateFrom"));
                req.setDateTo(rsReq.getDate("DateTo"));
                req.setReason(rsReq.getString("Reason"));
                req.setStatus(rsReq.getString("Status"));
                req.seteId(rsReq.getInt("EmployeeId"));
                req.seteName(rsReq.getString("eName"));
                requestList.add(req);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return requestList;
    }

    public static void main(String[] args) {
        // Giả sử employeeId cần test là 1
        int employeeId = 1;
        // Thiết lập khoảng ngày test (định dạng: yyyy-MM-dd)
        java.sql.Date dateFrom = java.sql.Date.valueOf("2025-03-24");
        java.sql.Date dateTo = java.sql.Date.valueOf("2025-04-15");

        // Tạo đối tượng AgendaDAO (đảm bảo trong constructor có thiết lập kết nối DB)
        EmployeeDAO agendaDAO = new EmployeeDAO();

        // Gọi phương thức lấy AgendaDTO
        List<AgendaDTO> agendaList = agendaDAO.getAgendaByEmployeeId(employeeId, dateFrom, dateTo);
        for (AgendaDTO agenda : agendaList) {
            if (agenda != null) {
                System.out.println("Employee ID: " + agenda.geteId());
                System.out.println("Employee Name: " + agenda.geteName());
                System.out.println("Danh sách Request:");

                for (RequestDTO req : agenda.getRequests()) {
                    System.out.println("Request ID: " + req.getId());
                    System.out.println("Date Create: " + req.getDateCreate());
                    System.out.println("Date From: " + req.getDateFrom());
                    System.out.println("Date To: " + req.getDateTo());
                    System.out.println("Reason: " + req.getReason());
                    System.out.println("Status: " + req.getStatus());
                    System.out.println("--------------------------");

                    // Kiểm tra kết quả và in ra console
                }
            }
        }
    }
}
