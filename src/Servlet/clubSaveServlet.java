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
import java.util.List;

@WebServlet(name = "clubSaveServlet", urlPatterns = "/clubSaveServlet")
public class clubSaveServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String clubName = request.getParameter("clubName");
        String clubIntroduction = request.getParameter("clubIntroduction");
        // HttpSession session = request.getSession();
        // User user = (User) session.getAttribute("user");
        ClubService clubService = new ClubService();
        boolean b = false;
        Club club = clubService.selectRepeatedName(clubName);
        // 判断非空和非重复
        if (club == null && !clubName.equals("") && !clubIntroduction.equals("")) {
            b = clubService.insertClub(new Club(clubName, clubIntroduction));
        }
        // // 用户创建俱乐部的同时加入俱乐部
        // // 社团俱乐部人数加1
        // club.setClubNumbers(club.getClubNumbers() + 1);
        // User_ClubService user_clubService = new User_ClubService();
        // user_clubService.insertUser_Club(new User_Club(user.getUserId(), club.getClubId()));
        // 跳转到提示页面然后跳转主页面，并显示提示信息
        String tips = b ? "<label style='color:green'>创建俱乐部成功!</label>" : "<label style='color:red'>创建俱乐部失败!</label>";
        String type = "clubSave";
        String address = "主页面";
        request.setAttribute("tips", tips);
        request.setAttribute("type", type);
        request.setAttribute("address", address);
        request.getRequestDispatcher("prompt.jsp").forward(request, response);
    }
}
