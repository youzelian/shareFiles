package DAO;

import DTO.User;
import org.apache.commons.dbutils.*;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import utils.DruidUtils;

import java.sql.SQLException;
import java.util.List;

public class UserDAO {
    BeanProcessor bean = new GenerousBeanProcessor();
    RowProcessor processor = new BasicRowProcessor(bean);
    
    // 增加用户信息
    public int insertUser(User user) {
        int i = 0;
        try {
            String sql = "insert into users(user_name,user_pwd) values(?,?)";
            QueryRunner queryRunner = new QueryRunner(DruidUtils.getDataSource());
            i = queryRunner.update(sql, user.getUserName(), user.getUserPwd());
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return i;
    }
    
    // 删除用户信息
    // 修改用户信息
    // 根据用户名查找用户信息
    public User queryUserByUserName(String userName) {
        User user = new User();
        try {
            String sql = "select user_id,user_name,user_pwd,user_email,user_gender,user_tel,user_address,personal_signature,user_of_club from users where user_name=?";
            QueryRunner queryRunner = new QueryRunner(DruidUtils.getDataSource());
            user = queryRunner.query(sql, new BeanHandler<User>(User.class, processor), userName);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }
    
    // 查询所有用户信息
    public List<User> listUser() {
        List<User> userList = null;
        try {
            String sql = "select * from users";
            QueryRunner queryRunner = new QueryRunner(DruidUtils.getDataSource());
            userList = queryRunner.query(sql, new BeanListHandler<User>(User.class, processor));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return userList;
    }
}