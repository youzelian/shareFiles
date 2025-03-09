package Test;

import DAO.FileDAO;
import DTO.File;
import org.junit.Test;

import java.util.List;

import static org.junit.Assert.*;

public class FileDAOTest {
    private FileDAO fileDAO = new FileDAO();

    @Test
    public void insertFile() {
        int i = fileDAO.insertFile(new File("动漫3.jpg", "海贼王团伙", "海贼王1.jpg", "12 KB", "图片", 1, 1));
        System.out.println(i);
    }

    @Test
    public void updateFile() {
        int i = fileDAO.updateFile(new File(5, "xx", "files/picture/5/5693e9bd-288c-4d08-88b4-86c5e93b6c30.jpg"));
        System.out.println(i);
    }

    @Test
    public void interact() {
        int i = fileDAO.interact(new File(1, 1, 1, 1));
        System.out.println(i);
    }

    @Test
    public void fuzzyQueryFileByFileName() {
        List<File> fileList = fileDAO.fuzzyQueryFileByFileName("笑");
        System.out.println(fileList);
    }

    @Test
    public void fuzzyQueryFileByFileId() {
        List<File> fileList = fileDAO.listAllFilesByPage(0, 5);
        System.out.println(fileList);
    }
}