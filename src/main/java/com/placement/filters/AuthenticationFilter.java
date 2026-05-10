package com.placement.filters;

import com.placement.models.User;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/*")
public class AuthenticationFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization code if needed
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);
        String path = req.getRequestURI().substring(req.getContextPath().length());

        // Allow access to public resources like login, register, CSS, JS, etc.
        boolean isPublicResource = path.startsWith("/auth") || path.startsWith("/login.jsp") ||
                path.startsWith("/register.jsp") || path.startsWith("/css/") || path.startsWith("/js/") ||
                path.equals("/") || path.equals("/index.jsp") || path.startsWith("/forgot-password") ||
                path.startsWith("/forgot_password.jsp") || path.startsWith("/verify_otp.jsp") ||
                path.startsWith("/reset_password.jsp");

        if (isPublicResource) {
            chain.doFilter(request, response);
            return;
        }

        // For protected resources, check if the user is logged in
        if (session == null || session.getAttribute("user") == null) {
            res.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        // Role-based access control
        User user = (User) session.getAttribute("user");
        String role = user.getRole();

        boolean isAuthorized = true;

        if (path.startsWith("/admin")) {
            isAuthorized = "ADMIN".equals(role);
        } else if (path.startsWith("/student")) {
            isAuthorized = "STUDENT".equals(role);
        } else if (path.startsWith("/company")) {
            isAuthorized = "COMPANY".equals(role);
        }

        if (!isAuthorized) {
            res.sendRedirect(req.getContextPath() + "/login.jsp?errorMessage=Unauthorized access");
            return;
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // Cleanup code if needed
    }
}
