<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.ServletException" %>
<%@ page import="jakarta.servlet.http.HttpServlet" %>
<%@ page import="jakarta.servlet.http.HttpServletRequest" %>
<%@ page import="jakarta.servlet.http.HttpServletResponse" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link href="assets/img/apple-touch-icon.png" rel="apple-touch-icon">

<!-- Google Fonts -->
<link href="https://fonts.gstatic.com" rel="preconnect">
<link
	href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i"
	rel="stylesheet">

<!-- Vendor CSS Files -->
<link href="assets/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
<link href="assets/vendor/bootstrap-icons/bootstrap-icons.css"
	rel="stylesheet">
<link href="assets/vendor/boxicons/css/boxicons.min.css"
	rel="stylesheet">
<link href="assets/vendor/quill/quill.snow.css" rel="stylesheet">
<link href="assets/vendor/quill/quill.bubble.css" rel="stylesheet">
<link href="assets/vendor/remixicon/remixicon.css" rel="stylesheet">
<link href="assets/vendor/simple-datatables/style.css" rel="stylesheet">

<!-- Template Main CSS File -->
<link href="assets/css/style.css" rel="stylesheet">
    <title>SCADA Login</title>
    
<style>
    body {
        background-color: #f2f2f2;
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
    }
    
    h1 {
        color: #333333;
        text-align: center;
        margin-top: 30px;
    }
    
    .container {
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        height: 100vh;
    }
    
    form {
        background-color: #ffffff;
        padding: 20px;
        border-radius: 5px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }
    
    table {
        margin: 0 auto;
    }
    
    input[type="text"],
    input[type="password"] {
        padding: 10px;
        width: 200px;
        border-radius: 3px;
        border: 1px solid #cccccc;
    }

</style>
</head>
<body>

<%
    // Check if the user is already logged in
    boolean isUserLoggedIn = false;
    HttpSession existingSession = request.getSession(false);
    if (existingSession != null && existingSession.getAttribute("loggedIn") != null && (boolean) existingSession.getAttribute("loggedIn")) {
        isUserLoggedIn = true;
    }

    // If the user is already logged in, redirect to the home.jsp page
    if (isUserLoggedIn) {
        response.sendRedirect("home.jsp");
    } else {
%>

<div class="container">
    <h1>Please Sign In</h1>
    <form action="LoginServlet" method="post">
        <table>
            <tr>
                <td>Username:  </td>
                <td><input type="text" name="txtName"></td>
            </tr>
            <tr>
                <td>Password:  </td>
                <td><input type="password" name="txtPwd"></td>
            </tr>
            <tr>
                <td colspan="2">
                    <input type="submit" class="btn btn-primary" value="Login">
                    <input type="reset" class="btn btn-secondary">
                </td>
            </tr>
        </table>
    </form>
</div>

<%
    }
%>

</body>
</html>
