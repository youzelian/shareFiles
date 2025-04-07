package Servlet;

import DTO.User;
import Service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.UUID;

@WebServlet(name = "userUpdateServlet", urlPatterns = "/userUpdateServlet")
@MultipartConfig
public class userUpdateServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1.接受请求
        request.setCharacterEncoding("utf-8");
        String userName = request.getParameter("userName");
        String userGender = request.getParameter("userGender");
        String userEmail = request.getParameter("userEmail");
        String userTel = request.getParameter("userTel");
        String userAddress = request.getParameter("userAddress");
        String pwdQuestion = request.getParameter("pwdQuestion");
        String pwdQuestionAnswer = request.getParameter("pwdQuestionAnswer");
        String personalSignature = request.getParameter("personalSignature");
        UserService userService = new UserService();
        User user = userService.checkUser(userName);

        // 2.接收并保存用户头像到文件中
        Part userImg = request.getPart("userImg");
        String userImgName = userImg.getSubmittedFileName();
        String UUIDUserImgName = null;
        // 判断是否上传了照片
        if (!userImgName.isEmpty()) {
            // 2.1获取头像后缀名
            String ext = userImgName.substring(userImgName.lastIndexOf("."));
            // 2.2使用随机数给头像文件重新赋名
            UUIDUserImgName = UUID.randomUUID() + ext;
            String dir = getServletContext().getRealPath("userImg");
            // 2.3判断用户是否已经有了头像（是否是第一次上传）,如果已经有了则删除原来的头像(节省空间)
            if (user.getUserImgPath() != null) {
                String oldUserImgName = user.getUserImgPath().contains("/") ?
                        user.getUserImgPath().substring(user.getUserImgPath().lastIndexOf("/") + 1) :
                        user.getUserImgPath().substring(user.getUserImgPath().lastIndexOf("\\") + 1);
                // 此处使用的是java.io.File
                File file = new File(dir + "/" + oldUserImgName);
                // file.deleteOnExit();  这个只有重启服务器才会删除
                Files.deleteIfExists(file.toPath()); // 这个是立即删除
            }
            // Windows中文件路径是以'\'隔开，在字符串中表达则写两个，即'\\'
            // String savePath = dir + "\\" + userImgPath;
            // Linux中文件路径是以'/'隔开，在字符串中表达只需写一个，即'/'
            String savePath = dir + "/" + UUIDUserImgName;
            // 2.4保存图片
            userImg.write(savePath);
        } else {
            // 如果没有重新上传，头像名称不变
            UUIDUserImgName = user.getUserImgPath().substring(user.getUserImgPath().lastIndexOf("/") + 1);
        }

        // 3.传递数据到数据库中
        int userId = user.getUserId();
        user = new User(userId, userName, userGender, userEmail, userTel, userAddress, "userImg/" + UUIDUserImgName, personalSignature, pwdQuestion, pwdQuestionAnswer);
        boolean b = userService.updateUser(user);

        // 4.每次更新user数据，重新更新session中的user值
        HttpSession session = request.getSession();
        // 利用checkUser重新获得user，因为上面传递数据到数据中的数据不完整，没有用户密码，所以需要重新抓取
        User user1 = userService.checkUser(userName);
        session.setAttribute("user", user1);

        // 5.跳转到提示页面然后跳转主页面，并显示提示信息
        String tips = b ? "<label style='color:green'>更新成功!</label>" : "<label style='color:red'>更新失败!</label>";
        String type = "userUpdate";
        String address = "主页面";
        request.setAttribute("tips", tips);
        request.setAttribute("type", type);
        request.setAttribute("address", address);
        request.getRequestDispatcher("prompt.jsp").forward(request, response);
    }
}