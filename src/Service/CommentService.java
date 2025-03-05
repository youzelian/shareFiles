package Service;

import DAO.CommentDAO;
import DTO.Comment;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CommentService {
    private CommentDAO commentDAO = new CommentDAO();

    // 增加评论
    public boolean saveComment(Comment comment) {
        int i = commentDAO.insertComment(comment);
        return i > 0;
    }

    // 删除评论
    public boolean deleteComment(int commentId) {
        int i = commentDAO.deleteComment(commentId);
        return i > 0;
    }

    // 根据文件id查询所有评论，并构建两层评论树
    public List<Comment> listCommentByFId(int fId) {
        // 查询所有评论
        List<Comment> commentList = commentDAO.listCommentByFId(fId);
        if (commentList == null) {
            return new ArrayList<>();
        }

        // 构建两层评论树
        return buildCommentTree(commentList);
    }

    // 将平面评论列表构建成两层评论树
    private List<Comment> buildCommentTree(List<Comment> commentList) {
        // 使用 Map 存储评论，key 为 commentId，value 为 Comment 对象
        Map<Integer, Comment> commentMap = new HashMap<>();
        for (Comment comment : commentList) {
            comment.setChildComments(new ArrayList<>()); // 初始化子评论列表
            commentMap.put(comment.getCommentId(), comment);
        }

        // 存储根评论（一级评论）
        List<Comment> rootComments = new ArrayList<>();

        // 遍历评论列表，构建两层结构
        for (Comment comment : commentList) {
            if (comment.getParentId() == 0) {
                // 一级评论
                rootComments.add(comment);
            } else {
                // 查找父评论
                Comment parentComment = commentMap.get(comment.getParentId());
                if (parentComment != null) {
                    if (parentComment.getParentId() == 0) {
                        // 如果父评论是一级评论，则当前评论是二级评论
                        parentComment.getChildComments().add(comment);
                    } else {
                        // 如果父评论是二级评论，则将当前评论的 parentId 调整为 rootParentId
                        Comment rootComment = commentMap.get(comment.getRootParentId());
                        if (rootComment != null) {
                            // 记录被回复的用户
                            comment.setRepliedUserName(parentComment.getUserName());
                            // 将当前评论作为二级评论，添加到一级评论的子评论列表
                            rootComment.getChildComments().add(comment);
                        }
                    }
                }
            }
        }
        return rootComments;
    }

    // 根据评论Id查询评论信息
    public Comment getCommentById(int commentId) {
        Comment comment = commentDAO.getCommentById(commentId);
        return comment;
    }

    // 更新评论信息
    public int updateComment(Comment comment) {
        int i = commentDAO.updateComment(comment);
        return i;
    }
}