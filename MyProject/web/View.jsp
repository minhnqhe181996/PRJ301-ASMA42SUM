<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Danh sách đơn nghỉ phép</title>
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
                --pending: #fbbf24;
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
                align-items: flex-start;
                padding: 30px 0;
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
                padding: 38px 28px 32px 28px;
                width: 100%;
                max-width: 1000px;
                position: relative;
                z-index: 1;
                animation: containerFadeIn 1s cubic-bezier(0.4, 0, 0.2, 1);
                margin: 0 auto;
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
            .header {
                text-align: center;
                margin-bottom: 32px;
                position: relative;
            }
            .header::before {
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
            .header h2 {
                font-size: 26px;
                font-weight: 700;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
                margin-bottom: 8px;
                letter-spacing: -0.5px;
            }
            .btn-back {
                position: absolute;
                top: 24px;
                left: 24px;
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
            .table-wrapper {
                overflow-x: auto;
            }
            table {
                width: 100%;
                min-width: 800px;
                border-collapse: separate;
                border-spacing: 0;
                background: rgba(255,255,255,0.85);
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.10);
                border-radius: 16px;
                overflow: hidden;
                margin: 0 auto;
            }
            th, td {
                padding: 14px 10px;
                text-align: center;
                font-size: 15px;
            }
            th {
                background: var(--accent-gradient);
                color: var(--text-light);
                font-weight: 700;
                border: none;
            }
            table tr:first-child th:first-child {
                border-top-left-radius: 16px;
            }
            table tr:first-child th:last-child {
                border-top-right-radius: 16px;
            }
            table tr:last-child td:first-child {
                border-bottom-left-radius: 16px;
            }
            table tr:last-child td:last-child {
                border-bottom-right-radius: 16px;
            }
            td {
                background: transparent;
                border: none;
                color: var(--text-primary);
                font-weight: 500;
            }
            tr:nth-child(even) td {
                background: rgba(102,126,234,0.04);
            }
            tr:hover td {
                background: rgba(102,126,234,0.09);
            }
            .status-pending {
                color: #fff;
                background: var(--pending);
                font-weight: 700;
                padding: 4px 14px;
                border-radius: 8px;
                display: inline-block;
                font-size: 14px;
            }
            .status-rejected {
                color: #fff;
                background: var(--danger);
                font-weight: 700;
                padding: 4px 14px;
                border-radius: 8px;
                display: inline-block;
                font-size: 14px;
            }
            .status-approved {
                color: #fff;
                background: var(--success);
                font-weight: 700;
                padding: 4px 14px;
                border-radius: 8px;
                display: inline-block;
                font-size: 14px;
            }
            .action-buttons {
                display: flex;
                gap: 10px;
                justify-content: center;
                align-items: center;
            }
            .action-buttons a {
                color: #667eea;
                font-weight: 600;
                text-decoration: none;
                transition: color 0.2s;
                display: flex;
                align-items: center;
                gap: 4px;
                padding: 6px 12px;
                border-radius: 7px;
                background: rgba(102,126,234,0.08);
            }
            .action-buttons a:hover {
                color: #fff;
                background: var(--primary-gradient);
            }
            .action-buttons span {
                color: #aaa;
                font-size: 18px;
                font-weight: 400;
            }
            a {
                text-decoration: none;
                color: #007bff;
                font-weight: bold;
                transition: color 0.3s;
            }
            a:hover {
                text-decoration: underline;
                color: #0056b3;
            }
            @media (max-width: 1200px) {
                .main-container { padding: 18px 2vw; }
                th, td { font-size: 13px; padding: 10px 4px; }
            }
            @media (max-width: 700px) {
                .main-container { padding: 10px 2vw; }
                .header h2 { font-size: 19px; }
                .btn-back { top: 10px; left: 10px; padding: 8px 12px; font-size: 12px; }
                .table-wrapper { overflow-x: auto; }
                table { min-width: 600px; }
            }
        </style>
    </head>
    <body>
        <button class="btn-back" onclick="window.location.href = '${pageContext.request.contextPath}/Home'"><i class="fas fa-arrow-left"></i> Quay lại</button>
        <div class="main-container">
            <div class="header">
                <h2>Danh sách đơn nghỉ phép</h2>
            </div>
            <div class="table-wrapper">
                <table>
                    <thead>
                        <tr>
                            <th>Title</th>
                            <th>From</th>
                            <th>To</th>
                            <th>DateCreate</th>
                            <th>Status</th>
                            <th>Update</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="request" items="${requests}">
                            <tr>
                                <td>
                                    <c:choose>
                                        <c:when test="${request.getStatus() eq 'Pending'}">
                                            <a href="detail?id=${request.getId()}">
                                                ${request.getReason()}
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                            ${request.getReason()}
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td style="white-space: nowrap;">${request.getDateFrom()}</td>
                                <td style="white-space: nowrap;">${request.getDateTo()}</td>
                                <td style="white-space: nowrap;">${request.getDateCreate()}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${request.getStatus() eq 'Pending'}">
                                            <span class="status-pending">Pending</span>
                                        </c:when>
                                        <c:when test="${request.getStatus() eq 'Rejected'}">
                                            <span class="status-rejected">Rejected</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status-approved">${request.getStatus()}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:if test="${request.getStatus() eq 'Pending'}">
                                        <div class="action-buttons">
                                            <a href="${pageContext.request.contextPath}/Edit?Id=${request.getId()}"><i class="fas fa-edit"></i> Edit</a>
                                            <span>|</span>
                                            <a href="${pageContext.request.contextPath}/Delete?id=${request.getId()}" 
                                               onclick="return confirm('Bạn có chắc chắn muốn xóa đơn này?');">
                                                <i class="fas fa-trash-alt"></i> Delete
                                            </a>
                                        </div>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </body>
</html>
