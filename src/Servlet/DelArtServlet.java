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

@WebServlet("/delArt")
public class DelArtServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ArticleDao articleDao = new ArticleDao();

        String way = req.getParameter("way");
        String userId = req.getParameter("user_id");
        String artId = req.getParameter("art_id");

        int rs = articleDao.delArt(userId, artId);

        String back;
        if (rs == 1) {
            back = "删除成功";
        } else {
            back = "删除失败";
        }

        req.setAttribute("way", way);
        req.getSession().setAttribute("mes", back);

        ServletContext application = this.getServletContext();
        RequestDispatcher rd = application.getRequestDispatcher("/artList.jsp");
        rd.forward(req, resp);
    }
}
