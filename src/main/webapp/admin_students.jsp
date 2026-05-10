<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%-- Redundant session check removed, handled by AuthenticationFilter --%>
<!DOCTYPE html>
<html class="light" lang="en">
<head>
    <title>Manage Students - Placement Portal</title>
    <jsp:include page="includes/layout_head.jsp" />
</head>
<body class="bg-background font-body text-on-background min-h-screen">
    <jsp:include page="includes/layout_sidebar.jsp" />

    <main class="main-content min-h-screen flex flex-col transition-all duration-300 md:ml-64">
        <jsp:include page="includes/layout_header.jsp" />

        <!-- Page Header -->
        <div class="px-8 py-6 flex flex-col md:flex-row md:items-center justify-between gap-4 border-b border-outline-variant bg-surface/50 backdrop-blur-sm">
            <div>
                <h1 class="text-2xl font-bold text-on-surface">Student Records</h1>
                <p class="text-on-surface-variant">View and manage all registered students and their academic profiles</p>
            </div>
            <button onclick="openModal('addModal')" class="flex items-center gap-2 px-6 py-3 bg-secondary text-white rounded-xl hover:bg-secondary/90 shadow-lg shadow-secondary/20 transition-all font-medium">
                <span class="material-symbols-outlined">person_add</span>
                <span>Add Student</span>
            </button>
        </div>

        <div class="p-8">
            <c:if test="${not empty param.success}">
                <div class="mb-6 p-4 bg-green-100 text-green-700 border border-green-200 rounded-xl flex items-center gap-3 animate-fade-in">
                    <span class="material-symbols-outlined">check_circle</span>
                    <p class="font-medium">${param.success}</p>
                </div>
            </c:if>
            <c:if test="${not empty param.error}">
                <div class="mb-6 p-4 bg-red-100 text-red-700 border border-red-200 rounded-xl flex items-center gap-3 animate-fade-in">
                    <span class="material-symbols-outlined">error</span>
                    <p class="font-medium">${param.error}</p>
                </div>
            </c:if>

            <div class="glass-card rounded-2xl border border-outline-variant overflow-hidden shadow-sm">
                <div class="overflow-x-auto">
                    <table class="w-full text-left border-collapse" id="studentTable">
                        <thead>
                            <tr class="text-on-surface-variant text-sm border-b border-outline-variant bg-surface-container-low/50">
                                <th class="px-6 py-4 font-semibold uppercase tracking-wider">Full Name</th>
                                <th class="px-6 py-4 font-semibold uppercase tracking-wider">Email</th>
                                <th class="px-6 py-4 font-semibold uppercase tracking-wider">Department</th>
                                <th class="px-6 py-4 font-semibold uppercase tracking-wider">CGPA</th>
                                <th class="px-6 py-4 font-semibold uppercase tracking-wider text-right">Actions</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-outline-variant/30">
                            <c:forEach var="student" items="${students}">
                                <tr class="hover:bg-surface-container-low/50 transition-colors group">
                                    <td class="px-6 py-4">
                                        <div class="font-medium text-on-surface">${student.fullName}</div>
                                    </td>
                                    <td class="px-6 py-4 text-on-surface-variant">${student.email}</td>
                                    <td class="px-6 py-4">
                                        <span class="px-3 py-1 bg-surface-container-high rounded-full text-xs font-medium text-on-surface">
                                            ${student.department}
                                        </span>
                                    </td>
                                    <td class="px-6 py-4">
                                        <span class="font-bold text-secondary">${student.cgpa}</span>
                                    </td>
                                    <td class="px-6 py-4 text-right">
                                        <div class="flex items-center justify-end gap-2">
                                            <button 
                                                    data-id="${student.userId}"
                                                    data-name="${student.fullName}"
                                                    data-email="${student.email}"
                                                    data-dept="${student.department}"
                                                    data-cgpa="${student.cgpa}"
                                                    data-contact="${student.contactNumber}"
                                                    data-roll="${student.rollNumber}"
                                                    data-semester="${student.semester}"
                                                    onclick="editStudentFromBtn(this)"
                                                    class="p-2 text-on-surface-variant hover:text-secondary hover:bg-secondary/10 rounded-full transition-all"
                                                    title="Edit Student">
                                                <span class="material-symbols-outlined text-[20px]">edit</span>
                                            </button>
                                            <button onclick="confirmDelete(${student.userId})" 
                                                    class="p-2 text-on-surface-variant hover:text-error hover:bg-error/10 rounded-full transition-all"
                                                    title="Delete Student">
                                                <span class="material-symbols-outlined text-[20px]">delete</span>
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty students}">
                                <tr>
                                    <td colspan="5" class="px-6 py-20 text-center">
                                        <div class="flex flex-col items-center gap-3 text-on-surface-variant">
                                            <span class="material-symbols-outlined text-4xl opacity-20">group_off</span>
                                            <p>No students registered yet.</p>
                                        </div>
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <jsp:include page="includes/layout_footer.jsp" />
    </main>

    <!-- Add Student Modal -->
    <div id="addModal" class="modal">
        <div class="glass-card p-8 rounded-3xl w-full max-w-lg shadow-2xl border border-outline-variant animate-scale-up">
            <div class="flex justify-between items-center mb-6">
                <h3 class="text-2xl font-bold text-on-surface">Add New Student</h3>
                <button onclick="closeModal('addModal')" class="p-2 hover:bg-surface-container-high rounded-full transition-colors">
                    <span class="material-symbols-outlined">close</span>
                </button>
            </div>
            <form action="${pageContext.request.contextPath}/admin/students" method="POST" class="space-y-5">
                <input type="hidden" name="action" value="add">
                
                <div class="space-y-2">
                    <label class="text-sm font-semibold text-on-surface-variant px-1">Full Name</label>
                    <input type="text" name="fullName" required class="w-full px-4 py-3 rounded-xl bg-surface-container-low border border-outline-variant focus:border-secondary focus:ring-2 focus:ring-secondary/20 transition-all">
                </div>

                <div class="grid grid-cols-2 gap-4">
                    <div class="space-y-2">
                        <label class="text-sm font-semibold text-on-surface-variant px-1">Username</label>
                        <input type="text" name="username" required class="w-full px-4 py-3 rounded-xl bg-surface-container-low border border-outline-variant focus:border-secondary focus:ring-2 focus:ring-secondary/20 transition-all">
                    </div>
                    <div class="space-y-2">
                        <label class="text-sm font-semibold text-on-surface-variant px-1">Password</label>
                        <input type="password" name="password" class="w-full px-4 py-3 rounded-xl bg-surface-container-low border border-outline-variant focus:border-secondary focus:ring-2 focus:ring-secondary/20 transition-all" placeholder="Default: student123">
                    </div>
                </div>

                <div class="grid grid-cols-2 gap-4">
                    <div class="space-y-2">
                        <label class="text-sm font-semibold text-on-surface-variant px-1">Email</label>
                        <input type="email" name="email" required class="w-full px-4 py-3 rounded-xl bg-surface-container-low border border-outline-variant focus:border-secondary focus:ring-2 focus:ring-secondary/20 transition-all">
                    </div>
                    <div class="space-y-2">
                        <label class="text-sm font-semibold text-on-surface-variant px-1">Department</label>
                        <select name="department" class="w-full px-4 py-3 rounded-xl bg-surface-container-low border border-outline-variant focus:border-secondary focus:ring-2 focus:ring-secondary/20 transition-all">
                            <option value="Computer Science">Computer Science</option>
                            <option value="Information Technology">Information Technology</option>
                            <option value="Electronics">Electronics</option>
                            <option value="Mechanical">Mechanical</option>
                            <option value="Civil">Civil</option>
                        </select>
                    </div>
                </div>

                <div class="grid grid-cols-2 gap-4">
                    <div class="space-y-2">
                        <label class="text-sm font-semibold text-on-surface-variant px-1">Roll Number</label>
                        <input type="text" name="rollNumber" required class="w-full px-4 py-3 rounded-xl bg-surface-container-low border border-outline-variant focus:border-secondary focus:ring-2 focus:ring-secondary/20 transition-all">
                    </div>
                    <div class="space-y-2">
                        <label class="text-sm font-semibold text-on-surface-variant px-1">Semester</label>
                        <select name="semester" class="w-full px-4 py-3 rounded-xl bg-surface-container-low border border-outline-variant focus:border-secondary focus:ring-2 focus:ring-secondary/20 transition-all">
                            <c:forEach var="i" begin="1" end="8">
                                <option value="${i}">Semester ${i}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>

                <div class="grid grid-cols-2 gap-4">
                    <div class="space-y-2">
                        <label class="text-sm font-semibold text-on-surface-variant px-1">CGPA</label>
                        <input type="number" step="0.01" name="cgpa" required class="w-full px-4 py-3 rounded-xl bg-surface-container-low border border-outline-variant focus:border-secondary focus:ring-2 focus:ring-secondary/20 transition-all">
                    </div>
                    <div class="space-y-2">
                        <label class="text-sm font-semibold text-on-surface-variant px-1">Contact</label>
                        <input type="text" name="contactNumber" class="w-full px-4 py-3 rounded-xl bg-surface-container-low border border-outline-variant focus:border-secondary focus:ring-2 focus:ring-secondary/20 transition-all">
                    </div>
                </div>

                <div class="pt-4">
                    <button type="submit" class="w-full py-4 bg-secondary text-white rounded-xl font-bold shadow-lg shadow-secondary/30 hover:bg-secondary/90 transition-all">
                        Register Student
                    </button>
                </div>
            </form>
        </div>
    </div>

    <!-- Edit Student Modal -->
    <div id="editModal" class="modal">
        <div class="glass-card p-8 rounded-3xl w-full max-w-lg shadow-2xl border border-outline-variant animate-scale-up">
            <div class="flex justify-between items-center mb-6">
                <h3 class="text-2xl font-bold text-on-surface">Edit Student Profile</h3>
                <button onclick="closeModal('editModal')" class="p-2 hover:bg-surface-container-high rounded-full transition-colors">
                    <span class="material-symbols-outlined">close</span>
                </button>
            </div>
            <form action="${pageContext.request.contextPath}/admin/students" method="POST" class="space-y-5">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="userId" id="edit_userId">
                
                <div class="space-y-2">
                    <label class="text-sm font-semibold text-on-surface-variant px-1">Full Name</label>
                    <input type="text" name="fullName" id="editFullName" required class="w-full px-4 py-3 rounded-xl bg-surface-container-low border border-outline-variant focus:border-secondary focus:ring-2 focus:ring-secondary/20 transition-all">
                </div>

                <div class="grid grid-cols-2 gap-4">
                    <div class="space-y-2">
                        <label class="text-sm font-semibold text-on-surface-variant px-1">Email</label>
                        <input type="email" name="email" id="editEmail" readonly class="w-full px-4 py-3 rounded-xl bg-surface-container-low border border-outline-variant opacity-70 cursor-not-allowed">
                    </div>
                    <div class="space-y-2">
                        <label class="text-sm font-semibold text-on-surface-variant px-1">Department</label>
                        <select name="department" id="editDepartment" class="w-full px-4 py-3 rounded-xl bg-surface-container-low border border-outline-variant focus:border-secondary focus:ring-2 focus:ring-secondary/20 transition-all">
                            <option value="Computer Science">Computer Science</option>
                            <option value="Information Technology">Information Technology</option>
                            <option value="Electronics">Electronics</option>
                            <option value="Mechanical">Mechanical</option>
                            <option value="Civil">Civil</option>
                        </select>
                    </div>
                </div>

                <div class="grid grid-cols-2 gap-4">
                    <div class="space-y-2">
                        <label class="text-sm font-semibold text-on-surface-variant px-1">Roll Number</label>
                        <input type="text" name="rollNumber" id="editRollNumber" required class="w-full px-4 py-3 rounded-xl bg-surface-container-low border border-outline-variant focus:border-secondary focus:ring-2 focus:ring-secondary/20 transition-all">
                    </div>
                    <div class="space-y-2">
                        <label class="text-sm font-semibold text-on-surface-variant px-1">Semester</label>
                        <select name="semester" id="editSemester" class="w-full px-4 py-3 rounded-xl bg-surface-container-low border border-outline-variant focus:border-secondary focus:ring-2 focus:ring-secondary/20 transition-all">
                            <c:forEach var="i" begin="1" end="8">
                                <option value="${i}">Semester ${i}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>

                <div class="grid grid-cols-2 gap-4">
                    <div class="space-y-2">
                        <label class="text-sm font-semibold text-on-surface-variant px-1">CGPA</label>
                        <input type="number" step="0.01" name="cgpa" id="editCgpa" required class="w-full px-4 py-3 rounded-xl bg-surface-container-low border border-outline-variant focus:border-secondary focus:ring-2 focus:ring-secondary/20 transition-all">
                    </div>
                    <div class="space-y-2">
                        <label class="text-sm font-semibold text-on-surface-variant px-1">Contact</label>
                        <input type="text" name="contactNumber" id="editContact" class="w-full px-4 py-3 rounded-xl bg-surface-container-low border border-outline-variant focus:border-secondary focus:ring-2 focus:ring-secondary/20 transition-all">
                    </div>
                </div>

                <div class="pt-4">
                    <button type="submit" class="w-full py-4 bg-secondary text-white rounded-xl font-bold shadow-lg shadow-secondary/30 hover:bg-secondary/90 transition-all">
                        Update Student
                    </button>
                </div>
            </form>
        </div>
    </div>

    <script>
        function openModal(id) {
            const modal = document.getElementById(id);
            modal.classList.add('active');
            document.body.classList.add('overflow-hidden');
        }

        function closeModal(id) {
            const modal = document.getElementById(id);
            modal.classList.remove('active');
            document.body.classList.remove('overflow-hidden');
        }

        function editStudentFromBtn(btn) {
            const id = btn.getAttribute('data-id');
            const name = btn.getAttribute('data-name');
            const email = btn.getAttribute('data-email');
            const dept = btn.getAttribute('data-dept');
            const cgpa = btn.getAttribute('data-cgpa');
            const contact = btn.getAttribute('data-contact');
            const roll = btn.getAttribute('data-roll');
            const semester = btn.getAttribute('data-semester');

            document.getElementById('edit_userId').value = id;
            document.getElementById('editFullName').value = name;
            document.getElementById('editEmail').value = email;
            document.getElementById('editDepartment').value = dept;
            document.getElementById('editCgpa').value = cgpa;
            document.getElementById('editContact').value = contact;
            document.getElementById('editRollNumber').value = roll;
            document.getElementById('editSemester').value = semester;

            openModal('editModal');
        }

        function confirmDelete(id) {
            if (confirm('Are you sure you want to delete this student record? This action cannot be undone.')) {
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '${pageContext.request.contextPath}/admin/students';
                
                const actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'action';
                actionInput.value = 'delete';
                
                const idInput = document.createElement('input');
                idInput.type = 'hidden';
                idInput.name = 'userId';
                idInput.value = id;
                
                form.appendChild(actionInput);
                form.appendChild(idInput);
                document.body.appendChild(form);
                form.submit();
            }
        }

        // Global Search listener
        document.addEventListener('globalSearch', (e) => {
            const searchTerm = e.detail.value;
            const rows = document.querySelectorAll('#studentTable tbody tr');
            
            rows.forEach(row => {
                if (row.querySelector('td[colspan]')) return; // Skip "No students" row
                const text = row.textContent.toLowerCase();
                row.style.display = text.includes(searchTerm) ? '' : 'none';
            });
        });
    </script>
</body>
</html>
