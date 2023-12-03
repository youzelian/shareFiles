package Servlet;

import DTO.Club;
import DTO.File;
import DTO.File_Club;
import Service.ClubService;
import Service.FileService;
import Service.File_ClubService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "file_clubSaveServlet", urlPatterns = "/file_clubSaveServlet")
public class file_clubSaveServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 对所有的文件进行与俱乐部关联的操作
        FileService fileService = new FileService();
        List<File> fileList = fileService.listFile();
        ClubService clubService = new ClubService();
        List<Club> clubList = clubService.listClub();
        File_ClubService file_clubService = new File_ClubService();
        for (Club club : clubList) {
            for (File file : fileList) {
                // 关联前进行查询是否已经关联了
                File_Club file_club = file_clubService.checkFile_Club(file.getFileId(), club.getClubId());
                if (file.getFileOfClub() == club.getClubId() && file_club == null) {
                    file_clubService.insertFile_Club(new File_Club(file.getFileId(), club.getClubId()));
                }
            }
        }
        // 转发至index.jsp页面
        response.sendRedirect("index.jsp");
    }
}
