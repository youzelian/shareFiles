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

/**
 * Servlet 实现类 transferServlet
 * 处理文件详情和评论的显示请求
 */
@WebServlet(name = "transferServlet", urlPatterns = "/transferServlet")
public class transferServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * 处理 HTTP GET 请求
     * 将请求委托给 doPost 方法以保持一致性
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response); // 委托给 doPost 处理
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 设置字符编码为 UTF-8 以支持中文
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=UTF-8");

        // 从请求参数中提取 fileId
        int fileId = Integer.parseInt(request.getParameter("fileId"));

        // 初始化服务对象
        FileService fileService = new FileService();
        CommentService commentService = new CommentService();
        File_ClubService fileClubService = new File_ClubService();
        InteractService interactService = new InteractService();

        // 获取会话和用户信息
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        int userId = user.getUserId();

        // 从数据库获取文件详情
        File file = fileService.checkFile(fileId);

        // 解析 fileIntroduction 中的 [img] 标签为 <img> 标签
        if (file != null) {
            String fileIntroduction = file.getFileIntroduction();
            if (fileIntroduction != null) {
                fileIntroduction = fileIntroduction.replaceAll("\\[img](.*?)\\[/img]",
                        "<img src=\"$1\" style=\"max-width: 100%; height: auto;\" alt=\"图片\">");
                file.setFileIntroduction(fileIntroduction); // 更新文件对象中的描述
            }
        }

        // 获取该文件的评论列表
        List<Comment> commentRootList = commentService.listCommentByFId(fileId);

        // 为评论及其子评论设置点赞状态
        if (commentRootList != null) {
            for (Comment comment : commentRootList) {
                setCommentLikeStatus(comment, userId, interactService); // 设置根评论的点赞状态
                if (comment.getChildComments() != null) {
                    for (Comment child : comment.getChildComments()) {
                        setCommentLikeStatus(child, userId, interactService); // 设置子评论的点赞状态
                    }
                }
            }
        }

        // 处理投票交互
        Interaction voteInteraction = interactService.checkInteraction(1, userId, fileId);
        if (voteInteraction == null) {
            interactService.insertInteraction(new Interaction(1, userId, fileId, 0)); // 初始化投票状态
            if (file != null) file.setVoteStatus(0); // 默认未投票
        } else {
            if (file != null) file.setVoteStatus(voteInteraction.getStatus()); // 设置投票状态
        }

        // 处理收藏交互
        Interaction collectInteraction = interactService.checkInteraction(2, userId, fileId);
        if (collectInteraction == null) {
            interactService.insertInteraction(new Interaction(2, userId, fileId, 0)); // 初始化收藏状态
            if (file != null) file.setCollectByUser(false); // 默认未收藏
        } else {
            if (file != null) file.setCollectByUser(collectInteraction.getStatus() == 1); // 设置收藏状态
        }

        // 获取文件关联的俱乐部信息
        File_Club file_club = fileClubService.checkClubByFileId(fileId);

        // 将数据设置为请求属性，以便 JSP 页面使用
        request.setAttribute("user", user);
        request.setAttribute("file", file);
        request.setAttribute("commentRootList", commentRootList);
        request.setAttribute("file_club", file_club);
        request.setAttribute("vote_status", (file != null && file.getVoteStatus() == 1) ? "upvote"
                : (file != null && file.getVoteStatus() == -1) ? "downvote" : "none"); // 设置投票状态
        request.setAttribute("isCollectByUser", (file != null && file.isCollectByUser()) ? "collected" : ""); // 设置收藏状态

        // 转发请求到 fileShow.jsp
        request.getRequestDispatcher("fileShow.jsp").forward(request, response);
    }

    /**
     * 根据用户交互设置评论的点赞状态
     *
     * @param comment         评论对象
     * @param userId          用户 ID
     * @param interactService 交互服务
     */
    private void setCommentLikeStatus(Comment comment, int userId, InteractService interactService) {
        if (comment != null && userId != -1) { // 确保评论和用户存在
            Interaction likedInteraction = interactService.checkInteraction(3, userId, comment.getCommentId());
            if (likedInteraction == null) {
                interactService.insertInteraction(new Interaction(3, userId, comment.getCommentId(), 0)); // 初始化点赞状态
                comment.setLikedByUser(false); // 默认未点赞
            } else {
                comment.setLikedByUser(likedInteraction.getStatus() == 1); // 设置点赞状态
            }
        }
    }
}