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

@WebServlet(name = "fileSaveServlet", urlPatterns = "/fileSaveServlet")
@MultipartConfig
public class fileSaveServlet extends HttpServlet {
    private int fileId;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        String fileTitle = request.getParameter("fileTitle");
        String fileIntroduction = request.getParameter("fileIntroduction");
        String mediaUrlsJson = request.getParameter("mediaUrls");
        int fileOfClub = Integer.parseInt(request.getParameter("fileOfClub"));
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        Part file = request.getPart("file");
        FileService fileService = new FileService();

        String fileLength = humanReadableByteCount(file.getSize());
        String fileName = file.getSubmittedFileName();
        String ext = fileName.substring(fileName.lastIndexOf("."));
        String filePath = UUID.randomUUID() + ext;
        String dir = null;
        String fileType = null;

        switch (ext.toLowerCase()) {
            // 图片
            case ".jpg":
            case ".png":
            case ".jpeg":
            case ".bmp":
            case ".gif":
            case ".webp":
                dir = getServletContext().getRealPath("/files/picture");
                fileType = "picture";
                break;
            // 视频
            case ".mp4":
            case ".avi":
            case ".rmvb":
            case ".flv":
            case ".mov":
                dir = getServletContext().getRealPath("/files/video");
                fileType = "video";
                break;
            // 压缩包
            case ".zip":
            case ".rar":
            case ".7z":
            case ".tar":
                dir = getServletContext().getRealPath("/files/packages");
                fileType = "packages";
                break;
            // 办公文档
            case ".doc":
            case ".docx":
            case ".ppt":
            case ".pptx":
            case ".xls":
            case ".xlsx":
            case ".pdf":
            case ".txt":
                dir = getServletContext().getRealPath("/files/office");
                fileType = "office";
                break;
            // 安装包
            case ".apk":
            case ".exe":
                dir = getServletContext().getRealPath("/files/executable");
                fileType = "executable";
                break;
            // 其他
            default:
                dir = getServletContext().getRealPath("/files/others");
                fileType = "others";
                break;
        }

        File savedFile = new File(fileTitle, fileIntroduction, fileName, fileLength, fileType, fileOfClub, user.getUserId());
        fileId = fileService.saveFile(savedFile);

        String fileDownloadLink = dir.contains("/") ?
                dir.substring(dir.lastIndexOf("/", dir.lastIndexOf("/") - 1) + 1) + "/" + fileId + "/" + filePath :
                dir.substring(dir.lastIndexOf("\\", dir.lastIndexOf("\\") - 1) + 1) + "/" + fileId + "/" + filePath;
        String saveDir = dir + "/" + fileId;
        java.io.File directory = new java.io.File(saveDir);
        if (!directory.exists()) directory.mkdirs();
        String savePath = saveDir + "/" + filePath;
        file.write(savePath);

        List<String> updatedMediaUrls = new ArrayList<>();
        if (mediaUrlsJson != null && !mediaUrlsJson.isEmpty()) {
            ObjectMapper mapper = new ObjectMapper();
            List<String> mediaUrls = mapper.readValue(mediaUrlsJson, mapper.getTypeFactory().constructCollectionType(List.class, String.class));
            for (String tempUrl : mediaUrls) {
                if (tempUrl.startsWith("files/temp/")) {
                    String tempPath = getServletContext().getRealPath(tempUrl);
                    String fileNameInUrl = tempUrl.substring(tempUrl.lastIndexOf("/") + 1);
                    String newDir = dir + "/" + fileId + "/desc_images";
                    java.io.File newDirFile = new java.io.File(newDir);
                    if (!newDirFile.exists()) newDirFile.mkdirs();
                    String newPath = newDir + "/" + fileNameInUrl;
                    try {
                        Files.move(Paths.get(tempPath), Paths.get(newPath));
                    } catch (IOException e) {
                        fileService.deleteFile(fileId, getServletContext().getRealPath("")); // 回滚
                        throw new ServletException("图片移动失败: " + e.getMessage());
                    }
                    String newUrl = "files/" + fileType + "/" + fileId + "/desc_images/" + fileNameInUrl;
                    updatedMediaUrls.add(newUrl);
                } else {
                    updatedMediaUrls.add(tempUrl);
                }
            }
        }

        File reallSavedFile = fileService.checkFile(fileId);
        ObjectMapper mapper = new ObjectMapper();
        String updatedMediaUrlsJson = mapper.writeValueAsString(updatedMediaUrls);
        if (updatedMediaUrlsJson.length() > 2555) {
            fileService.deleteFile(fileId, getServletContext().getRealPath("")); // 回滚
            throw new ServletException("媒体 URL 超出长度限制 (2555 字符)");
        }
        reallSavedFile.setFileDownloadLink(fileDownloadLink);
        reallSavedFile.setMediaUrls(updatedMediaUrlsJson);

        fileService.updateFile(reallSavedFile);

        String tempDir = getServletContext().getRealPath("files/temp");
        java.io.File tempFolder = new java.io.File(tempDir);
        if (tempFolder.exists() && tempFolder.isDirectory()) {
            java.io.File[] tempFiles = tempFolder.listFiles();
            if (tempFiles != null) {
                for (java.io.File tempFile : tempFiles) {
                    if (tempFile.isFile()) tempFile.delete();
                }
            }
        }

        String tips = fileId != -1 ? "<label style='color:green'>上传成功!</label>" : "<label style='color:red'>上传失败!</label>";
        String type = "fileSave";
        String address = "主页面";
        request.setAttribute("tips", tips);
        request.setAttribute("type", type);
        request.setAttribute("address", address);
        request.getRequestDispatcher("prompt.jsp").forward(request, response);
    }

    public static String humanReadableByteCount(long bytes) {
        int unit = 1024;
        if (bytes < unit) return bytes + " B";
        int exp = (int) (Math.log(bytes) / Math.log(unit));
        char pre = "KMGTPE".charAt(exp - 1);
        return String.format("%.2f %sB", bytes / Math.pow(unit, exp), pre);
    }
}