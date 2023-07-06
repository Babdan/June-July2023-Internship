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
    <title>Home</title>
</head>
<body>
    <h1>Login Successful</h1>
</body>
</html>
