package DAO;

import DTO.File;
import DTO.File_Club;
import org.apache.commons.dbutils.*;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;
import utils.DruidUtils;

import java.sql.SQLException;
import java.util.List;

public class File_ClubDAO {
    BeanProcessor bean = new GenerousBeanProcessor();
    RowProcessor processor = new BasicRowProcessor(bean);

    // 增加文件与俱乐部的关联信息
    public int insertFile_Club(File_Club file_club) {
        int i = 0;
        try {
            String sql = "insert into file_club(f_id,c_id) values(?,?)";
            QueryRunner queryRunner = new QueryRunner(DruidUtils.getDataSource());
            Object[] params = {file_club.getfId(), file_club.getcId()};
            i = queryRunner.update(sql, params);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return i;
    }

    // 查询俱乐部所拥有的文件
    public List<File_Club> listFile_Club(int cId, int start, int limit) {
        List<File_Club> file_clubList = null;
        try {
            String sql = "select  * from file_club inner join files inner join clubs on file_club.f_id=files.file_id and file_club.c_id=clubs.club_id where file_club.c_id=? limit ?,?";
            QueryRunner queryRunner = new QueryRunner(DruidUtils.getDataSource());
            file_clubList = queryRunner.query(sql, new BeanListHandler<File_Club>(File_Club.class, processor), cId, start, limit);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return file_clubList;
    }

    // 根据文件id和俱乐部id查看已有关联信息
    public File_Club checkFile_Club(int fId, int cId) {
        File_Club file_club = null;
        try {
            String sql = "select * from file_club where f_id=? and c_id=?";
            QueryRunner queryRunner = new QueryRunner(DruidUtils.getDataSource());
            file_club = queryRunner.query(sql, new BeanHandler<File_Club>(File_Club.class, processor), fId, cId);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return file_club;
    }

    // 根据文件id查看已有关联信息
    public File_Club checkClubByFileId(int fId) {
        File_Club file_club = null;
        try {
            String sql = "select * from file_club inner join clubs on file_club.c_id=clubs.club_id where file_club.f_id=?";
            QueryRunner queryRunner = new QueryRunner(DruidUtils.getDataSource());
            file_club = queryRunner.query(sql, new BeanHandler<File_Club>(File_Club.class, processor), fId);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return file_club;
    }

    // 查询俱乐部拥有的的文件的总记录数
    public Long selectFile_ClubCount(int cId) {
        long count = 0;
        try {
            String sql = "select count(1) from file_club where c_id=?";
            QueryRunner queryRunner = new QueryRunner(DruidUtils.getDataSource());
            count = queryRunner.query(sql, new ScalarHandler<Long>(), cId);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

    // 根据文件名模糊查询文件
    public List<File_Club> fuzzyQueryFileByFileName(String fileName) {
        List<File_Club> file_clubList = null;
        try {
            String sql = "select * from user_file inner join files on user_file.f_id=files.file_id where file_name like ?";
            QueryRunner queryRunner = new QueryRunner(DruidUtils.getDataSource());
            file_clubList = queryRunner.query(sql, new BeanListHandler<File_Club>(File_Club.class, processor), "%" + fileName + "%");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return file_clubList;
    }
}
