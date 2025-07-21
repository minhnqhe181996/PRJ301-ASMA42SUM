/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Timestamp;
import java.util.Date;

/**
 *
 * @author LENOVO
 */
public class Registrations {

    private int RegistrationID;
    private String IDCard;
    private String RegistrationType;
    private Date StartDate;
    private Date EndDate;
    private String Status;
    private String Relationship;
    private String HeadOfHouseholdID;
    private String ApprovedBy;
    private String Address;
    private String City;
    private String Comments;
    private Timestamp createdDate;
    private String FirstName;
    private String LastName;

    public Registrations() {
    }

    public Registrations(int RegistrationID, String IDCard, String RegistrationType, Date StartDate, Date EndDate, String Status, String Relationship, String HeadOfHouseholdID, String ApprovedBy, String Address, String City, String Comments, Timestamp createdDate, String FirstName, String LastName) {
        this.RegistrationID = RegistrationID;
        this.IDCard = IDCard;
        this.RegistrationType = RegistrationType;
        this.StartDate = StartDate;
        this.EndDate = EndDate;
        this.Status = Status;
        this.Relationship = Relationship;
        this.HeadOfHouseholdID = HeadOfHouseholdID;
        this.ApprovedBy = ApprovedBy;
        this.Address = Address;
        this.City = City;
        this.Comments = Comments;
        this.createdDate = createdDate;
        this.FirstName = FirstName;
        this.LastName = LastName;
    }

    public Registrations(int RegistrationID, String IDCard, String RegistrationType, Date StartDate, Date EndDate, String Status, String Relationship, String HeadOfHouseholdID, String ApprovedBy, String Address, String City, String Comments, Timestamp createdDate) {
        this.RegistrationID = RegistrationID;
        this.IDCard = IDCard;
        this.RegistrationType = RegistrationType;
        this.StartDate = StartDate;
        this.EndDate = EndDate;
        this.Status = Status;
        this.Relationship = Relationship;
        this.HeadOfHouseholdID = HeadOfHouseholdID;
        this.ApprovedBy = ApprovedBy;
        this.Address = Address;
        this.City = City;
        this.Comments = Comments;
        this.createdDate = createdDate;
    }

    public Registrations(int RegistrationID, String IDCard, String RegistrationType, Date StartDate, String Status, String Relationship, String HeadOfHouseholdID, String ApprovedBy, String Address, String City, String Comments, Timestamp createdDate) {
        this.RegistrationID = RegistrationID;
        this.IDCard = IDCard;
        this.RegistrationType = RegistrationType;
        this.StartDate = StartDate;
        this.Status = Status;
        this.Relationship = Relationship;
        this.HeadOfHouseholdID = HeadOfHouseholdID;
        this.ApprovedBy = ApprovedBy;
        this.Address = Address;
        this.City = City;
        this.Comments = Comments;
        this.createdDate = createdDate;
    }

    

    public Registrations(int RegistrationID, String Status, String ApprovedBy) {
        this.RegistrationID = RegistrationID;
        this.Status = Status;
        this.ApprovedBy = ApprovedBy;
    }

    public Registrations(String IDCard, String RegistrationType, Date StartDate, Date EndDate, String Relationship, String HeadOfHouseholdID, String Address, String City, String Comments) {
        this.IDCard = IDCard;
        this.RegistrationType = RegistrationType;
        this.StartDate = StartDate;
        this.EndDate = EndDate;
        this.Relationship = Relationship;
        this.HeadOfHouseholdID = HeadOfHouseholdID;
        this.Address = Address;
        this.City = City;
        this.Comments = Comments;
    }

    public String getFirstName() {
        return FirstName;
    }

    public void setFirstName(String FirstName) {
        this.FirstName = FirstName;
    }

    public String getLastName() {
        return LastName;
    }

    public void setLastName(String LastName) {
        this.LastName = LastName;
    }

    public String getCity() {
        return City;
    }

    public void setCity(String City) {
        this.City = City;
    }

    public int getRegistrationID() {
        return RegistrationID;
    }

    public void setRegistrationID(int RegistrationID) {
        this.RegistrationID = RegistrationID;
    }

    public String getIDCard() {
        return IDCard;
    }

    public void setIDCard(String IDCard) {
        this.IDCard = IDCard;
    }

    public String getRegistrationType() {
        return RegistrationType;
    }

    public void setRegistrationType(String RegistrationType) {
        this.RegistrationType = RegistrationType;
    }

    public Date getStartDate() {
        return StartDate;
    }

    public void setStartDate(Date StartDate) {
        this.StartDate = StartDate;
    }

    public Date getEndDate() {
        return EndDate;
    }

    public void setEndDate(Date EndDate) {
        this.EndDate = EndDate;
    }

    public String getStatus() {
        return Status;
    }

    public void setStatus(String Status) {
        this.Status = Status;
    }

    public String getRelationship() {
        return Relationship;
    }

    public void setRelationship(String Relationship) {
        this.Relationship = Relationship;
    }

    public String getHeadOfHouseholdID() {
        return HeadOfHouseholdID;
    }

    public void setHeadOfHouseholdID(String HeadOfHouseholdID) {
        this.HeadOfHouseholdID = HeadOfHouseholdID;
    }

    public String getApprovedBy() {
        return ApprovedBy;
    }

    public void setApprovedBy(String ApprovedBy) {
        this.ApprovedBy = ApprovedBy;
    }

    public String getAddress() {
        return Address;
    }

    public void setAddress(String Address) {
        this.Address = Address;
    }

    public String getComments() {
        return Comments;
    }

    public void setComments(String Comments) {
        this.Comments = Comments;
    }

    public Timestamp getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Timestamp createdDate) {
        this.createdDate = createdDate;
    }

}
