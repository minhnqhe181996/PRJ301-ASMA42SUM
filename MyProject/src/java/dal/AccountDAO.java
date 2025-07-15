package dal;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Account;

public class AccountDAO extends DBContext {
    public Account validateUser(String username, String password) {
        String sql = "SELECT Id, Username, Password, EmployeeId, RoleId FROM Account WHERE Username = ? AND Password = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Account(
                    rs.getInt("Id"),
                    rs.getString("Username"),
                    rs.getString("Password"),
                    rs.getInt("EmployeeId"),
                    rs.getInt("RoleId")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Account> getAllAccount() {
        List<Account> list = new ArrayList<>();
        String sql = "SELECT Id, Username, Password, EmployeeId, RoleId FROM Account";
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Account account = new Account(
                    rs.getInt("Id"),
                    rs.getString("Username"),
                    rs.getString("Password"),
                    rs.getInt("EmployeeId"),
                    rs.getInt("RoleId")
                );
                list.add(account);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Account getAccount(String Username, String Password) {
        return validateUser(Username, Password);
    }
}
