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
        int fileId = Integer.parseInt(request.getParameter("fileId"));
        FileService fileService = new FileService();
        CommentService commentService = new CommentService();
        File_ClubService fileClubService = new File_ClubService();
        HttpSession session = request.getSession();
        InteractService interactService = new InteractService();
        File_Club file_club = fileClubService.checkClubByFileId(fileId);
        User user = (User) session.getAttribute("user");
        int userId = user.getUserId();
        File file = fileService.checkFile(fileId);
        List<Comment> commentRootList = commentService.listCommentByFId(fileId);

        // 为根评论及其子评论设置点赞状态
        for (Comment comment : commentRootList) {
            setCommentLikeStatus(comment, userId, interactService);
            if (comment.getChildComments() != null) {
                for (Comment child : comment.getChildComments()) {
                    setCommentLikeStatus(child, userId, interactService);
                }
            }
        }

        Interaction voteInteraction = interactService.checkInteraction(1, userId, fileId);
        if (voteInteraction == null) {
            interactService.insertInteraction(new Interaction(1, userId, fileId, 0));
            file.setVoteStatus(0);
        } else {
            file.setVoteStatus(voteInteraction.getStatus());
        }
        Interaction collectInteraction = interactService.checkInteraction(2, userId, fileId);
        if (collectInteraction == null) {
            interactService.insertInteraction(new Interaction(2, userId, fileId, 0));
            file.setCollectByUser(false);
        } else {
            file.setCollectByUser(collectInteraction.getStatus() == 1);
        }

        request.setAttribute("user", user);
        request.setAttribute("file", file);
        request.setAttribute("commentRootList", commentRootList);
        request.setAttribute("file_club", file_club);
        request.setAttribute("vote_status", file.getVoteStatus() == 1 ? "upvote" : file.getVoteStatus() == -1 ? "downvote" : "none");
        request.setAttribute("isCollectByUser", file.isCollectByUser() ? "collected" : "");
        request.getRequestDispatcher("fileShow.jsp").forward(request, response);
    }

    private void setCommentLikeStatus(Comment comment, int userId, InteractService interactService) {
        Interaction likedInteraction = interactService.checkInteraction(3, userId, comment.getCommentId());
        if (likedInteraction == null) {
            interactService.insertInteraction(new Interaction(3, userId, comment.getCommentId(), 0));
            comment.setLikedByUser(false);
        } else {
            comment.setLikedByUser(likedInteraction.getStatus() == 1);
        }
    }
}
