<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<meta charset="utf-8"/>
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>

<script id="tailwind-config">
  tailwind.config = {
    darkMode: "class",
    theme: {
      extend: {
        colors: {
          "primary": "#2563eb",
          "on-primary": "#ffffff",
          "secondary": "#0ea5e9",
          "on-secondary": "#ffffff",
          "background": "#f8f9ff",
          "surface": "#f8f9ff",
          "on-surface": "#0b1c30",
          "on-surface-variant": "#45464d",
          "outline": "#76777d",
          "outline-variant": "#c6c6cd",
          "secondary-container": "#316bf3",
          "on-secondary-container": "#fefcff",
          "primary-container": "#131b2e",
          "on-primary-container": "#7c839b",
          "surface-container": "#e5eeff",
          "surface-container-low": "#eff4ff",
          "surface-container-lowest": "#ffffff",
          "surface-container-high": "#dce9ff",
          "surface-container-highest": "#d3e4fe",
          "error": "#ba1a1a",
          "error-container": "#ffdad6"
        },
        boxShadow: {
          'btn': '0 4px 6px -1px rgba(37, 99, 235, 0.25), 0 2px 4px -1px rgba(37, 99, 235, 0.15)',
          'btn-secondary': '0 4px 6px -1px rgba(14, 165, 233, 0.25), 0 2px 4px -1px rgba(14, 165, 233, 0.15)',
          'card': '0 10px 15px -3px rgba(0, 0, 0, 0.05), 0 4px 6px -2px rgba(0, 0, 0, 0.02)',
        },
        borderRadius: {
          "DEFAULT": "0.25rem",
          "lg": "0.5rem",
          "xl": "0.75rem",
          "full": "9999px"
        },
        spacing: {
          "sm": "16px",
          "md": "24px",
          "lg": "40px",
          "xl": "64px",
          "gutter": "24px",
          "container-max": "1280px"
        },
        fontFamily: {
          "body": ["Inter", "sans-serif"]
        }
      }
    }
  }
</script>

<style>
    .glass-card {
        background: rgba(255, 255, 255, 0.8);
        backdrop-filter: blur(12px);
        -webkit-backdrop-filter: blur(12px);
        border: 1px solid rgba(226, 232, 240, 0.5);
    }
    .material-symbols-outlined {
        font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
    }
    body {
        min-height: 100dvh;
    }
    .modal {
        display: none;
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0, 0, 0, 0.5);
        z-index: 1000;
        align-items: center;
        justify-content: center;
        backdrop-filter: blur(4px);
    }
    .modal.active {
        display: flex;
    }
</style>
