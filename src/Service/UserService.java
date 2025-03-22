package Service;

import DAO.UserDAO;
import DTO.User;

import java.util.List;

public class UserService {
    private UserDAO userDAO = new UserDAO();

    // 增加用户信息
    public boolean saveUser(User user) {
        int i = userDAO.insertUser(user);
        return i > 0 ? true : false;
    }

    // 修改用户数据
    public boolean updateUser(User user) {
        int i = userDAO.updateUser(user);
        return i > 0 ? true : false;
    }

    // 修改用户密码
    public boolean modifyUserPwd(User user) {
        int i = userDAO.changeUserPwd(user);
        return i > 0 ? true : false;
    }

    // 根据姓名查找用户
    public User checkUser(String userName) {
        User user = userDAO.queryUserByUserName(userName);
        if (user == null) {
            return null;
        } else {
            return user;
        }
    }

    // 查询所有用户
    public List<User> listUser() {
        List<User> userList = userDAO.listUser();
        return userList;
    }

    // 根据邮箱查找用户
    public User checkEmail(String email) {
        User user = userDAO.checkEmail(email);
        return user;
    }
}
