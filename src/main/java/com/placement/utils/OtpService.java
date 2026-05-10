package com.placement.utils;

import java.security.SecureRandom;
import java.sql.*;
import java.time.LocalDateTime;

public class OtpService {
    private static final SecureRandom random = new SecureRandom();

    public static String generateOtp() {
        return String.format("%06d", random.nextInt(1000000));
    }

    public static boolean saveOtp(int userId, String otp) {
        String deleteSql = "DELETE FROM password_reset_tokens WHERE user_id = ?";
        String insertSql = "INSERT INTO password_reset_tokens (user_id, otp, expires_at) VALUES (?, ?, ?)";

        try (Connection conn = DBConnection.getConnection()) {
            // Remove old tokens
            try (PreparedStatement pstmt = conn.prepareStatement(deleteSql)) {
                pstmt.setInt(1, userId);
                pstmt.executeUpdate();
            }

            // Insert new token (5 minute expiry)
            try (PreparedStatement pstmt = conn.prepareStatement(insertSql)) {
                pstmt.setInt(1, userId);
                pstmt.setString(2, otp);
                pstmt.setTimestamp(3, Timestamp.valueOf(LocalDateTime.now().plusMinutes(5)));
                return pstmt.executeUpdate() > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static boolean verifyOtp(int userId, String otp) {
        String sql = "SELECT * FROM password_reset_tokens WHERE user_id = ? AND otp = ? AND expires_at > ? AND used = FALSE";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, userId);
            pstmt.setString(2, otp);
            pstmt.setTimestamp(3, Timestamp.valueOf(LocalDateTime.now()));

            try (ResultSet rs = pstmt.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static boolean markOtpUsed(int userId) {
        String sql = "UPDATE password_reset_tokens SET used = TRUE WHERE user_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, userId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static boolean canResendOtp(int userId) {
        String sql = "SELECT last_sent_at FROM password_reset_tokens WHERE user_id = ? ORDER BY last_sent_at DESC LIMIT 1";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, userId);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    Timestamp lastSent = rs.getTimestamp("last_sent_at");
                    return lastSent.toLocalDateTime().plusMinutes(1).isBefore(LocalDateTime.now());
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return true;
    }
}
