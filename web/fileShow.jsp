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
    <link rel="stylesheet" href="fonts/font_back/iconfont.css">
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

        #interact {
            padding: 15px 20px;
            background: white;
            display: flex;
            align-items: center;
            gap: 15px;
        }

        #interact input[type="button"] {
            padding: 8px 16px;
            border: none;
            border-radius: 20px;
            cursor: pointer;
            font-size: 14px;
            transition: all 0.3s ease;
        }

        #interact #upvote, #interact #downvote {
            background-color: #ecf0f1;
            color: #7f8c8d;
        }

        #interact #upvote:hover, #interact #downvote:hover {
            background-color: #dfe6e9;
            color: #2c3e50;
        }

        #interact #collect {
            background-color: #fff;
            border: 1px solid #ddd;
        }

        #interact #collect.active {
            background-color: #ffebee;
            border-color: #ffcdd2;
            color: #e91e63;
        }

        #interact #collect:hover {
            background-color: #f8f9fa;
        }

        #interact span {
            color: #95a5a6;
            font-size: 14px;
        }

        #interact label {
            color: #2c3e50;
            font-weight: 500;
        }

        #interact a {
            text-decoration: none;
            color: #3498db;
            font-weight: 500;
            padding: 8px 16px;
            border-radius: 20px;
            background: #e6f3ff;
            transition: all 0.3s ease;
        }

        #interact a:hover {
            background: #d5ebff;
            color: #2980b9;
        }

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
            <a href="communityListServlet" class="iconfont" title="返回动态广场">&#xe63b;</a>
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
        <%--此处太麻烦，后面再写--%>
        <p>IP属地：江西</p>
    </div>

    <%--内容--%>
    <div id="content">
        <h2>${file.fileName}</h2>
        <p>${file.fileIntroduction}</p>
        <a href="${file.fileDownloadLink}" download="${file.fileDownloadLink}" class="styled-link"
           id="download">下载</a>
        <%--如果上传的是pdf、zip、word等文件则在互动区显示下载链接按钮，如果是图片或者视频则展示在内容区域--%>
    </div>

    <!-- 互动区 -->
    <div id="interact">
        <button class="iconfont" id="upvote">&#xe63c;</button>
        <label id="voteNum">${file.fileVote}</label>
        <button class="iconfont" id="downvote">&#xe609;</button>
        <button class="iconfont" id="collect">&#xe642;</button>
        <label id="collectNum">${file.fileCollect}</label>
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
    var flag = 0;
    if ("${user_file}" != "") {
        $("#collect").addClass("active");
        flag = 1;
    }
    // ajax实现互动
    // 点赞
    $("#upvote").click(function () {
        $.post("interactServlet", {type: "upvote", fileId: "${file.fileId}"}, function (res) {
            $("#voteNum").replaceWith("<label id='voteNum'>" + res.fileVote + "</label>");
        }, "json");
    });

    // 踩
    $("#downvote").click(function () {
        $.post("interactServlet", {type: "downvote", fileId: "${file.fileId}"}, function (res) {
            $("#voteNum").replaceWith("<label id='voteNum'>" + res.fileVote + "</label>");
        }, "json");
    });

    // 收藏
    $("#collect").click(function () {
        $.post("interactServlet", {type: "collect", fileId: "${file.fileId}"}, function (res) {
            $("#collectNum").replaceWith("<label id='collectNum'>" + res.fileCollect + "</label>");
        }, "json");
        $(this).toggleClass("active");
        flag = !flag;
    });

    // 下载
    $("#download").click(function () {
        $.post("interactServlet", {type: "download", fileId: "${file.fileId}"}, function (res) {
            $("#downloadNum").replaceWith("<label id='downloadNum'>" + res.fileDownloadAmount + "</label>");
        }, "json");
    });
</script>
</body>
</html>