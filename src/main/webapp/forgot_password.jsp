<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html class="light" lang="en">
<head>
<meta charset="utf-8"/>
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<title>CareerConnect Portal - Forgot Password</title>
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
<script id="tailwind-config">
  tailwind.config = {
    darkMode: "class",
    theme: {
      extend: {
        "colors": {
          "primary": "#4F46E5",
          "secondary": "#06B6D4",
          "background": "#F8FAFC",
          "surface": "#FFFFFF",
          "error": "#EF4444"
        }
      }
    }
  }
</script>
<style>
  .glass-panel {
    background: rgba(255,255,255,0.7);
    backdrop-filter: blur(12px);
    -webkit-backdrop-filter: blur(12px);
    border: 1px solid rgba(255,255,255,0.3);
  }
  .step-dot { transition: all 0.3s ease; }
  .step-dot.active { background-color: #4F46E5; transform: scale(1.2); }
  .step-dot.done   { background-color: #10B981; }
  @keyframes shake {
    0%, 100% { transform: translateX(0); }
    25% { transform: translateX(-5px); }
    75% { transform: translateX(5px); }
  }
  .animate-shake { animation: shake 0.4s ease-in-out; }
</style>
</head>
<body class="bg-slate-50 text-slate-900 font-sans min-h-screen flex flex-col">

<!-- Header -->
<header class="fixed top-0 left-0 w-full z-50 flex justify-between items-center px-6 py-4 bg-white/80 backdrop-blur-md border-b border-slate-200">
  <a href="login.jsp" class="flex items-center gap-2">
    <span class="material-symbols-outlined text-indigo-600 font-bold">school</span>
    <h1 class="text-xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-indigo-600 to-cyan-500">CareerConnect Portal</h1>
  </a>
</header>

<main class="flex-grow flex pt-20">
  <!-- Left visual panel -->
  <section class="relative hidden lg:flex lg:w-1/2 items-center justify-center bg-indigo-900 overflow-hidden">
    <div class="absolute inset-0 opacity-40">
        <img src="https://images.unsplash.com/photo-1557683316-973673baf926?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80" alt="Background" class="w-full h-full object-cover">
    </div>
    <div class="relative z-10 p-12 text-center">
        <div class="glass-panel p-8 rounded-2xl max-w-lg">
            <h2 class="text-3xl font-bold text-slate-900 mb-4">Secure Password Recovery</h2>
            <p class="text-slate-700 text-lg">We take your account security seriously. Please provide your registered details to receive a secure verification code.</p>
        </div>
    </div>
  </section>

  <!-- Right form panel -->
  <section class="w-full lg:w-1/2 flex items-center justify-center p-6">
    <div class="w-full max-w-md bg-white p-8 rounded-2xl shadow-xl border border-slate-100">
      
      <%
        String role = (String) request.getAttribute("role");
        if (role == null) role = "STUDENT";
      %>

      <!-- Role Selection -->
      <div class="flex p-1 bg-slate-100 rounded-xl mb-8" id="roleTabs">
        <button type="button" data-role="STUDENT" class="role-tab flex-1 py-2 px-4 text-sm font-bold rounded-lg transition-all <%= "STUDENT".equals(role) ? "bg-white text-indigo-600 shadow-sm" : "text-slate-500 hover:text-indigo-600" %>">
          Student
        </button>
        <button type="button" data-role="COMPANY" class="role-tab flex-1 py-2 px-4 text-sm font-bold rounded-lg transition-all <%= "COMPANY".equals(role) ? "bg-white text-indigo-600 shadow-sm" : "text-slate-500 hover:text-indigo-600" %>">
          Company
        </button>
        <button type="button" data-role="ADMIN" class="role-tab flex-1 py-2 px-4 text-sm font-bold rounded-lg transition-all <%= "ADMIN".equals(role) ? "bg-white text-indigo-600 shadow-sm" : "text-slate-500 hover:text-indigo-600" %>">
          Admin
        </button>
      </div>

      <!-- Heading -->
      <div class="mb-8">
        <div id="roleBadge" class="inline-flex items-center px-3 py-1 rounded-full bg-indigo-50 text-indigo-700 text-sm font-semibold mb-4">
            <span class="material-symbols-outlined text-sm mr-1">person_search</span>
            <span id="roleText"><%= role %></span> RECOVERY
        </div>
        <h2 class="text-2xl font-bold text-slate-900 mb-2">Find your account</h2>
        <p class="text-slate-500" id="roleDescription">
            <% if ("ADMIN".equals(role)) { %>
                Enter your admin username to receive an OTP.
            <% } else { %>
                Enter your registered email address.
            <% } %>
        </p>
      </div>

      <!-- Messages -->
      <% if (request.getAttribute("errorMessage") != null) { %>
        <div class="flex items-center gap-3 p-4 bg-red-50 text-red-700 rounded-xl mb-6 border border-red-100 animate-shake">
          <span class="material-symbols-outlined text-red-500">error</span>
          <span class="text-sm font-medium"><%= request.getAttribute("errorMessage") %></span>
        </div>
      <% } %>

      <!-- Form -->
      <form action="forgot-password" method="POST" class="space-y-6">
        <input type="hidden" name="action" value="send_otp"/>
        <input type="hidden" name="role" id="selectedRole" value="<%= role %>"/>

        <div class="space-y-2">
          <label class="text-sm font-semibold text-slate-700 flex items-center gap-2">
            <span class="material-symbols-outlined text-sm" id="identifierIcon"><%= "ADMIN".equals(role) ? "person" : "mail" %></span>
            <span id="identifierLabel"><%= "ADMIN".equals(role) ? "Username" : "Email Address" %></span>
          </label>
          <input name="identifier" id="identifierInput"
                 class="w-full px-4 py-3 bg-slate-50 border border-slate-200 rounded-xl focus:ring-4 focus:ring-indigo-100 focus:border-indigo-500 transition-all outline-none"
                 placeholder="<%= "ADMIN".equals(role) ? "Enter username" : "Enter registered email" %>" 
                 type="<%= "ADMIN".equals(role) ? "text" : "email" %>" 
                 required />
        </div>

        <button type="submit"
                class="w-full py-4 px-6 bg-indigo-600 hover:bg-indigo-700 text-white font-bold rounded-xl shadow-lg shadow-indigo-200 transform transition-all hover:-translate-y-0.5 active:scale-95 flex items-center justify-center gap-2">
          Send Verification Code
          <span class="material-symbols-outlined">send</span>
        </button>
      </form>

      <!-- Footer Links -->
      <div class="mt-8 pt-6 border-t border-slate-100 text-center">
        <a href="login.jsp" class="inline-flex items-center text-sm font-semibold text-indigo-600 hover:text-indigo-800 transition-colors">
          <span class="material-symbols-outlined text-sm mr-1">arrow_back</span>
          Back to Login
        </a>
      </div>

    </div>
  </section>
</main>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        const tabs = document.querySelectorAll(".role-tab");
        const roleInput = document.getElementById("selectedRole");
        const roleText = document.getElementById("roleText");
        const roleDesc = document.getElementById("roleDescription");
        const identifierLabel = document.getElementById("identifierLabel");
        const identifierInput = document.getElementById("identifierInput");
        const identifierIcon = document.getElementById("identifierIcon");

        tabs.forEach(tab => {
            tab.addEventListener("click", function() {
                const role = this.getAttribute("data-role");
                
                // Update tabs UI
                tabs.forEach(t => {
                    t.classList.remove("bg-white", "text-indigo-600", "shadow-sm");
                    t.classList.add("text-slate-500", "hover:text-indigo-600");
                });
                this.classList.remove("text-slate-500", "hover:text-indigo-600");
                this.classList.add("bg-white", "text-indigo-600", "shadow-sm");

                // Update Form Logic
                roleInput.value = role;
                roleText.textContent = role;
                
                if (role === 'ADMIN') {
                    roleDesc.textContent = "Enter your admin username to receive an OTP.";
                    identifierLabel.textContent = "Username";
                    identifierInput.placeholder = "Enter username";
                    identifierInput.type = "text";
                    identifierIcon.textContent = "person";
                } else {
                    roleDesc.textContent = "Enter your registered email address.";
                    identifierLabel.textContent = "Email Address";
                    identifierInput.placeholder = "Enter registered email";
                    identifierInput.type = "email";
                    identifierIcon.textContent = "mail";
                }
            });
        });
    });
</script>

    </div>
  </section>
</main>

<footer class="py-6 px-8 flex justify-between items-center bg-white border-t border-slate-100 text-slate-400 text-sm">
  <div class="font-bold text-indigo-600/50 uppercase tracking-widest">CAREERCONNECT</div>
  <p>© 2026 University Placement System</p>
</footer>

</body>
</html>
