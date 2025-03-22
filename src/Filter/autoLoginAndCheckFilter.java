package Filter;

import DTO.User;
import Service.UserService;
import org.mindrot.jbcrypt.BCrypt;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.net.URLDecoder;
import java.util.List;

@WebFilter("/*")
public class autoLoginAndCheckFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        // 1.判断前准备
        // a.将ServletRequest转换成HttpServletRequest
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;
        // b.通过request对象获取用户的请求路径
        String uri = request.getRequestURI();
        // c.截取uri最后一个/后的路径，即为请求路径
        String requestPath = uri.substring(uri.lastIndexOf("/") + 1);
        // 2.判断：如果请求路径是非受限资源则直接放行，如果是受限资源则需要验证用户是否登录
        // a.受限资源判断
        if ("".equals(requestPath) || "index.jsp".equals(requestPath)) {
            // 进入if代码，表示此请求是受限资源，需要验证用户是否登录
            // 3.判断session中是否有一次性登录标记，如果有则表示用户已经登录--放行，session没有再判断cookie，cookie有则放行并存入session
            // 如果都没有则表示用户未登录，发送到登录页面，提示请先登录

            /*****获得session中的值和cookie中的值*****/
            // 获得session中存入的tempLogin值
            HttpSession session = request.getSession();
            String tempLogin = (String) session.getAttribute("tempLogin");
            // 获得cookie
            Cookie[] cookies = request.getCookies();
            String cookieAuto = null;
            for (int i = 0; cookies != null && i < cookies.length; i++) {
                if ("cookieAuto".equals(cookies[i].getName())) {// 找到了指定的cookie
                    cookieAuto = cookies[i].getValue();
                    break;
                }
            }
            /*****获得session中的值和cookie中的值*****/

            // 判断tempLogin中是否有信息,只允许一次登录，登录完销毁，再次访问主页需要填写账号密码
            if (tempLogin != null) {
                // 销毁一次性登录标记tempLogin
                session.removeAttribute("tempLogin");
                filterChain.doFilter(request, response);
            }
            // 如果session中没有tempLogin信息，则判断cookie中有没有信息，有信息再判断在数据库是否有对应信息有则存入session并放行，没有则跳转到登录页面;cookie没有则直接跳转到登录页面
            else if (cookieAuto != null) {
                String[] parts = cookieAuto.split("-");
                String userEmail = parts[0];
                int count = 0;
                // 对cookie中的userEmail值解码
                userEmail = URLDecoder.decode(userEmail, "utf-8");
                String password = parts[1];
                UserService userService = new UserService();
                List<User> userList = userService.listUser();
                for (User users : userList) {
                    // 如果cookie值在数据库有对应的值则放行并将sessionAuto存入session
                    // BCrypt解码
                    if (users.getUserEmail().equals(userEmail) && BCrypt.checkpw(password, users.getUserPwd())) {
                        // 此处是为了写项目而写的，重新将user写入session（因为重新部署或重新启动session都会丢失)
                        // ？？？？？？？？？？
                        // 保存user值到session中
                        User user = userService.checkEmail(userEmail);
                        request.getSession().setAttribute("user", user);
                        // ？？？？？？？？？？
                        session.setAttribute("sessionAuto", "yes");
                        filterChain.doFilter(request, response);
                        break;
                    } else {
                        count++;
                    }
                }
                // 如果count的数等于userList的成员数量则表明没有，跳转到登录页面
                if (count == userList.size()) {
                    // 转到登录页面并判断是不是越界查看
                    if (!requestPath.equals("")) {
                        request.setAttribute("tipsHeader", "<label style='color:red;'>请先登录!</label>");
                    }
                    request.getRequestDispatcher("loginRegistrationPage.jsp").forward(request, response);
                }
            }
            // session没有tempLogin并且cookie也没有cookieAuto则直接跳转到login.jsp
            else {
                // 转到登录页面并判断是不是越界查看
                if (!requestPath.equals("")) {
                    request.setAttribute("tipsHeader", "<label style='color:red;'>请先登录!</label>");
                }
                request.getRequestDispatcher("loginRegistrationPage.jsp").forward(request, response);
            }
        }
        // b.非受限资源直接放行
        else {
            filterChain.doFilter(request, response);
        }
    }

    @Override
    public void destroy() {
    }
}
