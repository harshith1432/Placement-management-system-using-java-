package com.placement.dao;

import com.placement.models.Student;
import com.placement.utils.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class StudentDAO {

    public Student getStudentByUserId(int userId) {
        String sql = "SELECT * FROM students WHERE user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Student student = new Student();
                    student.setUserId(rs.getInt("user_id"));
                    student.setFullName(rs.getString("full_name"));
                    student.setDepartment(rs.getString("department"));
                    student.setCgpa(rs.getDouble("cgpa"));
                    student.setSkills(rs.getString("skills"));
                    student.setResumeUrl(rs.getString("resume_url"));
                    student.setContactNumber(rs.getString("contact_number"));
                    student.setEmail(rs.getString("email"));
                    student.setRollNumber(rs.getString("roll_number"));
                    student.setSemester(rs.getInt("semester"));
                    student.setProfilePhotoUrl(rs.getString("profile_photo_url"));
                    return student;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean createOrUpdateStudent(Student student) {
        String checkSql = "SELECT user_id FROM students WHERE user_id = ?";
        boolean exists = false;
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
            checkStmt.setInt(1, student.getUserId());
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
            sql = "UPDATE students SET full_name = ?, department = ?, cgpa = ?, skills = ?, resume_url = ?, contact_number = ?, email = ?, roll_number = ?, semester = ?, profile_photo_url = ? WHERE user_id = ?";
        } else {
            sql = "INSERT INTO students (full_name, department, cgpa, skills, resume_url, contact_number, email, roll_number, semester, profile_photo_url, user_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        }
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, student.getFullName());
            stmt.setString(2, student.getDepartment());
            stmt.setDouble(3, student.getCgpa());
            stmt.setString(4, student.getSkills());
            stmt.setString(5, student.getResumeUrl());
            stmt.setString(6, student.getContactNumber());
            stmt.setString(7, student.getEmail());
            stmt.setString(8, student.getRollNumber());
            stmt.setInt(9, student.getSemester());
            stmt.setString(10, student.getProfilePhotoUrl());
            stmt.setInt(11, student.getUserId());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    public java.util.List<Student> getAllStudents() {
        java.util.List<Student> students = new java.util.ArrayList<>();
        String sql = "SELECT * FROM students";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                Student student = new Student();
                student.setUserId(rs.getInt("user_id"));
                student.setFullName(rs.getString("full_name"));
                student.setDepartment(rs.getString("department"));
                student.setCgpa(rs.getDouble("cgpa"));
                student.setSkills(rs.getString("skills"));
                student.setResumeUrl(rs.getString("resume_url"));
                student.setContactNumber(rs.getString("contact_number"));
                student.setEmail(rs.getString("email"));
                student.setRollNumber(rs.getString("roll_number"));
                student.setSemester(rs.getInt("semester"));
                student.setProfilePhotoUrl(rs.getString("profile_photo_url"));
                students.add(student);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return students;
    }

    public boolean isEmailExists(String email) {
        String sql = "SELECT user_id FROM students WHERE email = ?";
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

    public boolean deleteStudent(int userId) {
        String sql = "DELETE FROM students WHERE user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
