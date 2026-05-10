package com.placement.servlets;

import com.placement.dao.CompanyDAO;
import com.placement.dao.UserDAO;
import com.placement.models.Company;
import com.placement.models.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/companies")
public class AdminCompanyServlet extends HttpServlet {
    private CompanyDAO companyDAO = new CompanyDAO();
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null || !"ADMIN".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        List<Company> companies = companyDAO.getAllCompanies();
        request.setAttribute("companies", companies);
        request.getRequestDispatcher("/admin_companies.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User admin = (User) session.getAttribute("user");
        if (admin == null || !"ADMIN".equals(admin.getRole())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        String action = request.getParameter("action");
        if ("add".equals(action)) {
            addCompany(request, response);
        } else if ("edit".equals(action)) {
            editCompany(request, response);
        } else if ("delete".equals(action)) {
            deleteCompany(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/companies");
        }
    }

    private void addCompany(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String companyName = request.getParameter("companyName");
        String email = request.getParameter("email");
        String website = request.getParameter("website");
        String contactPhone = request.getParameter("contactPhone");
        String description = request.getParameter("description");
        String hrName = request.getParameter("hrName");
        String industryType = request.getParameter("industryType");
        String location = request.getParameter("location");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        if (password == null || password.isEmpty()) {
            password = "company123"; // Default password
        }

        // Check if username already exists
        if (userDAO.isUsernameExists(username)) {
            response.sendRedirect(request.getContextPath() + "/admin/companies?error=Username already exists");
            return;
        }

        // Check if email already exists
        if (companyDAO.isEmailExists(email)) {
            response.sendRedirect(request.getContextPath() + "/admin/companies?error=Email already registered");
            return;
        }

        int userId = userDAO.registerUser(username, password, "COMPANY");
        if (userId != -1) {
            Company company = new Company();
            company.setUserId(userId);
            company.setCompanyName(companyName);
            company.setContactEmail(email);
            company.setWebsite(website);
            company.setContactPhone(contactPhone);
            company.setDescription(description);
            company.setHrName(hrName);
            company.setIndustryType(industryType);
            company.setLocation(location);
            
            if (companyDAO.createOrUpdateCompany(company)) {
                response.sendRedirect(request.getContextPath() + "/admin/companies?success=Company added successfully");
            } else {
                userDAO.deleteUser(userId);
                response.sendRedirect(request.getContextPath() + "/admin/companies?error=Failed to create company profile");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/companies?error=Failed to register user");
        }
    }

    private void editCompany(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int userId = Integer.parseInt(request.getParameter("userId"));
        String companyName = request.getParameter("companyName");
        String email = request.getParameter("email");
        String website = request.getParameter("website");
        String contactPhone = request.getParameter("contactPhone");
        String description = request.getParameter("description");
        String hrName = request.getParameter("hrName");
        String industryType = request.getParameter("industryType");
        String location = request.getParameter("location");

        Company company = companyDAO.getCompanyByUserId(userId);
        if (company != null) {
            company.setCompanyName(companyName);
            company.setContactEmail(email);
            company.setWebsite(website);
            company.setContactPhone(contactPhone);
            company.setDescription(description);
            company.setHrName(hrName);
            company.setIndustryType(industryType);
            company.setLocation(location);
            
            if (companyDAO.createOrUpdateCompany(company)) {
                response.sendRedirect(request.getContextPath() + "/admin/companies?success=Company updated successfully");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/companies?error=Failed to update company");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/companies?error=Company not found");
        }
    }

    private void deleteCompany(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int userId = Integer.parseInt(request.getParameter("userId"));
        if (userDAO.deleteUser(userId)) {
            response.sendRedirect(request.getContextPath() + "/admin/companies?success=Company deleted successfully");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/companies?error=Failed to delete company");
        }
    }
}
