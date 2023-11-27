<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2023/11/22 0022
  Time: 20:19
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
        <form action="forgetPwdServlet" method="post">
            <input type="text" name="userName" placeholder="请填写用户名"><br>
            密保问题
            <select id="question" name="pwdReq">
                <!--selected设置默认选中-->
                <option value="初恋的名字" selected="selected">初恋的名字</option>
                <option value="小学校名">小学校名</option>
                <option value="玩的最好的朋友">玩的最好的朋友</option>
                <option value="喜欢看的电影">喜欢看的电影</option>
                <option value="您的母亲的名字">您的母亲的名字</option>
                <option value="出生地">出生地</option>
            </select>
            <input type="text" name="pwdReqAnswer" placeholder="请填写密保答案"><br>
            <input type="text" name="newPwd1" placeholder="请输入新密码"><br>
            <input type="text" name="newPwd2" placeholder="再次确认新密码"><br>
            <label id="tips"></label>
            <input type="submit" name="" value="提交"><br>
        </form>
    </div>
</div>
</body>

</html>
