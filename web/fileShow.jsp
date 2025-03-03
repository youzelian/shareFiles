<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script type="text/javascript" src="JS/jquery-3.7.1.js"></script>
    <title>文件详情</title>
    <link rel="stylesheet" href="fonts/iconfont.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            background-color: #f5f7fa;
            color: #2c3e50;
            line-height: 1.6;
        }

        .main {
            width: 85%;
            max-width: 1280px;
            margin: 0 auto;
            background: #fff;
            padding: 30px;
            border-radius: 16px;
            box-shadow: 0 6px 18px rgba(0, 0, 0, 0.06);
            position: relative;
            animation: fadeIn 0.8s ease-in-out;
        }

        /********************************************/
        /* 标头 */
        /********************************************/
        #head {
            display: flex;
            align-items: center;
            padding: 15px 20px;
            background: linear-gradient(135deg, #ffffff, #f8f9fd);
            position: sticky;
            top: 0;
            z-index: 10;
            border-bottom: 1px solid rgba(0, 0, 0, 0.1);
        }

        .back a {
            font-size: 28px;
            color: black;
            text-decoration: none;
        }

        .fileOfClub {
            margin-left: 30px;
            display: flex;
            align-items: center;
            background-color: #f5f3ff;
            padding: 10px;
            border-radius: 30px;
        }

        .fileOfClub img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            margin-right: 8px;
            object-fit: cover;
        }

        .fileOfClub a {
            text-decoration: none;
            color: #2c3e50;
            font-weight: 600;
            font-size: 16px;
            transition: color 0.3s ease;
        }

        .fileOfClub a:hover {
            color: #3498db;
        }

        /********************************************/
        /* 发帖人信息 */
        /********************************************/
        #title {
            padding: 20px;
            background: white;
            display: flex;
            align-items: center;
        }

        #title img {
            width: 48px;
            height: 48px;
            border-radius: 50%;
            margin-right: 15px;
            border: 2px solid #eef2f7;
        }

        #title p {
            font-size: 16px;
            font-weight: 500;
            color: #34495e;
        }

        /********************************************/
        /* 内容 */
        /********************************************/
        #content {
            padding: 0 20px;
            background: white;
        }

        #content h2 {
            font-size: 24px;
            color: #2c3e50;
            margin-bottom: 15px;
            font-weight: 600;
        }

        #content p {
            font-size: 15px;
            color: #7f8c8d;
        }

        /* 下载链接样式 */
        #content a.styled-link {
            display: inline-flex; /* 使用 inline-flex 确保宽度自适应内容 */
            align-items: center;
            text-decoration: none;
            color: #2c3e50; /* 文本颜色 */
            font-weight: 500;
            padding: 10px 15px; /* 内边距 */
            border-radius: 8px; /* 圆角 */
            background: #f0f0f0; /* 浅灰色背景 */
            transition: background 0.3s ease;
            gap: 10px; /* 元素间距 */
            width: 300px;
            margin-top: 30px;
        }

        #content a.styled-link:hover {
            background: #e0e0e0; /* 鼠标悬停时的背景颜色 */
            color: #2c3e50; /* 保持文本颜色一致 */
        }

        /* 第一个 span（文件图标）样式 */
        #content a.styled-link span:nth-child(1) {
            font-size: 30px;
            color: #7f8c8d;
        }

        /* 第二个 span（下载图标）样式 */
        #content a.styled-link span:nth-child(3) {
            font-size: 25px; /* 下载图标大小为 25px */
            color: #7f8c8d;
            margin-left: auto; /* 将下载图标推到最右边 */
        }

        /* 文件信息容器 */
        #content a.styled-link .file-info {
            display: flex;
            flex-direction: column; /* 垂直排列文件名和文件大小 */
            gap: 2px; /* 文件名和文件大小之间的间距 */
        }

        /* 文件名样式 */
        #content a.styled-link h4 {
            font-size: 14px;
            font-weight: 500;
            margin: 0;
            color: #177bcb;
        }

        /* 文件大小样式 */
        #content a.styled-link p {
            font-size: 12px;
            color: #7f8c8d; /* 灰色字体 */
            margin: 0;
        }

        /********************************************/
        /* 互动区 */
        /********************************************/
        #interact {
            padding: 15px 20px;
            background: white;
            display: flex;
            justify-content: flex-end; /* 将互动区移动到右边 */
            align-items: center;
            gap: 15px;
        }

        #interact span {
            font-weight: 500;
            font-size: 16px;
            min-width: 40px; /* 固定宽度防止数字变化时移动 */
            text-align: center;
        }

        #interact #upvote, #interact #downvote, #interact #collect {
            background: none;
            border: none;
            cursor: pointer;
            font-size: 25px;
            color: #7f8c8d;
            transition: color 0.3s ease;
        }

        #interact #collect {
            padding-left: 20px;
        }

        /* 鼠标悬停效果 */
        #interact #upvote:hover {
            color: #3498db;
        }

        #interact #downvote:hover {
            color: #e91e63;
        }

        #interact #collect:hover {
            color: #fce654;
        }

        #interact #upvote.active {
            color: #3498db;
        }

        /* 点击后的状态 */
        #interact #downvote.active {
            color: #e91e63;
        }

        #interact #collect.active {
            color: #fce654;
        }

        /********************************************/
        /* 评论区 */
        /********************************************/
        #review form {
            background: white;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
            display: flex;
            align-items: center;
            gap: 15px;
            margin-bottom: 20px;
        }

        #review form img {
            width: 48px;
            height: 48px;
            border-radius: 50%;
            border: 2px solid #eef2f7;
        }

        #review form textarea {
            flex-grow: 1;
            padding: 12px;
            border: 1px solid #eef2f7;
            border-radius: 8px;
            resize: none;
            font-size: 14px;
            min-height: 80px;
            transition: border-color 0.3s ease;
        }

        #review form textarea:focus {
            border-color: #3498db;
            outline: none;
        }

        #review form input[type="submit"] {
            padding: 10px 20px;
            background: #3498db;
            color: white;
            border: none;
            border-radius: 20px;
            cursor: pointer;
            font-weight: 500;
            transition: background 0.3s ease;
        }

        #review form input[type="submit"]:hover {
            background: #2980b9;
        }

        #review > div {
            background: white;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
        }

        #review .img img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            margin-right: 10px;
        }

        #review .userName span {
            display: block;
            font-size: 14px;
            color: #34495e;
        }

        #review .comment span {
            font-size: 15px;
            color: #2c3e50;
            margin: 10px 0;
            display: block;
        }

        #review .delete a {
            color: #e74c3c;
            text-decoration: none;
            font-size: 14px;
            padding: 5px 10px;
            border-radius: 15px;
            transition: all 0.3s ease;
        }

        #review .delete a:hover {
            background: #ffebee;
            color: #c0392b;
        }
    </style>
</head>
<body>
<div class="main">
    <%-- 标头 --%>
    <div id="head">
        <%-- 返回按钮 --%>
        <div class="back">
            <a href="communityListServlet" class="iconfont" title="返回动态广场"></a>
        </div>
        <%-- 文件所属俱乐部 --%>
        <div class="fileOfClub">
            <img src="${file_club.clubImgPath}" alt="">
            <a href="eachClubServlet?clubId=${file_club.cId}">${file_club.clubName}</a>
        </div>
    </div>

    <!-- 发帖人的信息 -->
    <div id="title">
        <img src="${file.userImgPath}" alt="">
        <p>${file.userName}</p>
        <p><fmt:formatDate value="${file.fileCreateTime}" pattern="MM-dd"/></p>
        <p>IP属地：江西</p>
    </div>

    <%-- 内容 --%>
    <div id="content">
        <h2>${file.fileTitle}</h2>
        <p>${file.fileIntroduction}</p>
        <a href="${file.fileDownloadLink}" download="${file.fileDownloadLink}" class="styled-link" id="download">
            <span class="iconfont"></span> <!-- 文件图标 -->
            <div class="file-info">
                <h4>${file.fileName}</h4> <!-- 文件名 -->
                <p>${file.fileLength}</p> <!-- 文件大小 -->
            </div>
            <span class="iconfont"></span> <!-- 下载箭头 -->
        </a>
    </div>

    <%-- 互动区 --%>
    <div id="interact">
        <button class="iconfont" id="upvote"></button>
        <span id="voteNum">${file.fileVote}</span>
        <button class="iconfont" id="downvote"></button>
        <button class="iconfont" id="collect"></button>
        <span id="collectNum">${file.fileCollect}</span>
    </div>

    <!-- 评论区 -->
    <div id="review">
        <%-- 发表评论 --%>
        <form action="commentSaveServlet">
            <img src="${user.userImgPath}" alt="">
            <input type="hidden" name="fId" value="${file.fileId}">
            <textarea name="commentContent" id="postComment" placeholder="请输入评论"></textarea>
            <input type="submit" value="提交评论">
        </form>
        <%-- 评论区列表 --%>
        <c:forEach items="${commentList}" var="comment">
            <div style="display: flex; align-items: flex-start; padding: 15px 0; border-bottom: 1px solid #eef2f7;">
                <div class="img">
                    <img src="${comment.userImgPath}" alt="">
                </div>
                <div style="flex: 1;">
                    <div class="userName">
                        <span>用户名:${comment.userName}</span>
                        <span>userId:${comment.uId}</span>
                    </div>
                    <div class="comment">
                        <span>${comment.commentContent}</span>
                    </div>
                    <c:if test="${comment.uId==user.getUserId()}">
                        <div class="delete">
                            <a href="commentDeleteServlet?commentId=${comment.commentId}&&fId=${file.fileId}">删除评论</a>
                        </div>
                    </c:if>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
<script>
    $(document).ready(function () {
        // 状态管理
        const interactionState = {
            vote: "${user_vote_status}" === "upvote" ? 1 : "${user_vote_status}" === "downvote" ? -1 : 0,
            collect: "${user_file}" !== "" ? 1 : 0
        };

        // 矢量图标代码配置
        const icons = {
            upvote: {normal: "", active: ""},
            downvote: {normal: "", active: ""},
            collect: {normal: "", active: ""}
        };

        // 初始化状态
        function initializeState() {
            if (interactionState.vote === 1) {
                $("#upvote").addClass("active").html(icons.upvote.active);
                $("#voteNum").addClass("upvoted");
            } else if (interactionState.vote === -1) {
                $("#downvote").addClass("active").html(icons.downvote.active);
                $("#voteNum").addClass("downvoted");
            }
            if (interactionState.collect) {
                $("#collect").addClass("active").html(icons.collect.active);
            }
        }

        // 发送交互请求的通用函数
        function sendInteraction(type, callback) {
            $.post("interactServlet",
                {type: type, fileId: "${file.fileId}"},
                function (res) {
                    $("#voteNum").text(res.fileVote);
                    $("#collectNum").text(res.fileCollect);
                    callback(res);
                },
                "json"
            );
        }

        // 点赞操作处理
        $("#upvote").click(function () {
            const $this = $(this);
            if (interactionState.vote === 1) {
                sendInteraction("cancelUpvote", () => {
                    $this.removeClass("active").html(icons.upvote.normal);
                    $("#voteNum").removeClass("upvoted");
                    interactionState.vote = 0;
                });
            } else if (interactionState.vote === -1) {
                sendInteraction("upvoteFromDownvote", () => {
                    $this.addClass("active").html(icons.upvote.active);
                    $("#downvote").removeClass("active").html(icons.downvote.normal);
                    $("#voteNum").removeClass("downvoted").addClass("upvoted");
                    interactionState.vote = 1;
                });
            } else {
                sendInteraction("upvote", () => {
                    $this.addClass("active").html(icons.upvote.active);
                    $("#voteNum").addClass("upvoted");
                    interactionState.vote = 1;
                });
            }
        });

        // 点踩操作处理
        $("#downvote").click(function () {
            const $this = $(this);
            if (interactionState.vote === -1) {
                sendInteraction("cancelDownvote", () => {
                    $this.removeClass("active").html(icons.downvote.normal);
                    $("#voteNum").removeClass("downvoted");
                    interactionState.vote = 0;
                });
            } else if (interactionState.vote === 1) {
                sendInteraction("downvoteFromUpvote", () => {
                    $this.addClass("active").html(icons.downvote.active);
                    $("#upvote").removeClass("active").html(icons.upvote.normal);
                    $("#voteNum").removeClass("upvoted").addClass("downvoted");
                    interactionState.vote = -1;
                });
            } else {
                sendInteraction("downvote", () => {
                    $this.addClass("active").html(icons.downvote.active);
                    $("#voteNum").addClass("downvoted");
                    interactionState.vote = -1;
                });
            }
        });

        // 收藏处理
        $("#collect").click(function () {
            const $this = $(this);
            sendInteraction("collect", () => {
                if (interactionState.collect) {
                    $this.removeClass("active").html(icons.collect.normal);
                    interactionState.collect = 0;
                } else {
                    $this.addClass("active").html(icons.collect.active);
                    interactionState.collect = 1;
                }
            });
        });

        // 下载处理
        $("#download").click(function () {
            sendInteraction("download", (res) => {
                $("#downloadNum").text(res.fileDownloadAmount);
            });
        });
        // 初始化
        initializeState();
    });
</script>
</body>
</html>