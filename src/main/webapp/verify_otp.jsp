<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html class="light" lang="en">
<head>
<meta charset="utf-8"/>
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<title>CareerConnect Portal - Verify OTP</title>
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
  
  /* OTP Input specific styles */
  .otp-input {
    width: 3rem;
    height: 3.5rem;
    text-align: center;
    font-size: 1.5rem;
    font-weight: 700;
    border-radius: 0.75rem;
    border: 2px solid #E2E8F0;
    background-color: #F8FAFC;
    transition: all 0.2s ease;
  }
  .otp-input:focus {
    border-color: #4F46E5;
    background-color: #FFFFFF;
    box-shadow: 0 0 0 4px rgba(79, 70, 229, 0.1);
    outline: none;
  }
  @keyframes fadeIn {
    from { opacity: 0; transform: translateY(10px); }
    to { opacity: 1; transform: translateY(0); }
  }
  .animate-fade-in { animation: fadeIn 0.5s ease-out forwards; }
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
  <!-- Right form panel (Full width for focus on OTP) -->
  <section class="w-full flex items-center justify-center p-6">
    <div class="w-full max-w-md bg-white p-8 rounded-2xl shadow-xl border border-slate-100 animate-fade-in">
      
      <%
        String maskedEmail = (String) session.getAttribute("resetUserEmail");
        if (maskedEmail == null) {
            response.sendRedirect("forgot-password");
            return;
        }
      %>

      <!-- Step indicator -->
      <div class="flex items-center gap-4 mb-8">
        <div class="step-dot w-3 h-3 rounded-full done"></div>
        <div class="flex-1 h-1 bg-indigo-100 rounded-full">
            <div class="h-full bg-indigo-600 w-full"></div>
        </div>
        <div class="step-dot w-3 h-3 rounded-full active"></div>
        <div class="flex-1 h-1 bg-slate-100 rounded-full">
             <div class="h-full bg-indigo-100 w-0"></div>
        </div>
        <div class="step-dot w-3 h-3 rounded-full bg-slate-200"></div>
      </div>

      <!-- Heading -->
      <div class="text-center mb-8">
        <div class="inline-flex items-center justify-center w-16 h-16 rounded-full bg-indigo-50 text-indigo-600 mb-4">
            <span class="material-symbols-outlined text-3xl">verified</span>
        </div>
        <h2 class="text-2xl font-bold text-slate-900 mb-2">Verify OTP</h2>
        <p class="text-slate-500">
            We've sent a 6-digit code to <br>
            <span class="font-semibold text-slate-700"><%= maskedEmail %></span>
        </p>
      </div>

      <!-- Messages -->
      <% if (request.getAttribute("errorMessage") != null) { %>
        <div class="flex items-center gap-3 p-4 bg-red-50 text-red-700 rounded-xl mb-6 border border-red-100">
          <span class="material-symbols-outlined text-red-500">error</span>
          <span class="text-sm font-medium"><%= request.getAttribute("errorMessage") %></span>
        </div>
      <% } %>
      
      <% if (request.getAttribute("successMessage") != null) { %>
        <div class="flex items-center gap-3 p-4 bg-emerald-50 text-emerald-700 rounded-xl mb-6 border border-emerald-100">
          <span class="material-symbols-outlined text-emerald-500">check_circle</span>
          <span class="text-sm font-medium"><%= request.getAttribute("successMessage") %></span>
        </div>
      <% } %>

      <!-- OTP Form -->
      <form action="forgot-password" method="POST" class="space-y-8" id="otpForm">
        <input type="hidden" name="action" value="verify_otp"/>
        
        <div class="flex justify-between gap-2">
            <input type="text" name="otp1" maxlength="1" class="otp-input" required autofocus onkeyup="moveNext(this, 'otp2')">
            <input type="text" name="otp2" maxlength="1" class="otp-input" required onkeyup="moveNext(this, 'otp3')">
            <input type="text" name="otp3" maxlength="1" class="otp-input" required onkeyup="moveNext(this, 'otp4')">
            <input type="text" name="otp4" maxlength="1" class="otp-input" required onkeyup="moveNext(this, 'otp5')">
            <input type="text" name="otp5" maxlength="1" class="otp-input" required onkeyup="moveNext(this, 'otp6')">
            <input type="text" name="otp6" maxlength="1" class="otp-input" required onkeyup="submitForm(this)">
        </div>

        <button type="submit"
                class="w-full py-4 px-6 bg-indigo-600 hover:bg-indigo-700 text-white font-bold rounded-xl shadow-lg shadow-indigo-200 transform transition-all hover:-translate-y-0.5 active:scale-95 flex items-center justify-center gap-2">
          Verify & Continue
          <span class="material-symbols-outlined">arrow_forward</span>
        </button>
      </form>

      <!-- Resend Section -->
      <div class="mt-10 text-center">
          <p class="text-sm text-slate-500 mb-4">Didn't receive the code?</p>
          <form action="forgot-password" method="POST" id="resendForm">
              <input type="hidden" name="action" value="resend_otp">
              <button type="submit" id="resendBtn" disabled
                      class="inline-flex items-center text-sm font-bold text-indigo-600 hover:text-indigo-800 disabled:text-slate-400 disabled:cursor-not-allowed transition-colors">
                  <span class="material-symbols-outlined text-sm mr-1">refresh</span>
                  Resend Code <span id="timer" class="ml-1">(60s)</span>
              </button>
          </form>
      </div>

    </div>
  </section>
</main>

<script>
    function moveNext(current, nextId) {
        if (current.value.length >= 1) {
            const next = document.getElementsByName(nextId)[0];
            if (next) next.focus();
        }
    }

    function submitForm(current) {
        if (current.value.length >= 1) {
            // Optional: Auto submit when last digit entered
            // document.getElementById('otpForm').submit();
        }
    }

    // Handle backspace
    document.querySelectorAll('.otp-input').forEach((input, index, inputs) => {
        input.addEventListener('keydown', (e) => {
            if (e.key === 'Backspace' && !input.value && index > 0) {
                inputs[index - 1].focus();
            }
        });
    });

    // Timer logic
    let timeLeft = 60;
    const timerElem = document.getElementById('timer');
    const resendBtn = document.getElementById('resendBtn');
    
    const countdown = setInterval(() => {
        timeLeft--;
        if (timeLeft <= 0) {
            clearInterval(countdown);
            timerElem.textContent = "";
            resendBtn.disabled = false;
        } else {
            timerElem.textContent = "(" + timeLeft + "s)";
        }
    }, 1000);
</script>

</body>
</html>
