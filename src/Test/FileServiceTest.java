package Test;

import DTO.File;
import Service.FileService;
import org.junit.Test;

import java.util.List;

import static org.junit.Assert.*;

public class FileServiceTest {
    private FileService fileService = new FileService();
    
    // 增加文件
    @Test
    public void saveFile() {
        boolean b = fileService.saveFile(new File("动漫图片", "图片", "xxx", 1, "动漫图片"));
        System.out.println(b);
    }
    
    // 根据文件id查询文件
    @Test
    public void checkFile() {
        File file = fileService.checkFile(1);
        System.out.println(file);
    }
    
    // 根据文件名模糊查询文件
    @Test
    public void fuzzyQueryFileByFileName() {
        List<File> fileList = fileService.fuzzyQueryFileByFileName("搞笑");
        System.out.println(fileList);
    }
    
    // 互动：点赞收藏下载
    @Test
    public void interact() {
        int i = fileService.interact(new File(1, 2, 1, 1));
        System.out.println(i);
    }
    
    // 查找所有文件信息
    @Test
    public void listFile() {
        List<File> fileList = fileService.listFile();
        System.out.println(fileList);
    }
}