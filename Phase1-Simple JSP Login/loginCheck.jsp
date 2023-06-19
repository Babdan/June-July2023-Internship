<%-- /Tomcat-install-dir/webapps/SCADAProject/loginCheck.jsp --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String user = request.getParameter("username");    
    String pass = request.getParameter("password");

    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/scadaproject", "root", "root");
    Statement st = conn.createStatement();
    ResultSet rs; 

    rs = st.executeQuery("SELECT * FROM users WHERE username='" + user + "' AND password=SHA2('" + pass + "', 256)");
    if (rs.next()) {
        session.setAttribute("username", user);
        response.sendRedirect("home.jsp");
    } else {
%>
        <html>
            <head>
                <style>
                    body {font-family: Arial, sans-serif; margin: 0; padding: 0; background-color: #f0f0f0;}
                    .error-message {width: 300px; margin: 50px auto; padding: 20px; background-color: #f8d7da; color: #721c24; text-align: center; border: 1px solid #f5c6cb; border-radius: 5px;}
                    .error-message a {color: #721c24; text-decoration: none;}
                    .error-message button {background-color: #721c24; color: white; border: none; padding: 10px 20px; margin-top: 10px; cursor: pointer; border-radius: 5px;}
                </style>
            </head>
            <body>
                <div class="error-message">
                    <p>Invalid username or password.</p>
                    <button onclick="window.location.href='login.jsp'">Go back to login</button>
                </div>
            </body>
        </html>
<%
    }
%>
