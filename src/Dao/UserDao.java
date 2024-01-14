package Dao;

import Beans.User;

import java.sql.*;

public class UserDao {
    private final String jdbc = "jdbc:mysql://localhost:3306/db_artSys?useUnicode=UTF-8&&serverTimezone=UTC&&useSSL=false";
    private final String userName = "root";
    private final String password = "1234";

    // 登录 √
    public User login(String user_name, String user_password) throws SQLException {

        Connection conn = null;

        User user = new User();
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(jdbc, userName, password);

            String sql = "select * from tb_user where user_name = ?";


            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, user_name);
            ResultSet rs = ps.executeQuery();
            if (rs.getRow() == 0) {
                user.setUser_id("-1");
            }
            while (rs.next()) {
                if (user_password.equals(rs.getString(3))) {
                    user.setUser_id(rs.getString(1));
                    user.setUser_name(rs.getString(2));
                    user.setUser_password(rs.getString(3));
                    user.setCreate_time(rs.getString(4));
                    user.setUpdate_time(rs.getString(5));
                } else {
                    user.setUser_id("-2");
                }
            }

            rs.close();
            conn.close();
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        } finally {
            try {
                if (conn != null) {
                    conn.close();
                    conn = null;
                }
            } catch (Exception ignored) {

            }
        }
        return user;
    }

    // 注册 √
    public int register(String user_name, String user_password) {
        Connection conn = null;
        int rs = 0;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(jdbc, userName, password);
            String sql = "insert into tb_user(user_name, user_password, create_time, update_time) value (?, ?, now(), now())";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, user_name);
            ps.setString(2, user_password);

            rs = ps.executeUpdate();

            conn.close();
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        } finally {
            try {
                if (conn != null) {
                    conn.close();
                    conn = null;
                }
            } catch (Exception ignored) {

            }
        }
        return rs;
    }
}
