package Servlet;

import DAO.CommentDAO;
import DTO.*;
import Service.*;

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
        InteractService interactService = new InteractService();
        CommentDAO commentDAO = new CommentDAO();

        // 2.收集信息
        // 得到当前用户的信息
        User user = (User) session.getAttribute("user");
        int userId = user.getUserId();
        // 得到文件信息和文件所对应的用户信息
        File file = fileService.checkFile(fileId);
        List<Comment> comments = commentDAO.listCommentByFId(fileId);
        // 对所有评论进行互动状态查询
        for (Comment comment : comments) {
            int commentId = comment.getCommentId();
            // 如果没有评论点赞交互信息则设置为isLikedByUser为假
            Interaction likedInteraction = interactService.checkInteraction(3, userId, commentId);
            if (likedInteraction == null) {
                interactService.insertInteraction(new Interaction(3, userId, commentId, 0));
                comment.setLikedByUser(false);
            } else {
                comment.setLikedByUser(likedInteraction.getStatus() == 1);
            }
        }
        // 根据文件id获得文件对应的Root根评论列表（和评论者的一系列信息）
        List<Comment> commentRootList = commentService.listCommentByFId(fileId);
        // 得到文件对应的俱乐部信息
        File_Club file_club = fileClubService.checkClubByFileId(fileId);
        // 如果vote交互信息没有则设置为VoteStatus为0  -1=点踩，0=无，1=点赞
        Interaction voteInteraction = interactService.checkInteraction(1, userId, fileId);
        if (voteInteraction == null) {
            interactService.insertInteraction(new Interaction(1, userId, fileId, 0));
            file.setVoteStatus(0);
        } else {
            // 如果有交互信息则将交互信息的status赋给VoteStatus
            file.setVoteStatus(voteInteraction.getStatus());
        }
        // 如果collect交互信息没有则设置为isCollectByUser为假
        Interaction collectInteraction = interactService.checkInteraction(2, userId, fileId);
        if (collectInteraction == null) {
            interactService.insertInteraction(new Interaction(2, userId, fileId, 0));
            file.setCollectByUser(false);
        } else {
            file.setCollectByUser(collectInteraction.getStatus() == 1);
        }

        // 3.传递参数
        request.setAttribute("user", user);
        request.setAttribute("file", file);
        request.setAttribute("commentRootList", commentRootList);
        request.setAttribute("file_club", file_club);
        // 传递 voteStatus 和 isCollectByUser 给前端
        request.setAttribute("vote_status", file.getVoteStatus() == 1 ? "upvote" : file.getVoteStatus() == -1 ? "downvote" : "none");
        request.setAttribute("isCollectByUser", file.isCollectByUser() ? "collected" : "");

        // 4.转发至fileShow.jsp
        request.getRequestDispatcher("fileShow.jsp").forward(request, response);
    }
}
