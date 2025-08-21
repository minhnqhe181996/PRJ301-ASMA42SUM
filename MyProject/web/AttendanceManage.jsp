<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*, model.Attendance" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Quản Lý Điểm Danh</title>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <style>
            :root {
                --primary-gradient: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
                --success-gradient: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%);
                --warning-gradient: linear-gradient(135deg, #fa709a 0%, #fee140 100%);
                --manager-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                --filter-gradient: linear-gradient(135deg, #ff9a9e 0%, #fecfef 100%);
                --glass-bg: rgba(255, 255, 255, 0.15);
                --glass-border: rgba(255, 255, 255, 0.25);
                --text-primary: #1a1a1a;
                --text-secondary: #64748b;
                --text-light: #ffffff;
                --shadow-soft: 0 8px 32px rgba(0, 0, 0, 0.1);
                --shadow-hover: 0 12px 48px rgba(0, 0, 0, 0.15);
                --blur-amount: 20px;
            }

            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Inter', sans-serif;
                min-height: 100vh;
                background: linear-gradient(135deg, #4facfe 0%, #00f2fe 50%, #43e97b 100%);
                background-size: 400% 400%;
                animation: gradientShift 15s ease infinite;
                padding: 20px;
                position: relative;
                overflow-x: hidden;
            }

            @keyframes gradientShift {
                0% {
                    background-position: 0% 50%;
                }
                50% {
                    background-position: 100% 50%;
                }
                100% {
                    background-position: 0% 50%;
                }
            }

            body::before {
                content: '';
                position: absolute;
                inset: 0;
                background:
                    radial-gradient(circle at 20% 20%, rgba(255,255,255,0.1) 0%, transparent 50%),
                    radial-gradient(circle at 80% 80%, rgba(255,255,255,0.1) 0%, transparent 50%),
                    radial-gradient(circle at 40% 60%, rgba(255,255,255,0.05) 0%, transparent 50%);
                animation: floatingOrbs 20s linear infinite;
                z-index: 0;
            }

            @keyframes floatingOrbs {
                0% {
                    transform: translateY(0) rotate(0);
                }
                50% {
                    transform: translateY(-20px) rotate(180deg);
                }
                100% {
                    transform: translateY(0) rotate(360deg);
                }
            }

            .back-button {
                position: fixed;
                top: 20px;
                left: 20px;
                background: var(--glass-bg);
                border: 1px solid var(--glass-border);
                backdrop-filter: blur(var(--blur-amount));
                color: var(--text-primary);
                padding: 12px 20px;
                font-size: 14px;
                font-weight: 600;
                border-radius: 12px;
                cursor: pointer;
                box-shadow: var(--shadow-soft);
                transition: all .3s cubic-bezier(0.4,0,0.2,1);
                display: flex;
                align-items: center;
                gap: 8px;
                z-index: 100;
                text-decoration: none;
            }

            .back-button:hover {
                transform: translateY(-2px);
                box-shadow: var(--shadow-hover);
                border-color: rgba(255,255,255,.4);
            }

            .main-container {
                background: var(--glass-bg);
                border: 1px solid var(--glass-border);
                backdrop-filter: blur(var(--blur-amount));
                border-radius: 24px;
                box-shadow: var(--shadow-soft);
                padding: 40px;
                max-width: 1200px;
                margin: 60px auto 0;
                position: relative;
                z-index: 1;
                animation: containerFadeIn 1s cubic-bezier(0.4,0,0.2,1);
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

            .page-header {
                text-align: center;
                margin-bottom: 40px;
                position: relative;
            }

            .page-header::before {
                content: '';
                position: absolute;
                top: -20px;
                left: 50%;
                transform: translateX(-50%);
                width: 80px;
                height: 4px;
                background: var(--manager-gradient);
                border-radius: 2px;
                animation: headerGlow 2s ease-in-out infinite alternate;
            }

            @keyframes headerGlow {
                from {
                    opacity: .6;
                    transform: translateX(-50%) scaleX(1);
                }
                to {
                    opacity: 1;
                    transform: translateX(-50%) scaleX(1.2);
                }
            }

            .manager-icon {
                width: 90px;
                height: 90px;
                border-radius: 50%;
                background: var(--manager-gradient);
                display: flex;
                align-items: center;
                justify-content: center;
                margin: 0 auto 20px;
                animation: managerPulse 3s ease-in-out infinite;
            }

            @keyframes managerPulse {
                0%, 100% {
                    transform: scale(1);
                    box-shadow: 0 0 0 0 rgba(102,126,234,.4);
                }
                50% {
                    transform: scale(1.05);
                    box-shadow: 0 0 0 20px rgba(102,126,234,0);
                }
            }

            .manager-icon i {
                font-size: 40px;
                color: var(--text-light);
            }

            .page-header h2 {
                font-size: 36px;
                font-weight: 700;
                background: var(--manager-gradient);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
                margin-bottom: 8px;
                letter-spacing: -.5px;
            }

            .page-header .subtitle {
                color: var(--text-secondary);
                font-size: 18px;
                font-weight: 400;
                opacity: .8;
            }

            .filter-section {
                background: var(--glass-bg);
                border: 1px solid var(--glass-border);
                backdrop-filter: blur(10px);
                padding: 30px;
                border-radius: 20px;
                margin-bottom: 30px;
                box-shadow: var(--shadow-soft);
                position: relative;
                overflow: hidden;
            }

            .filter-section::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 3px;
                background: var(--filter-gradient);
                border-radius: 20px 20px 0 0;
            }

            .filter-title {
                font-size: 20px;
                font-weight: 600;
                color: var(--text-primary);
                margin-bottom: 20px;
                display: flex;
                align-items: center;
                gap: 12px;
            }

            .filter-form {
                display: flex;
                gap: 20px;
                align-items: end;
                flex-wrap: wrap;
            }

            .filter-group {
                display: flex;
                flex-direction: column;
                gap: 8px;
            }

            .filter-label {
                font-size: 14px;
                font-weight: 500;
                color: var(--text-primary);
            }

            .filter-input {
                padding: 12px 16px;
                border: 1px solid var(--glass-border);
                border-radius: 10px;
                background: rgba(255, 255, 255, 0.1);
                backdrop-filter: blur(5px);
                color: var(--text-primary);
                font-size: 14px;
                font-family: 'Inter', sans-serif;
                transition: all .3s cubic-bezier(0.4,0,0.2,1);
                min-width: 150px;
            }

            .filter-input:focus {
                outline: none;
                border-color: rgba(102,126,234,.5);
                box-shadow: 0 0 0 3px rgba(102,126,234,.1);
                background: rgba(255, 255, 255, 0.15);
            }

            .filter-btn {
                padding: 12px 24px;
                border: none;
                border-radius: 10px;
                background: var(--filter-gradient);
                color: var(--text-light);
                font-size: 14px;
                font-weight: 600;
                cursor: pointer;
                transition: all .3s cubic-bezier(0.4,0,0.2,1);
                display: flex;
                align-items: center;
                gap: 8px;
                box-shadow: var(--shadow-soft);
                position: relative;
                overflow: hidden;
            }

            .filter-btn::before {
                content: '';
                position: absolute;
                top: 0;
                left: -100%;
                width: 100%;
                height: 100%;
                background: linear-gradient(90deg, transparent, rgba(255,255,255,.2), transparent);
                transition: left .5s cubic-bezier(0.4,0,0.2,1);
            }

            .filter-btn:hover::before {
                left: 100%;
            }

            .filter-btn:hover {
                transform: translateY(-2px);
                box-shadow: var(--shadow-hover);
            }

            .stats-cards {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                gap: 20px;
                margin-bottom: 30px;
            }

            .stat-card {
                background: var(--glass-bg);
                border: 1px solid var(--glass-border);
                backdrop-filter: blur(10px);
                padding: 24px;
                border-radius: 16px;
                box-shadow: var(--shadow-soft);
                text-align: center;
                position: relative;
                overflow: hidden;
                transition: all .3s cubic-bezier(0.4,0,0.2,1);
            }

            .stat-card:hover {
                transform: translateY(-4px);
                box-shadow: var(--shadow-hover);
            }

            .stat-icon {
                width: 50px;
                height: 50px;
                border-radius: 12px;
                display: flex;
                align-items: center;
                justify-content: center;
                margin: 0 auto 16px;
                font-size: 20px;
                color: var(--text-light);
            }

            .stat-card:nth-child(1) .stat-icon {
                background: var(--success-gradient);
            }

            .stat-card:nth-child(2) .stat-icon {
                background: var(--warning-gradient);
            }

            .stat-card:nth-child(3) .stat-icon {
                background: var(--primary-gradient);
            }

            .stat-card:nth-child(4) .stat-icon {
                background: var(--manager-gradient);
            }

            .stat-value {
                font-size: 28px;
                font-weight: 700;
                color: var(--text-primary);
                margin-bottom: 8px;
            }

            .stat-label {
                font-size: 14px;
                color: var(--text-secondary);
                font-weight: 500;
            }

            .message {
                padding: 16px 20px;
                border-radius: 12px;
                margin-bottom: 20px;
                font-weight: 500;
                display: flex;
                align-items: center;
                gap: 10px;
                backdrop-filter: blur(10px);
                border: 1px solid;
                animation: messageSlideIn .5s cubic-bezier(0.4,0,0.2,1);
            }

            @keyframes messageSlideIn {
                from {
                    opacity: 0;
                    transform: translateY(-10px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .message.error {
                background: rgba(239, 68, 68, 0.15);
                color: #dc2626;
                border-color: rgba(239, 68, 68, 0.3);
            }

            .data-table-container {
                background: var(--glass-bg);
                border: 1px solid var(--glass-border);
                backdrop-filter: blur(10px);
                border-radius: 20px;
                overflow: hidden;
                box-shadow: var(--shadow-soft);
                position: relative;
            }

            .data-table-container::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 3px;
                background: var(--primary-gradient);
                border-radius: 20px 20px 0 0;
            }

            .table-header {
                padding: 24px 30px;
                border-bottom: 1px solid var(--glass-border);
                display: flex;
                align-items: center;
                justify-content: space-between;
            }

            .table-title {
                font-size: 20px;
                font-weight: 600;
                color: var(--text-primary);
                display: flex;
                align-items: center;
                gap: 12px;
            }

            .record-count {
                background: var(--primary-gradient);
                color: var(--text-light);
                padding: 6px 12px;
                border-radius: 20px;
                font-size: 12px;
                font-weight: 600;
            }

            .table-wrapper {
                overflow-x: auto;
                max-height: 600px;
                overflow-y: auto;
            }

            .attendance-table {
                width: 100%;
                border-collapse: collapse;
                font-size: 14px;
            }

            .attendance-table th {
                background: rgba(255, 255, 255, 0.1);
                padding: 16px 20px;
                text-align: left;
                font-weight: 600;
                color: var(--text-primary);
                border-bottom: 1px solid var(--glass-border);
                position: sticky;
                top: 0;
                backdrop-filter: blur(10px);
                z-index: 10;
            }

            .attendance-table td {
                padding: 16px 20px;
                border-bottom: 1px solid rgba(255, 255, 255, 0.1);
                color: var(--text-primary);
                transition: all .2s ease;
            }

            .attendance-table tr {
                transition: all .2s ease;
            }

            .attendance-table tr:hover {
                background: rgba(255, 255, 255, 0.05);
            }

            .employee-id {
                font-weight: 600;
                background: var(--manager-gradient);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
            }

            .time-cell {
                font-family: 'Courier New', monospace;
                font-weight: 500;
            }

            .checkin-time {
                color: #059669;
                background: rgba(67, 233, 123, 0.1);
                padding: 4px 8px;
                border-radius: 6px;
                font-size: 12px;
            }

            .checkout-time {
                color: #dc2626;
                background: rgba(239, 68, 68, 0.1);
                padding: 4px 8px;
                border-radius: 6px;
                font-size: 12px;
            }

            .notes-cell {
                max-width: 200px;
                word-wrap: break-word;
                font-style: italic;
                color: var(--text-secondary);
            }

            .empty-state {
                text-align: center;
                padding: 60px 20px;
                color: var(--text-secondary);
            }

            .empty-icon {
                font-size: 48px;
                margin-bottom: 16px;
                opacity: 0.5;
            }

            .empty-text {
                font-size: 18px;
                margin-bottom: 8px;
            }

            .empty-subtext {
                font-size: 14px;
                opacity: 0.7;
            }

            @media (max-width: 768px) {
                .main-container {
                    padding: 20px;
                    margin: 80px 10px 0;
                }

                .page-header h2 {
                    font-size: 28px;
                }

                .manager-icon {
                    width: 70px;
                    height: 70px;
                }

                .manager-icon i {
                    font-size: 28px;
                }

                .filter-form {
                    flex-direction: column;
                    align-items: stretch;
                }

                .filter-input {
                    min-width: unset;
                }

                .stats-cards {
                    grid-template-columns: repeat(2, 1fr);
                }

                .table-wrapper {
                    font-size: 12px;
                }

                .attendance-table th,
                .attendance-table td {
                    padding: 12px 8px;
                }

                .back-button {
                    top: 15px;
                    left: 15px;
                    padding: 10px 16px;
                    font-size: 13px;
                }
            }

            @media (max-width: 480px) {
                .stats-cards {
                    grid-template-columns: 1fr;
                }

                .attendance-table {
                    font-size: 11px;
                }

                .attendance-table th,
                .attendance-table td {
                    padding: 8px 4px;
                }
            }
        </style>
    </head>
    <body>
        <a href="${pageContext.request.contextPath}/Management.jsp" class="back-button">
            <i class="fas fa-arrow-left"></i> Quay lại
        </a>

        <div class="main-container">
            <div class="page-header">
                <div class="manager-icon">
                    <i class="fas fa-users-cog"></i>
                </div>
                <h2>Quản Lý Điểm Danh</h2>
                <p class="subtitle">Theo dõi và quản lý điểm danh nhân viên</p>
            </div>

            <!-- Filter Section -->
            <div class="filter-section">
                <div class="filter-title">
                    <i class="fas fa-filter"></i>
                    Bộ Lọc Thời Gian
                </div>
                <form method="get" action="manage" class="filter-form">
                    <div class="filter-group">
                        <label class="filter-label">Từ ngày:</label>
                        <input type="date" name="from" value="${from}" class="filter-input"/>
                    </div>
                    <div class="filter-group">
                        <label class="filter-label">Đến ngày:</label>
                        <input type="date" name="to" value="${to}" class="filter-input"/>
                    </div>
                    <button type="submit" class="filter-btn">
                        <i class="fas fa-search"></i>
                        Lọc Dữ Liệu
                    </button>
                </form>
            </div>

            <!-- Statistics Cards -->
            <div class="stats-cards">
                <div class="stat-card">
                    <div class="stat-icon">
                        <i class="fas fa-calendar-check"></i>
                    </div>
                    <div class="stat-value">${totalRecords}</div>
                    <div class="stat-label">Tổng Bản Ghi</div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon">
                        <i class="fas fa-user-check"></i>
                    </div>
                    <div class="stat-value">${uniqueEmployees}</div>
                    <div class="stat-label">Nhân Viên</div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon">
                        <i class="fas fa-clock"></i>
                    </div>
                    <div class="stat-value">${presentToday}</div>
                    <div class="stat-label">Có Mặt Hôm Nay</div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon">
                        <i class="fas fa-chart-line"></i>
                    </div>
                    <div class="stat-value">${avgWorkingHours}</div>
                    <div class="stat-label">Giờ TB/Ngày</div>
                </div>
            </div>

            <!-- Display messages -->
            <c:if test="${not empty error}">
                <div class="message error">
                    <i class="fas fa-exclamation-circle"></i>
                    ${error}
                </div>
            </c:if>

            <!-- Data Table -->
            <div class="data-table-container">
                <div class="table-header">
                    <div class="table-title">
                        <i class="fas fa-table"></i>
                        Dữ Liệu Điểm Danh
                    </div>
                    <div class="record-count">
                        <c:choose>
                            <c:when test="${not empty list}">
                                ${list.size()} bản ghi
                            </c:when>
                            <c:otherwise>
                                0 bản ghi
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <div class="table-wrapper">
                    <c:choose>
                        <c:when test="${not empty list}">
                            <table class="attendance-table">
                                <thead>
                                    <tr>
                                        <th><i class="fas fa-id-card"></i> ID Nhân Viên</th>
                                        <th><i class="fas fa-calendar"></i> Ngày</th>
                                        <th><i class="fas fa-sign-in-alt"></i> Check-in</th>
                                        <th><i class="fas fa-sign-out-alt"></i> Check-out</th>
                                        <th><i class="fas fa-clock"></i> Giờ Làm</th>
                                        <th><i class="fas fa-sticky-note"></i> Ghi Chú</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${list}" var="a">
                                    <tr>
                                        <td class="employee-id">${a.employeeId}</td>
                                        <td class="time-cell">
                                    <fmt:formatDate value="${a.workDate}" pattern="dd/MM/yyyy" />
                                    </td>
                                    <td class="time-cell">
                                    <c:choose>
                                        <c:when test="${not empty a.checkIn}">
                                            <span class="checkin-time">
                                                <fmt:formatDate value="${a.checkIn}" pattern="HH:mm:ss" />
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span style="color: var(--text-secondary);">--:--:--</span>
                                        </c:otherwise>
                                    </c:choose>
                                    </td>
                                    <td class="time-cell">
                                    <c:choose>
                                        <c:when test="${not empty a.checkOut}">
                                            <span class="checkout-time">
                                                <fmt:formatDate value="${a.checkOut}" pattern="HH:mm:ss" />
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span style="color: var(--text-secondary);">--:--:--</span>
                                        </c:otherwise>
                                    </c:choose>
                                    </td>
                                    <td class="time-cell">
                                    <c:choose>
                                        <c:when test="${not empty a.workingHours}">
                                            <strong>${a.workingHours}</strong>
                                        </c:when>
                                        <c:otherwise>
                                            <span style="color: var(--text-secondary);">--</span>
                                        </c:otherwise>
                                    </c:choose>
                                    </td>
                                    <td class="notes-cell">
                                    <c:choose>
                                        <c:when test="${not empty a.notes}">
                                            ${a.notes}
                                        </c:when>
                                        <c:otherwise>
                                            <span style="color: var(--text-secondary); font-style: normal;">Không có ghi chú</span>
                                        </c:otherwise>
                                    </c:choose>
                                    </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-state">
                                <div class="empty-icon">
                                    <i class="fas fa-calendar-times"></i>
                                </div>
                                <div class="empty-text">Không có dữ liệu điểm danh</div>
                                <div class="empty-subtext">Thử điều chỉnh bộ lọc thời gian để xem dữ liệu</div>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </body>
</html>