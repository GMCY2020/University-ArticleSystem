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

@WebServlet("/addArt")
public class AddArtServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        ArticleDao articleDao = new ArticleDao();

        String way = req.getParameter("way");
        String userId = req.getParameter("user_id");
        String artTitle = req.getParameter("art_title");
        String artDetail = req.getParameter("art_detail");

        userId = new String(userId.getBytes(StandardCharsets.ISO_8859_1), StandardCharsets.UTF_8);
        artTitle = new String(artTitle.getBytes(StandardCharsets.ISO_8859_1), StandardCharsets.UTF_8);
        artDetail = new String(artDetail.getBytes(StandardCharsets.ISO_8859_1), StandardCharsets.UTF_8);

        int rs = articleDao.addArt(userId, artTitle, artDetail);

        String back;
        if (rs == 1) {
            back = "添加成功";
        } else {
            back = "添加失败";
        }

        req.setAttribute("way", way);
        req.getSession().setAttribute("mes", back);

        ServletContext application = this.getServletContext();
        RequestDispatcher rd = application.getRequestDispatcher("/artList.jsp");
        rd.forward(req, resp);

    }
}
