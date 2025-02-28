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
import java.io.PrintWriter;

@WebServlet(name = "user_clubOperationServlet", urlPatterns = "/user_clubOperationServlet")
public class user_clubOperationServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int clubId = Integer.parseInt(request.getParameter("clubId"));
        int operation = Integer.parseInt(request.getParameter("operation"));
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        int userId = user.getUserId();
        User_ClubService user_clubService = new User_ClubService();
        ClubService clubService = new ClubService();
        Club club = clubService.checkClub(clubId);
        String status = null;

        // 通过Operation的值判断是进行关联操作还是取消关联操作
        if (operation == 1) {
            // 进行用户和俱乐部关联操作
            user_clubService.insertUser_Club(new User_Club(userId, clubId));
            // 社团俱乐部人数加1
            club.setClubNumbers(club.getClubNumbers() + 1);
            operation = 0;
            status = "已加入";
        } else if (operation == 0) {
            // 进行用户和俱乐部关联操作
            user_clubService.deleteUser_Club(userId, clubId);
            // 社团俱乐部人数加1
            club.setClubNumbers(club.getClubNumbers() - 1);
            operation = 1;
            status = "加入";
        }
        clubService.updateClub(club);

        // 只能用\"不能用'来代替，必须是{"yy":xx}的形式
        String jsonStr = "{\"operation\":" + operation + ",\"status\":\"" + status + "\",\"clubNumbers\":" + club.getClubNumbers() + "}";
        // 3.响应ajax请求给出提示信息
        response.setContentType("application/json;charset=utf-8");
        response.setCharacterEncoding("utf-8");
        PrintWriter out = response.getWriter();
        out.println(jsonStr);
        out.flush();
        out.close();

        // 跳转到提示页面然后跳转至社团文件夹，并显示提示信息
        // String tips = b ? "<label style='color:green'>操作成功!</label>" : "<label style='color:red'>操作失败!</label>";
        // String type = "user_clubSave";
        // String address = "社团文件夹";
        // request.setAttribute("tips", tips);
        // request.setAttribute("type", type);
        // request.setAttribute("address", address);
        // request.getRequestDispatcher("prompt.jsp").forward(request, response);
    }
}
