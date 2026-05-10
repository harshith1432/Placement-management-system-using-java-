<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- Drive Details Modal -->
<div id="driveDetailsModal" class="fixed inset-0 z-[110] hidden overflow-y-auto">
    <div class="fixed inset-0 bg-black/60 backdrop-blur-sm transition-opacity" onclick="toggleDriveModal()"></div>
    <div class="relative min-h-screen flex items-center justify-center p-md">
        <div class="relative w-full max-w-lg bg-surface-container-lowest rounded-2xl shadow-2xl border border-outline-variant overflow-hidden animate-in zoom-in-95 duration-200">
            <div class="p-lg border-b border-outline-variant flex justify-between items-center bg-primary-container text-white">
                <div>
                    <h3 id="modalCompanyName" class="font-h3 text-xl font-bold">Company Name</h3>
                    <p id="modalJobRole" class="text-on-primary-container opacity-90">Job Role</p>
                </div>
                <button onclick="toggleDriveModal()" class="material-symbols-outlined p-xs hover:bg-white/10 rounded-full transition-all">close</button>
            </div>
            
            <div class="p-lg space-y-lg">
                <div class="grid grid-cols-2 gap-md">
                    <div class="space-y-1">
                        <p class="text-on-surface-variant text-[11px] uppercase font-bold tracking-widest">Application Status</p>
                        <p id="modalStatus" class="font-bold text-secondary">PENDING</p>
                    </div>
                    <div class="space-y-1">
                        <p class="text-on-surface-variant text-[11px] uppercase font-bold tracking-widest">Applied On</p>
                        <p id="modalAppliedDate" class="font-semibold text-on-surface">May 10, 2024</p>
                    </div>
                </div>
                
                <div class="p-md bg-surface-container rounded-xl border border-outline-variant">
                    <h4 class="font-bold text-primary mb-sm flex items-center gap-xs">
                        <span class="material-symbols-outlined text-[20px]">info</span>
                        Drive Overview
                    </h4>
                    <p class="text-sm text-on-surface-variant leading-relaxed">
                        You have successfully registered for this recruitment drive. Please ensure you are prepared for the selection process which may include online tests, technical rounds, and interviews.
                    </p>
                </div>

                <div class="space-y-sm">
                    <h4 class="font-bold text-primary">Next Steps</h4>
                    <ul class="space-y-xs text-sm text-on-surface-variant">
                        <li class="flex items-start gap-xs">
                            <span class="material-symbols-outlined text-secondary text-[18px]">check_circle</span>
                            Monitor your registered email for test links.
                        </li>
                        <li class="flex items-start gap-xs">
                            <span class="material-symbols-outlined text-secondary text-[18px]">check_circle</span>
                            Keep your resume and documents ready.
                        </li>
                    </ul>
                </div>
            </div>
            
            <div class="p-lg bg-surface-container-low border-t border-outline-variant flex justify-end">
                <button onclick="toggleDriveModal()" class="px-lg py-sm bg-primary text-white rounded-lg font-button shadow-md hover:bg-primary/90 transition-all active:scale-95">Close</button>
            </div>
        </div>
    </div>
</div>
