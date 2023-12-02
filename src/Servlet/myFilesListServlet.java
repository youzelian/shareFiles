package Servlet;

import DTO.User;
import DTO.User_File;
import Service.User_FileService;
import utils.pageHelper;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "myFilesListServlet", urlPatterns = "/myFilesListServlet")
public class myFilesListServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //1.接收客户端传递的页码(如果客户端没有传递页码，则默认页码为1，如果传递了则使用客户端传递的页码)
        String num = request.getParameter("pageNum");
        int pageNum = num == null ? 1 : Integer.parseInt(num);
        
        // 2.定义pageSize
        int pageSize = 10;
        
        // 3.调用User_FileService查询用户收藏的文件信息
        User_FileService user_fileService = new User_FileService();
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        pageHelper<User_File> user_FilePageHelper = user_fileService.listUser_FileByPage(pageNum, pageSize, user.getUserId());
        
        // 4.将查询到的文件信息转发到myFiles.jsp
        request.setAttribute("user_FilePageHelper", user_FilePageHelper);
        request.getRequestDispatcher("myFiles.jsp").forward(request, response);
    }
}
