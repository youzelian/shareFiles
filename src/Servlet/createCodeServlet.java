package Servlet;

import cn.dsna.util.images.ValidateCode;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "createCodeServlet", urlPatterns = "/createCode")
public class createCodeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //创建验证码 四参构造方法 宽度 高度 输入的字符 干扰线
        ValidateCode validateCode = new ValidateCode(200, 30, 4, 20);
        //拿到输入的字符串
        String codes = validateCode.getCode();
        //把验证码存到 session 中
        HttpSession session = request.getSession();
        session.setAttribute("codes", codes);
        validateCode.write(response.getOutputStream());
    }
}
