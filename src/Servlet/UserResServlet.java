package Servlet;

import Dao.UserDao;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.nio.charset.StandardCharsets;

@WebServlet("/res")
public class UserResServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UserDao userDao = new UserDao();
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        username = new String(username.getBytes(StandardCharsets.ISO_8859_1), StandardCharsets.UTF_8);
        password = new String(password.getBytes(StandardCharsets.ISO_8859_1), StandardCharsets.UTF_8);

        int rs = userDao.register(username, password);
        req.getSession().setAttribute("isRes", rs);

        ServletContext application = this.getServletContext();
        RequestDispatcher rd = application.getRequestDispatcher("/login.jsp");
        rd.forward(req, resp);
    }
}
