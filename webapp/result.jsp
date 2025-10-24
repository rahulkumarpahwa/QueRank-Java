<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Quiz Results - QueRank</title>
<script src="https://cdn.tailwindcss.com"></script>
</head>
<body
	class="bg-gradient-to-br from-blue-50 to-indigo-100 min-h-screen p-4">
	<div class="max-w-3xl mx-auto py-8">
		<!-- Results Card -->
		<div class="bg-white rounded-2xl shadow-2xl overflow-hidden">
			<!-- Header -->
			<div
				class="bg-gradient-to-r from-indigo-600 to-purple-600 p-8 text-white text-center">
				<div class="text-6xl mb-4">🎉</div>
				<h1 class="text-3xl font-bold mb-2">Quiz Completed!</h1>
				<p class="text-indigo-100">Here are your results</p>
			</div>

			<!-- Student Info -->
			<div class="p-8 border-b border-gray-200">
				<div class="text-center">
					<p class="text-gray-600 mb-1">Student Name</p>
					<p class="text-2xl font-bold text-gray-800">
						<%= request.getAttribute("userName") %>
					</p>
					<% if (request.getAttribute("companyName") != null) { %>
					<p class="text-indigo-600 mt-2">
						Company: <strong><%= request.getAttribute("companyName") %></strong>
					</p>
					<% } %>
				</div>
			</div>

			<!-- Score Display -->
			<div class="p-8">
				<div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
					<!-- Score -->
					<div class="bg-blue-50 rounded-xl p-6 text-center">
						<p class="text-gray-600 text-sm mb-2">Your Score</p>
						<p class="text-4xl font-bold text-blue-600">
							<%= request.getAttribute("score") %>/<%=
                request.getAttribute("totalQuestions") %>
						</p>
					</div>

					<!-- Percentage -->
					<div class="bg-green-50 rounded-xl p-6 text-center">
						<p class="text-gray-600 text-sm mb-2">Percentage</p>
						<p class="text-4xl font-bold text-green-600">
							<%= request.getAttribute("percentage") %>%
						</p>
					</div>

					<!-- Rank -->
					<div class="bg-purple-50 rounded-xl p-6 text-center">
						<p class="text-gray-600 text-sm mb-2">Your Rank</p>
						<p class="text-4xl font-bold text-purple-600">
							<%= request.getAttribute("rankAssigned") %>
						</p>
						<p class="text-xs text-gray-500 mt-1">(1 is best)</p>
					</div>
				</div>

				<!-- Performance Message -->
				<% Integer rank = (Integer) request.getAttribute("rankAssigned");
          String message = ""; String colorClass = ""; 
          if (rank != null) {
          switch(rank) { 
          case 1: message = "Outstanding! You're in the top tier!"; 
          colorClass = "bg-green-100 border-green-400 text-green-800";
          break; 
          case 2: message = "Excellent work! Keep it up!"; 
          colorClass = "bg-blue-100 border-blue-400 text-blue-800"; break; 
          case 3: message = "Good job! There's room for improvement."; 
          colorClass = "bg-yellow-100 border-yellow-400 text-yellow-800"; 
          break; 
         case 4: message = "Fair attempt. Practice more to improve."; 
         colorClass = "bg-orange-100 border-orange-400 text-orange-800"; 
         break; 
        default: message = "Keep practicing! You can do better."; 
        colorClass = "bg-red-100 border-red-400 text-red-800"; 
        } } %>

				<div
					class="<%= colorClass %> border-2 rounded-lg p-4 text-center mb-8">
					<p class="font-semibold"><%= message %></p>
				</div>

				<!-- Action Buttons -->
				<div class="grid grid-cols-1 md:grid-cols-2 gap-4">
					<a href="<%= request.getContextPath() %>/company-select"
						class="block bg-indigo-600 text-white font-semibold py-3 px-6 rounded-lg hover:bg-indigo-700 transition text-center">
						Take Another Quiz </a> <a
						href="<%= request.getContextPath() %>/register"
						class="block bg-gray-200 text-gray-800 font-semibold py-3 px-6 rounded-lg hover:bg-gray-300 transition text-center">
						Logout </a>
				</div>
			</div>
		</div>

		<!-- Tips Box -->
		<div class="mt-6 bg-white rounded-lg p-6 shadow-lg">
			<h3 class="font-semibold text-gray-800 mb-3">📚 Tips for
				Improvement</h3>
			<ul class="text-sm text-gray-600 space-y-2">
				<li>✓ Review questions ranked higher - they're asked more
					frequently</li>
				<li>✓ Practice with different companies to broaden your
					knowledge</li>
				<li>✓ Focus on topics where you scored less</li>
				<li>✓ Attempt quizzes regularly to track your progress</li>
			</ul>
		</div>
	</div>
</body>
</html>
