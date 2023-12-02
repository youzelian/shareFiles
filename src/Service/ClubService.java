package Service;

import DAO.ClubDAO;
import DTO.Club;

import java.util.List;

public class ClubService {
    private ClubDAO clubDAO = new ClubDAO();
    
    // 增加俱乐部
    public int insertClub(Club club) {
        int i = clubDAO.insertClub(club);
        return i;
    }
    
    // 查询所有俱乐部
    public List<Club> listClub() {
        List<Club> clubList = clubDAO.listClub();
        return clubList;
    }
}
