package Servlet;

import DAO.CommentDAO;
import DTO.*;
import Service.*;
import com.fasterxml.jackson.databind.ObjectMapper;

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
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=UTF-8");

        int fileId = Integer.parseInt(request.getParameter("fileId"));
        FileService fileService = new FileService();
        CommentService commentService = new CommentService();
        File_ClubService fileClubService = new File_ClubService();
        InteractService interactService = new InteractService();
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        int userId = user != null ? user.getUserId() : -1;

        File file = fileService.checkFile(fileId);
        if (file != null) {
            String mediaUrlsJson = file.getMediaUrls();
            if (mediaUrlsJson != null && !mediaUrlsJson.isEmpty()) {
                ObjectMapper mapper = new ObjectMapper();
                List<String> mediaUrls = mapper.readValue(mediaUrlsJson, mapper.getTypeFactory().constructCollectionType(List.class, String.class));
                StringBuilder mediaHtml = new StringBuilder();
                for (String url : mediaUrls) {
                    mediaHtml.append("<img src=\"").append(url).append("\" style=\"max-width: 100%; height: auto;\" alt=\"图片\">");
                }
                request.setAttribute("mediaHtml", mediaHtml.toString());
            }
        }

        List<Comment> commentRootList = commentService.listCommentByFId(fileId);
        if (commentRootList != null && userId != -1) {
            for (Comment comment : commentRootList) {
                setCommentLikeStatus(comment, userId, interactService);
                if (comment.getChildComments() != null) {
                    for (Comment child : comment.getChildComments()) {
                        setCommentLikeStatus(child, userId, interactService);
                    }
                }
            }
        }

        if (userId != -1) {
            Interaction voteInteraction = interactService.checkInteraction(1, userId, fileId);
            if (voteInteraction == null) {
                interactService.insertInteraction(new Interaction(1, userId, fileId, 0));
                if (file != null) file.setVoteStatus(0);
            } else {
                if (file != null) file.setVoteStatus(voteInteraction.getStatus());
            }

            Interaction collectInteraction = interactService.checkInteraction(2, userId, fileId);
            if (collectInteraction == null) {
                interactService.insertInteraction(new Interaction(2, userId, fileId, 0));
                if (file != null) file.setCollectByUser(false);
            } else {
                if (file != null) file.setCollectByUser(collectInteraction.getStatus() == 1);
            }
        }

        File_Club file_club = fileClubService.checkClubByFileId(fileId);

        request.setAttribute("user", user);
        request.setAttribute("file", file);
        request.setAttribute("commentRootList", commentRootList);
        request.setAttribute("file_club", file_club);
        request.setAttribute("vote_status", (file != null && file.getVoteStatus() == 1) ? "upvote" : (file != null && file.getVoteStatus() == -1) ? "downvote" : "none");
        request.setAttribute("isCollectByUser", (file != null && file.isCollectByUser()) ? "collected" : "");

        request.getRequestDispatcher("fileShow.jsp").forward(request, response);
    }

    private void setCommentLikeStatus(Comment comment, int userId, InteractService interactService) {
        if (comment != null && userId != -1) {
            Interaction likedInteraction = interactService.checkInteraction(3, userId, comment.getCommentId());
            if (likedInteraction == null) {
                interactService.insertInteraction(new Interaction(3, userId, comment.getCommentId(), 0));
                comment.setLikedByUser(false);
            } else {
                comment.setLikedByUser(likedInteraction.getStatus() == 1);
            }
        }
    }
}