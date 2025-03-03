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

        /*标头*/
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

        /*发帖人信息*/
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

        /*内容*/
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
            display: inline-block;
            text-decoration: none;
            color: #3498db;
            font-weight: 500;
            padding: 8px 16px;
            border-radius: 20px;
            background: #e6f3ff;
            transition: all 0.3s ease;
        }

        #content a.styled-link:hover {
            background: #d5ebff;
            color: #2980b9;
        }

        /*互动区*/
        #interact {
            padding: 15px 20px;
            background: white;
            display: flex;
            align-items: center;
            gap: 15px;
        }

        #interact span {
            /*color: #2c3e50;*/
            font-weight: 500;
            font-size: 16px;
        }

        #interact #upvote, #interact #downvote, #interact #collect {
            background: none;
            border: none;
            cursor: pointer;
            font-size: 16px;
            color: #7f8c8d;
            transition: color 0.3s ease;
        }

        /* 鼠标悬停效果 */
        #interact #upvote:hover {
            color: #3498db;
        }

        #interact #downvote:hover {
            color: #e91e63;
        }

        /* 激活状态 */
        #interact #upvote.active {
            color: #3498db;
        }

        #interact #downvote.active {
            color: #e91e63;
        }

        #interact #collect.active {
            color: #fce654;
        }


        #interact #voteNum.upvoted {
            color: #3498db;
        }

        #interact #voteNum.downvoted {
            color: #e91e63;
        }


        /*评论区*/
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
    <%--标头--%>
    <div id="head">
        <%--返回按钮--%>
        <div class="back">
            <a href="communityListServlet" class="iconfont" title="返回动态广场"></a>
        </div>
        <%--文件所属俱乐部--%>
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

    <%--内容--%>
    <div id="content">
        <h2>${file.fileTitle}</h2>
        <p>${file.fileIntroduction}</p>
        <a href="${file.fileDownloadLink}" download="${file.fileDownloadLink}" class="styled-link"
           id="download">下载</a>
    </div>

    <!-- 互动区 -->
    <div id="interact">
        <%--点赞和点踩--%>
        <button class="iconfont" id="upvote"></button>
        <span id="voteNum">${file.fileVote}</span>
        <button class="iconfont" id="downvote"></button>
        <%--收藏--%>
        <button class="iconfont" id="collect">&#xe674;</button>
        <span id="collectNum">${file.fileCollect}</span>
    </div>

    <!-- 评论区 -->
    <div id="review">
        <%--发表评论--%>
        <form action="commentSaveServlet">
            <img src="${user.userImgPath}" alt="">
            <input type="hidden" name="fId" value="${file.fileId}">
            <textarea name="commentContent" id="postComment" placeholder="请输入评论"></textarea>
            <input type="submit" value="提交评论">
        </form>
        <%--评论区列表--%>
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
    // 记录用户的点赞/点踩状态（0: 未操作, 1: 已点赞, -1: 已点踩）
    let voteStatus = 0;

    // 初始化时检查用户是否已点赞/点踩（假设后端返回用户状态）
    $(document).ready(function () {
        // 假设后端通过某个变量传递用户是否已点赞/点踩的状态
        const userVoteStatus = "${user_vote_status}"; // 假设后端返回 "upvote", "downvote", 或空字符串
        if (userVoteStatus === "upvote") {
            voteStatus = 1;
            $("#upvote").addClass("active").html(""); // 已点赞图标
            $("#voteNum").addClass("upvoted");
        } else if (userVoteStatus === "downvote") {
            voteStatus = -1;
            $("#downvote").addClass("active").html(""); // 已点踩图标
            $("#voteNum").addClass("downvoted");
        }

        // 初始化收藏状态
        let collectFlag = "${user_file}" !== "" ? 1 : 0;
        if (collectFlag) {
            $("#collect").addClass("active");
        }

        // 点赞逻辑
        $("#upvote").click(function () {
            if (voteStatus === 1) {
                // 已点赞，再次点击取消点赞
                $.post("interactServlet", {type: "cancelUpvote", fileId: "${file.fileId}"}, function (res) {
                    $("#voteNum").replaceWith("<label id='voteNum'>" + res.fileVote + "</label>");
                    $("#upvote").removeClass("active").html(""); // 恢复未点赞图标
                    $("#voteNum").removeClass("upvoted");
                    voteStatus = 0;
                }, "json");
            } else {
                // 未点赞，执行点赞
                $.post("interactServlet", {type: "upvote", fileId: "${file.fileId}"}, function (res) {
                    $("#voteNum").replaceWith("<label id='voteNum'>" + res.fileVote + "</label>");
                    $("#upvote").addClass("active").html(""); // 切换为已点赞图标
                    $("#downvote").removeClass("active").html(""); // 恢复未点踩图标
                    $("#voteNum").removeClass("downvoted").addClass("upvoted");
                    voteStatus = 1;
                }, "json");
            }
        });

        // 点踩逻辑
        $("#downvote").click(function () {
            if (voteStatus === -1) {
                // 已点踩，再次点击取消点踩
                $.post("interactServlet", {type: "cancelDownvote", fileId: "${file.fileId}"}, function (res) {
                    $("#voteNum").replaceWith("<label id='voteNum'>" + res.fileVote + "</label>");
                    $("#downvote").removeClass("active").html(""); // 恢复未点踩图标
                    $("#voteNum").removeClass("downvoted");
                    voteStatus = 0;
                }, "json");
            } else {
                // 未点踩，执行点踩
                $.post("interactServlet", {type: "downvote", fileId: "${file.fileId}"}, function (res) {
                    $("#voteNum").replaceWith("<label id='voteNum'>" + res.fileVote + "</label>");
                    $("#downvote").addClass("active").html(""); // 切换为已点踩图标
                    $("#upvote").removeClass("active").html(""); // 恢复未点赞图标
                    $("#voteNum").removeClass("upvoted").addClass("downvoted");
                    voteStatus = -1;
                }, "json");
            }
        });

        // 收藏逻辑
        $("#collect").click(function () {
            $.post("interactServlet", {type: "collect", fileId: "${file.fileId}"}, function (res) {
                $("#collectNum").replaceWith("<label id='collectNum'>" + res.fileCollect + "</label>");
            }, "json");
            $(this).toggleClass("active");
            collectFlag = !collectFlag;
        });

        // 下载逻辑
        $("#download").click(function () {
            $.post("interactServlet", {type: "download", fileId: "${file.fileId}"}, function (res) {
                $("#downloadNum").replaceWith("<label id='downloadNum'>" + res.fileDownloadAmount + "</label>");
            }, "json");
        });
    });
</script>
</body>
</html>