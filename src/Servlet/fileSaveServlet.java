package Servlet;

import DTO.File;
import DTO.User;
import Service.FileService;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.UUID;

@WebServlet(name = "fileSaveServlet", urlPatterns = "/fileSaveServlet")
@MultipartConfig
public class fileSaveServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1.接受请求
        request.setCharacterEncoding("utf-8");
        String fileTitle = request.getParameter("fileTitle");
        String fileType = "图片";
        String fileIntroduction = request.getParameter("fileIntroduction");
        int fileOfClub = Integer.parseInt(request.getParameter("fileOfClub"));
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        // 2.接受并保存文件
        // 2.1获取文件名后重新赋名存入
        // 2.1.1获取文件大小
        Part file = request.getPart("file");
        String fileLength = humanReadableByteCount(file.getSize());
        // 2.1.2获取后缀名
        String fileName = file.getSubmittedFileName();
        String ext = fileName.substring(fileName.lastIndexOf("."));
        // 2.1.3使用随机数重新赋名
        String filePath = UUID.randomUUID() + ext;
        // 2.2根据后缀名获取该文件类型的目录在服务器上的路径
        String dir = null;
        switch (ext) {
            case ".jpg":
            case ".png":
            case ".jpeg":
            case ".BMP":
            case ".GIF":
            case ".webp":
                dir = getServletContext().getRealPath("/files/picture");
                break;
            case ".MP4":
            case ".AVI":
            case ".rmvb":
            case ".flv":
            case ".MOV":
                dir = getServletContext().getRealPath("/files/video");
                break;
            case ".exe":
                dir = getServletContext().getRealPath("/files/exe");
                break;
            case ".apk":
                dir = getServletContext().getRealPath("/files/apk");
                break;
            case ".pdf":
                dir = getServletContext().getRealPath("/files/pdf");
                break;
            case ".ppt":
                dir = getServletContext().getRealPath("/files/ppt");
                break;
            case ".zip":
            case ".rar":
            case ".7z":
            case ".tar":
                dir = getServletContext().getRealPath("/files/packages");
                break;
        }
        // 在Linux中和Windows中都可以通过/或者\保存，为了方便取'/‘
        String savePath = dir + "/" + filePath;
        // 2.3保存文件
        file.write(savePath);

        // 3.传递数据到数据库中
        FileService fileService = new FileService();
        String fileDownloadLink;
        // 根据路径分隔符判断程序是否运行在Linux上则，如果不是则...
        if (dir.contains("/")) {
            // a. linux路径是用/隔开，正则表达式中'/'是用一个'/'表示
            fileDownloadLink = dir.substring(dir.lastIndexOf("/", dir.lastIndexOf("/") - 1) + 1) + "/" + filePath;
        } else {
            // b. windows路径是用\隔开，正则表达式中'\'是用两个'\'表示
            fileDownloadLink = dir.substring(dir.lastIndexOf("\\", dir.lastIndexOf("\\") - 1) + 1) + "/" + filePath;
        }

        boolean b = fileService.saveFile(new File(fileTitle, fileIntroduction,fileName, fileLength, fileType, fileDownloadLink, fileOfClub, user.getUserId()));

        // 4.跳转到提示页面然后跳转主页面，并显示提示信息
        String tips = b ? "<label style='color:green'>上传成功!</label>" : "<label style='color:red'>上传失败!</label>";
        String type = "fileSave";
        String address = "主页面";
        request.setAttribute("tips", tips);
        request.setAttribute("type", type);
        request.setAttribute("address", address);
        request.getRequestDispatcher("prompt.jsp").forward(request, response);
    }

    // 将字节转换为人类可读的格式
    public static String humanReadableByteCount(long bytes) {
        int unit = 1024;
        if (bytes < unit)
            return bytes + " B";
        int exp = (int) (Math.log(bytes) / Math.log(unit));
        char pre = "KMGTPE".charAt(exp - 1);
        return String.format("%.2f %sB", bytes / Math.pow(unit, exp), pre);
    }
}

