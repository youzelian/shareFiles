package Service;

import DAO.ClubDAO;
import DTO.Club;
import DTO.User;

import java.util.List;

public class ClubService {
    private ClubDAO clubDAO = new ClubDAO();
    
    // 增加俱乐部
    public boolean insertClub(Club club) {
        int i = clubDAO.insertClub(club);
        return i > 0 ? true : false;
    }
    
    // 更新俱乐部信息
    public boolean updateClub(Club club) {
        int i = clubDAO.updateClub(club);
        return i > 0 ? true : false;
    }
    
    // 根据俱乐部Id查询俱乐部
    public Club checkClub(int clubId) {
        Club club = clubDAO.checkClub(clubId);
        return club;
    }
    
    // 根据俱乐部名查询俱乐部
    public Club selectRepeatedName(String clubName) {
        Club club = clubDAO.selectRepeatedName(clubName);
        return club;
    }
    
    // 查询所有俱乐部
    public List<Club> listClub() {
        List<Club> clubList = clubDAO.listClub();
        // 查询俱乐部所拥有的文件数
        for (Club club : clubList) {
            Long count = clubDAO.selectClubHasFilesCount(club.getClubId());
            club.setClubHasFiles(count);
        }
        return clubList;
    }
    
    // // 查询俱乐部所拥有的文件数
    // public Long selectClubHasFilesCount(int clubId) {
    //     Long count = clubDAO.selectClubHasFilesCount(clubId);
    //     return count;
    // }
}
