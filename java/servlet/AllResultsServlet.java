package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import util.DatabaseConnection;

/**
 * AllResultsServlet
 * Displays all quiz results of logged-in users
 */
@WebServlet("/all-results")
public class AllResultsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Map<String, Object>> allResults = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DatabaseConnection.getConnection();

            // Query to fetch all results with user and company information
            String sql = "SELECT " +
                    "r.result_id, " +
                    "u.name AS user_name, " +
                    "u.roll_number, " +
                    "u.email, " +
                    "c.company_name, " +
                    "r.score, " +
                    "r.total_questions, " +
                    "r.rank_assigned, " +
                    "r.attempted_at, " +
                    "ROUND((r.score * 100.0 / r.total_questions), 2) AS percentage " +
                    "FROM Results r " +
                    "JOIN Users u ON r.user_id = u.user_id " +
                    "JOIN Companies c ON r.company_id = c.company_id " +
                    "ORDER BY r.attempted_at DESC";

            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();

            while (rs.next()) {
                Map<String, Object> resultMap = new HashMap<>();
                resultMap.put("resultId", rs.getInt("result_id"));
                resultMap.put("userName", rs.getString("user_name"));
                resultMap.put("rollNumber", rs.getString("roll_number"));
                resultMap.put("email", rs.getString("email"));
                resultMap.put("companyName", rs.getString("company_name"));
                resultMap.put("score", rs.getInt("score"));
                resultMap.put("totalQuestions", rs.getInt("total_questions"));
                resultMap.put("rankAssigned", rs.getInt("rank_assigned"));
                resultMap.put("percentage", rs.getDouble("percentage"));
                resultMap.put("attemptedAt", rs.getTimestamp("attempted_at"));

                allResults.add(resultMap);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error fetching results: " + e.getMessage());
        } finally {
            try {
                if (rs != null)
                    rs.close();
                if (stmt != null)
                    stmt.close();
                if (conn != null)
                    DatabaseConnection.closeConnection(conn);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        // Set attributes for JSP
        request.setAttribute("allResults", allResults);
        request.setAttribute("totalResults", allResults.size());

        // Forward to JSP
        request.getRequestDispatcher("/all-results.jsp").forward(request, response);
    }
}
