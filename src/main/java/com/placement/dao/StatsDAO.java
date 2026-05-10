package com.placement.dao;

import com.placement.utils.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class StatsDAO {

    public int getTotalStudents() {
        return getCount("SELECT COUNT(*) FROM users WHERE role = 'STUDENT'");
    }

    public int getTotalCompanies() {
        return getCount("SELECT COUNT(*) FROM users WHERE role = 'COMPANY'");
    }

    public int getActiveDrives() {
        return getCount("SELECT COUNT(*) FROM drives WHERE status = 'OPEN'");
    }

    public int getTotalPlacements() {
        return getCount("SELECT COUNT(*) FROM applications WHERE status = 'SELECTED'");
    }

    public java.util.Map<String, Integer> getMonthlyPlacementTrend() {
        java.util.Map<String, Integer> trend = new java.util.LinkedHashMap<>();
        String sql = "SELECT TO_CHAR(applied_at, 'Mon') as month, COUNT(*) as count " +
                     "FROM applications " +
                     "WHERE status = 'SELECTED' " +
                     "GROUP BY month, TO_CHAR(applied_at, 'MM') " +
                     "ORDER BY TO_CHAR(applied_at, 'MM') DESC " +
                     "LIMIT 6";
                     
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                trend.put(rs.getString("month"), rs.getInt("count"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return trend;
    }

    private int getCount(String sql) {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}
