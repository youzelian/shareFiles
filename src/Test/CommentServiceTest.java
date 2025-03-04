package Test;

import DTO.Comment;
import Service.CommentService;
import org.junit.Test;

import java.util.List;

import static org.junit.Assert.*;

public class CommentServiceTest {
    private CommentService commentService = new CommentService();

    // 增加评论信息
    @Test
    public void saveComment() {
        // boolean great = commentService.saveComment(new Comment(1, 7, "great"));
        // System.out.println(great);
    }

    // 删除评论信息
    @Test
    public void deleteComment() {
        boolean b = commentService.deleteComment(15);
        System.out.println(b);
    }

    // 查询评论信息
    @Test
    public void checkComment() {
        List<Comment> commentList = commentService.listCommentByFId(1);
        System.out.println(commentList);
    }
}