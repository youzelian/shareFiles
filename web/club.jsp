<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>俱乐部广场</title>
    <link rel="stylesheet" href="fonts/iconfont.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Arial', 'PingFang SC', sans-serif; /* 添加中文字体支持 */
        }

        body {
            background: linear-gradient(135deg, #e9f1f6, #c8d8e4); /* 更柔和的渐变 */
            padding-top: 50px;
            min-height: 100vh;
            color: #333;
            overflow-x: hidden; /* 防止水平溢出 */
        }

        .club-introduction {
            width: 90%;
            max-width: 1280px; /* 更宽的容器 */
            margin: 0 auto;
            text-align: center;
            padding-bottom: 80px;
            position: relative;
            animation: fadeIn 0.8s ease-in-out; /* 页面加载动画 */
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .club-introduction h1 {
            font-size: 40px;
            color: #1e2a38; /* 更深沉的标题色 */
            margin-bottom: 50px;
            font-weight: 800;
            letter-spacing: 1px; /* 增加字符间距 */
            background: linear-gradient(90deg, #3498db, #2ecc71); /* 渐变文字 */
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            text-shadow: 0 3px 6px rgba(0, 0, 0, 0.1);
        }

        /* 返回按钮 */
        .back {
            position: absolute;
            top: 10px;
            left: 10px;
        }

        .back a {
            display: flex;
            align-items: center;
            padding: 8px 14px;
            background: linear-gradient(45deg, #3498db, #2ecc71); /* 更活泼的渐变 */
            color: white;
            text-decoration: none;
            border-radius: 10px;
            font-size: 16px;
            transition: all 0.3s ease;
            box-shadow: 0 3px 8px rgba(0, 0, 0, 0.15);
        }

        .back a:hover {
            background: linear-gradient(45deg, #2980b9, #27ae60);
            transform: scale(1.05); /* 轻微放大 */
        }

        .back a:active {
            transform: scale(0.95); /* 点击缩小 */
        }

        .back .iconfont {
            font-size: 20px;
            margin-right: 5px; /* 图标与文字间距 */
        }

        .club-list {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(340px, 1fr)); /* 卡片更宽松 */
            gap: 30px;
            justify-items: center;
            padding: 0 20px; /* 增加两侧内边距 */
        }

        .club-card {
            width: 100%;
            background: #fff;
            padding: 30px;
            border-radius: 16px; /* 更圆润 */
            box-shadow: 0 6px 18px rgba(0, 0, 0, 0.06);
            transition: all 0.4s ease;
            border: 1px solid rgba(223, 230, 233, 0.5);
            position: relative;
            overflow: hidden; /* 防止内容溢出 */
        }

        .club-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 4px;
            background: linear-gradient(90deg, #3498db, #2ecc71); /* 卡片顶部装饰线 */
        }

        .club-card.hidden {
            opacity: 0;
            transform: translateY(20px); /* 初始偏移 */
            visibility: hidden;
            height: 0;
            margin: 0;
            overflow: hidden;
            transition: opacity 0.5s ease, transform 0.5s ease, height 0s 0.5s;
        }

        .club-card.visible {
            opacity: 1;
            transform: translateY(0);
            visibility: visible;
            height: auto;
            margin-bottom: 30px;
        }

        .club-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 12px 25px rgba(0, 0, 0, 0.12);
        }

        .club-card h2 {
            font-size: 28px;
            color: #1e2a38;
            margin-bottom: 18px;
            font-weight: 700;
            letter-spacing: 0.5px;
        }

        .club-card .introduction {
            font-size: 16px;
            color: #555;
            line-height: 1.7;
            margin-bottom: 20px;
            overflow: hidden;
            text-overflow: ellipsis;
            display: -webkit-box;
            -webkit-box-orient: vertical;
            -webkit-line-clamp: 3;
        }

        .club-card .members {
            font-size: 14px;
            color: #95a5a6;
            margin-bottom: 20px;
            font-style: italic; /* 增加趣味性 */
        }

        .club-card .message {
            margin-top: 25px;
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .club-card .message p {
            font-size: 14px;
            color: #777;
        }

        .club-card .message a {
            padding: 12px 24px;
            background: linear-gradient(45deg, #3498db, #2ecc71);
            color: white;
            text-decoration: none;
            border-radius: 10px;
            font-size: 15px;
            font-weight: 500;
            transition: all 0.3s ease;
            box-shadow: 0 3px 8px rgba(0, 0, 0, 0.1);
        }

        .club-card .message a:hover {
            background: linear-gradient(45deg, #2980b9, #27ae60);
            transform: scale(1.03);
        }

        .club-card .message a:active {
            transform: scale(0.97);
        }

        @media (max-width: 768px) {
            .club-list {
                grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
                gap: 20px;
            }

            .club-introduction h1 {
                font-size: 32px;
            }

            .club-card {
                padding: 25px;
            }

            .back a {
                padding: 6px 12px;
            }
        }

        @media (max-width: 480px) {
            .club-introduction h1 {
                font-size: 26px;
            }

            .club-card h2 {
                font-size: 24px;
            }
        }
    </style>
</head>

<body>
<div class="club-introduction">
    <div class="back">
        <a href="index.jsp" class="iconfont" title="返回"> 返回</a>
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
    // 让页面一开始只显示6个，后面页面滑动后再呈现
    document.addEventListener('DOMContentLoaded', function () {
        const clubCards = document.querySelectorAll('.club-card');
        clubCards.forEach((card, index) => {
            if (index < 6) {
                card.classList.remove('hidden');
                card.classList.add('visible');
            }
        });
        // 防止页面高度低导致无法滑动
        const visibleCards = document.querySelectorAll('.club-card.visible');
        if (visibleCards.length > 0) {
            const list = document.querySelector('.club-list');
            list.style.minHeight = `${window.innerHeight - 100}px`; /* 调整最小高度 */
        }
    });
    
    // 设置滑动距离
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