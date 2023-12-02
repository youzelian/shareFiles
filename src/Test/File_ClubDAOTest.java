package Test;

import DAO.File_ClubDAO;
import DTO.File_Club;
import org.junit.Test;

import java.util.List;

import static org.junit.Assert.*;

public class File_ClubDAOTest {
    private File_ClubDAO file_clubDAO = new File_ClubDAO();
    
    @Test
    public void insertFile_Club() {
        int i = file_clubDAO.insertFile_Club(new File_Club(4, 1));
        System.out.println(i);
    }
    
    @Test
    public void listFile_Club() {
        List<File_Club> file_clubList = file_clubDAO.listFile_Club(1, 0, 3);
        System.out.println(file_clubList);
    }
    
    @Test
    public void selectFile_ClubCount() {
        Long count = file_clubDAO.selectFile_ClubCount(1);
        System.out.println(count);
    }
}