<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<section class="space-y-lg">
    <div class="flex justify-between items-center">
        <div>
            <h2 class="font-h2 text-h2 text-on-surface">Campus Drives</h2>
            <p class="text-on-surface-variant">Manage your active and past recruitment drives.</p>
        </div>
        <button onclick="document.getElementById('newDriveModal').showModal()" class="bg-[#2563eb] text-white px-6 py-2.5 rounded-xl font-bold flex items-center gap-2 hover:bg-[#1d4ed8] shadow-xl transition-all active:scale-95 border-2 border-[#1e40af]">
            <span class="material-symbols-outlined font-bold">add</span>
            Post New Drive
        </button>
    </div>

    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-md">
        <c:forEach items="${myDrives}" var="drive">
            <div class="glass-card p-md rounded-2xl flex flex-col hover:shadow-lg transition-all group border-l-4 ${drive.status == 'OPEN' ? 'border-l-secondary' : 'border-l-surface-container-highest'}">
                <div class="flex justify-between items-start mb-sm">
                    <div class="px-3 py-1 rounded-full text-[10px] font-bold ${drive.status == 'OPEN' ? 'bg-secondary/10 text-secondary' : 'bg-surface-container-highest text-on-surface-variant'} border">
                        ${drive.status}
                    </div>
                    <div class="flex gap-xs opacity-0 group-hover:opacity-100 transition-opacity">
                        <button 
                            onclick="openEditDriveModal(this)" 
                            data-id="${drive.id}" 
                            data-role="${fn:escapeXml(drive.jobRole)}" 
                            data-desc="${fn:escapeXml(drive.jobDescription)}" 
                            data-pkg="${drive.packageLpa}" 
                            data-cgpa="${drive.cgpaReq}" 
                            data-branch="${fn:escapeXml(drive.branchReq)}" 
                            data-date="${drive.driveDate}" 
                            data-status="${drive.status}"
                            class="p-1.5 hover:bg-surface-variant rounded-full text-on-surface-variant">
                            <span class="material-symbols-outlined text-sm">edit</span>
                        </button>
                        <form action="company" method="post" onsubmit="return confirm('Delete this drive?')">
                            <input type="hidden" name="action" value="deleteDrive">
                            <input type="hidden" name="driveId" value="${drive.id}">
                            <input type="hidden" name="redirectView" value="manageDrives">
                            <button type="submit" class="p-1.5 hover:bg-error/10 rounded-full text-error">
                                <span class="material-symbols-outlined text-sm">delete</span>
                            </button>
                        </form>
                    </div>
                </div>
                <h4 class="font-h3 text-h3 text-on-surface mb-xs">${drive.jobRole}</h4>
                <div class="flex flex-col gap-2 flex-1">
                    <div class="flex items-center gap-xs text-on-surface-variant text-sm">
                        <span class="material-symbols-outlined text-sm">payments</span>
                        ₹${drive.packageLpa} LPA
                    </div>
                    <div class="flex items-center gap-xs text-on-surface-variant text-sm">
                        <span class="material-symbols-outlined text-sm">school</span>
                        ${drive.cgpaReq} CGPA • ${drive.branchReq}
                    </div>
                    <div class="flex items-center gap-xs text-on-surface-variant text-sm">
                        <span class="material-symbols-outlined text-sm">calendar_month</span>
                        Drive: ${drive.driveDate}
                    </div>
                </div>
                <div class="mt-lg pt-md border-t border-outline-variant/30 flex justify-between items-center">
                    <a href="company?view=applicantReview&driveId=${drive.id}" class="text-secondary font-button text-sm hover:underline">View Applicants</a>
                    <span class="text-xs text-outline font-semibold">ID: #${drive.id}</span>
                </div>
            </div>
        </c:forEach>
        <c:if test="${empty myDrives}">
            <div class="col-span-full py-xl text-center glass-card rounded-2xl">
                <span class="material-symbols-outlined text-6xl text-outline-variant mb-md">post_add</span>
                <p class="text-on-surface-variant">No drives posted yet. Click 'Post New Drive' to start recruiting.</p>
            </div>
        </c:if>
    </div>
</section>

<!-- New Drive Modal -->
<dialog id="newDriveModal" class="rounded-2xl p-0 backdrop:bg-on-surface/20 backdrop:backdrop-blur-sm shadow-2xl w-full max-w-md">
    <div class="p-lg">
        <div class="flex justify-between items-center mb-lg">
            <h3 class="font-h3 text-h3">Create New Drive</h3>
            <button onclick="document.getElementById('newDriveModal').close()" class="material-symbols-outlined">close</button>
        </div>
        <form action="company" method="post" class="space-y-md">
            <input type="hidden" name="action" value="createDrive">
            <input type="hidden" name="redirectView" value="manageDrives">
            
            <div class="space-y-xs">
                <label class="font-label-caps text-on-surface-variant">Job Role</label>
                <input type="text" name="jobRole" placeholder="e.g. Software Engineer" class="w-full rounded-lg border-outline-variant bg-surface-container-lowest" required>
            </div>
            <div class="space-y-xs">
                <label class="font-label-caps text-on-surface-variant">Job Description</label>
                <textarea name="jobDescription" placeholder="Describe the role and responsibilities..." class="w-full rounded-lg border-outline-variant bg-surface-container-lowest" rows="3"></textarea>
            </div>
            <div class="grid grid-cols-2 gap-md">
                <div class="space-y-xs">
                    <label class="font-label-caps text-on-surface-variant">Package (LPA)</label>
                    <input type="number" step="0.1" name="packageLpa" placeholder="12.5" class="w-full rounded-lg border-outline-variant bg-surface-container-lowest" required>
                </div>
                <div class="space-y-xs">
                    <label class="font-label-caps text-on-surface-variant">CGPA Req</label>
                    <input type="number" step="0.1" name="cgpaReq" placeholder="7.5" class="w-full rounded-lg border-outline-variant bg-surface-container-lowest" required>
                </div>
            </div>
            <div class="space-y-xs">
                <label class="font-label-caps text-on-surface-variant">Branch Req</label>
                <input type="text" name="branchReq" placeholder="CSE, IT, ECE" class="w-full rounded-lg border-outline-variant bg-surface-container-lowest" required>
            </div>
            <div class="space-y-xs">
                <label class="font-label-caps text-on-surface-variant">Drive Date</label>
                <input type="date" name="driveDate" class="w-full rounded-lg border-outline-variant bg-surface-container-lowest" required>
            </div>
            
            <div class="pt-lg">
                <button type="submit" class="w-full bg-[#2563eb] text-white py-3.5 rounded-xl font-bold shadow-xl hover:bg-[#1d4ed8] transition-all active:scale-[0.98] border-2 border-[#1e40af] text-lg">Post Drive</button>
            </div>
        </form>
    </div>
</dialog>

<!-- Edit Drive Modal -->
<dialog id="editDriveModal" class="rounded-2xl p-0 backdrop:bg-on-surface/20 backdrop:backdrop-blur-sm shadow-2xl w-full max-w-md">
    <div class="p-lg">
        <div class="flex justify-between items-center mb-lg">
            <h3 class="font-h3 text-h3">Edit Drive</h3>
            <button onclick="document.getElementById('editDriveModal').close()" class="material-symbols-outlined">close</button>
        </div>
        <form action="company" method="post" class="space-y-md">
            <input type="hidden" name="action" value="updateDrive">
            <input type="hidden" name="driveId" id="edit_driveId">
            <input type="hidden" name="redirectView" value="manageDrives">
            
            <div class="space-y-xs">
                <label class="font-label-caps text-on-surface-variant">Job Role</label>
                <input type="text" name="jobRole" id="edit_jobRole" class="w-full rounded-lg border-outline-variant bg-surface-container-lowest" required>
            </div>
            <div class="space-y-xs">
                <label class="font-label-caps text-on-surface-variant">Job Description</label>
                <textarea name="jobDescription" id="edit_jobDescription" class="w-full rounded-lg border-outline-variant bg-surface-container-lowest" rows="3"></textarea>
            </div>
            <div class="grid grid-cols-2 gap-md">
                <div class="space-y-xs">
                    <label class="font-label-caps text-on-surface-variant">Package (LPA)</label>
                    <input type="number" step="0.1" name="packageLpa" id="edit_packageLpa" class="w-full rounded-lg border-outline-variant bg-surface-container-lowest" required>
                </div>
                <div class="space-y-xs">
                    <label class="font-label-caps text-on-surface-variant">CGPA Req</label>
                    <input type="number" step="0.1" name="cgpaReq" id="edit_cgpaReq" class="w-full rounded-lg border-outline-variant bg-surface-container-lowest" required>
                </div>
            </div>
            <div class="space-y-xs">
                <label class="font-label-caps text-on-surface-variant">Branch Req</label>
                <input type="text" name="branchReq" id="edit_branchReq" class="w-full rounded-lg border-outline-variant bg-surface-container-lowest" required>
            </div>
            <div class="space-y-xs">
                <label class="font-label-caps text-on-surface-variant">Drive Date</label>
                <input type="date" name="driveDate" id="edit_driveDate" class="w-full rounded-lg border-outline-variant bg-surface-container-lowest" required>
            </div>
            <div class="space-y-xs">
                <label class="font-label-caps text-on-surface-variant">Status</label>
                <select name="status" id="edit_status" class="w-full rounded-lg border-outline-variant bg-surface-container-lowest">
                    <option value="OPEN">OPEN</option>
                    <option value="CLOSED">CLOSED</option>
                </select>
            </div>
            
            <div class="pt-lg">
                <button type="submit" class="w-full bg-[#0ea5e9] text-white py-3.5 rounded-xl font-bold shadow-xl hover:bg-[#0284c7] transition-all active:scale-[0.98] border-2 border-[#0369a1] text-lg">Update Drive Details</button>
            </div>
        </form>
    </div>
</dialog>

<script>
    function openEditDriveModal(btn) {
        document.getElementById('edit_driveId').value = btn.getAttribute('data-id');
        document.getElementById('edit_jobRole').value = btn.getAttribute('data-role');
        document.getElementById('edit_jobDescription').value = btn.getAttribute('data-desc');
        document.getElementById('edit_packageLpa').value = btn.getAttribute('data-pkg');
        document.getElementById('edit_cgpaReq').value = btn.getAttribute('data-cgpa');
        document.getElementById('edit_branchReq').value = btn.getAttribute('data-branch');
        document.getElementById('edit_driveDate').value = btn.getAttribute('data-date');
        document.getElementById('edit_status').value = btn.getAttribute('data-status');
        document.getElementById('editDriveModal').showModal();
    }
</script>
