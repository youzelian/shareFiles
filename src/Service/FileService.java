package Service;

import DAO.FileDAO;
import DTO.File;

public class FileService {
    private FileDAO fileDAO = new FileDAO();
    
    // 增加文件
    public boolean saveFile(File file) {
        int i = fileDAO.insertFile(file);
        return i > 0 ? true : false;
    }
}
