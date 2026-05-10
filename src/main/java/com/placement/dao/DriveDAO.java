package com.placement.dao;

import com.placement.models.Drive;
import com.placement.utils.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DriveDAO {

    public boolean createDrive(Drive drive) {
        String sql = "INSERT INTO drives (company_id, job_role, job_description, package_lpa, cgpa_req, branch_req, drive_date, status) VALUES (?, ?, ?, ?, ?, ?, ?, 'OPEN')";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, drive.getCompanyId());
            stmt.setString(2, drive.getJobRole());
            stmt.setString(3, drive.getJobDescription());
            stmt.setDouble(4, drive.getPackageLpa());
            stmt.setDouble(5, drive.getCgpaReq());
            stmt.setString(6, drive.getBranchReq());
            stmt.setDate(7, drive.getDriveDate());
            
            int result = stmt.executeUpdate();
            System.out.println("[DriveDAO] Create drive result: " + result);
            return result > 0;
        } catch (SQLException e) {
            System.err.println("[DriveDAO] Critical error creating drive for company ID " + drive.getCompanyId() + ": " + e.getMessage());
            System.err.println("[DriveDAO] SQL State: " + e.getSQLState());
            System.err.println("[DriveDAO] Error Code: " + e.getErrorCode());
            e.printStackTrace();
            return false;
        }
    }

    public List<Drive> getAllActiveDrives() {
        List<Drive> drives = new ArrayList<>();
        String sql = "SELECT d.*, c.company_name FROM drives d JOIN companies c ON d.company_id = c.user_id WHERE d.status = 'OPEN' ORDER BY d.drive_date ASC";
        
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Drive drive = extractDriveFromResultSet(rs);
                drive.setCompanyName(rs.getString("company_name"));
                drives.add(drive);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return drives;
    }

    public List<Drive> getDrivesByCompany(int companyId) {
        List<Drive> drives = new ArrayList<>();
        String sql = "SELECT * FROM drives WHERE company_id = ? ORDER BY created_at DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, companyId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    drives.add(extractDriveFromResultSet(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return drives;
    }
    public Drive getDriveById(int id) {
        String sql = "SELECT d.*, c.company_name FROM drives d LEFT JOIN companies c ON d.company_id = c.user_id WHERE d.id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Drive drive = extractDriveFromResultSet(rs);
                    drive.setCompanyName(rs.getString("company_name"));
                    return drive;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    private Drive extractDriveFromResultSet(ResultSet rs) throws SQLException {
        Drive drive = new Drive();
        drive.setId(rs.getInt("id"));
        drive.setCompanyId(rs.getInt("company_id"));
        drive.setJobRole(rs.getString("job_role"));
        drive.setJobDescription(rs.getString("job_description"));
        drive.setPackageLpa(rs.getDouble("package_lpa"));
        drive.setCgpaReq(rs.getDouble("cgpa_req"));
        drive.setBranchReq(rs.getString("branch_req"));
        drive.setDriveDate(rs.getDate("drive_date"));
        drive.setStatus(rs.getString("status"));
        
        // Safety check for created_at
        try {
            drive.setCreatedAt(rs.getTimestamp("created_at"));
        } catch (SQLException e) {
            // Column might be missing if schema initialization hasn't run yet or failed
            System.err.println("[DriveDAO] Warning: 'created_at' column missing or null: " + e.getMessage());
        }
        
        return drive;
    }
    public List<Drive> getAllDrives() {
        List<Drive> drives = new ArrayList<>();
        String sql = "SELECT d.*, c.company_name FROM drives d JOIN companies c ON d.company_id = c.user_id ORDER BY d.drive_date DESC";
        
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Drive drive = extractDriveFromResultSet(rs);
                drive.setCompanyName(rs.getString("company_name"));
                drives.add(drive);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return drives;
    }

    public boolean updateDrive(Drive drive) {
        String sql = "UPDATE drives SET job_role = ?, job_description = ?, package_lpa = ?, cgpa_req = ?, branch_req = ?, drive_date = ?, status = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, drive.getJobRole());
            stmt.setString(2, drive.getJobDescription());
            stmt.setDouble(3, drive.getPackageLpa());
            stmt.setDouble(4, drive.getCgpaReq());
            stmt.setString(5, drive.getBranchReq());
            stmt.setDate(6, drive.getDriveDate());
            stmt.setString(7, drive.getStatus());
            stmt.setInt(8, drive.getId());
            
            int result = stmt.executeUpdate();
            System.out.println("[DriveDAO] Update drive result for ID " + drive.getId() + ": " + result);
            return result > 0;
        } catch (SQLException e) {
            System.err.println("[DriveDAO] Critical error updating drive ID " + drive.getId() + ": " + e.getMessage());
            System.err.println("[DriveDAO] SQL State: " + e.getSQLState());
            System.err.println("[DriveDAO] Error Code: " + e.getErrorCode());
            e.printStackTrace();
            return false;
        }
    }

    public List<Drive> getEligibleDrivesForStudent(int studentId, double cgpa, String department) {
        List<Drive> drives = new ArrayList<>();
        // Query drives that are OPEN, meet CGPA requirement, and match branch requirement
        // Also exclude drives the student has already applied to
        String sql = "SELECT d.*, c.company_name " +
                     "FROM drives d " +
                     "JOIN companies c ON d.company_id = c.user_id " +
                     "WHERE d.status = 'OPEN' " +
                     "AND d.cgpa_req <= ? " +
                     "AND (d.branch_req = 'ALL' OR d.branch_req LIKE ?) " +
                     "AND d.id NOT IN (SELECT drive_id FROM applications WHERE student_id = ?) " +
                     "ORDER BY d.drive_date ASC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setDouble(1, cgpa);
            stmt.setString(2, "%" + department + "%");
            stmt.setInt(3, studentId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Drive drive = extractDriveFromResultSet(rs);
                    drive.setCompanyName(rs.getString("company_name"));
                    drives.add(drive);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return drives;
    }

    public boolean deleteDrive(int driveId) {
        String sql = "DELETE FROM drives WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, driveId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
