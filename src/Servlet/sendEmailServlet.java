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

@WebServlet(name = "sendEmailServlet", urlPatterns = "/sendEmailServlet")
public class sendEmailServlet extends HttpServlet {
    private static final String RESEND_API_URL = "https://api.resend.com/emails";
    private static final String API_KEY = ConfigUtil.getProperty("resend.api.key");
    private static final String FROM_EMAIL = ConfigUtil.getProperty("resend.from.email");

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            request.setCharacterEncoding("utf-8");
            System.out.println("Entering sendEmailServlet.doPost");

            String email = request.getParameter("email");
            System.out.println("Received email: " + email);

            // 校验邮箱是否为空
            if (email == null || email.trim().isEmpty()) {
                sendJsonResponse(response, false, "邮箱不能为空");
                return;
            }

            // 校验邮箱格式
            if (!email.matches("^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$")) {
                sendJsonResponse(response, false, "邮箱格式不正确，请输入类似 email@example.com 的格式");
                return;
            }

            // 检查是否可以发送（60秒限制）
            Long lastSentTime = (Long) request.getSession().getAttribute("lastEmailSentTime");
            long currentTime = System.currentTimeMillis();
            if (lastSentTime != null && (currentTime - lastSentTime) < 60000) {
                sendJsonResponse(response, false, "发送过于频繁，请稍后再试");
                return;
            }

            UserService userService = new UserService();
            User user = userService.checkEmail(email);
            System.out.println("User check result: " + (user != null ? "User exists" : "User does not exist"));
            if (user != null) {
                sendJsonResponse(response, false, "邮箱已被注册");
                return;
            }

            String code = String.format("%06d", new Random().nextInt(999999));
            request.getSession().setAttribute("emailCode", code);
            request.getSession().setAttribute("emailCodeTimestamp", currentTime);
            request.getSession().setAttribute("lastEmailSentTime", currentTime);
            System.out.println("Generated code: " + code);

            if (API_KEY == null || FROM_EMAIL == null) {
                sendJsonResponse(response, false, "API Key 或发件人邮箱未配置");
                return;
            }

            // 使用 Gson 构造请求体
            String json = new Gson().toJson(new EmailRequest(FROM_EMAIL, email, "邮箱验证码", "您的验证码是: " + code));
            System.out.println("Request JSON: " + json);

            // 使用 HttpURLConnection 发送请求
            System.out.println("Sending request using HttpURLConnection...");
            try {
                URL url = new URL(RESEND_API_URL);
                HttpURLConnection conn = (HttpURLConnection) url.openConnection();
                conn.setRequestMethod("POST");
                conn.setRequestProperty("Authorization", "Bearer " + API_KEY);
                conn.setRequestProperty("Content-Type", "application/json");
                conn.setDoOutput(true);
                conn.setConnectTimeout(10000);
                conn.setReadTimeout(10000);

                // 发送请求体
                try (OutputStream os = conn.getOutputStream()) {
                    byte[] input = json.getBytes("utf-8");
                    os.write(input, 0, input.length);
                }

                // 获取响应
                int responseCode = conn.getResponseCode();
                System.out.println("HttpURLConnection response code: " + responseCode);
                StringBuilder responseBody = new StringBuilder();
                try (BufferedReader br = new BufferedReader(
                        new InputStreamReader(
                                responseCode >= 400 ? conn.getErrorStream() : conn.getInputStream(), "utf-8"))) {
                    String line;
                    while ((line = br.readLine()) != null) {
                        responseBody.append(line);
                    }
                }
                System.out.println("HttpURLConnection response body: " + responseBody);

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

    private void sendJsonResponse(HttpServletResponse response, boolean success, String message) throws IOException {
        System.out.println("Response: success=" + success + ", message=" + message);
        response.setContentType("application/json;charset=utf-8");
        PrintWriter out = response.getWriter();
        out.println(new Gson().toJson(new ResponseData(success, message)));
        out.flush();
        out.close();
    }

    static class EmailRequest {
        String from;
        String to;
        String subject;
        String html;

        EmailRequest(String from, String to, String subject, String html) {
            this.from = from;
            this.to = to;
            this.subject = subject;
            this.html = html;
        }
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