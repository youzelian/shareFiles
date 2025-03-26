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

@WebServlet(name = "changePwdServlet", urlPatterns = "/changePwdServlet")
public class changePwdServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");

        // 获取请求参数
        String oldPwd = request.getParameter("oldPwd"); // 旧密码
        String newPwd = request.getParameter("newPwd"); // 新密码
        String success = request.getParameter("success"); // 是否为成功后的页面跳转请求
        // 从 session 获取当前用户
        User user = (User) request.getSession().getAttribute("user");

        // 如果是成功后的页面跳转请求（第二次请求）
        if ("true".equals(success)) {
            // 清除 session，强制用户重新登录
            request.getSession().invalidate();
            // 设置提示信息和跳转参数
            request.setAttribute("tips", "<label style='color:green'>密码修改成功！</label>"); // 成功提示
            request.setAttribute("type", "forgetPwd"); // 操作类型
            request.setAttribute("address", "登录页面"); // 跳转目标
            // 转发到提示页面
            request.getRequestDispatcher("prompt.jsp").forward(request, response);
            return;
        }

        // 第一次请求：AJAX 验证和密码修改
        response.setContentType("application/json;charset=utf-8"); // 设置响应类型为 JSON

        ResponseData responseData; // 响应数据对象
        // 输入验证
        if (user == null) {
            responseData = new ResponseData(false, "用户未登录，请重新登录！");
        } else if (oldPwd == null || newPwd == null || oldPwd.trim().isEmpty() || newPwd.trim().isEmpty()) {
            responseData = new ResponseData(false, "旧密码和新密码不能为空！");
        } else if (oldPwd.equals(newPwd)) {
            responseData = new ResponseData(false, "旧密码和新密码不能相同！");
        } else if (newPwd.length() < 6 || newPwd.length() > 20 || !isComplexEnough(newPwd)) {
            responseData = new ResponseData(false, "密码需6-20个字符，且包含字母、数字、特殊符号中的至少两种！");
        } else {
            try {
                // 验证旧密码是否正确
                if (!BCrypt.checkpw(oldPwd, user.getUserPwd())) {
                    responseData = new ResponseData(false, "旧密码不正确！");
                } else {
                    // 对新密码进行加密
                    String hashedPassword = BCrypt.hashpw(newPwd, BCrypt.gensalt());
                    user.setUserPwd(hashedPassword); // 更新用户对象中的密码
                    UserService userService = new UserService();
                    userService.modifyUserPwd(user); // 更新数据库中的密码
                    responseData = new ResponseData(true, "密码修改成功！");
                }
            } catch (Exception e) {
                e.printStackTrace();
                responseData = new ResponseData(false, "密码修改失败！"); // 异常处理
            }
        }

        // 返回 JSON 响应
        PrintWriter out = response.getWriter();
        out.println(new Gson().toJson(responseData)); // 序列化为 JSON 并输出
        out.flush();
        out.close();
    }

    // 检查密码复杂度
    private boolean isComplexEnough(String pwd) {
        int types = 0;
        if (pwd.matches(".*[a-zA-Z].*")) types++; // 检查是否包含字母
        if (pwd.matches(".*\\d.*")) types++; // 检查是否包含数字
        if (pwd.matches(".*[@$!%*?&].*")) types++; // 检查是否包含特殊符号
        return types >= 2; // 至少包含两种类型
    }

    // 递归响应数据结构，返回状态信息
    static class ResponseData {
        boolean success; // 操作是否成功
        String message; // 返回消息

        ResponseData(boolean success, String message) {
            this.success = success;
            this.message = message;
        }
    }
}