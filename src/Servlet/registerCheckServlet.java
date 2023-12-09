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

@WebServlet(name = "registerCheckServlet", urlPatterns = "/registerCheckServlet")
public class registerCheckServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        // 1.接受用户信息
        String userName = request.getParameter("registerUserName");
        String userPwd1 = request.getParameter("registerPwd1");
        String userPwd2 = request.getParameter("registerPwd2");
        // 2.判断用户名和密码是否符合规范
        UserService userService = new UserService();
        User user = userService.checkUser(userName);
        boolean b1 = user == null ? true : false;
        boolean b2 = userPwd1.equals(userPwd2);
        String jsonStr;
        if (b1 == true && b2 == true) {
            jsonStr = "{\"nameCode\":1,\"pwdCode\":1}";
        }
        else if (b1 == true && b2 == false) {
            jsonStr = "{\"nameCode\":1,\"pwdCode\":0}";
        }
        else if (b1 == false && b2 == true) {
            jsonStr = "{\"nameCode\":0,\"pwdCode\":1}";
        }
        else {
            jsonStr = "{\"nameCode\":0,\"pwdCode\":0}";
        }
        // 3.响应ajax请求给出提示信息
        response.setContentType("application/json;charset=utf-8");
        response.setCharacterEncoding("utf-8");
        PrintWriter out = response.getWriter();
        out.println(jsonStr);
        out.flush();
        out.close();
    }
}
