package Test;

import DTO.User_Club;
import Service.User_ClubService;
import org.junit.Test;

import java.util.List;

public class User_ClubServiceTest {
    private User_ClubService userClubService = new User_ClubService();

    @Test
    // 查询用户关注的俱乐部
    public void listUser_Club() {
        List<User_Club> user_clubList = userClubService.listUser_Club(1);
        System.out.println(user_clubList);
    }

    // 取消用户与俱乐部的关联
    @Test
    public void deleteUser_Club() {
        boolean b = userClubService.deleteUser_Club(1, 1);
        System.out.println(b);
    }

    // 模糊查询俱乐部
    @Test
    public void fuzzyQueryClubByClubName() {
        List<User_Club> user_clubList = userClubService.fuzzyQueryClubByClubName(1, "跑");
        System.out.printf("user_clubList:%s\n", user_clubList);
    }
}