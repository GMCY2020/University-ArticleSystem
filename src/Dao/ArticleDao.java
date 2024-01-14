package Dao;

import Beans.Article;

import java.sql.*;
import java.util.ArrayList;

public class ArticleDao {
    private final String jdbc = "jdbc:mysql://localhost:3306/db_artSys?useUnicode=UTF-8&&serverTimezone=UTC&&useSSL=false";
    private final String user = "root";
    private final String password = "1234";

    // 获取所有文章 (搜索功能?) √
    public ArrayList getAllArt(String art_title, String art_author) {

        if (art_title == null || art_title.equals("")) art_title = "0{0,1}";
        if (art_author == null || art_author.equals("")) art_author = "0{0,1}";
        ArrayList arts = new ArrayList();
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(jdbc, user, password);

            String sql = "select\n" +
                    "    tb_article.art_id, art_title, user_name, tb_article.art_detail, tb_article.create_time, tb_article.update_time\n" +
                    "from\n" +
                    "    tb_article\n" +
                    "        join tb_userart on tb_article.art_id = tb_userart.art_id\n" +
                    "        join tb_user on tb_userart.user_id = tb_user.user_id\n" +
                    "where art_title regexp ? and user_name regexp ?";


            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, art_title);
            ps.setString(2, art_author);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Article article = new Article();
                article.setArt_id(rs.getString(1));
                article.setArt_title(rs.getString(2));
                article.setArt_author(rs.getString(3));
                article.setArt_detail(rs.getString(4));
                article.setCreate_time(rs.getString(5));
                article.setUpdate_time(rs.getString(6));
                arts.add(article);
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
        return arts;
    }

    // 根据 用户 id 获取用户写的文章 √
    public ArrayList getArtByUserId(String user_id) {
        ArrayList arts = new ArrayList();
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(jdbc, user, password);

            String sql = "select\n" +
                    "    *\n" +
                    "from\n" +
                    "    tb_article\n" +
                    "where art_id in (select art_id from tb_userart where user_id = ?)";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, user_id);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Article article = new Article();
                article.setArt_id(rs.getString(1));
                article.setArt_title(rs.getString(2));
                article.setArt_detail(rs.getString(3));
                article.setCreate_time(rs.getString(4));
                article.setUpdate_time(rs.getString(5));
                arts.add(article);
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
        return arts;
    }

    // 根据 用户 id 获取用户 收藏 的 文章 √
    public ArrayList getArtStarByUserId(String user_id) {
        ArrayList arts = new ArrayList();
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(jdbc, user, password);


            String sql = "select\n" +
                    "    tb_article.art_id, art_title, user_name, tb_article.art_detail, tb_article.create_time, tb_article.update_time\n" +
                    "from\n" +
                    "    tb_article\n" +
                    "        join tb_userart on tb_article.art_id = tb_userart.art_id\n" +
                    "        join tb_user on tb_userart.user_id = tb_user.user_id\n" +
                    "where tb_article.art_id in (select tb_userstar.art_id from tb_userstar where tb_userstar.user_id = ?)";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, user_id);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Article article = new Article();
                article.setArt_id(rs.getString(1));
                article.setArt_title(rs.getString(2));
                article.setArt_author(rs.getString(3));
                article.setArt_detail(rs.getString(4));
                article.setCreate_time(rs.getString(5));
                article.setUpdate_time(rs.getString(6));
                arts.add(article);
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
        return arts;
    }

    // 添加文章 √
    public int addArt(String user_id, String art_title, String art_detail) {
        int rs3 = 0;
        Connection conn = null;
        try {
            conn = DriverManager.getConnection(jdbc, user, password);

            Class.forName("com.mysql.cj.jdbc.Driver");

            String sql = "insert into tb_article(art_title, art_detail, create_time, update_time) value (?, ?, now(), now())";

            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, art_title);
            ps.setString(2, art_detail);

            int rs = ps.executeUpdate();

            if (rs == 1) {
                String sql2 = "select art_id from tb_article where art_title = ?";
                PreparedStatement ps2 = conn.prepareStatement(sql2);
                ps2.setString(1, art_title);
                ResultSet rs2 = ps2.executeQuery();
                while (rs2.next()) {
                    String key = rs2.getString(1);
                    String sql3 = "insert into tb_userart(user_id, art_id) value (?, ?)";
                    PreparedStatement ps3 = conn.prepareStatement(sql3);
                    ps3.setInt(1, Integer.parseInt(user_id));
                    ps3.setInt(2, Integer.parseInt(key));
                    rs3 = ps3.executeUpdate();
                }
            }
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
        return rs3;
    }

    // 修改文章 √
    public int updateArt(String art_id, String art_title, String art_detail) {
        int rs = 0;
        Connection conn = null;
        try {
            conn = DriverManager.getConnection(jdbc, user, password);

            Class.forName("com.mysql.cj.jdbc.Driver");

            String sql = "update tb_article set art_title = ?, art_detail = ? where art_id = ?;";

            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, art_title);
            ps.setString(2, art_detail);
            ps.setInt(3, Integer.parseInt(art_id));

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

    // 收藏文章 √
    public int starArt(String user_id, String art_id) {
        int rs = 0;
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(jdbc, user, password);

            String sql = "insert into tb_userstar value (?, ?)";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, user_id);
            ps.setString(2, art_id);

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

    // 取消收藏文章 √
    public int unStarArt(String user_id, String art_id) {
        int rs = 0;
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(jdbc, user, password);

            String sql = "delete from tb_userstar where user_id = ? and art_id = ?";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, user_id);
            ps.setString(2, art_id);

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

    // 删除文章 √
    public int delArt(String user_id, String art_id) {
        int rs = 0;
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(jdbc, user, password);


            String sql = "delete from tb_article where art_id = ?";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, Integer.parseInt(art_id));
            int r1 = ps.executeUpdate();

            String sql2 = "delete from tb_userart where user_id = ? and art_id = ?";
            PreparedStatement ps2 = conn.prepareStatement(sql2);
            ps2.setInt(1, Integer.parseInt(user_id));
            ps2.setInt(2, Integer.parseInt(art_id));
            int r2 = ps2.executeUpdate();

            if (r1 == 1 && r2 == 1) {
                rs = 1;
            }

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

    // 获取文章 √
    public Article getArt(String art_id) {
        Article article = new Article();
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(jdbc, user, password);

            String sql = "select * from tb_article where art_id = ?;";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, Integer.parseInt(art_id));

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                article.setArt_id(rs.getString(1));
                article.setArt_title(rs.getString(2));
                article.setArt_detail(rs.getString(3));
                article.setCreate_time(rs.getString(4));
                article.setUpdate_time(rs.getString(5));
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
        return article;
    }
}
