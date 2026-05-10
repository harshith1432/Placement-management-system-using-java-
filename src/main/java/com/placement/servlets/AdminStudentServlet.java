package com.placement.servlets;

import com.placement.dao.StudentDAO;
import com.placement.dao.UserDAO;
import com.placement.dao.DepartmentDAO;
import com.placement.models.Student;
import com.placement.models.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/students")
public class AdminStudentServlet extends HttpServlet {
    private StudentDAO studentDAO = new StudentDAO();
    private UserDAO userDAO = new UserDAO();
    private DepartmentDAO departmentDAO = new DepartmentDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null || !"ADMIN".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        List<Student> students = studentDAO.getAllStudents();
        List<String> departments = departmentDAO.getAllDepartmentNames();
        
        request.setAttribute("students", students);
        request.setAttribute("departments", departments);
        request.getRequestDispatcher("/admin_students.jsp").forward(request, response);
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
            addStudent(request, response);
        } else if ("edit".equals(action)) {
            editStudent(request, response);
        } else if ("delete".equals(action)) {
            deleteStudent(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/students");
        }
    }

    private void addStudent(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String department = request.getParameter("department");
        double cgpa = Double.parseDouble(request.getParameter("cgpa"));
        String rollNumber = request.getParameter("rollNumber");
        int semester = Integer.parseInt(request.getParameter("semester"));
        String contact = request.getParameter("contact");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        if (password == null || password.isEmpty()) {
            password = "student123"; // Default password
        }

        // Check if username already exists
        if (userDAO.isUsernameExists(username)) {
            response.sendRedirect(request.getContextPath() + "/admin/students?error=Username already exists");
            return;
        }

        // Check if email already exists
        if (studentDAO.isEmailExists(email)) {
            response.sendRedirect(request.getContextPath() + "/admin/students?error=Email already registered");
            return;
        }

        // Create User account
        int userId = userDAO.registerUser(username, password, "STUDENT");
        if (userId != -1) {
            Student student = new Student();
            student.setUserId(userId);
            student.setFullName(fullName);
            student.setEmail(email);
            student.setDepartment(department);
            student.setCgpa(cgpa);
            student.setRollNumber(rollNumber);
            student.setSemester(semester);
            student.setContactNumber(contact);
            
            if (studentDAO.createOrUpdateStudent(student)) {
                response.sendRedirect(request.getContextPath() + "/admin/students?success=Student added successfully");
            } else {
                userDAO.deleteUser(userId); // Rollback user creation if student profile fails
                response.sendRedirect(request.getContextPath() + "/admin/students?error=Failed to create student profile");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/students?error=Failed to register user");
        }
    }

    private void editStudent(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int userId = Integer.parseInt(request.getParameter("userId"));
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String department = request.getParameter("department");
        double cgpa = Double.parseDouble(request.getParameter("cgpa"));
        String rollNumber = request.getParameter("rollNumber");
        int semester = Integer.parseInt(request.getParameter("semester"));
        String contact = request.getParameter("contact");

        Student student = studentDAO.getStudentByUserId(userId);
        if (student != null) {
            student.setFullName(fullName);
            student.setEmail(email);
            student.setDepartment(department);
            student.setCgpa(cgpa);
            student.setRollNumber(rollNumber);
            student.setSemester(semester);
            student.setContactNumber(contact);
            
            if (studentDAO.createOrUpdateStudent(student)) {
                response.sendRedirect(request.getContextPath() + "/admin/students?success=Student updated successfully");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/students?error=Failed to update student");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/students?error=Student not found");
        }
    }

    private void deleteStudent(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int userId = Integer.parseInt(request.getParameter("userId"));
        // Explicitly delete student profile first (though ON DELETE CASCADE should handle it)
        studentDAO.deleteStudent(userId);
        if (userDAO.deleteUser(userId)) {
            response.sendRedirect(request.getContextPath() + "/admin/students?success=Student deleted successfully");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/students?error=Failed to delete student");
        }
    }
}
