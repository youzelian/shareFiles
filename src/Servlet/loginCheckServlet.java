package Servlet;

import DTO.User;
import Service.UserService;
import com.google.gson.Gson;
import org.mindrot.jbcrypt.BCrypt;

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
        // 设置字符编码
        request.setCharacterEncoding("utf-8");
        response.setContentType("application/json;charset=utf-8");
        response.setCharacterEncoding("utf-8");

        // 1. 接收用户信息
        String loginUserEmail = request.getParameter("loginUserEmail");
        String loginPwd = request.getParameter("loginPwd");
        String inputVCode = request.getParameter("inputVCode");
        UserService userService = new UserService();

        // 2. 进行验证
        // 验证邮箱是否存在
        boolean emailCode = true;
        User user = userService.checkEmail(loginUserEmail);
        if (user == null) {
            emailCode = false; // 邮箱不存在
        }

        // 验证密码是否正确
        boolean pwdCode = false;
        if (emailCode) {
            pwdCode = BCrypt.checkpw(loginPwd, user.getUserPwd()); // 验证密码
        }

        // 验证验证码是否正确
        boolean vCode = false;
        String sessionCode = (String) request.getSession().getAttribute("codes");
        if (inputVCode != null && sessionCode != null) {
            vCode = inputVCode.equalsIgnoreCase(sessionCode);
        }

        // 3. 构造响应数据
        ResponseData responseData = new ResponseData();
        responseData.emailCode = emailCode ? 1 : 0;
        responseData.pwdCode = pwdCode ? 1 : 0;
        responseData.vCode = vCode ? 1 : 0;

        // 4. 返回 JSON 响应
        PrintWriter out = response.getWriter();
        out.println(new Gson().toJson(responseData));
        out.flush();
        out.close();
    }

    // 响应数据类
    static class ResponseData {
        int emailCode;
        int pwdCode;
        int vCode;
    }
}