<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<footer class="mt-auto border-t border-outline-variant/30 bg-surface/50 backdrop-blur-sm">
    <div class="max-w-container-max mx-auto px-gutter py-md">
        <div class="flex flex-col md:flex-row justify-between items-center gap-md">
            <div class="flex items-center gap-2">
                <span class="material-symbols-outlined text-secondary text-[20px]">hub</span>
                <span class="font-bold text-on-surface tracking-tight">CAREER NEXUS</span>
            </div>
            <p class="text-on-surface-variant text-sm font-medium">
                &copy; <%= new java.util.Date().getYear() + 1900 %> Placement Management System. All rights reserved.
            </p>
            <div class="flex items-center gap-lg">
                <a href="#" class="text-on-surface-variant hover:text-secondary text-sm font-medium transition-colors">Privacy Policy</a>
                <a href="#" class="text-on-surface-variant hover:text-secondary text-sm font-medium transition-colors">Terms of Service</a>
                <a href="#" class="text-on-surface-variant hover:text-secondary text-sm font-medium transition-colors">Contact Support</a>
            </div>
        </div>
    </div>
</footer>
