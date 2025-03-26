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

@WebServlet(name = "forgetPwdServlet", urlPatterns = "/forgetPwdServlet")
public class forgetPwdServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");

        // 获取参数
        String newPwd = request.getParameter("newPwd");
        String success = request.getParameter("success");

        // 从 session 获取通过验证的用户
        User user = (User) request.getSession().getAttribute("resetUser");

        // 如果是页面跳转请求（成功后第二次请求）
        if ("true".equals(success)) {
            // 清除 session
            request.getSession().removeAttribute("resetUser");
            request.getSession().removeAttribute("emailCode");
            request.getSession().removeAttribute("emailCodeTimestamp");
            // 设置跳转参数
            request.setAttribute("tips", "<label style='color:green'>密码修改成功！</label>");
            request.setAttribute("type", "forgetPwd");
            request.setAttribute("address", "登录页面");
            request.getRequestDispatcher("prompt.jsp").forward(request, response);
            return;
        }

        // 第一次请求：AJAX 验证
        response.setContentType("application/json;charset=utf-8");

        ResponseData responseData;
        if (user == null) {
            responseData = new ResponseData(false, "用户未验证，请重新开始！");
        } else if (newPwd == null || newPwd.trim().isEmpty()) {
            responseData = new ResponseData(false, "新密码不能为空！");
        } else if (newPwd.length() < 6 || newPwd.length() > 20 || !isComplexEnough(newPwd)) {
            responseData = new ResponseData(false, "密码需6-20个字符，且包含字母、数字、特殊符号中的至少两种！");
        } else {
            try {
                // 加密新密码
                String hashedPassword = BCrypt.hashpw(newPwd, BCrypt.gensalt());
                user.setUserPwd(hashedPassword);
                UserService userService = new UserService();
                userService.modifyUserPwd(user);
                responseData = new ResponseData(true, "密码修改成功！");
            } catch (Exception e) {
                e.printStackTrace();
                responseData = new ResponseData(false, "密码修改失败！");
            }
        }

        PrintWriter out = response.getWriter();
        out.println(new Gson().toJson(responseData));
        out.flush();
        out.close();
    }

    // 检查密码复杂度
    private boolean isComplexEnough(String pwd) {
        int types = 0;
        if (pwd.matches(".*[a-zA-Z].*")) types++;
        if (pwd.matches(".*\\d.*")) types++;
        if (pwd.matches(".*[@$!%*?&].*")) types++;
        return types >= 2;
    }

    // 递归响应数据结构，返回状态信息
    static class ResponseData {
        boolean success;
        String message;

        ResponseData(boolean success, String message) {
            this.success = success;
            this.message = message;
        }
    }
}