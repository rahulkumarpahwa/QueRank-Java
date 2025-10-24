<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Question" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quiz - QueRank</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gradient-to-br from-blue-50 to-indigo-100 min-h-screen p-4">
    <div class="max-w-4xl mx-auto py-8">
        <!-- Header -->
        <div class="bg-white rounded-2xl shadow-xl p-6 mb-6">
            <div class="flex justify-between items-center">
                <div>
                    <h1 class="text-2xl font-bold text-indigo-600">Quiz in Progress</h1>
                    <p class="text-gray-600 text-sm">Answer all questions and submit</p>
                </div>
                <div class="text-right">
                    <p class="text-sm text-gray-600">Student: <%= session.getAttribute("userName") %></p>
                    <% 
                    @SuppressWarnings("unchecked")
                    List<Question> questions = (List<Question>) request.getAttribute("questions");
                    int totalQuestions = questions != null ? questions.size() : 0;
                    %>
                    <p class="text-sm font-semibold text-indigo-600"><%= totalQuestions %> Questions</p>
                </div>
            </div>
        </div>
        
        <!-- Quiz Form -->
        <form method="post" action="<%= request.getContextPath() %>/submit-quiz" id="quizForm">
            <% 
            if (questions != null && !questions.isEmpty()) {
                int questionNumber = 1;
                for (Question question : questions) {
            %>
                <div class="bg-white rounded-2xl shadow-xl p-8 mb-6">
                    <!-- Question Header -->
                    <div class="flex items-start justify-between mb-6">
                        <div class="flex-1">
                            <div class="flex items-center gap-3 mb-3">
                                <span class="bg-indigo-600 text-white font-bold px-4 py-2 rounded-lg">
                                    Q<%= questionNumber %>
                                </span>
                                <span class="bg-yellow-100 text-yellow-800 text-xs font-semibold px-3 py-1 rounded-full">
                                    Rank: <%= question.getRank() %>/10
                                </span>
                            </div>
                            <p class="text-lg font-medium text-gray-800"><%= question.getQuestionText() %></p>
                        </div>
                    </div>
                    
                    <!-- Options -->
                    <div class="space-y-3">
                        <label class="flex items-center p-4 border-2 border-gray-200 rounded-lg cursor-pointer hover:border-indigo-400 transition">
                            <input type="radio" name="question_<%= question.getQuestionId() %>" value="A" 
                                   class="w-5 h-5 text-indigo-600" required>
                            <span class="ml-3 text-gray-700"><strong>A.</strong> <%= question.getOptionA() %></span>
                        </label>
                        
                        <label class="flex items-center p-4 border-2 border-gray-200 rounded-lg cursor-pointer hover:border-indigo-400 transition">
                            <input type="radio" name="question_<%= question.getQuestionId() %>" value="B" 
                                   class="w-5 h-5 text-indigo-600" required>
                            <span class="ml-3 text-gray-700"><strong>B.</strong> <%= question.getOptionB() %></span>
                        </label>
                        
                        <label class="flex items-center p-4 border-2 border-gray-200 rounded-lg cursor-pointer hover:border-indigo-400 transition">
                            <input type="radio" name="question_<%= question.getQuestionId() %>" value="C" 
                                   class="w-5 h-5 text-indigo-600" required>
                            <span class="ml-3 text-gray-700"><strong>C.</strong> <%= question.getOptionC() %></span>
                        </label>
                        
                        <label class="flex items-center p-4 border-2 border-gray-200 rounded-lg cursor-pointer hover:border-indigo-400 transition">
                            <input type="radio" name="question_<%= question.getQuestionId() %>" value="D" 
                                   class="w-5 h-5 text-indigo-600" required>
                            <span class="ml-3 text-gray-700"><strong>D.</strong> <%= question.getOptionD() %></span>
                        </label>
                    </div>
                </div>
            <% 
                    questionNumber++;
                }
            } else {
            %>
                <div class="bg-white rounded-2xl shadow-xl p-8 text-center">
                    <p class="text-gray-600">No questions available.</p>
                    <a href="<%= request.getContextPath() %>/company-select" 
                       class="inline-block mt-4 text-indigo-600 hover:text-indigo-800">
                        ← Back to Company Selection
                    </a>
                </div>
            <% } %>
            
            <% if (questions != null && !questions.isEmpty()) { %>
                <!-- Submit Button -->
                <div class="bg-white rounded-2xl shadow-xl p-6">
                    <button type="submit" 
                            class="w-full bg-green-600 text-white font-semibold py-4 px-6 rounded-lg hover:bg-green-700 transition duration-200 shadow-lg hover:shadow-xl">
                        Submit Quiz & View Results
                    </button>
                </div>
            <% } %>
        </form>
    </div>
    
    <script>
        // Confirm before submit
        document.getElementById('quizForm').addEventListener('submit', function(e) {
            if (!confirm('Are you sure you want to submit? You cannot change answers after submission.')) {
                e.preventDefault();
            }
        });
    </script>
</body>
</html>
