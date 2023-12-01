package Service;

import DAO.CommentDAO;
import DTO.Comment;
import DTO.File;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import utils.DruidUtils;

import java.sql.SQLException;
import java.util.List;

public class CommentService {
    private CommentDAO commentDAO = new CommentDAO();
    
    // 增加评论
    public boolean saveComment(Comment comment) {
        int i = commentDAO.insertComment(comment);
        return i > 0 ? true : false;
    }
    
    // 根据评论id删除评论
    public boolean deleteComment(int commentId) {
        int i = commentDAO.deleteComment(commentId);
        return i > 0 ? true : false;
    }
    
    // 根据文件id查询所有评论对应的评论信息
    public List<Comment> listCommentByFId(int fId) {
        List<Comment> commentList = commentDAO.listCommentByFId(fId);
        return commentList;
    }
}
