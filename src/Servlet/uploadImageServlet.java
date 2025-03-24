package Servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.util.UUID;

@WebServlet(name = "uploadImageServlet", urlPatterns = "/uploadImageServlet")
@MultipartConfig
public class uploadImageServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            // 获取上传的图片
            Part imagePart = request.getPart("image");
            String fileName = imagePart.getSubmittedFileName();
            String ext = fileName.substring(fileName.lastIndexOf("."));
            String newFileName = UUID.randomUUID() + ext;

            // 保存图片到服务器
            String dir = getServletContext().getRealPath("files/temp"); // 保存到 files/temp/
            File directory = new File(dir);
            if (!directory.exists()) {
                directory.mkdirs();
            }
            String savePath = dir + "/" + newFileName;
            imagePart.write(savePath);

            // 返回图片 URL
            String imageUrl = "files/temp/" + newFileName;
            String jsonResponse = "{\"success\": true, \"imageUrl\": \"" + imageUrl + "\"}";
            response.getWriter().write(jsonResponse);
        } catch (Exception e) {
            String jsonResponse = "{\"success\": false, \"message\": \"上传失败: " + e.getMessage() + "\"}";
            response.getWriter().write(jsonResponse);
        }
    }
}