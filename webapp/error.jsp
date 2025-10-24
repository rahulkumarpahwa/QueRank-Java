<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Error - QueRank</title>
    <script src="https://cdn.tailwindcss.com"></script>
  </head>
  <body
    class="bg-gradient-to-br from-red-50 to-orange-100 min-h-screen flex items-center justify-center p-4"
  >
    <div
      class="max-w-md w-full bg-white rounded-2xl shadow-2xl p-8 text-center"
    >
      <div class="text-6xl mb-4">⚠️</div>
      <h1 class="text-3xl font-bold text-red-600 mb-4">
        Oops! Something went wrong
      </h1>
      <p class="text-gray-600 mb-6">
        We encountered an error while processing your request.
      </p>
      <a
        href="<%= request.getContextPath() %>/register"
        class="inline-block bg-indigo-600 text-white font-semibold py-3 px-6 rounded-lg hover:bg-indigo-700 transition"
      >
        Go to Home
      </a>
    </div>
  </body>
</html>
