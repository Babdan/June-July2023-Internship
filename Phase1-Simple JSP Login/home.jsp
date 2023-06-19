<%-- /Tomcat-install-dir/webapps/SCADAProject/home.jsp --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<html>
    <head>
        <style>
            body {font-family: Arial, sans-serif; margin: 0; padding: 0; background-color: #f0f0f0;}
            .navbar {background-color: #333; overflow: hidden; position: sticky; top: 0; width: 100%;}
            .navbar a {float: right; display: block; color: #f2f2f2; text-align: center; padding: 14px 16px; text-decoration: none; font-size: 18px; border: 2px solid #721c24; border-radius: 5px; background-color: #721c24;}
            .navbar a:hover {background-color: #ddd; color: black;}
            .content {padding: 20px;}
        </style>
    </head>
    <body>
        <div class="navbar">
            <a href="logout.jsp">Logout</a>
        </div>
        <div class="content">
            <h1>Hello World!</h1>
        </div>
    </body>
</html>
