<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html class="light" lang="en">
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>Search Results - Placement Portal</title>
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&amp;display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
    <style>
        .glass-card {
            background: rgba(255, 255, 255, 0.8);
            backdrop-filter: blur(12px);
            border: 1px solid rgba(226, 232, 240, 0.5);
        }
    </style>
</head>
<body class="bg-[#f8f9ff] font-sans text-[#0b1c30] min-h-screen">
    <div class="max-w-4xl mx-auto p-6 md:p-12">
        <div class="flex items-center gap-4 mb-8">
            <a href="${pageContext.request.contextPath}/admin" class="p-2 hover:bg-gray-100 rounded-full transition-colors">
                <span class="material-symbols-outlined">arrow_back</span>
            </a>
            <h1 class="text-3xl font-bold">Search Results</h1>
        </div>

        <div class="glass-card rounded-2xl p-6 shadow-sm mb-8">
            <form action="${pageContext.request.contextPath}/search" method="get" class="flex gap-2">
                <div class="flex-1 relative">
                    <span class="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-gray-400">search</span>
                    <input type="text" name="q" value="${query}" class="w-full pl-10 pr-4 py-3 rounded-xl border-gray-200 focus:ring-2 focus:ring-blue-500 transition-all" placeholder="Search again...">
                </div>
                <button type="submit" class="px-8 py-3 bg-blue-600 text-white rounded-xl font-bold hover:bg-blue-700 transition-colors">Search</button>
            </form>
        </div>

        <div class="space-y-4">
            <p class="text-gray-500 mb-4">Found ${results.size()} results for "${query}"</p>
            
            <c:forEach var="item" items="${results}">
                <div class="glass-card p-5 rounded-xl flex items-center justify-between hover:border-blue-300 transition-all cursor-pointer group">
                    <div class="flex items-center gap-4">
                        <div class="w-12 h-12 rounded-full bg-blue-50 flex items-center justify-center text-blue-600">
                            <c:choose>
                                <c:when test="${item.type == 'student'}">
                                    <span class="material-symbols-outlined">school</span>
                                </c:when>
                                <c:when test="${item.type == 'company'}">
                                    <span class="material-symbols-outlined">business</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="material-symbols-outlined">event_available</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div>
                            <span class="text-xs font-bold uppercase tracking-wider text-blue-500">${item.type}</span>
                            <h3 class="text-lg font-bold group-hover:text-blue-600 transition-colors">${item.title}</h3>
                            <p class="text-sm text-gray-500">${item.detail}</p>
                        </div>
                    </div>
                    <span class="material-symbols-outlined text-gray-300 group-hover:text-blue-500 transition-colors">chevron_right</span>
                </div>
            </c:forEach>

            <c:if test="${empty results}">
                <div class="text-center py-20">
                    <div class="w-20 h-20 bg-gray-100 rounded-full flex items-center justify-center mx-auto mb-4 text-gray-400">
                        <span class="material-symbols-outlined text-4xl">search_off</span>
                    </div>
                    <h3 class="text-xl font-bold text-gray-800">No results found</h3>
                    <p class="text-gray-500">Try searching with a different keyword.</p>
                </div>
            </c:if>
        </div>
    </div>
</body>
</html>
