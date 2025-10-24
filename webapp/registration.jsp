<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Student Registration - QueRank</title>
    <script src="https://cdn.tailwindcss.com"></script>
  </head>
  <body
    class="bg-gradient-to-br from-blue-50 to-indigo-100 min-h-screen flex items-center justify-center p-4"
  >
    <div class="max-w-md w-full">
      <div class="bg-white rounded-2xl shadow-2xl p-8">
        <!-- Logo/Header -->
        <div class="text-center mb-8">
          <h1 class="text-4xl font-bold text-indigo-600 mb-2">QueRank</h1>
          <p class="text-gray-600">Company-Specific Quiz Platform</p>
        </div>

        <!-- Error Message -->
        <% if (request.getAttribute("error") != null) { %>
        <div
          class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded-lg mb-6"
        >
          <%= request.getAttribute("error") %>
        </div>
        <% } %>

        <!-- Registration Form -->
        <form
          method="post"
          action="<%= request.getContextPath() %>/register"
          class="space-y-6"
        >
          <div>
            <label
              for="name"
              class="block text-sm font-medium text-gray-700 mb-2"
            >
              Full Name
            </label>
            <input
              type="text"
              id="name"
              name="name"
              required
              class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-transparent transition"
              placeholder="Enter your full name"
            />
          </div>

          <div>
            <label
              for="rollNumber"
              class="block text-sm font-medium text-gray-700 mb-2"
            >
              Roll Number
            </label>
            <input
              type="text"
              id="rollNumber"
              name="rollNumber"
              required
              class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-transparent transition"
              placeholder="Enter your roll number"
            />
          </div>

          <div>
            <label
              for="email"
              class="block text-sm font-medium text-gray-700 mb-2"
            >
              Email Address
            </label>
            <input
              type="email"
              id="email"
              name="email"
              required
              class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-transparent transition"
              placeholder="your.email@example.com"
            />
          </div>

          <button
            type="submit"
            class="w-full bg-indigo-600 text-white font-semibold py-3 px-4 rounded-lg hover:bg-indigo-700 transition duration-200 shadow-lg hover:shadow-xl"
          >
            Register & Start Quiz
          </button>
        </form>

        <div class="mt-6 text-center text-sm text-gray-600">
          <p>Already registered? Just enter your details to continue.</p>
        </div>
      </div>

      <!-- Footer -->
      <div class="text-center mt-6 text-gray-600 text-sm">
        <p>&copy; 2025 QueRank. Placement Preparation Made Easy.</p>
      </div>
    </div>
  </body>
</html>
