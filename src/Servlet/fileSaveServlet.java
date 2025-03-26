package Servlet;

import DTO.File;
import DTO.User;
import Service.FileService;
import com.fasterxml.jackson.databind.ObjectMapper;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

// 定义 Servlet 名称和 URL 映射
@WebServlet(name = "fileSaveServlet", urlPatterns = "/fileSaveServlet")
// 支持文件上传
@MultipartConfig
public class fileSaveServlet extends HttpServlet {
    private int fileId; // 文件 ID，保存后由数据库返回

    // 处理 GET 请求，转发到 doPost
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    // 处理 POST 请求，核心文件上传逻辑
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        // 1.获取表单参数
        String fileTitle = request.getParameter("fileTitle");
        String fileIntroduction = request.getParameter("fileIntroduction");
        String mediaUrlsJson = request.getParameter("mediaUrls"); // 媒体 URL 的 JSON 字符串
        int fileOfClub = Integer.parseInt(request.getParameter("fileOfClub"));
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user"); // 从 session 获取当前用户
        Part file = request.getPart("file");
        FileService fileService = new FileService();

        // 2.计算文件大小并转换为人类可读格式
        String fileLength = humanReadableByteCount(file.getSize());
        String fileName = file.getSubmittedFileName(); // 获取原始文件名
        String ext = fileName.substring(fileName.lastIndexOf(".")); // 提取文件扩展名
        String UUIDFileName = UUID.randomUUID() + ext; // 生成唯一的随机文件名
        String dir = null; // 文件存储目录
        String fileType = null;

        // 3.根据文件扩展名分类存储路径和类型
        switch (ext.toLowerCase()) {
            // 图片类型
            case ".jpg":
            case ".png":
            case ".jpeg":
            case ".bmp":
            case ".gif":
            case ".webp":
                dir = getServletContext().getRealPath("/files/picture"); // 图片存储路径
                fileType = "picture";
                break;
            // 视频类型
            case ".mp4":
            case ".avi":
            case ".rmvb":
            case ".flv":
            case ".mov":
                dir = getServletContext().getRealPath("/files/video"); // 视频存储路径
                fileType = "video";
                break;
            // 压缩包类型
            case ".zip":
            case ".rar":
            case ".7z":
            case ".tar":
                dir = getServletContext().getRealPath("/files/packages"); // 压缩包存储路径
                fileType = "packages";
                break;
            // 办公文档类型
            case ".doc":
            case ".docx":
            case ".ppt":
            case ".pptx":
            case ".xls":
            case ".xlsx":
            case ".pdf":
            case ".txt":
                dir = getServletContext().getRealPath("/files/office"); // 文档存储路径
                fileType = "office";
                break;
            // 安装包类型
            case ".apk":
            case ".exe":
                dir = getServletContext().getRealPath("/files/executable"); // 可执行文件存储路径
                fileType = "executable";
                break;
            // 其他类型
            default:
                dir = getServletContext().getRealPath("/files/others"); // 其他文件存储路径
                fileType = "others";
                break;
        }

        // 4.创建 File 对象并保存到数据库
        File savedFile = new File(fileTitle, fileIntroduction, fileName, fileLength, fileType, fileOfClub, user.getUserId());
        fileId = fileService.saveFile(savedFile); // 保存文件信息到数据库，返回文件 ID
        // 判断Linux和Windows来进行操作
        String fileDownloadLink = dir.contains("/") ?
                dir.substring(dir.lastIndexOf("/", dir.lastIndexOf("/") - 1) + 1) + "/" + fileId + "/" + UUIDFileName :
                dir.substring(dir.lastIndexOf("\\", dir.lastIndexOf("\\") - 1) + 1) + "/" + fileId + "/" + UUIDFileName;
        String saveDir = dir + "/" + fileId; // 文件保存目录（带 ID）
        java.io.File directory = new java.io.File(saveDir);
        if (!directory.exists()) directory.mkdirs(); // 如果目录不存在，创建目录
        String savePath = saveDir + "/" + UUIDFileName; // 完整文件保存路径
        file.write(savePath); // 将文件写入服务器

        // 5.处理上传的媒体图片（mediaUrls）
        List<String> updatedMediaUrls = new ArrayList<>();
        if (mediaUrlsJson != null && !mediaUrlsJson.isEmpty()) {
            ObjectMapper mapper = new ObjectMapper();
            // 解析 JSON 字符串为 List<String>
            List<String> mediaUrls = mapper.readValue(mediaUrlsJson, mapper.getTypeFactory().constructCollectionType(List.class, String.class));
            for (String tempUrl : mediaUrls) {
                if (tempUrl.startsWith("files/temp/")) { // 如果是临时文件
                    String tempPath = getServletContext().getRealPath(tempUrl); // 临时文件路径
                    String fileNameInUrl = tempUrl.substring(tempUrl.lastIndexOf("/") + 1); // 提取文件名
                    String newDir = dir + "/" + fileId + "/desc_images"; // 新目录（描述图片）
                    java.io.File newDirFile = new java.io.File(newDir);
                    if (!newDirFile.exists()) newDirFile.mkdirs(); // 创建新目录
                    String newPath = newDir + "/" + fileNameInUrl; // 新文件路径
                    try {
                        Files.move(Paths.get(tempPath), Paths.get(newPath)); // 移动临时文件到新路径
                    } catch (IOException e) {
                        fileService.deleteFile(fileId, getServletContext().getRealPath("")); // 出错时回滚
                        throw new ServletException("图片移动失败: " + e.getMessage());
                    }
                    String newUrl = "files/" + fileType + "/" + fileId + "/desc_images/" + fileNameInUrl; // 更新 URL
                    updatedMediaUrls.add(newUrl);
                } else {
                    updatedMediaUrls.add(tempUrl); // 非临时文件直接添加
                }
            }
        }

        // 6.更新文件信息
        File reallSavedFile = fileService.checkFile(fileId); // 从数据库重新获取文件对象，因为一开始的File没有其他数据
        ObjectMapper mapper = new ObjectMapper();
        String updatedMediaUrlsJson = mapper.writeValueAsString(updatedMediaUrls); // 转换为 JSON 字符串
        if (updatedMediaUrlsJson.length() > 2555) { // 检查 JSON 长度限制
            fileService.deleteFile(fileId, getServletContext().getRealPath("")); // 回滚
            throw new ServletException("媒体 URL 超出长度限制 (2555 字符)");
        }
        reallSavedFile.setFileDownloadLink(fileDownloadLink); // 保存下载链接到File
        reallSavedFile.setMediaUrls(updatedMediaUrlsJson); // 保存媒体图片URL到File

        fileService.updateFile(reallSavedFile); // 更新数据库中的文件信息

        // 7.清理临时文件夹
        String tempDir = getServletContext().getRealPath("files/temp");
        java.io.File tempFolder = new java.io.File(tempDir);
        if (tempFolder.exists() && tempFolder.isDirectory()) {
            java.io.File[] tempFiles = tempFolder.listFiles();
            if (tempFiles != null) {
                for (java.io.File tempFile : tempFiles) {
                    if (tempFile.isFile()) tempFile.delete(); // 删除临时文件
                }
            }
        }

        // 8.设置提示信息并转发到提示页面
        String tips = fileId != -1 ? "<label style='color:green'>上传成功!</label>" : "<label style='color:red'>上传失败!</label>";
        String type = "fileSave";
        String address = "主页面";
        request.setAttribute("tips", tips);
        request.setAttribute("type", type);
        request.setAttribute("address", address);
        request.getRequestDispatcher("prompt.jsp").forward(request, response);
    }

    // 将字节数转换为人类可读格式（如 KB、MB）
    public static String humanReadableByteCount(long bytes) {
        int unit = 1024;
        if (bytes < unit) return bytes + " B"; // 小于 1KB 直接返回字节数
        int exp = (int) (Math.log(bytes) / Math.log(unit)); // 计算单位指数
        char pre = "KMGTPE".charAt(exp - 1); // 获取单位前缀（K、M、G 等）
        return String.format("%.2f %sB", bytes / Math.pow(unit, exp), pre); // 格式化输出
    }
}