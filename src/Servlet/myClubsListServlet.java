package Servlet;

import DTO.File_Club;
import DTO.User;
import DTO.User_Club;
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

@WebServlet(name = "myClubsListServlet", urlPatterns = "/myClubsListServlet")
public class myClubsListServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        File_ClubService file_clubService = new File_ClubService();
        // FileService fileService = new FileService();
        ArrayList<pageHelper<File_Club>> pages = new ArrayList<>();
        int userId = user.getUserId();
        
        // 1.先查询用户关注了哪些俱乐部,再列出这些俱乐部的文件
        User_ClubService user_clubService = new User_ClubService();
        List<User_Club> user_clubList = user_clubService.listUser_Club(userId);
        
        // 提取下列代码至file_clubSaveServlet,进行代码的优化
        // // 2.在列出所有俱乐部文件前，先对所有文件进行俱乐部关联
        // for (User_Club user_club : user_clubList) {
        //     int cId = user_club.getcId();
        //     List<File> fileList = fileService.listFile();
        //     // 对所有文件的fileOfClub的值与cId一致的文件进行文件与俱乐部关联
        //     for (File file : fileList) {
        //         // 关联前进行查询是否已经关联了
        //         File_Club file_club = file_clubService.checkFile_Club(file.getFileId(), cId);
        //         if (file.getFileOfClub() == cId && file_club == null) {
        //             file_clubService.insertFile_Club(new File_Club(file.getFileId(), cId));
        //         }
        //     }
        // }
        
        // 3.得到用户关注的所有俱乐部的所有文件
        for (User_Club user_club : user_clubList) {
            int cId = user_club.getcId();
            // 3.1.接收客户端传递的页码(如果客户端没有传递页码，则默认页码为1，如果传递了则使用客户端传递的页码)
            String num = request.getParameter("pageNum");
            int pageNum = num == null ? 1 : Integer.parseInt(num);
            
            // 3.2.定义pageSize
            int pageSize = 10;
            
            // 3.3.调用File_Club查询文件信息并存储到List中
            pageHelper<File_Club> file_ClubPageHelper = file_clubService.listFile_ClubByPage(cId, pageNum, pageSize);
            pages.add(file_ClubPageHelper);
        }
        // 4.转发到myClubs.jsp
        request.setAttribute("pages", pages);
        request.getRequestDispatcher("myClubs.jsp").forward(request, response);
    }
}
