package DTO;

public class User_Club {
    private int ucId;
    private int uId;
    private int cId;
    
    public User_Club() {
    }
    
    public User_Club(int uId, int cId) {
        this.uId = uId;
        this.cId = cId;
    }
    
    @Override
    public String toString() {
        return "User_Club{" +
                "ucId=" + ucId +
                ", uId=" + uId +
                ", cId=" + cId +
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
}
