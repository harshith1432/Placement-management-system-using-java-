<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="includes/layout_head.jsp" />
</head>
<body class="bg-background font-inter text-on-surface">
    <jsp:include page="includes/layout_sidebar.jsp" />

    <main class="main-content min-h-screen flex flex-col transition-all duration-300 md:ml-64">
        <jsp:include page="includes/layout_header.jsp" />

        <!-- Page Header -->
        <div class="px-8 py-6 flex flex-col md:flex-row md:items-center justify-between gap-4 border-b border-outline-variant bg-surface/50 backdrop-blur-sm">
            <div>
                <h1 class="text-2xl font-bold text-on-surface">Profile Settings</h1>
                <p class="text-on-surface-variant">Manage your account and security preferences</p>
            </div>
        </div>

        <div class="p-8 max-w-5xl">
            <c:if test="${not empty success}">
                <div class="mb-6 p-4 bg-green-100 border border-green-200 text-green-800 rounded-xl flex items-center gap-3">
                    <span class="material-symbols-outlined">check_circle</span>
                    ${success}
                </div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="mb-6 p-4 bg-red-100 border border-red-200 text-red-800 rounded-xl flex items-center gap-3">
                    <span class="material-symbols-outlined">error</span>
                    ${error}
                </div>
            </c:if>

            <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
                <!-- Sidebar Info -->
                <div class="md:col-span-1 space-y-6">
                    <div class="glass-card rounded-2xl p-6 text-center border border-outline-variant/30">
                        <div class="w-24 h-24 bg-secondary/10 rounded-full flex items-center justify-center mx-auto mb-4 border-4 border-surface shadow-inner">
                            <span class="material-symbols-outlined text-4xl text-secondary">person</span>
                        </div>
                        <h2 class="text-xl font-bold text-on-surface">${sessionScope.user.username}</h2>
                        <p class="text-on-surface-variant text-sm capitalize font-medium px-3 py-1 bg-surface-container-high rounded-full inline-block mt-2">${sessionScope.user.role}</p>
                    </div>
                </div>

                <!-- Settings Forms -->
                <div class="md:col-span-2 space-y-6">
                    <!-- Update Username -->
                    <div class="glass-card rounded-2xl p-8 shadow-sm border border-outline-variant/30">
                        <h3 class="text-lg font-bold mb-6 flex items-center gap-3 text-on-surface">
                            <span class="p-2 bg-secondary/10 text-secondary rounded-lg material-symbols-outlined">edit</span>
                            General Settings
                        </h3>
                        <form action="${pageContext.request.contextPath}/admin/profile" method="post" class="space-y-4">
                            <input type="hidden" name="action" value="updateUsername">
                            <div>
                                <label class="block text-sm font-medium text-on-surface-variant mb-1.5">Username</label>
                                <input type="text" name="username" value="${sessionScope.user.username}" 
                                       class="w-full rounded-xl border-outline-variant bg-surface-container-low focus:ring-secondary focus:border-secondary px-4 py-2.5 transition-all" required>
                            </div>
                            <div class="pt-2">
                                <button type="submit" class="bg-secondary text-white px-8 py-2.5 rounded-xl hover:bg-secondary/90 transition-all font-medium shadow-lg shadow-secondary/20">Update Username</button>
                            </div>
                        </form>
                    </div>

                    <!-- Update Password -->
                    <div class="glass-card rounded-2xl p-8 shadow-sm border border-outline-variant/30">
                        <h3 class="text-lg font-bold mb-6 flex items-center gap-3 text-on-surface">
                            <span class="p-2 bg-secondary/10 text-secondary rounded-lg material-symbols-outlined">lock</span>
                            Security Settings
                        </h3>
                        <form action="${pageContext.request.contextPath}/admin/profile" method="post" class="space-y-4" id="passwordForm">
                            <input type="hidden" name="action" value="updatePassword">
                            <div>
                                <label class="block text-sm font-medium text-on-surface-variant mb-1.5">New Password</label>
                                <input type="password" name="newPassword" id="newPassword" 
                                       class="w-full rounded-xl border-outline-variant bg-surface-container-low focus:ring-secondary focus:border-secondary px-4 py-2.5 transition-all" required>
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-on-surface-variant mb-1.5">Confirm New Password</label>
                                <input type="password" name="confirmPassword" id="confirmPassword" 
                                       class="w-full rounded-xl border-outline-variant bg-surface-container-low focus:ring-secondary focus:border-secondary px-4 py-2.5 transition-all" required>
                            </div>
                            <div id="passwordError" class="text-red-600 text-sm font-medium hidden flex items-center gap-2">
                                <span class="material-symbols-outlined text-sm">warning</span>
                                Passwords do not match.
                            </div>
                            <div class="pt-2">
                                <button type="submit" class="bg-secondary text-white px-8 py-2.5 rounded-xl hover:bg-secondary/90 transition-all font-medium shadow-lg shadow-secondary/20">Update Password</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="includes/layout_footer.jsp" />
    </main>

    <script>
        document.getElementById('passwordForm').onsubmit = function(e) {
            const pass = document.getElementById('newPassword').value;
            const confirm = document.getElementById('confirmPassword').value;
            const error = document.getElementById('passwordError');
            
            if (pass !== confirm) {
                e.preventDefault();
                error.classList.remove('hidden');
            } else {
                error.classList.add('hidden');
            }
        };
    </script>
</body>
</html>
