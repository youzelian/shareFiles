package DTO;

import com.fasterxml.jackson.annotation.JsonInclude;

import java.io.Serializable;

// 当服务器重启或应用重新部署时，会导致已有的Session对象丢失。
// 为了解决这个问题，可以使用持久化存储来保存Session数据，例如使用数据库或文件系统。
// 这样即使服务器重启，也能够恢复之前的Session数据。
// 此处是为了session长期保存，即使服务器重新启动也能保存
@JsonInclude(JsonInclude.Include.NON_NULL)
public class User implements Serializable {
    
    private int userId;
    private String userName;
    private String userPwd;
    private String userGender;
    private String userEmail;
    private String userTel;
    private String userAddress;
    private String userImgPath;
    private String personalSignature;
    private String userOfClub;
    private String pwdReq;
    private String pwdReqAnswer;
    
    public User() {
    }
    
    public User(String userName, String userPwd) {
        this.userName = userName;
        this.userPwd = userPwd;
    }
    
    public User(int userId, String userName, String userGender, String userEmail, String userTel, String userAddress, String userImgPath, String personalSignature, String pwdReq, String pwdReqAnswer) {
        this.userId = userId;
        this.userName = userName;
        this.userGender = userGender;
        this.userEmail = userEmail;
        this.userTel = userTel;
        this.userAddress = userAddress;
        this.userImgPath = userImgPath;
        this.personalSignature = personalSignature;
        this.pwdReq = pwdReq;
        this.pwdReqAnswer = pwdReqAnswer;
    }
    
    @Override
    public String toString() {
        return "User{" +
                "userId=" + userId +
                ", userName='" + userName + '\'' +
                ", userPwd='" + userPwd + '\'' +
                ", userGender='" + userGender + '\'' +
                ", userEmail='" + userEmail + '\'' +
                ", userTel='" + userTel + '\'' +
                ", userAddress='" + userAddress + '\'' +
                ", userImgPath='" + userImgPath + '\'' +
                ", personalSignature='" + personalSignature + '\'' +
                ", userOfClub='" + userOfClub + '\'' +
                ", pwdReq='" + pwdReq + '\'' +
                ", pwdReqAnswer='" + pwdReqAnswer + '\'' +
                '}';
    }
    
    public int getUserId() {
        return userId;
    }
    
    public void setUserId(int userId) {
        this.userId = userId;
    }
    
    public String getUserName() {
        return userName;
    }
    
    public void setUserName(String userName) {
        this.userName = userName;
    }
    
    public String getUserPwd() {
        return userPwd;
    }
    
    public void setUserPwd(String userPwd) {
        this.userPwd = userPwd;
    }
    
    public String getUserGender() {
        return userGender;
    }
    
    public void setUserGender(String userGender) {
        this.userGender = userGender;
    }
    
    public String getUserEmail() {
        return userEmail;
    }
    
    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }
    
    public String getUserTel() {
        return userTel;
    }
    
    public void setUserTel(String userTel) {
        this.userTel = userTel;
    }
    
    public String getUserAddress() {
        return userAddress;
    }
    
    public void setUserAddress(String userAddress) {
        this.userAddress = userAddress;
    }
    
    public String getUserImgPath() {
        return userImgPath;
    }
    
    public void setUserImgPath(String userImgPath) {
        this.userImgPath = userImgPath;
    }
    
    public String getPersonalSignature() {
        return personalSignature;
    }
    
    public void setPersonalSignature(String personalSignature) {
        this.personalSignature = personalSignature;
    }
    
    public String getUserOfClub() {
        return userOfClub;
    }
    
    public void setUserOfClub(String userOfClub) {
        this.userOfClub = userOfClub;
    }
    
    public String getPwdReq() {
        return pwdReq;
    }
    
    public void setPwdReq(String pwdReq) {
        this.pwdReq = pwdReq;
    }
    
    public String getPwdReqAnswer() {
        return pwdReqAnswer;
    }
    
    public void setPwdReqAnswer(String pwdReqAnswer) {
        this.pwdReqAnswer = pwdReqAnswer;
    }
}
