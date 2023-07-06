<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Index Page</title>
    <style>
        body {
            background-color: #f2f2f2;
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }

        .container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .message {
            text-align: center;
            font-size: 24px;
            color: #333333;
            margin-bottom: 20px;
        }

        .redirect-link {
            display: inline-block;
            padding: 10px 20px;
            background-color: #4caf50;
            color: #ffffff;
            text-decoration: none;
            border-radius: 3px;
            transition: background-color 0.3s ease;
        }

        .redirect-link:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="message">
            If you see this page, the redirection didn't work correctly.<br>
            Please click <a class="redirect-link" href="login.jsp">here</a> to redirect manually.
        </div>
    </div>

    <script>
        setTimeout(function () {
            window.location.href = "login.jsp";
        }, 3000);
    </script>
</body>
</html>
