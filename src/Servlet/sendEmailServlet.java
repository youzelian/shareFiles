package Servlet;

import DTO.User;
import Service.UserService;
import com.google.gson.Gson;
import utils.ConfigUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Random;

// 定义Servlet的名称和URL映射
@WebServlet(name = "sendEmailServlet", urlPatterns = "/sendEmailServlet")
public class sendEmailServlet extends HttpServlet {
    // Resend API的常量配置
    private static final String RESEND_API_URL = "https://api.resend.com/emails";  // 邮件服务API地址
    private static final String API_KEY = ConfigUtil.getProperty("resend.api.key");  // 从配置文件获取API密钥
    private static final String FROM_EMAIL = ConfigUtil.getProperty("resend.from.email");  // 从配置文件获取发件人邮箱

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            request.setCharacterEncoding("utf-8");  // 设置请求编码为UTF-8
            System.out.println("Entering sendEmailServlet.doPost");

            // 获取请求参数
            String email = request.getParameter("email");  // 用户提交的邮箱
            String action = request.getParameter("action");  // 操作类型（register 或 resetPassword）
            System.out.println("Received email: " + email + ", action: " + action);

            // 验证邮箱是否为空
            if (email == null || email.trim().isEmpty()) {
                sendJsonResponse(response, false, "邮箱不能为空");  // 返回错误响应
                return;
            }

            // 使用正则表达式验证邮箱格式
            if (!email.matches("^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$")) {
                sendJsonResponse(response, false, "邮箱格式不正确，请输入类似 email@example.com 的格式");
                return;
            }

            // 检查发送频率（60秒内只能发送一次）
            Long lastSentTime = (Long) request.getSession().getAttribute("lastEmailSentTime");
            long currentTime = System.currentTimeMillis();
            if (lastSentTime != null && (currentTime - lastSentTime) < 60000) {
                sendJsonResponse(response, false, "发送过于频繁，请稍后再试");
                return;
            }

            // 检查邮箱是否存在
            UserService userService = new UserService();
            User user = userService.checkEmail(email);
            System.out.println("User check result: " + (user != null ? "User exists" : "User does not exist"));

            // 根据action参数处理不同场景
            if ("register".equals(action)) {
                // 注册场景：如果邮箱已存在，返回错误
                if (user != null) {
                    sendJsonResponse(response, false, "邮箱已被注册");
                    return;
                }
            } else if ("resetPassword".equals(action)) {
                // 重置密码场景：如果邮箱不存在，返回错误
                if (user == null) {
                    sendJsonResponse(response, false, "不存在该邮箱");
                    return;
                }
            } else {
                // 默认按注册处理
                if (user != null) {
                    sendJsonResponse(response, false, "邮箱已被注册");
                    return;
                }
            }

            // 生成6位随机验证码
            String code = String.format("%06d", new Random().nextInt(999999));
            // 将验证码和时间戳存入session
            request.getSession().setAttribute("emailCode", code);
            request.getSession().setAttribute("emailCodeTimestamp", currentTime);
            request.getSession().setAttribute("lastEmailSentTime", currentTime);
            System.out.println("Generated code: " + code);

            // 检查API配置是否完整
            if (API_KEY == null || FROM_EMAIL == null) {
                sendJsonResponse(response, false, "API Key 或发件人邮箱未配置");
                return;
            }
            // 根据 user 是否存在获取称呼
            String userName = (user != null && user.getUserName() != null) ? user.getUserName() : "用户";
            String greeting = "尊敬的" + userName;
            // 构造邮件请求的JSON数据
            String htmlContent = "<!DOCTYPE html>" +
                    "<html>" +
                    "<head>" +
                    "<meta charset=\"UTF-8\">" +
                    "<style>" +
                    "body { font-family: Arial, sans-serif; color: #333; line-height: 1.6; }" +
                    ".container { max-width: 600px; margin: 0 auto; padding: 20px; background-color: #f9f9f9; border-radius: 8px; }" +
                    ".header { background-color: #007bff; color: white; padding: 10px; text-align: center; border-radius: 8px 8px 0 0; }" +
                    ".content { padding: 20px; background-color: white; border-radius: 0 0 8px 8px; }" +
                    ".code { font-size: 24px; font-weight: bold; color: #007bff; text-align: center; margin: 20px 0; }" +
                    ".footer { font-size: 12px; color: #777; text-align: center; margin-top: 20px; }" +
                    "</style>" +
                    "</head>" +
                    "<body>" +
                    "<div class=\"container\">" +
                    "<div class=\"header\">" +
                    "<h2>邮箱验证码</h2>" +
                    "</div>" +
                    "<div class=\"content\">" +
                    "<p>" + greeting + "，您好：</p>" +
                    "<p>您正在进行" + ("register".equals(action) ? "账户注册" : "密码重置") + "操作，请使用以下验证码完成验证：</p>" +
                    "<div class=\"code\">" + code + "</div>" +
                    "<p>此验证码在 <strong>10分钟</strong> 内有效，请尽快使用。如非本人操作，请忽略此邮件。</p>" +
                    "</div>" +
                    "<div class=\"footer\">" +
                    "<p>此邮件由系统自动发送，请勿回复。<br>如需帮助，请联系我们的支持团队：1431850082@qq.com</p>" +
                    "</div>" +
                    "</div>" +
                    "</body>" +
                    "</html>";
            String json = new Gson().toJson(new EmailRequest(FROM_EMAIL, email, "邮箱验证码", htmlContent));
            System.out.println("Request JSON: " + json);

            // 使用HttpURLConnection发送邮件请求
            System.out.println("Sending request using HttpURLConnection...");
            try {
                URL url = new URL(RESEND_API_URL);
                HttpURLConnection conn = (HttpURLConnection) url.openConnection();
                conn.setRequestMethod("POST");
                conn.setRequestProperty("Authorization", "Bearer " + API_KEY);  // 设置API认证
                conn.setRequestProperty("Content-Type", "application/json");  // 设置内容类型
                conn.setDoOutput(true);  // 允许输出
                conn.setConnectTimeout(10000);  // 设置连接超时10秒
                conn.setReadTimeout(10000);  // 设置读取超时10秒

                // 发送JSON请求体
                try (OutputStream os = conn.getOutputStream()) {
                    byte[] input = json.getBytes("utf-8");
                    os.write(input, 0, input.length);
                }

                // 获取响应状态码
                int responseCode = conn.getResponseCode();
                System.out.println("HttpURLConnection response code: " + responseCode);
                StringBuilder responseBody = new StringBuilder();
                // 根据状态码读取响应或错误流
                try (BufferedReader br = new BufferedReader(
                        new InputStreamReader(
                                responseCode >= 400 ? conn.getErrorStream() : conn.getInputStream(), "utf-8"))) {
                    String line;
                    while ((line = br.readLine()) != null) {
                        responseBody.append(line);
                    }
                }
                System.out.println("HttpURLConnection response body: " + responseBody);

                // 根据响应状态返回结果
                if (responseCode >= 200 && responseCode < 300) {
                    sendJsonResponse(response, true, "验证码已发送");
                } else {
                    sendJsonResponse(response, false, "发送失败: " + responseBody);
                }
            } catch (Exception e) {
                e.printStackTrace();
                sendJsonResponse(response, false, "发送请求失败: " + e.getMessage());
            }
        } catch (Exception e) {
            e.printStackTrace();
            sendJsonResponse(response, false, "服务器错误: " + e.getMessage());
        }
    }

    // 发送JSON格式的响应给前端
    private void sendJsonResponse(HttpServletResponse response, boolean success, String message) throws IOException {
        System.out.println("Response: success=" + success + ", message=" + message);
        response.setContentType("application/json;charset=utf-8");  // 设置响应类型为JSON
        PrintWriter out = response.getWriter();
        out.println(new Gson().toJson(new ResponseData(success, message)));  // 序列化为JSON并输出
        out.flush();
        out.close();
    }

    // 邮件请求的数据结构
    static class EmailRequest {
        String from;  // 发件人
        String to;    // 收件人
        String subject;  // 邮件主题
        String html;     // 邮件内容（HTML格式）

        EmailRequest(String from, String to, String subject, String html) {
            this.from = from;
            this.to = to;
            this.subject = subject;
            this.html = html;
        }
    }

    // 响应数据结构
    static class ResponseData {
        boolean success;  // 操作是否成功
        String message;   // 返回消息

        ResponseData(boolean success, String message) {
            this.success = success;
            this.message = message;
        }
    }
}