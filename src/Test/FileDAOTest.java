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
        int i = fileDAO.insertFile(new File("动漫图片", "图片", "xxx", 1, "动漫图片", 1));
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