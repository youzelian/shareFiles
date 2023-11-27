package Servlet;

import DTO.User;
import Service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "changePwdServlet", urlPatterns = "/changePwdServlet")
public class changePwdServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1.从前端接收请求
        request.setCharacterEncoding("utf-8");
        String userName = request.getParameter("userName");
        String oldPwd = request.getParameter("oldPwd");
        String newPwd1 = request.getParameter("newPwd1");
        String newPwd2 = request.getParameter("newPwd2");
        // 2.从数据库中取出数据并比较旧密码
        UserService userService = new UserService();
        User user = userService.checkUser(userName);
        String type = null;
        String address = null;
        if (user.getUserPwd().equals(oldPwd) && newPwd1.equals(newPwd2)) {
            user.setUserPwd(newPwd2);
            userService.modifyUserPwd(user);
            request.setAttribute("tips", "<label style='color:green'>修改密码成功!请重新登录</label>");
            type = "forgetPwd";
            address = "登录页面";
        }
        else {
            request.setAttribute("tips", "<label style='color:red'>修改密码失败!</label>");
            type = "forgetPwdFail";
            address = "主页面";
        }
        request.setAttribute("type", type);
        request.setAttribute("address", address);
        request.getRequestDispatcher("prompt.jsp").forward(request, response);
    }
}
