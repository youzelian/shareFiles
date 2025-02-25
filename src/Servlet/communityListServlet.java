package Servlet;

import DTO.*;
import Service.ClubService;
import Service.FileService;
import Service.File_ClubService;
import Service.User_ClubService;
import utils.pageHelper;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "communityListServlet", urlPatterns = "/communityListServlet")
public class communityListServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String searchContent = request.getParameter("searchContent");
        FileService fileService = new FileService();
        List<File> fileList = null;
        // 2.1.接收客户端传递的页码(如果客户端没有传递页码，则默认页码为1，如果传递了则使用客户端传递的页码)
        String num = request.getParameter("pageNum");
        int pageNum = num == null ? 1 : Integer.parseInt(num);
        // 2.2.定义pageSize
        int pageSize = 5;
        // 调用fileService的函数进行分页查找所有文件，存储到pageHelper类型的对象中
        pageHelper<File> pages = fileService.listAllFilesByPage(pageNum, pageSize);

        // 3.转发到communityFiles.jsp
        if (searchContent != null) {
            // 如果是搜索传递，进行模糊搜索后将值替换pages中的list值，并通过传递fileList的个数更新pageCount(即总页数)
            fileList = fileService.fuzzyQueryFileByFileName(searchContent);
            pages.setList(fileList);
            // int pageCount = fileList.size() % pageSize == 0 ? fileList.size() / pageSize : fileList.size() / pageSize + 1;
            int pageCount = (fileList.size() + pageSize + 1) / pageSize;
            if (pageCount == 0) {
                pageCount = 1;
            }
            pages.setPageCount(pageCount);
        }
        request.setAttribute("pages", pages);
        request.getRequestDispatcher("community.jsp").forward(request, response);
    }
}
