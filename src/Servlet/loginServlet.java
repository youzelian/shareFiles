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
        String userEmail = request.getParameter("userEmail");
        String userPwd = request.getParameter("userPwd");
        String auto_login = request.getParameter("auto_login");
        if (auto_login != null) {
            // 编码是为了在cookie中存储汉字
            String usernameCode = URLEncoder.encode(userEmail, "UTF-8");
            Cookie cookie = new Cookie("cookieAuto", usernameCode + '-' + userPwd);
            // 设置持久化时间
            cookie.setMaxAge(60 * 60);
            // 发送cookie
            response.addCookie(cookie);
            request.setAttribute("cookieName", cookie.getName());
        }
        UserService userService = new UserService();
        User user = userService.checkEmail(userEmail);
        // 将user存入session中
        HttpSession session = request.getSession();
        // 设置null值为空值
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
        if (user.getPersonalSignature() == null) {
            user.setPersonalSignature("");
        }
        session.setAttribute("user", user);
        session.setAttribute("tempLogin", "yes");
        response.sendRedirect("index.jsp");
    }
}
