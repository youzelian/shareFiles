package DAO;

import DTO.Club;
import DTO.File;
import org.apache.commons.dbutils.*;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;
import utils.DruidUtils;

import java.math.BigInteger;
import java.sql.SQLException;
import java.util.List;

public class FileDAO {
    BeanProcessor bean = new GenerousBeanProcessor();
    RowProcessor processor = new BasicRowProcessor(bean);

    // 增加文件信息并返回主键ID
    public int insertFile(File file) {
        int generatedId = 0;
        try {
            String sql = "insert into files(file_title,file_name,file_type,file_download_link,file_of_club,file_introduction,file_length,file_of_user) values(?,?,?,?,?,?,?,?)";
            QueryRunner queryRunner = new QueryRunner(DruidUtils.getDataSource());
            Object[] params = {file.getFileTitle(), file.getFileName(), file.getFileType(), file.getFileDownloadLink(), file.getFileOfClub(), file.getFileIntroduction(), file.getFileLength(), file.getFileOfUser()};
            // 使用 ScalarHandler<BigInteger> 获取主键
            BigInteger bigIntId = queryRunner.insert(sql, new ScalarHandler<BigInteger>(), params);
            generatedId = bigIntId.intValue(); // 转换为 int
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return generatedId;
    }

    // 删除指定 file_id 的文件记录
    public int deleteFile(int fileId) {
        int rowsAffected = 0;
        try {
            String sql = "delete from files where file_id=?";
            QueryRunner queryRunner = new QueryRunner(DruidUtils.getDataSource());
            rowsAffected = queryRunner.update(sql, fileId);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rowsAffected; // 返回受影响的行数，0 表示删除失败
    }

    // 更新俱乐部信息
    public int updateFile(File file) {
        int i = 0;
        try {
            String sql = "update  files set file_download_link=?,media_urls=? where file_id=?";
            QueryRunner queryRunner = new QueryRunner(DruidUtils.getDataSource());
            Object[] params = {file.getFileDownloadLink(), file.getMediaUrls(), file.getFileId()};
            i = queryRunner.update(sql, params);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return i;
    }

    // 根据文件id查询文件
    public File selectFileById(int fileId) {
        File file = null;
        try {
            String sql = "select * from files inner join users on files.file_of_user=users.user_id where file_id=?";
            QueryRunner queryRunner = new QueryRunner(DruidUtils.getDataSource());
            file = queryRunner.query(sql, new BeanHandler<File>(File.class, processor), fileId);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return file;
    }

    // 根据文件名模糊查询文件
    public List<File> fuzzyQueryFileByFileName(String fileName) {
        List<File> fileList = null;
        try {
            String sql = "select * from files where file_name like ?";
            QueryRunner queryRunner = new QueryRunner(DruidUtils.getDataSource());
            fileList = queryRunner.query(sql, new BeanListHandler<File>(File.class, processor), "%" + fileName + "%");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return fileList;
    }

    // 互动：点赞收藏下载
    public int interact(File file) {
        int i = 0;
        try {
            String sql = "update files set file_vote=?,file_collect=?,file_download_amount=? where file_id=?";
            QueryRunner queryRunner = new QueryRunner(DruidUtils.getDataSource());
            Object[] params = {file.getFileVote(), file.getFileCollect(), file.getFileDownloadAmount(), file.getFileId()};
            i = queryRunner.update(sql, params);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return i;
    }

    // 查找所有文件信息
    public List<File> listFile() {
        List<File> fileList = null;
        try {
            String sql = "select * from files";
            QueryRunner queryRunner = new QueryRunner(DruidUtils.getDataSource());
            fileList = queryRunner.query(sql, new BeanListHandler<File>(File.class, processor));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return fileList;
    }

    // 分页查询所有的文件（联合查询，clubs和files通过file_club联合）
    public List<File> listAllFilesByPage(int start, int limit) {
        List<File> fileAll = null;
        try {
            String sql = "select  * from file_club inner join files inner join clubs on file_club.f_id=files.file_id and file_club.c_id=clubs.club_id ORDER BY fc_id limit ?,?";
            QueryRunner queryRunner = new QueryRunner(DruidUtils.getDataSource());
            fileAll = queryRunner.query(sql, new BeanListHandler<File>(File.class, processor), start, limit);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return fileAll;
    }
}
