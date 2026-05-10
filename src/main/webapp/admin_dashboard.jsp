<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html class="light" lang="en">
<head>
    <title>Placement Portal - Admin Dashboard</title>
    <jsp:include page="includes/layout_head.jsp" />
</head>
<body class="bg-background font-body text-on-background min-h-screen">
    <jsp:include page="includes/layout_sidebar.jsp" />
    <jsp:include page="includes/layout_header.jsp" />
    
    <!-- Main Content Wrapper -->
    <main class="md:ml-64 flex flex-col min-h-screen">

<!-- Dashboard Content -->
<div class="p-gutter max-w-container-max mx-auto w-full">
<section class="mb-lg">
<h2 class="font-h2 text-h2 text-on-surface mb-xs">Placement Overview</h2>
<p class="text-on-surface-variant font-body-md">Welcome back, Admin. Here's what's happening today.</p>
</section>
<!-- Statistics Grid -->
<div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-md mb-lg">
<!-- Card 1 -->
<a href="${pageContext.request.contextPath}/admin/students" class="glass-card p-md rounded-xl shadow-sm flex items-start justify-between hover:shadow-md hover:scale-[1.02] transition-all cursor-pointer">
<div>
<p class="text-label-caps text-on-surface-variant mb-2">TOTAL STUDENTS</p>
<h3 class="font-h1 text-3xl font-bold text-on-surface">${totalStudents != null ? totalStudents : 0}</h3>
<div class="flex items-center gap-1 text-secondary text-xs mt-2 font-medium">
<span class="material-symbols-outlined text-xs" data-icon="trending_up">trending_up</span>
<span>+4.5% from last month</span>
</div>
</div>
<div class="w-12 h-12 rounded-lg bg-secondary/10 flex items-center justify-center text-secondary">
<span class="material-symbols-outlined" data-icon="school" style="font-variation-settings: 'FILL' 1;">school</span>
</div>
</a>
<!-- Card 2 -->
<a href="${pageContext.request.contextPath}/admin/companies" class="glass-card p-md rounded-xl shadow-sm flex items-start justify-between hover:shadow-md hover:scale-[1.02] transition-all cursor-pointer">
<div>
<p class="text-label-caps text-on-surface-variant mb-2">REGISTERED COMPANIES</p>
<h3 class="font-h1 text-3xl font-bold text-on-surface">${totalCompanies != null ? totalCompanies : 0}</h3>
<div class="flex items-center gap-1 text-secondary text-xs mt-2 font-medium">
<span class="material-symbols-outlined text-xs" data-icon="add">add</span>
<span>8 new this week</span>
</div>
</div>
<div class="w-12 h-12 rounded-lg bg-surface-container-high flex items-center justify-center text-on-surface">
<span class="material-symbols-outlined" data-icon="business" style="font-variation-settings: 'FILL' 1;">business</span>
</div>
</a>
<!-- Card 3 -->
<a href="${pageContext.request.contextPath}/admin/drives" class="glass-card p-md rounded-xl shadow-sm flex items-start justify-between hover:shadow-md hover:scale-[1.02] transition-all cursor-pointer">
<div>
<p class="text-label-caps text-on-surface-variant mb-2">ACTIVE DRIVES</p>
<h3 class="font-h1 text-3xl font-bold text-on-surface">${activeDrives != null ? activeDrives : 0}</h3>
<div class="flex items-center gap-1 text-on-surface-variant text-xs mt-2 font-medium">
<span class="material-symbols-outlined text-xs" data-icon="schedule">schedule</span>
<span>3 closing today</span>
</div>
</div>
<div class="w-12 h-12 rounded-lg bg-primary-container flex items-center justify-center text-primary-fixed">
<span class="material-symbols-outlined" data-icon="event_available" style="font-variation-settings: 'FILL' 1;">event_available</span>
</div>
</a>
<!-- Card 4 -->
<a href="${pageContext.request.contextPath}/admin/reports" class="glass-card p-md rounded-xl shadow-sm flex items-start justify-between hover:shadow-md hover:scale-[1.02] transition-all cursor-pointer">
<div>
<p class="text-label-caps text-on-surface-variant mb-2">TOTAL PLACED</p>
<h3 class="font-h1 text-3xl font-bold text-on-surface">${totalPlacements != null ? totalPlacements : 0}</h3>
<div class="flex items-center gap-1 text-secondary text-xs mt-2 font-medium">
<span class="material-symbols-outlined text-xs" data-icon="check_circle">check_circle</span>
<span>36% placement rate</span>
</div>
</div>
<div class="w-12 h-12 rounded-lg bg-secondary-container flex items-center justify-center text-on-secondary-container">
<span class="material-symbols-outlined" data-icon="emoji_events" style="font-variation-settings: 'FILL' 1;">emoji_events</span>
</div>
</a>
</div>
<!-- Bento Grid Main Content -->
<div class="grid grid-cols-1 lg:grid-cols-3 gap-md">
<!-- Table Section (Large) -->
<div class="lg:col-span-2 glass-card rounded-xl shadow-sm overflow-hidden border border-outline-variant/30 flex flex-col">
<div class="p-md flex items-center justify-between border-b border-outline-variant/20">
<h3 class="font-h3 text-lg font-bold text-on-surface">Recent Placement Drives</h3>
<a href="${pageContext.request.contextPath}/admin/drives" class="text-secondary text-button font-button flex items-center gap-1 hover:underline">
                            View All <span class="material-symbols-outlined text-sm" data-icon="arrow_forward">arrow_forward</span>
</a>
</div>
<div class="overflow-x-auto">
<table class="w-full text-left">
<thead class="bg-surface-container-low/50">
<tr>
<th class="px-md py-4 text-label-caps text-on-surface-variant">Company Name</th>
<th class="px-md py-4 text-label-caps text-on-surface-variant">Job Role</th>
<th class="px-md py-4 text-label-caps text-on-surface-variant text-center">Package</th>
<th class="px-md py-4 text-label-caps text-on-surface-variant">Status</th>
<th class="px-md py-4 text-label-caps text-on-surface-variant">Date</th>
</tr>
</thead>
<tbody class="divide-y divide-outline-variant/10">
<c:forEach var="drive" items="${recentDrives}">
<tr class="hover:bg-surface-container-low transition-colors group">
<td class="px-md py-4">
<div class="flex items-center gap-3">
<div class="w-8 h-8 rounded-full bg-surface-container-high flex items-center justify-center">
<span class="material-symbols-outlined text-sm" data-icon="corporate_fare">corporate_fare</span>
</div>
<span class="font-medium text-on-surface">${drive.companyName}</span>
</div>
</td>
<td class="px-md py-4 text-on-surface-variant">${drive.jobRole}</td>
<td class="px-md py-4 text-center font-bold text-secondary">${drive.packageLpa} LPA</td>
<td class="px-md py-4">
<span class="px-2 py-1 bg-secondary-container/20 text-secondary text-xs font-bold rounded-full border border-secondary/20">${drive.status}</span>
</td>
<td class="px-md py-4 text-on-surface-variant text-sm">${drive.driveDate}</td>
</tr>
</c:forEach>
<c:if test="${empty recentDrives}">
<tr>
<td colspan="5" class="px-md py-4 text-center text-on-surface-variant">No active drives available</td>
</tr>
</c:if>
</tbody>
</table>
</div>
</div>
<!-- Secondary Asymmetric Info Card -->
<div class="flex flex-col gap-md">
<!-- Placement Performance Chart Placeholder -->
<div class="glass-card rounded-xl shadow-sm p-md flex-1">
<h3 class="font-h3 text-lg font-bold text-on-surface mb-sm">Yearly Trend</h3>
<canvas id="placementChart"></canvas>
</div>
<!-- CTA Glass Card -->
<div class="bg-primary-container rounded-xl shadow-md p-md text-on-secondary-container">
<div class="flex items-center gap-3 mb-sm">
<span class="material-symbols-outlined text-secondary-fixed" data-icon="auto_awesome">auto_awesome</span>
<span class="text-label-caps tracking-widest text-secondary-fixed">INSIGHTS</span>
</div>
<p class="font-body-md mb-md leading-relaxed opacity-90">
                            Recent placement drives are seeing active student registration. Monitor session slots regularly.
                        </p>
<a href="${pageContext.request.contextPath}/admin/drives" class="block w-full py-3 bg-secondary text-on-secondary font-button rounded-lg hover:bg-secondary/90 transition-colors text-center">
                            Manage Session
                        </a>
</div>
</div>
</div>

<!-- Student Placement Tracking Section -->
<div class="mt-lg">
    <div class="glass-card rounded-xl shadow-sm overflow-hidden border border-outline-variant/30">
        <div class="p-md flex items-center justify-between border-b border-outline-variant/20 bg-surface-container-low/30">
            <div>
                <h3 class="font-h3 text-lg font-bold text-on-surface">Live Placement Tracking</h3>
                <p class="text-xs text-on-surface-variant font-medium mt-1">Real-time status of all student applications and interview rounds</p>
            </div>
            <button class="bg-secondary/10 text-secondary p-2 rounded-lg hover:bg-secondary/20 transition-all">
                <span class="material-symbols-outlined" data-icon="filter_list">filter_list</span>
            </button>
        </div>
        <div class="overflow-x-auto">
            <table class="w-full text-left">
                <thead class="bg-surface-container-low/50">
                    <tr>
                        <th class="px-md py-4 text-label-caps text-on-surface-variant">Student Name</th>
                        <th class="px-md py-4 text-label-caps text-on-surface-variant">Company</th>
                        <th class="px-md py-4 text-label-caps text-on-surface-variant">Job Role</th>
                        <th class="px-md py-4 text-label-caps text-on-surface-variant">Current Stage</th>
                        <th class="px-md py-4 text-label-caps text-on-surface-variant text-center">Status</th>
                        <th class="px-md py-4 text-label-caps text-on-surface-variant">Applied Date</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-outline-variant/10">
                    <c:forEach var="app" items="${placementProgress}">
                        <tr class="hover:bg-surface-container-low/50 transition-colors group">
                            <td class="px-md py-4">
                                <div class="flex items-center gap-3">
                                    <div class="w-8 h-8 rounded-full bg-primary/10 flex items-center justify-center text-primary">
                                        <span class="material-symbols-outlined text-sm" data-icon="person">person</span>
                                    </div>
                                    <div>
                                        <p class="font-bold text-on-surface"><c:out value="${app.studentName}"/></p>
                                        <p class="text-[10px] text-on-surface-variant font-bold uppercase"><c:out value="${app.studentDepartment}"/></p>
                                    </div>
                                </div>
                            </td>
                            <td class="px-md py-4">
                                <span class="font-medium text-on-surface"><c:out value="${app.companyName}"/></span>
                            </td>
                            <td class="px-md py-4 text-on-surface-variant"><c:out value="${app.jobRole}"/></td>
                            <td class="px-md py-4">
                                <div class="flex items-center gap-2">
                                    <span class="w-2 h-2 rounded-full bg-secondary"></span>
                                    <span class="text-sm font-semibold text-on-surface"><c:out value="${not empty app.currentRound ? app.currentRound : 'Initial Application'}"/></span>
                                </div>
                            </td>
                            <td class="px-md py-4 text-center">
                                <span class="px-3 py-1 rounded-full text-[10px] font-bold uppercase tracking-wider
                                    ${app.status == 'SELECTED' ? 'bg-green-100 text-green-700' : 
                                      (app.status == 'REJECTED' ? 'bg-red-100 text-red-700' : 
                                      (app.status == 'INTERVIEW_SCHEDULED' ? 'bg-blue-100 text-blue-700' : 'bg-surface-container-high text-on-surface-variant'))}">
                                    <c:out value="${app.status}"/>
                                </span>
                            </td>
                            <td class="px-md py-4 text-on-surface-variant text-sm">
                                ${app.appliedAt}
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty placementProgress}">
                        <tr>
                            <td colspan="6" class="px-md py-8 text-center text-on-surface-variant italic">
                                No placement activity recorded yet.
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>
</div>
<jsp:include page="includes/layout_footer.jsp" />
</main>
<!-- FAB for quick actions -->
<button id="fabBtn" class="fixed bottom-gutter right-gutter w-14 h-14 bg-secondary text-on-secondary rounded-full shadow-lg flex items-center justify-center hover:scale-110 active:scale-95 transition-all z-50">
<span class="material-symbols-outlined" data-icon="add">add</span>
</button>

<!-- Quick Action Modal -->
<div id="quickModal" class="fixed inset-0 bg-black/50 backdrop-blur-sm z-[60] hidden flex items-center justify-center p-md">
    <div class="glass-card w-full max-w-md rounded-2xl overflow-hidden shadow-2xl animate-in zoom-in duration-300">
        <div class="p-md bg-secondary text-on-secondary flex justify-between items-center">
            <h3 class="font-h3 text-lg">Quick Action</h3>
            <button onclick="toggleModal()" class="material-symbols-outlined hover:bg-white/20 rounded-full p-1">close</button>
        </div>
        <div class="p-md space-y-md">
            <div class="grid grid-cols-2 gap-md">
                <button onclick="showForm('student')" class="p-md rounded-xl border border-outline-variant hover:bg-secondary/5 hover:border-secondary transition-all flex flex-col items-center gap-2">
                    <span class="material-symbols-outlined text-3xl text-secondary">school</span>
                    <span class="font-body-md font-bold">Add Student</span>
                </button>
                <button onclick="showForm('company')" class="p-md rounded-xl border border-outline-variant hover:bg-secondary/5 hover:border-secondary transition-all flex flex-col items-center gap-2">
                    <span class="material-symbols-outlined text-3xl text-secondary">business</span>
                    <span class="font-body-md font-bold">Add Company</span>
                </button>
            </div>
            
            <div id="quickFormContainer" class="hidden border-t border-outline-variant pt-md">
                <!-- Forms will be injected here or toggled -->
                <form id="quickStudentForm" action="${pageContext.request.contextPath}/admin/students" method="post" class="hidden space-y-md">
                    <input type="hidden" name="action" value="add">
                    <div class="grid grid-cols-2 gap-2">
                        <input type="text" name="username" placeholder="Username" class="w-full rounded-lg border-outline-variant" required>
                        <input type="password" name="password" placeholder="Password" class="w-full rounded-lg border-outline-variant" required>
                    </div>
                    <input type="text" name="fullName" placeholder="Full Name" class="w-full rounded-lg border-outline-variant" required>
                    <input type="email" name="email" placeholder="Email Address" class="w-full rounded-lg border-outline-variant" required>
                    <div class="grid grid-cols-2 gap-2">
                        <select name="department" class="w-full rounded-lg border-outline-variant">
                            <option>Computer Science</option>
                            <option>Information Technology</option>
                            <option>Electronics</option>
                        </select>
                        <input type="number" step="0.01" name="cgpa" placeholder="CGPA" class="w-full rounded-lg border-outline-variant" required>
                    </div>
                    <input type="text" name="contact" placeholder="Contact Number" class="w-full rounded-lg border-outline-variant" required>
                    <button type="submit" class="w-full py-2 bg-secondary text-on-secondary rounded-lg font-button">Create Student</button>
                </form>
                
                <form id="quickCompanyForm" action="${pageContext.request.contextPath}/admin/companies" method="post" class="hidden space-y-md">
                    <input type="hidden" name="action" value="add">
                    <div class="grid grid-cols-2 gap-2">
                        <input type="text" name="username" placeholder="Username" class="w-full rounded-lg border-outline-variant" required>
                        <input type="password" name="password" placeholder="Password" class="w-full rounded-lg border-outline-variant" required>
                    </div>
                    <input type="text" name="companyName" placeholder="Company Name" class="w-full rounded-lg border-outline-variant" required>
                    <input type="email" name="email" placeholder="Email" class="w-full rounded-lg border-outline-variant" required>
                    <input type="text" name="website" placeholder="Website (e.g., https://google.com)" class="w-full rounded-lg border-outline-variant">
                    <input type="text" name="contactPhone" placeholder="Contact Phone" class="w-full rounded-lg border-outline-variant">
                    <textarea name="description" placeholder="Short Description" class="w-full rounded-lg border-outline-variant" rows="2"></textarea>
                    <button type="submit" class="w-full py-2 bg-secondary text-on-secondary rounded-lg font-button">Create Company</button>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
    function toggleModal() {
        const modal = document.getElementById('quickModal');
        modal.classList.toggle('hidden');
        document.getElementById('quickFormContainer').classList.add('hidden');
    }
    
    function showForm(type) {
        document.getElementById('quickFormContainer').classList.remove('hidden');
        document.getElementById('quickStudentForm').classList.toggle('hidden', type !== 'student');
        document.getElementById('quickCompanyForm').classList.toggle('hidden', type !== 'company');
    }

    document.getElementById('fabBtn').onclick = toggleModal;

    // Initialize Placement Trend Chart
    document.addEventListener('DOMContentLoaded', function() {
        const ctx = document.getElementById('placementChart');
        if (ctx) {
            fetch('${pageContext.request.contextPath}/api/dashboard-data')
                .then(response => response.json())
                .then(data => {
                    const labels = Object.keys(data).reverse();
                    const values = Object.values(data).reverse();
                    
                    new Chart(ctx, {
                        type: 'bar',
                        data: {
                            labels: labels,
                            datasets: [{
                                label: 'Selected Students',
                                data: values,
                                backgroundColor: '#0051d5',
                                borderRadius: 8,
                                borderSkipped: false,
                            }]
                        },
                        options: {
                            responsive: true,
                            maintainAspectRatio: false,
                            plugins: {
                                legend: { display: false }
                            },
                            scales: {
                                y: { beginAtZero: true, grid: { display: false } },
                                x: { grid: { display: false } }
                            }
                        }
                    });
                })
                .catch(err => console.error('Error fetching chart data:', err));
        }

        // Global Search Logic
        const searchInput = document.querySelector('input[placeholder="Search students, companies..."]');
        if (searchInput) {
            searchInput.addEventListener('keypress', function(e) {
                if (e.key === 'Enter') {
                    const query = e.target.value;
                    if (query.length > 2) {
                        window.location.href = '${pageContext.request.contextPath}/search?q=' + encodeURIComponent(query);
                    }
                }
            });
        }

        // Dropdown Toggles
        const notifBtn = document.getElementById('notifBtn');
        const notifDropdown = document.getElementById('notifDropdown');
        const profileBtn = document.getElementById('profileBtn');
        const profileDropdown = document.getElementById('profileDropdown');

        notifBtn.onclick = (e) => {
            e.stopPropagation();
            notifDropdown.classList.toggle('hidden');
            profileDropdown.classList.add('hidden');
            if (!notifDropdown.classList.contains('hidden')) {
                fetchNotifications();
            }
        };

        profileBtn.onclick = (e) => {
            e.stopPropagation();
            profileDropdown.classList.toggle('hidden');
            notifDropdown.classList.add('hidden');
        };

        window.onclick = () => {
            notifDropdown.classList.add('hidden');
            profileDropdown.classList.add('hidden');
        };

        function fetchNotifications() {
            const list = document.getElementById('notifList');
            const badge = document.getElementById('notifBadge');
            
            fetch('${pageContext.request.contextPath}/api/notifications')
                .then(res => res.json())
                .then(data => {
                    if (!data || data.length === 0) {
                        list.innerHTML = '<div class="p-4 text-center text-on-surface-variant text-sm">No new notifications</div>';
                        badge.classList.add('hidden');
                    } else {
                        badge.classList.remove('hidden');
                        list.innerHTML = data.map(n => `
                            <div class="p-4 hover:bg-surface-container-high transition-colors cursor-pointer" onclick="markRead(\${n.id})">
                                <p class="text-sm font-bold text-on-surface">\${n.title}</p>
                                <p class="text-xs text-on-surface-variant mt-1">\${n.message}</p>
                                <p class="text-[10px] text-on-surface-variant/60 mt-2">\${n.createdAt}</p>
                            </div>
                        `).join('');
                    }
                })
                .catch(err => {
                    list.innerHTML = '<div class="p-4 text-center text-error text-sm">Failed to load notifications</div>';
                });
        }

        window.markRead = function(id) {
            const params = new URLSearchParams();
            params.append('action', 'markRead');
            params.append('id', id);
            
            fetch('${pageContext.request.contextPath}/api/notifications', { 
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: params
            }).then(() => fetchNotifications());
        };

        window.markAllRead = function() {
            const params = new URLSearchParams();
            params.append('action', 'markAllRead');
            
            fetch('${pageContext.request.contextPath}/api/notifications', { 
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: params
            }).then(() => {
                fetchNotifications();
                notifDropdown.classList.add('hidden');
            });
        };

        // Form Validation
        const validateForm = (formId) => {
            const form = document.getElementById(formId);
            form.onsubmit = (e) => {
                const inputs = form.querySelectorAll('input[required]');
                let valid = true;
                inputs.forEach(input => {
                    if (!input.value.trim()) {
                        input.classList.add('border-error');
                        valid = false;
                    } else {
                        input.classList.remove('border-error');
                    }
                });

                const email = form.querySelector('input[type="email"]');
                if (email && email.value) {
                    const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                    if (!re.test(email.value)) {
                        email.classList.add('border-error');
                        valid = false;
                    }
                }

                if (!valid) {
                    e.preventDefault();
                    // Optional: Show a toast or error message
                }
            };
        };

        validateForm('quickStudentForm');
        validateForm('quickCompanyForm');

        // Initial fetch for badge
        fetchNotifications();
    });
</script>
    </main>
</body>
</html>