package com.placement.servlets;

import com.placement.dao.PasswordResetDAO;
import com.placement.dao.UserDAO;
import com.placement.models.User;
import com.placement.utils.EmailService;
import com.placement.utils.OtpService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/forgot-password")
public class ForgotPasswordServlet extends HttpServlet {

    private PasswordResetDAO passwordResetDAO;
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        passwordResetDAO = new PasswordResetDAO();
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String role = request.getParameter("role");
        if (role == null || role.isEmpty()) {
            role = "STUDENT"; // default
        }
        request.setAttribute("role", role);
        request.getRequestDispatcher("forgot_password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String role = request.getParameter("role");

        if ("send_otp".equals(action)) {
            handleSendOtp(request, response, role);
        } else if ("verify_otp".equals(action)) {
            handleVerifyOtp(request, response);
        } else if ("resend_otp".equals(action)) {
            handleResendOtp(request, response);
        } else if ("reset_password".equals(action)) {
            handleResetPassword(request, response);
        } else {
            response.sendRedirect("login.jsp");
        }
    }

    private void handleSendOtp(HttpServletRequest request, HttpServletResponse response, String role)
            throws ServletException, IOException {
        String identifier = request.getParameter("identifier"); // Email for Student/Company, Username for Admin

        if (identifier == null || identifier.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Please enter your registered identifier.");
            request.setAttribute("role", role);
            request.getRequestDispatcher("forgot_password.jsp").forward(request, response);
            return;
        }

        User user = passwordResetDAO.findUserByEmailAndRole(identifier.trim(), role);
        if (user == null) {
            request.setAttribute("errorMessage", "No account found with this information.");
            request.setAttribute("role", role);
            request.getRequestDispatcher("forgot_password.jsp").forward(request, response);
            return;
        }

        String otp = OtpService.generateOtp();
        if (OtpService.saveOtp(user.getId(), otp)) {
            String userEmail = passwordResetDAO.getEmailForUser(user.getId(), role);
            EmailService.sendOtpEmail(userEmail, otp, role);

            HttpSession session = request.getSession();
            session.setAttribute("resetUserId", user.getId());
            session.setAttribute("resetUserRole", role);
            session.setAttribute("resetUserEmail", maskEmail(userEmail));
            
            response.sendRedirect("verify_otp.jsp");
        } else {
            request.setAttribute("errorMessage", "Failed to generate OTP. Please try again.");
            request.setAttribute("role", role);
            request.getRequestDispatcher("forgot_password.jsp").forward(request, response);
        }
    }

    private void handleVerifyOtp(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("resetUserId") == null) {
            response.sendRedirect("forgot-password");
            return;
        }

        int userId = (int) session.getAttribute("resetUserId");
        StringBuilder otpBuilder = new StringBuilder();
        for (int i = 1; i <= 6; i++) {
            String val = request.getParameter("otp" + i);
            if (val != null) otpBuilder.append(val);
        }
        String otp = otpBuilder.toString();

        if (otp.length() == 6 && OtpService.verifyOtp(userId, otp)) {
            session.setAttribute("otpVerified", true);
            response.sendRedirect("reset_password.jsp");
        } else {
            request.setAttribute("errorMessage", "Invalid or expired OTP.");
            request.getRequestDispatcher("verify_otp.jsp").forward(request, response);
        }
    }

    private void handleResendOtp(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("resetUserId") == null) {
            response.sendRedirect("forgot-password");
            return;
        }

        int userId = (int) session.getAttribute("resetUserId");
        String role = (String) session.getAttribute("resetUserRole");

        if (OtpService.canResendOtp(userId)) {
            String otp = OtpService.generateOtp();
            if (OtpService.saveOtp(userId, otp)) {
                String userEmail = passwordResetDAO.getEmailForUser(userId, role);
                EmailService.sendOtpEmail(userEmail, otp, role);
                request.setAttribute("successMessage", "A new OTP has been sent to your email.");
            } else {
                request.setAttribute("errorMessage", "Failed to resend OTP.");
            }
        } else {
            request.setAttribute("errorMessage", "Please wait before requesting a new OTP.");
        }
        request.getRequestDispatcher("verify_otp.jsp").forward(request, response);
    }

    private void handleResetPassword(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("resetUserId") == null || 
            session.getAttribute("otpVerified") == null || !(boolean)session.getAttribute("otpVerified")) {
            response.sendRedirect("forgot-password");
            return;
        }

        int userId = (int) session.getAttribute("resetUserId");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if (newPassword == null || newPassword.length() < 8) {
            request.setAttribute("errorMessage", "Password must be at least 8 characters.");
            request.getRequestDispatcher("reset_password.jsp").forward(request, response);
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "Passwords do not match.");
            request.getRequestDispatcher("reset_password.jsp").forward(request, response);
            return;
        }

        if (userDAO.updatePassword(userId, newPassword)) {
            OtpService.markOtpUsed(userId);
            session.invalidate();
            response.sendRedirect("login.jsp?pwdReset=true");
        } else {
            request.setAttribute("errorMessage", "Failed to update password. Please try again.");
            request.getRequestDispatcher("reset_password.jsp").forward(request, response);
        }
    }

    private String maskEmail(String email) {
        if (email == null || !email.contains("@")) return email;
        String[] parts = email.split("@");
        String name = parts[0];
        if (name.length() <= 2) return email;
        return name.charAt(0) + "***" + name.charAt(name.length() - 1) + "@" + parts[1];
    }
}
