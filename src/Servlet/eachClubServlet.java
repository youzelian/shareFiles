package Servlet;

import DTO.Club;
import DTO.File_Club;
import DTO.User;
import DTO.User_Club;
import Service.ClubService;
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
import java.util.List;

@WebServlet(name = "eachClubServlet", urlPatterns = "/eachClubServlet")
public class eachClubServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        int clubId = Integer.parseInt(request.getParameter("clubId"));
        int type = Integer.parseInt(request.getParameter("type"));
        String searchContent = request.getParameter("searchContent");
        ClubService clubService = new ClubService();
        // 得到该俱乐部的所有文件
        File_ClubService file_clubService = new File_ClubService();
        // 得到该俱乐部的信息
        Club club = clubService.checkClub(clubId);
        // 得到用户与俱乐部的关联信息
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        User_ClubService userClubService = new User_ClubService();
        User_Club userClub = userClubService.checkUser_Club(user.getUserId(), clubId);

        // 判断是否已经关联，传递操作信号
        int operation;
        if (userClub == null) {
            operation = 1;
        } else {
            operation = 0;
        }

        // 1.接收客户端传递的页码(如果客户端没有传递页码，则默认页码为1，如果传递了则使用客户端传递的页码)
        String num = request.getParameter("pageNum");
        int pageNum = num == null ? 1 : Integer.parseInt(num);

        // 2.定义pageSize
        int pageSize = 5;

        // 3.调用File_Club查询文件信息并存储到List中
        pageHelper<File_Club> file_ClubPageHelper = file_clubService.listFile_ClubByPage(clubId, pageNum, pageSize);
        // 进行搜索判断
        if (searchContent != null) {
            // 如果是搜索传递，进行模糊搜索后将值替换pages中的list值，并通过传递fileList的个数更新pageCount(即总页数)
            List<File_Club> file_clubList = file_clubService.fuzzyQueryFileByFileName(searchContent);
            file_ClubPageHelper.setList(file_clubList);
            int pageCount = (file_clubList.size() + pageSize - 1) / pageSize;
            if (pageCount == 0) {
                pageCount = 1;
            }
            file_ClubPageHelper.setPageCount(pageCount);
        }
        request.setAttribute("type", type);
        request.setAttribute("file_ClubPageHelper", file_ClubPageHelper);
        request.setAttribute("club", club);
        request.setAttribute("operation", operation);
        request.getRequestDispatcher("clubShow.jsp").forward(request, response);
    }
}
