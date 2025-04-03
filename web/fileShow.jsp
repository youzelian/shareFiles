<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <%--<meta name="viewport" content="width=device-width, initial-scale=1.0">--%>
    <script type="text/javascript" src="JS/jquery-3.7.1.js"></script>
    <title>文件详情</title>
    <link rel="stylesheet" href="fonts/iconfont.css">
    <style>
        /* 全局基础样式 */
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
            width: 80%;
            max-width: 1280px;
            margin: 0 auto;
            background: #fff;
            padding: 30px;
            border-radius: 16px;
            box-shadow: 0 6px 18px rgba(0, 0, 0, 0.06);
            position: relative;
            animation: fadeIn 0.8s ease-in-out;
        }

        /* 标头区域css代码 */
        #head {
            display: flex;
            align-items: center;
            padding: 15px 20px;
            background: linear-gradient(135deg, #ffffff, #f8f9fd);
            position: sticky;
            top: -5px;
            z-index: 10;
            border-bottom: 1px solid rgba(0, 0, 0, 0.1);
        }

        /* 返回按钮 */
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

        /* 文件所属俱乐部的头像格式 */
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

        /* 标头区域css代码结束 */

        /* 标题区域样式 */
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

        /* 内容区域样式 */
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

        /* 图片展示区域样式 */
        #imageGallery {
            display: grid;
            gap: 4px;
            margin-top: 10px;
            padding: 5px;
        }

        #imageGallery img {
            width: 100%;
            height: 225px;
            object-fit: cover;
            border-radius: 10px;
            background-color: #fff;
            cursor: pointer;
            transition: transform 0.3s ease;
        }

        @media (max-width: 600px) {
            #imageGallery img {
                height: 100px;
            }
        }

        /* 文件下载链接样式 */
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
            flex: 1;
            overflow: hidden;
        }

        #content a.styled-link .file-info h4 {
            font-size: 14px;
            font-weight: 500;
            margin: 0;
            color: #177bcb;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        #content a.styled-link p {
            font-size: 12px;
            color: #7f8c8d;
            margin: 0;
        }

        /* 交互按钮区域样式 */
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

        /* 评论区整体样式 */
        #review {
            padding-top: 20px;
            background: white;
        }

        /* 主评论表单样式 */
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
            position: relative;
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
            background: #f9fafc;
            color: #92c1f3;
            border: none;
            cursor: pointer;
            font-weight: 500;
            font-size: 14px;
            transition: color 0.3s ease;
        }

        #review form input[type="submit"]:hover {
            color: #3498db;
        }

        /* 回复评论表单样式 */
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

        /* 主评论项样式 */
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

        /* 子评论区域样式 */
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

        /* 图片预览模态框样式 */
        .image-preview {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.9);
            z-index: 1001;
            justify-content: center;
            align-items: center;
        }

        .image-preview.active {
            display: flex;
        }

        .image-preview img {
            max-width: 90%;
            max-height: 90vh;
            border-radius: 10px;
            object-fit: contain;
        }

        .image-preview .controls {
            position: absolute;
            top: 50%;
            width: 100%;
            display: flex;
            justify-content: space-between;
            padding: 0 20px;
            transform: translateY(-50%);
        }

        .image-preview .controls button {
            background: rgba(255, 255, 255, 0.2);
            border: none;
            color: white;
            font-size: 30px;
            cursor: pointer;
            padding: 10px;
            border-radius: 50%;
            transition: background 0.3s ease;
        }

        .image-preview .controls button:hover {
            background: rgba(255, 255, 255, 0.4);
        }

        .image-preview .close-btn {
            position: absolute;
            top: 20px;
            right: 20px;
            background: rgba(255, 255, 255, 0.2);
            border: none;
            color: white;
            font-size: 24px;
            cursor: pointer;
            padding: 5px 10px;
            border-radius: 50%;
            transition: background 0.3s ease;
        }

        .image-preview .close-btn:hover {
            background: rgba(255, 255, 255, 0.4);
        }

        /* 提示框样式 */
        .alert {
            padding: 10px 20px;
            background-color: #333;
            color: white;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            z-index: 1000;
            display: none;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
            font-size: 14px;
            font-weight: 500;
            text-align: center;
        }

        /* 添加表情按钮样式 */
        .comment-buttons {
            display: flex;
            gap: 10px;
            margin-top: 5px;
        }

        .add-emoji-btn {
            border: none;
            cursor: pointer;
            font-size: 20px;
        }

        .add-emoji-btn:active {
            transform: translateY(1px);
            box-shadow: 0 1px 3px rgba(52, 152, 219, 0.1);
        }

        /* 表情选择器样式 */
        .emoji-panel {
            display: none; /* 默认隐藏 */
            position: absolute;
            background: #fff;
            border: 1px solid #ccc;
            padding: 10px;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            max-height: 200px;
            overflow-y: auto;
            z-index: 1000;
            grid-template-columns: repeat(6, 1fr); /* 只需要定义网格布局，不需要重复设置 display */
            gap: 5px;
        }

        .emoji-option {
            font-size: 20px;
            cursor: pointer;
            padding: 5px;
            text-align: center;
            transition: background-color 0.2s;
        }

        .emoji-option:hover {
            background-color: #eef2f5;
            border-radius: 4px;
        }
    </style>
</head>
<body>
<%--主要内容--%>
<div class="main">
    <%--标头--%>
    <div id="head">
        <%--返回按钮--%>
        <div class="back">
            <c:if test="${type == 1}">
                <a href="communityListServlet?pageNum=${pageNum}" class="iconfont" title="返回动态广场"></a>
            </c:if>
            <c:if test="${type == 2}">
                <a href="eachClubServlet?clubId=${file_club.cId}&type=1" class="iconfont"
                   title="返回俱乐部"></a>
            </c:if>
            <c:if test="${type == 3}">
                <a href="myFilesListServlet" class="iconfont"
                   title="返回我的文件夹"></a>
            </c:if>
        </div>
        <%--文件所属俱乐部--%>
        <div class="fileOfClub">
            <img src="${file_club.clubImgPath}" alt="">
            <a href="eachClubServlet?clubId=${file_club.cId}&type=1">${file_club.clubName}</a>
        </div>
    </div>

    <%--标题--%>
    <div id="title">
        <img src="${file.userImgPath}" alt="">
        <p>${file.userName}</p>
        <p><fmt:formatDate value="${file.fileCreateTime}" pattern="MM-dd"/></p>
        <%--硬编码，后面再写--%>
        <p>IP属地：江西</p>
    </div>

    <%--内容--%>
    <div id="content">
        <h2>${file.fileTitle}</h2>
        <p>${file.fileIntroduction}</p>
        <%--图片--%>
        <div id="imageGallery">
            <c:if test="${not empty mediaUrls}">
                <c:forEach var="url" items="${mediaUrls}" varStatus="loop">
                    <img src="${url}" alt="图片" loading="lazy" data-index="${loop.index}">
                </c:forEach>
            </c:if>
        </div>
        <%--共享的文件下载链接--%>
        <a href="${file.fileDownloadLink}" download="${file.fileDownloadLink}" class="styled-link" id="download">
            <span class="iconfont"></span>
            <div class="file-info">
                <h4 data-full-name="${file.fileName}">${file.fileName}</h4>
                <p>${file.fileLength}</p>
            </div>
            <span class="iconfont"></span>
        </a>
    </div>

    <%--交互按钮--%>
    <div id="interact">
        <button class="iconfont" id="upvote"></button>
        <span id="voteNum">${file.fileVote}</span>
        <button class="iconfont" id="downvote"></button>
        <button class="iconfont" id="collect"></button>
        <span id="collectNum">${file.fileCollect}</span>
    </div>

    <%--评论区--%>
    <div id="review">
        <%--输入框--%>
        <c:if test="${not empty sessionScope.user}">
            <form action="commentSaveServlet" method="post" id="main-comment-form">
                <img src="${sessionScope.user.userImgPath}" alt="">
                <textarea name="commentContent" placeholder="写下你的评论..." required></textarea>
                <input type="hidden" name="fId" value="${file.fileId}">
                <input type="hidden" name="parentId" value="0">
                <input type="hidden" name="rootParentId" value="0">
                <input type="submit" value="发表评论">
                <div class="comment-buttons">
                    <button type="button" class="add-emoji-btn main-add-emoji iconfont">&#xe6bc;</button>
                </div>
            </form>
        </c:if>

        <%--评论展示区域--%>
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

<!-- 图片预览模态框 -->
<div class="image-preview" id="imagePreviewModal">
    <button class="close-btn iconfont" id="closePreview"></button>
    <div class="controls">
        <button class="iconfont" id="prevImage"></button>
        <button class="iconfont" id="nextImage"></button>
    </div>
    <img src="" alt="预览图片" id="previewImage">
</div>

<!-- 表情选择器 -->
<div class="emoji-panel" id="emojiPanel"></div>

<script>
    $(document).ready(function () {
        // 文件名截断函数(防止文件名过长)
        function truncateFileName() {
            const $fileName = $("#content .file-info h4");
            const fullName = $fileName.data("full-name");
            const maxLength = 20;
            if (fullName.length > maxLength) {
                const extIndex = fullName.lastIndexOf(".");
                const name = fullName.substring(0, extIndex);
                const ext = fullName.substring(extIndex);
                const frontLength = Math.floor((maxLength - ext.length) / 2);
                const backLength = maxLength - ext.length - frontLength - 3;
                const truncatedName = name.substring(0, frontLength) + "..." + name.substring(name.length - backLength) + ext;
                $fileName.text(truncatedName);
            }
            $fileName.attr("title", fullName);
        }

        // ***************互动按钮***************
        // 初始化按钮的交互状态
        const interactionState = {
            vote: "${vote_status}" === "upvote" ? 1 : "${vote_status}" === "downvote" ? -1 : 0,
            collect: "${isCollectByUser}" !== "" ? 1 : 0,
            likedComments: {}
        };
        const icons = {
            upvote: {normal: "", active: ""},
            downvote: {normal: "", active: ""},
            collect: {normal: "", active: ""},
            like: {normal: "", active: ""}
        };

        // 初始化页面状态(互动按钮状态)
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
            $(".comment-item").each(function () {
                const $this = $(this);
                const commentId = $this.data("comment-id");
                const isLiked = $this.data("liked") === true;
                if (isLiked) {
                    $this.find("#like").addClass("active").html(icons.like.active);
                    interactionState.likedComments[commentId] = true;
                } else {
                    interactionState.likedComments[commentId] = false;
                }
            });
        }

        // 发送交互请求的通用函数
        function sendInteraction(type, data, callback) {
            $.post("interactServlet", data, function (res) {
                callback(res);
            }, "json");
        }

        // 点赞功能
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
        // 踩功能
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
        // 收藏功能
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
        // 下载功能
        $("#download").click(function () {
            sendInteraction("download", {type: "download", fileId: "${file.fileId}"}, (res) => {
                // 注意：此处应根据实际返回数据调整
                // $("#downloadNum").text(res.fileDownloadAmount); // 如果有下载量字段，可启用
            });
        });
        // 评论点赞功能
        $("#review").on("click", ".comment-item #like", function () {
            const $this = $(this);
            const $commentItem = $this.closest(".comment-item");
            const commentId = $commentItem.data("comment-id");
            const isLiked = interactionState.likedComments[commentId] === true;

            if (!commentId) return;

            sendInteraction("likeComment", {
                type: isLiked ? "cancelLikeComment" : "likeComment",
                commentId: commentId
            }, (res) => {
                if (res.error) return;
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
        // ***************互动按钮***************


        // ***************图片展示***************
        const $gallery = $("#imageGallery");
        const $images = $gallery.find("img");
        const imageCount = $images.length;
        // 动态调整图片布局(采用九宫格图片布局)
        if (imageCount === 1) {
            $gallery.css("grid-template-columns", "1fr");
        } else if (imageCount === 2) {
            $gallery.css("grid-template-columns", "repeat(2, 1fr)");
        } else if (imageCount === 3) {
            $gallery.css("grid-template-columns", "repeat(3, 1fr)");
        } else if (imageCount === 4) {
            $gallery.css("grid-template-columns", "repeat(2, 1fr)");
            $gallery.css("grid-template-rows", "repeat(2, 225px)");
        } else if (imageCount >= 5 && imageCount <= 6) {
            $gallery.css("grid-template-columns", "repeat(3, 1fr)");
            $gallery.css("grid-template-rows", "repeat(2, 225px)");
        } else if (imageCount >= 7 && imageCount <= 9) {
            $gallery.css("grid-template-columns", "repeat(3, 1fr)");
            $gallery.css("grid-template-rows", "repeat(3, 225px)");
        }

        // 图片预览功能
        // 定义图片预览相关的 DOM 元素和变量
        const $previewModal = $("#imagePreviewModal"); // 图片预览模态框
        const $previewImage = $("#previewImage");       // 预览图片的 img 元素
        const $prevBtn = $("#prevImage");               // 上一张图片按钮
        const $nextBtn = $("#nextImage");               // 下一张图片按钮
        const $closeBtn = $("#closePreview");           // 关闭预览按钮
        let currentIndex = 0;                           // 当前显示图片的索引，默认为 0
        const imageUrls = [];                           // 存储所有图片 URL 的数组

        // 遍历所有图片元素，收集图片的 URL
        $images.each(function (index) {
            imageUrls.push($(this).attr("src"));        // 将每张图片的 src 属性添加到数组
        });
        // 点击图片时触发预览
        $images.on("click", function () {
            currentIndex = $(this).data("index");       // 获取点击图片的索引
            $previewImage.attr("src", imageUrls[currentIndex]); // 设置预览图片的 src
            $previewModal.addClass("active");           // 显示预览模态框
        });
        // 点击“上一张”按钮切换图片
        $prevBtn.on("click", function () {
            currentIndex = (currentIndex - 1 + imageUrls.length) % imageUrls.length; // 计算上一张图片的索引（循环）
            $previewImage.attr("src", imageUrls[currentIndex]); // 更新预览图片的 src
        });
        // 点击“下一张”按钮切换图片
        $nextBtn.on("click", function () {
            currentIndex = (currentIndex + 1) % imageUrls.length; // 计算下一张图片的索引（循环）
            $previewImage.attr("src", imageUrls[currentIndex]);   // 更新预览图片的 src
        });
        // 点击关闭按钮隐藏预览
        $closeBtn.on("click", function () {
            $previewModal.removeClass("active");        // 移除 active 类，隐藏模态框
        });
        // 点击模态框空白区域关闭预览
        $previewModal.on("click", function (e) {
            if (e.target === this) {                    // 判断点击的是模态框本身（而不是内部元素）
                $previewModal.removeClass("active");    // 移除 active 类，隐藏模态框
            }
        });
        // ***************图片展示***************


        // ***************表情包功能***************
        var emojis = [];
        // 通过emojis.json来获取表情包
        $.getJSON("emojis.json", function (data) {
            emojis = data;
        }).fail(function () {
            emojis = [
                {"name": "微笑", "font": "🙂"},
                {"name": "笑脸", "font": "😊"},
                {"name": "点赞", "font": "👍"}
            ];
        });

        // 主评论表情包功能
        $(".main-add-emoji").click(function (e) {
            var panel = $("#emojiPanel");
            panel.empty();
            emojis.forEach(function (emoji) {
                panel.append('<span class="emoji-option" data-name="' + emoji.name + '">' + emoji.font + '</span>');
            });
            var panelWidth = panel.outerWidth();
            panel.css({
                display: panel.is(":visible") ? "none" : "grid",
                top: $(this).offset().top + $(this).outerHeight() + 5,
                left: $(this).offset().left - 275  // 硬编码，后面改
            });
            panel.data("targetTextarea", $(this).closest("form").find("textarea"));
            e.stopPropagation();
        });

        // 回复评论表情包功能
        $(document).on("click", ".reply-add-emoji", function (e) {
            var panel = $("#emojiPanel");
            panel.empty();
            emojis.forEach(function (emoji) {
                panel.append('<span class="emoji-option" data-name="' + emoji.name + '">' + emoji.font + '</span>');
            });
            panel.css({
                display: panel.is(":visible") ? "none" : "grid",
                top: $(this).offset().top + $(this).outerHeight() + 5,
                left: $(this).offset().left - 275  // 硬编码，后面改
            });
            panel.data("targetTextarea", $(this).closest(".reply-form").find("textarea"));
            e.stopPropagation();
        });

        // 将表情包添加到textarea光标位置
        $("#emojiPanel").on("click", ".emoji-option", function () {
            var emoji = $(this).text();
            var targetTextarea = $("#emojiPanel").data("targetTextarea");
            if (targetTextarea && targetTextarea.length) {
                var startPos = targetTextarea[0].selectionStart; // 获取光标起始位置
                var endPos = targetTextarea[0].selectionEnd;     // 获取光标结束位置
                var text = targetTextarea.val();
                // 在光标位置插入表情
                var newText = text.substring(0, startPos) + emoji + text.substring(endPos);
                targetTextarea.val(newText);
                // 移动光标到插入后的位置
                var newCursorPos = startPos + emoji.length;
                targetTextarea[0].setSelectionRange(newCursorPos, newCursorPos);
                targetTextarea[0].focus(); // 保持焦点
            }
            $("#emojiPanel").hide();
        });

        // 为表情添加 title 属性，显示表情的名称
        $("#emojiPanel").on("mouseover", ".emoji-option", function () {
            $(this).attr("title", $(this).data("name"));
        });

        // 检测点击是否在表情面板或按钮外，如果是则隐藏面板
        $(document).click(function (e) {
            if (!$(e.target).closest("#emojiPanel, .main-add-emoji, .reply-add-emoji").length) {
                $("#emojiPanel").hide();
            }
        });
        // ***************表情包功能***************


        // 初始化页面状态和文件名截断
        initializeState();
        truncateFileName();


        // ***************评论区***************
        let currentReplyTarget = null;
        let $replyForm = null;
        // 回复评论功能
        if ($(".reply-form").length === 0) {
            const replyFormHtml = `
            <form action="commentSaveServlet" method="post" class="reply-form" style="display: none;">
                <textarea name="commentContent" placeholder="回复..." required></textarea>
                <input type="hidden" name="fId" value="${file.fileId}">
                <input type="hidden" name="parentId" id="replyParentId">
                <input type="hidden" name="rootParentId" id="replyRootParentId">
                <input type="submit" value="提交回复">
                <div class="comment-buttons">
                    <button type="button" class="add-emoji-btn reply-add-emoji iconfont">&#xe6bc;</button>
                </div>
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
                $replyForm.appendTo($rootCommentItem.find(".child-comments")).show();
                currentReplyTarget = commentId;
                $('html, body').animate({
                    scrollTop: $replyForm.offset().top - 100
                }, 500);
            }
        });

        // 显示提示信息
        function showAlert(message) {
            $("#myAlert").remove();
            const $alertBox = $("<div>", {
                id: "myAlert",
                class: "alert",
                text: message
            });
            $("body").append($alertBox);
            $alertBox.fadeIn();
            setTimeout(function () {
                $alertBox.fadeOut(function () {
                    $(this).remove();
                });
            }, 1500);
        }

        // 主评论提交功能
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
                        $form.find("textarea").val("");
                        showAlert(res.message);
                        if (res.message === "发送成功") {
                            setTimeout(() => {
                                location.reload();
                            }, 3000);
                        }
                    }
                },
                error: function () {
                    showAlert("发送失败");
                }
            });
        });

        // 回复评论提交功能
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
                                location.reload();
                            }, 1000);
                        }
                    }
                },
                error: function () {
                    showAlert("发送失败");
                }
            });
        });

        // 删除评论功能
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
        // ***************评论区***************
    });
</script>
</body>
</html>