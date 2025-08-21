<%-- 
    Document   : sessionCounter
    Created on : Jul 21, 2025, 6:33:30 AM
    Author     : quang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Session Counter</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 40px;
                background-color: #f4f4f4;
            }
            .container {
                background: white;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0,0,0,0.1);
                max-width: 600px;
                margin: 0 auto;
            }
            h1 {
                color: #333;
                text-align: center;
                margin-bottom: 30px;
            }
            .counter-box {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                padding: 30px;
                border-radius: 10px;
                text-align: center;
                margin: 20px 0;
            }
            .counter-number {
                font-size: 48px;
                font-weight: bold;
                margin: 10px 0;
            }
            .counter-label {
                font-size: 18px;
                opacity: 0.9;
            }
            .stats-grid {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 20px;
                margin: 30px 0;
            }
            .stat-item {
                background: #f8f9fa;
                padding: 20px;
                border-radius: 8px;
                text-align: center;
                border-left: 4px solid #007bff;
            }
            .stat-number {
                font-size: 24px;
                font-weight: bold;
                color: #007bff;
            }
            .stat-label {
                color: #666;
                margin-top: 5px;
            }
            .links {
                text-align: center;
                margin-top: 30px;
            }
            .links a {
                display: inline-block;
                margin: 0 10px;
                padding: 10px 20px;
                background: #007bff;
                color: white;
                text-decoration: none;
                border-radius: 5px;
                transition: background 0.3s;
            }
            .links a:hover {
                background: #0056b3;
            }
            .refresh-btn {
                background: #28a745 !important;
            }
            .refresh-btn:hover {
                background: #1e7e34 !important;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>🔢 Bộ Đếm Phiên Làm Việc</h1>
            
            <div class="counter-box">
                <div class="counter-label">Số lượng phiên làm việc hiện tại</div>
                <div class="counter-number">
                    <%
                        Integer currentUsers = (Integer) application.getAttribute("currentusers");
                        Integer totalUsers = (Integer) application.getAttribute("totalusers");
                        
                        if (currentUsers == null) currentUsers = 0;
                        if (totalUsers == null) totalUsers = 0;
                    %>
                    <%= currentUsers %>
                </div>
            </div>
            
            <div class="stats-grid">
                <div class="stat-item">
                    <div class="stat-number"><%= currentUsers %></div>
                    <div class="stat-label">Người dùng hiện tại</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number"><%= totalUsers %></div>
                    <div class="stat-label">Tổng số người dùng</div>
                </div>
            </div>
            
            <div class="links">
                <a href="sessionCounter.jsp" class="refresh-btn">🔄 Làm mới</a>
                <a href="index.html">🏠 Trang chủ</a>
                <a href="javascript:history.back()">⬅️ Quay lại</a>
            </div>
            
            <div style="margin-top: 30px; text-align: center; color: #666; font-size: 14px;">
                <p>💡 <strong>Lưu ý:</strong> Số liệu được cập nhật tự động khi có người dùng đăng nhập hoặc đăng xuất.</p>
            </div>
        </div>
    </body>
</html>
