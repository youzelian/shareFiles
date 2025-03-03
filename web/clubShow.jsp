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
            transition: background 0.3s ease, box-shadow 0.3s ease; /* 平滑过渡 */
        }

        /* 触碰搜索框时（hover）变为明亮 */
        .search-box:hover {
            background: #ffffff; /* 明亮背景 */
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.15);
        }

        /* 触碰搜索按钮时，搜索框背景恢复暗色 */
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
            background: transparent; /* 透明背景 */
            color: #333; /* 深灰色文字，确保在所有背景下可见 */
            border-radius: 8px 0 0 8px;
            cursor: text; /* 明确提示可以输入 */
        }

        .search-box input::placeholder {
            color: #ccc; /* 占位符颜色，浅灰色 */
            opacity: 0.8;
        }

        .search-box button {
            height: 40px;
            padding: 0 15px;
            background: #fff; /* 按钮默认白色 */
            color: #333; /* 暗色文字 */
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
            background: #f0f4f8; /* 明亮背景 */
            color: #333;
            transform: scale(1.05); /* 轻微放大 */
        }

        .search-box button:active {
            transform: scale(0.98); /* 轻微缩小 */
        }

        /* 俱乐部信息 */
        .club_message {
            display: flex;
            flex-direction: column;
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
            gap: 20px;
            margin-bottom: 15px;
        }

        .club_message img {
            width: 100px;
            height: 100px;
            object-fit: cover;
            border-radius: 8px;
        }

        .club_details {
            flex: 1;
        }

        .club_message h4 {
            font-size: 24px;
            color: #2c3e50;
            margin-bottom: 5px;
            font-weight: 600;
        }

        #clubNumbers {
            font-size: 16px;
            color: #7f8c8d;
            margin-bottom: 10px;
        }

        .club_introduction {
            margin-top: 15px;
        }

        .club_message .introduction {
            font-size: 14px;
            color: #666;
            line-height: 1.6;
            margin: 0;
        }

        /* 按钮样式 */
        .club_message a {
            width: 105px;
            display: inline-block;
            padding: 12px 24px; /* 增大按钮大小 */
            font-size: 16px; /* 增大文字大小 */
            text-decoration: none;
            border-radius: 8px;
            /*transition: background 0.3s ease, transform 0.2s ease;*/
            text-align: center; /* 文字水平居中 */
            line-height: 1; /* 确保文字垂直居中 */
            white-space: nowrap;
            cursor: pointer;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        /* 加入按钮（operation = 1） */
        .join-btn {
            background-color: #eb435a; /* 红色 */
            color: white;
        }

        .join-btn:hover {
            background-color: #cc0000; /* 稍微深一些的红色 */
        }

        .join-btn:active {
            transform: translateY(1px);
        }

        /* 已加入按钮（operation = 0） */
        .joined-btn {
            background-color: #f3f3f3; /* 灰色 */
            color: #333;
        }

        .joined-btn:active {
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
            background: #00aeec;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            transition: background 0.3s ease, transform 0.2s ease;
            font-size: 14px;
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

            .club_message a {
                padding: 10px 20px; /* 小屏幕上稍微缩小但仍保持可读性 */
                font-size: 14px;
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
    <%--标头--%>
    <div class="header">
        <div class="back">
            <a href="clubListServlet?web=club.jsp" class="iconfont" title="返回俱乐部广场"></a>
        </div>
        <div class="search-box">
            <form action="eachClubServlet?clubId=${club.clubId}" method="post" style="display: flex; width: 100%;">
                <input type="text" name="searchContent" placeholder="请输入文件名" id="searchContent">
                <button type="submit" class="iconfont"></button>
            </form>
        </div>
    </div>
    <%--俱乐部信息--%>
    <div class="club_message">
        <div class="top-row">
            <img src="${club.clubImgPath}" alt="">
            <div class="club_details">
                <h4>${club.clubName}</h4>
                <p id="clubNumbers">${club.clubNumbers} ${club.clubMembership}</p>
            </div>
            <c:if test="${operation == 1}">
                <a href="#" id="join" class="join-btn" data-operation="${operation}">加入</a>
            </c:if>
            <c:if test="${operation == 0}">
                <a href="#" id="join" class="joined-btn" data-operation="${operation}">已加入</a>
            </c:if>
        </div>
        <div class="club_introduction">
            <p class="introduction">${club.clubIntroduction}</p>
        </div>
    </div>
    <%--文件信息--%>
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
    <%--分页--%>
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
<script>
    $("#join").click(function (e) {
        e.preventDefault(); // 阻止默认链接行为
        $.post("user_clubOperationServlet",
            {clubId: "${club.clubId}", operation: $("#join").data("operation")},
            function (res) {
                $("#join").removeClass("join-btn joined-btn").addClass(res.operation == 1 ? "join-btn" : "joined-btn").text(res.status); // 动态切换类名和文本
                $("#join").data("operation", res.operation); // 更新 operation
                $("#clubNumbers").text(res.clubNumbers + " ${club.clubMembership}"); // 更新 clubNumbers
            }, "json")
            .fail(function () {
                alert("操作失败，请稍后重试");
            });
    });
</script>
</body>
</html>