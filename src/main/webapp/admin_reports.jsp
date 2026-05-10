<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html class="light" lang="en">
<head>
    <title>Placement Portal - Reports & Analytics</title>
    <jsp:include page="includes/layout_head.jsp" />
    <!-- Additional script for Charts -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body class="bg-background font-inter text-on-surface">
    <jsp:include page="includes/layout_sidebar.jsp" />

    <main class="main-content min-h-screen flex flex-col transition-all duration-300 md:ml-64">
        <jsp:include page="includes/layout_header.jsp" />

        <!-- Page Header -->
        <div class="px-8 py-6 flex flex-col md:flex-row md:items-center justify-between gap-4 border-b border-outline-variant bg-surface/50 backdrop-blur-sm">
            <div>
                <h1 class="text-2xl font-bold text-on-surface">Reports & Analytics</h1>
                <p class="text-on-surface-variant">Comprehensive system data and performance metrics.</p>
            </div>
            <div class="flex flex-wrap gap-3">
                <button onclick="window.location.href='?type=${param.type != null ? param.type : 'summary'}&format=csv'" 
                        class="flex items-center gap-2 px-4 py-2 bg-secondary text-white rounded-xl hover:bg-secondary/90 shadow-sm transition-all text-sm font-medium">
                    <span class="material-symbols-outlined text-[20px]">download</span> Download CSV
                </button>
                <button onclick="window.print()" 
                        class="flex items-center gap-2 px-4 py-2 bg-surface-container-lowest border border-outline-variant rounded-xl text-on-surface hover:bg-surface-container-low shadow-sm transition-all text-sm font-medium">
                    <span class="material-symbols-outlined text-[20px]">print</span> Print Report
                </button>
            </div>
        </div>

        <div class="p-8 space-y-8">
            <!-- Report Type Navigation -->
            <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                <a href="?type=summary" class="glass-card p-6 rounded-2xl border-2 transition-all group ${param.type == null || param.type == 'summary' ? 'border-secondary bg-secondary/5' : 'border-transparent hover:border-outline-variant'}">
                    <div class="flex items-center gap-4">
                        <div class="w-12 h-12 rounded-xl bg-secondary/10 text-secondary flex items-center justify-center">
                            <span class="material-symbols-outlined">bar_chart</span>
                        </div>
                        <div>
                            <h3 class="font-bold text-on-surface">General Stats</h3>
                            <p class="text-xs text-on-surface-variant">Department performance</p>
                        </div>
                    </div>
                </a>
                <a href="?type=placements" class="glass-card p-6 rounded-2xl border-2 transition-all group ${param.type == 'placements' ? 'border-secondary bg-secondary/5' : 'border-transparent hover:border-outline-variant'}">
                    <div class="flex items-center gap-4">
                        <div class="w-12 h-12 rounded-xl bg-green-100 text-green-600 flex items-center justify-center">
                            <span class="material-symbols-outlined">check_circle</span>
                        </div>
                        <div>
                            <h3 class="font-bold text-on-surface">Placement Detail</h3>
                            <p class="text-xs text-on-surface-variant">List of selected students</p>
                        </div>
                    </div>
                </a>
                <a href="?type=drives" class="glass-card p-6 rounded-2xl border-2 transition-all group ${param.type == 'drives' ? 'border-secondary bg-secondary/5' : 'border-transparent hover:border-outline-variant'}">
                    <div class="flex items-center gap-4">
                        <div class="w-12 h-12 rounded-xl bg-orange-100 text-orange-600 flex items-center justify-center">
                            <span class="material-symbols-outlined">campaign</span>
                        </div>
                        <div>
                            <h3 class="font-bold text-on-surface">Drive History</h3>
                            <p class="text-xs text-on-surface-variant">All recruitment events</p>
                        </div>
                    </div>
                </a>
            </div>

            <!-- Report Content Area -->
            <div class="glass-card rounded-2xl border border-outline-variant overflow-hidden p-8 shadow-sm">
                <c:choose>
                    <c:when test="${param.type == 'placements'}">
                        <div class="flex items-center justify-between mb-6">
                            <h3 class="text-xl font-bold text-on-surface">Selected Students Report</h3>
                            <div class="flex items-center gap-2 bg-surface-container-low px-3 py-1.5 rounded-lg border border-outline-variant">
                                <span class="material-symbols-outlined text-[18px] text-on-surface-variant">search</span>
                                <input type="text" id="reportSearch" placeholder="Filter placements..." class="bg-transparent border-none focus:ring-0 text-sm p-0 w-48 text-on-surface">
                            </div>
                        </div>
                        <div class="overflow-x-auto">
                            <table class="w-full text-left border-collapse" id="reportTable">
                                <thead>
                                    <tr class="text-on-surface-variant text-sm border-b border-outline-variant">
                                        <th class="py-4 px-4 font-semibold">Student Name</th>
                                        <th class="py-4 px-4 font-semibold">Department</th>
                                        <th class="py-4 px-4 font-semibold">Company</th>
                                        <th class="py-4 px-4 font-semibold">Job Role</th>
                                        <th class="py-4 px-4 font-semibold">Date</th>
                                    </tr>
                                </thead>
                                <tbody class="divide-y divide-outline-variant/30">
                                    <c:forEach var="item" items="${reportData}">
                                        <tr class="hover:bg-surface-container-low/50 transition-colors">
                                            <td class="py-4 px-4 font-medium text-on-surface">${item.studentName}</td>
                                            <td class="py-4 px-4 text-on-surface-variant">${item.studentDepartment}</td>
                                            <td class="py-4 px-4 text-on-surface">${item.companyName}</td>
                                            <td class="py-4 px-4">
                                                <span class="px-2 py-1 bg-secondary/10 text-secondary text-xs font-medium rounded-lg">
                                                    ${item.jobRole}
                                                </span>
                                            </td>
                                            <td class="py-4 px-4 text-on-surface-variant text-sm">${item.appliedAt}</td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty reportData}">
                                        <tr>
                                            <td colspan="5" class="py-20 text-center">
                                                <div class="flex flex-col items-center gap-3 text-on-surface-variant">
                                                    <span class="material-symbols-outlined text-4xl opacity-20">inventory_2</span>
                                                    <p>No placements found for this criteria.</p>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>
                    </c:when>
                    <c:when test="${param.type == 'drives'}">
                        <div class="flex items-center justify-between mb-6">
                            <h3 class="text-xl font-bold text-on-surface">Drive History Report</h3>
                            <div class="flex items-center gap-2 bg-surface-container-low px-3 py-1.5 rounded-lg border border-outline-variant">
                                <span class="material-symbols-outlined text-[18px] text-on-surface-variant">search</span>
                                <input type="text" id="reportSearch" placeholder="Filter drives..." class="bg-transparent border-none focus:ring-0 text-sm p-0 w-48 text-on-surface">
                            </div>
                        </div>
                        <div class="overflow-x-auto">
                            <table class="w-full text-left border-collapse" id="reportTable">
                                <thead>
                                    <tr class="text-on-surface-variant text-sm border-b border-outline-variant">
                                        <th class="py-4 px-4 font-semibold">Company</th>
                                        <th class="py-4 px-4 font-semibold">Role</th>
                                        <th class="py-4 px-4 font-semibold">Package</th>
                                        <th class="py-4 px-4 font-semibold text-center">Status</th>
                                        <th class="py-4 px-4 font-semibold">Date</th>
                                    </tr>
                                </thead>
                                <tbody class="divide-y divide-outline-variant/30">
                                    <c:forEach var="item" items="${reportData}">
                                        <tr class="hover:bg-surface-container-low/50 transition-colors">
                                            <td class="py-4 px-4 font-medium text-on-surface">${item.companyName}</td>
                                            <td class="py-4 px-4 text-on-surface-variant">${item.jobRole}</td>
                                            <td class="py-4 px-4 text-green-600 font-bold">${item.packageLpa} LPA</td>
                                            <td class="py-4 px-4 text-center">
                                                <span class="px-3 py-1 ${item.status == 'OPEN' ? 'bg-green-100 text-green-700' : 'bg-red-100 text-red-700'} rounded-full text-xs font-bold uppercase tracking-wider">
                                                    ${item.status}
                                                </span>
                                            </td>
                                            <td class="py-4 px-4 text-on-surface-variant text-sm">${item.driveDate}</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <h3 class="text-xl font-bold mb-8 text-on-surface">Placement Statistics by Department</h3>
                        <div class="grid grid-cols-1 lg:grid-cols-2 gap-12 items-center">
                            <div class="relative h-[350px]">
                                <canvas id="deptChart"></canvas>
                            </div>
                            <div class="space-y-6">
                                <h4 class="font-bold text-on-surface-variant border-b border-outline-variant pb-2 text-sm uppercase tracking-wider">Department Summary</h4>
                                <div class="grid gap-3">
                                    <c:forEach var="entry" items="${deptStats}">
                                        <div class="flex justify-between items-center p-4 rounded-xl bg-surface-container-low border border-outline-variant/50 hover:border-secondary transition-colors group">
                                            <div class="flex items-center gap-3">
                                                <div class="w-2 h-2 rounded-full bg-secondary group-hover:scale-125 transition-transform"></div>
                                                <span class="text-on-surface font-medium">${entry.key}</span>
                                            </div>
                                            <span class="font-bold text-secondary bg-secondary/10 px-3 py-1 rounded-lg text-sm">${entry.value} Placed</span>
                                        </div>
                                    </c:forEach>
                                    <c:if test="${empty deptStats}">
                                        <div class="py-10 text-center text-on-surface-variant italic">
                                            No placement data available yet.
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <jsp:include page="includes/layout_footer.jsp" />
    </main>

    <script>
        // Chart Logic
        <c:if test="${not empty deptStats}">
        const ctx = document.getElementById('deptChart').getContext('2d');
        new Chart(ctx, {
            type: 'doughnut',
            data: {
                labels: [
                    <c:forEach var="entry" items="${deptStats}">
                        '${entry.key}',
                    </c:forEach>
                ],
                datasets: [{
                    data: [
                        <c:forEach var="entry" items="${deptStats}">
                            ${entry.value},
                        </c:forEach>
                    ],
                    backgroundColor: [
                        '#316bf3', '#10b981', '#f59e0b', '#ef4444', '#8b5cf6', '#ec4899'
                    ],
                    hoverOffset: 15,
                    borderWidth: 4,
                    borderColor: '#ffffff'
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                cutout: '75%',
                plugins: {
                    legend: {
                        display: false
                    },
                    tooltip: {
                        backgroundColor: '#131b2e',
                        padding: 12,
                        titleFont: { size: 14, weight: 'bold' },
                        bodyFont: { size: 13 },
                        cornerRadius: 8,
                        displayColors: true
                    }
                }
            }
        });
        </c:if>

        // Search Filter for Tables
        const reportSearch = document.getElementById('reportSearch');
        if (reportSearch) {
            reportSearch.addEventListener('keyup', function() {
                const value = this.value.toLowerCase();
                const rows = document.querySelectorAll('#reportTable tbody tr');
                
                rows.forEach(row => {
                    const text = row.textContent.toLowerCase();
                    row.style.display = text.includes(value) ? '' : 'none';
                });
            });
        }
    </script>
</body>
</html>
