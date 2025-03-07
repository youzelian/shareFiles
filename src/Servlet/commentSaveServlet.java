package Servlet;

import DTO.Comment;
import DTO.User;
import Service.CommentService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;

@WebServlet(name = "commentSaveServlet", urlPatterns = "/commentSaveServlet")
public class commentSaveServlet extends HttpServlet {
    private CommentService commentService = new CommentService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 设置编码
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();

        // 获取参数
        int fId = Integer.parseInt(request.getParameter("fId"));
        String commentContent = request.getParameter("commentContent");
        int parentId = request.getParameter("parentId") != null ? Integer.parseInt(request.getParameter("parentId")) : 0;
        int rootParentId = request.getParameter("rootParentId") != null ? Integer.parseInt(request.getParameter("rootParentId")) : 0;
        User user = (User) request.getSession().getAttribute("user");

        // 如果是回复一级评论，rootParentId 等于 parentId
        if (parentId != 0 && rootParentId == 0) {
            rootParentId = parentId;
        }

        // 保存评论
        boolean success = commentService.saveComment(new Comment(fId, user.getUserId(), commentContent, new Timestamp(System.currentTimeMillis()), parentId, rootParentId, user.getUserName(), user.getUserImgPath()));
        if (success) {
            out.println("{\"message\": \"发送成功\", \"fileId\": " + fId + "}");
        } else {
            out.println("{\"message\": \"发送失败\"}");
        }
        out.flush();
        out.close();
    }
}