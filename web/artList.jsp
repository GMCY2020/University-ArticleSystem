<%--
  Created by IntelliJ IDEA.
  User: GMCY
  Date: 2023/12/23
  Time: 18:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="Beans.Article" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Dao.ArticleDao" %>
<%@ page import="Beans.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
    <link type="text/css" rel="stylesheet" href="css/main.css">
    <link type="text/css" rel="stylesheet" href="css/artList.css">
</head>
<body>
<%
    String way = request.getParameter("way");
    String title = request.getParameter("title");
    String author = request.getParameter("author");

    String mes = (String) request.getSession().getAttribute("mes");

    if (mes != null) {
        out.print("<div class=\"messagePop success\">\n" +
                mes +
                "</div>");
    }

    request.getSession().setAttribute("mes", null);

    if (title == null) title = "";
    if (author == null) author = "";

    ArrayList<Article> arrayLists = null;
    ArticleDao articleDao = new ArticleDao();


    User user = (User) request.getSession().getAttribute("user");


    if (user == null) {
        out.println("<script>\n" +
                "    window.parent.location.href = \"/login.jsp\"\n" +
                "\n" +
                "</script>");
        return;
    }

    if (way.equals("all")) {
        arrayLists = articleDao.getAllArt(title, author);
    } else if (way.equals("myStar")) {

        arrayLists = articleDao.getArtStarByUserId(user.getUser_id());
    } else if (way.equals("my")) {
        arrayLists = articleDao.getArtByUserId(user.getUser_id());
    }
%>
<div class="formPop dis" id="formPop">
    <form name="artForm" id="artForm" action="/addArt" method="post">
        <div class="artForm-title">文章</div>
        <div class="artForm-item">
            <input name="way" value="<%=way%>" type="text" style="display: none">
            <input name="user_id" value="<%=user.getUser_id()%>" type="text" style="display: none">
        </div>
        <div class="artForm-item">
            文章名称
            <input class="inp" name="art_title" id="artTitle" type="text">
        </div>
        <div class="artForm-item">
            文章详情
            <textarea class="inp" name="art_detail" id="artDetail"></textarea>
        </div>
        <div class="artForm-item btns">
            <input class="btn" type="button" onclick="closePop()" value="取消">
            <input class="btn" type="button" onclick="addArt()" value="确认">
        </div>
    </form>
</div>

<div class="formPop dis" id="formPopE">
    <form name="artForm" id="artEditPop" action="/updateArt" method="post">
        <div class="artForm-title">文章</div>
        <div class="artForm-item">
            <input name="way" value="<%=way%>" type="text" style="display: none">
            <input name="art_id" id="artIdE" type="text" style="display: none">
        </div>
        <div class="artForm-item">
            文章名称
            <input class="inp" name="art_title" id="artTitleE" type="text">
        </div>
        <div class="artForm-item">
            文章详情
            <textarea class="inp" name="art_detail" id="artDetailE"></textarea>
        </div>
        <div class="artForm-item btns">
            <input class="btn" type="button" onclick="closeEdit()" value="取消">
            <input class="btn" type="button" onclick="editArt()" value="确认">
        </div>
    </form>
</div>

<div class="art">
    <div class="messagePop fail dis"></div>
    <div class="title">
        <%
            if (way.equals("all")) {
                out.println("所有文章");
            } else if (way.equals("myStar")) {
                out.println("我的收藏");
            } else if (way.equals("my")) {
                out.println("我的文章");
            } else {
                out.println("错误");
            }
        %>
    </div>
    <div class="search">
        <div></div>
        <form class="search-form" action="artList.jsp" method="get" style="<%
                if (!way.equals("all")) {
                    out.println("display: none");
                }
            %>">
            <input name="way" value="<%=way%>" type="text" style="display: none">
            文章名称<input name="title" value="<%=title%>" type="text">
            作者 <input name="author" value="<%=author%>" type="text">
            <input class="sub" type="submit" value="查询">
        </form>
        <%
            if (way.equals("my")) {
        %>
        <div class="art-show-add" onclick="openPop()">
            <svg class="art-show-add-img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1024 1024">
                <path fill="currentColor"
                      d="M480 480V128a32 32 0 0 1 64 0v352h352a32 32 0 1 1 0 64H544v352a32 32 0 1 1-64 0V544H128a32 32 0 0 1 0-64z"></path>
            </svg>
            添加文章
        </div>
        <%
            }
        %>
    </div>
    <div class="art-table-box">
        <table class="art-table">
            <tbody class="art-table-body" align="center">
            <tr class="art-table-title">
                <th>文章名称</th>
                <th style="<%
                        if (way.equals("my")) {
                            out.println("display: none");
                        }else {
                            out.println();
                        }
                    %>">文章作者
                </th>
                <th>创建时间</th>
                <th>编辑时间</th>
                <th>操作</th>
            </tr>
            <%
                for (Article arrayList : arrayLists) {
            %>
            <tr class="art-table-item">
                <td>
                    <div onclick="goToArtDetail(<%=arrayList.getArt_id()%>)" style="cursor: pointer">
                        <%=arrayList.getArt_title()%>
                    </div>
                </td>
                <td style="<%
                        if (way.equals("my")) {
                            out.println("display: none");
                        }else {
                            out.println();
                        }
                    %>"><%=arrayList.getArt_author()%>
                </td>
                <td><%=arrayList.getCreate_time()%>
                </td>
                <td><%=arrayList.getUpdate_time()%>
                </td>
                <td class="editBtns">
                    <%
                        if (way.equals("all")) {
                    %>
                    <form action="/star" method="post">
                        <input name="way" value="<%=way%>" type="text" style="display: none">
                        <input name="user_id" value="<%=user.getUser_id()%>" type="text" style="display: none">
                        <input name="art_id" value="<%=arrayList.getArt_id()%>" type="text" style="display: none">
                        <input class="btn" type="submit" value="收藏">
                    </form>
                    <%
                    } else if (way.equals("myStar")) {
                    %>
                    <form action="/unStarArt" method="post">
                        <input name="way" value="<%=way%>" type="text" style="display: none">
                        <input name="user_id" value="<%=user.getUser_id()%>" type="text" style="display: none">
                        <input name="art_id" value="<%=arrayList.getArt_id()%>" type="text" style="display: none">
                        <input class="btn" type="submit" value="取消收藏">
                    </form>
                    <%
                    } else if (way.equals("my")) {
                    %>
                    <input class="btn" type="button"
                           onclick="openEdit('<%=arrayList.getArt_id()%>', '<%=arrayList.getArt_title()%>', `<%=arrayList.getArt_detail()%>`)"
                           value="编辑">
                    <form action="/delArt" method="post">
                        <input name="way" value="<%=way%>" type="text" style="display: none">
                        <input name="user_id" value="<%=user.getUser_id()%>" type="text" style="display: none">
                        <input name="art_id" value="<%=arrayList.getArt_id()%>" type="text" style="display: none">
                        <input class="del" type="submit" value="删除">
                    </form>
                    <%
                        }
                    %>

                </td>
            </tr>
            <%
                }
            %>
            <%
                if (arrayLists.size() == 0) {
            %>
            <tr class="art-table-item">
                <td></td>
                <td>没有数据</td>
                <td></td>
                <td></td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>
</div>
<script>
    function openPop() {
        document.getElementById("formPop").className = "formPop"
    }

    function closePop() {
        document.getElementById("formPop").className = "formPop dis"
    }

    function addArt() {
        const artForm = document.getElementById("artForm")
        const artDiv = document.getElementsByClassName("art")[0]
        const mesBoxs = document.getElementsByClassName("messagePop")

        for (let i = 0; i < mesBoxs.length; i++) {
            setTimeout(() => {
                artDiv.removeChild(mesBoxs[i])
            }, 100)
        }

        const artTitle = document.getElementById("artTitle").value
        const artDetail = document.getElementById("artDetail").value


        if (artTitle === "" || artDetail === "") {
            artDiv.innerHTML = artDiv.innerHTML + "<div class=\"messagePop fail\">\n" + "不能为空" + "</div>"
        } else {
            artForm.submit()
        }
    }

    function openEdit(art_id, art_title, art_detail) {
        const artId = document.getElementById("artIdE")
        const artTitle = document.getElementById("artTitleE")
        const artDetail = document.getElementById("artDetailE")

        artId.value = art_id
        artTitle.value = art_title
        artDetail.value = art_detail

        document.getElementById("formPopE").className = "formPop"
    }

    function closeEdit() {
        document.getElementById("formPopE").className = "formPop dis"
    }

    function editArt() {
        const artEditPop = document.getElementById("artEditPop")
        const artDiv = document.getElementsByClassName("art")[0]
        const mesBoxs = document.getElementsByClassName("messagePop")

        for (let i = 0; i < mesBoxs.length; i++) {
            setTimeout(() => {
                artDiv.removeChild(mesBoxs[i])
            }, 100)
        }

        const artTitle = document.getElementById("artTitleE")
        const artDetail = document.getElementById("artDetailE")

        if (artTitle.value === "" || artDetail.value === "") {
            artDiv.innerHTML = artDiv.innerHTML + "<div class=\"messagePop fail\">\n" + "不能为空" + "</div>"
        } else {
            artEditPop.submit()
        }
    }

    function goToArtDetail(art_id) {
        window.parent.document.location.href = "index.jsp?way=detail&artId=" + art_id
    }
</script>
</body>
</html>
