package DAO;

import DTO.Club;
import org.apache.commons.dbutils.*;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;
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
            String sql = "insert into clubs(club_name,club_introduction,club_img_path,club_membership) values(?,?,?,?)";
            QueryRunner queryRunner = new QueryRunner(DruidUtils.getDataSource());
            i = queryRunner.update(sql, club.getClubName(), club.getClubIntroduction(), club.getClubImgPath(), club.getClubMembership());
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return i;
    }

    // 更新俱乐部信息
    public int updateClub(Club club) {
        int i = 0;
        try {
            String sql = "update  clubs set club_numbers=? where club_id=?";
            QueryRunner queryRunner = new QueryRunner(DruidUtils.getDataSource());
            Object[] params = {club.getClubNumbers(), club.getClubId()};
            i = queryRunner.update(sql, params);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return i;
    }

    // 根据俱乐部Id查询俱乐部
    public Club checkClub(int clubId) {
        Club club = null;
        try {
            String sql = "select * from clubs where club_id=?";
            QueryRunner queryRunner = new QueryRunner(DruidUtils.getDataSource());
            club = queryRunner.query(sql, new BeanHandler<Club>(Club.class, processor), clubId);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return club;
    }

    // 根据俱乐部名查询俱乐部
    public Club selectRepeatedName(String clubName) {
        Club club = null;
        try {
            String sql = "select * from clubs where club_name=?";
            QueryRunner queryRunner = new QueryRunner(DruidUtils.getDataSource());
            club = queryRunner.query(sql, new BeanHandler<Club>(Club.class, processor), clubName);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return club;
    }

    // 查询所有俱乐部
    public List<Club> listClub() {
        List<Club> clubList = null;
        try {
            String sql = "select * from clubs ";
            QueryRunner queryRunner = new QueryRunner(DruidUtils.getDataSource());
            clubList = queryRunner.query(sql, new BeanListHandler<Club>(Club.class, processor));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return clubList;
    }

    // 查询俱乐部所拥有的文件数
    public Long selectClubHasFilesCount(int clubId) {
        long count = 0;
        try {
            String sql = "select count(1) from clubs inner join file_club on clubs.club_id=file_club.c_id where clubs.club_id=?";
            QueryRunner queryRunner = new QueryRunner(DruidUtils.getDataSource());
            count = queryRunner.query(sql, new ScalarHandler<Long>(), clubId);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

    // // 查询俱乐部所拥有的所有文件的所有点赞数
    // public Long selectAllVotes(int clubId) {
    //     long count = 0;
    //     try {
    //         String sql = "select sum(file_vote) from files where file_of_club=?";
    //         QueryRunner queryRunner = new QueryRunner(DruidUtils.getDataSource());
    //         count = queryRunner.query(sql, new ScalarHandler<Long>(), clubId);
    //     } catch (SQLException e) {
    //         e.printStackTrace();
    //     }
    //     return count;
    // }
}
