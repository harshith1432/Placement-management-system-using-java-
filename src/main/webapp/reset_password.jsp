<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html class="light" lang="en">
<head>
<meta charset="utf-8"/>
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<title>CareerConnect Portal - Set New Password</title>
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
  
  #strengthBar { transition: width 0.3s ease, background-color 0.3s ease; }
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
        <img src="https://images.unsplash.com/photo-1563986768609-322da13575f3?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80" alt="Security" class="w-full h-full object-cover">
    </div>
    <div class="relative z-10 p-12 text-center">
        <div class="glass-panel p-8 rounded-2xl max-w-lg">
            <h2 class="text-3xl font-bold text-slate-900 mb-4">Stronger Protection</h2>
            <p class="text-slate-700 text-lg">Create a password that is hard to guess but easy for you to remember. We recommend using a combination of letters, numbers, and symbols.</p>
        </div>
    </div>
  </section>

  <!-- Right form panel -->
  <section class="w-full lg:w-1/2 flex items-center justify-center p-6">
    <div class="w-full max-w-md bg-white p-8 rounded-2xl shadow-xl border border-slate-100">
      
      <%
        if (session.getAttribute("otpVerified") == null || !(boolean)session.getAttribute("otpVerified")) {
            response.sendRedirect("forgot-password");
            return;
        }
      %>

      <!-- Step indicator -->
      <div class="flex items-center gap-4 mb-8">
        <div class="step-dot w-3 h-3 rounded-full done"></div>
        <div class="flex-1 h-1 bg-indigo-600 rounded-full"></div>
        <div class="step-dot w-3 h-3 rounded-full done"></div>
        <div class="flex-1 h-1 bg-indigo-600 rounded-full"></div>
        <div class="step-dot w-3 h-3 rounded-full active"></div>
      </div>

      <!-- Heading -->
      <div class="mb-8">
        <div class="inline-flex items-center px-3 py-1 rounded-full bg-emerald-50 text-emerald-700 text-sm font-semibold mb-4">
            <span class="material-symbols-outlined text-sm mr-1">check_circle</span>
            OTP VERIFIED
        </div>
        <h2 class="text-2xl font-bold text-slate-900 mb-2">Create New Password</h2>
        <p class="text-slate-500">Please enter a strong password for your account.</p>
      </div>

      <!-- Messages -->
      <% if (request.getAttribute("errorMessage") != null) { %>
        <div class="flex items-center gap-3 p-4 bg-red-50 text-red-700 rounded-xl mb-6 border border-red-100">
          <span class="material-symbols-outlined text-red-500">error</span>
          <span class="text-sm font-medium"><%= request.getAttribute("errorMessage") %></span>
        </div>
      <% } %>

      <!-- Form -->
      <form action="forgot-password" method="POST" class="space-y-6" id="resetForm">
        <input type="hidden" name="action" value="reset_password"/>

        <div class="space-y-2">
          <label class="text-sm font-semibold text-slate-700 flex items-center gap-2">
            <span class="material-symbols-outlined text-sm">lock</span>
            New Password
          </label>
          <div class="relative">
              <input name="newPassword" id="newPassword"
                     class="w-full pl-4 pr-12 py-3 bg-slate-50 border border-slate-200 rounded-xl focus:ring-4 focus:ring-indigo-100 focus:border-indigo-500 transition-all outline-none"
                     placeholder="At least 8 characters" type="password" required 
                     oninput="checkStrength(this.value); checkMatch()"/>
              <button type="button" onclick="toggleVisibility('newPassword', 'eyeIcon1')" class="absolute right-4 top-1/2 -translate-y-1/2 text-slate-400 hover:text-indigo-600 transition-colors">
                  <span class="material-symbols-outlined text-lg" id="eyeIcon1">visibility</span>
              </button>
          </div>
          <!-- Strength Meter -->
          <div class="pt-2">
              <div class="w-full bg-slate-100 rounded-full h-1.5 overflow-hidden">
                  <div id="strengthBar" class="h-full w-0 transition-all duration-300"></div>
              </div>
              <p id="strengthText" class="text-xs font-medium mt-1 text-slate-500">Strength: None</p>
          </div>
        </div>

        <div class="space-y-2">
          <label class="text-sm font-semibold text-slate-700 flex items-center gap-2">
            <span class="material-symbols-outlined text-sm">lock_person</span>
            Confirm Password
          </label>
          <div class="relative">
              <input name="confirmPassword" id="confirmPassword"
                     class="w-full pl-4 pr-12 py-3 bg-slate-50 border border-slate-200 rounded-xl focus:ring-4 focus:ring-indigo-100 focus:border-indigo-500 transition-all outline-none"
                     placeholder="Repeat new password" type="password" required 
                     oninput="checkMatch()"/>
              <button type="button" onclick="toggleVisibility('confirmPassword', 'eyeIcon2')" class="absolute right-4 top-1/2 -translate-y-1/2 text-slate-400 hover:text-indigo-600 transition-colors">
                  <span class="material-symbols-outlined text-lg" id="eyeIcon2">visibility</span>
              </button>
          </div>
          <p id="matchText" class="text-xs font-medium"></p>
        </div>

        <button type="submit" id="submitBtn" disabled
                class="w-full py-4 px-6 bg-indigo-600 hover:bg-indigo-700 text-white font-bold rounded-xl shadow-lg shadow-indigo-200 transform transition-all hover:-translate-y-0.5 active:scale-95 flex items-center justify-center gap-2 disabled:opacity-50 disabled:cursor-not-allowed">
          Reset Password
          <span class="material-symbols-outlined">key</span>
        </button>
      </form>

    </div>
  </section>
</main>

<script>
    function toggleVisibility(inputId, iconId) {
        const input = document.getElementById(inputId);
        const icon = document.getElementById(iconId);
        if (input.type === 'password') {
            input.type = 'text';
            icon.textContent = 'visibility_off';
        } else {
            input.type = 'password';
            icon.textContent = 'visibility';
        }
    }

    function checkStrength(password) {
        const bar = document.getElementById('strengthBar');
        const text = document.getElementById('strengthText');
        let strength = 0;
        
        if (password.length >= 8) strength += 25;
        if (/[A-Z]/.test(password)) strength += 25;
        if (/[0-9]/.test(password)) strength += 25;
        if (/[^A-Za-z0-9]/.test(password)) strength += 25;

        bar.style.width = strength + '%';
        
        if (strength <= 25) {
            bar.className = 'h-full bg-red-500 transition-all duration-300';
            text.innerText = 'Strength: Weak';
            text.className = 'text-xs font-medium mt-1 text-red-500';
        } else if (strength <= 50) {
            bar.className = 'h-full bg-orange-500 transition-all duration-300';
            text.innerText = 'Strength: Fair';
            text.className = 'text-xs font-medium mt-1 text-orange-500';
        } else if (strength <= 75) {
            bar.className = 'h-full bg-blue-500 transition-all duration-300';
            text.innerText = 'Strength: Good';
            text.className = 'text-xs font-medium mt-1 text-blue-500';
        } else {
            bar.className = 'h-full bg-emerald-500 transition-all duration-300';
            text.innerText = 'Strength: Strong';
            text.className = 'text-xs font-medium mt-1 text-emerald-500';
        }
    }

    function checkMatch() {
        const pass = document.getElementById('newPassword').value;
        const confirm = document.getElementById('confirmPassword').value;
        const text = document.getElementById('matchText');
        const btn = document.getElementById('submitBtn');

        if (!confirm) {
            text.innerText = '';
            btn.disabled = true;
            return;
        }

        if (pass === confirm) {
            text.innerText = '✓ Passwords match';
            text.className = 'text-xs font-medium mt-1 text-emerald-500';
            btn.disabled = pass.length < 8;
        } else {
            text.innerText = '✗ Passwords do not match';
            text.className = 'text-xs font-medium mt-1 text-red-500';
            btn.disabled = true;
        }
    }
</script>

</body>
</html>
