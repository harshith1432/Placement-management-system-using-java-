package com.placement.servlets;

import com.placement.dao.ApplicationDAO;
import com.placement.dao.DriveDAO;
import com.placement.models.Application;
import com.placement.models.Drive;
import com.placement.models.Student;
import com.placement.models.User;
import com.placement.dao.StudentDAO;
import com.placement.dao.NotificationDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/student")
public class StudentServlet extends HttpServlet {

    private DriveDAO driveDAO;
    private ApplicationDAO applicationDAO;
    private StudentDAO studentDAO;
    private NotificationDAO notificationDAO;
    private com.placement.dao.InterviewDAO interviewDAO;

    @Override
    public void init() throws ServletException {
        driveDAO = new DriveDAO();
        applicationDAO = new ApplicationDAO();
        studentDAO = new StudentDAO();
        notificationDAO = new NotificationDAO();
        interviewDAO = new com.placement.dao.InterviewDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        User user = (User) session.getAttribute("user");

        // Fetch student profile
        Student studentProfile = studentDAO.getStudentByUserId(user.getId());
        request.setAttribute("studentProfile", studentProfile);

        // Fetch student's applications
        List<Application> myApplications = applicationDAO.getApplicationsByStudent(user.getId());
        request.setAttribute("myApplications", myApplications);

        // Fetch eligible drives based on student profile
        List<Drive> availableDrives;
        if (studentProfile != null) {
            availableDrives = driveDAO.getEligibleDrivesForStudent(user.getId(), studentProfile.getCgpa(), studentProfile.getDepartment());
        } else {
            // If profile is missing, show all active drives but warn the user to complete profile
            availableDrives = driveDAO.getAllActiveDrives();
            request.setAttribute("warningMessage", "Please complete your profile to see accurate eligible drives.");
        }
        request.setAttribute("availableDrives", availableDrives);

        // Fetch dashboard specific data
        request.setAttribute("applicationStats", applicationDAO.getApplicationStatsByStudent(user.getId()));
        request.setAttribute("latestApplication", applicationDAO.getLatestApplication(user.getId()));
        request.setAttribute("notifications", notificationDAO.getNotificationsByUser(user.getId()));
        request.setAttribute("upcomingInterviews", interviewDAO.getInterviewsByStudent(user.getId()));

        // Determine view
        String view = request.getParameter("view");
        if (view == null) view = "dashboard";
        request.setAttribute("currentView", view);

        request.getRequestDispatcher("student_dashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        User user = (User) session.getAttribute("user");
        
        String action = request.getParameter("action");
        if ("apply".equals(action)) {
            int driveId = Integer.parseInt(request.getParameter("driveId"));
            
            // Security Check: Verify eligibility before applying
            Student studentProfile = studentDAO.getStudentByUserId(user.getId());
            if (studentProfile == null) {
                response.sendRedirect("student?view=dashboard&error=Please complete your profile before applying");
                return;
            }
            
            Drive drive = driveDAO.getDriveById(driveId);
            if (drive == null || !"OPEN".equals(drive.getStatus())) {
                response.sendRedirect("student?view=dashboard&error=Drive is no longer active");
                return;
            }
            
            if (studentProfile.getCgpa() < drive.getCgpaReq()) {
                response.sendRedirect("student?view=dashboard&error=You do not meet the CGPA requirement for this drive");
                return;
            }
            
            // Check branch requirement
            if (!"ALL".equalsIgnoreCase(drive.getBranchReq()) && 
                !drive.getBranchReq().toUpperCase().contains(studentProfile.getDepartment().toUpperCase())) {
                response.sendRedirect("student?view=dashboard&error=Your department is not eligible for this drive");
                return;
            }

            boolean success = applicationDAO.applyForDrive(user.getId(), driveId);
            
            if (success) {
                response.sendRedirect("student?view=applications&success=Successfully applied for " + drive.getJobRole());
            } else {
                response.sendRedirect("student?view=dashboard&error=Application failed or already applied");
            }
        } else if ("updateProfile".equals(action)) {
            Student student = new Student();
            student.setUserId(user.getId());
            student.setFullName(request.getParameter("fullName"));
            student.setDepartment(request.getParameter("department"));
            
            try {
                String cgpaStr = request.getParameter("cgpa");
                student.setCgpa(cgpaStr != null && !cgpaStr.trim().isEmpty() ? Double.parseDouble(cgpaStr) : 0.0);
            } catch (NumberFormatException e) {
                student.setCgpa(0.0);
            }
            
            student.setRollNumber(request.getParameter("rollNumber"));
            
            try {
                String semStr = request.getParameter("semester");
                student.setSemester(semStr != null && !semStr.trim().isEmpty() ? Integer.parseInt(semStr) : 1);
            } catch (NumberFormatException e) {
                student.setSemester(1);
            }
            
            student.setContactNumber(request.getParameter("contactNumber"));
            student.setEmail(request.getParameter("email"));
            student.setSkills(request.getParameter("skills"));
            student.setResumeUrl(request.getParameter("resumeUrl"));
            student.setProfilePhotoUrl(request.getParameter("profilePhotoUrl"));
            
            boolean success = studentDAO.createOrUpdateStudent(student);
            if (success) {
                response.sendRedirect("student?success=Profile updated successfully");
            } else {
                response.sendRedirect("student?error=Failed to update profile");
            }
        }
    }
}
