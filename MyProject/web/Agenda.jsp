<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Lịch làm việc</title>
        <style>
            body {
                background-color: #C0E5E3; /* Màu xanh ngọc */
                font-family: Arial, sans-serif;
                text-align: center;
            }
            .btn-back {
                position: absolute;
                top: 20px;
                right: 20px;
                background-color: #3b6cc2;
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
                background-color: #2a5298;
            }
            .filter-form {
                margin: 20px;
            }
            .filter-form input, .filter-form button {
                padding: 8px;
                margin: 5px;
            }
            table {
                border-collapse: collapse;
                width: 80%;
                margin: 20px auto;
                background: white;
                box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.2);
                border-radius: 8px;
            }
            th, td {
                border: 1px solid black;
                padding: 10px;
                text-align: center;
            }
            th {
                background-color: #f2f2f2;
            }
            .available {
                background-color: green;
                color: white;
            }
            .unavailable {
                background-color: red;
                color: white;
            }
        </style>
    </head>
    <body>
        <button class="btn-back" onclick="window.history.back();">Quay lại</button>
        <h2>Lịch làm việc (Tuần ${weekNumber}, Năm ${year})</h2>
        
        <!-- Form lọc theo khoảng ngày -->
        <form class="filter-form" action="agenda" method="get">
            <input type="hidden" name="weekNumber" value="${weekNumber}">
            <input type="hidden" name="year" value="${year}">
            <label for="fromDate">Từ ngày:</label>
            <input type="date" name="fromDate" id="fromDate" value="${fromDate}">
            <label for="toDate">Đến ngày:</label>
            <input type="date" name="toDate" id="toDate" value="${toDate}">
            <button type="submit">Lọc</button>
        </form>
        
        <table id="scheduleTable">
            <tr>
                <th>Nhân sự</th>
                <!-- Hiển thị tiêu đề theo các ngày trong tuần -->
                <c:forEach var="day" items="${weekDays}">
                    <th>${day}</th>
                </c:forEach>
            </tr>
            <!-- Duyệt qua danh sách nhân viên -->
            <c:forEach var="employee" items="${employees}">
                <tr>
                    <td>${employee.name}</td>
                    <!-- Với mỗi ngày, hiển thị trạng thái: V (đi làm) hoặc X (nghỉ) -->
                    <c:forEach var="day" items="${weekDays}">
                        <c:set var="status" value="${attendanceMap[employee.id][day]}" />
                        <td class="<c:out value='${status == "V" ? "available" : (status == "X" ? "unavailable" : "")}'/>">
                            <c:choose>
                                <c:when test="${status == 'V'}">V</c:when>
                                <c:when test="${status == 'X'}">X</c:when>
                                <c:otherwise>-</c:otherwise>
                            </c:choose>
                        </td>
                    </c:forEach>
                </tr>
            </c:forEach>
        </table>
    </body>
</html>
