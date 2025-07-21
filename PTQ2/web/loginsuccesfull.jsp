<%-- 
    Document   : loginsuccesfull
    Created on : Jul 21, 2025, 8:14:38 AM
    Author     : quang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Trang chủ - Hệ thống đăng nhập</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 20px;
                background-color: #f4f4f4;
            }
            .container {
                max-width: 800px;
                margin: 50px auto;
                padding: 30px;
                background: white;
                border-radius: 8px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                text-align: center;
            }
            .success-message {
                background-color: #d4edda;
                color: #155724;
                padding: 20px;
                border-radius: 4px;
                margin-bottom: 30px;
                border: 1px solid #c3e6cb;
            }
            .btn {
                display: inline-block;
                padding: 12px 24px;
                margin: 10px;
                text-decoration: none;
                border-radius: 4px;
                font-weight: bold;
            }
            .btn-primary {
                background-color: #007bff;
                color: white;
            }
            .btn-primary:hover {
                background-color: #0056b3;
            }
            .btn-success {
                background-color: #28a745;
                color: white;
            }
            .btn-success:hover {
                background-color: #1e7e34;
            }
            .btn-danger {
                background-color: #dc3545;
                color: white;
            }
            .btn-danger:hover {
                background-color: #c82333;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="success-message">
                <h1>🎉 Đăng nhập thành công!</h1>
                <p>Chào mừng bạn đến với hệ thống quản lý.</p>
            </div>
            
            <h2>Các tính năng có sẵn:</h2>
            
            <div>
                <a href="secure/dashboard.jsp" class="btn btn-primary">
                    📊 Truy cập Dashboard (Trang được bảo vệ)
                </a>
            </div>
            
            <div>
                <a href="login.jsp" class="btn btn-success">
                    🔐 Đăng nhập lại
                </a>
            </div>
            
            <div style="margin-top: 30px;">
                <h3>Hướng dẫn test Filter:</h3>
                <ol style="text-align: left; max-width: 600px; margin: 0 auto;">
                    <li>Click vào "Truy cập Dashboard" để vào trang được bảo vệ</li>
                    <li>Đóng trình duyệt hoặc xóa session</li>
                    <li>Truy cập trực tiếp: <code>/secure/dashboard.jsp</code></li>
                    <li>Bạn sẽ được chuyển hướng về trang đăng nhập</li>
                    <li>Đăng nhập lại với username: <strong>admin</strong>, password: <strong>123</strong></li>
                </ol>
            </div>
        </div>
    </body>
</html>
