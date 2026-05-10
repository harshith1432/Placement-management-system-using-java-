<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html class="light" lang="en"><head>
<meta charset="utf-8"/>
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<title>CareerConnect Portal - Login</title>
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<script id="tailwind-config">
      tailwind.config = {
        darkMode: "class",
        theme: {
          extend: {
            "colors": {
                    "surface-variant": "#d3e4fe",
                    "tertiary-fixed": "#e0e3e5",
                    "on-secondary-container": "#fefcff",
                    "surface-container-high": "#dce9ff",
                    "secondary-fixed-dim": "#b4c5ff",
                    "tertiary": "#000000",
                    "surface-container-lowest": "#ffffff",
                    "secondary": "#0051d5",
                    "surface-dim": "#cbdbf5",
                    "on-tertiary": "#ffffff",
                    "surface-tint": "#565e74",
                    "tertiary-fixed-dim": "#c4c7c9",
                    "on-error-container": "#93000a",
                    "secondary-container": "#316bf3",
                    "on-secondary-fixed": "#00174b",
                    "surface-bright": "#f8f9ff",
                    "primary-fixed": "#dae2fd",
                    "background": "#f8f9ff",
                    "surface-container": "#e5eeff",
                    "surface-container-low": "#eff4ff",
                    "outline": "#76777d",
                    "on-primary": "#ffffff",
                    "primary-container": "#131b2e",
                    "inverse-primary": "#bec6e0",
                    "on-error": "#ffffff",
                    "tertiary-container": "#191c1e",
                    "on-primary-container": "#7c839b",
                    "primary-fixed-dim": "#bec6e0",
                    "on-tertiary-fixed-variant": "#444749",
                    "on-tertiary-fixed": "#191c1e",
                    "on-secondary": "#ffffff",
                    "error-container": "#ffdad6",
                    "inverse-on-surface": "#eaf1ff",
                    "outline-variant": "#c6c6cd",
                    "inverse-surface": "#213145",
                    "on-primary-fixed-variant": "#3f465c",
                    "on-background": "#0b1c30",
                    "secondary-fixed": "#dbe1ff",
                    "surface": "#f8f9ff",
                    "surface-container-highest": "#d3e4fe",
                    "on-surface": "#0b1c30",
                    "on-surface-variant": "#45464d",
                    "primary": "#000000",
                    "on-tertiary-container": "#818486",
                    "on-primary-fixed": "#131b2e",
                    "on-secondary-fixed-variant": "#003ea8",
                    "error": "#ba1a1a"
            },
            "borderRadius": {
                    "DEFAULT": "0.25rem",
                    "lg": "0.5rem",
                    "xl": "0.75rem",
                    "full": "9999px"
            },
            "spacing": {
                    "xs": "8px",
                    "gutter": "24px",
                    "sm": "16px",
                    "xl": "64px",
                    "base": "4px",
                    "lg": "40px",
                    "md": "24px",
                    "container-max": "1280px"
            },
            "fontFamily": {
                    "h1": ["Inter"],
                    "h2": ["Inter"],
                    "button": ["Inter"],
                    "body-sm": ["Inter"],
                    "body-lg": ["Inter"],
                    "label-caps": ["Inter"],
                    "h3": ["Inter"],
                    "body-md": ["Inter"]
            },
            "fontSize": {
                    "h1": ["48px", {"lineHeight": "1.2", "letterSpacing": "-0.02em", "fontWeight": "700"}],
                    "h2": ["36px", {"lineHeight": "1.2", "letterSpacing": "-0.01em", "fontWeight": "600"}],
                    "button": ["15px", {"lineHeight": "1", "fontWeight": "500"}],
                    "body-sm": ["14px", {"lineHeight": "1.5", "fontWeight": "400"}],
                    "body-lg": ["18px", {"lineHeight": "1.6", "fontWeight": "400"}],
                    "label-caps": ["12px", {"lineHeight": "1", "letterSpacing": "0.05em", "fontWeight": "600"}],
                    "h3": ["24px", {"lineHeight": "1.3", "fontWeight": "600"}],
                    "body-md": ["16px", {"lineHeight": "1.5", "fontWeight": "400"}]
            }
          },
        },
      }
    </script>
<style>
        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
        }
        .glass-panel {
            background: rgba(255, 255, 255, 0.7);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            border: 1px solid rgba(255, 255, 255, 0.3);
        }
    </style>
<style>
    body {
      min-height: max(884px, 100dvh);
    }
  </style>
  </head>
<body class="bg-background text-on-background font-body-md min-h-screen flex flex-col">
<!-- TopAppBar from JSON -->
<header class="fixed top-0 left-0 w-full z-50 flex justify-between items-center px-gutter py-sm max-w-container-max mx-auto bg-surface/80 dark:bg-surface-container/80 backdrop-blur-md border-b border-outline-variant/30 dark:border-outline/20">
<div class="flex items-center gap-xs cursor-pointer active:opacity-70">
<span class="material-symbols-outlined text-secondary dark:text-secondary-fixed">school</span>
<h1 class="font-h3 text-h3 font-bold text-secondary dark:text-secondary-fixed">CareerConnect Portal</h1>
</div>
<div class="flex items-center gap-md">
<button class="font-body-sm text-body-sm text-on-surface-variant font-medium hover:text-secondary transition-colors duration-200 cursor-pointer active:opacity-70">Help</button>
</div>
</header>
<main class="flex-grow flex flex-col md:flex-row pt-[72px]">
<!-- Top Section (Mobile) / Left Section (Desktop): Visual Identity -->
<section class="relative w-full md:w-1/2 min-h-[300px] md:min-h-0 overflow-hidden bg-primary-container">
<div class="absolute inset-0 z-0">
<img alt="University Excellence" class="w-full h-full object-cover opacity-60" data-alt="A cinematic, high-key photograph of a diverse group of college students in smart professional attire walking confidently through a sun-drenched, modern university campus. The lighting is soft and golden, creating an atmosphere of ambition and academic excellence. The architectural background features clean lines and large glass windows, reflecting a sophisticated Oxford Blue and crisp white color palette. The overall mood is inspiring, organized, and professionally focused." src="https://lh3.googleusercontent.com/aida-public/AB6AXuDtrX_wuTZoXBl3gCJFvYDuHj-a7xknNHO8xQUuYgAZCQGaAUVOT1lwYwvs56IVcnNYap3Vq52NSyI8jHT3GGcTbD1CicGUDNj8x67Ep5RVMKela2t_ZyoRPU4YzqWBGm0pkPHV8ZjQx2FTCIDKDBklX3NgNES3kxrmYa7cUo5I7I9tUD4TU5iUlfP7gufIi853gu-Rz9qeQduAAZO5E1mxNgj9KaF-a_9ULa_NLTMKN4HHycAs6S_LS0Onlz_snReNLMg3HjuEApTk"/>
</div>
<div class="relative z-10 w-full h-full flex flex-col justify-center items-center p-xl text-center">
<div class="glass-panel p-lg rounded-xl max-w-md">
<h2 class="font-h2 text-h2 text-on-primary-fixed mb-sm">Elevate Your Career</h2>
<p class="font-body-lg text-body-lg text-on-primary-fixed-variant">Connect with global recruiters and unlock exclusive placement opportunities from your institution.</p>
</div>
</div>
</section>
<!-- Bottom Section (Mobile) / Right Section (Desktop): Login Form -->
<section class="w-full md:w-1/2 flex items-center justify-center p-gutter bg-surface">
<div class="w-full max-w-md bg-surface-container-lowest p-lg rounded-xl shadow-sm border border-outline-variant/30">
<div class="mb-lg">
<h3 class="font-h3 text-h3 text-on-surface mb-xs">Welcome Back</h3>
<p class="font-body-sm text-body-sm text-on-surface-variant">Please select your role and enter your credentials.</p>
</div>

<% if (request.getAttribute("errorMessage") != null) { %>
    <div class="text-error bg-error-container p-sm rounded mb-md text-center font-medium">
        <%= request.getAttribute("errorMessage") %>
    </div>
<% } %>
<% if (request.getAttribute("successMessage") != null) { %>
    <div class="text-[green] bg-[lightgreen] p-sm rounded mb-md text-center font-medium">
        <%= request.getAttribute("successMessage") %>
    </div>
<% } %>
<% if ("true".equals(request.getParameter("pwdReset"))) { %>
    <div class="flex items-center gap-xs bg-[#dcfce7] text-[#166534] p-sm rounded-lg mb-md text-center font-medium text-body-sm">
        <span style="font-family:'Material Symbols Outlined';font-size:18px">check_circle</span>
        Password reset successfully! Please log in with your new password.
    </div>
<% } %>

<!-- Role Selection Segmented Tabs -->
<div class="flex p-base bg-surface-container-low rounded-lg mb-md" id="roleTabs">
<button type="button" data-role="STUDENT" class="role-tab flex-1 py-xs px-sm font-button text-button rounded-lg transition-all duration-200 bg-secondary text-on-secondary shadow-sm">
                        Student
                    </button>
<button type="button" data-role="COMPANY" class="role-tab flex-1 py-xs px-sm font-button text-button rounded-lg transition-all duration-200 text-on-surface-variant hover:text-secondary">
                        Company
                    </button>
<button type="button" data-role="ADMIN" class="role-tab flex-1 py-xs px-sm font-button text-button rounded-lg transition-all duration-200 text-on-surface-variant hover:text-secondary">
                        Admin
                    </button>
</div>
<!-- Login Form -->
<form action="auth" method="POST" class="space-y-md">
<input type="hidden" name="action" value="login" />
<input type="hidden" name="role" id="selectedRole" value="STUDENT" />

<div class="space-y-xs">
<label class="font-label-caps text-label-caps text-on-surface-variant uppercase tracking-wider block" for="username">Username</label>
<div class="relative">
<span class="material-symbols-outlined absolute left-sm top-1/2 -translate-y-1/2 text-outline text-[20px]">person</span>
<input name="username" class="w-full pl-[44px] pr-sm py-sm bg-surface-container-low border-transparent focus:border-secondary focus:ring-0 rounded-lg font-body-md transition-all" id="username" placeholder="Enter your username" type="text" required/>
</div>
</div>
<div class="space-y-xs">
<label class="font-label-caps text-label-caps text-on-surface-variant uppercase tracking-wider block" for="password">Password</label>
<div class="relative">
<span class="material-symbols-outlined absolute left-sm top-1/2 -translate-y-1/2 text-outline text-[20px]">lock</span>
<input name="password" class="w-full pl-[44px] pr-sm py-sm bg-surface-container-low border-transparent focus:border-secondary focus:ring-0 rounded-lg font-body-md transition-all" id="password" placeholder="••••••••" type="password" required/>
</div>
</div>
<div class="flex items-center justify-between">
<div class="flex items-center gap-xs">
<input class="w-4 h-4 text-secondary rounded border-outline-variant focus:ring-secondary/20" id="remember" type="checkbox"/>
<label class="font-body-sm text-body-sm text-on-surface-variant" for="remember">Remember me</label>
</div>
<a class="font-body-sm text-body-sm text-secondary font-medium hover:underline" href="forgot-password">Forgot Password?</a>
</div>
<button class="w-full py-sm px-md bg-secondary text-on-secondary font-button text-button rounded-lg shadow-md hover:bg-secondary/90 active:opacity-70 transition-all flex justify-center items-center gap-xs" type="submit">
                        Login to Portal
                        <span class="material-symbols-outlined text-[18px]">login</span>
</button>
</form>
<div class="mt-lg pt-md border-t border-outline-variant/20 text-center space-y-2">
<p class="font-body-sm text-body-sm text-on-surface-variant">
                        Don't have an account? <a class="text-secondary font-medium hover:underline" href="register.jsp">Register here</a>
</p>
<p class="font-body-sm text-body-sm text-on-surface-variant">
                        Trouble accessing your account? <a class="text-secondary font-medium hover:underline" href="#">Contact Administrator</a>
</p>
</div>
</div>
</section>
</main>
<!-- Footer from JSON -->
<footer class="w-full py-md px-gutter flex flex-col md:flex-row justify-between items-center gap-xs bg-surface-container-low dark:bg-surface-container-lowest border-t border-outline-variant/20">
<div class="font-label-caps text-label-caps uppercase tracking-wider text-secondary">
            CareerConnect
        </div>
<p class="font-body-sm text-body-sm text-on-surface-variant dark:text-outline text-center">
            © 2024 University Placement Management System. All rights reserved.
        </p>
<div class="flex gap-md">
<a class="font-body-sm text-body-sm text-on-surface-variant hover:text-secondary underline transition-all cursor-pointer">Privacy Policy</a>
<a class="font-body-sm text-body-sm text-on-surface-variant hover:text-secondary underline transition-all cursor-pointer">Terms of Service</a>
<a class="font-body-sm text-body-sm text-on-surface-variant hover:text-secondary underline transition-all cursor-pointer">Contact Support</a>
</div>
</footer>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        const tabs = document.querySelectorAll(".role-tab");
        const roleInput = document.getElementById("selectedRole");

        tabs.forEach(tab => {
            tab.addEventListener("click", function() {
                // Remove active classes from all
                tabs.forEach(t => {
                    t.classList.remove("bg-secondary", "text-on-secondary", "shadow-sm");
                    t.classList.add("text-on-surface-variant", "hover:text-secondary");
                });

                // Add active classes to clicked
                this.classList.remove("text-on-surface-variant", "hover:text-secondary");
                this.classList.add("bg-secondary", "text-on-secondary", "shadow-sm");

                // Update hidden input
                const role = this.getAttribute("data-role");
                roleInput.value = role;
                
                // Update Forgot Password link
                const forgotLink = document.querySelector('a[href^="forgot-password"]');
                if (forgotLink) {
                    forgotLink.href = "forgot-password?role=" + role;
                }
            });
        });
    });
</script>
</body></html>