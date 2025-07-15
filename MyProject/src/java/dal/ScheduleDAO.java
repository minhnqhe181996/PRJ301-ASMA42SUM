package dal;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Schedule;

import model.AgendaDTO;

public class ScheduleDAO extends DBContext {
    public List<AgendaDTO> getAllAgenda() {
        List<AgendaDTO> list = new ArrayList<>();
        String sql = "SELECT Id, EmployeeId, Date, Status FROM Schedule";
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                AgendaDTO agenda = new AgendaDTO();
                agenda.setId(rs.getInt("Id"));
                agenda.setEmployeeId(rs.getInt("EmployeeId"));
                agenda.setDate(rs.getDate("Date"));
                agenda.setStatus(rs.getBoolean("Status"));
                list.add(agenda);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    public List<Schedule> getAllSchedules() {
        List<Schedule> list = new ArrayList<>();
        String sql = "SELECT Id, EmployeeId, Date, Status FROM Schedule";
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Schedule sch = new Schedule(
                    rs.getInt("Id"),
                    rs.getInt("EmployeeId"),
                    rs.getDate("Date"),
                    rs.getBoolean("Status")
                );
                list.add(sch);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Schedule getScheduleById(int id) {
        String sql = "SELECT Id, EmployeeId, Date, Status FROM Schedule WHERE Id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Schedule(
                    rs.getInt("Id"),
                    rs.getInt("EmployeeId"),
                    rs.getDate("Date"),
                    rs.getBoolean("Status")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean insertSchedule(Schedule sch) {
        String sql = "INSERT INTO Schedule (EmployeeId, Date, Status) VALUES (?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, sch.getEmployeeId());
            ps.setDate(2, new java.sql.Date(sch.getDate().getTime()));
            ps.setBoolean(3, sch.isStatus());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateSchedule(Schedule sch) {
        String sql = "UPDATE Schedule SET EmployeeId=?, Date=?, Status=? WHERE Id=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, sch.getEmployeeId());
            ps.setDate(2, new java.sql.Date(sch.getDate().getTime()));
            ps.setBoolean(3, sch.isStatus());
            ps.setInt(4, sch.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteSchedule(int id) {
        String sql = "DELETE FROM Schedule WHERE Id=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
