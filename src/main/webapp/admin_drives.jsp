<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html class="light" lang="en">
<head>
    <title>Placement Portal - Admin Drives</title>
    <jsp:include page="includes/layout_head.jsp" />
</head>
<body class="bg-background font-inter text-on-surface">
    <jsp:include page="includes/layout_sidebar.jsp" />

    <main class="main-content min-h-screen flex flex-col transition-all duration-300 md:ml-64">
        <jsp:include page="includes/layout_header.jsp" />

        <!-- Page Header -->
        <div class="px-8 py-6 flex flex-col md:flex-row md:items-center justify-between gap-4 border-b border-outline-variant bg-surface/50 backdrop-blur-sm">
            <div>
                <h1 class="text-2xl font-bold text-on-surface">Placement Drives</h1>
                <p class="text-on-surface-variant">Manage recruitment drives and requirements</p>
            </div>
            <div class="flex items-center gap-3">
                <button onclick="openModal('addModal')" class="bg-secondary text-white px-5 py-2.5 rounded-xl flex items-center gap-2 hover:bg-secondary/90 transition-all shadow-lg shadow-secondary/20 font-medium">
                    <span class="material-symbols-outlined text-[20px]">add</span>
                    <span>New Drive</span>
                </button>
            </div>
        </div>

        <div class="p-6">
            <c:if test="${not empty param.success}">
                <div class="mb-4 p-4 bg-green-100 text-green-700 border border-green-200 rounded-lg flex items-center gap-2">
                    <span class="material-symbols-outlined">check_circle</span>
                    ${param.success}
                </div>
            </c:if>
            <c:if test="${not empty param.error}">
                <div class="mb-4 p-4 bg-red-100 text-red-700 border border-red-200 rounded-lg flex items-center gap-2">
                    <span class="material-symbols-outlined">error</span>
                    ${param.error}
                </div>
            </c:if>

            <div class="glass-card rounded-2xl shadow-sm overflow-hidden border border-outline-variant/30">
                <table id="drivesTable" class="w-full text-left border-collapse">
                    <thead>
                        <tr class="bg-surface-container-low/50 border-b border-outline-variant/30">
                            <th class="px-6 py-4 text-xs font-bold text-on-surface-variant uppercase tracking-wider">Drive Details</th>
                            <th class="px-6 py-4 text-xs font-bold text-on-surface-variant uppercase tracking-wider">Requirements</th>
                            <th class="px-6 py-4 text-xs font-bold text-on-surface-variant uppercase tracking-wider">Package</th>
                            <th class="px-6 py-4 text-xs font-bold text-on-surface-variant uppercase tracking-wider">Date</th>
                            <th class="px-6 py-4 text-xs font-bold text-on-surface-variant uppercase tracking-wider">Status</th>
                            <th class="px-6 py-4 text-xs font-bold text-on-surface-variant uppercase tracking-wider text-right">Actions</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-outline-variant/20">
                        <c:forEach var="drive" items="${drives}">
                            <tr class="hover:bg-surface-container-low transition-colors group">
                                <td class="px-6 py-4">
                                    <div class="flex flex-col">
                                        <span class="font-bold text-on-surface">${drive.companyName}</span>
                                        <span class="text-xs text-on-surface-variant">${drive.jobRole}</span>
                                    </div>
                                </td>
                                <td class="px-6 py-4">
                                    <div class="flex flex-col gap-1">
                                        <span class="text-xs text-on-surface-variant flex items-center gap-1">
                                            <span class="material-symbols-outlined text-[14px]">grade</span> CGPA: ${drive.cgpaReq}
                                        </span>
                                        <span class="text-xs text-on-surface-variant flex items-center gap-1">
                                            <span class="material-symbols-outlined text-[14px]">account_tree</span> ${drive.branchReq}
                                        </span>
                                    </div>
                                </td>
                                <td class="px-6 py-4">
                                    <span class="font-bold text-secondary">${drive.packageLpa} LPA</span>
                                </td>
                                <td class="px-6 py-4 text-sm text-on-surface-variant">
                                    ${drive.driveDate}
                                </td>
                                <td class="px-6 py-4">
                                    <span class="px-2 py-1 ${drive.status == 'OPEN' ? 'bg-green-100 text-green-700' : 'bg-red-100 text-red-700'} rounded-full text-[10px] font-bold uppercase tracking-wider">
                                        ${drive.status}
                                    </span>
                                </td>
                                <td class="px-6 py-4 text-right flex items-center justify-end gap-2">
                                    <button 
                                            data-id="${drive.id}"
                                            data-company-id="${drive.companyId}"
                                            data-job-role="${drive.jobRole}"
                                            data-package="${drive.packageLpa}"
                                            data-cgpa="${drive.cgpaReq}"
                                            data-branch="${drive.branchReq}"
                                            data-date="${drive.driveDate}"
                                            data-status="${drive.status}"
                                            onclick="editDriveFromBtn(this)"
                                            class="p-2 text-on-surface-variant hover:text-secondary hover:bg-secondary/10 rounded-full">
                                        <span class="material-symbols-outlined text-sm">edit</span>
                                    </button>
                                    <button onclick="confirmDelete(${drive.id})" class="p-2 text-on-surface-variant hover:text-red-600 hover:bg-red-50 rounded-full">
                                        <span class="material-symbols-outlined text-sm">delete</span>
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty drives}">
                            <tr>
                                <td colspan="6" class="px-6 py-10 text-center text-on-surface-variant italic">No placement drives scheduled.</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
        <jsp:include page="includes/layout_footer.jsp" />
    </main>

    <!-- Add Drive Modal -->
    <div id="addModal" class="modal">
        <div class="bg-surface rounded-2xl shadow-xl w-full max-w-lg mx-4 overflow-hidden border border-outline-variant/30">
            <div class="px-6 py-4 border-b border-outline-variant/30 flex justify-between items-center bg-surface-container-low">
                <h3 class="text-xl font-bold text-on-surface">New Placement Drive</h3>
                <button onclick="closeModal('addModal')" class="p-2 hover:bg-surface-container-high rounded-full transition-colors">
                    <span class="material-symbols-outlined">close</span>
                </button>
            </div>
            <form action="${pageContext.request.contextPath}/admin/drives" method="POST" class="p-6 space-y-4">
                <input type="hidden" name="action" value="add">
                <div class="grid grid-cols-2 gap-4">
                    <div class="col-span-2">
                        <label class="block text-sm font-medium text-on-surface-variant mb-1">Company</label>
                        <select name="companyId" required class="w-full rounded-xl border-outline-variant bg-surface-container-low focus:ring-secondary focus:border-secondary transition-all">
                            <option value="">Select Company</option>
                            <c:forEach var="company" items="${companies}">
                                <option value="${company.userId}">${company.companyName}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-span-2">
                        <label class="block text-sm font-medium text-on-surface-variant mb-1">Job Role</label>
                        <input type="text" name="jobRole" required class="w-full rounded-xl border-outline-variant bg-surface-container-low focus:ring-secondary focus:border-secondary transition-all">
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-on-surface-variant mb-1">Package (LPA)</label>
                        <input type="number" step="0.1" name="packageLpa" required class="w-full rounded-xl border-outline-variant bg-surface-container-low focus:ring-secondary focus:border-secondary transition-all">
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-on-surface-variant mb-1">CGPA Req</label>
                        <input type="number" step="0.01" name="cgpaReq" required class="w-full rounded-xl border-outline-variant bg-surface-container-low focus:ring-secondary focus:border-secondary transition-all">
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-on-surface-variant mb-1">Eligible Branches</label>
                        <select name="branchReq" required class="w-full rounded-xl border-outline-variant bg-surface-container-low focus:ring-secondary focus:border-secondary transition-all">
                            <option value="ALL">All Branches</option>
                            <c:forEach var="dept" items="${departments}">
                                <option value="${dept}">${dept}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-on-surface-variant mb-1">Drive Date</label>
                        <input type="date" name="driveDate" required class="w-full rounded-xl border-outline-variant bg-surface-container-low focus:ring-secondary focus:border-secondary transition-all">
                    </div>
                </div>
                <div class="pt-6 flex justify-end gap-3 border-t border-outline-variant/30 mt-4">
                    <button type="button" onclick="closeModal('addModal')" class="px-5 py-2.5 text-on-surface-variant hover:bg-surface-container-high rounded-xl transition-all font-medium">Cancel</button>
                    <button type="submit" class="px-6 py-2.5 bg-secondary text-white rounded-xl hover:bg-secondary/90 shadow-lg shadow-secondary/20 transition-all font-medium">Create Drive</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Edit Drive Modal -->
    <div id="editModal" class="modal">
        <div class="bg-surface rounded-2xl shadow-xl w-full max-w-lg mx-4 overflow-hidden border border-outline-variant/30">
            <div class="px-6 py-4 border-b border-outline-variant/30 flex justify-between items-center bg-surface-container-low">
                <h3 class="text-xl font-bold text-on-surface">Edit Drive Details</h3>
                <button onclick="closeModal('editModal')" class="p-2 hover:bg-surface-container-high rounded-full transition-colors">
                    <span class="material-symbols-outlined">close</span>
                </button>
            </div>
            <form action="${pageContext.request.contextPath}/admin/drives" method="POST" class="p-6 space-y-4">
                <input type="hidden" name="action" value="edit">
                <input type="hidden" name="id" id="editDriveId">
                <div class="grid grid-cols-2 gap-4">
                    <div class="col-span-2">
                        <label class="block text-sm font-medium text-on-surface-variant mb-1">Job Role</label>
                        <input type="text" name="jobRole" id="editJobRole" required class="w-full rounded-xl border-outline-variant bg-surface-container-low focus:ring-secondary focus:border-secondary transition-all">
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-on-surface-variant mb-1">Package (LPA)</label>
                        <input type="number" step="0.1" name="packageLpa" id="editPackage" required class="w-full rounded-xl border-outline-variant bg-surface-container-low focus:ring-secondary focus:border-secondary transition-all">
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-on-surface-variant mb-1">CGPA Req</label>
                        <input type="number" step="0.01" name="cgpaReq" id="editCgpa" required class="w-full rounded-xl border-outline-variant bg-surface-container-low focus:ring-secondary focus:border-secondary transition-all">
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-on-surface-variant mb-1">Eligible Branches</label>
                        <select name="branchReq" id="editBranch" required class="w-full rounded-xl border-outline-variant bg-surface-container-low focus:ring-secondary focus:border-secondary transition-all">
                            <option value="ALL">All Branches</option>
                            <c:forEach var="dept" items="${departments}">
                                <option value="${dept}">${dept}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-on-surface-variant mb-1">Drive Date</label>
                        <input type="date" name="driveDate" id="editDate" required class="w-full rounded-xl border-outline-variant bg-surface-container-low focus:ring-secondary focus:border-secondary transition-all">
                    </div>
                    <div class="col-span-2">
                        <label class="block text-sm font-medium text-on-surface-variant mb-1">Status</label>
                        <select name="status" id="editStatus" required class="w-full rounded-xl border-outline-variant bg-surface-container-low focus:ring-secondary focus:border-secondary transition-all">
                            <option value="OPEN">OPEN</option>
                            <option value="CLOSED">CLOSED</option>
                        </select>
                    </div>
                </div>
                <div class="pt-6 flex justify-end gap-3 border-t border-outline-variant/30 mt-4">
                    <button type="button" onclick="closeModal('editModal')" class="px-5 py-2.5 text-on-surface-variant hover:bg-surface-container-high rounded-xl transition-all font-medium">Cancel</button>
                    <button type="submit" class="px-6 py-2.5 bg-secondary text-white rounded-xl hover:bg-secondary/90 shadow-lg shadow-secondary/20 transition-all font-medium">Update Drive</button>
                </div>
            </form>
        </div>
    </div>
    <script>
        // Global Search Implementation
        document.getElementById('globalSearch')?.addEventListener('input', function(e) {
            const searchTerm = e.target.value.toLowerCase();
            const rows = document.querySelectorAll('#drivesTable tbody tr');
            
            rows.forEach(row => {
                const text = row.innerText.toLowerCase();
                row.style.display = text.includes(searchTerm) ? '' : 'none';
            });
        });

        function openModal(id) {
            document.getElementById(id).classList.add('active');
        }
        function closeModal(id) {
            document.getElementById(id).classList.remove('active');
        }

        function editDriveFromBtn(btn) {
            var id = btn.getAttribute('data-id');
            var companyId = btn.getAttribute('data-company-id');
            var jobRole = btn.getAttribute('data-job-role');
            var packageLpa = btn.getAttribute('data-package');
            var cgpaReq = btn.getAttribute('data-cgpa');
            var branchReq = btn.getAttribute('data-branch');
            var driveDate = btn.getAttribute('data-date');
            var status = btn.getAttribute('data-status');
            editDrive(id, companyId, jobRole, packageLpa, cgpaReq, branchReq, driveDate, status);
        }

        function editDrive(id, companyId, jobRole, packageLpa, cgpaReq, branchReq, driveDate, status) {
            document.getElementById('editDriveId').value = id;
            document.getElementById('editJobRole').value = jobRole;
            document.getElementById('editPackage').value = packageLpa;
            document.getElementById('editCgpa').value = cgpaReq;
            document.getElementById('editBranch').value = branchReq;
            document.getElementById('editDate').value = driveDate;
            document.getElementById('editStatus').value = status;
            openModal('editModal');
        }

        function confirmDelete(id) {
            if (confirm('Are you sure you want to delete this placement drive? All applications will also be removed.')) {
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '${pageContext.request.contextPath}/admin/drives';
                
                const actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'action';
                actionInput.value = 'delete';
                
                const idInput = document.createElement('input');
                idInput.type = 'hidden';
                idInput.name = 'id';
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
            const rows = document.querySelectorAll('#drivesTable tbody tr');
            
            rows.forEach(row => {
                if (row.querySelector('td[colspan]')) return;
                const text = row.textContent.toLowerCase();
                row.style.display = text.includes(searchTerm) ? '' : 'none';
            });
        });
    </script>
</body>
</html>
