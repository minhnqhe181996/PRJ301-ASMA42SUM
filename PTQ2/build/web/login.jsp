<%-- 
    Document   : login
    Created on : Jul 20, 2025, 10:07:30 PM
    Author     : quang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Đăng nhập</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 20px;
                background-color: #f4f4f4;
            }
            .login-container {
                max-width: 400px;
                margin: 50px auto;
                padding: 20px;
                background: white;
                border-radius: 8px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            }
            .error-message {
                color: red;
                margin-bottom: 15px;
                padding: 10px;
                background-color: #ffe6e6;
                border: 1px solid #ff9999;
                border-radius: 4px;
            }
            table {
                width: 100%;
            }
            td {
                padding: 8px;
            }
            input[type="text"], input[type="password"] {
                width: 100%;
                padding: 8px;
                border: 1px solid #ddd;
                border-radius: 4px;
                box-sizing: border-box;
            }
            input[type="submit"] {
                background-color: #4CAF50;
                color: white;
                padding: 10px 20px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }
            input[type="submit"]:hover {
                background-color: #45a049;
            }
        </style>
    </head>
    <body>
        <div class="login-container">
            <h2>Đăng nhập hệ thống</h2>

            <% if (request.getAttribute("error") != null) { %>
            <div class="error-message">
                <%= request.getAttribute("error") %>
            </div>
            <% } %>

            <form action="login" method="post">
                <table>
                    <tr>
                        <td>Tên đăng nhập: </td>
                        <td><input type="text" name="username" required></td>
                    </tr>
                    <tr>
                        <td>Mật khẩu: </td>
                        <td><input type="password" name="password" required></td>
                    </tr>
                    <tr>
                        <td colspan="2" style="text-align: center;">
                            <input type="submit" value="ĐĂNG NHẬP">
                        </td>
                    </tr>
                </table>
            </form>


        </div>
    </body>
</html>
