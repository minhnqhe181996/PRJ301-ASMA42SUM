package dal;

import model.Account;
import model.Request;
import model.Role;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;


public class RoleDAO extends DBContext{
    DBContext db=new DBContext();
    
    public List<Role> getAllRole() {
        List<Role> list = new ArrayList<>();
        String sql = "select * from [Role]";
        try {
            
            PreparedStatement st = db.connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Role rl=new Role();
                rl.setId(rs.getInt(1));
                rl.setName(rs.getString(2));
                rl.setDescription(rs.getString(3));                
                list.add(rl);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    public static void main(String[] args) {
        RoleDAO rl=new RoleDAO();
        List<Role> l=rl.getAllRole();
        System.out.println(l.get(0));
}
    
}
