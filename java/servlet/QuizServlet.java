package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import model.Question;
import util.DatabaseConnection;

/**
 * QuizServlet
 * Displays questions for the selected company
 */
@WebServlet("/quiz")
public class QuizServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/register");
            return;
        }

        // Check if company is selected
        Integer companyId = (Integer) session.getAttribute("companyId");
        if (companyId == null) {
            response.sendRedirect(request.getContextPath() + "/company-select");
            return;
        }

        // Fetch questions for the selected company, sorted by rank (high to low)
        List<Question> questions = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT question_id, question_text, option_a, option_b, option_c, option_d, " +
                    "correct_answer, question_rank, company_id FROM Questions " +
                    "WHERE company_id = ? ORDER BY question_rank DESC";

            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, companyId);
            rs = stmt.executeQuery();

            while (rs.next()) {
                Question question = new Question(
                        rs.getInt("question_id"),
                        rs.getString("question_text"),
                        rs.getString("option_a"),
                        rs.getString("option_b"),
                        rs.getString("option_c"),
                        rs.getString("option_d"),
                        rs.getString("correct_answer"),
                        rs.getInt("question_rank"),
                        rs.getInt("company_id"));
                questions.add(question);
            }

            if (questions.isEmpty()) {
                request.setAttribute("error", "No questions available for this company.");
                request.getRequestDispatcher("/company-select.jsp").forward(request, response);
                return;
            }

            // Store questions in session for evaluation
            session.setAttribute("questions", questions);

            request.setAttribute("questions", questions);
            request.getRequestDispatcher("/quiz.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error loading questions: " + e.getMessage());
            request.getRequestDispatcher("/company-select.jsp").forward(request, response);
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
    }
}
