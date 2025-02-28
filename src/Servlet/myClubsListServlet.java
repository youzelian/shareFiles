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
        request.setCharacterEncoding("utf-8");
        String searchContent = request.getParameter("searchContent");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        int userId = user.getUserId();
        User_ClubService userClubService = new User_ClubService();
        List<User_Club> user_clubList = userClubService.listUser_Club(userId);
        int operation = 0;
        if (searchContent != null) {
            // 如果是搜索传递，进行模糊搜索后将值替换pages中的list值，并通过传递fileList的个数更新pageCount(即总页数)
            List<User_Club> user_clubListSearch = userClubService.fuzzyQueryClubByClubName(userId, searchContent);
            user_clubList = user_clubListSearch;
        }
        request.setAttribute("user_clubList", user_clubList);
        request.setAttribute("operation", operation);
        request.getRequestDispatcher("myClubs.jsp").forward(request, response);
    }
}
