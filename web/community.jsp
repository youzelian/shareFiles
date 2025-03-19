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
            font-family: 'Arial', 'PingFang SC', sans-serif; /* 支持中文字体 */
        }

        body {
            background: linear-gradient(135deg, #e9f1f6, #c8d8e4); /* 与 club.jsp 一致的渐变背景 */
            min-height: 100vh;
            padding: 40px 0; /* 增加顶部和底部留白 */
            color: #333;
        }

        .main {
            width: 85%;
            max-width: 1280px; /* 更宽的容器 */
            margin: 0 auto;
            background: #fff;
            padding: 30px;
            border-radius: 16px;
            box-shadow: 0 6px 18px rgba(0, 0, 0, 0.06);
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

        /* 返回首页按钮 */
        .backHome {
            position: absolute;
            top: 20px;
            left: 20px;
        }

        .backHome a {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 50px;
            height: 50px;
            color: black;
            font-size: 26px;
            border-radius: 50%;
            text-decoration: none;
            transition: all 0.3s ease;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        }

        /*.backHome a:hover {*/
        /*    background: linear-gradient(45deg, #8e44ad, #d8437e);*/
        /*    transform: scale(1.1); !* 放大效果 *!*/
        /*}*/

        .backHome a:active {
            transform: scale(0.95); /* 点击缩小 */
        }

        /* 搜索框 */
        .search-box {
            width: 100%;
            max-width: 600px;
            display: flex;
            align-items: center;
            border: 2px solid #d9534f;
            border-radius: 10px;
            overflow: hidden;
            margin: 30px auto;
            box-shadow: 0 3px 8px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
        }

        .search-box:hover {
            border-color: #c9302c;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.15);
        }

        .search-box input {
            flex: 1;
            height: 48px;
            font-size: 16px;
            border: none;
            padding: 0 15px;
            outline: none;
            background: #fafafa; /* 浅灰背景 */
        }

        .search-box button {
            height: 48px;
            padding: 0 25px;
            background: linear-gradient(90deg, #d9534f, #c9302c);
            color: white;
            border: none;
            cursor: pointer;
            font-size: 16px;
            transition: all 0.3s ease;
        }

        .search-box button:hover {
            background: linear-gradient(90deg, #c9302c, #b02828);
        }

        /* 文件介绍 */
        .file-introduction {
            margin-top: 25px;
            padding: 25px;
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
            transition: all 0.4s ease;
            border: 1px solid rgba(223, 230, 233, 0.5);
            position: relative;
        }

        .file-introduction::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 4px;
            background: linear-gradient(90deg, #d9534f, #e74c3c); /* 顶部装饰线 */
        }

        .file-introduction:hover {
            transform: translateY(-8px);
            box-shadow: 0 12px 25px rgba(0, 0, 0, 0.12);
        }

        .file-introduction h1 {
            font-size: 24px;
            color: #1e2a38;
            text-align: left;
            margin-bottom: 15px;
            font-weight: 700;
            letter-spacing: 0.5px;
        }

        .file-introduction h3 {
            color: #555;
            font-size: 18px;
            margin-top: 15px;
            font-weight: 500;
        }

        .news_info {
            color: #666;
            font-size: 16px;
            line-height: 1.7;
            margin-top: 10px;
            overflow: hidden;
            text-overflow: ellipsis;
            display: -webkit-box;
            -webkit-box-orient: vertical;
            -webkit-line-clamp: 3; /* 限制3行 */
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
            width: 100%;
        }

        .message td {
            padding: 5px 15px;
            font-size: 14px;
            color: #777;
        }

        /* “点击进入”按钮 */
        .message a {
            padding: 12px 30px; /* 增加内边距，确保文字在一行 */
            background: linear-gradient(45deg, #f39c12, #f1c40f); /* 橙色到黄色的渐变 */
            color: white;
            text-decoration: none;
            border-radius: 10px;
            font-size: 16px; /* 增大字体，确保清晰 */
            font-weight: 600; /* 字体加粗 */
            white-space: nowrap; /* 确保文字不换行 */
            transition: all 0.3s ease;
            box-shadow: 0 3px 8px rgba(0, 0, 0, 0.1);
        }

        .message a:hover {
            background: linear-gradient(45deg, #e67e22, #d4a017);
            transform: scale(1.05); /* 轻微放大 */
        }

        .message a:active {
            transform: scale(0.95); /* 点击缩小 */
        }

        /* 分页栏 */
        .file-pagination {
            text-align: center;
            margin-top: 30px;
            padding: 15px;
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
        }

        .file-pagination a {
            margin: 0 10px;
            text-decoration: none;
            color: #3498db;
            padding: 8px 15px;
            border: 1px solid #ddd;
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        .file-pagination a:hover {
            background: linear-gradient(90deg, #3498db, #2980b9);
            color: white;
            border-color: transparent;
        }

        .file-pagination label {
            color: #bbb;
            padding: 8px 15px;
            font-size: 14px;
        }

        .file-pagination span {
            font-size: 14px;
            color: #555;
            margin: 0 10px;
        }

        @media (max-width: 768px) {
            .main {
                width: 90%;
                padding: 20px;
            }

            .search-box {
                max-width: 100%;
            }

            .file-introduction {
                padding: 20px;
            }

            .message {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }

            .message td {
                padding: 5px 10px;
            }
        }

        @media (max-width: 480px) {
            .file-introduction h1 {
                font-size: 20px;
            }

            .file-introduction h3 {
                font-size: 16px;
            }

            .backHome a {
                width: 40px;
                height: 40px;
                font-size: 20px;
            }
        }
    </style>
</head>

<body>
<div class="main">
    <%-- 返回首页 --%>
    <div class="backHome">
        <a href="index.jsp" class="iconfont" title="回到主页">&#xe63b;</a>
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
                <h1>${file.fileTitle}</h1>
                <h3>文件介绍</h3>
                <p class="news_info">${file.fileIntroduction}</p>
                <div class="message">
                    <table>
                        <tr>
                            <td>👍 ${file.fileVote}</td>
                            <td>⭐ ${file.fileCollect}</td>
                            <td>📥 ${file.fileDownloadAmount}</td>
                            <td>🏆 所属俱乐部: ${file.clubName}</td>
                        </tr>
                    </table>
                    <a href="transferServlet?fileId=${file.fileId}&pageNum=${pages.pageNum}&type=1">点击进入</a>
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
        <span>当前第 ${pages.pageNum} 页 / 共 ${pages.pageCount} 页</span>
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