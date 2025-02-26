package Servlet;

import DTO.Club;
import DTO.User;
import DTO.User_Club;
import Service.ClubService;
import Service.User_ClubService;

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
        // 1.接受请求
        request.setCharacterEncoding("utf-8");
        String clubName = request.getParameter("clubName");
        String clubIntroduction = request.getParameter("clubIntroduction");
        String clubMembership = request.getParameter("clubMembership");
        ClubService clubService = new ClubService();
        boolean b = false;
        Club club = clubService.selectRepeatedName(clubName);

        // 2.判断非空和非重复
        if (club == null && !clubName.equals("") && !clubIntroduction.equals("")) {
            Part clubImg = request.getPart("clubImg");
            // 2.1先进行重新赋名
            String clubImgName = clubImg.getSubmittedFileName();
            // 2.1.1获取后缀名 这里不统一改成.jpg或者.png是为了不让文件损坏
            String ext = clubImgName.substring(clubImgName.lastIndexOf("."));
            // 2.1.2使用随机数重新赋名
            clubImgName = UUID.randomUUID() + ext;
            // 2.2获取clubImg文件的路径
            String dir = getServletContext().getRealPath("clubImg");
            // 在Linux中和Windows中保存路径可以通过/或者\保存，为了方便取'/‘
            String savePath = dir + "/" + clubImgName;
            // 2.3保存文件
            clubImg.write(savePath);
            String clubImgPath;
            // 根据路径分隔符判断程序是否运行在Linux上则，如果不是则...
            if (dir.contains("/")) {
                // a. linux路径是用/隔开，正则表达式中'/'是用一个'/'表示
                clubImgPath = dir.substring(dir.lastIndexOf("/") + 1) + "/" + clubImgName;
            } else {
                // b. windows路径是用\隔开，正则表达式中'\'是用两个'\'表示
                clubImgPath = dir.substring(dir.lastIndexOf("\\") + 1) + "/" + clubImgName;
            }
            b = clubService.insertClub(new Club(clubName, clubIntroduction, clubImgPath, clubMembership));
        }

        // 3.用户创建俱乐部的同时加入俱乐部
        // 3.1查询到user和newClub的值
        Club newClub = clubService.selectRepeatedName(clubName);
        int clubId = newClub.getClubId();
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        User_ClubService user_clubService = new User_ClubService();
        // 3.2进行用户和俱乐部关联操作
        user_clubService.insertUser_Club(new User_Club(user.getUserId(), clubId));
        // 3.3社团俱乐部人数加1
        newClub.setClubNumbers(newClub.getClubNumbers() + 1);
        clubService.updateClub(newClub);

        // 4.跳转到提示页面然后跳转主页面，并显示提示信息
        String tips = b ? "<label style='color:green'>创建俱乐部成功!</label>" : "<label style='color:red'>创建俱乐部失败!</label>";
        String type = "clubSave";
        String address = "主页面";
        request.setAttribute("tips", tips);
        request.setAttribute("type", type);
        request.setAttribute("address", address);
        request.getRequestDispatcher("prompt.jsp").forward(request, response);
    }
}
