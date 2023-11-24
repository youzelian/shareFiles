package Servlet;

import DTO.User;
import Service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "userUpdateServlet", urlPatterns = "/userUpdateServlet")
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
        String userPwd = request.getParameter("userPwd");
        // 2.传递数据到数据库中
        User user = new User(userName, userPwd);
        System.out.println(user);
        UserService userService = new UserService();
        boolean b = userService.saveUser(user);
        User user1 = userService.checkUser(userName);
        // 3.跳转到提示页面然后跳转登录页面，并显示提示信息
        String tips = b ? "<label style='color:green'>注册成功!</label><br>您的id为" + user1.getUserId() : "<label style='color:red'>注册失败!</label>";
        String type = "userSave";
        String address = "登录页面";
        request.setAttribute("tips", tips);
        request.setAttribute("type", type);
        request.setAttribute("address", address);
        request.getRequestDispatcher("prompt.jsp").forward(request, response);
    }
}
