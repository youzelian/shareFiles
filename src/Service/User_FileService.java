package Service;

import DAO.User_FileDAO;
import DTO.User_File;

public class User_FileService {
    private User_FileDAO user_fileDAO = new User_FileDAO();
    
    // 增加文件与用户的关联信息
    public int insertUser_File(User_File user_file) {
        int i = user_fileDAO.insertUser_File(user_file);
        return i;
    }
    
    // 根据文件id和用户id删除已有关联信息
    public int deleteUser_File(int uId, int fId) {
        int i = user_fileDAO.deleteUser_File(uId, fId);
        return i;
    }
    
    // 根据文件id和用户id查看已有关联信息
    public User_File checkUser_File(int uId, int fId) {
        User_File user_file = user_fileDAO.checkUser_File(uId, fId);
        return user_file;
    }
}
