package model;

/**
 * User Model Class
 * Represents a user in the system
 */
public class User {
    private int userId;
    private String name;
    private String rollNumber;
    private String email;

    // Constructors
    public User() {
    }

    public User(String name, String rollNumber, String email) {
        this.name = name;
        this.rollNumber = rollNumber;
        this.email = email;
    }

    public User(int userId, String name, String rollNumber, String email) {
        this.userId = userId;
        this.name = name;
        this.rollNumber = rollNumber;
        this.email = email;
    }

    // Getters and Setters
    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getRollNumber() {
        return rollNumber;
    }

    public void setRollNumber(String rollNumber) {
        this.rollNumber = rollNumber;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    @Override
    public String toString() {
        return "User{" +
                "userId=" + userId +
                ", name='" + name + '\'' +
                ", rollNumber='" + rollNumber + '\'' +
                ", email='" + email + '\'' +
                '}';
    }
}
