package Filter;

import DTO.User;
import Service.UserService;

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
        // a.将ServletRequest转换成HttpServletRequest
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;
        // b.通过request对象获取用户的请求路径
        String uri = request.getRequestURI();
        // c.截取uri最后一个/后的路径，即为请求路径
        String requestPath = uri.substring(uri.lastIndexOf("/") + 1);
        // 2.判断：如果请求路径是非受限资源则直接放行，如果是受限资源则需要验证用户是否登录
        // a.受限资源判断
        if ("".equals(requestPath) || "index".equals(requestPath)) {
            //进入if代码，表示此请求是受限资源，需要验证用户是否登录
            //3.判断session中是否有用户信息，如果有则表示用户已经登录--放行，session没有再判断cookie，cookie有则放行并存入session
            //如果都没有则表示用户未登录，发送到登录页面，提示请先登录
            
            /*****获得session值和cookie值*****/
            // 获得session
            HttpSession session = request.getSession();
            // User user = (User) session.getAttribute("user");
            // 获得session中存入的sessionAuto值
            String sessionAuto = (String) session.getAttribute("sessionAuto");
            // 获得cookie
            Cookie[] cookies = request.getCookies();
            String cookieAuto = null;
            for (int i = 0; cookies != null && i < cookies.length; i++) {
                if ("cookieAuto".equals(cookies[i].getName())) {// 找到了指定的cookie
                    cookieAuto = cookies[i].getValue();
                    break;
                }
            }
            /*****获得session值和cookie值*****/
            
            // 判断sessionAuto中是否有信息
            if (sessionAuto != null) {
                filterChain.doFilter(request, response);
            }
            // 如果session中没有sessionAuto信息，则判断cookie中有没有信息，有信息再判断在数据库是否有对应信息有则存入session并放行，没有则跳转到登录页面，cookie没有则直接跳转到登录页面
            else if (cookieAuto != null) {
                String[] parts = cookieAuto.split("-");
                String username = parts[0];
                int count = 0;
                // 对cookie中的userName值解码
                username = URLDecoder.decode(username, "utf-8");
                String password = parts[1];
                UserService userService = new UserService();
                List<User> userList = userService.listUser();
                for (User users : userList) {
                    // 如果cookie值在数据库有对应的值则放行并将sessionAuto存入session
                    if (users.getUserName().equals(username) && users.getUserPwd().equals(password)) {
                        // request.getSession().setAttribute("user", new User(username, password));
                        session.setAttribute("sessionAuto", "yes");
                        filterChain.doFilter(request, response);
                        break;
                    }
                    else {
                        count++;
                    }
                }
                // 如果count的数等于userList的成员数量则表明没有，跳转到登录页面
                if (count == userList.size()) {
                    // 转到登录页面并判断是不是越界查看
                    if (!requestPath.equals("")) {
                        request.setAttribute("tipsHeader", "<label style='color:red;'>请先登录!</label>");
                    }
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                }
            }
            // session没有并且cookie也没有则直接跳转到login.jsp
            else {
                // 转到登录页面并判断是不是越界查看
                if (!requestPath.equals("")) {
                    request.setAttribute("tipsHeader", "<label style='color:red;'>请先登录!</label>");
                }
                request.getRequestDispatcher("login.jsp").forward(request, response);
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
