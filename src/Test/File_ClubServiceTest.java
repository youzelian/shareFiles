package Test;

import DTO.File_Club;
import Service.File_ClubService;
import org.junit.Test;
import utils.pageHelper;

import static org.junit.Assert.*;

public class File_ClubServiceTest {
    private File_ClubService file_clubService = new File_ClubService();
    
    @Test
    public void insertFile_Club() {
        int i = file_clubService.insertFile_Club(new File_Club(3, 1));
        System.out.println(i);
    }
    
    @Test
    public void checkUser_Club() {
        File_Club file_club = file_clubService.checkFile_Club(4, 1);
        System.out.println(file_club);
    }
    
    @Test
    public void listFile_ClubByPage() {
        pageHelper<File_Club> file_ClubPageHelper = file_clubService.listFile_ClubByPage(1, 1, 3);
        System.out.println(file_ClubPageHelper.list);
    }
}