package Servlet;

import DTO.User;
import Service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "loginCheckServlet", urlPatterns = "/loginCheckServlet")
public class loginCheckServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        // 1.接受用户信息
        String userName = request.getParameter("loginUserName");
        String userPwd = request.getParameter("loginPwd");
        String inputVCode = request.getParameter("inputVCode");
        // 2.判断用户名和密码是否符合规范
        UserService userService = new UserService();
        User user = userService.checkUser(userName);
        boolean b1 = user == null ? false : true;
        boolean b2 = false;
        // 如果找到用户则判断面
        if (b1) {
            b2 = userPwd.equals(user.getUserPwd());
        }
        // 3.从session中得到验证码并判断验证码是否一致
        // 验证码非空判断且验证码不区分大小写
        String codes = (String) request.getSession().getAttribute("codes");
        boolean b3 = !inputVCode.isEmpty() && inputVCode.equalsIgnoreCase(codes);
        String jsonStr;
        if (b1) {
            jsonStr = "{\"nameCode\":1,";
        } else {
            jsonStr = "{\"nameCode\":0,";
        }
        if (b2) {
            jsonStr += "\"pwdCode\":1,";
        } else {
            jsonStr += "\"pwdCode\":0,";
        }
        if (b3) {
            jsonStr += "\"vCode\":1}";
        } else {
            jsonStr += "\"vCode\":0}";
        }
        System.out.println(jsonStr);
        // 4.响应ajax请求给出提示信息
        response.setContentType("application/json;charset=utf-8");
        response.setCharacterEncoding("utf-8");
        PrintWriter out = response.getWriter();
        out.println(jsonStr);
        out.flush();
        out.close();
    }
}
