package com.placement.dao;

import com.placement.models.User;
import com.placement.utils.DBConnection;
import io.github.cdimascio.dotenv.Dotenv;
import java.sql.*;

public class PasswordResetDAO {
    private static final Dotenv dotenv = Dotenv.load();

    public User findUserByEmailAndRole(String identifier, String role) {
        String sql;
        if ("STUDENT".equals(role)) {
            sql = "SELECT u.* FROM users u JOIN students s ON u.id = s.user_id WHERE s.email = ? AND u.role = 'STUDENT'";
        } else if ("COMPANY".equals(role)) {
            sql = "SELECT u.* FROM users u JOIN companies c ON u.id = c.user_id WHERE c.contact_email = ? AND u.role = 'COMPANY'";
        } else { // ADMIN
            // Admins are found by username, and we use a fallback email from .env
            sql = "SELECT * FROM users WHERE username = ? AND role = 'ADMIN'";
        }

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, identifier);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    User user = new User();
                    user.setId(rs.getInt("id"));
                    user.setUsername(rs.getString("username"));
                    user.setRole(rs.getString("role"));
                    return user;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public String getEmailForUser(int userId, String role) {
        String sql;
        if ("STUDENT".equals(role)) {
            sql = "SELECT email FROM students WHERE user_id = ?";
        } else if ("COMPANY".equals(role)) {
            sql = "SELECT contact_email as email FROM companies WHERE user_id = ?";
        } else {
            // Check admins table for the admin email
            String adminSql = "SELECT email FROM admins WHERE user_id = ?";
            try (Connection conn = DBConnection.getConnection();
                 PreparedStatement pstmt = conn.prepareStatement(adminSql)) {
                pstmt.setInt(1, userId);
                try (ResultSet rs = pstmt.executeQuery()) {
                    if (rs.next()) {
                        return rs.getString("email");
                    }
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            return dotenv.get("ADMIN_EMAIL", "admin@college.edu");
        }

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, userId);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("email");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
