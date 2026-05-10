package com.placement.dao;

import com.placement.models.Interview;
import com.placement.utils.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class InterviewDAO {

    public boolean scheduleInterview(Interview interview) {
        String sql = "INSERT INTO interviews (application_id, round_name, date_time, meeting_link, notes) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, interview.getApplicationId());
            stmt.setString(2, interview.getRoundName());
            stmt.setTimestamp(3, interview.getDateTime());
            stmt.setString(4, interview.getMeetingLink());
            stmt.setString(5, interview.getNotes());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Interview> getInterviewsByCompany(int companyId) {
        List<Interview> interviews = new ArrayList<>();
        String sql = "SELECT i.*, s.full_name, d.job_role " +
                     "FROM interviews i " +
                     "JOIN applications a ON i.application_id = a.id " +
                     "JOIN students s ON a.student_id = s.user_id " +
                     "JOIN drives d ON a.drive_id = d.id " +
                     "WHERE d.company_id = ? " +
                     "ORDER BY i.date_time DESC";
                     
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, companyId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Interview interview = new Interview();
                    interview.setId(rs.getInt("id"));
                    interview.setApplicationId(rs.getInt("application_id"));
                    interview.setRoundName(rs.getString("round_name"));
                    interview.setDateTime(rs.getTimestamp("date_time"));
                    interview.setMeetingLink(rs.getString("meeting_link"));
                    interview.setStatus(rs.getString("status"));
                    interview.setNotes(rs.getString("notes"));
                    interview.setStudentName(rs.getString("full_name"));
                    interview.setJobRole(rs.getString("job_role"));
                    interview.setResult(rs.getString("result"));
                    interview.setFeedback(rs.getString("feedback"));
                    interviews.add(interview);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return interviews;
    }

    public List<Interview> getInterviewsByStudent(int studentId) {
        List<Interview> interviews = new ArrayList<>();
        String sql = "SELECT i.*, c.company_name, d.job_role " +
                     "FROM interviews i " +
                     "JOIN applications a ON i.application_id = a.id " +
                     "JOIN drives d ON a.drive_id = d.id " +
                     "JOIN companies c ON d.company_id = c.user_id " +
                     "WHERE a.student_id = ? " +
                     "ORDER BY i.date_time DESC";
                     
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, studentId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Interview interview = new Interview();
                    interview.setId(rs.getInt("id"));
                    interview.setApplicationId(rs.getInt("application_id"));
                    interview.setRoundName(rs.getString("round_name"));
                    interview.setDateTime(rs.getTimestamp("date_time"));
                    interview.setMeetingLink(rs.getString("meeting_link"));
                    interview.setStatus(rs.getString("status"));
                    interview.setNotes(rs.getString("notes"));
                    interview.setJobRole(rs.getString("job_role"));
                    interview.setResult(rs.getString("result"));
                    interview.setFeedback(rs.getString("feedback"));
                    // We reuse studentName field to store company name for student view
                    interview.setStudentName(rs.getString("company_name"));
                    interviews.add(interview);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return interviews;
    }

    public boolean updateInterviewResult(int interviewId, String result, String feedback) {
        String sql = "UPDATE interviews SET result = ?, feedback = ?, status = 'COMPLETED' WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, result);
            stmt.setString(2, feedback);
            stmt.setInt(3, interviewId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateInterviewStatus(int interviewId, String status) {
        String sql = "UPDATE interviews SET status = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, status);
            stmt.setInt(2, interviewId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
