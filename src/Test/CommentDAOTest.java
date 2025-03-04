package Test;

import DAO.CommentDAO;
import DTO.Comment;
import org.junit.Test;

import java.util.List;

public class CommentDAOTest {
    CommentDAO commentDAO = new CommentDAO();

    // 增加所有图书信息
    @Test
    public void insertComment() {
        // int i = commentDAO.insertComment(new Comment(3, 7, "好"));
        // System.out.println(i);
    }

    // 删除评论信息
    @Test
    public void deleteComment() {
        int i = commentDAO.deleteComment(12);
        System.out.println(i);
    }

    // 查询所有评论信息
    @Test
    public void listCommentByFId() {
        List<Comment> commentList = commentDAO.listCommentByFId(1);
        System.out.println(commentList);
    }
}