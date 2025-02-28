package DTO;

public class User_Club {
    private int ucId;
    private int uId;
    private int cId;
    private String clubImgPath;
    private String clubName;
    private int clubNumbers;
    private String clubMembership;

    public User_Club() {
    }

    public User_Club(int uId, int cId) {
        this.uId = uId;
        this.cId = cId;
    }

    public User_Club(int ucId, int uId, int cId, String clubImgPath, String clubName, int clubNumbers, String clubMembership) {
        this.ucId = ucId;
        this.uId = uId;
        this.cId = cId;
        this.clubImgPath = clubImgPath;
        this.clubName = clubName;
        this.clubNumbers = clubNumbers;
        this.clubMembership = clubMembership;
    }

    @Override
    public String toString() {
        return "User_Club{" +
                "ucId=" + ucId +
                ", uId=" + uId +
                ", cId=" + cId +
                ", clubImgPath='" + clubImgPath + '\'' +
                ", clubName='" + clubName + '\'' +
                ", clubNumbers=" + clubNumbers +
                ", clubMembership='" + clubMembership + '\'' +
                '}';
    }

    public int getUcId() {
        return ucId;
    }

    public void setUcId(int ucId) {
        this.ucId = ucId;
    }

    public int getuId() {
        return uId;
    }

    public void setuId(int uId) {
        this.uId = uId;
    }

    public int getcId() {
        return cId;
    }

    public void setcId(int cId) {
        this.cId = cId;
    }

    public String getClubImgPath() {
        return clubImgPath;
    }

    public void setClubImgPath(String clubImgPath) {
        this.clubImgPath = clubImgPath;
    }

    public String getClubName() {
        return clubName;
    }

    public void setClubName(String clubName) {
        this.clubName = clubName;
    }

    public int getClubNumbers() {
        return clubNumbers;
    }

    public void setClubNumbers(int clubNumbers) {
        this.clubNumbers = clubNumbers;
    }

    public String getClubMembership() {
        return clubMembership;
    }

    public void setClubMembership(String clubMembership) {
        this.clubMembership = clubMembership;
    }
}
