package Service;

import DAO.FileDAO;
import DTO.File;
import org.apache.commons.dbutils.QueryRunner;
import utils.DruidUtils;

import java.sql.SQLException;
import java.util.List;

public class FileService {
    private FileDAO fileDAO = new FileDAO();
    
    // 增加文件
    public boolean saveFile(File file) {
        int i = fileDAO.insertFile(file);
        return i > 0 ? true : false;
    }
    
    // 根据文件id查询文件
    public File checkFile(int fileId) {
        File file = fileDAO.selectFileById(fileId);
        return file;
    }
    
    // 根据文件名模糊查询文件
    public List<File> fuzzyQueryFileByFileName(String fileName) {
        List<File> fileList = fileDAO.fuzzyQueryFileByFileName(fileName);
        return fileList;
    }
    
    // 互动：点赞收藏下载
    public int interact(File file) {
        int i = fileDAO.interact(file);
        return i;
    }
    
    // 查找所有文件信息
    public List<File> listFile() {
        List<File> fileList = fileDAO.listFile();
        return fileList;
    }
}
