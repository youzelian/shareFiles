package Servlet;

import DTO.*;
import Service.FileService;
import Service.InteractService;
import Service.User_FileService;
import Service.CommentService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "interactServlet", urlPatterns = "/interactServlet")
public class interactServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1.接受请求并初始化
        response.setContentType("application/json;charset=utf-8");
        response.setCharacterEncoding("utf-8");
        String type = request.getParameter("type");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        int userId = user.getUserId();
        PrintWriter out = response.getWriter();
        InteractService interactService = new InteractService();
        User_FileService user_fileService = new User_FileService();

        // 2.处理文件相关交互
        if (type.startsWith("upvote") || type.startsWith("downvote") || type.equals("collect") || type.equals("download") || type.startsWith("cancelUpvote") || type.startsWith("cancelDownvote") || type.startsWith("upvoteFromDownvote") || type.startsWith("downvoteFromUpvote")) {
            int fid = Integer.parseInt(request.getParameter("fileId"));
            FileService fileService = new FileService();
            File file = fileService.checkFile(fid);
            boolean judge = true;
            if (type.equals("collect")) {
                User_File user_file = user_fileService.checkUser_File(userId, fid);
                if (user_file == null) {
                    user_fileService.insertUser_File(new User_File(userId, fid));
                } else {
                    user_fileService.deleteUser_File(userId, fid);
                    judge = false;
                }
            }

            switch (type) {
                case "upvote":
                    interactService.updateInteraction(1, userId, fid, 1);
                    file.setFileVote(file.getFileVote() + 1);
                    break;
                case "cancelDownvote":
                    interactService.updateInteraction(1, userId, fid, 0);
                    file.setFileVote(file.getFileVote() + 1);
                    break;
                case "downvote":
                    interactService.updateInteraction(1, userId, fid, -1);
                    file.setFileVote(file.getFileVote() - 1);
                    break;
                case "cancelUpvote":
                    interactService.updateInteraction(1, userId, fid, 0);
                    file.setFileVote(file.getFileVote() - 1);
                    break;
                case "upvoteFromDownvote":
                    interactService.updateInteraction(1, userId, fid, 1);
                    file.setFileVote(file.getFileVote() + 2);
                    break;
                case "downvoteFromUpvote":
                    interactService.updateInteraction(1, userId, fid, -1);
                    file.setFileVote(file.getFileVote() - 2);
                    break;
                case "collect":
                    if (judge) {
                        interactService.updateInteraction(2, userId, fid, 1);
                        file.setFileCollect(file.getFileCollect() + 1);
                    } else {
                        interactService.updateInteraction(2, userId, fid, 0);
                        file.setFileCollect(file.getFileCollect() - 1);
                    }
                    break;
                case "download":
                    file.setFileDownloadAmount(file.getFileDownloadAmount() + 1);
                    break;
            }

            fileService.interact(file);
            String jsonStr = "{\"fileVote\":" + file.getFileVote() + ",\"fileCollect\":" + file.getFileCollect() + ",\"fileDownloadAmount\":" + file.getFileDownloadAmount() + "}";
            out.println(jsonStr);
        }

        // 3.处理评论点赞（支持点赞和取消）
        else if (type.equals("likeComment") || type.equals("cancelLikeComment")) {
            int commentId = Integer.parseInt(request.getParameter("commentId"));
            CommentService commentService = new CommentService();
            Comment comment = commentService.getCommentById(commentId);
            int newStatus;
            int commentLikedNum;

            if (type.equals("likeComment")) {
                newStatus = 1;
                commentLikedNum = comment.getCommentLikedNum() + 1;
            } else {
                newStatus = 0;
                commentLikedNum = comment.getCommentLikedNum() - 1;
            }
            interactService.updateInteraction(3, userId, commentId, newStatus);
            comment.setCommentLikedNum(commentLikedNum);
            commentService.updateComment(comment);
            String jsonStr = "{\"commentLikedNum\":" + commentLikedNum + "}";
            out.println(jsonStr);
        } else {
            out.println("{\"error\":\"Unsupported type\"}");
        }
        out.flush();
        out.close();
    }
}