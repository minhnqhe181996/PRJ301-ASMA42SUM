<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #f4f4f4;
        }
        .login-container {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 300px;
            text-align: center;
        }
        input {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .btn {
            width: 100%;
            padding: 10px;
            background-color: #0073b1;
            color: white;
            border: none;
            cursor: pointer;
            border-radius: 5px;
        }
        .btn:hover {
            background-color: #005582;
        }
        .error {
            color: red;
            font-size: 14px;
        }
    </style>
    <body>
        <div class="login-container">
        <h2>Login</h2>
        <% String error = request.getParameter("error"); %>
        <% if (error != null) { %>
            <p class="error">Sai thông tin đăng nhập. Vui lòng thử lại.</p>
        <% } %>
        <form action="login" method="POST">
            <input type="text" name="username" placeholder="User" required>
            <input type="password" name="password" placeholder="Password" required>
            <button type="submit" class="btn">Sign in</button>
        </form>
    </div>
    </body>
</html>
