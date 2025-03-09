package Servlet;

import DTO.File;
import DTO.User;
import Service.FileService;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@WebServlet(name = "fileSaveServlet", urlPatterns = "/fileSaveServlet")
@MultipartConfig
public class fileSaveServlet extends HttpServlet {
    private int fileId; // 用于存储 fileId，以便在 processImages 中使用

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1.接收请求并创建函数
        request.setCharacterEncoding("utf-8");
        String fileTitle = request.getParameter("fileTitle");
        String fileType = null;
        String fileIntroduction = request.getParameter("fileIntroduction");
        int fileOfClub = Integer.parseInt(request.getParameter("fileOfClub"));
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        Part file = request.getPart("file");
        FileService fileService = new FileService();

        // 2.对文件进行类型判断并重新赋值
        String fileLength = humanReadableByteCount(file.getSize());
        String fileName = file.getSubmittedFileName();
        // 获取后缀名ext
        String ext = fileName.substring(fileName.lastIndexOf("."));
        // 使用随机数重新赋名
        String filePath = UUID.randomUUID() + ext;
        String dir = null;
        // 2.1通过后缀名来判断文件的类型
        switch (ext) {
            case ".jpg":
            case ".png":
            case ".jpeg":
            case ".BMP":
            case ".GIF":
            case ".webp":
                dir = getServletContext().getRealPath("/files/picture");
                fileType = "图片";
                break;
            case ".MP4":
            case ".AVI":
            case ".rmvb":
            case ".flv":
            case ".MOV":
                fileType = "视频";
                dir = getServletContext().getRealPath("/files/video");
                break;
            case ".exe":
                fileType = "exe文件";
                dir = getServletContext().getRealPath("/files/exe");
                break;
            case ".apk":
                fileType = "apl文件";
                dir = getServletContext().getRealPath("/files/apk");
                break;
            case ".pdf":
                fileType = "pdf";
                dir = getServletContext().getRealPath("/files/pdf");
                break;
            case ".ppt":
                fileType = "ppt";
                dir = getServletContext().getRealPath("/files/ppt");
                break;
            case ".zip":
            case ".rar":
            case ".7z":
            case ".tar":
                fileType = "压缩包";
                dir = getServletContext().getRealPath("/files/packages");
                break;
        }
        // 2.2第一次保存到数据库
        File savedFile = new File(fileTitle, fileIntroduction, fileName, fileLength, fileType, fileOfClub, user.getUserId());

        // 3.存储到文件路径中
        // 通过saveFile返回自动生成的主键ID
        fileId = fileService.saveFile(savedFile);
        String fileDownloadLink;
        // 3.1根据路径分隔符判断程序是否运行在Linux上则，如果不是则...
        if (dir.contains("/")) {
            // a. linux路径是用/隔开，正则表达式中'/'是用一个'/'表示
            fileDownloadLink = dir.substring(dir.lastIndexOf("/", dir.lastIndexOf("/") - 1) + 1) + "/" + fileId + "/" + filePath;
        } else {
            // b. windows路径是用\隔开，正则表达式中'\'是用两个'\'表示
            fileDownloadLink = dir.substring(dir.lastIndexOf("\\", dir.lastIndexOf("\\") - 1) + 1) + "/" + fileId + "/" + filePath;
        }
        File reallSavedFile = fileService.checkFile(fileId);
        // 3.2插入文件下载路径
        reallSavedFile.setFileDownloadLink(fileDownloadLink);
        // 3.3根据主键ID自动创建一个名为主键ID的文件夹，将所有内容存入其中
        String saveDir = dir + "/" + fileId;
        java.io.File directory = new java.io.File(saveDir);
        if (!directory.exists()) {
            directory.mkdirs();
        }
        // 在Linux中和Windows中都可以通过/或者\保存，为了方便取'/‘
        String savePath = saveDir + "/" + filePath;
        // 3.4保存文件到savePath路径中
        file.write(savePath);

        // 4.处理文件描述中的图片,取出内容中的图片路径
        String updatedIntroduction = processImages(fileIntroduction, dir);
        // 插入文件下载路径
        reallSavedFile.setFileIntroduction(updatedIntroduction);

        // 5.更新文件描述到数据库，最后一次保存到数据库中
        fileService.updateFile(reallSavedFile);

        // 6.删除临时图片
        String tempDir = getServletContext().getRealPath("files/temp");
        java.io.File tempFolder = new java.io.File(tempDir);
        if (tempFolder.exists() && tempFolder.isDirectory()) {
            java.io.File[] tempFiles = tempFolder.listFiles();
            if (tempFiles != null) {
                for (java.io.File tempFile : tempFiles) {
                    if (tempFile.isFile()) {
                        tempFile.delete();
                    }
                }
            }
        }

        // 7.跳转提示页面
        String tips = fileId != -1 ? "<label style='color:green'>上传成功!</label>" : "<label style='color:red'>上传失败!</label>";
        String type = "fileSave";
        String address = "主页面";
        request.setAttribute("tips", tips);
        request.setAttribute("type", type);
        request.setAttribute("address", address);
        request.getRequestDispatcher("prompt.jsp").forward(request, response);
    }

    // 处理图片，将临时图片移动到 files/fileType/{fileId}/desc_images/
    private String processImages(String introduction, String pictureDir) throws IOException {
        Pattern pattern = Pattern.compile("\\[img](.*?)\\[/img]");
        Matcher matcher = pattern.matcher(introduction);
        // 由于需要大量对字符串进行修改所以使用StringBuilder，类似字符串数组
        StringBuilder updatedText = new StringBuilder();
        int lastEnd = 0;

        while (matcher.find()) {
            String tempUrl = matcher.group(1); // 提取 [img] 内的路径
            updatedText.append(introduction, lastEnd, matcher.start());

            if (tempUrl.startsWith("files/temp/")) {
                String tempPath = getServletContext().getRealPath(tempUrl); // 临时文件真实路径
                String fileName = tempUrl.substring(tempUrl.lastIndexOf("/") + 1); // 提取文件名
                String newDir = pictureDir + "/" + fileId + "/desc_images"; // 目标目录
                java.io.File newDirFile = new java.io.File(newDir);
                if (!newDirFile.exists()) {
                    newDirFile.mkdirs(); // 创建目录
                }
                String newPath = newDir + "/" + fileName; // 目标文件路径
                Files.move(Paths.get(tempPath), Paths.get(newPath)); // 移动文件
                // 提取图片的src路径
                // 使用正则表达式匹配目标部分（目的为了处理Linux和Windows不同格式的路径
                String regex = "(files[\\\\/]picture[\\\\/]\\d+[\\\\/]desc_images[\\\\/][^\\\\/]+\\.jpg)";
                Pattern patternSrc = Pattern.compile(regex);
                Matcher matcherSrc = patternSrc.matcher(newPath);
                String newUrl = null;
                if (matcherSrc.find()) {
                    newUrl = matcherSrc.group(1); // 这里取到的路径类似于是files/fileType/fileId/desc_images/随机uuid.jpg
                }
                updatedText.append("[img]").append(newUrl).append("[/img]");
            } else {
                updatedText.append(matcher.group(0)); // 未处理的路径保持原样
            }
            lastEnd = matcher.end();
        }
        updatedText.append(introduction.substring(lastEnd));
        return updatedText.toString();
    }

    // 将占用的内存解析成人类可读的形式
    public static String humanReadableByteCount(long bytes) {
        int unit = 1024;
        if (bytes < unit) return bytes + " B";
        int exp = (int) (Math.log(bytes) / Math.log(unit));
        char pre = "KMGTPE".charAt(exp - 1);
        return String.format("%.2f %sB", bytes / Math.pow(unit, exp), pre);
    }
}