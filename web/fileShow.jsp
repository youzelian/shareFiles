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
            display: inline-flex;
            align-items: center;
            text-decoration: none;
            color: #2c3e50;
            font-weight: 500;
            padding: 10px 15px;
            border-radius: 8px;
            background: #f0f0f0;
            transition: background 0.3s ease;
            gap: 10px;
            width: 300px;
            margin-top: 30px;
        }

        #content a.styled-link:hover {
            background: #e0e0e0;
            color: #2c3e50;
        }

        #content a.styled-link span:nth-child(1) {
            font-size: 30px;
            color: #7f8c8d;
        }

        #content a.styled-link span:nth-child(3) {
            font-size: 25px;
            color: #7f8c8d;
            margin-left: auto;
        }

        #content a.styled-link .file-info {
            display: flex;
            flex-direction: column;
            gap: 2px;
        }

        #content a.styled-link h4 {
            font-size: 14px;
            font-weight: 500;
            margin: 0;
            color: #177bcb;
        }

        #content a.styled-link p {
            font-size: 12px;
            color: #7f8c8d;
            margin: 0;
        }

        /********************************************/
        /* 互动区 */
        /********************************************/
        #interact {
            padding: 15px 20px;
            background: white;
            display: flex;
            justify-content: flex-end;
            align-items: center;
            gap: 15px;
        }

        #interact span {
            font-weight: 500;
            font-size: 16px;
            min-width: 40px;
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

        #review > div.comment-item {
            background: white;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
            margin-bottom: 15px;
        }

        #review .comment-item .comment-header {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
        }

        #review .comment-item .img img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            margin-right: 10px;
        }

        #review .comment-item .userName span {
            display: block;
            font-size: 14px;
            color: #34495e;
        }

        #review .comment-item .comment span {
            font-size: 15px;
            color: #2c3e50;
            margin: 10px 0;
            display: block;
        }

        #review .comment-item .comment-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        #review .comment-item .reply a {
            color: #3498db;
            text-decoration: none;
            font-size: 14px;
            padding: 5px 10px;
            border-radius: 15px;
            transition: all 0.3s ease;
        }

        #review .comment-item .reply a:hover {
            background: #e3f2fd;
            color: #2980b9;
        }

        #review .comment-item .delete a {
            color: #e74c3c;
            text-decoration: none;
            font-size: 14px;
            padding: 5px 10px;
            border-radius: 15px;
            transition: all 0.3s ease;
        }

        #review .comment-item .delete a:hover {
            background: #ffebee;
            color: #c0392b;
        }

        #review .child-comments {
            margin-left: 50px;
            margin-top: 15px;
        }
    </style>
</head>
<body>
<div class="main">
    <%-- 标头 --%>
    <div id="head">
        <div class="back">
            <a href="communityListServlet" class="iconfont" title="返回动态广场"></a>
        </div>
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
            <span class="iconfont"></span>
            <div class="file-info">
                <h4>${file.fileName}</h4>
                <p>${file.fileLength}</p>
            </div>
            <span class="iconfont"></span>
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
        <!-- 发表评论 -->
        <c:if test="${not empty sessionScope.user}">
            <form action="commentSaveServlet" method="post">
                <img src="${user.userImgPath}" alt="">
                <textarea name="commentContent" placeholder="写下你的评论..." required></textarea>
                <input type="hidden" name="fId" value="${file.fileId}">
                <input type="hidden" name="parentId" value="0">
                <input type="hidden" name="rootParentId" value="0">
                <input type="submit" value="发表评论">
            </form>
        </c:if>

        <!-- 递归展示评论 -->
        <c:forEach var="comment" items="${commentList}">
            <div class="comment-item">
                <div class="comment-header">
                    <div class="img">
                        <img src="${comment.userImgPath}" alt="">
                    </div>
                    <div class="userName">
                        <span>${comment.userName}</span>
                        <span style="font-size: 12px; color: #7f8c8d;">${comment.commentCreateTime}</span>
                    </div>
                </div>
                <div class="comment">
                    <span>${comment.commentContent}</span>
                </div>
                <div class="comment-footer">
                    <div class="reply">
                        <a href="javascript:void(0)"
                           onclick="showReplyForm(${comment.commentId}, ${comment.rootParentId != 0 ? comment.rootParentId : comment.commentId})">回复</a>
                    </div>
                    <c:if test="${sessionScope.user.userId == comment.uId}">
                        <div class="delete">
                            <a href="commentDeleteServlet?commentId=${comment.commentId}&fId=${file.fileId}">删除</a>
                        </div>
                    </c:if>
                </div>

                <!-- 子评论 -->
                <c:if test="${not empty comment.childComments}">
                    <div class="child-comments">
                        <c:set var="childComments" value="${comment.childComments}" scope="request"/>
                        <c:import url="commentRecursive.jsp"/>
                    </div>
                </c:if>
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

        const icons = {
            upvote: {normal: "", active: ""},
            downvote: {normal: "", active: ""},
            collect: {normal: "", active: ""}
        };

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

        $("#download").click(function () {
            sendInteraction("download", (res) => {
                $("#downloadNum").text(res.fileDownloadAmount);
            });
        });

        initializeState();
    });

    // 显示回复评论的表单
    function showReplyForm(commentId, rootParentId) {
        const replyForm = `
        <form action="commentSaveServlet" method="post" style="margin-left: 50px; margin-top: 10px;">
            <textarea name="commentContent" placeholder="回复..." required></textarea>
            <input type="hidden" name="fId" value="${file.fileId}">
            <input type="hidden" name="parentId" value="` + commentId + `">
            <input type="hidden" name="rootParentId" value="` + rootParentId + `">
            <input type="submit" value="提交回复">
        </form>`;
        $(event.target).closest('.comment-item').append(replyForm);
    }
</script>
</body>
</html>