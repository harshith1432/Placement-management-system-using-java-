<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- TopAppBar -->
<header class="fixed top-0 right-0 z-40 flex justify-between items-center px-md h-16 w-full bg-surface/80 dark:bg-surface-dim/80 backdrop-blur-md shadow-sm md:pl-64">
    <div class="flex items-center gap-sm">
        <button class="md:hidden p-xs transition-all duration-200 hover:bg-surface-variant/30 rounded-full">
            <span class="material-symbols-outlined text-primary">menu</span>
        </button>
        <h1 class="font-h3 text-h3 font-semibold text-primary capitalize">${currentView}</h1>
    </div>
    <div class="flex items-center gap-sm">
        <span class="hidden md:block font-body-md font-semibold text-on-surface">
            <c:out value="${not empty company.companyName ? company.companyName : user.username}"/>
        </span>
        <div class="w-10 h-10 rounded-full bg-surface-container-high flex items-center justify-center overflow-hidden border border-outline-variant">
            <c:choose>
                <c:when test="${not empty company.logoUrl}">
                    <img src="${company.logoUrl}" alt="Logo" class="w-full h-full object-cover">
                </c:when>
                <c:otherwise>
                    <span class="material-symbols-outlined text-on-surface-variant">business</span>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</header>
