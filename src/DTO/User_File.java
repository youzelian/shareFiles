package DTO;

public class User_File {
    private int ufId;
    private int uId;
    private int fId;
    private String fileName;
    private String fileType;
    private String fileDownloadLink;
    private int fileVote;
    private int fileCollect;
    private int fileDownloadAmount;
    private String fileOfClub;
    private String fileIntroduction;
    
    public User_File() {
    }
    
    public User_File(int uId, int fId) {
        this.uId = uId;
        this.fId = fId;
    }
    
    @Override
    public String toString() {
        return "User_File{" +
                "ufId=" + ufId +
                ", uId=" + uId +
                ", fId=" + fId +
                ", fileName='" + fileName + '\'' +
                ", fileType='" + fileType + '\'' +
                ", fileDownloadLink='" + fileDownloadLink + '\'' +
                ", fileVote=" + fileVote +
                ", fileCollect=" + fileCollect +
                ", fileDownloadAmount=" + fileDownloadAmount +
                ", fileOfClub='" + fileOfClub + '\'' +
                ", fileIntroduction='" + fileIntroduction + '\'' +
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
    
    public String getFileOfClub() {
        return fileOfClub;
    }
    
    public void setFileOfClub(String fileOfClub) {
        this.fileOfClub = fileOfClub;
    }
    
    public String getFileIntroduction() {
        return fileIntroduction;
    }
    
    public void setFileIntroduction(String fileIntroduction) {
        this.fileIntroduction = fileIntroduction;
    }
}
