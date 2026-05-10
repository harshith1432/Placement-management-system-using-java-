package com.placement.servlets;

import com.placement.dao.DriveDAO;
import com.placement.dao.StatsDAO;
import com.placement.models.Drive;
import com.placement.models.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet {

    private StatsDAO statsDAO;
    private DriveDAO driveDAO;
    private com.placement.dao.ApplicationDAO applicationDAO;

    @Override
    public void init() throws ServletException {
        statsDAO = new StatsDAO();
        driveDAO = new DriveDAO();
        applicationDAO = new com.placement.dao.ApplicationDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = session != null ? (User) session.getAttribute("user") : null;
        if (user == null || !"ADMIN".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // Fetch stats
        request.setAttribute("totalStudents", statsDAO.getTotalStudents());
        request.setAttribute("totalCompanies", statsDAO.getTotalCompanies());
        request.setAttribute("activeDrives", statsDAO.getActiveDrives());
        request.setAttribute("totalPlacements", statsDAO.getTotalPlacements());

        // Fetch recent drives (for simplicity we just get all active drives here)
        List<Drive> recentDrives = driveDAO.getAllActiveDrives();
        request.setAttribute("recentDrives", recentDrives);

        // Fetch placement progress (who is selected where)
        request.setAttribute("placementProgress", applicationDAO.getPlacementProgress());

        request.getRequestDispatcher("admin_dashboard.jsp").forward(request, response);
    }
}
