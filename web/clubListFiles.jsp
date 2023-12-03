<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2023/12/3 0003
  Time: 13:59
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
            width: 1200px;
            height: 1000px;
            margin: 0 auto;
        }

        .file-introduction {
            width: 1000px;
            margin: 25px auto;
            height: 200px;
            border-bottom: 1px solid #dedede;
        }

        .file-introduction h1 {
            text-align: center;
        }

        .message {
            width: 1000px;
            height: 70px;
        }

        .message td {
            padding: 10px 10px 10px 0px;
        }

        .message a {
            float: right;
        }

        .news_info {
            color: #898a8b;
            font-size: 18px;
            line-height: 30px;
            height: 60px;
            max-height: 60px;
            overflow: hidden;
            /* 超出的文本隐藏 */
            text-overflow: ellipsis;
            /* 溢出用省略号显示 */
            display: -webkit-box;
            /* 将对象作为弹性伸缩盒子模型显示 */
            -webkit-box-orient: vertical;
            /* 这个属性不是css的规范属性，需要组合上面两个属性，表示显示的行数 */
            -webkit-line-clamp: 2;
            /*  从上到下垂直排列子元素（设置伸缩盒子的子元素排列方式） */
        }
    </style>
</head>

<body>
<div class="main">
    <div class="file-introduction">
        <c:forEach items="${clubList}" var="club">
            <h1>${club.clubName}</h1>
            <h3>俱乐部介绍</h3>
            <p class="news_info">${club.clubIntroduction}</p>
            <div class="message">
                <table>
                    <tr>
                        <td>俱乐部人数${club.clubNumbers}</td>
                        <td>俱乐部文件数${club.clubHasFiles}</td>
                    </tr>
                </table>
                <a href="user_clubSaveServlet?clubId=${club.clubId}">点击加入</a>
                
                <a href="eachClubServlet?clubId=${club.clubId}">点击进入</a>
            </div>
        </c:forEach>
    </div>
</div>
</body>

</html>