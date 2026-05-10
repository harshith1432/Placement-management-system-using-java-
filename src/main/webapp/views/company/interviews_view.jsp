<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<section class="space-y-lg">
    <div class="flex justify-between items-center">
        <div>
            <h2 class="font-h2 text-h2 text-on-surface">Scheduled Interviews</h2>
            <p class="text-on-surface-variant">Track and join your upcoming candidate interviews.</p>
        </div>
    </div>

<div class="grid grid-cols-1 xl:grid-cols-12 gap-lg">
    <!-- Scheduled Interviews -->
    <div class="xl:col-span-8 space-y-md">
        <div class="flex justify-between items-center">
            <h3 class="font-h3 text-h3 text-on-surface">Upcoming Interviews</h3>
            <span class="text-xs text-on-surface-variant bg-surface-container px-2 py-1 rounded-full">${fn:length(interviews)} Total</span>
        </div>
        
        <div class="grid grid-cols-1 md:grid-cols-2 gap-md">
            <c:forEach items="${interviews}" var="interview">
                <div class="glass-card p-lg rounded-2xl border-l-4 ${interview.status == 'SCHEDULED' ? 'border-l-secondary' : 'border-l-outline-variant'} flex flex-col justify-between">
                    <div>
                        <div class="flex justify-between items-start mb-md">
                            <div>
                                <h4 class="font-bold text-on-surface">${interview.roundName}</h4>
                                <p class="text-on-surface-variant text-sm">${interview.jobRole}</p>
                            </div>
                            <span class="px-2 py-0.5 rounded-full text-[10px] font-bold border ${interview.status == 'SCHEDULED' ? 'bg-secondary/10 text-secondary border-secondary/20' : 'bg-surface-container-highest text-on-surface-variant border-outline-variant'}">
                                ${interview.status}
                            </span>
                        </div>
                        
                        <div class="space-y-sm mb-lg">
                            <div class="flex items-center gap-xs text-on-surface text-sm font-medium">
                                <span class="material-symbols-outlined text-sm text-secondary">person</span>
                                ${interview.studentName}
                            </div>
                            <div class="flex items-center gap-xs text-on-surface-variant text-[13px]">
                                <span class="material-symbols-outlined text-sm">calendar_today</span>
                                ${interview.dateTime}
                            </div>
                            <c:if test="${not empty interview.notes}">
                                <p class="text-[12px] text-on-surface-variant italic bg-surface-container/30 p-2 rounded-lg mt-sm">
                                    "${interview.notes}"
                                </p>
                            </c:if>
                        </div>
                    </div>

                    <div class="flex flex-col gap-2 pt-md border-t border-outline-variant/30">
                        <c:choose>
                            <c:when test="${interview.status == 'SCHEDULED'}">
                                <a href="${interview.meetingLink}" target="_blank" class="w-full bg-primary text-on-primary py-2 rounded-lg font-button text-center text-sm shadow-btn hover:opacity-90 transition-all active:scale-[0.98] flex items-center justify-center gap-2">
                                    <span class="material-symbols-outlined text-sm">videocam</span>
                                    Join Meeting
                                </a>
                                <form action="company" method="post" class="w-full">
                                    <input type="hidden" name="action" value="updateInterviewStatus">
                                    <input type="hidden" name="interviewId" value="${interview.id}">
                                    <input type="hidden" name="status" value="COMPLETED">
                                    <input type="hidden" name="redirectView" value="interviews">
                                    <button type="submit" class="w-full border border-outline-variant py-2 rounded-lg font-button text-sm hover:bg-surface-variant/30 transition-colors">Mark Completed</button>
                                </form>
                                <button onclick="openRecordResultModal(${interview.id}, ${interview.applicationId}, '${fn:escapeXml(interview.studentName)}')" class="w-full bg-secondary text-on-secondary py-2 rounded-lg font-button text-sm shadow-btn-secondary hover:opacity-90 transition-all active:scale-[0.98] flex items-center justify-center gap-2 mt-2">
                                    <span class="material-symbols-outlined text-sm">assignment_turned_in</span>
                                    Record Result
                                </button>
                            </c:when>
                            <c:otherwise>
                                <button disabled class="w-full bg-surface-container-highest text-on-surface-variant py-2 rounded-lg font-button text-sm cursor-not-allowed">Interview ${interview.status}</button>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </c:forEach>
            <c:if test="${empty interviews}">
                <div class="col-span-full py-xl text-center glass-card rounded-2xl border-dashed border-2 border-outline-variant/30 bg-transparent">
                    <span class="material-symbols-outlined text-6xl text-outline-variant mb-md opacity-20">videocam_off</span>
                    <p class="text-on-surface-variant">No interviews found.</p>
                </div>
            </c:if>
        </div>
    </div>

    <!-- Ready for Scheduling -->
    <div class="xl:col-span-4 space-y-md">
        <h3 class="font-h3 text-h3 text-on-surface">Available Candidates</h3>
        <div class="glass-card rounded-2xl p-md overflow-hidden">
            <p class="text-xs text-on-surface-variant mb-md px-1">Shortlisted students waiting for interview slots.</p>
            <div class="space-y-sm max-h-[600px] overflow-y-auto pr-2 custom-scrollbar">
                <c:set var="shortlistedCount" value="0" />
                <c:forEach items="${allApplicants}" var="app">
                    <c:if test="${app.status == 'SHORTLISTED'}">
                        <c:set var="shortlistedCount" value="${shortlistedCount + 1}" />
                        <div class="p-sm rounded-xl border border-outline-variant/30 hover:border-secondary/50 transition-colors bg-surface-container/20">
                            <div class="flex justify-between items-start mb-2">
                                <div>
                                    <p class="font-bold text-on-surface text-sm">${app.studentName}</p>
                                    <p class="text-[11px] text-on-surface-variant">${app.jobRole}</p>
                                </div>
                                <span class="bg-secondary/10 text-secondary text-[10px] px-1.5 py-0.5 rounded font-bold">${app.studentCgpa} CGPA</span>
                            </div>
                        <button onclick="openScheduleModal(${app.id}, '${app.studentName}', 'interviews')" class="w-full bg-secondary text-on-secondary py-1.5 rounded-lg text-xs font-bold shadow-btn-secondary hover:opacity-90 transition-all active:scale-[0.98] flex items-center justify-center gap-1">
                                <span class="material-symbols-outlined text-sm">schedule</span>
                                Schedule Now
                            </button>
                        </div>
                    </c:if>
                </c:forEach>
                <c:if test="${shortlistedCount == 0}">
                    <div class="py-8 text-center">
                        <p class="text-xs text-on-surface-variant italic">No candidates ready to schedule.</p>
                        <a href="company?view=applicantReview" class="text-xs text-secondary mt-2 inline-block hover:underline">Go to Applicants</a>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</div>

<!-- Schedule Interview Modal -->
<jsp:include page="../../includes/schedule_interview_modal.jsp" />

<!-- Record Result Modal -->
<jsp:include page="../../includes/record_result_modal.jsp" />

