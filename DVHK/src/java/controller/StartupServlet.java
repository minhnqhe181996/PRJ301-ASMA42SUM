/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dao.RegistrationsDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;

import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

/**
 *
 * @author LENOVO
 */
public class StartupServlet extends HttpServlet {

    private ScheduledExecutorService scheduler;

    @Override
    public void init() throws ServletException {
        super.init();
        scheduler = Executors.newSingleThreadScheduledExecutor();
        scheduler.scheduleAtFixedRate(() -> {
            RegistrationsDAO.checkAndNotifyExpiredRegistrations();
            System.out.println("Checked and notified expired registrations at " + new java.util.Date());
        }, 0, 1, TimeUnit.DAYS); // Chạy ngay khi khởi động và mỗi ngày một lần
    }

    @Override
    public void destroy() {
        super.destroy();
        if (scheduler != null) {
            scheduler.shutdown();
        }
    }
}