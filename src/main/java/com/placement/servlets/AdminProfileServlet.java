package com.placement.servlets;

import com.placement.dao.UserDAO;
import com.placement.models.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/admin/profile")
public class AdminProfileServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        request.getRequestDispatcher("/admin_profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        String action = request.getParameter("action");

        if ("updatePassword".equals(action)) {
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");

            if (newPassword != null && newPassword.equals(confirmPassword) && !newPassword.isEmpty()) {
                if (userDAO.updatePassword(user.getId(), newPassword)) {
                    request.setAttribute("success", "Password updated successfully!");
                } else {
                    request.setAttribute("error", "Failed to update password.");
                }
            } else {
                request.setAttribute("error", "Passwords do not match or are empty.");
            }
        } else if ("updateUsername".equals(action)) {
            String newUsername = request.getParameter("username");
            if (newUsername != null && !newUsername.isEmpty()) {
                if (userDAO.updateUsername(user.getId(), newUsername)) {
                    user.setUsername(newUsername);
                    session.setAttribute("user", user);
                    request.setAttribute("success", "Username updated successfully!");
                } else {
                    request.setAttribute("error", "Failed to update username.");
                }
            }
        }

        request.getRequestDispatcher("/admin_profile.jsp").forward(request, response);
    }
}
