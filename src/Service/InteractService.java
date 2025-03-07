package Service;

import DAO.InteractDAO;
import DTO.Interaction;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.ScalarHandler;
import utils.DruidUtils;

import java.sql.SQLException;

public class InteractService {
    private InteractDAO interactDAO = new InteractDAO();

    // 增加互动
    public int insertInteraction(Interaction interaction) {
        int i = interactDAO.insertInteraction(interaction);
        return i;
    }

    // 更新互动信息
    public int updateInteraction(int type, int uId, int objectId, int status) {
        int i = interactDAO.updateInteraction(type, uId, objectId, status);
        return i;
    }

    // 查询互动信息的状态
    public Interaction checkInteraction(int type, int uId, int objectId) {
        Interaction interaction = interactDAO.checkInteraction(type, uId, objectId);
        return interaction;
    }
}
