<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html class="light" lang="en">
<head>
    <title>Career Nexus - Student Dashboard</title>
    <jsp:include page="includes/layout_head.jsp" />
</head>
<body class="bg-background font-body text-on-background min-h-screen">
    <jsp:include page="includes/layout_sidebar.jsp" />
    <jsp:include page="includes/layout_header.jsp" />

    <!-- Main Content -->
    <main class="md:ml-64 flex flex-col min-h-screen">
        <!-- Alerts/Notifications -->
        <div class="pt-4 px-md lg:px-lg max-w-container-max mx-auto w-full">
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
            <c:if test="${not empty warningMessage}">
                <div class="flex items-center gap-sm p-sm bg-[#fef9c3] text-[#854d0e] border border-[#fef08a] rounded-lg shadow-sm mb-4">
                    <span class="material-symbols-outlined text-[20px]">warning</span>
                    <span class="font-body-sm font-medium"><c:out value="${warningMessage}"/></span>
                </div>
            </c:if>
        </div>

        <div class="max-w-container-max mx-auto p-md lg:p-lg space-y-lg w-full flex-1">
            <c:choose>
                <c:when test="${currentView == 'dashboard'}">
                    <jsp:include page="views/student/dashboard_view.jsp" />
                </c:when>
                <c:when test="${currentView == 'drives'}">
                    <jsp:include page="views/student/drives_view.jsp" />
                </c:when>
                <c:when test="${currentView == 'applications'}">
                    <jsp:include page="views/student/applications_view.jsp" />
                </c:when>
                <c:otherwise>
                    <jsp:include page="views/student/dashboard_view.jsp" />
                </c:otherwise>
            </c:choose>
        </div>

        <jsp:include page="includes/layout_footer.jsp" />
    </main>

    <!-- Modals -->
    <jsp:include page="views/student/profile_modal.jsp" />
    <jsp:include page="views/student/drive_details_modal.jsp" />

    <script>
        function toggleProfileModal() {
            const modal = document.getElementById('profileModal');
            modal.classList.toggle('hidden');
            if (!modal.classList.contains('hidden')) {
                document.body.style.overflow = 'hidden';
            } else {
                document.body.style.overflow = 'auto';
            }
        }

        function toggleDriveModal() {
            const modal = document.getElementById('driveDetailsModal');
            modal.classList.toggle('hidden');
            if (!modal.classList.contains('hidden')) {
                document.body.style.overflow = 'hidden';
            } else {
                document.body.style.overflow = 'auto';
            }
        }

        function showDriveDetails(company, role, status, date) {
            document.getElementById('modalCompanyName').textContent = company;
            document.getElementById('modalJobRole').textContent = role;
            document.getElementById('modalStatus').textContent = status;
            document.getElementById('modalAppliedDate').textContent = date;
            toggleDriveModal();
        }

        // Client-side filtering
        document.addEventListener('DOMContentLoaded', function() {
            // Drive search
            const driveSearch = document.getElementById('driveSearch');
            if (driveSearch) {
                driveSearch.addEventListener('input', function(e) {
                    const term = e.target.value.toLowerCase();
                    const cards = document.querySelectorAll('#driveGrid > div');
                    cards.forEach(card => {
                        const role = card.querySelector('.drive-role').textContent.toLowerCase();
                        const company = card.querySelector('.drive-company').textContent.toLowerCase();
                        card.style.display = (role.includes(term) || company.includes(term)) ? '' : 'none';
                    });
                });
            }

            // Application search
            const appSearch = document.getElementById('appSearch');
            if (appSearch) {
                appSearch.addEventListener('input', function(e) {
                    const term = e.target.value.toLowerCase();
                    const rows = document.querySelectorAll('#appTable tbody tr');
                    rows.forEach(row => {
                        const company = row.querySelector('.app-company')?.textContent.toLowerCase() || '';
                        const role = row.querySelector('.app-role')?.textContent.toLowerCase() || '';
                        row.style.display = (company.includes(term) || role.includes(term)) ? '' : 'none';
                    });
                });
            }
        });
    </script>
</body>
</html>