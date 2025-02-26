package Service;

import DAO.User_FileDAO;
import DTO.User;
import DTO.User_File;
import utils.pageHelper;

import java.util.List;

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

    // 分页查询用户收藏的文件
    public pageHelper<User_File> listUser_FileByPage(int pageNum, int pageSize, int uId) {
        // 1.查询当前页面信息
        int start = (pageNum - 1) * pageSize;
        int limit = pageSize;
        List<User_File> user_fileList = user_fileDAO.listUser_File(uId, start, limit);
        // 2.查询并计算图书总页数
        // a.查询总记录数
        long count = user_fileDAO.selectUser_FileCount(uId);
        // b.根据总记录数和每页条数，计算总页数
        // long pageCount = count % pageSize == 0 ? count / pageSize : count / pageSize + 1;
        long pageCount = (count + pageSize - 1) / pageSize;
        if (pageCount == 0) {
            pageCount = 1;
        }
        // 3. 将分页数据都放在一个pageHelper对象中
        pageHelper<User_File> user_FilePageHelper = new pageHelper<User_File>(user_fileList, pageNum, (int) pageCount);
        return user_FilePageHelper;
    }
}
