package com.placement.models;

public class Student {
    private int userId;
    private String fullName;
    private String department;
    private double cgpa;
    private String skills;
    private String resumeUrl;
    private String contactNumber;
    private String email;
    private String rollNumber;
    private int semester;
    private String profilePhotoUrl;

    public Student() {}

    public Student(int userId, String fullName, String department, double cgpa, String skills, String resumeUrl, String contactNumber, String email, String rollNumber, int semester, String profilePhotoUrl) {
        this.userId = userId;
        this.fullName = fullName;
        this.department = department;
        this.cgpa = cgpa;
        this.skills = skills;
        this.resumeUrl = resumeUrl;
        this.contactNumber = contactNumber;
        this.email = email;
        this.rollNumber = rollNumber;
        this.semester = semester;
        this.profilePhotoUrl = profilePhotoUrl;
    }

    // Getters and Setters
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }
    public String getDepartment() { return department; }
    public void setDepartment(String department) { this.department = department; }
    public double getCgpa() { return cgpa; }
    public void setCgpa(double cgpa) { this.cgpa = cgpa; }
    public String getSkills() { return skills; }
    public void setSkills(String skills) { this.skills = skills; }
    public String getResumeUrl() { return resumeUrl; }
    public void setResumeUrl(String resumeUrl) { this.resumeUrl = resumeUrl; }
    public String getContactNumber() { return contactNumber; }
    public void setContactNumber(String contactNumber) { this.contactNumber = contactNumber; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getRollNumber() { return rollNumber; }
    public void setRollNumber(String rollNumber) { this.rollNumber = rollNumber; }
    public int getSemester() { return semester; }
    public void setSemester(int semester) { this.semester = semester; }
    public String getProfilePhotoUrl() { return profilePhotoUrl; }
    public void setProfilePhotoUrl(String profilePhotoUrl) { this.profilePhotoUrl = profilePhotoUrl; }
}
