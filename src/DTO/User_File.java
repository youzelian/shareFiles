package DTO;

public class User_File {
    private int ufId;
    private int uId;
    private int fId;
    
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
}
