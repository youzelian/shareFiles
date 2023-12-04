package Test;

import DTO.Club;
import Service.ClubService;
import org.junit.Test;

import java.util.List;

import static org.junit.Assert.*;

public class ClubServiceTest {
    private ClubService clubService = new ClubService();
    
    @Test
    public void insertClub() {
        boolean i = clubService.insertClub(new Club("搞笑图片，快乐源泉", "让快乐占据大脑"));
        System.out.println(i);
    }
    
    @Test
    public void checkClub() {
        Club club = clubService.checkClub(1);
        System.out.println(club);
    }
    
    @Test
    public void selectRepeatedName() {
        Club club = clubService.selectRepeatedName("穿衣搭配");
        System.out.println(club);
    }
    
    @Test
    public void listClub() {
        List<Club> clubList = clubService.listClub();
        System.out.println(clubList);
    }
    
    // @Test
    // public void selectClubHasFilesCount() {
    //     Long count = clubService.selectClubHasFilesCount(3);
    //     System.out.println(count);
    // }
}