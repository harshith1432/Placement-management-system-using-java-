<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%-- Redundant session check removed, handled by AuthenticationFilter --%>
<!DOCTYPE html>
<html class="light" lang="en">
<head>
    <title>Manage Companies - Placement Portal</title>
    <jsp:include page="includes/layout_head.jsp" />
</head>
<body class="bg-background font-body text-on-background min-h-screen">
    <jsp:include page="includes/layout_sidebar.jsp" />

    <main class="main-content min-h-screen flex flex-col transition-all duration-300 md:ml-64">
        <jsp:include page="includes/layout_header.jsp" />

        <!-- Page Header -->
        <div class="px-8 py-6 flex flex-col md:flex-row md:items-center justify-between gap-4 border-b border-outline-variant bg-surface/50 backdrop-blur-sm">
            <div>
                <h1 class="text-2xl font-bold text-on-surface">Registered Companies</h1>
                <p class="text-on-surface-variant">Manage corporate partners and placement entities</p>
            </div>
            <button onclick="openModal('addModal')" class="flex items-center gap-2 px-6 py-3 bg-secondary text-white rounded-xl hover:bg-secondary/90 shadow-lg shadow-secondary/20 transition-all font-medium">
                <span class="material-symbols-outlined">add_business</span>
                <span>Add Company</span>
            </button>
        </div>

        <div class="p-8">
            <!-- Alerts -->
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

            <div id="companyGrid" class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
                <c:forEach var="company" items="${companies}">
                    <div class="company-card glass-card rounded-2xl p-7 border border-outline-variant/50 shadow-sm hover:shadow-xl hover:border-secondary/30 transition-all duration-300 flex flex-col group relative overflow-hidden">
                        <!-- Top Accent Bar -->
                        <div class="absolute top-0 left-0 w-full h-1 bg-secondary/10 group-hover:bg-secondary transition-colors"></div>
                        
                        <div class="flex items-start justify-between mb-6">
                            <div class="w-14 h-14 rounded-2xl bg-secondary/5 flex items-center justify-center text-secondary group-hover:scale-110 transition-transform duration-300">
                                <span class="material-symbols-outlined text-4xl">corporate_fare</span>
                            </div>
                            <div class="flex gap-2">
                                <button 
                                         data-id="${company.userId}"
                                         data-name="${company.companyName}"
                                         data-email="${company.contactEmail}"
                                         data-website="${company.website}"
                                         data-phone="${company.contactPhone}"
                                         data-desc="${company.description}"
                                         data-hr="${company.hrName}"
                                         data-industry="${company.industryType}"
                                         data-location="${company.location}"
                                         onclick="editCompanyFromBtn(this)" 
                                         class="p-2 text-on-surface-variant hover:text-secondary hover:bg-secondary/10 rounded-full transition-all"
                                         title="Edit Company">
                                     <span class="material-symbols-outlined text-[20px]">edit</span>
                                 </button>
                                 <button onclick="confirmDelete(${company.userId})" 
                                         class="p-2 text-on-surface-variant hover:text-error hover:bg-error/10 rounded-full transition-all"
                                         title="Delete Company">
                                     <span class="material-symbols-outlined text-[20px]">delete</span>
                                 </button>
                            </div>
                        </div>
                        
                        <h3 class="text-xl font-bold text-on-surface mb-1 group-hover:text-secondary transition-colors">${company.companyName}</h3>
                        <div class="flex flex-wrap gap-2 mb-3">
                            <span class="px-2 py-0.5 bg-surface-container-high text-on-surface-variant text-[10px] font-bold rounded uppercase tracking-wider">${company.industryType != null ? company.industryType : 'Industry'}</span>
                            <span class="px-2 py-0.5 bg-surface-container-high text-on-surface-variant text-[10px] font-bold rounded uppercase tracking-wider">${company.location != null ? company.location : 'Remote'}</span>
                        </div>
                        
                        <p class="text-sm text-secondary font-medium mb-4 flex items-center gap-1.5">
                            <span class="material-symbols-outlined text-[16px]">public</span>
                            <a href="${company.website}" target="_blank" class="hover:underline opacity-80 hover:opacity-100">${company.website}</a>
                        </p>
                        
                        <p class="text-on-surface-variant text-sm line-clamp-3 mb-8 flex-1 leading-relaxed">
                            ${company.description}
                        </p>
                        
                        <div class="pt-6 border-t border-outline-variant/30 flex flex-col gap-3 mt-auto">
                            <div class="flex items-center gap-3 text-sm text-on-surface">
                                <div class="w-8 h-8 rounded-lg bg-surface-container-low flex items-center justify-center text-on-surface-variant">
                                    <span class="material-symbols-outlined text-[18px]">person</span>
                                </div>
                                <span class="font-medium truncate">${company.hrName != null ? company.hrName : 'Contact Person'}</span>
                            </div>
                            <div class="flex items-center gap-3 text-sm text-on-surface">
                                <div class="w-8 h-8 rounded-lg bg-surface-container-low flex items-center justify-center text-on-surface-variant">
                                    <span class="material-symbols-outlined text-[18px]">mail</span>
                                </div>
                                <span class="font-medium truncate">${company.contactEmail}</span>
                            </div>
                            <div class="flex items-center gap-3 text-sm text-on-surface">
                                <div class="w-8 h-8 rounded-lg bg-surface-container-low flex items-center justify-center text-on-surface-variant">
                                    <span class="material-symbols-outlined text-[18px]">call</span>
                                </div>
                                <span class="font-medium">${company.contactPhone}</span>
                            </div>
                        </div>
                    </div>
                </c:forEach>
                
                <c:if test="${empty companies}">
                    <div class="col-span-full py-24 text-center">
                        <div class="flex flex-col items-center gap-4 text-on-surface-variant">
                            <span class="material-symbols-outlined text-6xl opacity-10">business</span>
                            <p class="text-lg">No companies registered yet.</p>
                            <button onclick="openModal('addModal')" class="text-secondary font-bold hover:underline">Register the first company</button>
                        </div>
                    </div>
                </c:if>
            </div>
        </div>
        <jsp:include page="includes/layout_footer.jsp" />
    </main>

    <!-- Modals -->
    <jsp:include page="views/admin/add_company_modal.jsp" />
    <jsp:include page="views/admin/edit_company_modal.jsp" />

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

        function editCompanyFromBtn(btn) {
            const id = btn.getAttribute('data-id');
            const name = btn.getAttribute('data-name');
            const email = btn.getAttribute('data-email');
            const website = btn.getAttribute('data-website');
            const phone = btn.getAttribute('data-phone');
            const desc = btn.getAttribute('data-desc');
            const hr = btn.getAttribute('data-hr');
            const industry = btn.getAttribute('data-industry');
            const location = btn.getAttribute('data-location');

            document.getElementById('editCompanyId').value = id;
            document.getElementById('editName').value = name;
            document.getElementById('editEmail').value = email;
            document.getElementById('editWebsite').value = website;
            document.getElementById('editPhone').value = phone;
            document.getElementById('editDesc').value = desc;
            document.getElementById('editHr').value = hr === 'null' ? '' : hr;
            document.getElementById('editIndustry').value = industry === 'null' ? '' : industry;
            document.getElementById('editLocation').value = location === 'null' ? '' : location;

            openModal('editModal');
        }

        function confirmDelete(id) {
            if (confirm('Are you sure you want to delete this company? This will also remove all their placement drives and related data.')) {
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '${pageContext.request.contextPath}/admin/companies';
                
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

        // Global Search listener for card grid
        document.addEventListener('globalSearch', (e) => {
            const searchTerm = e.detail.value.toLowerCase();
            const cards = document.querySelectorAll('.company-card');
            
            cards.forEach(card => {
                const text = card.textContent.toLowerCase();
                if (text.includes(searchTerm)) {
                    card.style.display = '';
                    card.classList.add('animate-fade-in');
                } else {
                    card.style.display = 'none';
                    card.classList.remove('animate-fade-in');
                }
            });
        });
    </script>
</body>
</html>
