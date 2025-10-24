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

import util.DatabaseConnection;

/**
 * ResultServlet
 * Displays quiz results
 */
@WebServlet("/result")
public class ResultServlet extends HttpServlet {
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

        // Get result details from session
        Integer score = (Integer) session.getAttribute("score");
        Integer totalQuestions = (Integer) session.getAttribute("totalQuestions");
        Integer rankAssigned = (Integer) session.getAttribute("rankAssigned");
        Integer companyId = (Integer) session.getAttribute("companyId");

        if (score == null || totalQuestions == null) {
            response.sendRedirect(request.getContextPath() + "/company-select");
            return;
        }

        // Get company name
        String companyName = "";
        if (companyId != null) {
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;

            try {
                conn = DatabaseConnection.getConnection();
                String sql = "SELECT company_name FROM Companies WHERE company_id = ?";
                stmt = conn.prepareStatement(sql);
                stmt.setInt(1, companyId);
                rs = stmt.executeQuery();

                if (rs.next()) {
                    companyName = rs.getString("company_name");
                }
            } catch (SQLException e) {
                e.printStackTrace();
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

        // Calculate percentage
        double percentage = (score * 100.0) / totalQuestions;

        // Set attributes for JSP
        request.setAttribute("score", score);
        request.setAttribute("totalQuestions", totalQuestions);
        request.setAttribute("percentage", String.format("%.2f", percentage));
        request.setAttribute("rankAssigned", rankAssigned);
        request.setAttribute("companyName", companyName);
        request.setAttribute("userName", session.getAttribute("userName"));

        // Forward to result page
        request.getRequestDispatcher("/result.jsp").forward(request, response);
    }
}
