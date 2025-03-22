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

@WebServlet(name = "verifyIdentityServlet", urlPatterns = "/verifyIdentityServlet")
public class verifyIdentityServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("application/json;charset=utf-8");

        String userName = request.getParameter("userName");
        String userEmail = request.getParameter("userEmail");

        UserService userService = new UserService();
        User user = userService.checkUser(userName);

        ResponseData responseData;
        if (user == null) {
            responseData = new ResponseData(false, "用户名不存在！");
        } else if (!user.getUserEmail().equals(userEmail)) {
            responseData = new ResponseData(false, "邮箱与用户名不匹配！");
        } else {
            request.getSession().setAttribute("resetUser", user); // 存储用户以供后续步骤使用
            responseData = new ResponseData(true, "验证成功！");
        }

        PrintWriter out = response.getWriter();
        out.println(new Gson().toJson(responseData));
        out.flush();
        out.close();
    }

    static class ResponseData {
        boolean success;
        String message;

        ResponseData(boolean success, String message) {
            this.success = success;
            this.message = message;
        }
    }
}
