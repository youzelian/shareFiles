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

@WebServlet(name = "registerCheckServlet", urlPatterns = "/registerCheckServlet")
public class registerCheckServlet extends HttpServlet {
    // 验证码有效期：10分钟（单位：毫秒）
    private static final long EMAIL_CODE_VALIDITY = 10 * 60 * 1000;
    // 用户名长度限制
    private static final int USERNAME_MIN_LENGTH = 2;
    private static final int USERNAME_MAX_LENGTH = 20;
    // 密码长度限制
    private static final int PASSWORD_MIN_LENGTH = 6;
    private static final int PASSWORD_MAX_LENGTH = 20;

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
        String userName = request.getParameter("registerUserName");
        String email = request.getParameter("registerEmail");
        String userPwd1 = request.getParameter("registerPwd1");
        String userPwd2 = request.getParameter("registerPwd2");
        String emailVCode = request.getParameter("emailVCode");

        // 2. 进行验证
        UserService userService = new UserService();

        // 验证用户名是否可用（包括长度限制）
        boolean nameCode = true;
        if (userName == null || userName.trim().isEmpty()) {
            nameCode = false; // 用户名为空
        } else if (userName.length() < USERNAME_MIN_LENGTH || userName.length() > USERNAME_MAX_LENGTH) {
            nameCode = false; // 用户名长度不符合要求
        } else {
            User userByName = userService.checkUser(userName);
            if (userByName != null) {
                nameCode = false; // 用户名已存在
            }
        }

        // 验证邮箱是否可用（包括格式校验）
        boolean emailCode = true;
        if (email == null || email.trim().isEmpty()) {
            emailCode = false; // 邮箱为空
        } else if (!email.matches("^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$")) {
            emailCode = false; // 邮箱格式不合法
        } else {
            User userByEmail = userService.checkEmail(email);
            if (userByEmail != null) {
                emailCode = false; // 邮箱已被注册
            }
        }

        // 验证密码强度和一致性
        boolean pwdCode = true;
        if (userPwd1 == null || userPwd2 == null) {
            pwdCode = false; // 密码为空
        } else {
            // 检查密码长度
            if (userPwd1.length() < PASSWORD_MIN_LENGTH || userPwd1.length() > PASSWORD_MAX_LENGTH) {
                pwdCode = false;
            } else {
                // 检查字符类型
                boolean hasLetter = userPwd1.matches(".*[a-zA-Z].*"); // 包含字母
                boolean hasNumber = userPwd1.matches(".*\\d.*"); // 包含数字
                boolean hasSpecial = userPwd1.matches(".*[@$!%*?&].*"); // 包含特殊符号
                int typeCount = (hasLetter ? 1 : 0) + (hasNumber ? 1 : 0) + (hasSpecial ? 1 : 0);
                if (typeCount < 2) {
                    pwdCode = false; // 不满足至少两种字符类型
                } else if (!userPwd1.equals(userPwd2)) {
                    pwdCode = false; // 两次密码不一致
                }
            }
        }

        // 验证邮箱验证码是否正确（包括是否过期）
        boolean vCode = false;
        String sessionEmailCode = (String) request.getSession().getAttribute("emailCode");
        Long emailCodeTimestamp = (Long) request.getSession().getAttribute("emailCodeTimestamp");
        if (sessionEmailCode != null && emailCodeTimestamp != null) {
            long currentTime = System.currentTimeMillis();
            if (currentTime - emailCodeTimestamp <= EMAIL_CODE_VALIDITY) {
                vCode = emailVCode != null && emailVCode.equals(sessionEmailCode);
            }
        }

        // 3. 构造响应数据
        ResponseData responseData = new ResponseData();
        responseData.nameCode = nameCode ? 1 : 0;
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
        int nameCode;
        int emailCode;
        int pwdCode;
        int vCode;
    }
}