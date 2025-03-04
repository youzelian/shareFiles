package DAO;

import DTO.Comment;
import org.apache.commons.dbutils.*;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.ColumnListHandler;
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
            String sql = "insert into comments (f_id, u_id, comment_content, parent_id, root_parent_id) values ( ?, ?, ?, ?, ?)";
            QueryRunner queryRunner = new QueryRunner(DruidUtils.getDataSource());
            Object[] params = {
                    comment.getfId(),
                    comment.getuId(),
                    comment.getCommentContent(),
                    comment.getParentId(),
                    comment.getRootParentId()
            };
            i = queryRunner.update(sql, params);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return i;
    }


    // 递归删除子评论
    private void deleteChildComments(int parentId) {
        try {
            // 查询所有以该评论为父评论的子评论
            String sql = "SELECT comment_id FROM comments WHERE parent_id = ? AND is_delete = 0";
            QueryRunner queryRunner = new QueryRunner(DruidUtils.getDataSource());
            List<Integer> childIds = queryRunner.query(sql, new ColumnListHandler<Integer>("comment_id"), parentId);

            // 递归删除每个子评论
            for (Integer childId : childIds) {
                deleteChildComments(childId); // 递归删除子评论的子评论
                String deleteSql = "UPDATE comments SET is_delete = 1 WHERE comment_id = ?";
                queryRunner.update(deleteSql, childId);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // 删除评论信息（递归删除子评论）
    public int deleteComment(int commentId) {
        int i = 0;
        try {
            // 先递归删除所有子评论
            deleteChildComments(commentId);
            // 再删除当前评论
            String sql = "UPDATE comments SET is_delete = 1 WHERE comment_id = ?";
            QueryRunner queryRunner = new QueryRunner(DruidUtils.getDataSource());
            i = queryRunner.update(sql, commentId);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return i;
    }

    // 根据文件id查询文件对应的所有评论信息
    public List<Comment> listCommentByFId(int fId) {
        List<Comment> commentList = null;
        try {
            String sql = "SELECT c.comment_id, c.f_id, c.u_id, c.comment_content, c.is_delete, c.comment_create_time, c.comment_liked, c.parent_id, c.root_parent_id, u.user_name, u.user_img_path " +
                    "FROM comments c INNER JOIN users u ON c.u_id = u.user_id " +
                    "WHERE c.f_id = ? AND c.is_delete = 0";
            QueryRunner queryRunner = new QueryRunner(DruidUtils.getDataSource());
            commentList = queryRunner.query(sql, new BeanListHandler<Comment>(Comment.class, processor), fId);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return commentList;
    }
}
