package Servlet;

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
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "transferServlet", urlPatterns = "/transferServlet")
public class transferServlet extends HttpServlet {
    private static final long serialVersionUID = 1L; // 序列化版本号，用于序列化兼容性

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=UTF-8");

        // 1.获取请求参数并初始化服务类
        int fileId = Integer.parseInt(request.getParameter("fileId"));
        int type = Integer.parseInt(request.getParameter("type"));
        int pageNum = Integer.parseInt(request.getParameter("pageNum"));
        FileService fileService = new FileService();
        CommentService commentService = new CommentService();
        File_ClubService fileClubService = new File_ClubService();
        InteractService interactService = new InteractService();
        HttpSession session = request.getSession();// 获取当前用户信息
        User user = (User) session.getAttribute("user"); // 从 session 获取用户信息
        int userId = user != null ? user.getUserId() : -1; // 用户 ID，未登录时为 -1

        // 2.获取文件信息
        File file = fileService.checkFile(fileId); // 根据 fileId 查询文件
        if (file != null) {
            String mediaUrlsJson = file.getMediaUrls(); // 获取媒体 URL 的 JSON 字符串
            List<String> mediaUrls = new ArrayList<>();
            if (mediaUrlsJson != null && !mediaUrlsJson.isEmpty()) {
                try {
                    ObjectMapper mapper = new ObjectMapper();
                    // 解析 JSON 字符串为 List<String>
                    mediaUrls = mapper.readValue(mediaUrlsJson, mapper.getTypeFactory().constructCollectionType(List.class, String.class));
                } catch (Exception e) {
                    e.printStackTrace();
                    System.err.println("JSON 解析失败: " + mediaUrlsJson); // 记录解析错误
                }
            }
            request.setAttribute("mediaUrls", mediaUrls); // 设置媒体 URL 列表到请求属性
        } else {
            request.setAttribute("mediaUrls", new ArrayList<>()); // 文件不存在时返回空列表
        }

        // 3.获取评论列表并设置点赞状态
        List<Comment> commentRootList = commentService.listCommentByFId(fileId); // 获取文件的所有根评论
        if (commentRootList != null && userId != -1) { // 如果有评论且用户已登录
            for (Comment comment : commentRootList) {
                setCommentLikeStatus(comment, userId, interactService); // 设置根评论的点赞状态
                if (comment.getChildComments() != null) { // 如果有子评论
                    for (Comment child : comment.getChildComments()) {
                        setCommentLikeStatus(child, userId, interactService); // 设置子评论的点赞状态
                    }
                }
            }
        }

        // 4.处理用户对文件的投票和收藏状态
        if (userId != -1) { // 用户已登录
            // 检查投票状态（类型 1 表示点赞）
            Interaction voteInteraction = interactService.checkInteraction(1, userId, fileId);
            if (voteInteraction == null) { // 如果没有投票记录
                interactService.insertInteraction(new Interaction(1, userId, fileId, 0)); // 插入默认状态（未投票）
                if (file != null) file.setVoteStatus(0); // 设置文件投票状态为未投票
            } else {
                if (file != null) file.setVoteStatus(voteInteraction.getStatus()); // 设置文件投票状态
            }

            // 检查收藏状态（类型 2 表示收藏）
            Interaction collectInteraction = interactService.checkInteraction(2, userId, fileId);
            if (collectInteraction == null) { // 如果没有收藏记录
                interactService.insertInteraction(new Interaction(2, userId, fileId, 0)); // 插入默认状态（未收藏）
                if (file != null) file.setCollectByUser(false); // 设置文件未被收藏
            } else {
                if (file != null) file.setCollectByUser(collectInteraction.getStatus() == 1); // 设置文件收藏状态
            }
        }

        // 获取文件所属俱乐部信息
        File_Club file_club = fileClubService.checkClubByFileId(fileId); // 查询文件关联的俱乐部

        // 设置请求属性，供fileShow.jsp页面使用并转发到文件展示页面
        request.setAttribute("pageNum", pageNum); // 页面编号
        request.setAttribute("type", type);
        request.setAttribute("user", user);
        request.setAttribute("file", file);
        request.setAttribute("commentRootList", commentRootList);
        request.setAttribute("file_club", file_club);
        request.setAttribute("vote_status", (file != null && file.getVoteStatus() == 1) ? "upvote" :
                (file != null && file.getVoteStatus() == -1) ? "downvote" : "none"); // 投票状态字符串
        request.setAttribute("isCollectByUser", (file != null && file.isCollectByUser()) ? "collected" : ""); // 收藏状态字符串
        request.getRequestDispatcher("fileShow.jsp").forward(request, response);
    }

    // 设置评论的点赞状态
    private void setCommentLikeStatus(Comment comment, int userId, InteractService interactService) {
        if (comment != null && userId != -1) { // 评论存在且用户已登录
            // 检查点赞状态（类型 3 表示评论点赞）
            Interaction likedInteraction = interactService.checkInteraction(3, userId, comment.getCommentId());
            if (likedInteraction == null) { // 如果没有点赞记录
                interactService.insertInteraction(new Interaction(3, userId, comment.getCommentId(), 0)); // 插入默认状态（未点赞）
                comment.setLikedByUser(false); // 设置未点赞
            } else {
                comment.setLikedByUser(likedInteraction.getStatus() == 1); // 设置点赞状态
            }
        }
    }
}