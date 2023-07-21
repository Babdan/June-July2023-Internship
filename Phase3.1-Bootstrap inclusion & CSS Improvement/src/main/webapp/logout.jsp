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
    <title>Logout</title>
</head>
<body>
    <% 
        // Invalidate the session to log out the user
        HttpSession sessionToInvalidate = request.getSession(false);
        if (sessionToInvalidate != null) {
            sessionToInvalidate.invalidate();
        }
        
        // Redirect the user to the login page
        response.sendRedirect("login.jsp");
    %>
</body>
</html>
