package Test;

import DTO.User;
import Service.UserService;
import org.junit.Test;

import static org.junit.Assert.*;

public class UserServiceTest {
    private UserService userService = new UserService();
    
    @Test
    public void checkUser() {
        User user = userService.checkUser("yu");
        System.out.println(user);
    }
}