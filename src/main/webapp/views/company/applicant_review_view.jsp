<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<section class="space-y-lg">
    <div class="flex flex-col md:flex-row justify-between items-start md:items-end gap-md">
        <div>
            <h2 class="font-h2 text-h2 text-on-surface">Applicant Pool</h2>
            <p class="text-on-surface-variant">Review and manage candidates for all your drives.</p>
        </div>
        <div class="w-full md:w-auto">
            <form action="company" method="get" class="flex items-center gap-sm">
                <input type="hidden" name="view" value="applicantReview">
                <label for="driveId" class="whitespace-nowrap text-sm font-medium text-on-surface-variant">Filter by Drive:</label>
                <select name="driveId" id="driveId" onchange="this.form.submit()" class="bg-surface-container border-none rounded-lg text-sm focus:ring-2 focus:ring-primary min-w-[200px]">
                    <option value="">All Drives</option>
                    <c:forEach items="${myDrives}" var="drive">
                        <option value="${drive.id}" ${selectedDriveId == drive.id ? 'selected' : ''}>
                            ${drive.jobRole} (${drive.driveDate})
                        </option>
                    </c:forEach>
                </select>
            </form>
        </div>
    </div>

    <div class="glass-card rounded-2xl overflow-hidden">
        <table class="w-full text-left">
            <thead class="bg-surface-container">
                <tr class="font-label-caps text-on-surface-variant text-xs">
                    <th class="px-md py-sm">Applicant</th>
                    <th class="px-md py-sm">Job Role</th>
                    <th class="px-md py-sm">Academic Profile</th>
                    <th class="px-md py-sm">Status</th>
                    <th class="px-md py-sm">Actions</th>
                </tr>
            </thead>
            <tbody class="divide-y divide-outline-variant/30">
                <c:forEach items="${allApplicants}" var="app">
                    <tr class="hover:bg-surface-variant/10 transition-colors">
                        <td class="px-md py-md">
                            <div class="flex items-center gap-sm">
                                <div class="w-10 h-10 rounded-full bg-surface-container-highest flex items-center justify-center text-on-surface font-bold">
                                    ${fn:substring(app.studentName, 0, 1)}
                                </div>
                                <div>
                                    <p class="font-semibold text-on-surface">${app.studentName}</p>
                                    <p class="text-[12px] text-on-surface-variant">${app.studentEmail}</p>
                                </div>
                            </div>
                        </td>
                        <td class="px-md py-md">
                            <p class="font-medium text-on-surface">${app.jobRole}</p>
                        </td>
                        <td class="px-md py-md">
                            <div class="flex items-center gap-xs text-sm text-on-surface-variant">
                                <span class="bg-secondary/5 text-secondary px-2 py-0.5 rounded border border-secondary/10 font-bold">${app.studentCgpa} CGPA</span>
                                <span>${app.studentDepartment}</span>
                            </div>
                        </td>
                        <td class="px-md py-md">
                            <span class="px-3 py-1 rounded-full text-[10px] font-bold border
                                ${app.status == 'APPLIED' ? 'bg-surface-container-highest text-on-surface border-outline-variant/30' : 
                                  app.status == 'SHORTLISTED' ? 'bg-secondary/10 text-secondary border-secondary/20' :
                                  app.status == 'INTERVIEW_SCHEDULED' ? 'bg-primary-container/10 text-primary-container border-primary-container/20' :
                                  app.status == 'REJECTED' ? 'bg-error/10 text-error border-error/20' : 
                                  'bg-surface-variant/30 text-on-surface-variant'}">
                                ${app.status}
                            </span>
                        </td>
                        <td class="px-md py-md">
                            <div class="flex gap-2">
                                <c:if test="${app.status == 'APPLIED'}">
                                    <form action="company" method="post">
                                        <input type="hidden" name="action" value="updateStatus">
                                        <input type="hidden" name="applicationId" value="${app.id}">
                                        <input type="hidden" name="status" value="SHORTLISTED">
                                        <input type="hidden" name="redirectView" value="applicantReview">
                                        <button type="submit" class="p-1.5 bg-secondary text-on-secondary rounded-lg hover:opacity-90 shadow-btn-secondary transition-all active:scale-90" title="Shortlist">
                                            <span class="material-symbols-outlined text-sm">check</span>
                                        </button>
                                    </form>
                                    <form action="company" method="post">
                                        <input type="hidden" name="action" value="updateStatus">
                                        <input type="hidden" name="applicationId" value="${app.id}">
                                        <input type="hidden" name="status" value="REJECTED">
                                        <input type="hidden" name="redirectView" value="applicantReview">
                                        <button type="submit" class="p-1.5 border border-error text-error rounded-lg hover:bg-error/5" title="Reject">
                                            <span class="material-symbols-outlined text-sm">close</span>
                                        </button>
                                    </form>
                                </c:if>
                                <c:if test="${app.status == 'SHORTLISTED'}">
                                    <button onclick="openScheduleModal(${app.id}, '${app.studentName}')" class="flex items-center gap-1 bg-primary text-on-primary px-3 py-1.5 rounded-lg text-xs font-button hover:opacity-90 shadow-btn transition-all active:scale-95">
                                        <span class="material-symbols-outlined text-xs">video_chat</span>
                                        Schedule
                                    </button>
                                </c:if>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty allApplicants}">
                    <tr>
                        <td colspan="5" class="px-md py-xl text-center text-on-surface-variant">No applicants to review.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
</section>

<!-- Schedule Interview Modal -->
<jsp:include page="../../includes/schedule_interview_modal.jsp" />
