<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- Bottom Navigation for Mobile -->
<nav class="md:hidden fixed bottom-0 left-0 right-0 h-16 bg-surface/80 backdrop-blur-md border-t border-outline-variant/30 flex items-center justify-around px-md z-40">
    <a class="flex flex-col items-center gap-1 ${currentView == 'dashboard' ? 'text-secondary' : 'text-on-surface-variant'}" href="company?view=dashboard">
        <span class="material-symbols-outlined" style="font-variation-settings: 'FILL' ${currentView == 'dashboard' ? '1' : '0'};">dashboard</span>
        <span class="text-[10px] ${currentView == 'dashboard' ? 'font-bold' : ''}">Home</span>
    </a>
    <a class="flex flex-col items-center gap-1 ${currentView == 'manageDrives' ? 'text-secondary' : 'text-on-surface-variant'}" href="company?view=manageDrives">
        <span class="material-symbols-outlined" style="font-variation-settings: 'FILL' ${currentView == 'manageDrives' ? '1' : '0'};">event_note</span>
        <span class="text-[10px] ${currentView == 'manageDrives' ? 'font-bold' : ''}">Drives</span>
    </a>
    <a class="flex flex-col items-center gap-1 ${currentView == 'applicantReview' ? 'text-secondary' : 'text-on-surface-variant'}" href="company?view=applicantReview">
        <span class="material-symbols-outlined" style="font-variation-settings: 'FILL' ${currentView == 'applicantReview' ? '1' : '0'};">group</span>
        <span class="text-[10px] ${currentView == 'applicantReview' ? 'font-bold' : ''}">Applicants</span>
    </a>
    <a class="flex flex-col items-center gap-1 ${currentView == 'interviews' ? 'text-secondary' : 'text-on-surface-variant'}" href="company?view=interviews">
        <span class="material-symbols-outlined" style="font-variation-settings: 'FILL' ${currentView == 'interviews' ? '1' : '0'};">video_chat</span>
        <span class="text-[10px] ${currentView == 'interviews' ? 'font-bold' : ''}">Interviews</span>
    </a>
    <a class="flex flex-col items-center gap-1 ${currentView == 'profile' ? 'text-secondary' : 'text-on-surface-variant'}" href="company?view=profile">
        <span class="material-symbols-outlined" style="font-variation-settings: 'FILL' ${currentView == 'profile' ? '1' : '0'};">account_circle</span>
        <span class="text-[10px] ${currentView == 'profile' ? 'font-bold' : ''}">Profile</span>
    </a>
</nav>
