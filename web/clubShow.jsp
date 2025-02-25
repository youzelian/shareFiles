<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="JS/jquery-3.7.1.js" charset="utf-8"></script>
    <title>社区资源</title>
    <link rel="stylesheet" href="fonts/font_back/iconfont.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: "Arial", sans-serif;
        }

        body {
            background: linear-gradient(135deg, #f0f4f8, #d9e2ec); /* 渐变背景，与 club.jsp 一致 */
            min-height: 100vh;
        }

        .main {
            width: 90%;
            max-width: 1200px;
            margin: 20px auto;
            background: #fff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05); /* 更柔和的阴影 */
        }

        /* 头部区域（返回按钮和搜索框） */
        .header {
            display: flex;
            justify-content: space-between; /* 返回按钮和搜索框在同一行，两端对齐 */
            align-items: center;
            margin-bottom: 20px;
        }

        /* 返回按钮 */
        .back a {
            display: inline-block;
            padding: 8px 12px;
            background: linear-gradient(90deg, #3498db, #2980b9); /* 蓝色渐变 */
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-size: 16px;
            transition: background 0.3s ease, transform 0.2s ease;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .back a:hover {
            background: linear-gradient(90deg, #2980b9, #1f6391);
            transform: translateY(-2px);
        }

        .back a:active {
            transform: translateY(1px);
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
            background: linear-gradient(90deg, #3498db, #2980b9); /* 渐变背景 */
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .search-box input {
            flex: 1;
            height: 40px;
            font-size: 16px;
            border: none;
            padding: 0 15px;
            outline: none;
            background: #fff;
            border-radius: 8px 0 0 8px;
        }

        .search-box button {
            height: 40px;
            padding: 0 20px;
            background: #fff;
            color: #3498db;
            border: none;
            cursor: pointer;
            border-radius: 0 8px 8px 0;
            transition: background 0.3s ease, color 0.3s ease;
            font-weight: bold;
        }

        .search-box button:hover {
            background: #2980b9;
            color: white;
        }

        /* 俱乐部信息 */
        .club_message {
            display: flex;
            flex-direction: column; /* 改为纵向排列 */
            background: #fff;
            padding: 20px;
            border-radius: 12px;
            margin-bottom: 20px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
            overflow: hidden;
        }

        .club_message .top-row {
            display: flex;
            align-items: center;
            gap: 20px; /* 前四个标签在同一行 */
            margin-bottom: 15px; /* 与简介分隔 */
        }

        .club_message img {
            width: 100px;
            height: 100px;
            object-fit: cover;
            border-radius: 8px;
        }

        .club_details {
            flex: 1; /* 占据可用空间 */
        }

        .club_message h4 {
            font-size: 24px;
            color: #2c3e50;
            margin-bottom: 5px;
            font-weight: 600;
        }

        .club_message p:not(.introduction) {
            font-size: 16px;
            color: #7f8c8d;
            margin-bottom: 10px;
        }

        .club_introduction {
            margin-top: 15px; /* 确保简介另起一行 */
        }

        .club_message .introduction {
            font-size: 14px;
            color: #666;
            line-height: 1.6;
            margin: 0;
        }

        .club_message a {
            display: inline-block;
            padding: 8px 16px;
            background: linear-gradient(90deg, #3498db, #2980b9);
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-size: 14px;
            transition: background 0.3s ease, transform 0.2s ease;
            white-space: nowrap;
        }

        .club_message a:hover {
            background: linear-gradient(90deg, #2980b9, #1f6391);
            transform: translateY(-2px);
        }

        .club_message a:active {
            transform: translateY(1px);
        }

        /* 文件介绍 */
        .file-introduction {
            margin-top: 20px;
            padding: 20px;
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
            transition: transform 0.3s ease;
        }

        .file-introduction:hover {
            transform: translateY(-5px);
        }

        .file-introduction h1 {
            font-size: 22px;
            color: #2c3e50;
            text-align: center;
            margin-bottom: 10px;
            font-weight: 600;
        }

        .file-introduction h3 {
            color: #555;
            margin-top: 10px;
            font-size: 18px;
        }

        .news_info {
            color: #666;
            font-size: 16px;
            line-height: 1.6;
            margin-top: 8px;
        }

        .message {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 0;
            border-top: 1px solid #eee;
            margin-top: 15px;
        }

        .message table {
            width: 60%;
        }

        .message td {
            padding: 5px;
            font-size: 14px;
            color: #777;
        }

        .message a {
            display: inline-block;
            padding: 8px 16px;
            background: linear-gradient(90deg, #3498db, #2980b9);
            color: white;
            text-decoration: none;
            border-radius: 8px;
            transition: background 0.3s ease, transform 0.2s ease;
            font-size: 14px;
        }

        .message a:hover {
            background: linear-gradient(90deg, #2980b9, #1f6391);
            transform: translateY(-2px);
        }

        .message a:active {
            transform: translateY(1px);
        }

        /* 分页栏 */
        .file-pagination {
            text-align: center;
            margin-top: 20px;
            padding: 15px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .file-pagination a {
            margin: 0 8px;
            text-decoration: none;
            color: #333;
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 8px;
            transition: background 0.3s ease;
        }

        .file-pagination a:hover {
            background-color: #f0f4f8;
        }

        .file-pagination label {
            color: #bbb;
            padding: 8px 12px;
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
                text-align: center;
            }

            .club_message .top-row {
                flex-direction: column;
                gap: 10px;
            }

            .club_message img {
                width: 80px;
                height: 80px;
            }

            .club_message h4 {
                font-size: 20px;
            }

            .club_introduction {
                margin-top: 15px;
            }

            .message {
                flex-direction: column;
                text-align: center;
            }

            .message table {
                width: 100%;
                margin-bottom: 10px;
            }
        }
    </style>
</head>

<body>
<div class="main">
    <div class="header">
        <div class="back">
            <a href="clubListServlet?web=club.jsp" class="iconfont" title="返回俱乐部广场"></a>
        </div>
        <div class="search-box">
            <form action="communityListServlet" style="display: flex; width: 100%;">
                <input type="text" name="searchContent" placeholder="请输入文件名">
                <button type="submit">搜索</button>
            </form>
        </div>
    </div>

    <div class="club_message">
        <div class="top-row">
            <img src="${club.clubImgPath}" alt="">
            <div class="club_details">
                <h4>${club.clubName}</h4>
                <p>${club.clubNumbers} ${club.clubMembership}</p>
            </div>
            <a href="user_clubSaveServlet?clubId=${club.clubId}">加入</a>
        </div>
        <div class="club_introduction">
            <p class="introduction">${club.clubIntroduction}</p>
        </div>
    </div>

    <div id="filesContent">
        <c:forEach items="${file_ClubPageHelper.list}" var="file_club">
            <div class="file-introduction">
                <h1>${file_club.fileName}</h1>
                <h3>文件介绍</h3>
                <p class="news_info">${file_club.fileIntroduction}</p>
                <div class="message">
                    <table>
                        <tr>
                            <td>👍 ${file_club.fileVote}</td>
                            <td>⭐ ${file_club.fileCollect}</td>
                            <td>📥 ${file_club.fileDownloadAmount}</td>
                        </tr>
                    </table>
                    <a href="transferServlet?fileId=${file_club.fId}">点击进入</a>
                </div>
            </div>
        </c:forEach>
    </div>

    <div class="file-pagination">
        <c:if test="${file_ClubPageHelper.pageNum == 1}">
            <label>首页</label>
            <label>上一页</label>
        </c:if>
        <c:if test="${file_ClubPageHelper.pageNum > 1}">
            <a href="communityListServlet?pageNum=1">首页</a>
            <a href="communityListServlet?pageNum=${file_ClubPageHelper.pageNum - 1}">上一页</a>
        </c:if>

        当前第 ${file_ClubPageHelper.pageNum} 页 / 共 ${file_ClubPageHelper.pageCount} 页

        <c:if test="${file_ClubPageHelper.pageNum < file_ClubPageHelper.pageCount}">
            <a href="communityListServlet?pageNum=${file_ClubPageHelper.pageNum + 1}">下一页</a>
            <a href="communityListServlet?pageNum=${file_ClubPageHelper.pageCount}">尾页</a>
        </c:if>
        <c:if test="${file_ClubPageHelper.pageNum == file_ClubPageHelper.pageCount}">
            <label>下一页</label>
            <label>尾页</label>
        </c:if>
    </div>
</div>

</body>
</html>