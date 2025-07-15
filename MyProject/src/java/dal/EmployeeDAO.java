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


public class EmployeeDAO extends DBContext {

    DBContext db = new DBContext();

    public List<Employee> getEmployeeByManagerId(int ManagerId) {
        List<Employee> list = new ArrayList<>();
        String sql = "select * from Employee where Parentemployee=? ";
        try {
            PreparedStatement st = db.connection.prepareStatement(sql);
            st.setInt(1, ManagerId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Employee e = new Employee();
                e.setId(rs.getInt(1));
                e.setName(rs.getString(2));
                e.setDob(rs.getDate(3));
                e.setEmail(rs.getString(4));
                e.setPhone(rs.getString(5));
                e.setParentemployee(rs.getInt(6));
                list.add(e);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Employee> getAllEmployees() {
        List<Employee> list = new ArrayList<>();
        String sql = "SELECT * FROM Employee";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Employee e = new Employee();
                e.setId(rs.getInt("Id"));
                e.setName(rs.getString("Name"));
                e.setDob(rs.getDate("Dob"));
                e.setEmail(rs.getString("Email"));
                e.setPhone(rs.getString("Phone"));
                e.setParentemployee(rs.getInt("Parentemployee"));
                list.add(e);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<AgendaDTO> getAgendaByEmployeeId(int employeeId, Date dateFrom, Date dateTo) {
        List<AgendaDTO> agendaList = new ArrayList<>();
        RequestDAO requestDAO = new RequestDAO();
        // 1. Lấy thông tin Employee
        String sqlEmp = "SELECT Id, Name FROM Employee WHERE Parentemployee = ?";
        try {
            PreparedStatement stEmp = db.connection.prepareStatement(sqlEmp);
            stEmp.setInt(1, employeeId);
            ResultSet rsEmp = stEmp.executeQuery();
            if (rsEmp.next()) {
                AgendaDTO agenda = new AgendaDTO();
                agenda = new AgendaDTO();
                agenda.seteId(rsEmp.getInt("Id"));
                agenda.seteName(rsEmp.getString("Name"));
                agenda.setRequests(getAgendabyEmpolyeeId(rsEmp.getInt("Id"), dateFrom, dateTo));
                agendaList.add(agenda);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        if (agendaList == null) {
            // Không tìm thấy employee, trả về null hoặc xử lý theo yêu cầu
            return null;
        }
        // 2. Lấy danh sách RequestDTO của employee trong khoảng thời gian và có status = 'Approved'

        return agendaList;
    }

    private List<RequestDTO> getAgendabyEmpolyeeId(int employeeId, Date dateFrom, Date dateTo) {
        List<RequestDTO> requestList = new ArrayList<>();
        String sqlReq = "SELECT r.Id, r.DateCreate, r.DateFrom, r.DateTo, r.Reason, r.Status "
                + "FROM Request r "
                + "WHERE r.EmployeeId = ? "
                + "  AND r.Status = 'Approved' "
                + "  AND r.DateFrom >= ? "
                + "  AND r.DateTo <= ?";
        try {
            PreparedStatement stReq = db.connection.prepareStatement(sqlReq);
            stReq.setInt(1, employeeId);
            stReq.setDate(2, dateFrom);
            stReq.setDate(3, dateTo);
            ResultSet rsReq = stReq.executeQuery();
            while (rsReq.next()) {
                RequestDTO req = new RequestDTO();
                req.setId(rsReq.getInt("Id"));
                req.setDateCreate(rsReq.getDate("DateCreate"));
                req.setDateFrom(rsReq.getDate("DateFrom"));
                req.setDateTo(rsReq.getDate("DateTo"));
                req.setReason(rsReq.getString("Reason"));
                req.setStatus(rsReq.getString("Status"));
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
        Date dateFrom = Date.valueOf("2025-03-24");
        Date dateTo = Date.valueOf("2025-04-15");

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
