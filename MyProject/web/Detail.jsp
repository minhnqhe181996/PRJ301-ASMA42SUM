<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Chi tiết đơn nghỉ</title>
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
                padding: 38px 28px 32px 28px;
                width: 100%;
                max-width: 420px;
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
            .detail-header {
                text-align: center;
                margin-bottom: 32px;
                position: relative;
            }
            .detail-header::before {
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
            .detail-header h2 {
                font-size: 26px;
                font-weight: 700;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
                margin-bottom: 8px;
                letter-spacing: -0.5px;
            }
            .detail-header .subtitle {
                color: var(--text-secondary);
                font-size: 15px;
                font-weight: 400;
                opacity: 0.8;
            }
            .field {
                margin-bottom: 18px;
                font-size: 15px;
                display: flex;
                flex-direction: column;
                gap: 4px;
                background: rgba(255,255,255,0.7);
                border-radius: 10px;
                padding: 12px 14px;
                box-shadow: 0 1px 4px rgba(102, 126, 234, 0.07);
            }
            .field label {
                font-weight: 600;
                color: var(--text-secondary);
                font-size: 14px;
            }
            .field span {
                color: var(--text-primary);
                font-size: 15px;
                font-weight: 500;
                word-break: break-word;
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
            .back-link {
                text-align: center;
                margin-top: 18px;
            }
            .back-link a {
                text-decoration: none;
                color: var(--text-light);
                background: var(--primary-gradient);
                padding: 10px 22px;
                border-radius: 10px;
                font-size: 15px;
                font-weight: 600;
                display: inline-flex;
                align-items: center;
                gap: 8px;
                box-shadow: 0 2px 8px rgba(102, 126, 234, 0.13);
                transition: background 0.2s, transform 0.2s;
            }
            .back-link a:hover {
                background: var(--secondary-gradient);
                transform: translateY(-2px);
            }
            @media (max-width: 600px) {
                .main-container { padding: 14px 2vw; }
                .detail-header h2 { font-size: 19px; }
                .field { font-size: 13px; padding: 8px 7px; }
                .back-link a { padding: 8px 12px; font-size: 13px; }
            }
        </style>
    </head>
    <body>
        <div class="main-container">
            <div class="detail-header">
                <h2>Chi tiết đơn nghỉ</h2>
                <div class="subtitle">Thông tin chi tiết về đơn nghỉ phép</div>
            </div>
            <c:if test="${detail != null}">
                <div class="field">
                    <label><i class="fas fa-calendar-day"></i> Từ ngày</label>
                    <span>${detail.getDateFrom()}</span>
                </div>
                <div class="field">
                    <label><i class="fas fa-calendar-day"></i> Tới ngày</label>
                    <span>${detail.getDateTo()}</span>
                </div>
                <div class="field">
                    <label><i class="fas fa-clock"></i> Ngày tạo</label>
                    <span>${detail.getDateCreate()}</span>
                </div>
                <div class="field">
                    <label><i class="fas fa-align-left"></i> Lý do</label>
                    <span style="white-space: pre-wrap;">${detail.getReason()}</span>
                </div>
                <div class="field">
                    <label><i class="fas fa-info-circle"></i> Trạng thái</label>
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
                <p style="color: #f5576c; text-align: center; font-size: 16px; font-weight: 600;">Không tìm thấy đơn nghỉ phép.</p>
            </c:if>
            <div class="back-link">
                <a href="View"><i class="fas fa-arrow-left"></i> Quay lại</a>
            </div>
        </div>
    </body>
</html>
