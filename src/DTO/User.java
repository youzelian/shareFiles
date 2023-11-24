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
    private String personal_signature;
    private String userOfClub;
    private String userMy;
    
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
                ", personal_signature='" + personal_signature + '\'' +
                ", userOfClub='" + userOfClub + '\'' +
                ", userMy='" + userMy + '\'' +
                '}';
    }
    
    public User() {
    }
    
    public User(String userName, String userPwd) {
        this.userName = userName;
        this.userPwd = userPwd;
    }
    
    public String getUserImgPath() {
        return userImgPath;
    }
    
    public void setUserImgPath(String userImgPath) {
        this.userImgPath = userImgPath;
    }
    
    public String getPersonal_signature() {
        return personal_signature;
    }
    
    public void setPersonal_signature(String personal_signature) {
        this.personal_signature = personal_signature;
    }
    
    public String getUserOfClub() {
        return userOfClub;
    }
    
    public void setUserOfClub(String userOfClub) {
        this.userOfClub = userOfClub;
    }
    
    public String getUserMy() {
        return userMy;
    }
    
    public void setUserMy(String userMy) {
        this.userMy = userMy;
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
    
    public String getUserEmail() {
        return userEmail;
    }
    
    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }
    
    public String getUserGender() {
        return userGender;
    }
    
    public void setUserGender(String userGender) {
        this.userGender = userGender;
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
}
