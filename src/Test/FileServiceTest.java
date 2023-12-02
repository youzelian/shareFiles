package Test;

import DTO.File;
import Service.FileService;
import org.junit.Test;

import java.util.List;

import static org.junit.Assert.*;

public class FileServiceTest {
    private FileService fileService = new FileService();
    
    @Test
    public void saveFile() {
        boolean b = fileService.saveFile(new File("动漫图片", "图片", "xxx", 1, "动漫图片"));
        System.out.println(b);
    }
    
    @Test
    public void checkFile() {
        File file = fileService.checkFile(1);
        System.out.println(file);
    }
    
    @Test
    public void interact() {
        int i = fileService.interact(new File(1, 2, 1, 1));
        System.out.println(i);
    }
    
    @Test
    public void listFile() {
        List<File> fileList = fileService.listFile();
        System.out.println(fileList);
    }
}