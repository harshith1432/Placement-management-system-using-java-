<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<aside id="sidebar" class="h-screen w-64 fixed left-0 top-0 z-50 backdrop-blur-xl bg-surface-container-low/90 border-r border-outline-variant shadow-md flex flex-col gap-xs py-lg hidden md:flex">
    <div class="px-gutter mb-lg">
        <h1 class="font-bold text-2xl text-on-surface tracking-tight">CAREER NEXUS</h1>
        <p class="text-on-surface-variant text-xs uppercase tracking-widest font-bold opacity-70">
            <c:choose>
                <c:when test="${user.role == 'ADMIN'}">Admin Portal</c:when>
                <c:when test="${user.role == 'STUDENT'}">Student Portal</c:when>
                <c:when test="${user.role == 'COMPANY'}">Corporate Portal</c:when>
            </c:choose>
        </p>
    </div>

    <nav class="flex-1 flex flex-col gap-1 px-2">
        <c:choose>
            <c:when test="${user.role == 'ADMIN'}">
                <a class="flex items-center gap-4 px-4 py-3 rounded-xl transition-all duration-200 ${pageContext.request.requestURI.endsWith('admin_dashboard.jsp') || pageContext.request.requestURI.endsWith('/admin') ? 'bg-secondary text-white shadow-lg' : 'text-on-surface-variant hover:bg-surface-container-high'}" href="${pageContext.request.contextPath}/admin">
                    <span class="material-symbols-outlined">dashboard</span>
                    <span class="font-medium">Dashboard</span>
                </a>
                <a class="flex items-center gap-4 px-4 py-3 rounded-xl transition-all duration-200 ${pageContext.request.requestURI.contains('students') ? 'bg-secondary text-white shadow-lg' : 'text-on-surface-variant hover:bg-surface-container-high'}" href="${pageContext.request.contextPath}/admin/students">
                    <span class="material-symbols-outlined">school</span>
                    <span class="font-medium">Students</span>
                </a>
                <a class="flex items-center gap-4 px-4 py-3 rounded-xl transition-all duration-200 ${pageContext.request.requestURI.contains('companies') ? 'bg-secondary text-white shadow-lg' : 'text-on-surface-variant hover:bg-surface-container-high'}" href="${pageContext.request.contextPath}/admin/companies">
                    <span class="material-symbols-outlined">business</span>
                    <span class="font-medium">Companies</span>
                </a>
                <a class="flex items-center gap-4 px-4 py-3 rounded-xl transition-all duration-200 ${pageContext.request.requestURI.contains('drives') ? 'bg-secondary text-white shadow-lg' : 'text-on-surface-variant hover:bg-surface-container-high'}" href="${pageContext.request.contextPath}/admin/drives">
                    <span class="material-symbols-outlined">event_available</span>
                    <span class="font-medium">Placement Drives</span>
                </a>
                <a class="flex items-center gap-4 px-4 py-3 rounded-xl transition-all duration-200 ${pageContext.request.requestURI.contains('reports') ? 'bg-secondary text-white shadow-lg' : 'text-on-surface-variant hover:bg-surface-container-high'}" href="${pageContext.request.contextPath}/admin/reports">
                    <span class="material-symbols-outlined">analytics</span>
                    <span class="font-medium">Reports</span>
                </a>
            </c:when>
            
            <c:when test="${user.role == 'STUDENT'}">
                <a class="flex items-center gap-4 px-4 py-3 rounded-xl transition-all duration-200 ${currentView == 'dashboard' || empty currentView ? 'bg-secondary text-white shadow-lg' : 'text-on-surface-variant hover:bg-surface-container-high'}" href="${pageContext.request.contextPath}/student?view=dashboard">
                    <span class="material-symbols-outlined">dashboard</span>
                    <span class="font-medium">Dashboard</span>
                </a>
                <a class="flex items-center gap-4 px-4 py-3 rounded-xl transition-all duration-200 ${currentView == 'drives' ? 'bg-secondary text-white shadow-lg' : 'text-on-surface-variant hover:bg-surface-container-high'}" href="${pageContext.request.contextPath}/student?view=drives">
                    <span class="material-symbols-outlined">business_center</span>
                    <span class="font-medium">Eligible Drives</span>
                </a>
                <a class="flex items-center gap-4 px-4 py-3 rounded-xl transition-all duration-200 ${currentView == 'applications' ? 'bg-secondary text-white shadow-lg' : 'text-on-surface-variant hover:bg-surface-container-high'}" href="${pageContext.request.contextPath}/student?view=applications">
                    <span class="material-symbols-outlined">assignment</span>
                    <span class="font-medium">My Applications</span>
                </a>
            </c:when>

            <c:when test="${user.role == 'COMPANY'}">
                <a class="flex items-center gap-4 px-4 py-3 rounded-xl transition-all duration-200 ${currentView == 'dashboard' || empty currentView ? 'bg-secondary text-white shadow-lg' : 'text-on-surface-variant hover:bg-surface-container-high'}" href="${pageContext.request.contextPath}/company?view=dashboard">
                    <span class="material-symbols-outlined">dashboard</span>
                    <span class="font-medium">Dashboard</span>
                </a>
                <a class="flex items-center gap-4 px-4 py-3 rounded-xl transition-all duration-200 ${currentView == 'manageDrives' ? 'bg-secondary text-white shadow-lg' : 'text-on-surface-variant hover:bg-surface-container-high'}" href="${pageContext.request.contextPath}/company?view=manageDrives">
                    <span class="material-symbols-outlined">campaign</span>
                    <span class="font-medium">My Drives</span>
                </a>
                <a class="flex items-center gap-4 px-4 py-3 rounded-xl transition-all duration-200 ${currentView == 'applicantReview' ? 'bg-secondary text-white shadow-lg' : 'text-on-surface-variant hover:bg-surface-container-high'}" href="${pageContext.request.contextPath}/company?view=applicantReview">
                    <span class="material-symbols-outlined">group</span>
                    <span class="font-medium">Applicants</span>
                </a>
                <a class="flex items-center gap-4 px-4 py-3 rounded-xl transition-all duration-200 ${currentView == 'interviews' ? 'bg-secondary text-white shadow-lg' : 'text-on-surface-variant hover:bg-surface-container-high'}" href="${pageContext.request.contextPath}/company?view=interviews">
                    <span class="material-symbols-outlined">event_note</span>
                    <span class="font-medium">Interviews</span>
                </a>
            </c:when>
        </c:choose>
    </nav>

    <div class="mt-auto px-4 py-4 border-t border-outline-variant/30">
        <a href="${pageContext.request.contextPath}/auth?action=logout" class="flex items-center gap-4 px-4 py-3 rounded-xl text-error hover:bg-error/10 transition-all duration-200">
            <span class="material-symbols-outlined">logout</span>
            <span class="font-medium">Logout</span>
        </a>
    </div>
</aside>
