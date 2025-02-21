<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>俱乐部广场</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Arial', sans-serif;
        }

        body {
            background-color: #f5f5f5;
            padding-top: 40px;
        }

        .club-introduction {
            width: 90%;
            max-width: 1200px;
            margin: 0 auto;
            text-align: center;
        }

        .club-introduction h1 {
            font-size: 32px;
            color: #333;
            margin-bottom: 40px;
        }

        .club-list {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
            justify-items: center;
        }

        .club-card {
            width: 100%;
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .club-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.15);
        }

        .club-card h2 {
            font-size: 24px;
            color: #333;
            margin-bottom: 15px;
        }

        .club-card h3 {
            font-size: 18px;
            color: #555;
            margin-bottom: 15px;
        }

        .club-card .introduction {
            font-size: 16px;
            color: #666;
            line-height: 1.5;
            height: 60px;
            overflow: hidden;
            text-overflow: ellipsis;
            display: -webkit-box;
            -webkit-box-orient: vertical;
            -webkit-line-clamp: 3;
            margin-bottom: 20px;
        }

        .club-card .message {
            margin-top: 20px;
        }

        .club-card .message p {
            font-size: 14px;
            color: #888;
            margin-bottom: 10px;
        }

        .club-card .message a {
            display: inline-block;
            padding: 8px 15px;
            background-color: #3498db;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s;
            margin-right: 10px;
        }

        .club-card .message a:hover {
            background-color: #2980b9;
        }

    </style>
</head>

<body>

<div class="club-introduction">
    <h1>欢迎来到俱乐部广场</h1>

    <div class="club-list">
        <c:forEach items="${clubList}" var="club">
            <div class="club-card">
                <h2>${club.clubName}</h2>
                <h3>俱乐部介绍</h3>
                <p class="introduction">${club.clubIntroduction}</p>
                <div class="message">
                    <p>俱乐部人数: ${club.clubNumbers} | 文件数: ${club.clubHasFiles}</p>
                    <a href="eachClubServlet?clubId=${club.clubId}">点击进入</a>
                    <a href="user_clubSaveServlet?clubId=${club.clubId}">点击加入</a>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

</body>

</html>
