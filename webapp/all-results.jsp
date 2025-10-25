<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>All Results - QueRank</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
      .table-header {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      }
      .rank-badge {
        display: inline-block;
        width: 40px;
        height: 40px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        font-weight: bold;
        color: white;
      }
      .rank-1 { background: linear-gradient(135deg, #FFD700 0%, #FFA500 100%); }
      .rank-2 { background: linear-gradient(135deg, #C0C0C0 0%, #808080 100%); }
      .rank-3 { background: linear-gradient(135deg, #CD7F32 0%, #8B4513 100%); }
      .rank-4 { background: linear-gradient(135deg, #FF6B6B 0%, #EE5A52 100%); }
      .rank-5, .rank-6 { background: linear-gradient(135deg, #FF8C42 0%, #D84315 100%); }
      
      .score-excellent { background-color: #10b981; }
      .score-good { background-color: #3b82f6; }
      .score-average { background-color: #f59e0b; }
      .score-poor { background-color: #ef4444; }
    </style>
  </head>
  <body class="bg-gradient-to-br from-gray-50 to-gray-100 min-h-screen p-4">
    <div class="max-w-7xl mx-auto py-8">
      <!-- Header -->
      <div class="mb-8">
        <div class="flex items-center justify-between mb-4">
          <div>
            <h1 class="text-4xl font-bold text-gray-800 mb-2">
              <i class="fas fa-chart-bar text-indigo-600 mr-3"></i>All Quiz Results
            </h1>
            <p class="text-gray-600">
              Total Attempts: <strong><%= request.getAttribute("totalResults") %></strong>
            </p>
          </div>
          <a
            href="<%= request.getContextPath() %>/register"
            class="bg-indigo-600 text-white font-semibold py-2 px-6 rounded-lg hover:bg-indigo-700 transition"
          >
            <i class="fas fa-home mr-2"></i>Home
          </a>
        </div>
      </div>

      <!-- Error Message -->
      <% if (request.getAttribute("error") != null) { %>
      <div class="bg-red-100 border-l-4 border-red-500 text-red-700 p-4 mb-6 rounded">
        <p><i class="fas fa-exclamation-circle mr-2"></i><%= request.getAttribute("error") %></p>
      </div>
      <% } %>

      <!-- Results Table -->
      <div class="bg-white rounded-xl shadow-lg overflow-hidden">
        <!-- Table Header -->
        <div class="table-header px-6 py-4 text-white">
          <h2 class="text-xl font-bold">
            <i class="fas fa-list mr-2"></i>Results Overview
          </h2>
        </div>

        <!-- Table Content -->
        <div class="overflow-x-auto">
          <% List<Map<String, Object>> allResults = (List<Map<String, Object>>) request.getAttribute("allResults"); %>
          
          <% if (allResults != null && allResults.size() > 0) { %>
          <table class="w-full">
            <thead class="bg-gray-100 border-b-2 border-gray-200">
              <tr>
                <th class="px-6 py-4 text-left text-sm font-semibold text-gray-700">
                  <i class="fas fa-user mr-2"></i>Student Name
                </th>
                <th class="px-6 py-4 text-left text-sm font-semibold text-gray-700">
                  <i class="fas fa-id-card mr-2"></i>Roll Number
                </th>
                <th class="px-6 py-4 text-left text-sm font-semibold text-gray-700">
                  <i class="fas fa-envelope mr-2"></i>Email
                </th>
                <th class="px-6 py-4 text-left text-sm font-semibold text-gray-700">
                  <i class="fas fa-building mr-2"></i>Company
                </th>
                <th class="px-6 py-4 text-center text-sm font-semibold text-gray-700">
                  <i class="fas fa-star mr-2"></i>Score
                </th>
                <th class="px-6 py-4 text-center text-sm font-semibold text-gray-700">
                  <i class="fas fa-percentage mr-2"></i>Percentage
                </th>
                <th class="px-6 py-4 text-center text-sm font-semibold text-gray-700">
                  <i class="fas fa-medal mr-2"></i>Rank
                </th>
                <th class="px-6 py-4 text-left text-sm font-semibold text-gray-700">
                  <i class="fas fa-calendar mr-2"></i>Attempted At
                </th>
              </tr>
            </thead>
            <tbody>
              <% int index = 0; %>
              <% for (Map<String, Object> result : allResults) { %>
                <% String rowColor = (index % 2 == 0) ? "bg-white" : "bg-gray-50"; %>
                <tr class="<%= rowColor %> border-b border-gray-200 hover:bg-indigo-50 transition">
                  <!-- Student Name -->
                  <td class="px-6 py-4 text-gray-800 font-medium">
                    <div class="flex items-center">
                      <div class="w-10 h-10 rounded-full bg-indigo-100 flex items-center justify-center text-indigo-600 font-bold mr-3">
                        <%= ((String) result.get("userName")).substring(0, 1).toUpperCase() %>
                      </div>
                      <%= result.get("userName") %>
                    </div>
                  </td>
                  
                  <!-- Roll Number -->
                  <td class="px-6 py-4 text-gray-700">
                    <%= result.get("rollNumber") %>
                  </td>
                  
                  <!-- Email -->
                  <td class="px-6 py-4 text-gray-700 text-sm">
                    <a href="mailto:<%= result.get("email") %>" class="text-indigo-600 hover:underline">
                      <%= result.get("email") %>
                    </a>
                  </td>
                  
                  <!-- Company -->
                  <td class="px-6 py-4 text-gray-700">
                    <span class="bg-blue-100 text-blue-800 px-3 py-1 rounded-full text-sm font-medium">
                      <%= result.get("companyName") %>
                    </span>
                  </td>
                  
                  <!-- Score -->
                  <td class="px-6 py-4 text-center">
                    <span class="bg-indigo-100 text-indigo-800 px-4 py-2 rounded-lg font-bold text-lg">
                      <%= result.get("score") %>/<%= result.get("totalQuestions") %>
                    </span>
                  </td>
                  
                  <!-- Percentage -->
                  <td class="px-6 py-4 text-center">
                    <% Double percentage = (Double) result.get("percentage");
                       String scoreClass = "";
                       if (percentage >= 80) {
                           scoreClass = "score-excellent";
                       } else if (percentage >= 60) {
                           scoreClass = "score-good";
                       } else if (percentage >= 40) {
                           scoreClass = "score-average";
                       } else {
                           scoreClass = "score-poor";
                       }
                    %>
                    <span class="<%= scoreClass %> text-white px-4 py-2 rounded-lg font-bold">
                      <%= String.format("%.2f", percentage) %>%
                    </span>
                  </td>
                  
                  <!-- Rank -->
                  <td class="px-6 py-4 text-center">
                    <% Integer rank = (Integer) result.get("rankAssigned"); %>
                    <span class="rank-badge rank-<%= rank %>">
                      <%= rank %>
                    </span>
                  </td>
                  
                  <!-- Attempted At -->
                  <td class="px-6 py-4 text-gray-700 text-sm">
                    <i class="fas fa-clock text-gray-400 mr-2"></i>
                    <%= result.get("attemptedAt") %>
                  </td>
                </tr>
                <% index++; %>
              <% } %>
            </tbody>
          </table>
          <% } else { %>
          <!-- No Results Message -->
          <div class="p-12 text-center">
            <i class="fas fa-inbox text-gray-300 text-6xl mb-4"></i>
            <p class="text-gray-500 text-lg">No quiz results found yet.</p>
            <p class="text-gray-400 mt-2">Start by taking a quiz to see results here.</p>
            <a
              href="<%= request.getContextPath() %>/register"
              class="inline-block mt-6 bg-indigo-600 text-white font-semibold py-2 px-6 rounded-lg hover:bg-indigo-700 transition"
            >
              <i class="fas fa-play mr-2"></i>Take Quiz
            </a>
          </div>
          <% } %>
        </div>
      </div>

      <!-- Statistics Section -->
      <% if (allResults != null && allResults.size() > 0) { %>
      <div class="grid grid-cols-1 md:grid-cols-4 gap-4 mt-8">
        <!-- Total Attempts -->
        <div class="bg-white rounded-xl shadow-lg p-6">
          <div class="flex items-center justify-between">
            <div>
              <p class="text-gray-600 text-sm">Total Attempts</p>
              <p class="text-3xl font-bold text-indigo-600"><%= allResults.size() %></p>
            </div>
            <i class="fas fa-chart-line text-indigo-200 text-4xl"></i>
          </div>
        </div>

        <!-- Average Score -->
        <div class="bg-white rounded-xl shadow-lg p-6">
          <div class="flex items-center justify-between">
            <div>
              <p class="text-gray-600 text-sm">Average Score</p>
              <% 
                double totalScore = 0;
                for (Map<String, Object> result : allResults) {
                  totalScore += (Integer) result.get("score");
                }
                double avgScore = totalScore / allResults.size();
              %>
              <p class="text-3xl font-bold text-green-600"><%= String.format("%.2f", avgScore) %></p>
            </div>
            <i class="fas fa-star text-green-200 text-4xl"></i>
          </div>
        </div>

        <!-- Average Percentage -->
        <div class="bg-white rounded-xl shadow-lg p-6">
          <div class="flex items-center justify-between">
            <div>
              <p class="text-gray-600 text-sm">Average Percentage</p>
              <% 
                double totalPercentage = 0;
                for (Map<String, Object> result : allResults) {
                  totalPercentage += (Double) result.get("percentage");
                }
                double avgPercentage = totalPercentage / allResults.size();
              %>
              <p class="text-3xl font-bold text-blue-600"><%= String.format("%.2f", avgPercentage) %>%</p>
            </div>
            <i class="fas fa-percent text-blue-200 text-4xl"></i>
          </div>
        </div>

        <!-- Unique Users -->
        <div class="bg-white rounded-xl shadow-lg p-6">
          <div class="flex items-center justify-between">
            <div>
              <p class="text-gray-600 text-sm">Unique Users</p>
              <% 
                java.util.Set<Object> uniqueUsers = new java.util.HashSet<>();
                for (Map<String, Object> result : allResults) {
                  uniqueUsers.add(result.get("userName"));
                }
              %>
              <p class="text-3xl font-bold text-purple-600"><%= uniqueUsers.size() %></p>
            </div>
            <i class="fas fa-users text-purple-200 text-4xl"></i>
          </div>
        </div>
      </div>
      <% } %>

      <!-- Footer -->
      <div class="mt-12 text-center text-gray-500 text-sm">
        <p><i class="fas fa-info-circle mr-2"></i>Results are automatically updated when quizzes are completed.</p>
      </div>
    </div>
  </body>
</html>
