package com.placement.servlets;

import com.placement.dao.DriveDAO;
import com.placement.dao.CompanyDAO;
import com.placement.dao.DepartmentDAO;
import com.placement.models.Drive;
import com.placement.models.Company;
import com.placement.models.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet("/admin/drives")
public class AdminDriveServlet extends HttpServlet {
    private DriveDAO driveDAO = new DriveDAO();
    private CompanyDAO companyDAO = new CompanyDAO();
    private DepartmentDAO departmentDAO = new DepartmentDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null || !"ADMIN".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        List<Drive> drives = driveDAO.getAllDrives();
        List<Company> companies = companyDAO.getAllCompanies();
        List<String> departments = departmentDAO.getAllDepartmentNames();
        
        request.setAttribute("drives", drives);
        request.setAttribute("companies", companies);
        request.setAttribute("departments", departments);
        request.getRequestDispatcher("/admin_drives.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User admin = (User) session.getAttribute("user");
        if (admin == null || !"ADMIN".equals(admin.getRole())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        String action = request.getParameter("action");
        if ("add".equals(action)) {
            addDrive(request, response);
        } else if ("edit".equals(action)) {
            editDrive(request, response);
        } else if ("delete".equals(action)) {
            deleteDrive(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/drives");
        }
    }

    private void addDrive(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int companyId = Integer.parseInt(request.getParameter("companyId"));
        String jobRole = request.getParameter("jobRole");
        double packageLpa = Double.parseDouble(request.getParameter("packageLpa"));
        double cgpaReq = Double.parseDouble(request.getParameter("cgpaReq"));
        String branchReq = request.getParameter("branchReq");
        Date driveDate = Date.valueOf(request.getParameter("driveDate"));

        Drive drive = new Drive();
        drive.setCompanyId(companyId);
        drive.setJobRole(jobRole);
        drive.setPackageLpa(packageLpa);
        drive.setCgpaReq(cgpaReq);
        drive.setBranchReq(branchReq);
        drive.setDriveDate(driveDate);
        drive.setStatus("OPEN");
        
        if (driveDAO.createDrive(drive)) {
            response.sendRedirect(request.getContextPath() + "/admin/drives?success=Drive created successfully");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/drives?error=Failed to create drive");
        }
    }

    private void editDrive(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String jobRole = request.getParameter("jobRole");
        double packageLpa = Double.parseDouble(request.getParameter("packageLpa"));
        double cgpaReq = Double.parseDouble(request.getParameter("cgpaReq"));
        String branchReq = request.getParameter("branchReq");
        Date driveDate = Date.valueOf(request.getParameter("driveDate"));
        String status = request.getParameter("status");

        Drive drive = driveDAO.getDriveById(id);
        if (drive != null) {
            drive.setJobRole(jobRole);
            drive.setPackageLpa(packageLpa);
            drive.setCgpaReq(cgpaReq);
            drive.setBranchReq(branchReq);
            drive.setDriveDate(driveDate);
            drive.setStatus(status);
            
            if (driveDAO.updateDrive(drive)) {
                response.sendRedirect(request.getContextPath() + "/admin/drives?success=Drive updated successfully");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/drives?error=Failed to update drive");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/drives?error=Drive not found");
        }
    }

    private void deleteDrive(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        if (driveDAO.deleteDrive(id)) {
            response.sendRedirect(request.getContextPath() + "/admin/drives?success=Drive deleted successfully");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/drives?error=Failed to delete drive");
        }
    }
}
