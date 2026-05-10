package com.placement.servlets;

import com.placement.dao.ApplicationDAO;
import com.placement.dao.DriveDAO;
import com.placement.dao.StudentDAO;
import com.placement.models.Application;
import com.placement.models.Drive;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import com.placement.utils.DBConnection;

@WebServlet("/admin/reports")
public class AdminReportServlet extends HttpServlet {

    private ApplicationDAO applicationDAO;
    private DriveDAO driveDAO;

    @Override
    public void init() throws ServletException {
        applicationDAO = new ApplicationDAO();
        driveDAO = new DriveDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String type = request.getParameter("type");
        String format = request.getParameter("format");
        
        if ("placements".equals(type)) {
            List<Application> placements = getDetailedPlacements();
            if ("csv".equals(format)) {
                exportPlacementsCSV(response, placements);
                return;
            }
            request.setAttribute("reportData", placements);
            request.setAttribute("reportType", "Placements");
        } else if ("drives".equals(type)) {
            List<Drive> drives = driveDAO.getAllDrives();
            if ("csv".equals(format)) {
                exportDrivesCSV(response, drives);
                return;
            }
            request.setAttribute("reportData", drives);
            request.setAttribute("reportType", "Drives");
        } else {
            Map<String, Integer> deptStats = getDepartmentPlacementStats();
            request.setAttribute("deptStats", deptStats);
        }

        request.getRequestDispatcher("/admin_reports.jsp").forward(request, response);
    }

    private void exportPlacementsCSV(HttpServletResponse response, List<Application> data) throws IOException {
        response.setContentType("text/csv");
        response.setHeader("Content-Disposition", "attachment; filename=placement_report.csv");
        
        StringBuilder csv = new StringBuilder();
        csv.append("\"ID\",\"Student Name\",\"Department\",\"Email\",\"Job Role\",\"Company\",\"Applied At\"\n");
        for (Application app : data) {
            csv.append("\"").append(app.getId()).append("\",")
               .append("\"").append(app.getStudentName()).append("\",")
               .append("\"").append(app.getStudentDepartment()).append("\",")
               .append("\"").append(app.getStudentEmail()).append("\",")
               .append("\"").append(app.getJobRole()).append("\",")
               .append("\"").append(app.getCompanyName()).append("\",")
               .append("\"").append(app.getAppliedAt()).append("\"\n");
        }
        response.getWriter().write(csv.toString());
    }

    private void exportDrivesCSV(HttpServletResponse response, List<Drive> data) throws IOException {
        response.setContentType("text/csv");
        response.setHeader("Content-Disposition", "attachment; filename=drives_report.csv");
        
        StringBuilder csv = new StringBuilder();
        csv.append("\"ID\",\"Job Role\",\"Package (LPA)\",\"CGPA Req\",\"Branch Req\",\"Date\",\"Status\"\n");
        for (Drive drive : data) {
            csv.append("\"").append(drive.getId()).append("\",")
               .append("\"").append(drive.getJobRole()).append("\",")
               .append("\"").append(drive.getPackageLpa()).append("\",")
               .append("\"").append(drive.getCgpaReq()).append("\",")
               .append("\"").append(drive.getBranchReq()).append("\",")
               .append("\"").append(drive.getDriveDate()).append("\",")
               .append("\"").append(drive.getStatus()).append("\"\n");
        }
        response.getWriter().write(csv.toString());
    }


    private List<Application> getDetailedPlacements() {
        List<Application> placements = new ArrayList<>();
        String sql = "SELECT a.*, s.full_name, s.department, s.email, d.job_role, c.company_name " +
                     "FROM applications a " +
                     "JOIN students s ON a.student_id = s.user_id " +
                     "JOIN drives d ON a.drive_id = d.id " +
                     "JOIN companies c ON d.company_id = c.user_id " +
                     "WHERE a.status = 'SELECTED' " +
                     "ORDER BY a.applied_at DESC";
                     
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                Application app = new Application();
                app.setId(rs.getInt("id"));
                app.setStudentName(rs.getString("full_name"));
                app.setStudentDepartment(rs.getString("department"));
                app.setStudentEmail(rs.getString("email"));
                app.setJobRole(rs.getString("job_role"));
                app.setCompanyName(rs.getString("company_name"));
                app.setAppliedAt(rs.getTimestamp("applied_at"));
                placements.add(app);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return placements;
    }

    private Map<String, Integer> getDepartmentPlacementStats() {
        Map<String, Integer> stats = new HashMap<>();
        String sql = "SELECT department, COUNT(*) as count FROM students s " +
                     "JOIN applications a ON s.user_id = a.student_id " +
                     "WHERE a.status = 'SELECTED' " +
                     "GROUP BY department";
                     
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                stats.put(rs.getString("department"), rs.getInt("count"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return stats;
    }
}
