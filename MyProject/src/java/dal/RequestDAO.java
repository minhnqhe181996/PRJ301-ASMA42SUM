package dal;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Request;

public class RequestDAO extends DBContext {
    public List<Request> getAllRequests() {
        List<Request> list = new ArrayList<>();
        String sql = "SELECT * FROM Request";
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Request req = new Request(
                    rs.getInt("Id"),
                    rs.getInt("EmployeeId"),
                    rs.getDate("DateTo"),
                    rs.getDate("DateFrom"),
                    rs.getDate("DateCreate"),
                    rs.getString("Reason"),
                    rs.getString("Status")
                );
                list.add(req);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Request getRequestById(int id) {
        String sql = "SELECT * FROM Request WHERE Id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Request(
                    rs.getInt("Id"),
                    rs.getInt("EmployeeId"),
                    rs.getDate("DateTo"),
                    rs.getDate("DateFrom"),
                    rs.getDate("DateCreate"),
                    rs.getString("Reason"),
                    rs.getString("Status")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean insertRequest(Request req) {
        String sql = "INSERT INTO Request (EmployeeId, DateTo, DateFrom, DateCreate, Reason, Status) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, req.getEmployeeId());
            ps.setDate(2, new java.sql.Date(req.getDateTo().getTime()));
            ps.setDate(3, new java.sql.Date(req.getDateFrom().getTime()));
            ps.setDate(4, new java.sql.Date(req.getDateCreate().getTime()));
            ps.setString(5, req.getReason());
            ps.setString(6, req.getStatus());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateRequest(Request req) {
        String sql = "UPDATE Request SET EmployeeId=?, DateTo=?, DateFrom=?, DateCreate=?, Reason=?, Status=? WHERE Id=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, req.getEmployeeId());
            ps.setDate(2, new java.sql.Date(req.getDateTo().getTime()));
            ps.setDate(3, new java.sql.Date(req.getDateFrom().getTime()));
            ps.setDate(4, new java.sql.Date(req.getDateCreate().getTime()));
            ps.setString(5, req.getReason());
            ps.setString(6, req.getStatus());
            ps.setInt(7, req.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteRequest(int id) {
        String sql = "DELETE FROM Request WHERE Id=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
