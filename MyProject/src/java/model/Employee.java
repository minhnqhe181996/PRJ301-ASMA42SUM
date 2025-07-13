/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package model;
import java.util.Date;

public class Employee {
    private int Id;
    private String Name;
    private Date Dob;
    private String Email;
    private String Phone;
    private int Parentemployee;

    public Employee() {
    }

    public Employee(int Id, String Name, Date Dob, String Email, String Phone, int Parentemployee) {
        this.Id = Id;
        this.Name = Name;
        this.Dob = Dob;
        this.Email = Email;
        this.Phone = Phone;
        this.Parentemployee = Parentemployee;
    }

    public int getId() {
        return Id;
    }

    public void setId(int Id) {
        this.Id = Id;
    }

    public String getName() {
        return Name;
    }

    public void setName(String Name) {
        this.Name = Name;
    }

    public Date getDob() {
        return Dob;
    }

    public void setDob(Date Dob) {
        this.Dob = Dob;
    }

    public String getEmail() {
        return Email;
    }

    public void setEmail(String Email) {
        this.Email = Email;
    }

    public String getPhone() {
        return Phone;
    }

    public void setPhone(String Phone) {
        this.Phone = Phone;
    }

    public int getParentemployee() {
        return Parentemployee;
    }

    public void setParentemployee(int Parentemployee) {
        this.Parentemployee = Parentemployee;
    }

    @Override
    public String toString() {
        return "Employee{" + "Id=" + Id + ", Name=" + Name + ", Dob=" + Dob + ", Email=" + Email + ", Phone=" + Phone + ", Parentemployee=" + Parentemployee + '}';
    }

}
