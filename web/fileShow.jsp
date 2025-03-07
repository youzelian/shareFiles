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

        #head {
            display: flex;
            align-items: center;
            padding: 15px 20px;
            background: linear-gradient(135deg, #ffffff, #f8f9fd);
            position: sticky;
            top: -5px; /*减少缝隙*/
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

        #review {
            padding-top: 20px;
            background: white;
        }

        #review form {
            background: #f9fafc;
            padding: 15px 20px;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.03);
            display: flex;
            align-items: center;
            gap: 15px;
            margin-bottom: 25px;
            transition: box-shadow 0.3s ease;
        }

        #review form:hover {
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.06);
        }

        #review form img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            border: 1px solid #eef2f7;
        }

        #review form textarea {
            flex-grow: 1;
            padding: 12px;
            border: 1px solid #e0e4e8;
            border-radius: 8px;
            resize: none;
            font-size: 14px;
            min-height: 60px;
            background: #fff;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }

        #review form textarea:focus {
            border-color: #3498db;
            box-shadow: 0 0 5px rgba(52, 152, 219, 0.3);
            outline: none;
        }

        #review form input[type="submit"] {
            padding: 8px 20px;
            background: #3498db;
            color: white;
            border: none;
            border-radius: 20px;
            cursor: pointer;
            font-weight: 500;
            font-size: 14px;
            transition: background 0.3s ease, transform 0.3s ease;
        }

        #review form input[type="submit"]:hover {
            background: #2980b9;
            transform: translateY(-2px);
        }

        .reply-form {
            background: #f9fafc;
            padding: 15px 20px;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.03);
            display: flex;
            align-items: center;
            gap: 15px;
            transition: box-shadow 0.3s ease;
            margin-top: 10px;
        }

        .reply-form:hover {
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.06);
        }

        .reply-form textarea {
            flex-grow: 1;
            padding: 12px;
            border: 1px solid #e0e4e8;
            border-radius: 8px;
            resize: none;
            font-size: 14px;
            min-height: 60px;
            background: #fff;
        }

        .reply-form input[type="submit"] {
            padding: 8px 20px;
            background: #3498db;
            color: white;
            border: none;
            border-radius: 20px;
            cursor: pointer;
        }

        #review > div.comment-item {
            background: #fff;
            padding: 15px 20px;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.03);
            margin-bottom: 15px;
            transition: box-shadow 0.3s ease;
        }

        #review > div.comment-item:hover {
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.06);
        }

        #review > div.comment-item .comment-img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            vertical-align: middle;
            float: left;
            margin: 3px 12px 0 0;
        }

        #review > div.comment-item .comment-main {
            display: inline-block;
            vertical-align: middle;
            width: calc(100% - 52px);
        }

        #review > div.comment-item .comment-main .username span {
            display: inline;
            font-size: 13px;
            font-weight: 500;
            color: #afafaf;
            margin-right: 8px;
        }

        #review > div.comment-item .comment-main .content {
            display: inline;
            font-size: 15px;
            color: #2c3e50;
            line-height: 1.5;
            word-wrap: break-word;
        }

        #review > div.comment-item .comment-main .footer {
            display: flex;
            align-items: center;
            font-size: 12px;
            color: #999;
            margin-top: 8px;
            gap: 15px;
        }

        #review > div.comment-item .comment-main .footer .time {
            font-size: 12px;
        }

        #review > div.comment-item .comment-main .footer .reply a,
        #review > div.comment-item .comment-main .footer .delete a {
            color: #3498db;
            text-decoration: none;
            font-size: 12px;
            transition: color 0.3s ease;
        }

        #review > div.comment-item .comment-main .footer .reply a:hover {
            color: #2980b9;
        }

        #review > div.comment-item .comment-main .footer .delete a {
            color: #e74c3c;
        }

        #review > div.comment-item .comment-main .footer .delete a:hover {
            color: #c0392b;
        }

        #review > div.comment-item .comment-main .footer button#like {
            background: none;
            border: none;
            cursor: pointer;
            font-size: 14px;
            color: #999;
            transition: color 0.3s ease;
        }

        #review > div.comment-item .comment-main .footer button#like:hover {
            color: #e74c3c;
        }

        #review > div.comment-item .comment-main .footer span#likeNum {
            font-size: 12px;
            color: #999;
            margin-left: 3px;
        }

        #review .child-comments {
            margin-left: 40px;
            margin-top: 10px;
        }

        .child-comments .comment-item {
            background: #fff;
            padding: 12px 15px;
            margin-bottom: 10px;
            box-shadow: none;
            border-left: none;
        }

        .child-comments .comment-item .comment-main {
            display: block;
        }

        .child-comments .comment-item .comment-main .username span {
            display: inline;
            font-size: 13px;
            font-weight: 500;
            color: #34495e;
            vertical-align: middle;
        }

        .child-comments .comment-item .comment-main .content p {
            display: block;
            font-size: 14px;
            color: #2c3e50;
            margin-top: 5px;
            line-height: 1.5;
            word-wrap: break-word;
        }

        .child-comments .comment-item .comment-main .footer {
            display: flex;
            align-items: center;
            font-size: 12px;
            color: #999;
            margin-top: 5px;
            gap: 15px;
        }

        .child-comments .comment-item .comment-main .footer .time {
            font-size: 12px;
        }

        .child-comments .comment-item .comment-main .footer .reply a,
        .child-comments .comment-item .comment-main .footer .delete a {
            color: #3498db;
            text-decoration: none;
            font-size: 12px;
            transition: color 0.3s ease;
        }

        .child-comments .comment-item .comment-main .footer .reply a:hover {
            color: #2980b9;
        }

        .child-comments .comment-item .comment-main .footer .delete a {
            color: #e74c3c;
        }

        .child-comments .comment-item .comment-main .footer .delete a:hover {
            color: #c0392b;
        }

        .child-comments .comment-item .comment-main .footer button#like {
            background: none;
            border: none;
            cursor: pointer;
            font-size: 14px;
            color: #999;
            transition: color 0.3s ease;
        }

        .child-comments .comment-item .comment-main .footer button#like:hover {
            color: #e74c3c;
        }

        .child-comments .comment-item .comment-main .footer span#likeNum {
            font-size: 12px;
            color: #999;
            margin-left: 3px;
        }

        .child-comments .comment-item .comment-img-second {
            width: 25px;
            height: 25px;
            float: left;
            margin: 3px 12px 0 0;
            border-radius: 50%;
            vertical-align: middle;
        }

        .comment-main .username span .reply-to {
            color: #999;
            font-size: 12px;
            margin-left: 5px;
            font-weight: 400;
            vertical-align: middle;
        }

        /* 提示框样式 */
        .alert {
            padding: 10px 20px;
            background-color: #333; /* 黑色背景 */
            color: white; /* 白色文字 */
            position: fixed;
            top: 50%; /* 垂直居中 */
            left: 50%; /* 水平居中 */
            transform: translate(-50%, -50%); /* 偏移自身宽高的一半以实现居中 */
            z-index: 1000;
            display: none; /* 初始隐藏 */
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
            font-size: 14px;
            font-weight: 500;
            text-align: center; /* 文字居中 */
        }
    </style>
</head>
<body>
<div class="main">
    <div id="head">
        <div class="back">
            <a href="communityListServlet" class="iconfont" title="返回动态广场"></a>
        </div>
        <div class="fileOfClub">
            <img src="${file_club.clubImgPath}" alt="">
            <a href="eachClubServlet?clubId=${file_club.cId}">${file_club.clubName}</a>
        </div>
    </div>

    <div id="title">
        <img src="${file.userImgPath}" alt="">
        <p>${file.userName}</p>
        <p><fmt:formatDate value="${file.fileCreateTime}" pattern="MM-dd"/></p>
        <p>IP属地：江西</p>
    </div>

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

    <div id="interact">
        <button class="iconfont" id="upvote"></button>
        <span id="voteNum">${file.fileVote}</span>
        <button class="iconfont" id="downvote"></button>
        <button class="iconfont" id="collect"></button>
        <span id="collectNum">${file.fileCollect}</span>
    </div>

    <div id="review">
        <c:if test="${not empty sessionScope.user}">
            <form action="commentSaveServlet" method="post" id="main-comment-form">
                <img src="${sessionScope.user.userImgPath}" alt="">
                <textarea name="commentContent" placeholder="写下你的评论..." required></textarea>
                <input type="hidden" name="fId" value="${file.fileId}">
                <input type="hidden" name="parentId" value="0">
                <input type="hidden" name="rootParentId" value="0">
                <input type="submit" value="发表评论">
            </form>
        </c:if>

        <c:forEach var="comment" items="${commentRootList}">
            <div class="comment-item" data-comment-id="${comment.commentId}" data-liked="${comment.likedByUser}">
                <img src="${comment.userImgPath}" class="comment-img" alt="">
                <div class="comment-main">
                    <div class="username">
                        <span>${comment.userName}</span>
                    </div>
                    <div class="content">
                        <p>${comment.commentContent}</p>
                    </div>
                    <div class="footer">
                        <span class="time">${comment.commentCreateTime}</span>
                        <button class="iconfont" id="like"></button>
                        <span id="likeNum">${comment.commentLikedNum}</span>
                        <div class="reply">
                            <a href="javascript:void(0)" data-comment-id="${comment.commentId}"
                               data-root-parent-id="${comment.rootParentId != 0 ? comment.rootParentId : comment.commentId}"
                               data-username="${comment.userName}">回复</a>
                        </div>
                        <c:if test="${sessionScope.user.userId == comment.uId}">
                            <div class="delete">
                                <a href="commentDeleteServlet?commentId=${comment.commentId}&fId=${file.fileId}"
                                   class="delete-comment">删除</a>
                            </div>
                        </c:if>
                    </div>
                </div>

                <div class="child-comments">
                    <c:if test="${not empty comment.childComments}">
                        <c:set var="childComments" value="${comment.childComments}" scope="request"/>
                        <c:import url="commentRecursive.jsp"/>
                    </c:if>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<script>
    $(document).ready(function () {
        const interactionState = {
            vote: "${vote_status}" === "upvote" ? 1 : "${vote_status}" === "downvote" ? -1 : 0,
            collect: "${isCollectByUser}" !== "" ? 1 : 0,
            likedComments: {}
        };

        const icons = {
            upvote: {normal: "", active: ""},
            downvote: {normal: "&#xe603;", active: "&#xe606;"},
            collect: {normal: "", active: ""},
            like: {normal: "", active: ""}
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
            // 初始化评论点赞状态
            $(".comment-item").each(function () {
                const $this = $(this);
                const commentId = $this.data("comment-id");
                const isLiked = $this.data("liked") === true; // 从后端传递
                if (isLiked) {
                    $this.find("#like").addClass("active").html(icons.like.active);
                    interactionState.likedComments[commentId] = true;
                } else {
                    interactionState.likedComments[commentId] = false;
                }
            });
        }

        function sendInteraction(type, data, callback) {
            $.post("interactServlet", data, function (res) {
                callback(res);
            }, "json");
        }

        $("#upvote").click(function () {
            const $this = $(this);
            if (interactionState.vote === 1) {
                sendInteraction("cancelUpvote", {type: "cancelUpvote", fileId: "${file.fileId}"}, (res) => {
                    $this.removeClass("active").html(icons.upvote.normal);
                    $("#voteNum").removeClass("upvoted").text(res.fileVote);
                    interactionState.vote = 0;
                });
            } else if (interactionState.vote === -1) {
                sendInteraction("upvoteFromDownvote", {type: "upvoteFromDownvote", fileId: "${file.fileId}"}, (res) => {
                    $this.addClass("active").html(icons.upvote.active);
                    $("#downvote").removeClass("active").html(icons.downvote.normal);
                    $("#voteNum").removeClass("downvoted").addClass("upvoted").text(res.fileVote);
                    interactionState.vote = 1;
                });
            } else {
                sendInteraction("upvote", {type: "upvote", fileId: "${file.fileId}"}, (res) => {
                    $this.addClass("active").html(icons.upvote.active);
                    $("#voteNum").addClass("upvoted").text(res.fileVote);
                    interactionState.vote = 1;
                });
            }
        });

        $("#downvote").click(function () {
            const $this = $(this);
            if (interactionState.vote === -1) {
                sendInteraction("cancelDownvote", {type: "cancelDownvote", fileId: "${file.fileId}"}, (res) => {
                    $this.removeClass("active").html(icons.downvote.normal);
                    $("#voteNum").removeClass("downvoted").text(res.fileVote);
                    interactionState.vote = 0;
                });
            } else if (interactionState.vote === 1) {
                sendInteraction("downvoteFromUpvote", {type: "downvoteFromUpvote", fileId: "${file.fileId}"}, (res) => {
                    $this.addClass("active").html(icons.downvote.active);
                    $("#upvote").removeClass("active").html(icons.upvote.normal);
                    $("#voteNum").removeClass("upvoted").addClass("downvoted").text(res.fileVote);
                    interactionState.vote = -1;
                });
            } else {
                sendInteraction("downvote", {type: "downvote", fileId: "${file.fileId}"}, (res) => {
                    $this.addClass("active").html(icons.downvote.active);
                    $("#voteNum").addClass("downvoted").text(res.fileVote);
                    interactionState.vote = -1;
                });
            }
        });

        $("#collect").click(function () {
            const $this = $(this);
            sendInteraction("collect", {type: "collect", fileId: "${file.fileId}"}, (res) => {
                if (interactionState.collect) {
                    $this.removeClass("active").html(icons.collect.normal);
                    $("#collectNum").text(res.fileCollect);
                    interactionState.collect = 0;
                } else {
                    $this.addClass("active").html(icons.collect.active);
                    $("#collectNum").text(res.fileCollect);
                    interactionState.collect = 1;
                }
            });
        });

        $("#download").click(function () {
            sendInteraction("download", {type: "download", fileId: "${file.fileId}"}, (res) => {
                $("#downloadNum").text(res.fileDownloadAmount);
            });
        });

        $("#review").on("click", ".comment-item #like", function () {
            const $this = $(this);
            const $commentItem = $this.closest(".comment-item");
            const commentId = $commentItem.data("comment-id");
            const isLiked = interactionState.likedComments[commentId] === true;

            if (!commentId) {
                return;
            }

            sendInteraction("likeComment", {
                type: isLiked ? "cancelLikeComment" : "likeComment",
                commentId: commentId
            }, (res) => {
                if (res.error) {
                    return;
                }
                if (isLiked) {
                    $this.removeClass("active").html(icons.like.normal);
                    interactionState.likedComments[commentId] = false;
                } else {
                    $this.addClass("active").html(icons.like.active);
                    interactionState.likedComments[commentId] = true;
                }
                $this.next("#likeNum").text(res.commentLikedNum);
            });
        });

        initializeState();

        // 回复框管理
        let currentReplyTarget = null;
        let $replyForm = null;
        if ($(".reply-form").length === 0) {
            const replyFormHtml = `
            <form action="commentSaveServlet" method="post" class="reply-form" style="display: none;">
                <textarea name="commentContent" placeholder="回复..." required></textarea>
                <input type="hidden" name="fId" value="${file.fileId}">
                <input type="hidden" name="parentId" id="replyParentId">
                <input type="hidden" name="rootParentId" id="replyRootParentId">
                <input type="submit" value="提交回复">
            </form>
        `;
            $("#review").append(replyFormHtml);
        }
        $replyForm = $(".reply-form");

        $(document).on("click", ".reply a", function (e) {
            e.preventDefault();
            const commentId = $(this).data("comment-id");
            const rootParentId = $(this).data("root-parent-id");
            const username = $(this).data("username");
            const $rootCommentItem = $("#review > .comment-item[data-comment-id='" + rootParentId + "']");
            const $childComments = $rootCommentItem.find(".child-comments");

            if (currentReplyTarget === commentId && $replyForm.is(":visible")) {
                $replyForm.hide();
                currentReplyTarget = null;
            } else {
                $("#replyParentId").val(commentId);
                $("#replyRootParentId").val(rootParentId);
                $replyForm.find("textarea").attr("placeholder", "@" + username);
                if ($childComments.length === 0) {
                    $rootCommentItem.append('<div class="child-comments"></div>');
                }
                $replyForm.appendTo($rootCommentItem.find(".child-comments"));
                $replyForm.show();
                currentReplyTarget = commentId;
                $('html, body').animate({
                    scrollTop: $replyForm.offset().top - 100
                }, 500);
            }
        });

        // 动态创建并显示提示框
        function showAlert(message) {
            // 移除已有的提示框（避免重复）
            $("#myAlert").remove();

            // 创建新的提示框
            const $alertBox = $("<div>", {
                id: "myAlert",
                class: "alert",
                text: message
            });

            // 添加到页面
            $("body").append($alertBox);

            // 显示动画
            $alertBox.fadeIn();
            setTimeout(function () {
                $alertBox.fadeOut(function () {
                    $(this).remove(); // 动画完成后移除元素
                });
            }, 1500); // 1秒后消失
        }

        // 主评论表单提交
        $("#main-comment-form").on("submit", function (e) {
            e.preventDefault();
            const $form = $(this);
            $.ajax({
                url: $form.attr("action"),
                type: "POST",
                data: $form.serialize(),
                dataType: "json",
                success: function (res) {
                    if (res.message) {
                        $form.find("textarea").val(""); // 清空输入框
                        showAlert(res.message);
                        if (res.message === "发送成功") {
                            setTimeout(() => {
                                location.reload(); // 刷新页面
                            }, 3000); // 等待提示消失后再刷新
                        }
                    }
                },
                error: function () {
                    showAlert("发送失败");
                }
            });
        });

        // 回复表单提交
        $replyForm.on("submit", function (e) {
            e.preventDefault();
            const $form = $(this);
            $.ajax({
                url: $form.attr("action"),
                type: "POST",
                data: $form.serialize(),
                dataType: "json",
                success: function (res) {
                    if (res.message) {
                        $form.hide();
                        $form.find("textarea").val("").attr("placeholder", "回复...");
                        currentReplyTarget = null;
                        showAlert(res.message);
                        if (res.message === "发送成功") {
                            setTimeout(() => {
                                location.reload(); // 刷新页面
                            }, 1000); // 等待提示消失后再刷新
                        }
                    }
                },
                error: function () {
                    showAlert("发送失败");
                }
            });
        });

        // 删除评论
        $(document).on("click", ".delete-comment", function (e) {
            e.preventDefault();
            const $this = $(this);
            const href = $this.attr("href");
            $.ajax({
                url: href,
                type: "POST",
                dataType: "json",
                success: function (res) {
                    if (res.message) {
                        showAlert(res.message);
                        if (res.message === "删除成功") {
                            $this.closest(".comment-item").remove();
                        }
                    }
                },
                error: function () {
                    showAlert("删除失败");
                }
            });
        });
    });
</script>
</body>
</html>