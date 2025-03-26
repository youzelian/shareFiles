package Servlet;

import DTO.User;
import Service.UserService;
import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

// 定义 Servlet 名称和 URL 映射
@WebServlet(name = "verifyIdentityServlet", urlPatterns = "/verifyIdentityServlet")
public class verifyIdentityServlet extends HttpServlet {

    // 处理 GET 请求，转发到 doPost
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    // 处理 POST 请求，验证用户身份
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("application/json;charset=utf-8"); // 设置响应类型为 JSON

        // 获取请求参数
        String userName = request.getParameter("userName");
        String userEmail = request.getParameter("userEmail");

        // 查询用户信息
        UserService userService = new UserService();
        User user = userService.checkUser(userName); // 根据用户名查询用户

        ResponseData responseData; // 响应数据对象
        // 验证逻辑
        if (user == null) {
            responseData = new ResponseData(false, "用户名不存在！"); // 用户不存在
        } else if (!user.getUserEmail().equals(userEmail)) {
            responseData = new ResponseData(false, "邮箱与用户名不匹配！"); // 邮箱不匹配
        } else {
            request.getSession().setAttribute("resetUser", user); // 将用户信息存入 session，供后续步骤使用
            responseData = new ResponseData(true, "验证成功！"); // 验证通过
        }

        // 返回 JSON 响应
        PrintWriter out = response.getWriter();
        out.println(new Gson().toJson(responseData)); // 序列化为 JSON 并输出
        out.flush();
        out.close();
    }

    // 响应数据结构
    static class ResponseData {
        boolean success; // 操作是否成功
        String message; // 返回消息

        ResponseData(boolean success, String message) {
            this.success = success;
            this.message = message;
        }
        // 类似于{"success": true, "message": "验证码正确！"}
    }
}