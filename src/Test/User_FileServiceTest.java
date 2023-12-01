package Test;

import DTO.User_File;
import Service.User_FileService;
import org.junit.Test;

import static org.junit.Assert.*;

public class User_FileServiceTest {
    private User_FileService user_fileService = new User_FileService();
    
    @Test
    public void insertUser_File() {
        int i = user_fileService.insertUser_File(new User_File(7, 1));
        System.out.println(i);
    }
    
    @Test
    // 根据文件id和用户id查看已有关联信息
    public void checkUser_File() {
        User_File user_file = user_fileService.checkUser_File(7, 1);
        System.out.println(user_file);
    }
    
    @Test
    // 根据文件id和用户id删除已有关联信息
    public void deleteUser_File() {
        int i = user_fileService.deleteUser_File(7, 1);
        System.out.println(i);
    }
}