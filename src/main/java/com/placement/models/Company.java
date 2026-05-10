package com.placement.models;

public class Company {
    private int userId;
    private String companyName;
    private String hrName;
    private String description;
    private String website;
    private String logoUrl;
    private String industryType;
    private String location;
    private String contactEmail;
    private String contactPhone;

    public Company() {}

    public Company(int userId, String companyName, String hrName, String description, String website, String logoUrl, String industryType, String location, String contactEmail, String contactPhone) {
        this.userId = userId;
        this.companyName = companyName;
        this.hrName = hrName;
        this.description = description;
        this.website = website;
        this.logoUrl = logoUrl;
        this.industryType = industryType;
        this.location = location;
        this.contactEmail = contactEmail;
        this.contactPhone = contactPhone;
    }

    // Getters and Setters
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public String getCompanyName() { return companyName; }
    public void setCompanyName(String companyName) { this.companyName = companyName; }
    public String getHrName() { return hrName; }
    public void setHrName(String hrName) { this.hrName = hrName; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public String getWebsite() { return website; }
    public void setWebsite(String website) { this.website = website; }
    public String getLogoUrl() { return logoUrl; }
    public void setLogoUrl(String logoUrl) { this.logoUrl = logoUrl; }
    public String getIndustryType() { return industryType; }
    public void setIndustryType(String industryType) { this.industryType = industryType; }
    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }
    public String getContactEmail() { return contactEmail; }
    public void setContactEmail(String contactEmail) { this.contactEmail = contactEmail; }
    public String getContactPhone() { return contactPhone; }
    public void setContactPhone(String contactPhone) { this.contactPhone = contactPhone; }
}
