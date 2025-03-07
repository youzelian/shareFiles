package Test;


import DAO.InteractDAO;
import DTO.Interaction;
import org.junit.Test;

public class InteractDAOTest {
    private InteractDAO interactDAO = new InteractDAO();

    // 增加互动信息
    @Test
    public void insertInteraction() {
        int i = interactDAO.insertInteraction(new Interaction(2, 1, 1, 1));
        System.out.println(i);
    }

    // 更新互动信息
    @Test
    public void updateInteraction() {
        int i = interactDAO.updateInteraction(1, 1, 1, 1);
        System.out.println(i);
    }

    // 查询互动信息的状态
    @Test
    public void checkInteraction() {
        Interaction interaction = interactDAO.checkInteraction(1, 1, 1);
        System.out.println(interaction);
    }
}