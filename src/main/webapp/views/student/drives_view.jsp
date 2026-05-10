<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- All Eligible Drives View -->
<section class="space-y-md">
    <div class="flex flex-col md:flex-row justify-between items-start md:items-center gap-md mb-md">
        <div>
            <h2 class="font-h2 text-3xl font-bold text-primary">Eligible Opportunities</h2>
            <p class="text-on-surface-variant">Based on your CGPA (<c:out value="${studentProfile.cgpa}"/>) and Department (<c:out value="${studentProfile.department}"/>)</p>
        </div>
        <div class="relative w-full md:w-64">
            <span class="material-symbols-outlined absolute left-sm top-1/2 -translate-y-1/2 text-on-surface-variant">search</span>
            <input type="text" id="driveSearch" placeholder="Search roles or companies..." class="w-full pl-lg pr-md py-sm bg-surface-container-low border border-outline-variant rounded-lg focus:ring-2 focus:ring-secondary/20 focus:border-secondary outline-none transition-all">
        </div>
    </div>

    <div class="grid grid-cols-1 md:grid-cols-2 gap-md" id="driveGrid">
        <c:forEach var="drive" items="${availableDrives}">
            <div class="glass-card p-lg rounded-2xl border border-outline-variant hover:border-secondary transition-all group hover:shadow-lg">
                <div class="flex justify-between items-start mb-md">
                    <div class="flex items-center gap-md">
                        <div class="w-14 h-14 bg-surface-container flex items-center justify-center rounded-xl border border-outline-variant group-hover:scale-110 transition-transform">
                            <span class="material-symbols-outlined text-3xl text-secondary">business</span>
                        </div>
                        <div>
                            <h4 class="font-h3 text-[20px] font-bold text-primary drive-role"><c:out value="${drive.jobRole}"/></h4>
                            <p class="font-body-md text-on-surface-variant font-medium drive-company"><c:out value="${drive.companyName}"/></p>
                        </div>
                    </div>
                    <span class="px-sm py-1 rounded-full bg-secondary/10 text-secondary text-[12px] font-bold uppercase tracking-wider"><c:out value="${drive.packageLpa}"/> LPA</span>
                </div>
                
                <div class="grid grid-cols-2 gap-md mb-lg">
                    <div class="space-y-1">
                        <p class="text-on-surface-variant text-[10px] uppercase font-bold tracking-widest">Drive Date</p>
                        <div class="flex items-center gap-xs text-on-surface">
                            <span class="material-symbols-outlined text-[18px]">calendar_today</span>
                            <span class="font-semibold text-sm"><c:out value="${drive.driveDate}"/></span>
                        </div>
                    </div>
                    <div class="space-y-1">
                        <p class="text-on-surface-variant text-[10px] uppercase font-bold tracking-widest">Eligibility</p>
                        <div class="flex items-center gap-xs text-on-surface">
                            <span class="material-symbols-outlined text-[18px]">grade</span>
                            <span class="font-semibold text-sm"><c:out value="${drive.cgpaReq}"/>+ CGPA</span>
                        </div>
                    </div>
                </div>

                <div class="flex items-center justify-between pt-md border-t border-outline-variant/30">
                    <span class="text-sm text-on-surface-variant italic">Branch: <c:out value="${drive.branchReq}"/></span>
                    <form action="student" method="post" class="m-0">
                        <input type="hidden" name="action" value="apply">
                        <input type="hidden" name="driveId" value="${drive.id}">
                        <button type="submit" class="bg-primary hover:bg-secondary text-white px-lg py-sm rounded-lg font-button transition-all shadow-md active:scale-95">Apply Now</button>
                    </form>
                </div>
            </div>
        </c:forEach>
    </div>
    <c:if test="${empty availableDrives}">
        <div class="text-center py-xl bg-surface-container-low rounded-2xl border-2 border-dashed border-outline-variant">
            <span class="material-symbols-outlined text-6xl text-outline mb-md">info</span>
            <h3 class="font-h3 text-xl font-bold text-primary">No Eligible Drives</h3>
            <p class="text-on-surface-variant max-w-md mx-auto">There are no placement drives matching your profile at the moment. Keep your profile updated to see new opportunities.</p>
        </div>
    </c:if>
</section>
