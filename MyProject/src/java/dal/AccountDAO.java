package dal;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Account;

public class AccountDAO extends DBContext {

    DBContext db = new DBContext();

    public Account validateUser(String username, String password) {
        String sql = "select * from Account "
                + "where Username = ? AND Password = ? ";
        try {
            PreparedStatement ps = db.connection.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Account account = new Account();
                account.setId(rs.getInt(1));
                account.setUsername(rs.getString(2));
                account.setPassword(rs.getString(3));
                account.setEmployeeId(rs.getInt(4));
                account.setRoleId(rs.getInt(5));
                return account;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();

        }
        return null;
    }

    public List<Account> getAllAccount() {
        List<Account> list = new ArrayList<>();
        String sql = "select * from [Account]";
        try {

            PreparedStatement st = db.connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Account a = new Account();
                a.setId(rs.getInt(1));
                a.setUsername(rs.getString(2));
                a.setPassword(rs.getString(3));
                a.setEmployeeId(rs.getInt(4));
                a.setRoleId(rs.getInt(5));
                list.add(a);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();

        }
        return list;
    }

    public Account getAccount(String Username, String Password) {
        String sql = "Select * from Account where Username=? and Password=?";
        try {
            PreparedStatement pr = db.connection.prepareStatement(sql);
            pr.setString(1, Username);
            pr.setString(2, Password);
            ResultSet rs = pr.executeQuery();
            while (rs.next()) {
                Account acc = new Account();
                acc.setId(rs.getInt(1));
                acc.setUsername(rs.getString(2));
                acc.setPassword(rs.getString(3));
                acc.setEmployeeId(rs.getInt(4));
                return acc;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

}
