package Test;

import DAO.FileDAO;
import DTO.File;
import org.junit.Test;

import static org.junit.Assert.*;

public class FileDAOTest {
    private FileDAO fileDAO = new FileDAO();
    
    @Test
    public void insertFile() {
        int i = fileDAO.insertFile(new File("动漫图片", "图片", "xxx", "1", "动漫图片"));
        System.out.println(i);
    }
}