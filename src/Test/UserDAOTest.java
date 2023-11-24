package Test;

import DAO.UserDAO;
import DTO.User;
import org.junit.Test;

public class UserDAOTest {
    private UserDAO userDAO = new UserDAO();
    
    @Test
    public void insertUser() {
        User user = new User("张三", "123");
        int i = userDAO.insertUser(user);
        System.out.println(i);
    }
    
    @Test
    public void queryUserByUserName() {
        User user = userDAO.queryUserByUserName("张三");
        System.out.println(user);
    }
}