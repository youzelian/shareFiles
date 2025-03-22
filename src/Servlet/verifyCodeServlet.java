package Servlet;

import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "verifyCodeServlet", urlPatterns = "/verifyCodeServlet")
public class verifyCodeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("application/json;charset=utf-8");

        String emailVCode = request.getParameter("emailVCode");
        String sessionCode = (String) request.getSession().getAttribute("emailCode");
        Long timestamp = (Long) request.getSession().getAttribute("emailCodeTimestamp");

        ResponseData responseData;
        if (emailVCode == null || !emailVCode.equals(sessionCode)) {
            responseData = new ResponseData(false, "验证码错误！");
        } else if ((System.currentTimeMillis() - timestamp) > 300000) { // 5分钟有效期
            responseData = new ResponseData(false, "验证码已过期！");
        } else {
            responseData = new ResponseData(true, "验证码正确！");
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
