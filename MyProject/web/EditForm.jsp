<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Edit Request</title>
        <style>
            body {
                font-family: 'Poppins', sans-serif;
                background-color: #eef8f6;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                margin: 0;
            }
            .container {
                width: 350px;
                background: white;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            }
            h2 {
                text-align: center;
                font-size: 20px;
                margin-bottom: 15px;
                color: #007bff;
            }
            .field {
                margin-bottom: 12px;
                display: flex;
                flex-direction: column;
                text-align: left;
            }
            .field label {
                font-weight: bold;
                margin-bottom: 5px;
                font-size: 14px;
            }
            .field input,
            .field textarea {
                padding: 6px;
                font-size: 14px;
                border: 1px solid #ddd;
                border-radius: 5px;
            }
            .button-group {
                display: flex;
                justify-content: space-between;
                margin-top: 15px;
            }
            .button-group button {
                background-color: #3b6cc2;
                color: white;
                border: none;
                padding: 8px 16px;
                font-size: 14px;
                font-weight: bold;
                border-radius: 5px;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }
            .button-group button:hover {
                background-color: #2a5298;
            }
            .cancel-button {
                background-color: #ccc;
            }
            .cancel-button:hover {
                background-color: #aaa;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Chỉnh sửa đơn nghỉ phép</h2>
            <form action="Edit" method="POST">
                <!-- Ẩn ID để gửi sang servlet -->
                <input type="hidden" name="id" value="${request.getId()}" />
                
                <div class="field">
                    <label>Từ ngày:</label>
                    <input type="date" name="dateFrom" value="${request.getDateFrom()}" required />
                </div>
                <div class="field">
                    <label>Tới ngày:</label>
                    <input type="date" name="dateTo" value="${request.getDateTo()}" required />
                </div>
                <div class="field">
                    <label>Lý do (Title):</label>
                    <textarea name="reason" rows="4" required>${request.getReaason()}</textarea>
                </div>
                <div class="button-group">
                    <button type="submit">Update</button>
                    <button type="button" class="cancel-button" onclick="window.location.href='View'">Cancel</button>
                </div>
            </form>
        </div>
    </body>
</html>
