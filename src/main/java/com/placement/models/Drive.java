package com.placement.models;

import java.sql.Date;
import java.sql.Timestamp;

public class Drive {
    private int id;
    private int companyId;
    private String companyName; // Used for display purposes
    private String jobRole;
    private String jobDescription;
    private double packageLpa;
    private double cgpaReq;
    private String branchReq;
    private Date driveDate;
    private String status;
    private Timestamp createdAt;

    public Drive() {}

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getCompanyId() { return companyId; }
    public void setCompanyId(int companyId) { this.companyId = companyId; }
    public String getCompanyName() { return companyName; }
    public void setCompanyName(String companyName) { this.companyName = companyName; }
    public String getJobRole() { return jobRole; }
    public void setJobRole(String jobRole) { this.jobRole = jobRole; }
    public String getJobDescription() { return jobDescription; }
    public void setJobDescription(String jobDescription) { this.jobDescription = jobDescription; }
    public double getPackageLpa() { return packageLpa; }
    public void setPackageLpa(double packageLpa) { this.packageLpa = packageLpa; }
    public double getCgpaReq() { return cgpaReq; }
    public void setCgpaReq(double cgpaReq) { this.cgpaReq = cgpaReq; }
    public String getBranchReq() { return branchReq; }
    public void setBranchReq(String branchReq) { this.branchReq = branchReq; }
    public Date getDriveDate() { return driveDate; }
    public void setDriveDate(Date driveDate) { this.driveDate = driveDate; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}
