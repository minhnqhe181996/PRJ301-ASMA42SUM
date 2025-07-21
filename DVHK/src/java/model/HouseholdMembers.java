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
public class HouseholdMembers {

    private int memberID;
    private int householdID;
    private String idCard; // ID của thành viên trong hộ khẩu
    private String relationship;
    private String headOfHouseholdID; // ID của chủ hộ
    private String firstName; // Tên của chủ hộ
    private String lastName; // Họ của chủ hộ
    private String address; // Địa chỉ của hộ khẩu
    private Date createdDate; // Ngày tạo hộ khẩu
    private String memberFirstName; // Tên của thành viên
    private String memberLastName; // Họ của thành viên

    // Constructor mặc định
    public HouseholdMembers() {
    }

    // Constructor đầy đủ
    public HouseholdMembers(int memberID, int householdID, String idCard, String relationship,
            String headOfHouseholdID, String firstName, String lastName,
            String address, Date createdDate, String memberFirstName, String memberLastName) {
        this.memberID = memberID;
        this.householdID = householdID;
        this.idCard = idCard;
        this.relationship = relationship;
        this.headOfHouseholdID = headOfHouseholdID;
        this.firstName = firstName;
        this.lastName = lastName;
        this.address = address;
        this.createdDate = createdDate;
        this.memberFirstName = memberFirstName;
        this.memberLastName = memberLastName;
    }

    // Constructor ngắn gọn cho getAllHouseholdMembers
    public HouseholdMembers(int memberID, int householdID, String idCard, String relationship) {
        this.memberID = memberID;
        this.householdID = householdID;
        this.idCard = idCard;
        this.relationship = relationship;
    }

    // Getters và Setters
    public int getMemberID() {
        return memberID;
    }

    public void setMemberID(int memberID) {
        this.memberID = memberID;
    }

    public int getHouseholdID() {
        return householdID;
    }

    public void setHouseholdID(int householdID) {
        this.householdID = householdID;
    }

    public String getIDCard() {
        return idCard;
    }

    public void setIDCard(String idCard) {
        this.idCard = idCard;
    }

    public String getRelationship() {
        return relationship;
    }

    public void setRelationship(String relationship) {
        this.relationship = relationship;
    }

    public String getHeadOfHouseholdID() {
        return headOfHouseholdID;
    }

    public void setHeadOfHouseholdID(String headOfHouseholdID) {
        this.headOfHouseholdID = headOfHouseholdID;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
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
}
