package Servlet;

import DTO.Club;
import DTO.User;
import DTO.User_Club;
import Service.ClubService;
import Service.User_ClubService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "user_clubSaveServlet", urlPatterns = "/user_clubSaveServlet")
public class user_clubSaveServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int clubId = Integer.parseInt(request.getParameter("clubId"));
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        User_ClubService user_clubService = new User_ClubService();
        ClubService clubService = new ClubService();
        Club club = clubService.checkClub(clubId);
        // 社团俱乐部人数加1
        club.setClubNumbers(club.getClubNumbers() + 1);
        // 进行用户和俱乐部关联操作
        boolean b = user_clubService.insertUser_Club(new User_Club(user.getUserId(), clubId));
        // 跳转到提示页面然后跳转至社团文件夹，并显示提示信息
        String tips = b ? "<label style='color:green'>加入成功!</label>" : "<label style='color:red'>加入失败!</label>";
        String type = "user_clubSave";
        String address = "社团文件夹";
        request.setAttribute("tips", tips);
        request.setAttribute("type", type);
        request.setAttribute("address", address);
        request.getRequestDispatcher("prompt.jsp").forward(request, response);
    }
}
