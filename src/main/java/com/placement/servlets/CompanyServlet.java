package com.placement.servlets;

import com.placement.dao.ApplicationDAO;
import com.placement.dao.CompanyDAO;
import com.placement.dao.DriveDAO;
import com.placement.dao.InterviewDAO;
import com.placement.models.Application;
import com.placement.models.Company;
import com.placement.models.Drive;
import com.placement.models.Interview;
import com.placement.models.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/company")
public class CompanyServlet extends HttpServlet {

    private DriveDAO driveDAO;
    private ApplicationDAO applicationDAO;
    private CompanyDAO companyDAO;
    private InterviewDAO interviewDAO;

    @Override
    public void init() throws ServletException {
        driveDAO = new DriveDAO();
        applicationDAO = new ApplicationDAO();
        companyDAO = new CompanyDAO();
        interviewDAO = new InterviewDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        User user = (User) session.getAttribute("user");
        String view = request.getParameter("view");
        if (view == null) view = "dashboard";

        // Fetch company profile (needed for header and several views)
        Company company = companyDAO.getCompanyByUserId(user.getId());
        request.setAttribute("company", company);
        request.setAttribute("currentView", view);

        if ("dashboard".equals(view)) {
            loadDashboardData(user.getId(), request);
        } else if ("profile".equals(view)) {
            // Profile data already fetched above
        } else if ("manageDrives".equals(view)) {
            request.setAttribute("myDrives", driveDAO.getDrivesByCompany(user.getId()));
        } else if ("applicantReview".equals(view)) {
            String driveIdParam = request.getParameter("driveId");
            Integer driveId = (driveIdParam != null && !driveIdParam.isEmpty()) ? Integer.parseInt(driveIdParam) : null;
            request.setAttribute("allApplicants", applicationDAO.getApplicationsByCompany(user.getId(), driveId));
            request.setAttribute("myDrives", driveDAO.getDrivesByCompany(user.getId()));
            request.setAttribute("selectedDriveId", driveId);
        } else if ("interviews".equals(view)) {
            request.setAttribute("interviews", interviewDAO.getInterviewsByCompany(user.getId()));
            request.setAttribute("allApplicants", applicationDAO.getApplicationsByCompany(user.getId()));
        }

        request.getRequestDispatcher("company_dashboard.jsp").forward(request, response);
    }

    private void loadDashboardData(int companyId, HttpServletRequest request) {
        List<Drive> myDrives = driveDAO.getDrivesByCompany(companyId);
        request.setAttribute("myDrives", myDrives);

        int totalApplicants = 0;
        int activeDrivesCount = 0;
        List<Application> pendingApplications = new ArrayList<>();
        
        for (Drive drive : myDrives) {
            if ("OPEN".equals(drive.getStatus())) {
                activeDrivesCount++;
                List<Application> apps = applicationDAO.getApplicationsForDrive(drive.getId());
                for (Application app : apps) {
                    if ("APPLIED".equals(app.getStatus())) {
                        pendingApplications.add(app);
                    }
                }
                totalApplicants += apps.size();
            }
        }

        List<Interview> upcomingInterviews = interviewDAO.getInterviewsByCompany(companyId);
        int scheduledInterviewsCount = 0;
        for (Interview i : upcomingInterviews) {
            if ("SCHEDULED".equals(i.getStatus())) scheduledInterviewsCount++;
        }

        request.setAttribute("activeDrivesCount", activeDrivesCount);
        request.setAttribute("totalApplicants", totalApplicants);
        request.setAttribute("pendingApplications", pendingApplications);
        request.setAttribute("scheduledInterviewsCount", scheduledInterviewsCount);
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
        String successMsg = "";
        String errorMsg = "";

        try {
            if ("updateProfile".equals(action)) {
                Company company = new Company();
                company.setUserId(user.getId());
                company.setCompanyName(request.getParameter("companyName"));
                company.setHrName(request.getParameter("hrName"));
                company.setDescription(request.getParameter("description"));
                company.setWebsite(request.getParameter("website"));
                company.setLogoUrl(request.getParameter("logoUrl"));
                company.setIndustryType(request.getParameter("industryType"));
                company.setLocation(request.getParameter("location"));
                company.setContactEmail(request.getParameter("contactEmail"));
                company.setContactPhone(request.getParameter("contactPhone"));
                
                if (companyDAO.createOrUpdateCompany(company)) {
                    successMsg = "Profile updated successfully";
                } else {
                    errorMsg = "Failed to update profile";
                }
            } else if ("createDrive".equals(action)) {
                System.out.println("[CompanyServlet] Processing createDrive for company ID: " + user.getId());
                Drive drive = new Drive();
                drive.setCompanyId(user.getId());
                drive.setJobRole(request.getParameter("jobRole"));
                drive.setJobDescription(request.getParameter("jobDescription"));
                
                String pkgStr = request.getParameter("packageLpa");
                String cgpaStr = request.getParameter("cgpaReq");
                String dateStr = request.getParameter("driveDate");
                
                if (pkgStr == null || pkgStr.isEmpty() || cgpaStr == null || cgpaStr.isEmpty() || dateStr == null || dateStr.isEmpty()) {
                    errorMsg = "Required fields (Package, CGPA, Date) are missing.";
                    System.err.println("[CompanyServlet] Validation failed: missing fields for createDrive");
                } else {
                    try {
                        drive.setPackageLpa(Double.parseDouble(pkgStr));
                        drive.setCgpaReq(Double.parseDouble(cgpaStr));
                        drive.setBranchReq(request.getParameter("branchReq"));
                        drive.setDriveDate(Date.valueOf(dateStr));
                        
                        if (driveDAO.createDrive(drive)) {
                            successMsg = "Campus drive posted successfully!";
                            System.out.println("[CompanyServlet] Drive created successfully for company: " + user.getUsername());
                        } else {
                            errorMsg = "Database error: Could not save the drive. Check server logs.";
                        }
                    } catch (NumberFormatException e) {
                        errorMsg = "Invalid numeric format for package (" + pkgStr + ") or CGPA (" + cgpaStr + ").";
                        System.err.println("[CompanyServlet] Number format error: " + e.getMessage());
                    } catch (IllegalArgumentException e) {
                        errorMsg = "Invalid date format: " + dateStr + ". Expected YYYY-MM-DD.";
                        System.err.println("[CompanyServlet] Date format error: " + e.getMessage());
                    }
                }
            } else if ("updateDrive".equals(action)) {
                String driveIdStr = request.getParameter("driveId");
                System.out.println("[CompanyServlet] Processing updateDrive for ID: " + driveIdStr);
                
                if (driveIdStr != null && !driveIdStr.isEmpty()) {
                    Drive drive = driveDAO.getDriveById(Integer.parseInt(driveIdStr));
                    if (drive != null && drive.getCompanyId() == user.getId()) {
                        drive.setJobRole(request.getParameter("jobRole"));
                        drive.setJobDescription(request.getParameter("jobDescription"));
                        
                        String pkgStr = request.getParameter("packageLpa");
                        String cgpaStr = request.getParameter("cgpaReq");
                        String dateStr = request.getParameter("driveDate");
                        
                        try {
                            if (pkgStr != null && !pkgStr.isEmpty()) drive.setPackageLpa(Double.parseDouble(pkgStr));
                            if (cgpaStr != null && !cgpaStr.isEmpty()) drive.setCgpaReq(Double.parseDouble(cgpaStr));
                            drive.setBranchReq(request.getParameter("branchReq"));
                            if (dateStr != null && !dateStr.isEmpty()) drive.setDriveDate(Date.valueOf(dateStr));
                            drive.setStatus(request.getParameter("status"));
                            
                            if (driveDAO.updateDrive(drive)) {
                                successMsg = "Drive updated successfully!";
                                System.out.println("[CompanyServlet] Drive ID " + driveIdStr + " updated successfully.");
                            } else {
                                errorMsg = "Database error: Could not update the drive.";
                            }
                        } catch (NumberFormatException e) {
                            errorMsg = "Invalid numeric format.";
                            System.err.println("[CompanyServlet] Number format error during update: " + e.getMessage());
                        } catch (IllegalArgumentException e) {
                            errorMsg = "Invalid date format.";
                            System.err.println("[CompanyServlet] Date format error during update: " + e.getMessage());
                        }
                    } else {
                        errorMsg = "Unauthorized access: You don't own this drive or it doesn't exist.";
                        System.err.println("[CompanyServlet] Unauthorized update attempt for drive ID " + driveIdStr + " by user " + user.getId());
                    }
                } else {
                    errorMsg = "Error: Missing Drive ID for update operation.";
                }
            } else if ("deleteDrive".equals(action)) {
                int driveId = Integer.parseInt(request.getParameter("driveId"));
                if (driveDAO.deleteDrive(driveId)) {
                    successMsg = "Drive deleted successfully";
                } else {
                    errorMsg = "Failed to delete drive";
                }
            } else if ("updateStatus".equals(action)) {
                int applicationId = Integer.parseInt(request.getParameter("applicationId"));
                String status = request.getParameter("status");
                if (applicationDAO.updateApplicationStatus(applicationId, status)) {
                    successMsg = "Application status updated to " + status;
                } else {
                    errorMsg = "Failed to update status";
                }
            } else if ("scheduleInterview".equals(action)) {
                Interview interview = new Interview();
                interview.setApplicationId(Integer.parseInt(request.getParameter("applicationId")));
                interview.setRoundName(request.getParameter("roundName"));
                interview.setDateTime(Timestamp.valueOf(request.getParameter("dateTime").replace("T", " ") + ":00"));
                interview.setMeetingLink(request.getParameter("meetingLink"));
                interview.setNotes(request.getParameter("notes"));
                
                if (interviewDAO.scheduleInterview(interview)) {
                    // Automatically update application status
                    applicationDAO.updateApplicationStatus(interview.getApplicationId(), "INTERVIEW_SCHEDULED");
                    successMsg = "Interview scheduled successfully";
                } else {
                    errorMsg = "Failed to schedule interview";
                }
            } else if ("updateInterviewStatus".equals(action)) {
                int interviewId = Integer.parseInt(request.getParameter("interviewId"));
                String status = request.getParameter("status");
                if (interviewDAO.updateInterviewStatus(interviewId, status)) {
                    successMsg = "Interview marked as " + status;
                } else {
                    errorMsg = "Failed to update interview status";
                }
            } else if ("recordInterviewResult".equals(action)) {
                int interviewId = Integer.parseInt(request.getParameter("interviewId"));
                int applicationId = Integer.parseInt(request.getParameter("applicationId"));
                String result = request.getParameter("result");
                String feedback = request.getParameter("feedback");
                
                if (interviewDAO.updateInterviewResult(interviewId, result, feedback)) {
                    String appStatus = "INTERVIEW_COMPLETED";
                    String currentRound = "Initial";
                    
                    if ("SELECTED".equals(result)) {
                        appStatus = "SELECTED";
                        currentRound = "Hired";
                    } else if ("REJECTED".equals(result)) {
                        appStatus = "REJECTED";
                        currentRound = "Rejected";
                    } else if ("NEXT_ROUND".equals(result)) {
                        appStatus = "SHORTLISTED";
                        currentRound = request.getParameter("nextRoundName");
                        
                        // Check if optional next round scheduling data is provided
                        String nextDateStr = request.getParameter("nextRoundDate");
                        String nextLink = request.getParameter("nextMeetingLink");
                        
                        if (nextDateStr != null && !nextDateStr.isEmpty()) {
                            Interview nextInterview = new Interview();
                            nextInterview.setApplicationId(applicationId);
                            nextInterview.setRoundName(currentRound);
                            nextInterview.setDateTime(Timestamp.valueOf(nextDateStr.replace("T", " ") + ":00"));
                            nextInterview.setMeetingLink(nextLink);
                            nextInterview.setNotes("Automatically scheduled from previous round.");
                            
                            if (interviewDAO.scheduleInterview(nextInterview)) {
                                appStatus = "INTERVIEW_SCHEDULED";
                            }
                        }
                    }
                    
                    applicationDAO.updateApplicationStatusWithRound(applicationId, appStatus, currentRound);
                    successMsg = "Interview result recorded successfully";
                } else {
                    errorMsg = "Failed to record interview result";
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            errorMsg = "Error: " + e.getMessage();
        }

        String redirectView = request.getParameter("redirectView");
        if (redirectView == null) redirectView = "dashboard";
        
        String redirectUrl = "company?view=" + redirectView;
        if (!successMsg.isEmpty()) redirectUrl += "&success=" + java.net.URLEncoder.encode(successMsg, "UTF-8");
        if (!errorMsg.isEmpty()) redirectUrl += "&error=" + java.net.URLEncoder.encode(errorMsg, "UTF-8");
        
        response.sendRedirect(redirectUrl);
    }
}
