<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2023/11/21 0021
  Time: 13:12
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
        body {
            padding: 0px;
            margin: 0px;
        }

        #container {
            width: 100%;
            height: 920px;
        }
    </style>
</head>

<body>
<table id="container" cellpadding="0">
    <tr height="120px">
        <td colspan="2" style="background:deepskyblue">
            <label style="color:white;font-size:35px;font-family:楷体;">在线书城后台管理系统</label>
        </td>
    </tr>
    <tr>
        <td width="220px" valign="top" style="padding-top :20px;padding-left:20px;border-right:1px lightblue solid">
            图书信息管理
            <ul style="list-style:none">
                <!--  target="mainFrame" -->
                <li><a href="communityFiles.jsp">社区文件夹</a></li>
                <li><a href="myClubsListServlet">社团文件夹</a></li>
            </ul>
            订单管理
            <ul style="list-style:none">
                <li><a href="myFilesListServlet">我的文件夹</a></li>
                <li><a href="clubListServlet">添加文件</a></li>
                <li><a href="ownPage.jsp">我的信息</a></li>
                <li><a href="changePwd.jsp">修改密码</a></li>
                <li><a href="logoutServlet">登出</a></li>
            </ul>
        </td>
        <!-- <td>
            <iframe src="" frameborder="0" name="mainFrame" width="100%" height="800"></iframe>
        </td> -->
    </tr>
</table>
</body>

</html>
