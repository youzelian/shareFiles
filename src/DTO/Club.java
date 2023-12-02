package DTO;

public class Club {
    private int clubId;
    private String clubName;
    private String clubIntroduction;
    private int clubNumbers;
    
    public Club() {
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
}
