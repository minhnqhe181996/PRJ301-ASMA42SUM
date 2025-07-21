/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Timestamp;


/**
 *
 * @author LENOVO
 */
public class Notifications {
    private int NotificationID;
    private String IDCard;
    private String Message;
    private Timestamp SentDate;
    private boolean IsRead; 

    public Notifications() {
    }

    public Notifications(int NotificationID, String IDCard, String Message, Timestamp SentDate, boolean IsRead) {
        this.NotificationID = NotificationID;
        this.IDCard = IDCard;
        this.Message = Message;
        this.SentDate = SentDate;
        this.IsRead = IsRead;
    }

    
    

    public int getNotificationID() {
        return NotificationID;
    }

    public void setNotificationID(int NotificationID) {
        this.NotificationID = NotificationID;
    }

    public String getIDCard() {
        return IDCard;
    }

    public void setIDCard(String IDCard) {
        this.IDCard = IDCard;
    }

   
    public String getMessage() {
        return Message;
    }

    public void setMessage(String Message) {
        this.Message = Message;
    }

    public Timestamp getSentDate() {
        return SentDate;
    }

    public void setSentDate(Timestamp SentDate) {
        this.SentDate = SentDate;
    }

    

    public boolean isIsRead() {
        return IsRead;
    }

    public void setIsRead(boolean IsRead) {
        this.IsRead = IsRead;
    }

   
    
}
