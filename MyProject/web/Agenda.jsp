<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Lịch làm việc</title>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <style>
            :root {
                --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                --secondary-gradient: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
                --accent-gradient: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
                --glass-bg: rgba(255, 255, 255, 0.15);
                --glass-border: rgba(255, 255, 255, 0.25);
                --text-primary: #1a1a1a;
                --text-secondary: #64748b;
                --text-light: #ffffff;
                --shadow-soft: 0 8px 32px rgba(0, 0, 0, 0.1);
                --shadow-hover: 0 12px 48px rgba(0, 0, 0, 0.15);
                --blur-amount: 20px;
                --success: #43e97b;
                --danger: #f5576c;
            }
            * { margin: 0; padding: 0; box-sizing: border-box; }
            body {
                font-family: 'Inter', sans-serif;
                min-height: 100vh;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 50%, #f093fb 100%);
                background-size: 400% 400%;
                animation: gradientShift 15s ease infinite;
                display: flex;
                justify-content: center;
                align-items: center;
                padding: 20px;
                position: relative;
                overflow: auto;
            }
            @keyframes gradientShift {
                0% { background-position: 0% 50%; }
                50% { background-position: 100% 50%; }
                100% { background-position: 0% 50%; }
            }
            body::before {
                content: '';
                position: absolute;
                top: 0; left: 0; right: 0; bottom: 0;
                background: 
                    radial-gradient(circle at 20% 20%, rgba(255,255,255,0.1) 0%, transparent 50%),
                    radial-gradient(circle at 80% 80%, rgba(255,255,255,0.1) 0%, transparent 50%),
                    radial-gradient(circle at 40% 60%, rgba(255,255,255,0.05) 0%, transparent 50%);
                animation: floatingOrbs 20s linear infinite;
                z-index: 0;
            }
            @keyframes floatingOrbs {
                0% { transform: translateY(0px) rotate(0deg); }
                50% { transform: translateY(-20px) rotate(180deg); }
                100% { transform: translateY(0px) rotate(360deg); }
            }
            .main-container {
                background: var(--glass-bg);
                border: 1px solid var(--glass-border);
                backdrop-filter: blur(var(--blur-amount));
                border-radius: 24px;
                box-shadow: var(--shadow-soft);
                padding: 38px 24px 32px 24px;
                width: 100%;
                max-width: 900px;
                position: relative;
                z-index: 1;
                animation: containerFadeIn 1s cubic-bezier(0.4, 0, 0.2, 1);
            }
            @keyframes containerFadeIn {
                from {
                    opacity: 0;
                    transform: translateY(40px) scale(0.95);
                    filter: blur(10px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0) scale(1);
                    filter: blur(0);
                }
            }
            .agenda-header {
                text-align: center;
                margin-bottom: 32px;
                position: relative;
            }
            .agenda-header::before {
                content: '';
                position: absolute;
                top: -20px;
                left: 50%;
                transform: translateX(-50%);
                width: 60px;
                height: 4px;
                background: var(--accent-gradient);
                border-radius: 2px;
                animation: headerGlow 2s ease-in-out infinite alternate;
            }
            @keyframes headerGlow {
                from { opacity: 0.6; transform: translateX(-50%) scaleX(1); }
                to { opacity: 1; transform: translateX(-50%) scaleX(1.2); }
            }
            .agenda-header h2 {
                font-size: 28px;
                font-weight: 700;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
                margin-bottom: 8px;
                letter-spacing: -0.5px;
            }
            .agenda-header .subtitle {
                color: var(--text-secondary);
                font-size: 15px;
                font-weight: 400;
                opacity: 0.8;
            }
            .btn-back {
                position: absolute;
                top: 24px;
                right: 24px;
                background: var(--secondary-gradient);
                color: var(--text-light);
                border: none;
                padding: 12px 20px;
                font-size: 14px;
                font-weight: 600;
                border-radius: 12px;
                cursor: pointer;
                box-shadow: var(--shadow-soft);
                transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                display: flex;
                align-items: center;
                gap: 8px;
                z-index: 2;
            }
            .btn-back:hover {
                transform: translateY(-2px);
                box-shadow: var(--shadow-hover);
            }
            .btn-back:active {
                transform: translateY(0);
                box-shadow: var(--shadow-soft);
            }
            .filter-form {
                display: flex;
                flex-wrap: wrap;
                justify-content: center;
                align-items: center;
                gap: 12px;
                margin: 18px 0 28px 0;
            }
            .filter-form label {
                color: var(--text-secondary);
                font-size: 15px;
                font-weight: 500;
            }
            .filter-form input[type="date"] {
                padding: 8px 12px;
                border-radius: 8px;
                border: 1px solid var(--glass-border);
                background: rgba(255,255,255,0.7);
                font-size: 15px;
                font-family: inherit;
                color: var(--text-primary);
                transition: border 0.2s;
            }
            .filter-form input[type="date"]:focus {
                border: 1.5px solid #667eea;
                outline: none;
            }
            .filter-form button {
                padding: 9px 20px;
                border-radius: 8px;
                border: none;
                background: var(--primary-gradient);
                color: var(--text-light);
                font-size: 15px;
                font-weight: 600;
                cursor: pointer;
                box-shadow: 0 2px 8px rgba(102, 126, 234, 0.13);
                transition: background 0.2s, transform 0.2s;
            }
            .filter-form button:hover {
                background: var(--secondary-gradient);
                transform: translateY(-2px);
            }
            .agenda-table {
                border-collapse: separate;
                border-spacing: 0;
                width: 100%;
                margin: 0 auto;
                background: rgba(255,255,255,0.85);
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.10);
                border-radius: 16px;
                overflow: hidden;
            }
            .agenda-table th, .agenda-table td {
                padding: 14px 10px;
                text-align: center;
                font-size: 15px;
            }
            .agenda-table th {
                background: var(--accent-gradient);
                color: var(--text-light);
                font-weight: 700;
                border: none;
            }
            .agenda-table tr:first-child th:first-child {
                border-top-left-radius: 16px;
            }
            .agenda-table tr:first-child th:last-child {
                border-top-right-radius: 16px;
            }
            .agenda-table tr:last-child td:first-child {
                border-bottom-left-radius: 16px;
            }
            .agenda-table tr:last-child td:last-child {
                border-bottom-right-radius: 16px;
            }
            .agenda-table td {
                background: transparent;
                border: none;
                color: var(--text-primary);
                font-weight: 500;
            }
            .agenda-table td.available {
                background: var(--success);
                color: #fff;
                font-weight: 700;
                border-radius: 8px;
            }
            .agenda-table td.unavailable {
                background: var(--danger);
                color: #fff;
                font-weight: 700;
                border-radius: 8px;
            }
            @media (max-width: 900px) {
                .main-container { padding: 18px 2vw; }
                .agenda-table th, .agenda-table td { font-size: 13px; padding: 10px 4px; }
            }
            @media (max-width: 600px) {
                .main-container { padding: 10px 2vw; }
                .agenda-header h2 { font-size: 20px; }
                .btn-back { top: 10px; right: 10px; padding: 8px 12px; font-size: 12px; }
                .filter-form { gap: 6px; }
            }
        </style>
    </head>
    <body>
        <div class="main-container">
            <button class="btn-back" onclick="window.history.back();"><i class="fas fa-arrow-left"></i> Quay lại</button>
            <div class="agenda-header">
                <h2>Lịch làm việc (Tuần ${weekNumber}, Năm ${year})</h2>
                <div class="subtitle">Theo dõi lịch làm việc và trạng thái nhân sự</div>
            </div>
            <form class="filter-form" action="agenda" method="get">
                <input type="hidden" name="weekNumber" value="${weekNumber}">
                <input type="hidden" name="year" value="${year}">
                <label for="fromDate">Từ ngày:</label>
                <input type="date" name="fromDate" id="fromDate" value="${fromDate}">
                <label for="toDate">Đến ngày:</label>
                <input type="date" name="toDate" id="toDate" value="${toDate}">
                <button type="submit"><i class="fas fa-filter"></i> Lọc</button>
            </form>
            <table class="agenda-table" id="scheduleTable">
                <tr>
                    <th>Nhân sự</th>
                    <c:forEach var="day" items="${weekDays}">
                        <th>${day}</th>
                    </c:forEach>
                </tr>
                <c:forEach var="employee" items="${employees}">
                    <tr>
                        <td>${employee.name}</td>
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
        </div>
    </body>
</html>
