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
        int i = clubService.insertClub(new Club("搞笑图片，快乐源泉", "让快乐占据大脑"));
        System.out.println(i);
    }
    
    @Test
    public void listClub() {
        List<Club> clubList = clubService.listClub();
        System.out.println(clubList);
    }
}