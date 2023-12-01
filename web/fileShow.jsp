<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="DTO.User" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2023/11/30 0030
  Time: 9:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script type="text/javascript" src="JS/jquery-3.7.1.js"></script>
    <title>Document</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            word-wrap: break-word;
            font-family: 微软雅黑;
            font-size: 14px;
            color: #444;
            outline: none;
        }

        a.styled-link {
            /* 去除下划线 */
            text-decoration: none;
            /* 文字颜色 */
            color: #333;
            /* 内边距 */
            padding: 5px 10px;
            /* 边框样式 */
            border: 1px solid #333;
            /* 边框圆角 */
            border-radius: 4px;
            /* 背景颜色 */
            background-color: #f1f1f1;
            /* 过渡效果 */
            transition: background-color 0.3s ease-in-out;
            /* 鼠标样式为手型 */
            cursor: pointer;
        }

        a.styled-link:hover {
            /* 鼠标悬停时的背景颜色 */
            background-color: yellow;
        }

        #postComment {
            border: 0;
            border-radius: 5px;
            background-color: rgba(241, 241, 241, .98);
            width: 355px;
            height: 100px;
            padding: 10px;
            resize: none;
        }

        img {
            height: 20px;
        }
    </style>
</head>

<body>
<!-- 标题 -->
<div class="title">
    <h1>${file.fileName}</h1>
</div>
<!-- 互动区 -->
<div class="interact">
    <input type="button" value="点赞" id="upvote">
    <span>已赞</span><label id="upvoteNum">${file.fileVote}</label>
    <input type="button" value="收藏" id="collect">
    <span>收藏人数</span><label id="collectNum">${file.fileCollect}</label>
    <a href="${file.fileDownloadLink}" download="${file.fileDownloadLink}" class="styled-link" id="download">下载</a>
    <span>下载人数</span><label id="downloadNum">${file.fileDownloadAmount}</label>
</div>
<!-- 评论区 -->
<div class="review">
    <%--发表评论--%>
    <form action="commentSaveServlet">
        <input type="hidden" name="fId" value="${file.fileId}">
        <textarea name="commentContent" id="postComment" cols="30" rows="10" placeholder="请输入评论"></textarea>
        <input type="submit" value="提交评论">
    </form>
    <%--评论区列表--%>
    <div>
        <c:forEach items="${commentList}" var="comment">
            <div class="img">
                <img src="${comment.userImgPath}" alt="">
            </div>
            <div class="userName">
                <span>用户名:${comment.userName}</span>
                <span>userId:${comment.uId}</span>
            </div>
            <div class="comment">
                <span>${comment.commentContent}</span>
            </div>
            <%--${comment.uId==user.getUserId()}--%>
            <%--判断如果是该用户的评论，就可以删除--%>
            <c:if test="${comment.uId==user.getUserId()}">
                <div class="delete">
                    <a href="commentDeleteServlet?commentId=${comment.commentId}&&fId=${file.fileId}">删除评论</a>
                </div>
            </c:if>
        </c:forEach>
    </div>
</div>
</body>
<script>
    var flag = 0;
    if ("${user_file}" != "") {
        $("#collect").css("background-color", "pink");
        flag = 1;
    } else {
        $("#collect").css("background-color", "white");
    }
    // ajax实现互动
    $("#upvote").click(function () {
        // 参数1:请求的urL
        // 参数2:传递的参数
        // 参数3:回调函数
        // 参数4,服务器返回的数据的格式(json,html,text,xml)
        $.post("interactServlet", {type: "upvote", fileId: "${file.fileId}"}, function (res) {
            $("#upvoteNum").replaceWith("<label id='upvoteNum'>" + res.fileVote + "</label>");
        }, "json");
        // $(this).attr('disabled', true);
    })
    $("#collect").click(function () {
        $.post("interactServlet", {type: "collect", fileId: "${file.fileId}"}, function (res) {
            $("#collectNum").replaceWith("<label id='collectNum'>" + res.fileCollect + "</label>");
        }, "json");
        if (flag == 0) {
            $(this).css("background-color", "pink");
            flag = 1;
        } else {
            $(this).css("background-color", "white");
            flag = 0;
        }
    })
    $("#download").click(function () {
        $.post("interactServlet", {type: "download", fileId: "${file.fileId}"}, function (res) {
            $("#downloadNum").replaceWith("<label id='downloadNum'>" + res.fileDownloadAmount + "</label>");
        }, "json");
    })
</script>
</html>
