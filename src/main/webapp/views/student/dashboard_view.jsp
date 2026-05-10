<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!-- Welcome Banner -->
<section class="relative overflow-hidden rounded-xl bg-primary-container p-lg text-white shadow-lg">
    <div class="absolute right-0 top-0 w-1/3 h-full opacity-20 pointer-events-none">
        <svg class="w-full h-full" viewbox="0 0 200 200" xmlns="http://www.w3.org/2000/svg">
            <path d="M44.7,-76.4C58.1,-69.2,69.2,-58.1,76.4,-44.7C83.7,-31.3,87.1,-15.7,85.6,-0.9C84.1,14,77.7,28,68.9,40.1C60.1,52.2,48.9,62.4,36,69.5C23.1,76.6,8.5,80.5,-6.2,78.2C-20.9,75.9,-35.7,67.4,-48.6,56.5C-61.5,45.6,-72.5,32.3,-77.8,17.1C-83.1,1.9,-82.7,-15.2,-76,-30.2C-69.3,-45.2,-56.3,-58.1,-41.4,-64.8C-26.5,-71.5,-9.7,-72,-0.9,-70.5C7.9,-69,15.7,-65.4,31.3,-69.2C46.9,-73,70.2,-84.2,44.7,-76.4Z" fill="#ffffff" transform="translate(100 100)"></path>
        </svg>
    </div>
    <div class="relative z-10 flex flex-col md:flex-row justify-between items-start md:items-center gap-md">
        <div class="space-y-sm">
            <h2 class="font-h2 text-h2">Welcome back, <c:out value="${studentProfile != null ? studentProfile.fullName : user.username}"/>!</h2>
            <p class="font-body-lg text-on-primary-container max-w-2xl opacity-90">Your career journey is looking promising. You have ${fn:length(availableDrives)} new opportunities waiting for you.</p>
        </div>
        <button onclick="toggleProfileModal()" class="flex items-center gap-xs bg-white text-primary px-md py-sm rounded-lg font-button hover:bg-secondary hover:text-white transition-all shadow-md active:scale-95">
            <span class="material-symbols-outlined text-[20px]">edit_square</span>
            Update Profile
        </button>
    </div>
</section>

<!-- Stat Cards Bento Grid -->
<section class="grid grid-cols-1 md:grid-cols-3 gap-md">
    <a href="${pageContext.request.contextPath}/student?view=drives" class="glass-card p-lg rounded-xl border border-outline-variant shadow-sm hover:shadow-md hover:scale-[1.02] transition-all flex flex-col justify-between cursor-pointer">
        <div class="flex justify-between items-start">
            <span class="material-symbols-outlined text-secondary p-sm bg-secondary/10 rounded-lg">rocket_launch</span>
            <span class="font-label-caps text-secondary text-xs font-bold">Available Now</span>
        </div>
        <div class="mt-md">
            <p class="font-h1 text-4xl font-bold text-primary">${fn:length(availableDrives)}</p>
            <p class="font-body-md font-semibold text-on-surface-variant">Eligible Drives</p>
        </div>
    </a>
    <a href="${pageContext.request.contextPath}/student?view=applications" class="glass-card p-lg rounded-xl border border-outline-variant shadow-sm hover:shadow-md hover:scale-[1.02] transition-all flex flex-col justify-between cursor-pointer">
        <div class="flex justify-between items-start">
            <span class="material-symbols-outlined text-primary p-sm bg-primary/5 rounded-lg">send</span>
            <span class="font-label-caps text-on-surface-variant text-xs font-bold">Applications</span>
        </div>
        <div class="mt-md flex items-end gap-sm">
            <div>
                <p class="font-h1 text-4xl font-bold text-primary">${applicationStats['APPLIED'] + applicationStats['SHORTLISTED'] + applicationStats['INTERVIEW_SCHEDULED'] + applicationStats['REJECTED'] + applicationStats['SELECTED']}</p>
                <p class="font-body-md font-semibold text-on-surface-variant">Total Applied</p>
            </div>
            <div class="pb-1 ml-auto text-right">
                <p class="text-[12px] font-bold text-secondary">${applicationStats['SHORTLISTED'] + applicationStats['INTERVIEW_SCHEDULED']} Shortlisted</p>
                <p class="text-[12px] font-bold text-green-600">${applicationStats['SELECTED']} Selected</p>
            </div>
        </div>
    </a>
    <div class="glass-card p-lg rounded-xl border border-outline-variant shadow-sm hover:shadow-md transition-all">
        <div class="flex justify-between items-start mb-md">
            <span class="material-symbols-outlined text-secondary p-sm bg-secondary/10 rounded-lg">person</span>
            <div class="text-right">
                <p class="font-body-sm text-on-surface-variant text-sm">Academic Status</p>
                <p class="font-h3 text-xl font-bold text-primary"><c:out value="${studentProfile != null ? studentProfile.cgpa : 'N/A'}"/></p>
            </div>
        </div>
        <div class="grid grid-cols-2 gap-sm text-sm mb-md">
            <div class="p-xs bg-surface-container rounded">
                <p class="text-on-surface-variant text-[10px] uppercase font-bold">Roll No.</p>
                <p class="font-semibold text-on-surface truncate"><c:out value="${studentProfile != null ? studentProfile.rollNumber : '-'}"/></p>
            </div>
            <div class="p-xs bg-surface-container rounded">
                <p class="text-on-surface-variant text-[10px] uppercase font-bold">Sem</p>
                <p class="font-semibold text-on-surface"><c:out value="${studentProfile != null ? studentProfile.semester : '-'}"/></p>
            </div>
        </div>
        <div class="space-y-1">
            <p class="text-on-surface-variant text-[10px] uppercase font-bold">Top Skills</p>
            <div class="flex flex-wrap gap-1">
                <c:forEach var="skill" items="${fn:split(studentProfile.skills, ',')}">
                    <span class="px-2 py-0.5 bg-secondary/10 text-secondary rounded text-[10px] font-bold uppercase"><c:out value="${fn:trim(skill)}"/></span>
                </c:forEach>
                <c:if test="${empty studentProfile.skills}">
                    <span class="text-on-surface-variant text-[11px] italic">No skills added yet</span>
                </c:if>
            </div>
        </div>
    </div>
</section>

<div class="grid grid-cols-1 lg:grid-cols-5 gap-lg">
    <!-- Recent Eligible Drives -->
    <section class="lg:col-span-3 space-y-md">
        <div class="flex justify-between items-end">
            <h3 class="font-h3 text-xl font-bold text-primary">Recent Eligible Drives</h3>
            <a class="text-secondary font-semibold hover:underline text-sm" href="student?view=drives">View All</a>
        </div>
        <div class="space-y-sm">
            <c:forEach var="drive" items="${availableDrives}" end="3">
                <div class="glass-card p-md rounded-xl border border-outline-variant flex items-center justify-between hover:border-secondary transition-colors group">
                    <div class="flex items-center gap-md">
                        <div class="w-12 h-12 bg-surface-container flex items-center justify-center rounded-lg overflow-hidden border border-outline-variant">
                            <span class="material-symbols-outlined text-2xl text-on-surface-variant">business</span>
                        </div>
                        <div>
                            <h4 class="font-body-md font-bold text-primary"><c:out value="${drive.jobRole}"/></h4>
                            <p class="font-body-sm text-sm text-on-surface-variant"><c:out value="${drive.companyName}"/> • <c:out value="${drive.driveDate}"/></p>
                        </div>
                    </div>
                    <form action="student" method="post" class="m-0">
                        <input type="hidden" name="action" value="apply">
                        <input type="hidden" name="driveId" value="${drive.id}">
                        <button type="submit" class="bg-primary hover:bg-primary-container text-white px-md py-sm rounded-lg font-button transition-all group-hover:scale-105">Apply</button>
                    </form>
                </div>
            </c:forEach>
            <c:if test="${empty availableDrives}">
                <p class="text-on-surface-variant text-body-md text-center py-md">No eligible drives currently available.</p>
            </c:if>
        </div>
    </section>
    <!-- Upcoming Interviews -->
    <section class="lg:col-span-2 space-y-md">
        <div class="flex justify-between items-end">
            <h3 class="font-h3 text-xl font-bold text-primary">Upcoming Interviews</h3>
            <span class="text-on-surface-variant text-xs font-bold uppercase tracking-wider">${fn:length(upcomingInterviews)} Scheduled</span>
        </div>
        <div class="glass-card p-lg rounded-xl border border-outline-variant flex flex-col gap-md relative">
            <c:forEach var="interview" items="${upcomingInterviews}">
                <c:if test="${interview.status == 'SCHEDULED'}">
                    <div class="p-md rounded-xl bg-secondary/5 border border-secondary/10 hover:border-secondary transition-all">
                        <div class="flex justify-between items-start mb-sm">
                            <div>
                                <h4 class="font-bold text-primary leading-none mb-1"><c:out value="${interview.roundName}"/></h4>
                                <p class="text-xs font-bold text-secondary uppercase tracking-tighter"><c:out value="${interview.studentName}"/> • <c:out value="${interview.jobRole}"/></p>
                            </div>
                            <div class="bg-white p-xs rounded shadow-sm text-center min-w-[50px]">
                                <p class="text-[10px] font-bold text-secondary uppercase leading-none">${fn:substring(interview.dateTime, 8, 10)}</p>
                                <p class="text-[10px] font-bold text-primary leading-none mt-0.5">${fn:substring(interview.dateTime, 5, 7)}</p>
                            </div>
                        </div>
                        <div class="flex items-center justify-between gap-sm mt-md">
                            <div class="flex items-center gap-1 text-on-surface-variant">
                                <span class="material-symbols-outlined text-[16px]">schedule</span>
                                <span class="text-[12px] font-medium">${fn:substring(interview.dateTime, 11, 16)}</span>
                            </div>
                            <c:if test="${not empty interview.meetingLink}">
                                <a href="${interview.meetingLink}" target="_blank" class="flex items-center gap-1 bg-secondary text-white px-md py-1.5 rounded-lg text-xs font-bold hover:bg-primary transition-all">
                                    <span class="material-symbols-outlined text-[16px]">video_call</span>
                                    Join Meeting
                                </a>
                            </c:if>
                        </div>
                    </div>
                </c:if>
            </c:forEach>
            <c:if test="${empty upcomingInterviews}">
                <div class="text-center py-lg opacity-60">
                    <span class="material-symbols-outlined text-4xl mb-2">event_busy</span>
                    <p class="text-sm font-medium">No interviews scheduled</p>
                </div>
            </c:if>
        </div>

<!-- New: Interview History & Results Section -->
<section class="mt-lg space-y-md">
    <div class="flex justify-between items-end">
        <h3 class="font-h3 text-xl font-bold text-primary">Interview Results & Feedback</h3>
        <span class="text-on-surface-variant text-xs font-bold uppercase tracking-wider">Historical Records</span>
    </div>
    
    <div class="grid grid-cols-1 md:grid-cols-2 gap-md">
        <c:forEach var="interview" items="${upcomingInterviews}">
            <c:if test="${interview.status == 'COMPLETED'}">
                <div class="glass-card p-lg rounded-2xl border border-outline-variant hover:border-secondary transition-all">
                    <div class="flex justify-between items-start mb-md">
                        <div>
                            <h4 class="font-bold text-primary text-lg leading-tight mb-1"><c:out value="${interview.studentName}"/></h4>
                            <p class="text-xs font-bold text-on-surface-variant uppercase tracking-tighter"><c:out value="${interview.jobRole}"/> • <c:out value="${interview.roundName}"/></p>
                        </div>
                        <span class="px-3 py-1 rounded-full text-[10px] font-bold uppercase tracking-widest shadow-sm
                            ${interview.result == 'SELECTED' ? 'bg-green-100 text-green-700' : 
                              (interview.result == 'REJECTED' ? 'bg-red-100 text-red-700' : 'bg-blue-100 text-blue-700')}">
                            <c:out value="${interview.result != null ? interview.result : 'Result Pending'}"/>
                        </span>
                    </div>
                    
                    <div class="bg-surface-container/50 rounded-xl p-md border border-outline-variant/30">
                        <div class="flex items-center gap-1 mb-2 text-primary">
                            <span class="material-symbols-outlined text-[16px]">comment</span>
                            <span class="text-xs font-bold uppercase tracking-wider">Feedback</span>
                        </div>
                        <p class="text-sm text-on-surface leading-relaxed italic">
                            "<c:out value="${not empty interview.feedback ? interview.feedback : 'No feedback provided yet.'}"/>"
                        </p>
                    </div>
                    
                    <div class="mt-md pt-md border-t border-outline-variant/30 flex justify-between items-center text-[10px] font-bold text-on-surface-variant uppercase">
                        <span>Interview Date: ${fn:substring(interview.dateTime, 0, 16)}</span>
                    </div>
                </div>
            </c:if>
        </c:forEach>
    </div>
    
    <c:set var="hasHistory" value="false"/>
    <c:forEach var="i" items="${upcomingInterviews}">
        <c:if test="${i.status == 'COMPLETED'}"><c:set var="hasHistory" value="true"/></c:if>
    </c:forEach>
    
    <c:if test="${not hasHistory}">
        <div class="glass-card p-xl rounded-2xl border border-dashed border-outline-variant text-center opacity-60">
            <span class="material-symbols-outlined text-4xl mb-2 text-on-surface-variant">history</span>
            <p class="text-sm font-medium">No interview history found yet.</p>
        </div>
    </c:if>
</section>

<!-- Applications Quick Status -->
<div class="mt-lg">
    <div class="flex justify-between items-end mb-md">
        <h3 class="font-h3 text-lg font-bold text-primary">Recent Application Status</h3>
        <a class="text-secondary font-semibold hover:underline text-xs" href="student?view=applications">See All</a>
    </div>
    <div class="glass-card p-md rounded-xl border border-outline-variant flex flex-col gap-sm">
        <c:forEach var="app" items="${myApplications}" end="3">
            <div class="flex items-center justify-between p-sm hover:bg-surface-container-low rounded-lg transition-colors border-b border-outline-variant last:border-0">
                <div class="flex-1 min-w-0">
                    <p class="font-bold text-primary text-sm truncate"><c:out value="${app.companyName}"/></p>
                    <p class="text-[10px] text-on-surface-variant font-medium uppercase tracking-tighter"><c:out value="${app.jobRole}"/> • Round: <c:out value="${app.currentRound != null ? app.currentRound : 'Applied'}"/></p>
                </div>
                <div class="flex flex-col items-end gap-1">
                    <span class="px-2 py-0.5 rounded text-[9px] font-bold uppercase tracking-wider
                        ${app.status == 'SELECTED' ? 'bg-green-100 text-green-700' : 
                          (app.status == 'REJECTED' ? 'bg-red-100 text-red-700' : 'bg-blue-100 text-blue-700')}">
                        <c:out value="${app.status}"/>
                    </span>
                    <span class="text-[8px] text-on-surface-variant font-medium">${app.appliedAt}</span>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
