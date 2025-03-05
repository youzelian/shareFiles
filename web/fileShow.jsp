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

        <c:forEach var="comment" items="${commentList}">
            <div class="comment-item" data-comment-id="${comment.commentId}">
                <img src="${comment.userImgPath}" class="comment-img" alt="">
                <div class="comment-main">
                    <div class="username">
                        <span>${comment.userName}</span>
                    </div>
                    <div class="content">
                        <p>${comment.commentContent}</p>
                    </div>
                    <div class="footer">
                        <span>${comment.commentCreateTime}</span>
                            <%--点赞--%>
                        <button class="iconfont" id="like"></button>
                            <%--点赞数--%>
                        <span id="likeNum">${comment.commentLiked}</span>
                        <div class="reply">
                            <a href="javascript:void(0)" data-comment-id="${comment.commentId}"
                               data-root-parent-id="${comment.rootParentId != 0 ? comment.rootParentId : comment.commentId}"
                               data-username="${comment.userName}">回复</a>
                        </div>
                        <c:if test="${sessionScope.user.userId == comment.uId}">
                            <div class="delete">
                                <a href="commentDeleteServlet?commentId=${comment.commentId}&fId=${file.fileId}">删除</a>
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
                $("#downvote").addClass("active").html(icons.downvote.normal);
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

        // 回复框管理
        let currentReplyTarget = null; // 当前回复的目标评论 ID
        let $replyForm = null; // 全局唯一的回复框

        // 初始化唯一回复框
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

        // 点击回复的处理函数
        $(document).on("click", ".reply a", function (e) {
            e.preventDefault();
            const commentId = $(this).data("comment-id");
            const rootParentId = $(this).data("root-parent-id");
            const username = $(this).data("username"); // 获取被回复的用户名
            const $rootCommentItem = $("#review > .comment-item[data-comment-id='" + rootParentId + "']");
            const $childComments = $rootCommentItem.find(".child-comments");

            // 如果当前回复框已显示且目标相同，则隐藏
            if (currentReplyTarget === commentId && $replyForm.is(":visible")) {
                $replyForm.hide();
                currentReplyTarget = null;
            } else {
                // 更新回复框内容并显示
                $("#replyParentId").val(commentId);
                $("#replyRootParentId").val(rootParentId);
                // 动态设置 placeholder 为 @用户名
                $replyForm.find("textarea").attr("placeholder", "@" + username);
                // 如果没有 child-comments，则先创建一个空的
                if ($childComments.length === 0) {
                    $rootCommentItem.append('<div class="child-comments"></div>');
                }
                // 追加到 child-comments 内部
                $replyForm.appendTo($rootCommentItem.find(".child-comments"));
                $replyForm.show();
                currentReplyTarget = commentId;

                // 自动滚动到回复框
                $('html, body').animate({
                    scrollTop: $replyForm.offset().top - 100 // 偏移 100px 留出顶部空间
                }, 500); // 500ms 平滑滚动
            }
        });

        // 提交后隐藏回复框并重置 placeholder
        $replyForm.on("submit", function () {
            $(this).hide();
            $(this).find("textarea").attr("placeholder", "回复..."); // 重置 placeholder
            currentReplyTarget = null;
        });
    });
</script>
</body>
</html>