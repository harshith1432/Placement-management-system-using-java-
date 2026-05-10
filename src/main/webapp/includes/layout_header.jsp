<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<header class="w-full sticky top-0 backdrop-blur-md bg-surface/80 border-b border-outline-variant shadow-sm z-40 flex items-center justify-between px-gutter h-16 md:pl-72">
    <div class="flex items-center gap-4">
        <button id="mobileMenuBtn" class="md:hidden p-2 hover:bg-surface-container-high rounded-full transition-colors">
            <span class="material-symbols-outlined">menu</span>
        </button>
        <div class="hidden md:flex items-center bg-surface-container-low px-4 py-2 rounded-full border border-outline-variant/50 w-80">
            <span class="material-symbols-outlined text-on-surface-variant text-sm mr-2">search</span>
            <input id="globalSearch" class="bg-transparent border-none focus:ring-0 text-sm w-full placeholder:text-on-surface-variant/60" placeholder="Search..." type="text"/>
        </div>
    </div>
    
    <div class="flex items-center gap-4">
        <!-- Notifications -->
        <div class="relative">
            <button id="notifBtn" class="p-2 hover:bg-surface-container-high rounded-full relative transition-colors">
                <span class="material-symbols-outlined">notifications</span>
                <span id="notifBadge" class="absolute top-2 right-2 w-2 h-2 bg-error rounded-full border-2 border-surface hidden"></span>
            </button>
            <div id="notifDropdown" class="absolute right-0 mt-2 w-80 glass-card rounded-xl shadow-xl overflow-hidden z-50 hidden">
                <div class="p-4 border-b border-outline-variant/20 flex justify-between items-center">
                    <h4 class="font-bold">Notifications</h4>
                    <button class="text-xs text-secondary hover:underline">Mark all as read</button>
                </div>
                <div id="notifList" class="max-h-96 overflow-y-auto">
                    <div class="p-4 text-center text-on-surface-variant text-sm">No new notifications</div>
                </div>
            </div>
        </div>

        <!-- Profile -->
        <div class="relative">
            <button id="profileBtn" class="flex items-center gap-2 pl-2 pr-1 py-1 hover:bg-surface-container-high rounded-full border border-outline-variant/30 transition-colors">
                <div class="w-8 h-8 rounded-full bg-secondary-container flex items-center justify-center text-on-secondary-container">
                    <span class="material-symbols-outlined text-sm">person</span>
                </div>
                <span class="hidden sm:inline font-medium text-sm px-1"><c:out value="${user.username}"/></span>
                <span class="material-symbols-outlined text-sm">expand_more</span>
            </button>
            <div id="profileDropdown" class="absolute right-0 mt-2 w-48 glass-card rounded-xl shadow-xl overflow-hidden z-50 hidden">
                <div class="p-2">
                    <c:choose>
                        <c:when test="${user.role == 'ADMIN'}">
                            <a href="${pageContext.request.contextPath}/admin/profile" class="flex items-center gap-3 px-4 py-2 hover:bg-surface-container-high rounded-lg text-sm transition-colors">
                                <span class="material-symbols-outlined text-[18px]">manage_accounts</span> Profile Settings
                            </a>
                        </c:when>
                        <c:when test="${user.role == 'STUDENT'}">
                            <a href="javascript:void(0)" onclick="toggleProfileModal()" class="flex items-center gap-3 px-4 py-2 hover:bg-surface-container-high rounded-lg text-sm transition-colors">
                                <span class="material-symbols-outlined text-[18px]">person</span> Edit Profile
                            </a>
                        </c:when>
                        <c:when test="${user.role == 'COMPANY'}">
                            <a href="${pageContext.request.contextPath}/company/profile" class="flex items-center gap-3 px-4 py-2 hover:bg-surface-container-high rounded-lg text-sm transition-colors">
                                <span class="material-symbols-outlined text-[18px]">business</span> Company Profile
                            </a>
                        </c:when>
                    </c:choose>
                    <hr class="my-2 border-outline-variant/20">
                    <a href="${pageContext.request.contextPath}/auth?action=logout" class="flex items-center gap-3 px-4 py-2 hover:bg-error/10 text-error rounded-lg text-sm transition-colors">
                        <span class="material-symbols-outlined text-[18px]">logout</span> Logout
                    </a>
                </div>
            </div>
        </div>
    </div>
</header>

<script>
    // Universal Toggle Function
    function setupDropdown(btnId, dropdownId) {
        const btn = document.getElementById(btnId);
        const dropdown = document.getElementById(dropdownId);
        if (btn && dropdown) {
            btn.addEventListener('click', (e) => {
                e.stopPropagation();
                dropdown.classList.toggle('hidden');
            });
            document.addEventListener('click', () => dropdown.classList.add('hidden'));
            dropdown.addEventListener('click', (e) => e.stopPropagation());
        }
    }

    setupDropdown('notifBtn', 'notifDropdown');
    setupDropdown('profileBtn', 'profileDropdown');

    // Mobile Menu Toggle with Overlay
    const mobileMenuBtn = document.getElementById('mobileMenuBtn');
    const sidebar = document.getElementById('sidebar');
    
    // Create overlay if it doesn't exist
    let overlay = document.getElementById('sidebarOverlay');
    if (!overlay) {
        overlay = document.createElement('div');
        overlay.id = 'sidebarOverlay';
        overlay.className = 'fixed inset-0 bg-black/50 z-40 hidden backdrop-blur-sm transition-opacity duration-300 opacity-0';
        document.body.appendChild(overlay);
    }

    function toggleSidebar() {
        const isOpen = !sidebar.classList.contains('hidden');
        if (isOpen) {
            sidebar.classList.add('hidden');
            sidebar.classList.remove('flex');
            overlay.classList.add('hidden');
            overlay.classList.replace('opacity-100', 'opacity-0');
            document.body.classList.remove('overflow-hidden');
        } else {
            sidebar.classList.remove('hidden');
            sidebar.classList.add('flex');
            overlay.classList.remove('hidden');
            setTimeout(() => overlay.classList.replace('opacity-0', 'opacity-100'), 10);
            document.body.classList.add('overflow-hidden');
        }
    }

    if (mobileMenuBtn && sidebar) {
        mobileMenuBtn.addEventListener('click', (e) => {
            e.stopPropagation();
            toggleSidebar();
        });

        overlay.addEventListener('click', toggleSidebar);
        
        // Close on window resize if moving to desktop
        window.addEventListener('resize', () => {
            if (window.innerWidth >= 768 && !sidebar.classList.contains('hidden')) {
                sidebar.classList.add('hidden'); // Reset mobile state
                overlay.classList.add('hidden');
                document.body.classList.remove('overflow-hidden');
            }
        });
    }

    // Global Search Hook
    const globalSearchInput = document.getElementById('globalSearch');
    if (globalSearchInput) {
        globalSearchInput.addEventListener('keyup', function() {
            const searchTerm = this.value.toLowerCase();
            const event = new CustomEvent('globalSearch', { detail: { value: searchTerm } });
            document.dispatchEvent(event);
        });
    }
</script>
