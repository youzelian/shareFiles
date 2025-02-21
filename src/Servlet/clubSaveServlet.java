package Servlet;

import DTO.Club;
import Service.ClubService;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.UUID;

@WebServlet(name = "clubSaveServlet", urlPatterns = "/clubSaveServlet")
@MultipartConfig
public class clubSaveServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String clubName = request.getParameter("clubName");
        String clubIntroduction = request.getParameter("clubIntroduction");
        String clubMembership = request.getParameter("clubMembership");

        // HttpSession session = request.getSession();
        // User user = (User) session.getAttribute("user");
        ClubService clubService = new ClubService();
        boolean b = false;
        Club club = clubService.selectRepeatedName(clubName);
        // 判断非空和非重复
        if (club == null && !clubName.equals("") && !clubIntroduction.equals("")) {
            Part clubImg = request.getPart("clubImg");
            // 1.先进行重新赋名
            String clubImgName = clubImg.getSubmittedFileName();
            // 1.1获取后缀名 这里不统一改成.jpg或者.png是为了不让文件损坏
            String ext = clubImgName.substring(clubImgName.lastIndexOf("."));
            // 1.2使用随机数重新赋名
            String clubImgPath = UUID.randomUUID() + ext;
            // 2.获取clubImg文件的路径
            String dir = getServletContext().getRealPath("clubImg");
            // a. windows路径是用\隔开，正则表达式中'\'是用两个'\'表示
            String savePath = dir + "\\" + clubImgPath;
            // b. linux路径是用/隔开，正则表达式中'/'是用一个'/'表示
            // String savePath = dir + "/" + clubImgPath;
            // 3.保存文件
            clubImg.write(savePath);
            b = clubService.insertClub(new Club(clubName, clubIntroduction, clubImgPath, clubMembership));
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
