package model;

import java.util.Date;

public class Attendance {

	private int id;
	private int employeeId;
	private Date workDate;
	private Date checkIn;
	private Date checkOut;
	private String notes;

	public Attendance(int id, int employeeId, Date workDate, Date checkIn, Date checkOut, String notes) {
		this.id = id;
		this.employeeId = employeeId;
		this.workDate = workDate;
		this.checkIn = checkIn;
		this.checkOut = checkOut;
		this.notes = notes;
	}

	public Attendance() {
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getEmployeeId() {
		return employeeId;
	}

	public void setEmployeeId(int employeeId) {
		this.employeeId = employeeId;
	}

	public Date getWorkDate() {
		return workDate;
	}

	public void setWorkDate(Date workDate) {
		this.workDate = workDate;
	}

	public Date getCheckIn() {
		return checkIn;
	}

	public void setCheckIn(Date checkIn) {
		this.checkIn = checkIn;
	}

	public Date getCheckOut() {
		return checkOut;
	}

	public void setCheckOut(Date checkOut) {
		this.checkOut = checkOut;
	}

	public String getNotes() {
		return notes;
	}

	public void setNotes(String notes) {
		this.notes = notes;
	}

	public String getWorkingHours() {
		if (checkIn == null || checkOut == null) {
			return null;
		}
		long millis = checkOut.getTime() - checkIn.getTime();
		if (millis <= 0) {
			return null;
		}
		long totalSeconds = millis / 1000;
		long hours = totalSeconds / 3600;
		long minutes = (totalSeconds % 3600) / 60;
		return String.format("%02d:%02d", hours, minutes);
	}
}
