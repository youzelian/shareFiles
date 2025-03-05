package Servlet;

import DTO.File;
import DTO.User;
import DTO.User_File;
import DTO.Comment;
import Service.FileService;
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
        String type = request.getParameter("type");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        response.setContentType("application/json;charset=utf-8");
        response.setCharacterEncoding("utf-8");
        PrintWriter out = response.getWriter();

        if (user == null) {
            out.println("{\"error\":\"User not logged in\"}");
            out.flush();
            out.close();
            return;
        }

        if (type == null || type.isEmpty()) {
            out.println("{\"error\":\"Invalid type\"}");
            out.flush();
            out.close();
            return;
        }

        // 处理文件相关交互
        if (type.startsWith("upvote") || type.startsWith("downvote") || type.equals("collect") || type.equals("download")) {
            int fid = Integer.parseInt(request.getParameter("fileId"));
            FileService fileService = new FileService();
            File file = fileService.checkFile(fid);
            User_FileService user_fileService = new User_FileService();
            boolean judge = true;

            if (type.equals("collect")) {
                User_File user_file = user_fileService.checkUser_File(user.getUserId(), fid);
                if (user_file == null) {
                    user_fileService.insertUser_File(new User_File(user.getUserId(), fid));
                } else {
                    user_fileService.deleteUser_File(user.getUserId(), fid);
                    judge = false;
                }
            }

            switch (type) {
                case "upvote":
                case "cancelDownvote":
                    file.setFileVote(file.getFileVote() + 1);
                    break;
                case "downvote":
                case "cancelUpvote":
                    file.setFileVote(file.getFileVote() - 1);
                    break;
                case "upvoteFromDownvote":
                    file.setFileVote(file.getFileVote() + 2);
                    break;
                case "downvoteFromUpvote":
                    file.setFileVote(file.getFileVote() - 2);
                    break;
                case "collect":
                    if (judge) {
                        file.setFileCollect(file.getFileCollect() + 1);
                    } else {
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
        // 处理评论点赞（支持点赞和取消）
        else if (type.equals("likeComment") || type.equals("unlikeComment")) {
            int commentId = Integer.parseInt(request.getParameter("commentId"));
            CommentService commentService = new CommentService();
            Comment comment = commentService.getCommentById(commentId);

            if (comment == null) {
                out.println("{\"error\":\"Comment not found\"}");
            } else {
                if (type.equals("likeComment")) {
                    comment.setCommentLiked(comment.getCommentLiked() + 1);
                } else if (type.equals("unlikeComment")) {
                    if (comment.getCommentLiked() > 0) { // 防止负数
                        comment.setCommentLiked(comment.getCommentLiked() - 1);
                    }
                }
                commentService.updateComment(comment);
                String jsonStr = "{\"commentLiked\":" + comment.getCommentLiked() + "}";
                out.println(jsonStr);
            }
        } else {
            out.println("{\"error\":\"Unsupported type\"}");
        }
        out.flush();
        out.close();
    }
}