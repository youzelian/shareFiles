package Test;

import DTO.User_File;
import Service.User_FileService;
import org.junit.Test;
import utils.pageHelper;

import java.util.List;

import static org.junit.Assert.*;

public class User_FileServiceTest {
    private User_FileService user_fileService = new User_FileService();

    // 增加文件与用户的关联信息
    @Test
    public void insertUser_File() {
        int i = user_fileService.insertUser_File(new User_File(7, 1));
        System.out.println(i);
    }

    // 根据文件id和用户id查看已有关联信息
    @Test
    public void checkUser_File() {
        User_File user_file = user_fileService.checkUser_File(1, 1);
        System.out.println(user_file);
    }

    // 根据文件id和用户id删除已有关联信息
    @Test
    public void deleteUser_File() {
        int i = user_fileService.deleteUser_File(7, 1);
        System.out.println(i);
    }

    // 分页查询用户收藏的文件
    @Test
    public void listUser_FileByPage() {
        pageHelper<User_File> user_FilePageHelper = user_fileService.listUser_FileByPage(1, 10, 7);
        System.out.println(user_FilePageHelper.list);
    }
}