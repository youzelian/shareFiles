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
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: "Arial", sans-serif;
        }

        body {
            background-color: #f5f5f5;
        }

        .main {
            width: 80%;
            max-width: 1200px;
            margin: 20px auto;
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        /* 返回首页按钮样式 */
        .backHome {
            top: 20px;
            left: 20px;
        }

        .backHome a {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 50px; /* 设置固定宽度 */
            height: 50px; /* 设置固定高度 */
            background-color: #2ecc71; /* 使用绿色背景色 */
            color: white;
            font-size: 24px; /* 图标大小 */
            border-radius: 50%; /* 圆形按钮 */
            border: 2px solid #27ae60; /* 绿色边框 */
            text-decoration: none;
            transition: background-color 0.3s, transform 0.3s, box-shadow 0.3s;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* 添加阴影 */
        }

        .backHome a:hover {
            background-color: #27ae60; /* 鼠标悬停时背景颜色变化 */
            transform: translateY(-5px); /* 鼠标悬停时按钮上移 */
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.15); /* 鼠标悬停时增加阴影 */
        }

        .backHome a:active {
            transform: translateY(2px); /* 按钮按下时的效果 */
        }

        /* 搜索框 */
        .search-box {
            width: 500px;
            display: flex;
            align-items: center;
            border: 1px solid #d9534f;
            border-radius: 5px;
            overflow: hidden;
            margin: 20px auto;
        }

        .search-box input {
            flex: 1;
            height: 40px;
            font-size: 16px;
            border: none;
            padding: 0 10px;
            outline: none;
        }

        .search-box button {
            height: 40px;
            padding: 0 20px;
            background-color: #d9534f;
            color: white;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .search-box button:hover {
            background-color: #c9302c;
        }

        /* 文件介绍 */
        .file-introduction {
            margin-top: 20px;
            padding: 15px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
            transition: all 0.3s; /* 上浮这个过程需要的时间 */
        }

        .file-introduction:hover {
            transform: translate(-5px, -10px); /*鼠标悬停在文件上方时向左上移动*/
        }

        .file-introduction h1 {
            font-size: 22px;
            color: #333;
            text-align: center;
            margin-bottom: 10px;
        }

        .file-introduction h3 {
            color: #555;
            margin-top: 10px;
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
            padding: 10px 0;
            border-top: 1px solid #eee;
            margin-top: 10px;
        }

        .message table {
            width: 100%;
        }

        .message td {
            padding: 5px;
            font-size: 14px;
            color: #777;
        }

        .message a {
            display: inline-block;
            text-decoration: none;
            background-color: #3498db;
            color: white;
            padding: 8px 12px;
            border-radius: 5px;
            transition: 0.3s;
            white-space: nowrap;
        }

        .message a:hover {
            background-color: #2980b9;
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
            padding: 5px 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            transition: 0.3s;
        }

        .file-pagination a:hover {
            background-color: #eee;
        }

        .file-pagination label {
            color: #bbb;
            padding: 5px 10px;
        }
    </style>
    <link rel="stylesheet" href="fonts/font_back/iconfont.css">
</head>

<body>

<div class="main">
    <%--返回首页--%>
    <div class="backHome">
        <a href="index.jsp" class="iconfont" title="回到主页">&#xe6fa;</a>
    </div>

    <!-- 搜索框 -->
    <div class="search-box">
        <form action="communityListServlet" style="display: flex; width: 100%;">
            <input type="text" name="searchContent" placeholder="请输入文件名" id="searchContent">
            <button type="submit" id="search">搜索</button>
        </form>
    </div>

    <!-- 文件内容 -->
    <div id="filesContent">
        <c:forEach items="${pages.list}" var="file">
            <div class="file-introduction">
                <h1>${file.fileName}</h1>
                <h3>文件介绍</h3>
                <p class="news_info">${file.fileIntroduction}</p>
                <div class="message">
                    <table>
                        <tr>
                            <td>👍 ${file.fileVote}</td>
                            <td>⭐ ${file.fileCollect}</td>
                            <td>📥 ${file.fileDownloadAmount}</td>
                            <td>🏆 所属俱乐部: ${file.clubName} (${file.clubId})</td>
                        </tr>
                    </table>
                    <a href="transferServlet?fileId=${file.fileId}">点击进入</a>
                </div>
            </div>
        </c:forEach>
    </div>

    <!-- 分页 -->
    <div class="file-pagination">
        <c:if test="${pages.pageNum == 1}">
            <label>首页</label>
            <label>上一页</label>
        </c:if>
        <c:if test="${pages.pageNum > 1}">
            <a href="communityListServlet?pageNum=1">首页</a>
            <a href="communityListServlet?pageNum=${pages.pageNum - 1}">上一页</a>
        </c:if>

        当前第 ${pages.pageNum} 页 / 共 ${pages.pageCount} 页

        <c:if test="${pages.pageNum < pages.pageCount}">
            <a href="communityListServlet?pageNum=${pages.pageNum + 1}">下一页</a>
            <a href="communityListServlet?pageNum=${pages.pageCount}">尾页</a>
        </c:if>
        <c:if test="${pages.pageNum == pages.pageCount}">
            <label>下一页</label>
            <label>尾页</label>
        </c:if>
    </div>
</div>

</body>
</html>