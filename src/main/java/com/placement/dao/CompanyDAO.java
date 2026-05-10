package com.placement.dao;

import com.placement.models.Company;
import com.placement.utils.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class CompanyDAO {

    public Company getCompanyByUserId(int userId) {
        String sql = "SELECT * FROM companies WHERE user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Company company = new Company();
                    company.setUserId(rs.getInt("user_id"));
                    company.setCompanyName(rs.getString("company_name"));
                    company.setHrName(rs.getString("hr_name"));
                    company.setDescription(rs.getString("description"));
                    company.setWebsite(rs.getString("website"));
                    company.setLogoUrl(rs.getString("logo_url"));
                    company.setIndustryType(rs.getString("industry_type"));
                    company.setLocation(rs.getString("location"));
                    company.setContactEmail(rs.getString("contact_email"));
                    company.setContactPhone(rs.getString("contact_phone"));
                    return company;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean createOrUpdateCompany(Company company) {
        String checkSql = "SELECT user_id FROM companies WHERE user_id = ?";
        boolean exists = false;
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
            checkStmt.setInt(1, company.getUserId());
            try (ResultSet rs = checkStmt.executeQuery()) {
                if (rs.next()) {
                    exists = true;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }

        String sql;
        if (exists) {
            sql = "UPDATE companies SET company_name = ?, hr_name = ?, description = ?, website = ?, logo_url = ?, industry_type = ?, location = ?, contact_email = ?, contact_phone = ? WHERE user_id = ?";
        } else {
            sql = "INSERT INTO companies (company_name, hr_name, description, website, logo_url, industry_type, location, contact_email, contact_phone, user_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        }
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, company.getCompanyName());
            stmt.setString(2, company.getHrName());
            stmt.setString(3, company.getDescription());
            stmt.setString(4, company.getWebsite());
            stmt.setString(5, company.getLogoUrl());
            stmt.setString(6, company.getIndustryType());
            stmt.setString(7, company.getLocation());
            stmt.setString(8, company.getContactEmail());
            stmt.setString(9, company.getContactPhone());
            stmt.setInt(10, company.getUserId());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    public java.util.List<Company> getAllCompanies() {
        java.util.List<Company> companies = new java.util.ArrayList<>();
        String sql = "SELECT * FROM companies";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                Company company = new Company();
                company.setUserId(rs.getInt("user_id"));
                company.setCompanyName(rs.getString("company_name"));
                company.setHrName(rs.getString("hr_name"));
                company.setDescription(rs.getString("description"));
                company.setWebsite(rs.getString("website"));
                company.setLogoUrl(rs.getString("logo_url"));
                company.setIndustryType(rs.getString("industry_type"));
                company.setLocation(rs.getString("location"));
                company.setContactEmail(rs.getString("contact_email"));
                company.setContactPhone(rs.getString("contact_phone"));
                companies.add(company);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return companies;
    }

    public boolean isEmailExists(String email) {
        String sql = "SELECT user_id FROM companies WHERE contact_email = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
