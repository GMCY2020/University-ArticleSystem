<%--
  Created by IntelliJ IDEA.
  User: GMCY
  Date: 2023/12/23
  Time: 17:22
  To change this template use File | Settings | File Templates.
  框架
--%>
<%@ page import="Beans.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>文章管理系统</title>
    <link type="text/css" rel="stylesheet" href="css/main.css">
    <link type="text/css" rel="stylesheet" href="css/index.css">
    <link rel="icon" href="img/logo.ico">
</head>
<body>
<%
    String mes = (String) request.getSession().getAttribute("mes");

    if (mes != null) {
        out.print("<div class=\"messagePop success\">\n" +
                mes +
                "</div>");
    }

    request.getSession().setAttribute("mes", null);

    String username;

    User user = (User) request.getSession().getAttribute("user");


    if (user != null) {
        username = user.getUser_name();
    } else {
        username = "未登录";
    }

    String way = request.getParameter("way");
    String toPan;

    if (way == null) {
        way = "home";
        toPan = "home.jsp";
    }

    if (way.equals("home")) {
        toPan = "home.jsp";
    } else if (way.equals("all")) {
        toPan = "artList.jsp?way=all";
    } else if (way.equals("myStar")) {
        toPan = "artList.jsp?way=myStar";
    } else if (way.equals("my")) {
        toPan = "artList.jsp?way=my";
    } else if (way.equals("detail")) {
        String artId = request.getParameter("artId");
        toPan = "artDetail.jsp?artId=" + artId;
    } else {
        toPan = "home.jsp";
    }
%>
<div class="app" id="app">
    <%-- 左边导航栏 --%>
    <div class="left">
        <div class="left-logo"></div>
        <div class="left-items">
            <a class="left-item <%
                if (way.equals("home")) {
                    out.println("left-item-choice");
                }
            %>" href="index.jsp?way=home">首页</a>
            <a class="left-item <%
                if (way.equals("all")) {
                    out.println("left-item-choice");
                }
            %>" href="index.jsp?way=all">所有文章</a>
            <a class="left-item <%
                if (way.equals("myStar")) {
                    out.println("left-item-choice");
                }
            %>" href="index.jsp?way=myStar">我的收藏</a>
            <a class="left-item <%
                if (way.equals("my")) {
                    out.println("left-item-choice");
                }
            %>" href="index.jsp?way=my">我的文章</a>
        </div>
    </div>

    <%-- 右边 --%>
    <div class="right">
        <div class="right-top">
            <div></div>
            <div class="right-top-box" id="right-top-box">
                <div class="user-name"><%=username%>
                </div>
                <div class="user-img-box">
                    <svg class="user-img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1024 1024">
                        <path fill="currentColor" d="m192 384 320 384 320-384z"></path>
                    </svg>
                </div>
            </div>
        </div>
        <div class="right-center">
            <iframe id="rightIframe" src="<%out.println(toPan);%>"></iframe>
        </div>
        <div class="right-bottom">
            文章管理系统 ©2023 Created by GMCY
        </div>

    </div>
</div>
<div class="pop dis" id="pop">
    <svg class="pop-img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1024 1024">
        <path fill="currentColor"
              d="M352 159.872V230.4a352 352 0 1 0 320 0v-70.528A416.128 416.128 0 0 1 512 960a416 416 0 0 1-160-800.128z"></path>
        <path fill="currentColor" d="M512 64q32 0 32 32v320q0 32-32 32t-32-32V96q0-32 32-32"></path>
    </svg>
    <%
        if (user != null) {
            out.println("退出");
        } else {
            out.println("登录");
        }
    %>
</div>
</body>
<script>
    const topBox = document.getElementById("right-top-box")
    const pop = document.getElementById("pop")

    topBox.addEventListener("mouseenter", () => {
        document.getElementById("pop").className = "pop"
    })

    topBox.addEventListener("mouseout", () => {
        pop.addEventListener("mouseout", () => {
            pop.className = "pop dis"
        })
    })

    pop.addEventListener("mousedown", () => {
        window.location.href = "/exit";
    })

</script>
</html>
