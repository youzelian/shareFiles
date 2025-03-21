package DTO;

import java.sql.Timestamp;

public class File {
    private int fileId;
    private String fileTitle;
    private String fileIntroduction;
    private Timestamp fileCreateTime;
    private String fileName;
    private String fileLength;
    private String fileType;
    private String fileDownloadLink;
    private int fileVote;
    private int fileCollect;
    private int fileDownloadAmount;
    private int fileOfClub;
    private int fileOfUser;
    private String mediaUrls;   // 数字媒体url路径内容

    private int voteStatus;   // -1=点踩，0=无，1=点赞
    private boolean isCollectByUser;   // 是否被当前用户收藏 0-没有 1-有
    private String userName;
    private String userImgPath;
    private String clubName;
    private int clubId;

    public File() {
    }

    public File(String fileTitle, String fileIntroduction, String fileName, String fileLength, String fileType, int fileOfClub, int fileOfUser) {
        this.fileTitle = fileTitle;
        this.fileIntroduction = fileIntroduction;
        this.fileName = fileName;
        this.fileLength = fileLength;
        this.fileType = fileType;
        this.fileOfClub = fileOfClub;
        this.fileOfUser = fileOfUser;
    }

    public File(int fileId, int fileVote, int fileCollect, int fileDownloadAmount) {
        this.fileId = fileId;
        this.fileVote = fileVote;
        this.fileCollect = fileCollect;
        this.fileDownloadAmount = fileDownloadAmount;
    }

    public File(int fileId, String fileIntroduction, String fileDownloadLink) {
        this.fileId = fileId;
        this.fileIntroduction = fileIntroduction;
        this.fileDownloadLink = fileDownloadLink;
    }

    @Override
    public String toString() {
        return "File{" +
                "fileId=" + fileId +
                ", fileTitle='" + fileTitle + '\'' +
                ", fileIntroduction='" + fileIntroduction + '\'' +
                ", fileCreateTime=" + fileCreateTime +
                ", fileName='" + fileName + '\'' +
                ", fileLength='" + fileLength + '\'' +
                ", fileType='" + fileType + '\'' +
                ", fileDownloadLink='" + fileDownloadLink + '\'' +
                ", fileVote=" + fileVote +
                ", fileCollect=" + fileCollect +
                ", fileDownloadAmount=" + fileDownloadAmount +
                ", fileOfClub=" + fileOfClub +
                ", fileOfUser=" + fileOfUser +
                ", mediaUrls='" + mediaUrls + '\'' +
                ", voteStatus=" + voteStatus +
                ", isCollectByUser=" + isCollectByUser +
                ", userName='" + userName + '\'' +
                ", userImgPath='" + userImgPath + '\'' +
                ", clubName='" + clubName + '\'' +
                ", clubId=" + clubId +
                '}';
    }

    public int getFileId() {
        return fileId;
    }

    public void setFileId(int fileId) {
        this.fileId = fileId;
    }

    public String getFileTitle() {
        return fileTitle;
    }

    public void setFileTitle(String fileTitle) {
        this.fileTitle = fileTitle;
    }

    public String getFileIntroduction() {
        return fileIntroduction;
    }

    public void setFileIntroduction(String fileIntroduction) {
        this.fileIntroduction = fileIntroduction;
    }

    public Timestamp getFileCreateTime() {
        return fileCreateTime;
    }

    public void setFileCreateTime(Timestamp fileCreateTime) {
        this.fileCreateTime = fileCreateTime;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public String getFileLength() {
        return fileLength;
    }

    public void setFileLength(String fileLength) {
        this.fileLength = fileLength;
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

    public int getFileOfUser() {
        return fileOfUser;
    }

    public void setFileOfUser(int fileOfUser) {
        this.fileOfUser = fileOfUser;
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

    public String getClubName() {
        return clubName;
    }

    public void setClubName(String clubName) {
        this.clubName = clubName;
    }

    public int getClubId() {
        return clubId;
    }

    public void setClubId(int clubId) {
        this.clubId = clubId;
    }

    public int getVoteStatus() {
        return voteStatus;
    }

    public void setVoteStatus(int voteStatus) {
        this.voteStatus = voteStatus;
    }

    public boolean isCollectByUser() {
        return isCollectByUser;
    }

    public void setCollectByUser(boolean collectByUser) {
        isCollectByUser = collectByUser;
    }

    public String getMediaUrls() {
        return mediaUrls;
    }

    public void setMediaUrls(String mediaUrls) {
        this.mediaUrls = mediaUrls;
    }
}
