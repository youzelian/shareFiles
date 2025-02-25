<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>俱乐部广场</title>
    <link rel="stylesheet" href="fonts/font_back/iconfont.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Arial', sans-serif;
        }

        body {
            background: linear-gradient(135deg, #f0f4f8, #d9e2ec); /* 与 addFile.jsp 一致的渐变背景 */
            padding-top: 40px;
            height: auto;
            color: #333;
        }

        .club-introduction {
            width: 90%;
            max-width: 1200px;
            margin: 0 auto;
            text-align: center;
            padding-bottom: 60px; /* 增加底部留白 */
            position: relative; /* 使返回按钮定位的父级 */
        }

        .club-introduction h1 {
            font-size: 36px; /* 标题更大 */
            color: #2c3e50; /* 深色标题 */
            margin-bottom: 40px;
            font-weight: 700;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* 添加微妙阴影 */
        }

        /* 返回按钮样式 */
        .back {
            position: absolute; /* 绝对定位 */
            top: 0; /* 顶部对齐 */
            left: 0; /* 左边对齐 */
            margin: 10px; /* 外边距 */
        }

        .back a {
            display: inline-block;
            padding: 8px 12px; /* 调整内边距 */
            background: linear-gradient(90deg, #3498db, #2980b9); /* 与页面蓝色主题一致的渐变 */
            color: white;
            text-decoration: none;
            border-radius: 8px; /* 圆角与卡片一致 */
            font-size: 16px; /* 字体大小 */
            transition: background 0.3s ease, transform 0.2s ease; /* 动画效果 */
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); /* 微妙阴影 */
        }

        .back a:hover {
            background: linear-gradient(90deg, #2980b9, #1f6391); /* 悬停时渐变变化 */
        }

        .back a:active {
            transform: translateY(1px); /* 点击时下沉 */
        }

        .back .iconfont {
            font-size: 18px; /* 调整图标大小 */
            vertical-align: middle; /* 图标垂直居中 */
        }

        .club-list {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr)); /* 卡片稍宽 */
            gap: 25px; /* 增加间距 */
            justify-items: center;
        }

        .club-card {
            width: 100%;
            background: #fff;
            padding: 25px;
            border-radius: 12px; /* 更大圆角 */
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05); /* 更柔和阴影 */
            transition: transform 0.3s ease, box-shadow 0.3s ease, opacity 5s ease; /* 保持你的淡入时间 */
            opacity: 1;
            border: 1px solid #dfe6e9; /* 添加细边框 */
        }

        .club-card.hidden {
            opacity: 0;
            visibility: hidden;
            height: 0;
            margin: 0;
            overflow: hidden;
            transition: height 0s, opacity 5s ease; /* 保持你的淡入时间 */
        }

        .club-card.visible {
            opacity: 1;
            visibility: visible;
            height: auto;
            margin-bottom: 25px; /* 一致间距 */
        }

        .club-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1); /* 悬停时阴影更明显 */
        }

        .club-card h2 {
            font-size: 26px; /* 标题稍大 */
            color: #2c3e50; /* 深色标题 */
            margin-bottom: 15px;
            font-weight: 600;
        }

        .club-card .introduction {
            font-size: 16px;
            color: #666;
            line-height: 1.6; /* 更舒适的行距 */
            margin-bottom: 20px;
            overflow: hidden;
            text-overflow: ellipsis;
            display: -webkit-box;
            -webkit-box-orient: vertical;
            -webkit-line-clamp: 3;
        }

        .club-card .members {
            font-size: 14px;
            color: #7f8c8d; /* 柔和灰色 */
            margin-bottom: 15px;
        }

        .club-card .message {
            margin-top: 20px;
            display: flex;
            flex-direction: column;
            gap: 10px; /* 按钮和文本间距 */
        }

        .club-card .message p {
            font-size: 14px;
            color: #888;
        }

        .club-card .message a {
            display: inline-block;
            padding: 10px 20px; /* 按钮更大 */
            background: linear-gradient(90deg, #3498db, #2980b9); /* 渐变按钮 */
            color: white;
            text-decoration: none;
            border-radius: 8px; /* 更大圆角 */
            transition: background 0.3s ease, transform 0.2s ease;
            font-size: 14px;
            text-align: center;
        }

        .club-card .message a:hover {
            background: linear-gradient(90deg, #2980b9, #1f6391);
        }

        .club-card .message a:active {
            transform: translateY(1px); /* 点击时下沉 */
        }

        @media (max-width: 768px) {
            .club-list {
                grid-template-columns: repeat(auto-fill, minmax(280px, 1fr)); /* 移动端稍窄 */
            }

            .club-introduction h1 {
                font-size: 28px; /* 移动端标题缩小 */
            }

            .back {
                margin: 5px; /* 移动端缩小外边距 */
            }

            .back a {
                padding: 6px 10px; /* 移动端按钮缩小 */
            }
        }
    </style>
</head>

<body>
<div class="club-introduction">
    <div class="back">
        <a href="index.jsp" class="iconfont" title="返回"></a>
    </div>
    <h1>欢迎来到俱乐部广场</h1>
    <div class="club-list">
        <c:forEach items="${clubList}" var="club" varStatus="loop">
            <div class="club-card ${loop.index >= 6 ? 'hidden' : ''}">
                <h2>${club.clubName}</h2>
                <p class="introduction">${club.clubIntroduction}</p>
                <p class="members">${club.clubNumbers} ${club.clubMembership} 成员</p>
                <div class="message">
                    <p>文件数: ${club.clubHasFiles}</p>
                    <a href="eachClubServlet?clubId=${club.clubId}">点击进入</a>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        const clubCards = document.querySelectorAll('.club-card');
        clubCards.forEach((card, index) => {
            if (index < 6) {
                card.classList.remove('hidden');
                card.classList.add('visible');
            }
        });

        const visibleCards = document.querySelectorAll('.club-card.visible');
        if (visibleCards.length > 0) {
            const list = document.querySelector('.club-list');
            list.style.minHeight = `${window.innerHeight}px`;
        }
    });

    window.addEventListener('scroll', function () {
        const clubCards = document.querySelectorAll('.club-card.hidden');
        const windowHeight = window.innerHeight;
        const scrollBottom = window.scrollY + windowHeight;

        clubCards.forEach(card => {
            const cardTop = card.getBoundingClientRect().top + window.scrollY;
            if (scrollBottom > cardTop + 50) {
                card.classList.remove('hidden');
                card.classList.add('visible');
            }
        });
    });
</script>
</body>
</html>