package DTO;

public class User_File {
    private int ufId;
    private int uId;
    private int fId;
    private String userImgPath;
    private String userName;
    private String fileName;
    private String fileType;
    private String fileDownloadLink;
    private int fileVote;
    private int fileCollect;
    private int fileDownloadAmount;
    private int fileOfClub;
    private String fileIntroduction;
    private String clubName;

    public User_File() {
    }

    public User_File(int uId, int fId) {
        this.uId = uId;
        this.fId = fId;
    }

    public User_File(int ufId, int uId, int fId, String userImgPath, String userName, String fileName, String fileType, String fileDownloadLink, int fileVote, int fileCollect, int fileDownloadAmount, int fileOfClub, String fileIntroduction, String clubName) {
        this.ufId = ufId;
        this.uId = uId;
        this.fId = fId;
        this.userImgPath = userImgPath;
        this.userName = userName;
        this.fileName = fileName;
        this.fileType = fileType;
        this.fileDownloadLink = fileDownloadLink;
        this.fileVote = fileVote;
        this.fileCollect = fileCollect;
        this.fileDownloadAmount = fileDownloadAmount;
        this.fileOfClub = fileOfClub;
        this.fileIntroduction = fileIntroduction;
        this.clubName = clubName;
    }

    @Override
    public String toString() {
        return "User_File{" +
                "ufId=" + ufId +
                ", uId=" + uId +
                ", fId=" + fId +
                ", userImgPath='" + userImgPath + '\'' +
                ", userName='" + userName + '\'' +
                ", fileName='" + fileName + '\'' +
                ", fileType='" + fileType + '\'' +
                ", fileDownloadLink='" + fileDownloadLink + '\'' +
                ", fileVote=" + fileVote +
                ", fileCollect=" + fileCollect +
                ", fileDownloadAmount=" + fileDownloadAmount +
                ", fileOfClub=" + fileOfClub +
                ", fileIntroduction='" + fileIntroduction + '\'' +
                ", clubName='" + clubName + '\'' +
                '}';
    }

    public int getUfId() {
        return ufId;
    }

    public void setUfId(int ufId) {
        this.ufId = ufId;
    }

    public int getuId() {
        return uId;
    }

    public void setuId(int uId) {
        this.uId = uId;
    }

    public int getfId() {
        return fId;
    }

    public void setfId(int fId) {
        this.fId = fId;
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

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public String getFileType() {
        return fileType;
    }

    public void setFileType(String fileType) {
        this.fileType = fileType;
    }

    public String getFileDownloadLink() {
        return fileDownloadLink;
    }

    public void setFileDownloadLink(String fileDownloadLink) {
        this.fileDownloadLink = fileDownloadLink;
    }

    public int getFileVote() {
        return fileVote;
    }

    public void setFileVote(int fileVote) {
        this.fileVote = fileVote;
    }

    public int getFileCollect() {
        return fileCollect;
    }

    public void setFileCollect(int fileCollect) {
        this.fileCollect = fileCollect;
    }

    public int getFileDownloadAmount() {
        return fileDownloadAmount;
    }

    public void setFileDownloadAmount(int fileDownloadAmount) {
        this.fileDownloadAmount = fileDownloadAmount;
    }

    public int getFileOfClub() {
        return fileOfClub;
    }

    public void setFileOfClub(int fileOfClub) {
        this.fileOfClub = fileOfClub;
    }

    public String getFileIntroduction() {
        return fileIntroduction;
    }

    public void setFileIntroduction(String fileIntroduction) {
        this.fileIntroduction = fileIntroduction;
    }

    public String getClubName() {
        return clubName;
    }

    public void setClubName(String clubName) {
        this.clubName = clubName;
    }
}
