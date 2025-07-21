/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;

/**
 *
 * @author LENOVO
 */
public class Households {

    private int HouseholdID;
    private String HeadOfHouseholdID;
    private String Address;
    private Date CreatedDate;
    private String IDCard;
    private String Relationship;
    private String FirstName;
    private String LastName;
    private String memberFirstName; // Member FirstName
    private String memberLastName;

    public Households() {
    }

    public Households(int HouseholdID, String HeadOfHouseholdID, String Address, Date CreatedDate) {
        this.HouseholdID = HouseholdID;
        this.HeadOfHouseholdID = HeadOfHouseholdID;
        this.Address = Address;
        this.CreatedDate = CreatedDate;
    }

    public Households(int HouseholdID, String HeadOfHouseholdID, String Address, Date CreatedDate, String IDCard, String Relationship, String FirstName, String LastName, String memberFirstName, String memberLastName) {
        this.HouseholdID = HouseholdID;
        this.HeadOfHouseholdID = HeadOfHouseholdID;
        this.Address = Address;
        this.CreatedDate = CreatedDate;
        this.IDCard = IDCard;
        this.Relationship = Relationship;
        this.FirstName = FirstName;
        this.LastName = LastName;
        this.memberFirstName = memberFirstName;
        this.memberLastName = memberLastName;
    }

    

    public String getMemberFirstName() {
        return memberFirstName;
    }

    public void setMemberFirstName(String memberFirstName) {
        this.memberFirstName = memberFirstName;
    }

    public String getMemberLastName() {
        return memberLastName;
    }

    public void setMemberLastName(String memberLastName) {
        this.memberLastName = memberLastName;
    }

    public String getIDCard() {
        return IDCard;
    }

    public void setIDCard(String IDCard) {
        this.IDCard = IDCard;
    }

    public String getRelationship() {
        return Relationship;
    }

    public void setRelationship(String Relationship) {
        this.Relationship = Relationship;
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

    
    public int getHouseholdID() {
        return HouseholdID;
    }

    public void setHouseholdID(int HouseholdID) {
        this.HouseholdID = HouseholdID;
    }

    public String getHeadOfHouseholdID() {
        return HeadOfHouseholdID;
    }

    public void setHeadOfHouseholdID(String HeadOfHouseholdID) {
        this.HeadOfHouseholdID = HeadOfHouseholdID;
    }

    public String getAddress() {
        return Address;
    }

    public void setAddress(String Address) {
        this.Address = Address;
    }

    public Date getCreatedDate() {
        return CreatedDate;
    }

    public void setCreatedDate(Date CreatedDate) {
        this.CreatedDate = CreatedDate;
    }

    @Override
    public String toString() {
        return "Households{" + "HouseholdID=" + HouseholdID + ", HeadOfHouseholdID=" + HeadOfHouseholdID + ", Address=" + Address + ", CreatedDate=" + CreatedDate + '}';
    }

}
