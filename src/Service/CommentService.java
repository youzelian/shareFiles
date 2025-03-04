package Service;

import DAO.CommentDAO;
import DTO.Comment;
import DTO.File;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import utils.DruidUtils;

import java.sql.SQLException;
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

    // 根据文件id查询所有评论，并构建父子关系
    public List<Comment> listCommentByFId(int fId) {
        // 查询所有评论
        List<Comment> commentList = commentDAO.listCommentByFId(fId);
        if (commentList == null) {
            return new ArrayList<>();
        }

        // 构建父子关系
        return buildCommentTree(commentList);
    }

    // 将平面评论列表构建成树形结构
    private List<Comment> buildCommentTree(List<Comment> commentList) {
        // 使用 Map 存储评论，key 为 commentId，value 为 Comment 对象
        Map<Integer, Comment> commentMap = new HashMap<>();
        for (Comment comment : commentList) {
            comment.setChildComments(new ArrayList<>()); // 初始化子评论列表
            commentMap.put(comment.getCommentId(), comment);
        }

        // 存储根评论（一级评论）
        List<Comment> rootComments = new ArrayList<>();

        // 遍历评论列表，构建父子关系
        for (Comment comment : commentList) {
            if (comment.getParentId() == 0) {
                // 如果 parentId 为 0，说明是一级评论
                rootComments.add(comment);
            } else {
                // 如果有 parentId，找到父评论并添加到其子评论列表
                Comment parentComment = commentMap.get(comment.getParentId());
                if (parentComment != null) {
                    parentComment.getChildComments().add(comment);
                }
            }
        }

        return rootComments;
    }
}
