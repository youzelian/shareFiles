package Test;

import DAO.User_FileDAO;
import DTO.User_File;
import org.junit.Test;

import static org.junit.Assert.*;

public class User_FileDAOTest {
    private User_FileDAO user_fileDAO = new User_FileDAO();
    
    @Test
    public void insertUser_File() {
        int i = user_fileDAO.insertUser_File(new User_File(7, 1));
        System.out.println(i);
    }
    
    @Test
    public void checkUser_File() {
        User_File user_file = user_fileDAO.checkUser_File(7, 1);
        System.out.println(user_file);
    }
    
    @Test
    public void deleteUser_File() {
        int i = user_fileDAO.deleteUser_File(7, 1);
        System.out.println(i);
    }
}