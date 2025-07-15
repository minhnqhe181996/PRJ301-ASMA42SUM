/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;
import java.util.List;

/**
 *
 * @author ADMIN
 */
public class AgendaDTO {
    private int eId;
    private String eName;
    
    
    private List<RequestDTO> requests;

    public AgendaDTO() {
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

}
