<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- Edit Company Modal -->
<div id="editModal" class="modal">
    <div class="glass-card p-8 rounded-3xl w-full max-w-xl shadow-2xl border border-outline-variant animate-scale-up">
        <div class="flex justify-between items-center mb-6">
            <h3 class="text-2xl font-bold text-on-surface">Edit Company Details</h3>
            <button onclick="closeModal('editModal')" class="p-2 hover:bg-surface-container-high rounded-full transition-colors">
                <span class="material-symbols-outlined">close</span>
            </button>
        </div>
        <form action="${pageContext.request.contextPath}/admin/companies" method="POST" class="space-y-6">
            <input type="hidden" name="action" value="edit">
            <input type="hidden" name="userId" id="editCompanyId">
            
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <div class="space-y-2">
                    <label class="text-sm font-semibold text-on-surface-variant px-1">Company Name</label>
                    <input type="text" name="companyName" id="editName" required class="w-full px-4 py-3 rounded-xl bg-surface-container-low border border-outline-variant focus:border-secondary focus:ring-2 focus:ring-secondary/20 transition-all">
                </div>
                <div class="space-y-2">
                    <label class="text-sm font-semibold text-on-surface-variant px-1">Industry Type</label>
                    <input type="text" name="industryType" id="editIndustry" required class="w-full px-4 py-3 rounded-xl bg-surface-container-low border border-outline-variant focus:border-secondary focus:ring-2 focus:ring-secondary/20 transition-all">
                </div>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <div class="space-y-2">
                    <label class="text-sm font-semibold text-on-surface-variant px-1">HR Name</label>
                    <input type="text" name="hrName" id="editHr" required class="w-full px-4 py-3 rounded-xl bg-surface-container-low border border-outline-variant focus:border-secondary focus:ring-2 focus:ring-secondary/20 transition-all">
                </div>
                <div class="space-y-2">
                    <label class="text-sm font-semibold text-on-surface-variant px-1">Location</label>
                    <input type="text" name="location" id="editLocation" required class="w-full px-4 py-3 rounded-xl bg-surface-container-low border border-outline-variant focus:border-secondary focus:ring-2 focus:ring-secondary/20 transition-all">
                </div>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <div class="space-y-2">
                    <label class="text-sm font-semibold text-on-surface-variant px-1">Contact Email</label>
                    <input type="email" name="email" id="editEmail" required class="w-full px-4 py-3 rounded-xl bg-surface-container-low border border-outline-variant focus:border-secondary focus:ring-2 focus:ring-secondary/20 transition-all">
                </div>
                <div class="space-y-2">
                    <label class="text-sm font-semibold text-on-surface-variant px-1">Contact Phone</label>
                    <input type="text" name="contactPhone" id="editPhone" required class="w-full px-4 py-3 rounded-xl bg-surface-container-low border border-outline-variant focus:border-secondary focus:ring-2 focus:ring-secondary/20 transition-all">
                </div>
            </div>

            <div class="space-y-2">
                <label class="text-sm font-semibold text-on-surface-variant px-1">Website URL</label>
                <input type="url" name="website" id="editWebsite" required class="w-full px-4 py-3 rounded-xl bg-surface-container-low border border-outline-variant focus:border-secondary focus:ring-2 focus:ring-secondary/20 transition-all">
            </div>

            <div class="space-y-2">
                <label class="text-sm font-semibold text-on-surface-variant px-1">Company Description</label>
                <textarea name="description" id="editDesc" rows="3" required class="w-full px-4 py-3 rounded-xl bg-surface-container-low border border-outline-variant focus:border-secondary focus:ring-2 focus:ring-secondary/20 transition-all resize-none"></textarea>
            </div>

            <div class="pt-4">
                <button type="submit" class="w-full py-4 bg-secondary text-white rounded-xl font-bold shadow-lg shadow-secondary/30 hover:bg-secondary/90 transition-all">
                    Save Changes
                </button>
            </div>
        </form>
    </div>
</div>
