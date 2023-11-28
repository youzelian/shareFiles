package Test;

import DTO.File;
import Service.FileService;
import org.junit.Test;

import static org.junit.Assert.*;

public class FileServiceTest {
    private FileService fileService = new FileService();
    
    @Test
    public void saveFile() {
        boolean b = fileService.saveFile(new File("动漫图片", "图片", "xxx", "1", "动漫图片"));
        System.out.println(b);
    }
}