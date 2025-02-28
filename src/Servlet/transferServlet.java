package Servlet;

import DTO.*;
import Service.CommentService;
import Service.FileService;
import Service.File_ClubService;
import Service.User_FileService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "transferServlet", urlPatterns = "/transferServlet")
public class transferServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1.从前端接收请求信息（fid）
        int fileId = Integer.parseInt(request.getParameter("fileId"));
        FileService fileService = new FileService();
        CommentService commentService = new CommentService();
        File_ClubService fileClubService = new File_ClubService();
        HttpSession session = request.getSession();

        // 2.收集信息
        // 得到当前用户的信息
        User user = (User) session.getAttribute("user");
        // 得到文件信息和文件所对应的用户信息
        File file = fileService.checkFile(fileId);
        // 根据文件id获得文件对应的评论列表（评论者的一系列信息）
        List<Comment> commentList = commentService.listCommentByFId(fileId);
        // 得到文件对应的俱乐部信息
        File_Club file_club = fileClubService.checkClubByFileId(fileId);
        // 3.传递参数
        request.setAttribute("user", user);
        request.setAttribute("file", file);
        request.setAttribute("commentList", commentList);
        request.setAttribute("file_club", file_club);

        // 4.转发至fileShow.jsp
        request.getRequestDispatcher("fileShow.jsp").forward(request, response);
    }
}
