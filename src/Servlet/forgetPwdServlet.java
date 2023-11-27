package Servlet;

import DTO.User;
import Service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "forgetPwdServlet", urlPatterns = "/forgetPwdServlet")
public class forgetPwdServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1.从前端接收请求
        request.setCharacterEncoding("utf-8");
        String userName = request.getParameter("userName");
        String pwdReq = request.getParameter("pwdReq");
        String pwdReqAnswer = request.getParameter("pwdReqAnswer");
        String newPwd = request.getParameter("newPwd2");
        // 2.从数据库中取出数据并比较密保问题和密保答案是否一致
        UserService userService = new UserService();
        User user = userService.checkUser(userName);
        if (user.getPwdReq().equals(pwdReq) && user.getPwdReqAnswer().equals(pwdReqAnswer)) {
            user.setUserPwd(newPwd);
            userService.modifyUserPwd(user);
            request.setAttribute("tips", "<label style='color:green'>修改密码成功!</label>");
        }
        else {
            request.setAttribute("tips", "<label style='color:red'>修改密码失败!</label>");
        }
        String type = "forgetPwd";
        String address = "登录页面";
        request.setAttribute("type", type);
        request.setAttribute("address", address);
        request.getRequestDispatcher("prompt.jsp").forward(request, response);
    }
}
