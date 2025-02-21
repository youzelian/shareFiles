package DTO;

public class Club {
    private int clubId;
    private String clubName;
    private String clubIntroduction;
    private int clubNumbers;
    private Long clubHasFiles;
    private String clubImgPath;
    private String clubMembership;

    public Club() {
    }

    public Club(String clubName, String clubIntroduction, String clubImgPath, String clubMembership) {
        this.clubName = clubName;
        this.clubIntroduction = clubIntroduction;
        this.clubImgPath = clubImgPath;
        this.clubMembership = clubMembership;
    }

    public Club(String clubName, String clubIntroduction) {
        this.clubName = clubName;
        this.clubIntroduction = clubIntroduction;
    }

    @Override
    public String toString() {
        return "Club{" +
                "clubId=" + clubId +
                ", clubName='" + clubName + '\'' +
                ", clubIntroduction='" + clubIntroduction + '\'' +
                ", clubNumbers=" + clubNumbers +
                ", clubHasFiles=" + clubHasFiles +
                ", clubImgPath='" + clubImgPath + '\'' +
                ", clubMembership='" + clubMembership + '\'' +
                '}';
    }

    public int getClubId() {
        return clubId;
    }

    public void setClubId(int clubId) {
        this.clubId = clubId;
    }

    public String getClubName() {
        return clubName;
    }

    public void setClubName(String clubName) {
        this.clubName = clubName;
    }

    public String getClubIntroduction() {
        return clubIntroduction;
    }

    public void setClubIntroduction(String clubIntroduction) {
        this.clubIntroduction = clubIntroduction;
    }

    public int getClubNumbers() {
        return clubNumbers;
    }

    public void setClubNumbers(int clubNumbers) {
        this.clubNumbers = clubNumbers;
    }

    public Long getClubHasFiles() {
        return clubHasFiles;
    }

    public void setClubHasFiles(Long clubHasFiles) {
        this.clubHasFiles = clubHasFiles;
    }

    public String getClubImgPath() {
        return clubImgPath;
    }

    public void setClubImgPath(String clubImgPath) {
        this.clubImgPath = clubImgPath;
    }

    public String getClubMembership() {
        return clubMembership;
    }

    public void setClubMembership(String clubMembership) {
        this.clubMembership = clubMembership;
    }
}
