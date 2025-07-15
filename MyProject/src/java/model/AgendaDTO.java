/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;
import java.util.List;

public class AgendaDTO {
    private int eId;
    private String eName;
    // Existing requests field
    private List<RequestDTO> requests;

    // Fields for schedule info
    private int id;
    private int employeeId;
    private Date date;
    private boolean status;

    public AgendaDTO() {
    }
    // Getters and setters for schedule info
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

    public Date getDate() {
        return date;
    }
    public void setDate(Date date) {
        this.date = date;
    }

    public boolean isStatus() {
        return status;
    }
    public void setStatus(boolean status) {
        this.status = status;
    }

    public AgendaDTO(int eId, String eName, List<RequestDTO> requests) {
        this.eId = eId;
        this.eName = eName;
        this.requests = requests;
    }

    public int geteId() {
        return eId;
    }

    public void seteId(int eId) {
        this.eId = eId;
    }

    public String geteName() {
        return eName;
    }

    public void seteName(String eName) {
        this.eName = eName;
    }

    public List<RequestDTO> getRequests() {
        return requests;
    }

    public void setRequests(List<RequestDTO> requests) {
        this.requests = requests;
    }

   
    @Override
    public String toString() {
        return "AgendaDTO{" + "eId=" + eId + ", eName=" + eName + ", requests=" + requests + '}';
    }
    
}
