package DTO;

public class File_Club {
    private int fcId;
    private int fId;
    private int cId;
    private String fileName;
    private String fileType;
    private String fileDownloadLink;
    private int fileVote;
    private int fileCollect;
    private int fileDownloadAmount;
    private int fileOfClub;
    private String fileIntroduction;
    private String clubName;
    
    public File_Club() {
    }
    
    public File_Club(int fId, int cId) {
        this.fId = fId;
        this.cId = cId;
    }
    
    @Override
    public String toString() {
        return "File_Club{" +
                "fcId=" + fcId +
                ", fId=" + fId +
                ", cId=" + cId +
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
    
    public int getFcId() {
        return fcId;
    }
    
    public void setFcId(int fcId) {
        this.fcId = fcId;
    }
    
    public int getfId() {
        return fId;
    }
    
    public void setfId(int fId) {
        this.fId = fId;
    }
    
    public int getcId() {
        return cId;
    }
    
    public void setcId(int cId) {
        this.cId = cId;
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
