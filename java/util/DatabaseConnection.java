package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Database Connection Utility Class
 * Manages JDBC connections for the Quiz System
 */
public class DatabaseConnection {

    // Database credentials - UPDATE THESE ACCORDING TO YOUR MYSQL SETUP
    private static final String DB_URL = "jdbc:mysql://localhost:3306/querank_db";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "root"; // Update with your MySQL password

    // JDBC Driver
    private static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";

    static {
        try {
            // Load MySQL JDBC Driver
            Class.forName(JDBC_DRIVER);
            System.out.println("MySQL JDBC Driver loaded successfully");
        } catch (ClassNotFoundException e) {
            System.err.println("MySQL JDBC Driver not found!");
            e.printStackTrace();
        }
    }

    /**
     * Get a database connection
     * 
     * @return Connection object
     * @throws SQLException if connection fails
     */
    public static Connection getConnection() throws SQLException {
        try {
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            System.out.println("Database connection established");
            return conn;
        } catch (SQLException e) {
            System.err.println("Failed to establish database connection!");
            throw e;
        }
    }

    /**
     * Close database connection
     * 
     * @param conn Connection to close
     */
    public static void closeConnection(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
                System.out.println("Database connection closed");
            } catch (SQLException e) {
                System.err.println("Error closing connection");
                e.printStackTrace();
            }
        }
    }

    /**
     * Test database connection
     * 
     * @return true if connection successful
     */
    public static boolean testConnection() {
        try (Connection conn = getConnection()) {
            return conn != null && !conn.isClosed();
        } catch (SQLException e) {
            System.err.println("Connection test failed: " + e.getMessage());
            return false;
        }
    }
}
