package Test;

import DAO.User_ClubDAO;
import DTO.User_Club;
import org.junit.Test;

import java.util.List;

import static org.junit.Assert.*;

public class User_ClubDAOTest {
    private User_ClubDAO user_clubDAO = new User_ClubDAO();

    @Test
    public void insertUser_Club() {
        int i = user_clubDAO.insertUser_Club(new User_Club(1, 1));
        System.out.println(i);
    }

    @Test
    public void deleteUser_Club() {
        int i = user_clubDAO.deleteUser_Club(2, 1);
        System.out.println(i);
    }

    @Test
    public void checkUser_Club() {
        User_Club user_club = user_clubDAO.checkUser_Club(7, 1);
        System.out.println(user_club);
    }

    @Test
    public void listUser_Club() {
        List<User_Club> user_clubList = user_clubDAO.listUser_Club(1);
        System.out.println(user_clubList);
    }

    @Test
    public void selectUser_ClubCount() {
        Long count = user_clubDAO.selectUser_ClubCount(7);
        System.out.println(count);
    }
}