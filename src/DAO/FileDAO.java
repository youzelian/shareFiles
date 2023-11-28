package DAO;

import DTO.File;
import org.apache.commons.dbutils.*;
import utils.DruidUtils;

import java.sql.SQLException;

public class FileDAO {
    BeanProcessor bean = new GenerousBeanProcessor();
    RowProcessor processor = new BasicRowProcessor(bean);
    
    // 增加文件信息
    public int insertFile(File file) {
        int i = 0;
        try {
            String sql = "insert into files(file_name,file_type,file_download_link,file_of_club,file_introduction) values(?,?,?,?,?)";
            QueryRunner queryRunner = new QueryRunner(DruidUtils.getDataSource());
            Object[] params = {file.getFileName(), file.getFileType(), file.getFileDownloadLink(), file.getFileOfClub(), file.getFileIntroduction()};
            i = queryRunner.update(sql, params);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return i;
    }
    // 查找所有文件信息
}
