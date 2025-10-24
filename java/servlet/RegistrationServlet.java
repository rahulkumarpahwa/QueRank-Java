package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import model.User;
import util.DatabaseConnection;

/**
 * RegistrationServlet Handles user registration
 */
@WebServlet("/register")
public class RegistrationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// Forward to registration page
		request.getRequestDispatcher("/registration.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// Get form parameters
		String name = request.getParameter("name");
		String rollNumber = request.getParameter("rollNumber");
		String email = request.getParameter("email");

		// Validate inputs
		if (name == null || name.trim().isEmpty() || rollNumber == null || rollNumber.trim().isEmpty() || email == null
				|| email.trim().isEmpty()) {

			request.setAttribute("error", "All fields are required!");
			request.getRequestDispatcher("/registration.jsp").forward(request, response);
			return;
		}

		Connection conn = null;
		PreparedStatement checkStmt = null;
		PreparedStatement insertStmt = null;
		ResultSet rs = null;

		try {
			conn = DatabaseConnection.getConnection();

			// Check if user already exists
			String checkSql = "SELECT user_id, name FROM Users WHERE roll_number = ? OR email = ?";
			checkStmt = conn.prepareStatement(checkSql);
			checkStmt.setString(1, rollNumber);
			checkStmt.setString(2, email);
			rs = checkStmt.executeQuery();

			if (rs.next()) {
				// User exists - log them in
				int userId = rs.getInt("user_id");
				String existingName = rs.getString("name");

				User user = new User(userId, existingName, rollNumber, email);
				HttpSession session = request.getSession();
				session.setAttribute("user", user);
				session.setAttribute("userId", userId);
				session.setAttribute("userName", existingName);

				response.sendRedirect(request.getContextPath() + "/company-select");
				return;
			}

			// Insert new user
			String insertSql = "INSERT INTO Users (name, roll_number, email) VALUES (?, ?, ?)";
			insertStmt = conn.prepareStatement(insertSql, PreparedStatement.RETURN_GENERATED_KEYS);
			insertStmt.setString(1, name);
			insertStmt.setString(2, rollNumber);
			insertStmt.setString(3, email);

			int rowsAffected = insertStmt.executeUpdate();

			if (rowsAffected > 0) {
				// Get generated user ID
				ResultSet generatedKeys = insertStmt.getGeneratedKeys();
				int userId = 0;
				if (generatedKeys.next()) {
					userId = generatedKeys.getInt(1);
				}

				// Create user object and store in session
				User user = new User(userId, name, rollNumber, email);
				HttpSession session = request.getSession();
				session.setAttribute("user", user);
				session.setAttribute("userId", userId);
				session.setAttribute("userName", name);

				// Redirect to company selection
				response.sendRedirect(request.getContextPath() + "/company-select");
			} else {
				request.setAttribute("error", "Registration failed. Please try again.");
				request.getRequestDispatcher("/registration.jsp").forward(request, response);
			}

		} catch (SQLException e) {
			e.printStackTrace();
			request.setAttribute("error", "Database error: " + e.getMessage());
			request.getRequestDispatcher("/registration.jsp").forward(request, response);
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (checkStmt != null)
					checkStmt.close();
				if (insertStmt != null)
					insertStmt.close();
				if (conn != null)
					DatabaseConnection.closeConnection(conn);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
}
