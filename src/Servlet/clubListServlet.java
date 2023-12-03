package Servlet;

import DTO.Club;
import Service.ClubService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "clubListServlet", urlPatterns = "/clubListServlet")
public class clubListServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String web = request.getParameter("web");
        ClubService clubService = new ClubService();
        List<Club> clubList = clubService.listClub();
        request.setAttribute("clubList", clubList);
        request.getRequestDispatcher(web).forward(request, response);
    }
}
