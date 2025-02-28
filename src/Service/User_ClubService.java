package Service;

import DAO.User_ClubDAO;
import DTO.User_Club;

import java.util.List;

public class User_ClubService {
    private User_ClubDAO user_clubDAO = new User_ClubDAO();

    // 增加用户与俱乐部的关联信息
    public boolean insertUser_Club(User_Club user_club) {
        int i = user_clubDAO.insertUser_Club(user_club);
        return i > 0 ? true : false;
    }

    // 删除用户与俱乐部的关联信息
    public boolean deleteUser_Club(int uId, int cId) {
        int i = user_clubDAO.deleteUser_Club(uId, cId);
        return i > 0 ? true : false;
    }

    // 根据用户id和俱乐部id查看已有关联信息
    public User_Club checkUser_Club(int uId, int cId) {
        User_Club user_club = user_clubDAO.checkUser_Club(uId, cId);
        return user_club;
    }

    // 查询用户关注的俱乐部
    public List<User_Club> listUser_Club(int uId) {
        List<User_Club> user_clubList = user_clubDAO.listUser_Club(uId);
        return user_clubList;
    }

    // 查询用户关注俱乐部的总数
    public Long selectUser_ClubCount(int uId) {
        Long count = user_clubDAO.selectUser_ClubCount(uId);
        return count;
    }

    // 通过俱乐部名称模糊查询俱乐部
    public List<User_Club> fuzzyQueryClubByClubName(int uId, String fileName) {
        List<User_Club> user_clubList = user_clubDAO.fuzzyQueryClubByClubName(uId, fileName);
        return user_clubList;
    }
}
