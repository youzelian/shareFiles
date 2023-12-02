package Servlet;

import DAO.File_ClubDAO;
import DTO.File;
import DTO.File_Club;
import DTO.User;
import Service.FileService;
import Service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
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
        String fileNme = request.getParameter("fileName");
        String fileType = request.getParameter("fileType");
        String fileIntroduction = request.getParameter("fileIntroduction");
        int fileOfClub = Integer.parseInt(request.getParameter("fileOfClub"));
        
        // 2.接受并保存文件
        // 2.1重新赋名
        // a.获取后缀名
        Part file = request.getPart("file");
        String FileName = file.getSubmittedFileName();
        String ext = FileName.substring(FileName.lastIndexOf("."));
        // b.使用随机数重新赋名
        String filePath = UUID.randomUUID().toString() + ext;
        // 2.2根据后缀名获取该文件类型的目录在服务器上的路径
        String dir = null;
        switch (ext) {
            case ".jpg":
            case ".png":
            case ".jpeg":
            case ".BMP":
            case ".GIF":
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
        String savePath = dir + "\\" + filePath;
        // 2.3保存文件
        file.write(savePath);
        
        // 3.传递数据到数据库中
        FileService fileService = new FileService();
        String fileDownloadLink = "files/" + dir.substring(dir.lastIndexOf("\\") + 1) + "/" + filePath;
        boolean b = fileService.saveFile(new File(fileNme, fileType, fileDownloadLink, fileOfClub, fileIntroduction));
        // File_ClubDAO file_clubDAO = new File_ClubDAO();
        // file_clubDAO.insertFile_Club(new File_Club())
        
        // 4.跳转到提示页面然后跳转主页面，并显示提示信息
        String tips = b ? "<label style='color:green'>上传成功!</label>" : "<label style='color:red'>上传失败!</label>";
        String type = "fileSave";
        String address = "主页面";
        request.setAttribute("tips", tips);
        request.setAttribute("type", type);
        request.setAttribute("address", address);
        request.getRequestDispatcher("prompt.jsp").forward(request, response);
    }
}
