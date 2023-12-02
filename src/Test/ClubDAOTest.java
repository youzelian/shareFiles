package Test;

import DAO.ClubDAO;
import DTO.Club;
import org.junit.Test;

import java.util.List;

import static org.junit.Assert.*;

public class ClubDAOTest {
    private ClubDAO clubDAO = new ClubDAO();
    
    @Test
    public void insertClub() {
        int i = clubDAO.insertClub(new Club("美食俱乐部", "民以食为天!"));
        System.out.println(i);
    }
    
    @Test
    public void listClub() {
        List<Club> clubList = clubDAO.listClub();
        System.out.println(clubList);
    }
}