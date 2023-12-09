<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2023/12/3 0003
  Time: 13:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

        .club-introduction {
            width: 1300px;
            margin: 25px auto;
        }

        .club-introduction h1 {
            text-align: center;
            margin-bottom: 30px;
        }

        .introduction {
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

        .club {
            width: 400px;
            /* border-bottom: 1px solid #dedede; */
            border: 1px solid pink;
            display: inline-block;
            margin: 10px 10px;
        }
    </style>
</head>

<body>
<div class="club-introduction">
    <h1>欢迎来到俱乐部</h1>
    <c:forEach items="${clubList}" var="club">
        <div class="club">
            <h1>${club.clubName}</h1>
            <h3>俱乐部介绍</h3>
            <p class="introduction">${club.clubIntroduction}</p>
            <div class="message">
                <p>俱乐部人数${club.clubNumbers}</p>
                <p>俱乐部文件数${club.clubHasFiles}</p>
                <a href="eachClubServlet?clubId=${club.clubId}">点击进入</a>
                <a href="user_clubSaveServlet?clubId=${club.clubId}">点击加入</a>
            </div>
        </div>
    </c:forEach>
</div>
</body>

</html>