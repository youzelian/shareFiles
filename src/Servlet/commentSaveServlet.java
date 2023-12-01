package Servlet;

import DTO.Comment;
import DTO.User;
import Service.CommentService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "commentSaveServlet", urlPatterns = "/commentSaveServlet")
public class commentSaveServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1.从前端获取请求参数
        String commentContent = request.getParameter("commentContent");
        int fId = Integer.parseInt(request.getParameter("fId"));
        // 2.将评论内容存入comment表
        CommentService commentService = new CommentService();
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        boolean b = commentService.saveComment(new Comment(fId, user.getUserId(), commentContent));
        // 3.跳转至提示页面然后再跳转回fileShow页面
        String tips = b ? "<label style='color:green'>提交评论成功!</label>" : "<label style='color:red'>提交评论失败!</label>";
        String type = "commentSave";
        String address = "文件页面";
        request.setAttribute("tips", tips);
        request.setAttribute("type", type);
        request.setAttribute("address", address);
        // 因为传递的fId如果是int类型，接收时要包装成int类型,如果是其他页面跳转到提示页面，不会传递fId，但是会转换成int型，所以发生了空值转换int型，发生错误
        String fidString = String.valueOf(fId);
        request.setAttribute("fId", fidString);
        request.getRequestDispatcher("prompt.jsp").forward(request, response);
    }
}
