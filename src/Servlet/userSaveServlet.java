package Servlet;

import DTO.User;
import Service.UserService;
import org.mindrot.jbcrypt.BCrypt;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "userSaveServlet", urlPatterns = "/userSaveServlet")
public class userSaveServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 设置字符编码
        request.setCharacterEncoding("utf-8");

        // 1. 接收用户信息
        String userName = request.getParameter("userName");
        String userPwd = request.getParameter("userPwd");
        String userEmail = request.getParameter("userEmail");

        // 2. 校验输入（防止空值）
        if (userName == null || userName.trim().isEmpty() || userPwd == null || userPwd.trim().isEmpty()) {
            request.setAttribute("msg", "用户名或密码不能为空");
            request.getRequestDispatcher("/prompt.jsp").forward(request, response);
            return;
        }

        // 3. 加密密码
        String hashedPassword = BCrypt.hashpw(userPwd, BCrypt.gensalt());
        System.out.println("Hashed password: " + hashedPassword);

        // 4. 保存用户
        UserService userService = new UserService();
        boolean saveSuccess = userService.saveUser(new User(userName, hashedPassword, userEmail));
        User savedUser = userService.checkUser(userName);


        // 5. 转发到提示页面
        String tips = saveSuccess ? "<label style='color:green'>注册成功!</label><br>您的id为" + savedUser.getUserId() : "<label style='color:red'>注册失败!</label>";
        String type = "userSave";
        String address = "登录页面";
        request.setAttribute("tips", tips);
        request.setAttribute("type", type);
        request.setAttribute("address", address);
        request.getRequestDispatcher("prompt.jsp").forward(request, response);
    }
}