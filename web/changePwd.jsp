<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2023/11/27 0027
  Time: 15:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <style>
        * {
            margin: 0;
            padding: 0;
        }

        .main {
            width: 200px;
            margin: 0 auto;
            clear: both;
            position: relative;
        }
    </style>
</head>

<body>
<div class="main">
    <div class="body">
        <form action="changePwdServlet" method="post">
            <%
                String userName = request.getParameter("userName");
            %>
            <input type="text" name="userName" placeholder="用户名" value="<%=userName%>" hidden><br>
            <input type="password" name="oldPwd" placeholder="请输入旧密码"><br>
            <input type="password" name="newPwd1" placeholder="请输入新密码"><br>
            <input type="password" name="newPwd2" placeholder="再次确认新密码"><br>
            <label id="tips"></label>
            <input type="submit" name="" value="提交"><br>
        </form>
    </div>
</div>
</body>

</html>
