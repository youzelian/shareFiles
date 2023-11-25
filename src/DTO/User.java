package DTO;

public class User {
    private int userId;
    private String userName;
    private String userPwd;
    private String userGender;
    private String userEmail;
    private int userTel;
    private String userAddress;
    private String userImgPath;
    private String personalSignature;
    private String userOfClub;
    
    @Override
    public String toString() {
        return "User{" +
                "userId=" + userId +
                ", userName='" + userName + '\'' +
                ", userPwd='" + userPwd + '\'' +
                ", userGender='" + userGender + '\'' +
                ", userEmail='" + userEmail + '\'' +
                ", userTel=" + userTel +
                ", userAddress='" + userAddress + '\'' +
                ", userImgPath='" + userImgPath + '\'' +
                ", personalSignature='" + personalSignature + '\'' +
                ", userOfClub='" + userOfClub + '\'' +
                '}';
    }
    
    public User() {
    }
    
    public User(String userName, String userPwd) {
        this.userName = userName;
        this.userPwd = userPwd;
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
    
    public int getUserTel() {
        return userTel;
    }
    
    public void setUserTel(int userTel) {
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
}
