package Service;

import DAO.File_ClubDAO;
import DTO.File_Club;
import DTO.User_File;
import utils.pageHelper;

import java.util.List;

public class File_ClubService {
    private File_ClubDAO file_clubDAO = new File_ClubDAO();

    // 增加文件与俱乐部的关联信息
    public int insertFile_Club(File_Club file_club) {
        int i = file_clubDAO.insertFile_Club(file_club);
        return i;
    }

    // 根据文件id和俱乐部id查看已有关联信息
    public File_Club checkFile_Club(int fId, int cId) {
        File_Club file_club = file_clubDAO.checkFile_Club(fId, cId);
        return file_club;
    }

    // 分页查询俱乐部所拥有的文件
    public pageHelper<File_Club> listFile_ClubByPage(int cId, int pageNum, int pageSize) {
        // 1.查询当前页面信息
        // 第一页 0~5 第二页 6~11
        int start = (pageNum - 1) * pageSize;
        int limit = pageSize;
        List<File_Club> file_clubList = file_clubDAO.listFile_Club(cId, start, limit);
        // 2.查询并计算文件总页数
        // a.查询总记录数
        Long count = file_clubDAO.selectFile_ClubCount(cId);
        // b.根据总记录数和每页条数，计算总页数
        long pageCount = count % pageSize == 0 ? count / pageSize : count / pageSize + 1;
        if (pageCount == 0) {
            pageCount = 1;
        }
        // 3. 将分页数据都放在一个pageHelper对象中
        pageHelper<File_Club> file_ClubPageHelper = new pageHelper<File_Club>(file_clubList, pageNum, (int) pageCount);
        return file_ClubPageHelper;
    }
}
