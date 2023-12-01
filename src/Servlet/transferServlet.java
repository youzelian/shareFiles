package Servlet;

import DTO.Comment;
import DTO.File;
import DTO.User;
import DTO.User_File;
import Service.CommentService;
import Service.FileService;
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
        // 得到文件信息
        File file = fileService.checkFile(fileId);
        CommentService commentService = new CommentService();
        // 根据文件id获得文件对应的评论列表（评论者的一系列信息）
        List<Comment> commentList = commentService.listCommentByFId(fileId);
        // 获得user_file，判断是否已经收藏过了
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        User_File user_file = new User_FileService().checkUser_File(user.getUserId(), fileId);
        // 2.传递参数file、commentList和imgAndPath
        request.setAttribute("file", file);
        request.setAttribute("commentList", commentList);
        request.setAttribute("user_file", user_file);
        // 3.转发至fileShow.jsp
        request.getRequestDispatcher("fileShow.jsp").forward(request, response);
    }
}
