package DAO;

import DTO.File_Club;
import DTO.User_Club;
import DTO.User_File;
import org.apache.commons.dbutils.*;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;
import utils.DruidUtils;

import java.sql.SQLException;
import java.util.List;

public class User_ClubDAO {
    BeanProcessor bean = new GenerousBeanProcessor();
    RowProcessor processor = new BasicRowProcessor(bean);

    // 增加用户与俱乐部的关联信息
    public int insertUser_Club(User_Club user_club) {
        int i = 0;
        try {
            String sql = "insert into user_club(u_id,c_id) values(?,?)";
            QueryRunner queryRunner = new QueryRunner(DruidUtils.getDataSource());
            Object[] params = {user_club.getuId(), user_club.getcId()};
            i = queryRunner.update(sql, params);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return i;
    }

    // 删除(后期加status变成隐藏)用户与俱乐部的关联信息
    public int deleteUser_Club(int uId, int cId) {
        int i = 0;
        try {
            String sql = "delete  from user_club where u_id=? and c_id=?;";
            QueryRunner queryRunner = new QueryRunner(DruidUtils.getDataSource());
            i = queryRunner.update(sql, uId, cId);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return i;
    }

    // 根据用户id和俱乐部id查看已有关联信息
    public User_Club checkUser_Club(int uId, int cId) {
        User_Club user_club = null;
        try {
            String sql = "select * from user_club where u_id=? and c_id=?";
            QueryRunner queryRunner = new QueryRunner(DruidUtils.getDataSource());
            user_club = queryRunner.query(sql, new BeanHandler<User_Club>(User_Club.class, processor), uId, cId);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user_club;
    }

    // 查询用户关注的俱乐部
    public List<User_Club> listUser_Club(int uId) {
        List<User_Club> user_clubList = null;
        try {
            String sql = "select  * from user_club inner join clubs on user_club.c_id=clubs.club_id where user_club.u_id=?";
            QueryRunner queryRunner = new QueryRunner(DruidUtils.getDataSource());
            user_clubList = queryRunner.query(sql, new BeanListHandler<User_Club>(User_Club.class, processor), uId);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user_clubList;
    }

    // 查询用户关注俱乐部的总数
    public Long selectUser_ClubCount(int uId) {
        long count = 0;
        try {
            String sql = "select count(1) from user_club where u_id=?";
            QueryRunner queryRunner = new QueryRunner(DruidUtils.getDataSource());
            count = queryRunner.query(sql, new ScalarHandler<Long>(), uId);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

    // 根据俱乐部名模糊查询俱乐部
    public List<User_Club> fuzzyQueryClubByClubName(int uid, String fileName) {
        List<User_Club> user_clubList = null;
        try {
            String sql = "select * from user_club inner join clubs on user_club.c_id=clubs.club_id where user_club.u_id=? and clubs.club_name like ?";
            QueryRunner queryRunner = new QueryRunner(DruidUtils.getDataSource());
            user_clubList = queryRunner.query(sql, new BeanListHandler<User_Club>(User_Club.class, processor), uid, "%" + fileName + "%");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user_clubList;
    }
}
