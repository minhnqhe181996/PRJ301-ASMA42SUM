/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpSessionEvent;
import jakarta.servlet.http.HttpSessionListener;

/**
 *
 * @author quang
 */
public class CountUser implements HttpSessionListener {

    ServletContext ctx = null;
    static int total = 0, current = 0;

    @Override
    public void sessionCreated(HttpSessionEvent e) {
        total++;
        current++;
        ctx = e.getSession().getServletContext();
        ctx.setAttribute("totalusers", total);
        ctx.setAttribute("currentusers", current);
        System.out.println("Session created. Current users: " + current);
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent e) {
        current--;
        ctx = e.getSession().getServletContext();
        ctx.setAttribute("currentusers", current);
        System.out.println("Session destroyed. Current users: " + current);
    }
}
