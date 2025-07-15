<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Xét Duyệt Đơn</title>
        <style>
            /* Phong cách tổng thể */
            body {
                font-family: 'Poppins', sans-serif;
                background-color: #eef8f6;
                margin: 0;
                padding: 0;
                font-size: 13px; 
            }
            /* Container căn giữa */
            .container {
                width: 70%;
                margin: 0 auto;
                position: relative; 
                padding-top: 20px;
            }
            .btn-back {
                position: absolute;
                top: 0;
                left: 0;
                background-color: #007bff;
                color: white;
                border: none;
                padding: 8px 14px;
                font-size: 12px;
                font-weight: bold;
                border-radius: 5px;
                cursor: pointer;
                transition: background-color 0.3s ease;
                margin: 10px;
            }
            .btn-back:hover {
                background-color: #0056b3;
            }
            /* Tiêu đề trang */
            h2 {
                margin-top: 50px; 
                color: #007bff;
                font-size: 18px;
                text-align: center; 
            }
            /* Bảng */
            table {
                width: 100%;
                max-width: 600px; /* Giảm kích thước bảng */
                margin: 15px auto;
                border-collapse: collapse;
                border-radius: 10px;
                overflow: hidden;
                background: white;
                box-shadow: 0 3px 8px rgba(0, 0, 0, 0.1);
            }
            th, td {
                border: 1px solid #ddd;
                padding: 6px; /* Giảm padding */
                font-size: 11px; /* Giảm kích thước chữ trong bảng */
                text-align: center;
            }
            th {
                background-color: #007bff;
                color: white;
                font-weight: bold;
            }
            tr:nth-child(even) {
                background-color: #f2f2f2;
            }
            tr:hover {
                background-color: #e9ecef;
            }
            /* Nút hành động Approve / Reject */
            .action-button {
                padding: 5px 10px;
                margin: 0 3px;
                cursor: pointer;
                border: none;
                border-radius: 5px;
                font-weight: bold;
                font-size: 12px;
                transition: background-color 0.3s ease;
            }
            .approve {
                background-color: #4caf50;
                color: white;
            }
            .approve:hover {
                background-color: #388e3c;
            }
            .reject {
                background-color: #f44336;
                color: white;
            }
            .reject:hover {
                background-color: #d32f2f;
            }
        </style>
    </head>
    <body>
        <!-- Nút quay lại -->
        <button class="btn-back" onclick="window.location.href='http://localhost:8080/ASMPRJ2/home'">
            Quay lại
        </button>
        <div class="container">
            <h2>Danh sách đơn cần xét duyệt</h2>
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Ngày tạo</th>
                        <th>Ngày bắt đầu</th>
                        <th>Ngày kết thúc</th>
                        <th>Lý do</th>
                        <th>Trạng thái</th>
                        <th>Id nhân viên</th>
                        <th>Tên nhân viên</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="req" items="${requests}">
    <c:if test="${req.getStatus() eq 'Pending'}">
        <tr>
            <td>${req.getId()}</td>
            <td style="white-space: nowrap;">${req.getDateCreate()}</td>
            <td style="white-space: nowrap;">${req.getDateFrom()}</td>
            <td style="white-space: nowrap;">${req.getDateTo()}</td>
            <td>${req.getReason()}</td>
            <td>${req.getStatus()}</td>
            <td>${req.geteId()}</td>
            <td>${req.geteName()}</td>
            <td>
                <!-- Form Approve -->
                <form action="Management" method="post" style="display: inline;">
                    <input type="hidden" name="Id" value="${req.getId()}"/>
                    <input type="submit" name="status" value="Approve"
                           class="action-button approve" />
                </form>
                <!-- Form Reject -->
                <form action="Management" method="post" style="display: inline;">
                    <input type="hidden" name="Id" value="${req.getId()}"/>
                    <input type="submit" name="status" value="Reject"
                           class="action-button reject" />
                </form>
            </td>
        </tr>
    </c:if>
</c:forEach>
                </tbody>
            </table>
        </div>
    </body>
</html>
