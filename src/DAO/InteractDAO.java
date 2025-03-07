package DAO;

import DTO.Club;
import DTO.Interaction;
import org.apache.commons.dbutils.*;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;
import utils.DruidUtils;

import java.sql.SQLException;

public class InteractDAO {
    BeanProcessor bean = new GenerousBeanProcessor();
    RowProcessor processor = new BasicRowProcessor(bean);

    // 增加互动
    public int insertInteraction(Interaction interaction) {
        int i = 0;
        try {
            String sql = "insert into interactions (type,u_id,object_id,status) values(?,?,?,?)";
            QueryRunner queryRunner = new QueryRunner(DruidUtils.getDataSource());
            i = queryRunner.update(sql, interaction.getType(), interaction.getuId(), interaction.getObjectId(), interaction.getStatus());
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return i;
    }

    // 更新互动信息
    public int updateInteraction(int type, int uId, int objectId, int status) {
        int i = 0;
        try {
            String sql = "update  interactions set status=? where u_id=? and object_id=? and type=?";
            QueryRunner queryRunner = new QueryRunner(DruidUtils.getDataSource());
            Object[] params = {status, uId, objectId, type};
            i = queryRunner.update(sql, params);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return i;
    }

    // 查询互动信息的状态
    public Interaction checkInteraction(int type, int uId, int objectId) {
        Interaction interaction = null;
        try {
            String sql = "select * from interactions where u_id=? and object_id=? and type=?";
            QueryRunner queryRunner = new QueryRunner(DruidUtils.getDataSource());
            interaction = queryRunner.query(sql, new BeanHandler<>(Interaction.class, processor), uId, objectId, type);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return interaction;
    }
}
