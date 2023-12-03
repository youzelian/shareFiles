package Servlet;

import DTO.*;
import Service.ClubService;
import Service.FileService;
import Service.File_ClubService;
import Service.User_ClubService;
import utils.pageHelper;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "communityListServlet", urlPatterns = "/communityListServlet")
public class communityListServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String searchContent = request.getParameter("searchContent");
        File_ClubService file_clubService = new File_ClubService();
        FileService fileService = new FileService();
        ClubService clubService = new ClubService();
        ArrayList<pageHelper<File_Club>> pages = new ArrayList<>();
        List<File> fileList = null;
        if (searchContent != null) {
            // 如果是搜索传递，进行模糊搜索符合要求的文件
            // fileList = fileService.fuzzyQueryFileByFileName(searchContent);
            fileList = fileService.fuzzyQueryFileByFileName("搞笑");
        }
        else {
            // 否则进行列出全部文件
            fileList = fileService.listFile();
        }
        List<Club> clubList = clubService.listClub();
        
        // 提取下列代码至file_clubSaveServlet,进行代码的优化
        // // 1.在列出所有俱乐部文件前，先对所有文件进行俱乐部关联
        // for (Club club : clubList) {
        //     for (File file : fileList) {
        //         // 关联前进行查询是否已经关联了
        //         File_Club file_club = file_clubService.checkFile_Club(file.getFileId(), club.getClubId());
        //         if (file.getFileOfClub() == club.getClubId() && file_club == null) {
        //             file_clubService.insertFile_Club(new File_Club(file.getFileId(), club.getClubId()));
        //         }
        //     }
        // }
        
        // 2.得到所有俱乐部的所有文件||得到模糊查询的文件
        for (Club club : clubList) {
            int clubId = club.getClubId();
            // 2.1.接收客户端传递的页码(如果客户端没有传递页码，则默认页码为1，如果传递了则使用客户端传递的页码)
            String num = request.getParameter("pageNum");
            int pageNum = num == null ? 1 : Integer.parseInt(num);
            
            // 2.2.定义pageSize
            int pageSize = 10;
            pageHelper<File_Club> file_ClubPageHelper = null;
            // 这个循环是为了模糊查询而写，如果是模糊查询，查询出来的fileList不是全部的，只查询clubId和模糊查询的文件的clubOfClub符合的file_ClubPageHelper;如果不是模糊查询，是全部文件，则下列判断都会符合，会查询出来所有文件
            for (File file : fileList) {
                if (file.getFileOfClub() == clubId) {
                    // 2.3.调用File_ClubService查询文件信息并存储到List中
                    file_ClubPageHelper = file_clubService.listFile_ClubByPage(clubId, pageNum, pageSize);
                }
            }
            pages.add(file_ClubPageHelper);
        }
        
        // 3.转发到communityFiles.jsp
        request.setAttribute("pages", pages);
        request.getRequestDispatcher("communityFiles.jsp").forward(request, response);
    }
}
