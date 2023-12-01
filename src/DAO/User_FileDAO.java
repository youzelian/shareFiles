package DAO;

import DTO.File;
import DTO.User_File;
import org.apache.commons.dbutils.*;
import org.apache.commons.dbutils.handlers.BeanHandler;
import utils.DruidUtils;

import java.sql.SQLException;

public class User_FileDAO {
    BeanProcessor bean = new GenerousBeanProcessor();
    RowProcessor processor = new BasicRowProcessor(bean);
    
    // 增加文件与用户的关联信息
    public int insertUser_File(User_File user_file) {
        int i = 0;
        try {
            String sql = "insert into user_file(u_id,f_id) values(?,?)";
            QueryRunner queryRunner = new QueryRunner(DruidUtils.getDataSource());
            Object[] params = {user_file.getuId(), user_file.getfId()};
            i = queryRunner.update(sql, params);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return i;
    }
    
    // 根据文件id和用户id删除已有关联信息
    public int deleteUser_File(int uId, int fId) {
        int i = 0;
        try {
            String sql = "delete from user_file where u_id=? and f_id=?";
            QueryRunner queryRunner = new QueryRunner(DruidUtils.getDataSource());
            i = queryRunner.update(sql, uId, fId);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return i;
    }
    
    // 根据文件id和用户id查看已有关联信息
    public User_File checkUser_File(int uId, int fId) {
        User_File user_file = null;
        try {
            String sql = "select * from user_file where u_id=? and f_id=?";
            QueryRunner queryRunner = new QueryRunner(DruidUtils.getDataSource());
            user_file = queryRunner.query(sql, new BeanHandler<User_File>(User_File.class, processor), uId, fId);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user_file;
    }
}
