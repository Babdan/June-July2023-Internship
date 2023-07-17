<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Check if the user is logged in
    boolean isLoggedIn = false;

    // Check if the loggedIn attribute is set to true in the session
    if (request.getSession().getAttribute("loggedIn") != null
            && (boolean) request.getSession().getAttribute("loggedIn")) {
        isLoggedIn = true;
    }

    // If the user is not logged in, redirect to the login page
    if (!isLoggedIn) {
        response.sendRedirect("login.jsp");
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Test Page</title>
    <style>
        /* Styles for the navbar */
        .navbar {
            background-color: #333333;
            padding: 10px;
            color: #ffffff;
        }

        .navbar ul {
            margin: 0;
            padding: 0;
            list-style-type: none;
            display: flex;
            justify-content: space-between;
        }

        .navbar li {
            display: inline;
            margin-right: 10px;
        }

        .navbar a {
            padding: 10px;
            border-radius: 5px;
            text-decoration: none;
            color: #ffffff;
        }

        .navbar .home-button {
            background-color: orange;
        }

        .navbar .logout-button {
            background-color: red;
        }

        .navbar a:hover {
            background-color: #555555;
        }

        /* Container styles */
        .container {
            max-width: 500px;
            margin: 50px auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: #f2f2f2;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
        }

        .container h1 {
            text-align: center;
            margin-bottom: 30px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }

        .form-group input[type="text"] {
            width: 100%;
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }

        .form-group button {
            width: 100%;
            padding: 10px;
            border-radius: 5px;
            border: none;
            background-color: #4CAF50;
            color: #fff;
            font-weight: bold;
            cursor: pointer;
        }

        .form-group button:hover {
            background-color: #45a049;
        }
        .home-button {
            background-color: #ffa500;
            color: #ffffff;
            padding: 10px;
            border-radius: 5px;
            text-decoration: none;
        }

        .home-button:hover {
            background-color: #ff8c00;
        }
    </style>
</head>
<body>
    <div class="navbar">
        <ul>
            <li>Logged-In Successfully</li>
            <li>
                <a href="http://localhost/phpMyAdmin/?lang=en" class="home-button">phpMyAdmin</a>
            </li>
            <li>
                <% if (isLoggedIn) { %>
                <a href="logout.jsp" class="logout-button">Logout</a>
                <% } %>
            </li>
        </ul>
    </div>

    <div class="container">
        <h1>Insert Sample Data</h1>
        <form action="" method="POST">
            <div class="form-group">
                <label for="name">Name:</label>
                <input type="text" id="name" name="name" required>
            </div>
            <div class="form-group">
                <label for="surname">Surname:</label>
                <input type="text" id="surname" name="surname" required>
            </div>
            <div class="form-group">
                <label for="city">City:</label>
                <input type="text" id="city" name="city" required>
            </div>
            <div class="form-group">
                <label for="university">University:</label>
                <input type="text" id="university" name="university" required>
            </div>
            <div class="form-group">
                <button type="submit">Submit</button>
            </div>
        </form>
    </div>

    <%!
        // Database connection details
        final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
        final String DB_URL = "jdbc:mysql://localhost:3306/swing_demo";
        final String USER = "root";
        final String PASS = "root";

        // Method to insert data into the database
        private void insertTestData(String name, String surname, String city, String university) {
            Connection conn = null;
            PreparedStatement statement = null;

            try {
                // Register JDBC driver
                Class.forName(JDBC_DRIVER);

                // Open a connection to the database
                conn = DriverManager.getConnection(DB_URL, USER, PASS);

                // Prepare the SQL statement
                String sql = "INSERT INTO testable (Name, Surname, City, University) VALUES (?, ?, ?, ?)";
                statement = conn.prepareStatement(sql);
                statement.setString(1, name);
                statement.setString(2, surname);
                statement.setString(3, city);
                statement.setString(4, university);

                // Execute the statement
                statement.executeUpdate();
            } catch (ClassNotFoundException | SQLException e) {
                e.printStackTrace();
            } finally {
                // Close the statement and connection
                if (statement != null) {
                    try {
                        statement.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }

                if (conn != null) {
                    try {
                        conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            }
        }
    %>

    <%-- Handle form submission --%>
    <% if (request.getMethod().equalsIgnoreCase("post")) {
            String name = request.getParameter("name");
            String surname = request.getParameter("surname");
            String city = request.getParameter("city");
            String university = request.getParameter("university");

            // Insert the data into the database
            insertTestData(name, surname, city, university);
        }
    %>
</body>
</html>
