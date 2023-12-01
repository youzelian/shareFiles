package DAO;

import DTO.Comment;
import org.apache.commons.dbutils.*;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import utils.DruidUtils;

import java.sql.SQLException;
import java.util.List;

public class CommentDAO {
    BeanProcessor bean = new GenerousBeanProcessor();
    RowProcessor processor = new BasicRowProcessor(bean);
    
    // 增加评论信息
    public int insertComment(Comment comment) {
        int i = 0;
        try {
            String sql = "insert into comments(comment_id,f_id,u_id,comment_content) values(?,?,?,?)";
            QueryRunner queryRunner = new QueryRunner(DruidUtils.getDataSource());
            Object[] params = {comment.getCommentId(), comment.getfId(), comment.getuId(), comment.getCommentContent()};
            i = queryRunner.update(sql, params);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return i;
    }
    
    // 根据评论id删除评论信息
    public int deleteComment(int commentId) {
        int i = 0;
        try {
            String sql = "delete  from comments where comment_id=?";
            QueryRunner queryRunner = new QueryRunner(DruidUtils.getDataSource());
            i = queryRunner.update(sql, commentId);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return i;
    }
    
    // 根据文件id查询所有文件对应的评论信息
    public List<Comment> listCommentByFId(int fId) {
        List<Comment> commentList = null;
        try {
            String sql = "select distinct comment_id,f_id,u_id,comment_content,user_img_path,user_name from comments inner join users on comments.u_id=users.user_id where comments.f_id=?";
            QueryRunner queryRunner = new QueryRunner(DruidUtils.getDataSource());
            commentList = queryRunner.query(sql, new BeanListHandler<Comment>(Comment.class, processor), fId);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return commentList;
    }
}
