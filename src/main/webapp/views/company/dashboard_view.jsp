<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!-- Welcome Banner -->
<section class="relative overflow-hidden rounded-xl mb-lg glass-card p-xl border-none shadow-sm flex flex-col md:flex-row items-center justify-between">
    <div class="absolute inset-0 bg-gradient-to-br from-secondary/10 to-transparent z-0"></div>
    <div class="relative z-10 space-y-xs text-center md:text-left">
        <h2 class="font-h1 text-h2 md:text-h1 text-on-surface">Welcome back, <c:out value="${not empty company.companyName ? company.companyName : user.username}"/>!</h2>
        <p class="text-on-surface-variant font-body-lg">You have ${totalApplicants} applicants waiting for your review across ${activeDrivesCount} active drives.</p>
        <div class="pt-sm">
            <a href="company?view=manageDrives" class="inline-block bg-[#2563eb] text-white px-8 py-3 rounded-xl font-bold hover:bg-[#1d4ed8] transition-all shadow-xl active:scale-95 border-2 border-[#1e40af]">Post New Drive</a>
        </div>
    </div>
    <div class="hidden lg:block relative z-10 w-64 h-64">
        <img alt="Success Illustration" class="w-full h-full object-contain" src="https://lh3.googleusercontent.com/aida-public/AB6AXuApHMqa9o4eTqo-ogsJc3WBbn3waBukqz0ym30cjf80ehNycZu9YziCJCfeMQFxQI-2M_06UTkbkE9ZOSBKkXuAmnFZr64agRxtyT_NSsc7iUa1VWCVnnUr7eZXNiaND7wxx5SR5uwGUYBdBvRDEs-CtU-jjlEzB7VsTNZ0iM_BzZXGoYuye8MWfMMXQ16KzagStu4VMebNc2Du7TQeF8b7m-ApwsTexBSCWXzlqortb9gqgpnoqXTRRg8bNGGTXtUh4bQpNjivRiF1"/>
    </div>
</section>

<!-- Company Profile Summary Card -->
<section class="glass-card rounded-xl p-lg mb-lg grid grid-cols-1 md:grid-cols-12 gap-lg items-center">
    <div class="md:col-span-3 flex justify-center">
        <div class="w-32 h-32 rounded-2xl bg-surface-container-highest flex items-center justify-center overflow-hidden border-2 border-outline-variant">
            <c:choose>
                <c:when test="${not empty company.logoUrl}">
                    <img src="${company.logoUrl}" alt="Company Logo" class="w-full h-full object-cover">
                </c:when>
                <c:otherwise>
                    <span class="material-symbols-outlined text-4xl text-on-surface-variant">business</span>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
    <div class="md:col-span-9 grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-md">
        <div class="space-y-1">
            <p class="font-label-caps text-on-surface-variant text-[10px]">COMPANY NAME</p>
            <p class="font-semibold text-on-surface">${not empty company.companyName ? company.companyName : 'Not Set'}</p>
        </div>
        <div class="space-y-1">
            <p class="font-label-caps text-on-surface-variant text-[10px]">HR NAME</p>
            <p class="font-semibold text-on-surface">${not empty company.hrName ? company.hrName : 'Not Set'}</p>
        </div>
        <div class="space-y-1">
            <p class="font-label-caps text-on-surface-variant text-[10px]">INDUSTRY</p>
            <p class="font-semibold text-on-surface">${not empty company.industryType ? company.industryType : 'Not Set'}</p>
        </div>
        <div class="space-y-1">
            <p class="font-label-caps text-on-surface-variant text-[10px]">EMAIL</p>
            <p class="font-semibold text-on-surface">${not empty company.contactEmail ? company.contactEmail : 'Not Set'}</p>
        </div>
        <div class="space-y-1">
            <p class="font-label-caps text-on-surface-variant text-[10px]">CONTACT</p>
            <p class="font-semibold text-on-surface">${not empty company.contactPhone ? company.contactPhone : 'Not Set'}</p>
        </div>
        <div class="space-y-1">
            <p class="font-label-caps text-on-surface-variant text-[10px]">LOCATION</p>
            <p class="font-semibold text-on-surface">${not empty company.location ? company.location : 'Not Set'}</p>
        </div>
        <div class="space-y-1">
            <p class="font-label-caps text-on-surface-variant text-[10px]">ACTIVE DRIVES</p>
            <p class="font-semibold text-secondary">${activeDrivesCount}</p>
        </div>
    </div>
</section>


<!-- Stats Grid -->
<section class="grid grid-cols-1 md:grid-cols-3 gap-md mb-lg">
    <div class="glass-card p-md rounded-xl flex items-center gap-md hover:shadow-md transition-shadow">
        <div class="w-12 h-12 rounded-lg bg-secondary/10 flex items-center justify-center text-secondary">
            <span class="material-symbols-outlined">campaign</span>
        </div>
        <div>
            <p class="font-label-caps text-on-surface-variant">ACTIVE DRIVES</p>
            <p class="font-h3 text-h3 text-on-surface">${activeDrivesCount}</p>
        </div>
    </div>
    <div class="glass-card p-md rounded-xl flex items-center gap-md hover:shadow-md transition-shadow">
        <div class="w-12 h-12 rounded-lg bg-primary-container/10 flex items-center justify-center text-primary-container">
            <span class="material-symbols-outlined">group</span>
        </div>
        <div>
            <p class="font-label-caps text-on-surface-variant">TOTAL APPLICANTS</p>
            <p class="font-h3 text-h3 text-on-surface">${totalApplicants}</p>
        </div>
    </div>
    <div class="glass-card p-md rounded-xl flex items-center gap-md hover:shadow-md transition-shadow">
        <div class="w-12 h-12 rounded-lg bg-surface-container-highest flex items-center justify-center text-on-surface">
            <span class="material-symbols-outlined">calendar_today</span>
        </div>
        <div>
            <p class="font-label-caps text-on-surface-variant">SCHEDULED INTERVIEWS</p>
            <p class="font-h3 text-h3 text-on-surface">${scheduledInterviewsCount}</p>
        </div>
    </div>
</section>

<div class="grid grid-cols-1 lg:grid-cols-12 gap-lg">
    <!-- Recent Drives -->
    <div class="lg:col-span-8">
        <div class="glass-card rounded-xl p-md h-full">
            <div class="flex justify-between items-center mb-md">
                <h3 class="font-h3 text-h3 text-on-surface">Recent Drives</h3>
                <a class="text-secondary font-button hover:underline" href="company?view=manageDrives">View All</a>
            </div>
            <div class="overflow-x-auto">
                <table class="w-full text-left">
                    <thead>
                        <tr class="border-b border-outline-variant font-label-caps text-on-surface-variant text-xs">
                            <th class="pb-sm">Job Role</th>
                            <th class="pb-sm">Package</th>
                            <th class="pb-sm">Drive Date</th>
                            <th class="pb-sm">Status</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-outline-variant/30">
                        <c:forEach items="${myDrives}" var="drive" varStatus="loop">
                            <c:if test="${loop.index < 5}">
                                <tr class="group hover:bg-surface-variant/10 transition-colors">
                                    <td class="py-md font-semibold text-on-surface">${drive.jobRole}</td>
                                    <td class="py-md">₹${drive.packageLpa} LPA</td>
                                    <td class="py-md text-on-surface-variant text-sm">${drive.driveDate}</td>
                                    <td class="py-md">
                                        <span class="px-sm py-1 rounded-full text-[10px] font-bold ${drive.status == 'OPEN' ? 'bg-secondary/10 text-secondary border-secondary/20' : 'bg-surface-container-highest text-on-surface-variant'} border">${drive.status}</span>
                                    </td>
                                </tr>
                            </c:if>
                        </c:forEach>
                        <c:if test="${empty myDrives}">
                            <tr>
                                <td colspan="4" class="py-md text-center text-on-surface-variant">No drives posted yet.</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Pending Applicants -->
    <div class="lg:col-span-4">
        <div class="glass-card rounded-xl p-md h-full">
            <div class="flex justify-between items-center mb-md">
                <h3 class="font-h3 text-h3 text-on-surface">Pending Review</h3>
                <c:if test="${not empty pendingApplications}">
                    <span class="bg-primary text-on-primary text-[10px] px-2 py-0.5 rounded-full">${fn:length(pendingApplications)} NEW</span>
                </c:if>
            </div>
            <div class="space-y-md">
                <c:forEach items="${pendingApplications}" var="app" varStatus="loop">
                    <c:if test="${loop.index < 3}">
                        <div class="p-sm rounded-lg border border-outline-variant/30 hover:shadow-sm transition-all space-y-sm">
                            <div class="flex items-center gap-sm">
                                <div class="w-10 h-10 rounded-full bg-surface-container flex items-center justify-center">
                                    <span class="material-symbols-outlined text-on-surface-variant">person</span>
                                </div>
                                <div class="overflow-hidden">
                                    <p class="font-body-md font-bold text-on-surface truncate">${app.studentName}</p>
                                    <p class="text-[12px] text-on-surface-variant truncate">${app.studentDepartment} • ${app.jobRole}</p>
                                </div>
                            </div>
                            <div class="flex gap-xs">
                                <form action="company" method="post" class="flex-1">
                                    <input type="hidden" name="action" value="updateStatus">
                                    <input type="hidden" name="applicationId" value="${app.id}">
                                    <input type="hidden" name="status" value="SHORTLISTED">
                                    <input type="hidden" name="redirectView" value="dashboard">
                                    <button type="submit" class="w-full font-bold py-2 bg-[#0ea5e9] text-white rounded-lg hover:bg-[#0284c7] transition-all shadow-lg active:scale-95 text-xs border-2 border-[#0369a1]">Shortlist</button>
                                </form>
                                <form action="company" method="post" class="flex-1">
                                    <input type="hidden" name="action" value="updateStatus">
                                    <input type="hidden" name="applicationId" value="${app.id}">
                                    <input type="hidden" name="status" value="REJECTED">
                                    <input type="hidden" name="redirectView" value="dashboard">
                                    <button type="submit" class="w-full font-button py-1.5 border border-error text-error rounded-lg hover:bg-error/5 transition-colors text-xs">Reject</button>
                                </form>
                            </div>
                        </div>
                    </c:if>
                </c:forEach>
                <c:if test="${empty pendingApplications}">
                    <p class="text-on-surface-variant text-sm py-8 text-center">No pending applicants.</p>
                </c:if>
            </div>
            <c:if test="${not empty pendingApplications}">
                <a href="company?view=applicantReview" class="block w-full mt-md text-center py-sm border border-outline-variant/50 rounded-lg font-button text-on-surface-variant hover:bg-surface-container/50 transition-colors text-sm">View All Applicants</a>
            </c:if>
        </div>
    </div>
</div>
