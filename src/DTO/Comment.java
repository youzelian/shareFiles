package DTO;

public class Comment {
    private int commentId;
    private int fId;
    private int uId;
    private String commentContent;
    private String userImgPath;
    private String userName;
    
    public Comment() {
    }
    
    public Comment(int fId, int uId, String commentContent) {
        this.fId = fId;
        this.uId = uId;
        this.commentContent = commentContent;
    }
    
    @Override
    public String toString() {
        return "Comment{" +
                "commentId=" + commentId +
                ", fId=" + fId +
                ", uId=" + uId +
                ", commentContent='" + commentContent + '\'' +
                ", userImgPath='" + userImgPath + '\'' +
                ", userName='" + userName + '\'' +
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
    
    public String getUserImgPath() {
        return userImgPath;
    }
    
    public void setUserImgPath(String userImgPath) {
        this.userImgPath = userImgPath;
    }
    
    public String getUserName() {
        return userName;
    }
    
    public void setUserName(String userName) {
        this.userName = userName;
    }
}
