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
    public void checkClub() {
        Club club = clubDAO.checkClub(1);
        System.out.println(club);
    }
    
    @Test
    public void selectRepeatedName() {
        Club club = clubDAO.selectRepeatedName("穿衣搭配");
        System.out.println(club);
    }
    
    @Test
    public void listClub() {
        List<Club> clubList = clubDAO.listClub();
        System.out.println(clubList);
    }
    
    @Test
    public void selectClubHasFilesCount() {
        Long count = clubDAO.selectClubHasFilesCount(3);
        System.out.println(count);
    }
    
    // @Test
    // public void selectAllVotes() {
    //     Long count = clubDAO.selectAllVotes(1);
    //     System.out.println(count);
    // }
}