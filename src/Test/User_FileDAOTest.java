package Test;

import DAO.User_FileDAO;
import DTO.User_File;
import org.junit.Test;

import java.util.List;

import static org.junit.Assert.*;

public class User_FileDAOTest {
    private User_FileDAO user_fileDAO = new User_FileDAO();

    // 增加文件与用户的关联信息
    @Test
    public void insertUser_File() {
        int i = user_fileDAO.insertUser_File(new User_File(7, 1));
        System.out.println(i);
    }

    // 根据文件id和用户id删除已有关联信息
    @Test
    public void deleteUser_File() {
        int i = user_fileDAO.deleteUser_File(7, 1);
        System.out.println(i);
    }

    // 根据文件id和用户id查看已有关联信息
    @Test
    public void checkUser_File() {
        User_File user_file = user_fileDAO.checkUser_File(7, 1);
        System.out.println(user_file);
    }

    // 查询用户收藏的文件
    @Test
    public void listUser_File() {
        List<User_File> user_fileList = user_fileDAO.listUser_File(7, 0, 3);
        System.out.println(user_fileList);
    }

    // 查询用户收藏的文件的总记录数
    @Test
    public void selectUser_FileCount() {
        long count = user_fileDAO.selectUser_FileCount(7);
        System.out.println(count);
    }
}