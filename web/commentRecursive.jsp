<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:forEach var="comment" items="${childComments}">
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

        <!-- 递归展示子评论 -->
        <c:if test="${not empty comment.childComments}">
            <div class="child-comments">
                <c:set var="childComments" value="${comment.childComments}" scope="request"/>
                <c:import url="commentRecursive.jsp"/>
            </div>
        </c:if>
    </div>
</c:forEach>