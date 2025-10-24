<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Company" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Select Company - QueRank</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gradient-to-br from-blue-50 to-indigo-100 min-h-screen p-4">
    <div class="max-w-4xl mx-auto py-8">
        <!-- Header -->
        <div class="bg-white rounded-2xl shadow-2xl p-8 mb-6">
            <div class="flex justify-between items-center">
                <div>
                    <h1 class="text-3xl font-bold text-indigo-600">Welcome, <%= session.getAttribute("userName") %>!</h1>
                    <p class="text-gray-600 mt-2">Select a company to start your placement quiz</p>
                </div>
                <a href="<%= request.getContextPath() %>/register" 
                   class="text-sm text-indigo-600 hover:text-indigo-800">Logout</a>
            </div>
        </div>
        
        <!-- Error Message -->
        <% if (request.getAttribute("error") != null) { %>
            <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded-lg mb-6">
                <%= request.getAttribute("error") %>
            </div>
        <% } %>
        
        <!-- Company Selection Form -->
        <div class="bg-white rounded-2xl shadow-2xl p-8">
            <h2 class="text-2xl font-bold text-gray-800 mb-6">Choose Your Target Company</h2>
            
            <form method="post" action="<%= request.getContextPath() %>/company-select">
                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
                    <% 
                    @SuppressWarnings("unchecked")
                    List<Company> companies = (List<Company>) request.getAttribute("companies");
                    if (companies != null && !companies.isEmpty()) {
                        for (Company company : companies) {
                    %>
                        <label class="relative cursor-pointer">
                            <input type="radio" name="companyId" value="<%= company.getCompanyId() %>" 
                                   class="peer sr-only" required>
                            <div class="p-6 border-2 border-gray-200 rounded-xl hover:border-indigo-500 peer-checked:border-indigo-600 peer-checked:bg-indigo-50 transition duration-200 text-center">
                                <div class="text-2xl mb-2">🏢</div>
                                <h3 class="font-semibold text-gray-800"><%= company.getCompanyName() %></h3>
                                <p class="text-xs text-gray-500 mt-1">Ranked Questions</p>
                            </div>
                        </label>
                    <% 
                        }
                    } else {
                    %>
                        <div class="col-span-3 text-center text-gray-500 py-8">
                            No companies available. Please contact administrator.
                        </div>
                    <% } %>
                </div>
                
                <% if (companies != null && !companies.isEmpty()) { %>
                    <div class="mt-8">
                        <button type="submit" 
                                class="w-full bg-indigo-600 text-white font-semibold py-3 px-4 rounded-lg hover:bg-indigo-700 transition duration-200 shadow-lg hover:shadow-xl">
                            Start Quiz →
                        </button>
                    </div>
                <% } %>
            </form>
        </div>
        
        <!-- Info Box -->
        <div class="mt-6 bg-blue-50 border border-blue-200 rounded-lg p-6">
            <h3 class="font-semibold text-blue-900 mb-2">💡 How it works</h3>
            <ul class="text-sm text-blue-800 space-y-1">
                <li>✓ Questions are ranked based on frequency in past interviews</li>
                <li>✓ Higher ranked questions appear first</li>
                <li>✓ Your score and rank will be calculated automatically</li>
                <li>✓ Results are saved for future reference</li>
            </ul>
        </div>
    </div>
</body>
</html>
