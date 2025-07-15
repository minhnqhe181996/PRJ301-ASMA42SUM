package dal;

import model.Request;
import model.RequestDTO;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.sql.Date;

/**
 *
 * @author ADMIN
 */
public class RequestDAO extends DBContext {

    DBContext db = new DBContext();

    public List<Request> getAllRequest() {
        List<Request> list = new ArrayList<>();
        String sql = "select * from [Request]";
        try {

            PreparedStatement st = db.connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Request r = new Request();
                r.setId(rs.getInt(1));
                r.setEmployeeId(rs.getInt(2));
                r.setDateTo(rs.getDate(3));
                r.setDateFrom(rs.getDate(4));
                r.setDateCreate(rs.getDate(5));
                r.setReason(rs.getString(6));
                r.setStatus(rs.getString(7));

                list.add(r);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();

        }
        return list;
    }

//    public static void main(String[] args) {
//        RequestDAO requestDAO = new RequestDAO();
//        List<Request> list = requestDAO.getAllRequest();
//        for (Request request : list) {
//            System.out.println(request.toString());
//        }
//    }
    public int insert(Request request) {
        int result = -1;
        String sql = "INSERT INTO [dbo].[Request] ( [EmployeeId], [DateTo], [DateFrom], [DateCreate], [Reason], [Status]) "
                + "VALUES (?, ?, ?, ?, ?, ?)";
        // Sử dụng try-with-resources để tự động đóng PreparedStatement
        try (PreparedStatement st = db.connection.prepareStatement(sql)) {
            st.setInt(1, request.getEmployeeId());
            st.setDate(2, request.getDateTo());
            st.setDate(3, request.getDateFrom());
            st.setDate(4, request.getDateCreate());
            st.setString(5, request.getReason()); // Nếu đổi tên thuộc tính, thì đây thành getReason()
            st.setString(6, request.getStatus());
            result = st.executeUpdate();
        } catch (SQLException ex) {
            // Log lỗi để tiện debug
            ex.printStackTrace();
        }
        return result;
    }

    public int DeleteById(int Id) {
        int result = -1;
        String sql = "DELETE FROM Request WHERE Id = ?";
        try {
            PreparedStatement st = db.connection.prepareStatement(sql);
            st.setInt(1, Id);
            result = st.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();

        }
        return result;
    }

    public int Update(Request request) {
        int result = -1;
        String sql = "UPDATE [dbo].[Request]\n"
                + "      SET [EmployeeId] = ?\n"
                + "      ,[DateTo] = ?\n"
                + "      ,[DateFrom] = ?\n"
                + "      ,[DateCreate] = ?\n"
                + "      ,[Reason] = ?\n"
                + "      ,[Status] = ?\n"
                + " WHERE Id = ?";
        try {
            PreparedStatement st = db.connection.prepareStatement(sql);
            st.setInt(1, request.getEmployeeId());
            st.setDate(2, new java.sql.Date(request.getDateTo().getTime()));
            st.setDate(3, new java.sql.Date(request.getDateFrom().getTime()));
            st.setDate(4, new java.sql.Date(request.getDateCreate().getTime()));
            st.setString(5, request.getReason());
            st.setString(6, request.getStatus());
            st.setInt(7, request.getId());
            result = st.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();

        }
        return result;
    }

    public List<RequestDTO> getRequestbyManagerID(int managementId) {
        List<RequestDTO> list = new ArrayList<>();
        String sql = "select r.Id,r.DateCreate,r.DateFrom,r.DateTo,r.Reason,r.Status,e.Id,e.Name from Request r inner join Employee  e on r.EmployeeId = e.Id where e.Parentemployee =?";
        try {

            PreparedStatement st = db.connection.prepareStatement(sql);
            st.setInt(1, managementId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                RequestDTO r = new RequestDTO();
                r.setId(rs.getInt(1));
                r.setDateCreate(rs.getDate(2));
                r.setDateFrom(rs.getDate(3));
                r.setDateTo(rs.getDate(4));
                r.setReason(rs.getString(5));
                r.setStatus(rs.getString(6));
                r.seteId(rs.getInt(7));
                r.seteName(rs.getString(8));

                list.add(r);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();

        }
        return list;
    }
//    public static void main(String[] args) {
//        RequestDAO requestDAO=new RequestDAO();
//        List<RequestDTO> list=requestDAO.getRequestbyManagerID(1);
//        for (RequestDTO request : list) {
//            System.out.println(request.toString());
//        }
//    }

    public void UpdateStatusRequest(String Status, int RequestId) {
        String sql = "update Request SET  Status = ? where  Id = ?";
        try {
            PreparedStatement st = db.connection.prepareStatement(sql);
            st.setString(1, Status);
            st.setInt(2, RequestId);
            int rs = st.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();

        }
    }

    public int updateRequest(Request r) {
        int result = -1;
        String sql = "UPDATE Request SET DateTo = ?, dateFrom = ?, Reason = ? WHERE id = ?";
        try (PreparedStatement st = db.connection.prepareStatement(sql)) {
            st.setDate(1, r.getDateTo());
            st.setDate(2, r.getDateFrom());
            st.setString(3, r.getReason());
            st.setInt(4, r.getId());
            result = st.executeUpdate();
        } catch (SQLException ex) {
            // Log lỗi để tiện debug
            ex.printStackTrace();
        }
        return result;
    }

    public List<RequestDTO> getequestbyEmployeeId() {
        List<RequestDTO> list = new ArrayList<>();
        String sql = "select r.Id,r.DateCreate,r.DateFrom,r.DateTo,r.Reason,r.Status from Request r where r.EmployeeId=?";
        try {
            PreparedStatement st = db.connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                RequestDTO r = new RequestDTO();
                r.setId(rs.getInt(1));
                r.setDateCreate(rs.getDate(2));
                r.setDateFrom(rs.getDate(3));
                r.setDateTo(rs.getDate(4));
                r.setReason(rs.getString(5));
                r.setStatus(rs.getString(6));
                r.seteId(rs.getInt(7));
                r.seteName(rs.getString(8));
                list.add(r);
            }
        } catch (SQLException ex) {
        }
        return list;
    }

    public List<RequestDTO> getequestbyEmployeeId(int employee, Date dateto, Date datefrom) {
        List<RequestDTO> list = new ArrayList<>();
        String sql = "SELECT r.Id, e.Name, r.DateCreate, r.DateFrom, r.DateTo, r.Reason, r.Status\n"
                + "FROM Request r\n"
                + "JOIN Employee e ON r.EmployeeId = e.Id\n"
                + "WHERE r.EmployeeId = ? \n"
                + "  AND r.Status = 'Approved'\n"
                + "  AND r.DateFrom >= ? \n"
                + "  AND r.DateTo <= ?";
        try {
            PreparedStatement st = db.connection.prepareStatement(sql);
            st.setInt(1, employee);
            st.setDate(2, dateto);
            st.setDate(3, datefrom);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                RequestDTO r = new RequestDTO();
                r.setId(rs.getInt(1));
                r.seteName(rs.getString(2));
                r.setDateCreate(rs.getDate(3));
                r.setDateFrom(rs.getDate(4));
                r.setDateTo(rs.getDate(5));
                r.setReason(rs.getString(6));
                r.setStatus(rs.getString(7));
                list.add(r);
            }
        } catch (SQLException ex) {
        }
        return list;
    }

//   public static void main(String[] args) {
//        // Khởi tạo RequestDAO (đảm bảo DB connection đã được thiết lập trong RequestDAO hoặc cha của nó)
//        RequestDAO requestDAO = new RequestDAO();
//        
//        // Đặt EmployeeId để test, ví dụ: employee id = 1
//        int employeeId = 2;
//        // Thiết lập khoảng ngày test (theo định dạng yyyy-MM-dd)
//        Date dateFrom = Date.valueOf("2025-04-12");
//        Date dateTo = Date.valueOf("2025-04-15");
//        
//        // Gọi phương thức lấy danh sách RequestDTO
//        List<RequestDTO> requestList = requestDAO.getequestbyEmployeeId(employeeId, dateFrom, dateTo);
//        
//        // In kết quả ra console để kiểm tra
//        if (requestList.isEmpty()) {
//            System.out.println("Không có request nào trong khoảng ngày này.");
//        } else {
//            for (RequestDTO req : requestList) {
//                System.out.println("Id: " + req.getId());
//                System.out.println("Employee Name: " + req.geteName());
//                System.out.println("Date Create: " + req.getDateCreate());
//                System.out.println("Date From: " + req.getDateFrom());
//                System.out.println("Date To: " + req.getDateTo());
//                System.out.println("Reason: " + req.getReason());
//                System.out.println("Status: " + req.getStatus());
//                System.out.println("---------------");
//            }
//        }
//    }
    public List<Request> getRequestbyEmployeeId(int employeeId) {
        List<Request> list = new ArrayList<>();
        String sql = "select r.Id,r.DateCreate,r.DateFrom,r.DateTo,r.Reason,r.Status from Request r where r.EmployeeId=?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, employeeId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Request r = new Request();
                r.setId(rs.getInt("Id"));
                r.setDateTo(rs.getDate("DateTo"));
                r.setDateFrom(rs.getDate("DateFrom"));
                r.setDateCreate(rs.getDate("DateCreate"));
                r.setReason(rs.getString("Reason"));
                r.setStatus(rs.getString("Status"));
                list.add(r);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Request getReuestbyId(int Id) {
        Request r = null;
        String sql = "select r.Id,r.DateCreate,r.DateFrom,r.DateTo,r.Reason,r.Status from Request r where r.Id=?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, Id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                r = new Request();
                r.setId(rs.getInt("Id"));
                r.setDateTo(rs.getDate("DateTo"));
                r.setDateFrom(rs.getDate("DateFrom"));
                r.setDateCreate(rs.getDate("DateCreate"));
                r.setReason(rs.getString("Reason"));
                r.setStatus(rs.getString("Status"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return r;
    }

    public Request getOneReuestbyId(int Id, int EmployeeId) {
        Request r = null;
        String sql = "select r.Id,r.DateCreate,r.DateFrom,r.DateTo,r.Reason,r.Status from Request r where r.Id = ? AND r.EmployeeId = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, Id);
            st.setInt(2, EmployeeId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                r = new Request();
                r.setId(rs.getInt("Id"));
                r.setDateTo(rs.getDate("DateTo"));
                r.setDateFrom(rs.getDate("DateFrom"));
                r.setDateCreate(rs.getDate("DateCreate"));
                r.setReason(rs.getString("Reason"));
                r.setStatus(rs.getString("Status"));

            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return r;
    }
//     public static void main(String[] args) {
//        RequestDAO requestDAO = new RequestDAO();
//        
//        // Giá trị test
//        int requestId = 2;    
//        int employeeId = 2;   
//        
//        // Gọi hàm getOneReuestbyId để lấy thông tin Request
//        Request request = requestDAO.getOneReuestbyId(requestId, employeeId);
//        if (request != null) {
//            System.out.println("Request ID: " + request.getId());
//            System.out.println("Date Create: " + request.getDateCreate());
//            System.out.println("Date From: " + request.getDateFrom());
//            System.out.println("Date To: " + request.getDateTo());
//            System.out.println("Reason: " + request.getReason());
//            System.out.println("Status: " + request.getStatus());
//        } else {
//            System.out.println("Không tìm thấy request với id " + requestId + " và employeeId " + employeeId);
//        }
//            
//    
//    }
}
