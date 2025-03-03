package Servlet;

import DTO.File;
import DTO.User;
import DTO.User_File;
import Service.FileService;
import Service.User_FileService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "interactServlet", urlPatterns = "/interactServlet")
public class interactServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int fid = Integer.parseInt(request.getParameter("fileId"));
        String type = request.getParameter("type");
        FileService fileService = new FileService();
        File file = fileService.checkFile(fid);
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        User_FileService user_fileService = new User_FileService();
        boolean judge = true;

        // 处理收藏逻辑
        if (type.equals("collect")) {
            User_File user_file = user_fileService.checkUser_File(user.getUserId(), fid);
            // 判断是否已经有了管理信息
            if (user_file == null) {
                // 如果没有则添加
                user_fileService.insertUser_File(new User_File(user.getUserId(), fid));
            } else {
                // 有则删除
                user_fileService.deleteUser_File(user.getUserId(), fid);
                judge = false;
            }
        }

        // 处理点赞、点踩、取消点赞、取消点踩、收藏和下载
        switch (type) {
            case "upvote":
                file.setFileVote(file.getFileVote() + 1);
                break;
            case "downvote":
                file.setFileVote(file.getFileVote() - 1);
                break;
            case "cancelUpvote":
                file.setFileVote(file.getFileVote() - 1); // 取消点赞，减去之前加的 1
                break;
            case "cancelDownvote":
                file.setFileVote(file.getFileVote() + 1); // 取消点踩，加回之前减的 1
                break;
            case "collect":
                if (judge) {
                    file.setFileCollect(file.getFileCollect() + 1);
                } else {
                    file.setFileCollect(file.getFileCollect() - 1);
                }
                break;
            case "download":
                file.setFileDownloadAmount(file.getFileDownloadAmount() + 1);
                break;
        }

        // 更新数据库
        fileService.interact(file);

        // 只能用\"不能用'来代替，必须是{"yy":xx}的形式
        String jsonStr = "{\"fileVote\":" + file.getFileVote() + "," + "\"fileCollect\":" + file.getFileCollect() + "," + "\"fileDownloadAmount\":" + file.getFileDownloadAmount() + "}";
        // 3.响应ajax请求给出提示信息
        response.setContentType("application/json;charset=utf-8");
        response.setCharacterEncoding("utf-8");
        PrintWriter out = response.getWriter();
        out.println(jsonStr);
        out.flush();
        out.close();
    }
}