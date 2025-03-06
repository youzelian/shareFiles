package Servlet;

import Service.CommentService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "commentDeleteServlet", urlPatterns = "/commentDeleteServlet")
public class commentDeleteServlet extends HttpServlet {
    private CommentService commentService = new CommentService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 设置编码
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();

        // 获取参数
        int commentId = Integer.parseInt(request.getParameter("commentId"));
        int fId = Integer.parseInt(request.getParameter("fId"));

        // 删除评论
        boolean success = commentService.deleteComment(commentId);
        if (success) {
            out.println("{\"message\": \"删除成功\", \"fileId\": " + fId + "}");
        } else {
            out.println("{\"message\": \"删除失败\"}");
        }
        out.flush();
        out.close();
    }
}