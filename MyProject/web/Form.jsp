<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Đơn xin nghỉ phép</title>
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
            .form-header {
                text-align: center;
                margin-bottom: 32px;
                position: relative;
            }
            .form-header::before {
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
            .form-header h2 {
                font-size: 26px;
                font-weight: 700;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
                margin-bottom: 8px;
                letter-spacing: -0.5px;
            }
            .form-header .subtitle {
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
            .form-leave {
                display: flex;
                flex-direction: column;
                gap: 18px;
            }
            .field {
                display: flex;
                flex-direction: column;
                gap: 6px;
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
            .field input,
            .field textarea {
                padding: 8px 10px;
                font-size: 15px;
                border: 1.5px solid var(--glass-border);
                border-radius: 7px;
                background: rgba(255,255,255,0.9);
                color: var(--text-primary);
                font-family: inherit;
                transition: border 0.2s;
                resize: none;
            }
            .field input:focus,
            .field textarea:focus {
                border: 1.5px solid #667eea;
                outline: none;
            }
            .submit-btn {
                background: var(--primary-gradient);
                color: var(--text-light);
                border: none;
                padding: 12px 22px;
                font-size: 16px;
                border-radius: 10px;
                cursor: pointer;
                margin-top: 10px;
                width: 100%;
                font-weight: 600;
                box-shadow: 0 2px 8px rgba(102, 126, 234, 0.13);
                transition: background 0.2s, transform 0.2s;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 8px;
            }
            .submit-btn:hover {
                background: var(--secondary-gradient);
                transform: translateY(-2px);
            }
            .error-list {
                color: var(--danger);
                margin-top: 10px;
                font-size: 14px;
                font-weight: 600;
                background: rgba(245,87,108,0.08);
                border-radius: 8px;
                padding: 8px 12px;
            }
            .error-list ul {
                margin: 0;
                padding-left: 20px;
            }
            @media (max-width: 600px) {
                .main-container { padding: 14px 2vw; }
                .form-header h2 { font-size: 19px; }
                .field { font-size: 13px; padding: 8px 7px; }
                .submit-btn { padding: 8px 12px; font-size: 13px; }
                .btn-back { top: 10px; right: 10px; padding: 8px 12px; font-size: 12px; }
            }
        </style>
    </head>
    <body>
        <button class="btn-back" onclick="window.history.back();"><i class="fas fa-arrow-left"></i> Quay lại</button>
        <div class="main-container">
            <div class="form-header">
                <h2>Đơn xin nghỉ phép</h2>
                <div class="subtitle">Vui lòng điền đầy đủ thông tin để gửi đơn</div>
            </div>
            <form action="Request" method="post" class="form-leave">
                <div class="field">
                    <label for="from-date"><i class="fas fa-calendar-day"></i> Từ ngày</label>
                    <input type="date" id="from-date" name="fromDate" required>
                </div>
                <div class="field">
                    <label for="to-date"><i class="fas fa-calendar-day"></i> Tới ngày</label>
                    <input type="date" id="to-date" name="toDate" required>
                </div>
                <div class="field">
                    <label for="reason"><i class="fas fa-align-left"></i> Lý do</label>
                    <textarea id="reason" name="reason" required></textarea>
                </div>
                <button type="submit" class="submit-btn"><i class="fas fa-paper-plane"></i> Gửi</button>
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
