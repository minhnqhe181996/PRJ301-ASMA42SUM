<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Chi tiết đơn nghỉ</title>
        <style>
            body {
                font-family: 'Poppins', sans-serif;
                background-color: #eef8f6;
                padding: 20px;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                margin: 0;
            }
            .container {
                width: 350px;
                background: white;
                padding: 15px;
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }
            h2 {
                text-align: center;
                font-size: 20px;
                margin-bottom: 15px;
                color: #007bff;
            }
            .field {
                margin-bottom: 10px;
                font-size: 14px;
                display: flex;
                justify-content: space-between;
                padding: 5px;
                border-bottom: 1px solid #ddd;
            }
            /* Dành riêng cho field cần hiển thị nội dung nhiều dòng */
            .field-multiline {
                flex-direction: column;
                align-items: flex-start;
            }
            .field label {
                font-weight: bold;
                color: #333;
            }
            .status-pending {
                color: #e67e22;
                font-weight: bold;
            }
            .status-rejected {
                color: #e74c3c;
                font-weight: bold;
            }
            .status-approved {
                color: #2ecc71;
                font-weight: bold;
            }
            .back-link {
                text-align: center;
                margin-top: 15px;
            }
            .back-link a {
                text-decoration: none;
                color: white;
                background: #007bff;
                padding: 8px 16px;
                border-radius: 5px;
                font-size: 14px;
                font-weight: bold;
                display: inline-block;
                transition: background 0.3s ease;
            }
            .back-link a:hover {
                background: #0056b3;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Chi tiết đơn nghỉ</h2>
            <c:if test="${detail != null}">
                <div class="field">
                    <label>Từ ngày:</label>
                    <span>${detail.getDateFrom()}</span>
                </div>
                <div class="field">
                    <label>Tới ngày:</label>
                    <span>${detail.getDateTo()}</span>
                </div>
                <div class="field">
                    <label>Ngày tạo:</label>
                    <span>${detail.getDateCreate()}</span>
                </div>
                <div class="field field-multiline">
                    <label>Lý do:</label>
                    <span style="white-space: pre-wrap;">${detail.getReaason()}</span>
                </div>
                <div class="field">
                    <label>Trạng thái:</label>
                    <c:choose>
                        <c:when test="${detail.getStatus() eq 'Pending'}">
                            <span class="status-pending">Pending</span>
                        </c:when>
                        <c:when test="${detail.getStatus() eq 'Rejected'}">
                            <span class="status-rejected">Rejected</span>
                        </c:when>
                        <c:otherwise>
                            <span class="status-approved">${detail.getStatus()}</span>
                        </c:otherwise>
                    </c:choose>
                </div>
            </c:if>
            <c:if test="${empty detail}">
                <p style="color: red; text-align: center; font-size: 16px;">Không tìm thấy đơn nghỉ phép.</p>
            </c:if>
            <div class="back-link">
                <a href="View">Quay lại</a>
            </div>
        </div>
    </body>
</html>
