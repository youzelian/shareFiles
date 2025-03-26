package Servlet;

import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

// 定义 Servlet 名称和 URL 映射
@WebServlet(name = "verifyCodeServlet", urlPatterns = "/verifyCodeServlet")
public class verifyCodeServlet extends HttpServlet {

    // 处理 GET 请求，转发到 doPost
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    // 处理 POST 请求，验证邮箱验证码
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8"); // 设置请求编码为 UTF-8
        response.setContentType("application/json;charset=utf-8"); // 设置响应类型为 JSON

        // 获取请求参数和 session 数据
        String emailVCode = request.getParameter("emailVCode"); // 用户输入的验证码
        String sessionCode = (String) request.getSession().getAttribute("emailCode"); // session 中存储的验证码
        Long timestamp = (Long) request.getSession().getAttribute("emailCodeTimestamp"); // 验证码生成时间戳

        ResponseData responseData; // 响应数据对象
        // 验证逻辑
        if (emailVCode == null || !emailVCode.equals(sessionCode)) {
            responseData = new ResponseData(false, "验证码错误！"); // 验证码不匹配
        } else if ((System.currentTimeMillis() - timestamp) > 300000) { // 检查是否超过5分钟（300,000毫秒）
            responseData = new ResponseData(false, "验证码已过期！"); // 验证码过期
        } else {
            responseData = new ResponseData(true, "验证码正确！"); // 验证通过
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
    }
}