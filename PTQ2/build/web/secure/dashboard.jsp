<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Dashboard - Trang được bảo vệ</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 20px;
                background-color: #f4f4f4;
            }
            .dashboard-container {
                max-width: 800px;
                margin: 50px auto;
                padding: 30px;
                background: white;
                border-radius: 8px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            }
            .welcome-message {
                background-color: #d4edda;
                color: #155724;
                padding: 15px;
                border-radius: 4px;
                margin-bottom: 20px;
                border: 1px solid #c3e6cb;
            }
            .logout-btn {
                background-color: #dc3545;
                color: white;
                padding: 10px 20px;
                text-decoration: none;
                border-radius: 4px;
                display: inline-block;
                margin-top: 20px;
            }
            .logout-btn:hover {
                background-color: #c82333;
            }
            .info-box {
                background-color: #e7f3ff;
                border: 1px solid #b3d9ff;
                padding: 15px;
                border-radius: 4px;
                margin: 20px 0;
            }
        </style>
    </head>
    <body>
        <div class="dashboard-container">
            <h1>Dashboard - Trang được bảo vệ</h1>
            
            <div class="welcome-message">
                <h2>Chào mừng, <%= session.getAttribute("loggedInUser") %>!</h2>
                <p>Bạn đã đăng nhập thành công và có thể truy cập trang này.</p>
            </div>
            
            <div class="info-box">
                <h3>Thông tin về Filter:</h3>
                <ul>
                    <li>Trang này được bảo vệ bởi AuthenticationFilter</li>
                    <li>Chỉ người dùng đã đăng nhập mới có thể truy cập</li>
                    <li>Filter kiểm tra thuộc tính "loggedInUser" trong session</li>
                    <li>Nếu chưa đăng nhập, sẽ tự động chuyển hướng về trang login.jsp</li>
                </ul>
            </div>
            
            <div class="info-box">
                <h3>Test Filter:</h3>
                <p>Để test filter hoạt động:</p>
                <ol>
                    <li>Đóng trình duyệt hoặc xóa session</li>
                    <li>Truy cập lại trang này: <code>/secure/dashboard.jsp</code></li>
                    <li>Bạn sẽ được chuyển hướng về trang đăng nhập</li>
                    <li>Đăng nhập lại với username: admin, password: 123</li>
                    <li>Sau đó có thể truy cập trang này bình thường</li>
                </ol>
            </div>
            
            <a href="../index.html" class="logout-btn">Về trang chủ</a>
        </div>
    </body>
</html> 