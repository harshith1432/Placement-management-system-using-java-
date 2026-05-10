package com.placement.servlets;

import com.google.gson.Gson;
import com.placement.dao.StatsDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Map;

@WebServlet("/api/dashboard-data")
public class DashboardDataServlet extends HttpServlet {

    private StatsDAO statsDAO;
    private Gson gson;

    @Override
    public void init() throws ServletException {
        statsDAO = new StatsDAO();
        gson = new Gson();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Map<String, Integer> trend = statsDAO.getMonthlyPlacementTrend();
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(gson.toJson(trend));
    }
}
