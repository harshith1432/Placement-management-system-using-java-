<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- NavigationDrawer -->
<aside class="h-screen w-64 fixed left-0 top-0 bg-surface/80 dark:bg-surface-dim/80 backdrop-blur-md z-50 hidden md:flex flex-col py-md px-sm bg-surface-container-low shadow-sm">
    <div class="mb-xl px-sm">
        <span class="font-h2 text-h2 font-extrabold text-primary">CareerNexus</span>
    </div>
    <nav class="flex-1 space-y-xs">
        <a class="flex items-center gap-sm px-md py-sm rounded-lg transition-all ${currentView == 'dashboard' ? 'text-secondary font-bold border-r-2 border-secondary bg-secondary-container/10' : 'text-on-surface-variant hover:bg-surface-variant/50'}" href="company?view=dashboard">
            <span class="material-symbols-outlined" style="font-variation-settings: 'FILL' ${currentView == 'dashboard' ? '1' : '0'};">dashboard</span>
            <span class="font-body-md">Dashboard</span>
        </a>
        <a class="flex items-center gap-sm px-md py-sm rounded-lg transition-all ${currentView == 'profile' ? 'text-secondary font-bold border-r-2 border-secondary bg-secondary-container/10' : 'text-on-surface-variant hover:bg-surface-variant/50'}" href="company?view=profile">
            <span class="material-symbols-outlined" style="font-variation-settings: 'FILL' ${currentView == 'profile' ? '1' : '0'};">business</span>
            <span class="font-body-md">Company Profile</span>
        </a>
        <a class="flex items-center gap-sm px-md py-sm rounded-lg transition-all ${currentView == 'manageDrives' ? 'text-secondary font-bold border-r-2 border-secondary bg-secondary-container/10' : 'text-on-surface-variant hover:bg-surface-variant/50'}" href="company?view=manageDrives">
            <span class="material-symbols-outlined" style="font-variation-settings: 'FILL' ${currentView == 'manageDrives' ? '1' : '0'};">event_note</span>
            <span class="font-body-md">Manage Drives</span>
        </a>
        <a class="flex items-center gap-sm px-md py-sm rounded-lg transition-all ${currentView == 'applicantReview' ? 'text-secondary font-bold border-r-2 border-secondary bg-secondary-container/10' : 'text-on-surface-variant hover:bg-surface-variant/50'}" href="company?view=applicantReview">
            <span class="material-symbols-outlined" style="font-variation-settings: 'FILL' ${currentView == 'applicantReview' ? '1' : '0'};">person_search</span>
            <span class="font-body-md">Applicant Review</span>
        </a>
        <a class="flex items-center gap-sm px-md py-sm rounded-lg transition-all ${currentView == 'interviews' ? 'text-secondary font-bold border-r-2 border-secondary bg-secondary-container/10' : 'text-on-surface-variant hover:bg-surface-variant/50'}" href="company?view=interviews">
            <span class="material-symbols-outlined" style="font-variation-settings: 'FILL' ${currentView == 'interviews' ? '1' : '0'};">video_chat</span>
            <span class="font-body-md">Interviews</span>
        </a>
    </nav>
    <a href="logout" class="mt-auto px-md py-sm border-t border-outline-variant/30 flex items-center gap-sm text-on-surface-variant hover:text-error hover:bg-error/5 rounded-lg transition-all">
        <span class="material-symbols-outlined">logout</span>
        <span class="font-body-md">Sign Out</span>
    </a>
</aside>
