package Test;

import DTO.File;
import Service.FileService;
import org.junit.Test;
import utils.pageHelper;

import java.util.List;

public class FileServiceTest {
    private FileService fileService = new FileService();

    // 增加文件
    @Test
    public void saveFile() {
        boolean b = fileService.saveFile(new File("海贼王","海贼王团伙","海贼王一家","100.00 KB","图片","userImg/11.png",1,1));
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

    @Test
    public void listFileByPage() {
        pageHelper<File> fileAll = fileService.listAllFilesByPage(1, 5);
        System.out.println(fileAll.pageCount);
    }
}