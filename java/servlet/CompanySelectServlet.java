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

import model.Company;
import util.DatabaseConnection;

/**
 * CompanySelectServlet
 * Handles company selection for quiz
 */
@WebServlet("/company-select")
public class CompanySelectServlet extends HttpServlet {
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

        // Fetch all companies from database
        List<Company> companies = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT company_id, company_name FROM Companies ORDER BY company_name";
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();

            while (rs.next()) {
                Company company = new Company(
                        rs.getInt("company_id"),
                        rs.getString("company_name"));
                companies.add(company);
            }

            request.setAttribute("companies", companies);
            request.getRequestDispatcher("/company-select.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error loading companies: " + e.getMessage());
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

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/register");
            return;
        }

        // Get selected company
        String companyIdStr = request.getParameter("companyId");

        if (companyIdStr == null || companyIdStr.trim().isEmpty()) {
            request.setAttribute("error", "Please select a company");
            doGet(request, response);
            return;
        }

        try {
            int companyId = Integer.parseInt(companyIdStr);

            // Store company ID in session
            session.setAttribute("companyId", companyId);

            // Redirect to quiz
            response.sendRedirect(request.getContextPath() + "/quiz");

        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid company selection");
            doGet(request, response);
        }
    }
}
