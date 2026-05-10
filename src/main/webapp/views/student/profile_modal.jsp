<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- Profile Edit Modal -->
<div id="profileModal" class="fixed inset-0 z-[100] hidden overflow-y-auto">
    <div class="fixed inset-0 bg-black/50 backdrop-blur-sm transition-opacity" onclick="toggleProfileModal()"></div>
    <div class="relative min-h-screen flex items-center justify-center p-md">
        <div class="relative w-full max-w-2xl bg-surface-container-lowest rounded-2xl shadow-xl border border-outline-variant overflow-hidden">
            <div class="p-lg border-b border-outline-variant flex justify-between items-center bg-surface-container-low">
                <h3 class="font-h3 text-xl font-bold text-primary">Update Student Profile</h3>
                <button onclick="toggleProfileModal()" class="material-symbols-outlined p-xs hover:bg-surface-container-high rounded-full transition-all">close</button>
            </div>
            
            <form action="student" method="post" class="p-lg">
                <input type="hidden" name="action" value="updateProfile">
                <div class="grid grid-cols-1 md:grid-cols-2 gap-md">
                    <!-- Basic Info -->
                    <div class="space-y-sm md:col-span-2">
                        <h4 class="font-bold text-secondary border-b border-outline-variant pb-1">Basic Information</h4>
                    </div>
                    
                    <div class="space-y-xs">
                        <label class="text-on-surface-variant uppercase text-[11px] font-bold">Full Name</label>
                        <input type="text" name="fullName" value="${studentProfile.fullName}" class="w-full p-sm bg-surface-container-low border-transparent focus:border-secondary focus:ring-0 rounded-lg" required>
                    </div>
                    <div class="space-y-xs">
                        <label class="text-on-surface-variant uppercase text-[11px] font-bold">Email Address</label>
                        <input type="email" name="email" value="${studentProfile.email}" class="w-full p-sm bg-surface-container-low border-transparent focus:border-secondary focus:ring-0 rounded-lg" required>
                    </div>
                    
                    <!-- Academic Info -->
                    <div class="space-y-sm md:col-span-2 mt-md">
                        <h4 class="font-bold text-secondary border-b border-outline-variant pb-1">Academic Details</h4>
                    </div>
                    
                    <div class="space-y-xs">
                        <label class="text-on-surface-variant uppercase text-[11px] font-bold">Department / Branch</label>
                        <select name="department" class="w-full p-sm bg-surface-container-low border-transparent focus:border-secondary focus:ring-0 rounded-lg">
                            <option value="Computer Science" ${studentProfile.department == 'Computer Science' ? 'selected' : ''}>Computer Science</option>
                            <option value="Information Technology" ${studentProfile.department == 'Information Technology' ? 'selected' : ''}>Information Technology</option>
                            <option value="Electronics" ${studentProfile.department == 'Electronics' ? 'selected' : ''}>Electronics</option>
                            <option value="Mechanical" ${studentProfile.department == 'Mechanical' ? 'selected' : ''}>Mechanical</option>
                            <option value="Civil" ${studentProfile.department == 'Civil' ? 'selected' : ''}>Civil</option>
                        </select>
                    </div>
                    <div class="space-y-xs">
                        <label class="text-on-surface-variant uppercase text-[11px] font-bold">Roll Number</label>
                        <input type="text" name="rollNumber" value="${studentProfile.rollNumber}" class="w-full p-sm bg-surface-container-low border-transparent focus:border-secondary focus:ring-0 rounded-lg" required placeholder="e.g. 20CS101">
                    </div>
                    <div class="space-y-xs">
                        <label class="text-on-surface-variant uppercase text-[11px] font-bold">Current CGPA</label>
                        <input type="number" step="0.01" min="0" max="10" name="cgpa" value="${studentProfile.cgpa}" class="w-full p-sm bg-surface-container-low border-transparent focus:border-secondary focus:ring-0 rounded-lg" required>
                    </div>
                    <div class="space-y-xs">
                        <label class="text-on-surface-variant uppercase text-[11px] font-bold">Current Semester</label>
                        <input type="number" min="1" max="8" name="semester" value="${studentProfile.semester}" class="w-full p-sm bg-surface-container-low border-transparent focus:border-secondary focus:ring-0 rounded-lg" required>
                    </div>
                    
                    <!-- Additional Info -->
                    <div class="space-y-sm md:col-span-2 mt-md">
                        <h4 class="font-bold text-secondary border-b border-outline-variant pb-1">Additional Information</h4>
                    </div>
                    
                    <div class="space-y-xs">
                        <label class="text-on-surface-variant uppercase text-[11px] font-bold">Contact Number</label>
                        <input type="text" name="contactNumber" value="${studentProfile.contactNumber}" class="w-full p-sm bg-surface-container-low border-transparent focus:border-secondary focus:ring-0 rounded-lg">
                    </div>
                    <div class="space-y-xs">
                        <label class="text-on-surface-variant uppercase text-[11px] font-bold">Skills (Comma separated)</label>
                        <input type="text" name="skills" value="${studentProfile.skills}" class="w-full p-sm bg-surface-container-low border-transparent focus:border-secondary focus:ring-0 rounded-lg" placeholder="Java, SQL, Spring Boot">
                    </div>
                    <div class="space-y-xs md:col-span-1">
                        <label class="text-on-surface-variant uppercase text-[11px] font-bold">Resume Link (Google Drive/Dropbox)</label>
                        <input type="url" name="resumeUrl" value="${studentProfile.resumeUrl}" class="w-full p-sm bg-surface-container-low border-transparent focus:border-secondary focus:ring-0 rounded-lg" placeholder="https://drive.google.com/...">
                    </div>
                    <div class="space-y-xs md:col-span-1">
                        <label class="text-on-surface-variant uppercase text-[11px] font-bold">Profile Photo URL</label>
                        <input type="url" name="profilePhotoUrl" value="${studentProfile.profilePhotoUrl}" class="w-full p-sm bg-surface-container-low border-transparent focus:border-secondary focus:ring-0 rounded-lg" placeholder="https://image-link.com/photo.jpg">
                    </div>
                </div>
                
                <div class="mt-lg flex justify-end gap-md">
                    <button type="button" onclick="toggleProfileModal()" class="px-md py-sm rounded-lg font-button text-on-surface-variant hover:bg-surface-container-high transition-all">Cancel</button>
                    <button type="submit" class="px-lg py-sm bg-secondary text-white rounded-lg font-button shadow-md hover:bg-secondary/90 transition-all active:scale-95">Save Profile</button>
                </div>
            </form>
        </div>
    </div>
</div>
