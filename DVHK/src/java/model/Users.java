/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author LENOVO
 */
public class Users {
    private String IDCard;
    private String FirstName;
    private String LastName;
    private String Gender;
    private String City;
    private String Email;
    private String Password;
    private int RoleID;
    private String PhoneNumber;
    private String Address;
    private String  RoleName;

    public Users() {
    }

    public Users(String IDCard, String FirstName, String LastName, String City, int RoleID, String Address) {
        this.IDCard = IDCard;
        this.FirstName = FirstName;
        this.LastName = LastName;
        this.City = City;
        this.RoleID = RoleID;
        this.Address = Address;
    }

    
    public Users(String IDCard, String FirstName, String LastName, String Gender, String City, String Email, String Password, int RoleID, String PhoneNumber, String Address) {
        this.IDCard = IDCard;
        this.FirstName = FirstName;
        this.LastName = LastName;
        this.Gender = Gender;
        this.City = City;
        this.Email = Email;
        this.Password = Password;
        this.RoleID = RoleID;
        this.PhoneNumber = PhoneNumber;
        this.Address = Address;
    }

    public Users(String IDCard, String FirstName, String LastName, String Gender, String City, String Email, String Password, String PhoneNumber, String Address) {
        this.IDCard = IDCard;
        this.FirstName = FirstName;
        this.LastName = LastName;
        this.Gender = Gender;
        this.City = City;
        this.Email = Email;
        this.Password = Password;
        this.PhoneNumber = PhoneNumber;
        this.Address = Address;
    }
    
    
    

    public String getGender() {
        return Gender;
    }

    public void setGender(String Gender) {
        this.Gender = Gender;
    }

    public String getCity() {
        return City;
    }

    public void setCity(String City) {
        this.City = City;
    }

    

    public String getIDCard() {
        return IDCard;
    }

    public void setIDCard(String IDCard) {
        this.IDCard = IDCard;
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

    public String getEmail() {
        return Email;
    }

    public void setEmail(String Email) {
        this.Email = Email;
    }

    public String getPassword() {
        return Password;
    }

    public void setPassword(String Password) {
        this.Password = Password;
    }

    public int getRoleID() {
        return RoleID;
    }

    public void setRoleID(int RoleID) {
        this.RoleID = RoleID;
    }

    public String getPhoneNumber() {
        return PhoneNumber;
    }

    public void setPhoneNumber(String PhoneNumber) {
        this.PhoneNumber = PhoneNumber;
    }

    public String getAddress() {
        return Address;
    }

    public void setAddress(String Address) {
        this.Address = Address;
    }

    public String getRoleName() {
        return RoleName;
    }

    public void setRoleName(String RoleName) {
        this.RoleName = RoleName;
    }

    

    @Override
    public String toString() {
        return "Users{" + "IDCard=" + IDCard + ", FirstName=" + FirstName + ", LastName=" + LastName + ", Gender=" + Gender + ", City=" + City + ", Email=" + Email + ", Password=" + Password + ", RoleID=" + RoleID + ", PhoneNumber=" + PhoneNumber + ", Address=" + Address + '}';
    }


 

    

  
    
    



}
