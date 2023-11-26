package Test;

import DTO.User;
import Service.UserService;
import org.junit.Test;

import java.util.List;

import static org.junit.Assert.*;

public class UserServiceTest {
    private UserService userService = new UserService();
    
    @Test
    public void checkUser() {
        User user = userService.checkUser("yu");
        System.out.println(user);
    }
    
    @Test
    public void userList() {
        List<User> userList = userService.listUser();
        System.out.println(userList);
    }
    
    @Test
    public void updateUser() {
        User user = userService.checkUser("张三");
        boolean b = userService.updateUser(user);
        System.out.println(b);
    }
}