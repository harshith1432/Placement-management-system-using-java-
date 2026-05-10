<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- Add Company Modal -->
<div id="addModal" class="modal">
    <div class="glass-card p-8 rounded-3xl w-full max-w-xl shadow-2xl border border-outline-variant animate-scale-up">
        <div class="flex justify-between items-center mb-6">
            <h3 class="text-2xl font-bold text-on-surface">Register New Company</h3>
            <button onclick="closeModal('addModal')" class="p-2 hover:bg-surface-container-high rounded-full transition-colors">
                <span class="material-symbols-outlined">close</span>
            </button>
        </div>
        <form action="${pageContext.request.contextPath}/admin/companies" method="POST" class="space-y-6">
            <input type="hidden" name="action" value="add">
            
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <div class="space-y-2">
                    <label class="text-sm font-semibold text-on-surface-variant px-1">Company Name</label>
                    <input type="text" name="companyName" required class="w-full px-4 py-3 rounded-xl bg-surface-container-low border border-outline-variant focus:border-secondary focus:ring-2 focus:ring-secondary/20 transition-all" placeholder="e.g. Google">
                </div>
                <div class="space-y-2">
                    <label class="text-sm font-semibold text-on-surface-variant px-1">Industry Type</label>
                    <input type="text" name="industryType" required class="w-full px-4 py-3 rounded-xl bg-surface-container-low border border-outline-variant focus:border-secondary focus:ring-2 focus:ring-secondary/20 transition-all" placeholder="e.g. IT, Finance">
                </div>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <div class="space-y-2">
                    <label class="text-sm font-semibold text-on-surface-variant px-1">HR Name</label>
                    <input type="text" name="hrName" required class="w-full px-4 py-3 rounded-xl bg-surface-container-low border border-outline-variant focus:border-secondary focus:ring-2 focus:ring-secondary/20 transition-all" placeholder="e.g. John Doe">
                </div>
                <div class="space-y-2">
                    <label class="text-sm font-semibold text-on-surface-variant px-1">Location</label>
                    <input type="text" name="location" required class="w-full px-4 py-3 rounded-xl bg-surface-container-low border border-outline-variant focus:border-secondary focus:ring-2 focus:ring-secondary/20 transition-all" placeholder="e.g. Mumbai, Remote">
                </div>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <div class="space-y-2">
                    <label class="text-sm font-semibold text-on-surface-variant px-1">Contact Email</label>
                    <input type="email" name="email" required class="w-full px-4 py-3 rounded-xl bg-surface-container-low border border-outline-variant focus:border-secondary focus:ring-2 focus:ring-secondary/20 transition-all" placeholder="hr@company.com">
                </div>
                <div class="space-y-2">
                    <label class="text-sm font-semibold text-on-surface-variant px-1">Contact Phone</label>
                    <input type="text" name="contactPhone" required class="w-full px-4 py-3 rounded-xl bg-surface-container-low border border-outline-variant focus:border-secondary focus:ring-2 focus:ring-secondary/20 transition-all" placeholder="+1 (234) 567-890">
                </div>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-2 gap-6 border-t border-outline-variant/30 pt-6">
                <div class="space-y-2">
                    <label class="text-sm font-semibold text-on-surface-variant px-1">Account Username</label>
                    <input type="text" name="username" required class="w-full px-4 py-3 rounded-xl bg-surface-container-low border border-outline-variant focus:border-secondary focus:ring-2 focus:ring-secondary/20 transition-all" placeholder="company_username">
                </div>
                <div class="space-y-2">
                    <label class="text-sm font-semibold text-on-surface-variant px-1">Account Password</label>
                    <input type="password" name="password" class="w-full px-4 py-3 rounded-xl bg-surface-container-low border border-outline-variant focus:border-secondary focus:ring-2 focus:ring-secondary/20 transition-all" placeholder="•••••••• (Default: company123)">
                </div>
            </div>

            <div class="space-y-2">
                <label class="text-sm font-semibold text-on-surface-variant px-1">Website URL</label>
                <input type="url" name="website" required class="w-full px-4 py-3 rounded-xl bg-surface-container-low border border-outline-variant focus:border-secondary focus:ring-2 focus:ring-secondary/20 transition-all" placeholder="https://example.com">
            </div>

            <div class="space-y-2">
                <label class="text-sm font-semibold text-on-surface-variant px-1">Company Description</label>
                <textarea name="description" rows="3" required class="w-full px-4 py-3 rounded-xl bg-surface-container-low border border-outline-variant focus:border-secondary focus:ring-2 focus:ring-secondary/20 transition-all resize-none" placeholder="Tell us about the company..."></textarea>
            </div>

            <div class="pt-4">
                <button type="submit" class="w-full py-4 bg-secondary text-white rounded-xl font-bold shadow-lg shadow-secondary/30 hover:bg-secondary/90 transition-all">
                    Register Partner
                </button>
            </div>
        </form>
    </div>
</div>
