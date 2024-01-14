package Servlet;

import Dao.ArticleDao;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.nio.charset.StandardCharsets;


@WebServlet("/star") // √
public class StarArtServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        ArticleDao articleDao = new ArticleDao();

        String way = req.getParameter("way");
        String user_id = req.getParameter("user_id");
        String art_id = req.getParameter("art_id");

        user_id = new String(user_id.getBytes(StandardCharsets.ISO_8859_1), StandardCharsets.UTF_8);
        art_id = new String(art_id.getBytes(StandardCharsets.ISO_8859_1), StandardCharsets.UTF_8);

        int rs = articleDao.starArt(user_id, art_id);

        String back;

        if (rs == 0) {
            back = "已经收藏";
        } else {
            back = "收藏成功";
        }

        req.setAttribute("way", way);
        req.getSession().setAttribute("mes", back);

        ServletContext application = this.getServletContext();
        RequestDispatcher rd = application.getRequestDispatcher("/artList.jsp");
        rd.forward(req, resp);
    }
}
