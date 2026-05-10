<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- My Applications View -->
<section class="space-y-md">
    <div class="flex flex-col md:flex-row justify-between items-start md:items-center gap-md mb-lg">
        <div>
            <h2 class="font-h2 text-3xl font-bold text-primary">Application History</h2>
            <p class="text-on-surface-variant">Track the status of your placement journey across different companies.</p>
        </div>
        <div class="relative w-full md:w-64">
            <span class="material-symbols-outlined absolute left-sm top-1/2 -translate-y-1/2 text-on-surface-variant">search</span>
            <input type="text" id="appSearch" placeholder="Search history..." class="w-full pl-lg pr-md py-sm bg-surface-container-low border border-outline-variant rounded-lg focus:ring-2 focus:ring-secondary/20 focus:border-secondary outline-none transition-all">
        </div>
    </div>

    <div class="glass-card rounded-2xl border border-outline-variant overflow-hidden shadow-sm">
        <table class="w-full text-left border-collapse" id="appTable">
            <thead class="bg-surface-container-low border-b border-outline-variant text-[11px] font-bold uppercase tracking-wider">
                <tr>
                    <th class="p-lg text-on-surface-variant">Company & Role</th>
                    <th class="p-lg text-on-surface-variant">Applied On</th>
                    <th class="p-lg text-on-surface-variant text-center">Status</th>
                    <th class="p-lg text-on-surface-variant text-right">Action</th>
                </tr>
            </thead>
            <tbody class="divide-y divide-outline-variant/20 font-body">
                <c:forEach var="app" items="${myApplications}">
                    <tr class="hover:bg-surface-container-low/50 transition-colors group">
                        <td class="p-lg">
                            <div class="flex items-center gap-md">
                                <div class="w-10 h-10 bg-surface-container rounded-lg flex items-center justify-center text-secondary">
                                    <span class="material-symbols-outlined">business</span>
                                </div>
                                <div>
                                    <p class="font-bold text-primary app-company"><c:out value="${app.companyName}"/></p>
                                    <p class="text-sm text-on-surface-variant app-role"><c:out value="${app.jobRole}"/></p>
                                </div>
                            </div>
                        </td>
                        <td class="p-lg text-on-surface-variant font-medium text-sm">
                            <c:out value="${app.appliedAt}"/>
                        </td>
                        <td class="p-lg text-center">
                            <span class="inline-flex items-center gap-1 px-3 py-1 rounded-full text-[12px] font-bold uppercase tracking-wider shadow-sm
                                ${app.status == 'HIRED' ? 'bg-green-100 text-green-700' : 
                                  (app.status == 'REJECTED' ? 'bg-red-100 text-red-700' : 'bg-blue-100 text-blue-700')}">
                                <span class="material-symbols-outlined text-[16px]">
                                    ${app.status == 'HIRED' ? 'check_circle' : (app.status == 'REJECTED' ? 'cancel' : 'pending')}
                                </span>
                                <c:out value="${app.status}"/>
                            </span>
                        </td>
                        <td class="p-lg text-right">
                            <button onclick="showDriveDetails('${app.companyName}', '${app.jobRole}', '${app.status}', '${app.appliedAt}')" class="text-secondary hover:text-primary font-semibold text-sm hover:underline">View Details</button>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <c:if test="${empty myApplications}">
            <div class="text-center py-xl bg-surface-container-low">
                <span class="material-symbols-outlined text-6xl text-outline mb-md">history_edu</span>
                <h3 class="font-h3 text-xl font-bold text-primary">No Applications Found</h3>
                <p class="text-on-surface-variant max-w-sm mx-auto">You haven't applied to any drives yet. Check the 'Eligible Drives' tab to get started!</p>
                <a href="student?view=drives" class="inline-block mt-md bg-secondary text-white px-lg py-sm rounded-lg font-button hover:bg-secondary/90 transition-all">Explore Drives</a>
            </div>
        </c:if>
    </div>
</section>
