<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="JS/jquery-3.7.1.js" charset="utf-8"></script>
    <title>我的俱乐部</title>
    <link rel="stylesheet" href="fonts/iconfont.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: "Arial", sans-serif;
        }

        body {
            background: linear-gradient(135deg, #f0f4f8, #d9e2ec);
            min-height: 100vh;
        }

        .main {
            width: 90%;
            max-width: 1200px;
            margin: 20px auto;
            background: #fff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
        }

        /* 头部区域（返回按钮和搜索框） */
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        /* 返回按钮 */
        .back a {
            display: inline-block;
            padding: 8px 12px;
            color: black;
            text-decoration: none;
            border-radius: 8px;
            font-size: 16px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .back .iconfont {
            font-size: 18px;
            vertical-align: middle;
        }

        /* 搜索框 */
        .search-box {
            width: 100%;
            max-width: 500px;
            display: flex;
            align-items: center;
            background: #f1f2f3; /* 默认暗色背景 */
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            transition: background 0.3s ease, box-shadow 0.3s ease;
        }

        .search-box:hover {
            background: #ffffff; /* 明亮背景 */
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.15);
        }

        .search-box:hover .search-button:hover + * {
            background: #f1f2f3; /* 恢复暗色 */
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .search-box input {
            flex: 1;
            height: 40px;
            font-size: 16px;
            border: none;
            padding: 0 15px;
            outline: none;
            background: transparent;
            color: #333; /* 深灰色文字，确保在所有背景下可见 */
            border-radius: 8px 0 0 8px;
            cursor: text;
        }

        .search-box input::placeholder {
            color: #ccc;
            opacity: 0.8;
        }

        .search-box button {
            height: 40px;
            padding: 0 15px;
            background: #fff;
            color: #333;
            border: none;
            cursor: pointer;
            border-radius: 0 8px 8px 0;
            transition: background 0.3s ease, color 0.3s ease, transform 0.3s ease;
            font-size: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .search-box button:hover {
            background: #f0f4f8;
            color: #333;
            transform: scale(1.05);
        }

        .search-box button:active {
            transform: scale(0.98);
        }

        /* 俱乐部信息 */
        .club_message {
            display: flex;
            align-items: center; /* 横向排列 */
            background: #fff;
            padding: 15px;
            border-radius: 12px;
            margin-bottom: 10px; /* 俱乐部之间的间距 */
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            transition: transform 0.3s ease;
        }

        .club_message:hover {
            transform: translateY(-2px); /* 轻微上浮效果 */
        }

        .club_message img {
            width: 50px; /* 头像大小匹配图示 */
            height: 50px;
            object-fit: cover;
            border-radius: 50%; /* 圆形头像 */
            margin-right: 15px;
        }

        .club_details {
            flex: 1;
        }

        .club_message h4 {
            font-size: 18px; /* 调整字体大小以匹配图示 */
            color: #2c3e50;
            margin-bottom: 5px;
            font-weight: 600;
        }

        .club_message p {
            font-size: 14px; /* 调整人数字体大小 */
            color: #7f8c8d;
            margin: 0;
        }

        /* 按钮样式 */
        .club_message a {
            width: 80px; /* 调整按钮宽度以匹配图示 */
            padding: 8px 16px; /* 按钮大小 */
            font-size: 14px; /* 文字大小 */
            text-decoration: none;
            border-radius: 6px;
            text-align: center;
            line-height: 1;
            white-space: nowrap;
            cursor: pointer;
            transition: transform 0.3s ease, background 0.3s ease;
        }

        /* 加入按钮（未关注） */
        .join-btn {
            background-color: #eb435a; /* 红色 */
            color: white;
        }

        .join-btn:hover {
            background-color: #cc0000; /* 更深的红色 */
            transform: scale(1.05);
        }

        .join-btn:active {
            transform: scale(0.98) translateY(1px);
        }

        /* 已加入按钮（已关注） */
        .joined-btn {
            background-color: #f3f3f3; /* 灰色 */
            color: #333;
        }

        .joined-btn:hover {
            background-color: #e0e0e0; /* 更深的灰色 */
            transform: scale(1.05);
        }

        .joined-btn:active {
            transform: scale(0.98) translateY(1px);
        }

        /* 更多按钮（省略号） */
        .more-options {
            margin-left: 10px;
            color: #333;
            font-size: 16px;
            cursor: pointer;
        }

        @media (max-width: 768px) {
            .main {
                width: 90%;
                padding: 15px;
            }

            .header {
                flex-direction: column;
                gap: 10px;
            }

            .search-box {
                max-width: 100%;
            }

            .club_message {
                padding: 10px;
            }

            .club_message img {
                width: 40px;
                height: 40px;
            }

            .club_message h4 {
                font-size: 16px;
            }

            .club_message p {
                font-size: 12px;
            }

            .club_message a {
                width: 70px;
                padding: 6px 12px;
                font-size: 12px;
            }
        }
    </style>
</head>

<body>
<div class="main">
    <%-- 标头 --%>
    <div class="header">
        <div class="back">
            <a href="index.jsp" class="iconfont" title="返回主页">&#xe63b;</a>
        </div>
        <div class="search-box">
            <form action="myClubsListServlet" method="post" style="display: flex; width: 100%;">
                <input type="text" name="searchContent" placeholder="请输入俱乐部名" id="searchContent">
                <button type="submit" class="iconfont"></button>
            </form>
        </div>
    </div>
    <%-- 俱乐部信息 --%>
    <c:forEach items="${user_clubList}" var="club">
        <div class="club_message">
            <a href="eachClubServlet?clubId=${club.cId}&type=2"><img src="${club.clubImgPath}" alt=""></a>
            <div class="club_details">
                <h4>${club.clubName}</h4>
                <p class="club-numbers" data-club-id="${club.cId}">${club.clubNumbers} 个粉丝</p>
            </div>
            <c:if test="${operation == 1}">
                <a href="#" class="join-btn" data-club-id="${club.cId}" data-operation="${club.operation}">关注</a>
            </c:if>
            <c:if test="${operation == 0}">
                <a href="#" class="joined-btn" data-club-id="${club.cId}"
                   data-operation="${operation}">已关注</a>
            </c:if>
        </div>
    </c:forEach>
</div>

<script>
    // 为每个按钮绑定独立的点击事件
    $(".join-btn, .joined-btn").click(function (e) {
        e.preventDefault(); // 阻止默认链接行为
        const button = $(this);
        const clubId = button.data("club-id");
        const operation = button.data("operation");

        $.post("user_clubOperationServlet",
            {clubId: clubId, operation: operation},
            function (res) {
                // 动态切换按钮样式和文本
                button.removeClass("join-btn joined-btn")
                    .addClass(res.operation == 1 ? "join-btn" : "joined-btn")
                    .text(res.operation == 1 ? "关注" : "已关注");
                // 更新 operation 值
                button.data("operation", res.operation);
                // 更新对应俱乐部的人数
                const clubNumbersElement = button.closest(".club_message").find(".club-numbers");
                clubNumbersElement.text(res.clubNumbers + " 个粉丝");
            }, "json")
            .fail(function () {
                alert("操作失败，请稍后重试");
            });
    });
</script>
</body>
</html>