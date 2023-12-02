package DAO;

import DTO.Club;
import org.apache.commons.dbutils.*;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import utils.DruidUtils;

import java.sql.SQLException;
import java.util.List;

public class ClubDAO {
    BeanProcessor bean = new GenerousBeanProcessor();
    RowProcessor processor = new BasicRowProcessor(bean);
    
    // 增加俱乐部
    public int insertClub(Club club) {
        int i = 0;
        try {
            String sql = "insert into clubs(club_name,club_introduction) values(?,?)";
            QueryRunner queryRunner = new QueryRunner(DruidUtils.getDataSource());
            i = queryRunner.update(sql, club.getClubName(), club.getClubIntroduction());
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return i;
    }
    
    // 查询所有俱乐部
    public List<Club> listClub() {
        List<Club> clubList = null;
        try {
            String sql = "select * from clubs";
            QueryRunner queryRunner = new QueryRunner(DruidUtils.getDataSource());
            clubList = queryRunner.query(sql, new BeanListHandler<Club>(Club.class, processor));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return clubList;
    }
}
