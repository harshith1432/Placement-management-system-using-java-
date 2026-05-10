package com.placement.servlets;

import com.placement.utils.DBConnection;
import com.placement.models.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/search")
public class SearchPageServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String query = request.getParameter("q");
        List<Map<String, String>> results = new ArrayList<>();

        if (query != null && !query.trim().isEmpty()) {
            String sql = "SELECT 'student' as type, full_name as title, department as detail FROM students WHERE full_name ILIKE ? " +
                         "UNION " +
                         "SELECT 'company' as type, company_name as title, website as detail FROM companies WHERE company_name ILIKE ? " +
                         "UNION " +
                         "SELECT 'drive' as type, job_role as title, status as detail FROM drives WHERE job_role ILIKE ? " +
                         "LIMIT 20";

            try (Connection conn = DBConnection.getConnection();
                 PreparedStatement stmt = conn.prepareStatement(sql)) {
                String searchPattern = "%" + query + "%";
                stmt.setString(1, searchPattern);
                stmt.setString(2, searchPattern);
                stmt.setString(3, searchPattern);

                try (ResultSet rs = stmt.executeQuery()) {
                    while (rs.next()) {
                        Map<String, String> item = new HashMap<>();
                        item.put("type", rs.getString("type"));
                        item.put("title", rs.getString("title"));
                        item.put("detail", rs.getString("detail"));
                        results.add(item);
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        request.setAttribute("results", results);
        request.setAttribute("query", query);
        request.getRequestDispatcher("/search_results.jsp").forward(request, response);
    }
}
