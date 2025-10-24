package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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
 * SubmitQuizServlet
 * Evaluates quiz answers and calculates score
 */
@WebServlet("/submit-quiz")
public class SubmitQuizServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/register");
            return;
        }

        // Get user ID and company ID from session
        Integer userId = (Integer) session.getAttribute("userId");
        Integer companyId = (Integer) session.getAttribute("companyId");

        if (companyId == null) {
            response.sendRedirect(request.getContextPath() + "/company-select");
            return;
        }

        // Get questions from session
        @SuppressWarnings("unchecked")
        List<Question> questions = (List<Question>) session.getAttribute("questions");

        if (questions == null || questions.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/quiz");
            return;
        }

        // Calculate score
        int score = 0;
        int totalQuestions = questions.size();

        for (Question question : questions) {
            String userAnswer = request.getParameter("question_" + question.getQuestionId());
            if (userAnswer != null && userAnswer.equalsIgnoreCase(question.getCorrectAnswer())) {
                score++;
            }
        }

        // Calculate rank based on score percentage
        int rankAssigned = calculateRank(score, totalQuestions);

        // Save result to database
        Connection conn = null;
        PreparedStatement insertStmt = null;

        try {
            conn = DatabaseConnection.getConnection();
            String insertSql = "INSERT INTO Results (user_id, company_id, score, total_questions, rank_assigned) " +
                    "VALUES (?, ?, ?, ?, ?)";

            insertStmt = conn.prepareStatement(insertSql, PreparedStatement.RETURN_GENERATED_KEYS);
            insertStmt.setInt(1, userId);
            insertStmt.setInt(2, companyId);
            insertStmt.setInt(3, score);
            insertStmt.setInt(4, totalQuestions);
            insertStmt.setInt(5, rankAssigned);

            insertStmt.executeUpdate();

            // Get generated result ID
            ResultSet generatedKeys = insertStmt.getGeneratedKeys();
            int resultId = 0;
            if (generatedKeys.next()) {
                resultId = generatedKeys.getInt(1);
            }

            // Store result details in session
            session.setAttribute("resultId", resultId);
            session.setAttribute("score", score);
            session.setAttribute("totalQuestions", totalQuestions);
            session.setAttribute("rankAssigned", rankAssigned);

            // Redirect to result page
            response.sendRedirect(request.getContextPath() + "/result");

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error saving results: " + e.getMessage());
            request.getRequestDispatcher("/quiz.jsp").forward(request, response);
        } finally {
            try {
                if (insertStmt != null)
                    insertStmt.close();
                if (conn != null)
                    DatabaseConnection.closeConnection(conn);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    /**
     * Calculate rank based on score percentage
     * 
     * @param score User's score
     * @param total Total questions
     * @return Rank (1-5, where 1 is best)
     */
    private int calculateRank(int score, int total) {
        double percentage = (score * 100.0) / total;

        if (percentage >= 90)
            return 1;
        else if (percentage >= 75)
            return 2;
        else if (percentage >= 60)
            return 3;
        else if (percentage >= 40)
            return 4;
        else
            return 5;
    }
}
