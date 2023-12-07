package Servlet;

import DTO.User;
import Service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;

@WebServlet(name = "loginServlet", urlPatterns = "/loginServlet")
public class loginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        String userName = request.getParameter("userName");
        String userPwd = request.getParameter("userPwd");
        String auto_login = request.getParameter("auto_login");
        if (auto_login != null) {
            //编码是为了在cookie中存储汉字
            String usernameCode = URLEncoder.encode(userName, "UTF-8");
            Cookie cookie = new Cookie("cookieAuto", usernameCode + '-' + userPwd);
            //设置持久化时间
            cookie.setMaxAge(60 * 60);
            //发送cookie
            response.addCookie(cookie);
            request.setAttribute("cookieName", cookie.getName());
        }
        UserService userService = new UserService();
        User user = userService.checkUser(userName);
        // 将user存入session中
        HttpSession session = request.getSession();
        if (user.getUserGender() == null) {
            user.setUserGender("");
        }
        if (user.getUserEmail() == null) {
            user.setUserEmail("");
        }
        if (user.getUserTel() == null) {
            user.setUserTel("");
        }
        if (user.getUserAddress() == null) {
            user.setUserAddress("");
        }
        if (user.getPwdReqAnswer() == null) {
            user.setPwdReqAnswer("");
        }
        user.setPersonalSignature("");
        session.setAttribute("user", user);
        request.setAttribute("user", user);
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
}
