<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html class="light" lang="en">
<head>
    <title>Career Nexus - ${company.companyName} Dashboard</title>
    <jsp:include page="includes/layout_head.jsp" />
</head>
<body class="bg-background font-body text-on-background min-h-screen">

    <jsp:include page="includes/layout_sidebar.jsp" />
    <jsp:include page="includes/layout_header.jsp" />

    <!-- Main Content -->
    <main class="md:ml-64 flex flex-col min-h-screen">
        <div class="max-w-container-max mx-auto p-md lg:p-lg space-y-lg w-full flex-1">
        
            <!-- Alerts -->
            <c:if test="${not empty param.success}">
                <div class="flex items-center gap-sm p-sm bg-[#dcfce7] text-[#166534] border border-[#bbf7d0] rounded-lg shadow-sm animate-in fade-in slide-in-from-top-2 duration-300 mb-4">
                    <span class="material-symbols-outlined text-[20px]">check_circle</span>
                    <span class="font-body-sm font-medium"><c:out value="${param.success}"/></span>
                </div>
            </c:if>
            <c:if test="${not empty param.error}">
                <div class="flex items-center gap-sm p-sm bg-[#fee2e2] text-[#991b1b] border border-[#fecaca] rounded-lg shadow-sm animate-in fade-in slide-in-from-top-2 duration-300 mb-4">
                    <span class="material-symbols-outlined text-[20px]">error</span>
                    <span class="font-body-sm font-medium"><c:out value="${param.error}"/></span>
                </div>
            </c:if>

            <c:choose>
                <c:when test="${currentView == 'dashboard'}">
                    <jsp:include page="views/company/dashboard_view.jsp" />
                </c:when>
                <c:when test="${currentView == 'profile'}">
                    <jsp:include page="views/company/profile_view.jsp" />
                </c:when>
                <c:when test="${currentView == 'manageDrives'}">
                    <jsp:include page="views/company/manage_drives_view.jsp" />
                </c:when>
                <c:when test="${currentView == 'applicantReview'}">
                    <jsp:include page="views/company/applicant_review_view.jsp" />
                </c:when>
                <c:when test="${currentView == 'interviews'}">
                    <jsp:include page="views/company/interviews_view.jsp" />
                </c:when>
                <c:otherwise>
                    <div class="glass-card p-xl rounded-2xl text-center">
                        <h2 class="font-h2 text-h2 text-on-surface">404 - View Not Found</h2>
                        <p class="text-on-surface-variant mt-md">The requested view "${currentView}" does not exist.</p>
                        <a href="company?view=dashboard" class="inline-block mt-lg bg-primary text-on-primary px-lg py-sm rounded-lg hover:bg-secondary transition-all">Return to Dashboard</a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
        
        <jsp:include page="includes/layout_footer.jsp" />
    </main>

</body>
</html>