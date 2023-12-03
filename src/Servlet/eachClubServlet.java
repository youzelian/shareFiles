package Servlet;

import DTO.Club;
import DTO.File_Club;
import Service.ClubService;
import Service.File_ClubService;
import utils.pageHelper;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "eachClubServlet", urlPatterns = "/eachClubServlet")
public class eachClubServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int clubId = Integer.parseInt(request.getParameter("clubId"));
        ClubService clubService = new ClubService();
        Club club = clubService.checkClub(clubId);
        String clubName = club.getClubName();
        // 得到该俱乐部的所有文件
        File_ClubService file_clubService = new File_ClubService();
        
        // 1.接收客户端传递的页码(如果客户端没有传递页码，则默认页码为1，如果传递了则使用客户端传递的页码)
        String num = request.getParameter("pageNum");
        int pageNum = num == null ? 1 : Integer.parseInt(num);
        
        // 2.定义pageSize
        int pageSize = 10;
        
        // 3.调用File_Club查询文件信息并存储到List中
        pageHelper<File_Club> file_ClubPageHelper = file_clubService.listFile_ClubByPage(clubId, pageNum, pageSize);
        request.setAttribute("file_ClubPageHelper", file_ClubPageHelper);
        request.setAttribute("clubName", clubName);
        request.getRequestDispatcher("clubShow.jsp").forward(request, response);
    }
}
