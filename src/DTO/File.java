package DTO;

public class File {
    private int fileId;
    private String fileName;
    private String fileType;
    private String fileDownloadLink;
    private int fileVote;
    private int fileCollect;
    private int fileDownloadAmount;
    private String fileOfClub;
    private String fileIntroduction;
    
    public File() {
    }
    
    public File(String fileName, String fileType, String fileDownloadLink, String fileOfClub, String fileIntroduction) {
        this.fileName = fileName;
        this.fileType = fileType;
        this.fileDownloadLink = fileDownloadLink;
        this.fileOfClub = fileOfClub;
        this.fileIntroduction = fileIntroduction;
    }
    
    public int getFileId() {
        return fileId;
    }
    
    public void setFileId(int fileId) {
        this.fileId = fileId;
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
