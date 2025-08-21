package dal;

import java.sql.*;
import java.time.*;
import java.util.*;
import model.Attendance;

public class AttendanceDAO extends DBContext {

	public Attendance getByEmployeeAndDate(int employeeId, LocalDate date) throws SQLException {
		String sql = "SELECT * FROM Attendance WHERE employee_id=? AND work_date=?";
		try (PreparedStatement st = connection.prepareStatement(sql)) {
			st.setInt(1, employeeId);
			st.setDate(2, java.sql.Date.valueOf(date));
			try (ResultSet rs = st.executeQuery()) {
				if (rs.next()) {
					return map(rs);
				}
				return null;
			}
		}
	}

	public Attendance checkIn(int employeeId, LocalDateTime now, String notes) throws SQLException {
		LocalDate d = now.toLocalDate();
		Attendance exist = getByEmployeeAndDate(employeeId, d);
		if (exist != null && exist.getCheckIn() != null) {
			throw new SQLException("Already checked in");
		}
		if (exist == null) {
			String ins = "INSERT INTO Attendance(employee_id, work_date, check_in, notes) VALUES(?,?,?,?)";
			try (PreparedStatement st = connection.prepareStatement(ins, Statement.RETURN_GENERATED_KEYS)) {
				st.setInt(1, employeeId);
				st.setDate(2, java.sql.Date.valueOf(d));
				st.setTimestamp(3, Timestamp.valueOf(now));
				st.setString(4, notes);
				st.executeUpdate();
				try (ResultSet keys = st.getGeneratedKeys()) {
					if (keys.next()) {
						int id = keys.getInt(1);
						Attendance a = new Attendance();
						a.setId(id);
						a.setEmployeeId(employeeId);
						a.setWorkDate(java.sql.Date.valueOf(d));
						a.setCheckIn(Timestamp.valueOf(now));
						a.setNotes(notes);
						return a;
					}
				}
			}
		} else {
			String upd = "UPDATE Attendance SET check_in=?, notes=? WHERE id=?";
			try (PreparedStatement st = connection.prepareStatement(upd)) {
				st.setTimestamp(1, Timestamp.valueOf(now));
				st.setString(2, notes);
				st.setInt(3, exist.getId());
				st.executeUpdate();
				exist.setCheckIn(Timestamp.valueOf(now));
				exist.setNotes(notes);
				return exist;
			}
		}
		throw new SQLException("Check-in failed");
	}

	public Attendance checkOut(int employeeId, LocalDateTime now) throws SQLException {
		LocalDate d = now.toLocalDate();
		Attendance exist = getByEmployeeAndDate(employeeId, d);
		if (exist == null || exist.getCheckIn() == null) {
			throw new SQLException("Not checked in yet");
		}
		if (exist.getCheckOut() != null) {
			throw new SQLException("Already checked out");
		}
		String upd = "UPDATE Attendance SET check_out=? WHERE id=?";
		try (PreparedStatement st = connection.prepareStatement(upd)) {
			st.setTimestamp(1, Timestamp.valueOf(now));
			st.setInt(2, exist.getId());
			st.executeUpdate();
			exist.setCheckOut(Timestamp.valueOf(now));
			return exist;
		}
	}

	public List<Attendance> listByManager(int managerId, LocalDate from, LocalDate to) throws SQLException {
		// Join with Employee using Parentemployee (manager -> employees)
		String sql = "SELECT a.* FROM Attendance a "
				+ "JOIN Employee e ON e.Id = a.employee_id "
				+ "WHERE e.Parentemployee = ? AND a.work_date BETWEEN ? AND ? "
				+ "ORDER BY a.work_date DESC, a.employee_id";
		try (PreparedStatement st = connection.prepareStatement(sql)) {
			st.setInt(1, managerId);
			st.setDate(2, java.sql.Date.valueOf(from));
			st.setDate(3, java.sql.Date.valueOf(to));
			try (ResultSet rs = st.executeQuery()) {
				List<Attendance> list = new ArrayList<>();
				while (rs.next()) {
					list.add(map(rs));
				}
				return list;
			}
		}
	}

	private Attendance map(ResultSet rs) throws SQLException {
		Attendance a = new Attendance();
		a.setId(rs.getInt("id"));
		a.setEmployeeId(rs.getInt("employee_id"));
		a.setWorkDate(rs.getDate("work_date"));
		Timestamp ci = rs.getTimestamp("check_in");
		Timestamp co = rs.getTimestamp("check_out");
		a.setCheckIn(ci);
		a.setCheckOut(co);
		a.setNotes(rs.getString("notes"));
		return a;
	}
}
