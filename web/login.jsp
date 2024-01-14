<%--
  Created by IntelliJ IDEA.
  User: GMCY
  Date: 2023/12/23
  Time: 17:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="Beans.User" %>
<%@ page import="Dao.UserDao" %>
<%@ page import="java.nio.charset.StandardCharsets" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
    <link type="text/css" rel="stylesheet" href="css/main.css">
    <link type="text/css" rel="stylesheet" href="css/login.css">
</head>
<body>
<script>

</script>
<div class="login">
    <%
        Object isRes = request.getSession().getAttribute("isRes");

        if (isRes != null) {
            if (isRes.toString().equals("0")) {
                out.print(
                        "<div class=\"messagePop fail\">\n" +
                                "用户存在" +
                                "</div>"
                );
            } else if (isRes.toString().equals("1")) {
                out.print(
                        "<div class=\"messagePop fail\">\n" +
                                "注册成功" +
                                "</div>"
                );
            }
            request.getSession().setAttribute("isRes", null);
        } else {
            isRes = "1";
            request.getSession().setAttribute("mes", null);

            String username = request.getParameter("username");
            String password = request.getParameter("password");

            if (username == null || password == null) {
                username = "";
                password = "";
            }

            username = new String(username.getBytes(StandardCharsets.ISO_8859_1), StandardCharsets.UTF_8);
            password = new String(password.getBytes(StandardCharsets.ISO_8859_1), StandardCharsets.UTF_8);

            UserDao userDao = new UserDao();

            User user = userDao.login(username, password);

            if (user.getUser_id().equals("-1")) {
                out.print(
                        "<div class=\"messagePop fail\">\n" +
                                "用户不存在" +
                                "</div>"
                );
            } else if (user.getUser_id().equals("-2")) {
                out.print(
                        "<div class=\"messagePop fail\">\n" +
                                "密码错误" +
                                "</div>"
                );
            } else {
                out.print(
                        "<div class=\"messagePop success\">\n" +
                                "登录成功" +
                                "</div>"
                );
                request.getSession().setAttribute("user", user);
                request.getRequestDispatcher("index.jsp").forward(request, response);
            }
        }
    %>

    <div class="login-left"></div>
    <div class="login-right  <%
        if (isRes.toString().equals("0")) {
            out.println("dis");
        }
      %>" id="login">
        <div class="login-box">
            <div class="login-title">登录</div>
            <form class="login-form" method="post" action="login.jsp">
                <div class="login-form-item">
                    <svg class="login-form-item-img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1024 1024">
                        <path fill="currentColor"
                              d="M512 512a192 192 0 1 0 0-384 192 192 0 0 0 0 384m0 64a256 256 0 1 1 0-512 256 256 0 0 1 0 512m320 320v-96a96 96 0 0 0-96-96H288a96 96 0 0 0-96 96v96a32 32 0 1 1-64 0v-96a160 160 0 0 1 160-160h448a160 160 0 0 1 160 160v96a32 32 0 1 1-64 0"></path>
                    </svg>
                    <input type="text" placeholder="用户名称" name="username">
                </div>
                <div class="login-form-item">
                    <svg class="login-form-item-img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1024 1024">
                        <path fill="currentColor"
                              d="M224 448a32 32 0 0 0-32 32v384a32 32 0 0 0 32 32h576a32 32 0 0 0 32-32V480a32 32 0 0 0-32-32zm0-64h576a96 96 0 0 1 96 96v384a96 96 0 0 1-96 96H224a96 96 0 0 1-96-96V480a96 96 0 0 1 96-96"></path>
                        <path fill="currentColor"
                              d="M512 544a32 32 0 0 1 32 32v192a32 32 0 1 1-64 0V576a32 32 0 0 1 32-32m192-160v-64a192 192 0 1 0-384 0v64zM512 64a256 256 0 0 1 256 256v128H256V320A256 256 0 0 1 512 64"></path>
                    </svg>
                    <input type="password" placeholder="密码" name="password">
                </div>
                <input class="login-btn" type="button" onclick="loginClick()" value="登录">
            </form>
            <div class="login-change">注册 →</div>
        </div>
    </div>

    <div class="login-right <%
        if (!isRes.toString().equals("0")) {
            out.println("dis");
        }
      %>" id="register">
        <div class="login-box">
            <div class="login-title">注册</div>
            <form class="login-form" action="/res" method="post">
                <div class="login-form-item">
                    <svg class="login-form-item-img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1024 1024">
                        <path fill="currentColor"
                              d="M512 512a192 192 0 1 0 0-384 192 192 0 0 0 0 384m0 64a256 256 0 1 1 0-512 256 256 0 0 1 0 512m320 320v-96a96 96 0 0 0-96-96H288a96 96 0 0 0-96 96v96a32 32 0 1 1-64 0v-96a160 160 0 0 1 160-160h448a160 160 0 0 1 160 160v96a32 32 0 1 1-64 0"></path>
                    </svg>
                    <input type="text" placeholder="用户名称" name="username">
                </div>
                <div class="login-form-item">
                    <svg class="login-form-item-img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1024 1024">
                        <path fill="currentColor"
                              d="M224 448a32 32 0 0 0-32 32v384a32 32 0 0 0 32 32h576a32 32 0 0 0 32-32V480a32 32 0 0 0-32-32zm0-64h576a96 96 0 0 1 96 96v384a96 96 0 0 1-96 96H224a96 96 0 0 1-96-96V480a96 96 0 0 1 96-96"></path>
                        <path fill="currentColor"
                              d="M512 544a32 32 0 0 1 32 32v192a32 32 0 1 1-64 0V576a32 32 0 0 1 32-32m192-160v-64a192 192 0 1 0-384 0v64zM512 64a256 256 0 0 1 256 256v128H256V320A256 256 0 0 1 512 64"></path>
                    </svg>
                    <input type="password" placeholder="密码" name="password">
                </div>
                <div class="login-form-item">
                    <svg class="login-form-item-img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1024 1024">
                        <path fill="currentColor"
                              d="M224 448a32 32 0 0 0-32 32v384a32 32 0 0 0 32 32h576a32 32 0 0 0 32-32V480a32 32 0 0 0-32-32zm0-64h576a96 96 0 0 1 96 96v384a96 96 0 0 1-96 96H224a96 96 0 0 1-96-96V480a96 96 0 0 1 96-96"></path>
                        <path fill="currentColor"
                              d="M512 544a32 32 0 0 1 32 32v192a32 32 0 1 1-64 0V576a32 32 0 0 1 32-32m192-160v-64a192 192 0 1 0-384 0v64zM512 64a256 256 0 0 1 256 256v128H256V320A256 256 0 0 1 512 64"></path>
                    </svg>
                    <input type="password" placeholder="密码" name="rePassword">
                </div>
                <input class="login-btn" type="button" onclick="registerClick()" value="注册">
            </form>
            <div class="login-change">登录 →</div>
        </div>
    </div>
</div>
<script>
    const login = document.getElementsByClassName("login-change")[0]
    const register = document.getElementsByClassName("login-change")[1]

    login.addEventListener("mousedown", changeLogin)
    register.addEventListener("mousedown", changeLogin)

    function changeLogin() {
        const loginBox = document.getElementById("login")
        const registerBox = document.getElementById("register")

        if (loginBox.classList.contains('dis')) {
            loginBox.className = "login-right"
            registerBox.className = "login-right dis"
        } else {
            loginBox.className = "login-right dis"
            registerBox.className = "login-right"
        }
    }


    function loginClick() {
        const loginDiv = document.getElementsByClassName("login")[0]
        const mesBox = document.getElementsByClassName("messagePop")[0]

        loginDiv.removeChild(mesBox)

        const lf = document.getElementsByClassName("login-form")[0]
        if (lf.username.value === "" || lf.password.value === "") {
            loginDiv.innerHTML = loginDiv.innerHTML + "<div class=\"messagePop fail\">\n" + "不能为空" + "</div>"
        } else {
            lf.submit()
        }
    }

    function registerClick() {
        const loginDiv = document.getElementsByClassName("login")[0]
        const mesBox = document.getElementsByClassName("messagePop")[0]

        loginDiv.removeChild(mesBox)

        const lf = document.getElementsByClassName("login-form")[1]
        if (lf.username.value === "" || lf.password.value === "" || lf.rePassword.value === "") {
            loginDiv.innerHTML = loginDiv.innerHTML + "<div class=\"messagePop fail\">\n" + "不能为空" + "</div>"
        } else if (lf.password.value !== lf.rePassword.value) {
            loginDiv.innerHTML = loginDiv.innerHTML + "<div class=\"messagePop fail\">\n" + "两次密码不一致" + "</div>"
        } else {
            lf.submit()
        }
    }
</script>
</body>
</html>
