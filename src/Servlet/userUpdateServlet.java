package Servlet;

import DTO.User;
import Service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.IOException;
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
        
        // 2.接受并保存图书的封面图片
        // 2.1重新赋名
        // a.获取后缀名
        UserService userService = new UserService();
        User user = userService.checkUser(userName);
        // 获得原头像路径
        String userImgPath = user.getUserImgPath();
        userImgPath = userImgPath.substring(userImgPath.lastIndexOf("/") + 1);
        // 如果更新照片则对照片进行重新赋名
        Part userImg = request.getPart("userImg");
        String FileName = userImg.getSubmittedFileName();
        System.out.println(FileName);
        if (!FileName.equals("")) {
            String ext = FileName.substring(FileName.lastIndexOf("."));
            // b.使用随机数重新赋名
            userImgPath = UUID.randomUUID().toString() + ext;
            // 2.2获取userImg目录在服务器上的路径
            String dir = getServletContext().getRealPath("/userImg");
            String savePath = dir + "\\" + userImgPath;
            // 2.3保存图片
            userImg.write(savePath);
        }
        
        // 3.传递数据到数据库中
        int userId = user.getUserId();
        user = new User(userId, userName, userGender, userEmail, userTel, userAddress, "userImg/" + userImgPath, personalSignature, pwdQuestion, pwdQuestionAnswer);
        boolean b = userService.updateUser(user);
        
        // 4.跳转到提示页面然后跳转主页面，并显示提示信息
        String tips = b ? "<label style='color:green'>更新成功!</label>" : "<label style='color:red'>更新失败!</label>";
        String type = "userUpdate";
        String address = "主页面";
        request.setAttribute("tips", tips);
        request.setAttribute("type", type);
        request.setAttribute("address", address);
        request.getRequestDispatcher("prompt.jsp").forward(request, response);
    }
}
