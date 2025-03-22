package Test;

import DAO.UserDAO;
import DTO.User;
import org.junit.Test;
import utils.ConfigUtil;

import java.util.List;

public class UserDAOTest {
    private UserDAO userDAO = new UserDAO();

    @Test
    public void insertUser() {
        User user = new User("张三", "123");
        int i = userDAO.insertUser(user);
        System.out.println(i);
    }

    @Test
    public void updateUser() {
        User user = userDAO.queryUserByUserName("张三");
        user.setUserGender("男");
        int i = userDAO.updateUser(user);
        System.out.println(i);
    }

    @Test
    public void queryUserByUserName() {
        User user = userDAO.queryUserByUserName("张三");
        System.out.println(user);
    }

    @Test
    public void listUser() {
        List<User> userList = userDAO.listUser();
        System.out.println(userList);
    }

    @Test
    public void deleteUser() {
        final String API_KEY = ConfigUtil.getProperty("resend.api.key");
        System.out.println(API_KEY);
    }
}