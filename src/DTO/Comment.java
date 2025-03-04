package DTO;

import java.util.List;

public class Comment {
    private int commentId; // 评论ID
    private int fId; // 帖子（文件）ID
    private int uId; // 用户ID
    private String commentContent;  // 评论内容
    private int isDeleted;  // 是否被删除  0-未删除；1-已删除
    private String commentCreateTime; // 创建时间
    private int commentLiked;    // 被点赞数
    private int parentId;   // 父评论ID（被回复的评论）
    private int rootParentId;   // 根评论ID
    private List<Comment> childComments; // 子评论


    private String userName;  // 用户名
    private String userImgPath; // 用户头像路径

    public Comment(int fId, int uId, String commentContent, int parentId, int rootParentId, String userName, String userImgPath) {
        this.fId = fId;
        this.uId = uId;
        this.commentContent = commentContent;
        this.parentId = parentId;
        this.rootParentId = rootParentId;
        this.userName = userName;
        this.userImgPath = userImgPath;
    }

    public Comment() {

    }

    @Override
    public String toString() {
        return "Comment{" +
                "commentId=" + commentId +
                ", fId=" + fId +
                ", uId=" + uId +
                ", commentContent='" + commentContent + '\'' +
                ", isDeleted=" + isDeleted +
                ", commentCreateTime='" + commentCreateTime + '\'' +
                ", commentLiked=" + commentLiked +
                ", parentId=" + parentId +
                ", rootParentId=" + rootParentId +
                ", childComments=" + childComments +
                ", userName='" + userName + '\'' +
                ", userImgPath='" + userImgPath + '\'' +
                '}';
    }

    public int getCommentId() {
        return commentId;
    }

    public void setCommentId(int commentId) {
        this.commentId = commentId;
    }

    public int getfId() {
        return fId;
    }

    public void setfId(int fId) {
        this.fId = fId;
    }

    public int getuId() {
        return uId;
    }

    public void setuId(int uId) {
        this.uId = uId;
    }

    public String getCommentContent() {
        return commentContent;
    }

    public void setCommentContent(String commentContent) {
        this.commentContent = commentContent;
    }

    public int getIsDeleted() {
        return isDeleted;
    }

    public void setIsDeleted(int isDeleted) {
        this.isDeleted = isDeleted;
    }

    public String getCommentCreateTime() {
        return commentCreateTime;
    }

    public void setCommentCreateTime(String commentCreateTime) {
        this.commentCreateTime = commentCreateTime;
    }

    public int getCommentLiked() {
        return commentLiked;
    }

    public void setCommentLiked(int commentLiked) {
        this.commentLiked = commentLiked;
    }

    public int getParentId() {
        return parentId;
    }

    public void setParentId(int parentId) {
        this.parentId = parentId;
    }

    public int getRootParentId() {
        return rootParentId;
    }

    public void setRootParentId(int rootParentId) {
        this.rootParentId = rootParentId;
    }

    public List<Comment> getChildComments() {
        return childComments;
    }

    public void setChildComments(List<Comment> childComments) {
        this.childComments = childComments;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserImgPath() {
        return userImgPath;
    }

    public void setUserImgPath(String userImgPath) {
        this.userImgPath = userImgPath;
    }
}
