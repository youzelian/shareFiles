<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:forEach var="comment" items="${childComments}">
    <div class="comment-item" data-comment-id="${comment.commentId}">
        <img src="${comment.userImgPath}" class="comment-img-second" alt="">
        <div class="comment-main">
            <div class="username">
                <span class="iconfont">
                    ${comment.userName}
                    <c:if test="${not empty comment.repliedUserName}">
                         ${comment.repliedUserName}
                    </c:if>
                </span>
            </div>
            <div class="content">
                <p>${comment.commentContent}</p>
            </div>
            <div class="footer">
                <span class="time">${comment.commentCreateTime}</span>
                    <%--点赞--%>
                <button class="iconfont" id="like"></button>
                    <%--点赞数--%>
                <span id="likeNum">${comment.commentLikedNum}</span>
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
    </div>
</c:forEach>