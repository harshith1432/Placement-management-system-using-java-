package com.placement.dao;

import com.placement.models.Application;
import com.placement.utils.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ApplicationDAO {

    public boolean applyForDrive(int studentId, int driveId) {
        String sql = "INSERT INTO applications (student_id, drive_id) VALUES (?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, studentId);
            stmt.setInt(2, driveId);
            return stmt.executeUpdate() > 0;
            
        } catch (SQLException e) {
            // Might be a duplicate application violation, which is expected to fail
            e.printStackTrace();
            return false;
        }
    }

    public List<Application> getApplicationsForDrive(int driveId) {
        List<Application> apps = new ArrayList<>();
        String sql = "SELECT a.*, s.full_name, s.department, s.cgpa, s.email " +
                     "FROM applications a " +
                     "JOIN students s ON a.student_id = s.user_id " +
                     "WHERE a.drive_id = ? " +
                     "ORDER BY a.applied_at DESC";
                     
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, driveId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Application app = new Application();
                    app.setId(rs.getInt("id"));
                    app.setStudentId(rs.getInt("student_id"));
                    app.setDriveId(rs.getInt("drive_id"));
                    app.setStatus(rs.getString("status"));
                    app.setAppliedAt(rs.getTimestamp("applied_at"));
                    
                    app.setStudentName(rs.getString("full_name"));
                    app.setStudentDepartment(rs.getString("department"));
                    app.setStudentCgpa(rs.getDouble("cgpa"));
                    app.setStudentEmail(rs.getString("email"));
                    app.setCurrentRound(rs.getString("current_round"));
                    
                    apps.add(app);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return apps;
    }

    public List<Application> getApplicationsByStudent(int studentId) {
        List<Application> apps = new ArrayList<>();
        String sql = "SELECT a.*, d.job_role, c.company_name " +
                     "FROM applications a " +
                     "JOIN drives d ON a.drive_id = d.id " +
                     "JOIN companies c ON d.company_id = c.user_id " +
                     "WHERE a.student_id = ? " +
                     "ORDER BY a.applied_at DESC";
                     
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, studentId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Application app = new Application();
                    app.setId(rs.getInt("id"));
                    app.setStudentId(rs.getInt("student_id"));
                    app.setDriveId(rs.getInt("drive_id"));
                    app.setStatus(rs.getString("status"));
                    app.setAppliedAt(rs.getTimestamp("applied_at"));
                    
                    app.setJobRole(rs.getString("job_role"));
                    app.setCompanyName(rs.getString("company_name"));
                    app.setCurrentRound(rs.getString("current_round"));
                    
                    apps.add(app);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return apps;
    }
    
    public Map<String, Integer> getApplicationStatsByStudent(int studentId) {
        Map<String, Integer> stats = new HashMap<>();
        // Initialize all possible statuses with 0
        stats.put("APPLIED", 0);
        stats.put("SHORTLISTED", 0);
        stats.put("INTERVIEW_SCHEDULED", 0);
        stats.put("REJECTED", 0);
        stats.put("SELECTED", 0);
        
        String sql = "SELECT status, COUNT(*) as count FROM applications WHERE student_id = ? GROUP BY status";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, studentId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    stats.put(rs.getString("status"), rs.getInt("count"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return stats;
    }

    public Application getLatestApplication(int studentId) {
        String sql = "SELECT a.*, d.job_role, c.company_name " +
                     "FROM applications a " +
                     "JOIN drives d ON a.drive_id = d.id " +
                     "JOIN companies c ON d.company_id = c.user_id " +
                     "WHERE a.student_id = ? " +
                     "ORDER BY a.applied_at DESC LIMIT 1";
                     
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, studentId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Application app = new Application();
                    app.setId(rs.getInt("id"));
                    app.setStudentId(rs.getInt("student_id"));
                    app.setDriveId(rs.getInt("drive_id"));
                    app.setStatus(rs.getString("status"));
                    app.setAppliedAt(rs.getTimestamp("applied_at"));
                    app.setJobRole(rs.getString("job_role"));
                    app.setCompanyName(rs.getString("company_name"));
                    return app;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateApplicationStatus(int id, String status) {
        String sql = "UPDATE applications SET status = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, status);
            stmt.setInt(2, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Application> getApplicationsByCompany(int companyId, Integer driveId) {
        List<Application> apps = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
            "SELECT a.*, s.full_name, s.department, s.cgpa, s.email, d.job_role " +
            "FROM applications a " +
            "JOIN students s ON a.student_id = s.user_id " +
            "JOIN drives d ON a.drive_id = d.id " +
            "WHERE d.company_id = ? "
        );
        
        if (driveId != null && driveId > 0) {
            sql.append("AND d.id = ? ");
        }
        
        sql.append("ORDER BY a.applied_at DESC");
                     
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql.toString())) {
            
            stmt.setInt(1, companyId);
            if (driveId != null && driveId > 0) {
                stmt.setInt(2, driveId);
            }
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Application app = new Application();
                    app.setId(rs.getInt("id"));
                    app.setStudentId(rs.getInt("student_id"));
                    app.setDriveId(rs.getInt("drive_id"));
                    app.setStatus(rs.getString("status"));
                    app.setAppliedAt(rs.getTimestamp("applied_at"));
                    
                    app.setStudentName(rs.getString("full_name"));
                    app.setStudentDepartment(rs.getString("department"));
                    app.setStudentCgpa(rs.getDouble("cgpa"));
                    app.setStudentEmail(rs.getString("email"));
                    app.setStudentEmail(rs.getString("email"));
                    app.setJobRole(rs.getString("job_role"));
                    app.setCurrentRound(rs.getString("current_round"));
                    
                    apps.add(app);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return apps;
    }

    public boolean updateApplicationStatusWithRound(int id, String status, String currentRound) {
        String sql = "UPDATE applications SET status = ?, current_round = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, status);
            stmt.setString(2, currentRound);
            stmt.setInt(3, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Application> getPlacementProgress() {
        List<Application> progress = new ArrayList<>();
        String sql = "SELECT a.*, s.full_name, s.department, c.company_name, d.job_role " +
                     "FROM applications a " +
                     "JOIN students s ON a.student_id = s.user_id " +
                     "JOIN drives d ON a.drive_id = d.id " +
                     "JOIN companies c ON d.company_id = c.user_id " +
                     "ORDER BY a.applied_at DESC";
                     
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Application app = new Application();
                app.setId(rs.getInt("id"));
                app.setStudentName(rs.getString("full_name"));
                app.setStudentDepartment(rs.getString("department"));
                app.setCompanyName(rs.getString("company_name"));
                app.setJobRole(rs.getString("job_role"));
                app.setStatus(rs.getString("status"));
                app.setCurrentRound(rs.getString("current_round"));
                app.setAppliedAt(rs.getTimestamp("applied_at"));
                progress.add(app);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return progress;
    }

    public List<Application> getApplicationsByCompany(int companyId) {
        return getApplicationsByCompany(companyId, null);
    }
}

