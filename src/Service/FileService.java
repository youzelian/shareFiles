package Service;

import DAO.FileDAO;
import DTO.File;
import DTO.File_Club;
import org.apache.commons.dbutils.QueryRunner;
import utils.DruidUtils;
import utils.pageHelper;

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

    // 分页查找所有文件信息
    public pageHelper<File> listAllFilesByPage(int pageNum, int pageSize) {
        // 和File_ClubService的listFile_ClubByPage操作相同，后期可优化简化，创造接口
        // 1.查询所有文件的信息
        int start = (pageNum - 1) * pageSize;
        int limit = pageSize;
        // 第一页是0 5 第二页是5 5 第三页是10 5
        List<File> fileAll = fileDAO.listAllFilesByPage(start, limit);
        // 2.算出所有文件对应的总页数
        long count = fileDAO.listFile().size();
        // long pageCount = count % pageSize == 0 ? count / pageSize : count / pageSize + 1;
        long pageCount = (count + pageSize + 1) / pageSize;
        if (pageCount == 0) {
            pageCount = 1;
        }
        // 3.将所有数据放入pageHelper对象中
        pageHelper<File> filePageHelper = new pageHelper<File>(fileAll, pageNum, (int) pageCount);
        return filePageHelper;
    }
}
