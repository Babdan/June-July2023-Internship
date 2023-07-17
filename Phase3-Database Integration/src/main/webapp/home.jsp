<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>

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
    } else {
        // Connect to the database
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/swing_demo", "root", "root");

            String sql = "SELECT * FROM testable";
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
%>
<!DOCTYPE html>
<html>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f1f1f1;
        }
        
        nav {
            background-color: #333333;
            padding: 10px;
            color: #ffffff;
        }
        
        nav ul {
            margin: 0;
            padding: 0;
            list-style-type: none;
            display: flex;
            justify-content: space-between;
        }
        
        nav li {
            display: inline;
            margin-right: 10px;
        }
        
        h2 {
            margin-top: 20px;
            color: #333333;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
        }
        
        th, td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        
        tr:hover {
            background-color: #ddd;
        }
        
        .refresh-interval {
            display: flex;
            align-items: center;
            margin-top: 20px;
        }
        
        .refresh-interval label {
            margin-right: 10px;
            color: #666666;
        }
        
        .refresh-interval input[type="number"] {
            padding: 5px;
            width: 80px;
            border-radius: 3px;
            border: 1px solid #cccccc;
        }
        
        .refresh-interval button {
            padding: 5px 10px;
            background-color: #4caf50;
            color: #ffffff;
            border: none;
            border-radius: 3px;
            cursor: pointer;
        }
        
        .refresh-interval button:hover {
            background-color: #45a049;
        }
        .countdown {
            font-size: 24px;
            color: #333;
            margin-bottom: 20px;
            text-align: right;
            flex-grow: 1;
          }

        .reset-button {
            background-color: #ffa500;
            color: #ffffff;
            padding: 5px 10px;
            border: none;
            border-radius: 3px;
            cursor: pointer;
        }

        .reset-button:hover {
            background-color: #ff8c00;
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
<head>
    <meta charset="UTF-8">
    <title>Home</title>
<script>
var countdownInterval;

function setRefreshInterval() {
    var intervalInput = document.getElementById("refreshInterval");
    var interval = parseInt(intervalInput.value);
    if (isNaN(interval) || interval <= 0) {
        alert("Please enter a valid refresh interval in seconds.");
        return;
    }
    clearInterval(countdownInterval);
    var refreshURL = "home.jsp?refreshInterval=" + interval;
    window.location.href = refreshURL;
}

function startCountdown() {
    var count = <%= request.getParameter("refreshInterval") %>;
    var countDisplay = document.getElementById("countdown");
    countdownInterval = setInterval(function() {
        count--;
        if (count >= 0) {
            countDisplay.innerText = count;
        } else {
            window.location.reload();
        }
    }, 1000);
}

function resetTimer() {
    clearInterval(countdownInterval);
    var intervalInput = document.getElementById("refreshInterval");
    intervalInput.value = "";
    var refreshURL = "home.jsp?refreshInterval=0";
    window.location.href = refreshURL;
}

    window.onload = function() {
        var refreshInterval = <%= request.getParameter("refreshInterval") %>;
        if (refreshInterval > 0) {
            startCountdown();
        }
    };
</script>

</head>
<body>
    <nav>
        <ul>
            <li>Logged-In Successfully</li>
            <li>
                <a href="#" class="home-button" onclick="openWindow()">Diagnostics</a>
<script>
function openWindow() {
    var windowFeatures = "width=420,height=600";
    var newWindow = window.open("test.jsp", "_blank", windowFeatures);
    newWindow.focus();
}
</script>
            </li>
            <li>
                <% if (isLoggedIn) { %>
                <a href="logout.jsp" style="background-color: red; color: white; padding: 10px; border-radius: 5px; text-decoration: none;">Logout</a>
                <% } %>
            </li>
        </ul>
    </nav>
    <h2>Data from Database</h2>
    
    <div class="refresh-interval">
        <label for="refreshInterval">Refresh Interval (seconds):</label>
        <input type="number" id="refreshInterval" name="refreshInterval" min="1" value="<%= request.getParameter("refreshInterval") %>">
        <button onclick="setRefreshInterval()">Set Refresh Interval</button>
        <div class="countdown">Countdown: <span id="countdown"></span></div>
        <button class="reset-button" onclick="resetTimer()">Reset Timer</button>
    </div>

    <table>
        <thead>
            <tr>
                <th>Name</th>
                <th>Surname</th>
                <th>City</th>
                <th>University</th>
            </tr>
        </thead>
        <tbody>
            <% while (rs.next()) { %>
            <tr>
                <td><%= rs.getString("Name") %></td>
                <td><%= rs.getString("Surname") %></td>
                <td><%= rs.getString("City") %></td>
                <td><%= rs.getString("University") %></td>
            </tr>
            <% } %>
        </tbody>
    </table>
</body>
</html>
<%
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Close the database resources
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>
