<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Đơn xin nghỉ phép</title>
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
            .btn-back {
                position: absolute;
                top: 20px;
                right: 20px;
                background-color: #007bff;
                color: white;
                border: none;
                padding: 10px 20px;
                font-size: 16px;
                font-weight: bold;
                border-radius: 5px;
                cursor: pointer;
                box-shadow: 2px 2px 8px rgba(0, 0, 0, 0.1);
                transition: background-color 0.3s ease;
            }
            .btn-back:hover {
                background-color: #0056b3;
            }
            .form-container {
                background: white;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
                width: 400px;
                text-align: left;
            }
            .form-container h2 {
                text-align: center;
                color: #007bff;
                margin-bottom: 20px;
            }
            .form-container label {
                font-weight: bold;
                display: block;
                margin-top: 10px;
            }
            .form-container input,
            .form-container textarea {
                width: 100%;
                padding: 8px;
                margin-top: 5px;
                border: 1px solid #ddd;
                border-radius: 5px;
                font-size: 14px;
            }
            .form-container textarea {
                height: 80px;
                resize: none;
            }
            .submit-btn {
                background-color: #007bff;
                color: white;
                border: none;
                padding: 10px 20px;
                font-size: 16px;
                border-radius: 5px;
                cursor: pointer;
                margin-top: 15px;
                width: 100%;
                transition: background-color 0.3s ease;
            }
            .submit-btn:hover {
                background-color: #0056b3;
            }
            .error-list {
                color: red;
                margin-top: 10px;
                font-size: 14px;
            }
            .error-list ul {
                margin: 0;
                padding-left: 20px;
            }
        </style>
    </head>
    <body>
        <button class="btn-back" onclick="window.history.back();">Quay lại</button>
        <div class="form-container">
            <h2>Đơn xin nghỉ phép</h2>
            <form action="Request" method="post">
                <label for="from-date">Từ ngày:</label>
                <input type="date" id="from-date" name="fromDate" required>
                
                <label for="to-date">Tới ngày:</label>
                <input type="date" id="to-date" name="toDate" required>
                
                <label for="reason">Lý do:</label>
                <textarea id="reason" name="reason" required></textarea>
                
                <button type="submit" class="submit-btn">Gửi</button>
            </form>
            <c:if test="${not empty error}">
                <div class="error-list">
                    <ul>
                        <c:forEach var="err" items="${error}">
                            <li>${err}</li>
                        </c:forEach>
                    </ul>
                </div>
            </c:if>
        </div>
    </body>
</html>
