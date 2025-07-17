/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;
import java.io.IOException;
import dal.RequestDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;    
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author quang
 */
public class DeleteRequest extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp); // Gọi lại GET khi POST   
    }
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String ID = req.getParameter("id");
        if (ID == null || ID.isEmpty()) {
            try{
                int id = Integer.parseInt(ID);
                RequestDAO requestDAO = new RequestDAO();
                requestDAO.DeleteById(id);
            }catch (NumberFormatException e) {
                e.printStackTrace();
                        }
    }
    resp.sendRedirect(req.getContextPath() + "/View");
    }
}
