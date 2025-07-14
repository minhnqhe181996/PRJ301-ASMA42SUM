/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;

/**
 *
 * @author quang
 */
public class RequestDTO {
    private int Id;
    private Date DateCreate;
    private Date DateFrom;
    private Date DateTo;
    private String Reason;
    private String Status;
    private int eId;
    private String eName;

    public RequestDTO() {
    }

    public RequestDTO(int Id, Date DateCreate, Date DateFrom, Date DateTo, String Reason, String Status, int eId, String eName) {
        this.Id = Id;
        this.DateCreate = DateCreate;
        this.DateFrom = DateFrom;
        this.DateTo = DateTo;
        this.Reason = Reason;
        this.Status = Status;
        this.eId = eId;
        this.eName = eName;
    }

    public int getId() {
        return Id;
    }

    public void setId(int Id) {
        this.Id = Id;
    }

    public Date getDateCreate() {
        return DateCreate;
    }

    public void setDateCreate(Date DateCreate) {
        this.DateCreate = DateCreate;
    }

    public Date getDateFrom() {
        return DateFrom;
    }

    public void setDateFrom(Date DateFrom) {
        this.DateFrom = DateFrom;
    }

    public Date getDateTo() {
        return DateTo;
    }

    public void setDateTo(Date DateTo) {
        this.DateTo = DateTo;
    }

    public String getReason() {
        return Reason;
    }

    public void setReason(String Reason) {
        this.Reason = Reason;
    }

    public String getStatus() {
        return Status;
    }

    public void setStatus(String Status) {
        this.Status = Status;
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


}
