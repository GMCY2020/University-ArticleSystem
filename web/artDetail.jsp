<%--
  Created by IntelliJ IDEA.
  User: GMCY
  Date: 2023/12/23
  Time: 23:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="Beans.Article" %>
<%@ page import="Dao.ArticleDao" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>文章详情</title>
    <link type="text/css" rel="stylesheet" href="css/main.css">
    <link type="text/css" rel="stylesheet" href="css/artDetail.css">
</head>
<body>
<%
    String artId = request.getParameter("artId");
    ArticleDao articleDao = new ArticleDao();
    Article article = articleDao.getArt(artId);
%>
<div class="artDetail">
    <div class="artDetail-title"><%=article.getArt_title()%>
    </div>

    <div class="artDetail-time">
        <div class="time-box">
            <div class="time-title">创建时间:</div>
            <div class="time-detail"><%=article.getCreate_time()%>
            </div>
        </div>
        <div class="time-box">
            <div class="time-title">最后编辑:</div>
            <div class="time-detail"><%=article.getUpdate_time()%>
            </div>
        </div>
    </div>
    <div class="artDetail-detail">
        <%
            String[] strings = article.getArt_detail().split("\n");
            for (String string : strings) {
                out.println("<p style=\"text-indent: 2em;\">" +  string + "</p>");
            }
        %>
    </div>
</div>
</body>
</html>
