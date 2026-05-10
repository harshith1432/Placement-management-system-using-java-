<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<section class="glass-card rounded-2xl p-lg max-w-4xl mx-auto">
    <div class="flex items-center gap-lg mb-xl border-b border-outline-variant/30 pb-lg">
        <div class="relative group">
            <div class="w-32 h-32 rounded-2xl bg-surface-container-highest flex items-center justify-center overflow-hidden border-2 border-outline-variant group-hover:border-secondary transition-colors">
                <c:choose>
                    <c:when test="${not empty company.logoUrl}">
                        <img src="${company.logoUrl}" alt="Logo" class="w-full h-full object-cover">
                    </c:when>
                    <c:otherwise>
                        <span class="material-symbols-outlined text-4xl text-on-surface-variant group-hover:text-secondary">business</span>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
        <div>
            <h3 class="font-h2 text-h2 text-on-surface">${company.companyName}</h3>
            <p class="text-on-surface-variant font-body-lg">${company.industryType} • ${company.location}</p>
        </div>
    </div>

    <form action="company" method="post" class="grid grid-cols-1 md:grid-cols-2 gap-lg">
        <input type="hidden" name="action" value="updateProfile">
        <input type="hidden" name="redirectView" value="profile">
        
        <div class="space-y-sm">
            <label class="font-label-caps text-on-surface-variant">Company Name</label>
            <input type="text" name="companyName" value="${company.companyName}" class="w-full rounded-lg border-outline-variant bg-surface-container-lowest focus:ring-secondary focus:border-secondary" required>
        </div>
        <div class="space-y-sm">
            <label class="font-label-caps text-on-surface-variant">HR Name</label>
            <input type="text" name="hrName" value="${company.hrName}" class="w-full rounded-lg border-outline-variant bg-surface-container-lowest focus:ring-secondary focus:border-secondary">
        </div>
        <div class="space-y-sm">
            <label class="font-label-caps text-on-surface-variant">Industry Type</label>
            <select name="industryType" class="w-full rounded-lg border-outline-variant bg-surface-container-lowest focus:ring-secondary focus:border-secondary">
                <option value="IT/Software" ${company.industryType == 'IT/Software' ? 'selected' : ''}>IT/Software</option>
                <option value="Finance" ${company.industryType == 'Finance' ? 'selected' : ''}>Finance</option>
                <option value="Manufacturing" ${company.industryType == 'Manufacturing' ? 'selected' : ''}>Manufacturing</option>
                <option value="E-commerce" ${company.industryType == 'E-commerce' ? 'selected' : ''}>E-commerce</option>
                <option value="Other" ${company.industryType == 'Other' ? 'selected' : ''}>Other</option>
            </select>
        </div>
        <div class="space-y-sm">
            <label class="font-label-caps text-on-surface-variant">Location</label>
            <input type="text" name="location" value="${company.location}" class="w-full rounded-lg border-outline-variant bg-surface-container-lowest focus:ring-secondary focus:border-secondary">
        </div>
        <div class="space-y-sm md:col-span-2">
            <label class="font-label-caps text-on-surface-variant">Company Description</label>
            <textarea name="description" rows="4" class="w-full rounded-lg border-outline-variant bg-surface-container-lowest focus:ring-secondary focus:border-secondary">${company.description}</textarea>
        </div>
        <div class="space-y-sm">
            <label class="font-label-caps text-on-surface-variant">Website</label>
            <input type="url" name="website" value="${company.website}" class="w-full rounded-lg border-outline-variant bg-surface-container-lowest focus:ring-secondary focus:border-secondary">
        </div>
        <div class="space-y-sm">
            <label class="font-label-caps text-on-surface-variant">Logo URL</label>
            <input type="text" name="logoUrl" value="${company.logoUrl}" class="w-full rounded-lg border-outline-variant bg-surface-container-lowest focus:ring-secondary focus:border-secondary">
        </div>
        <div class="space-y-sm">
            <label class="font-label-caps text-on-surface-variant">Contact Email</label>
            <input type="email" name="contactEmail" value="${company.contactEmail}" class="w-full rounded-lg border-outline-variant bg-surface-container-lowest focus:ring-secondary focus:border-secondary">
        </div>
        <div class="space-y-sm">
            <label class="font-label-caps text-on-surface-variant">Contact Phone</label>
            <input type="tel" name="contactPhone" value="${company.contactPhone}" class="w-full rounded-lg border-outline-variant bg-surface-container-lowest focus:ring-secondary focus:border-secondary">
        </div>
        
        <div class="md:col-span-2 pt-lg flex justify-end">
            <button type="submit" class="bg-secondary text-on-secondary px-xl py-sm rounded-xl font-button hover:opacity-90 transition-all shadow-btn-secondary active:scale-95">Save Changes</button>
        </div>
    </form>
</section>
