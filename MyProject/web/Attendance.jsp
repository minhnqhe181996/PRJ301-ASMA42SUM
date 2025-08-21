<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Điểm Danh</title>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <style>
            :root {
                --primary-gradient: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
                --success-gradient: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%);
                --warning-gradient: linear-gradient(135deg, #fa709a 0%, #fee140 100%);
                --checkin-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                --checkout-gradient: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
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
                display: flex;
                flex-direction: column;
                align-items: center;
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
                position: absolute;
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
                z-index: 10;
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
                width: 100%;
                max-width: 600px;
                position: relative;
                z-index: 1;
                animation: containerFadeIn 1s cubic-bezier(0.4,0,0.2,1);
                margin-top: 40px;
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
                width: 60px;
                height: 4px;
                background: var(--primary-gradient);
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

            .clock-icon {
                width: 80px;
                height: 80px;
                border-radius: 50%;
                background: var(--primary-gradient);
                display: flex;
                align-items: center;
                justify-content: center;
                margin: 0 auto 20px;
                animation: clockPulse 3s ease-in-out infinite;
            }

            @keyframes clockPulse {
                0%, 100% {
                    transform: scale(1);
                    box-shadow: 0 0 0 0 rgba(79,172,254,.4);
                }
                50% {
                    transform: scale(1.05);
                    box-shadow: 0 0 0 20px rgba(79,172,254,0);
                }
            }

            .clock-icon i {
                font-size: 36px;
                color: var(--text-light);
            }

            .page-header h2 {
                font-size: 32px;
                font-weight: 700;
                background: var(--primary-gradient);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
                margin-bottom: 8px;
                letter-spacing: -.5px;
            }

            .page-header .subtitle {
                color: var(--text-secondary);
                font-size: 16px;
                font-weight: 400;
                opacity: .8;
            }

            .current-time {
                background: var(--glass-bg);
                border: 1px solid var(--glass-border);
                backdrop-filter: blur(10px);
                padding: 20px;
                border-radius: 16px;
                margin-bottom: 30px;
                text-align: center;
                box-shadow: var(--shadow-soft);
            }

            .current-time .time-display {
                font-size: 28px;
                font-weight: 700;
                background: var(--primary-gradient);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
                margin-bottom: 8px;
            }

            .current-time .date-display {
                color: var(--text-secondary);
                font-size: 16px;
                font-weight: 500;
            }

            .status-card {
                background: var(--glass-bg);
                border: 1px solid var(--glass-border);
                backdrop-filter: blur(10px);
                padding: 24px;
                border-radius: 16px;
                margin-bottom: 30px;
                box-shadow: var(--shadow-soft);
            }

            .status-title {
                font-size: 18px;
                font-weight: 600;
                color: var(--text-primary);
                margin-bottom: 16px;
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .status-grid {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 16px;
            }

            .status-item {
                text-align: center;
                padding: 16px;
                background: rgba(255, 255, 255, 0.1);
                border-radius: 12px;
                border: 1px solid rgba(255, 255, 255, 0.15);
            }

            .status-item .status-label {
                font-size: 14px;
                color: var(--text-secondary);
                margin-bottom: 8px;
                font-weight: 500;
            }

            .status-item .status-value {
                font-size: 18px;
                font-weight: 700;
                color: var(--text-primary);
            }

            .status-item.checked-in .status-value {
                background: var(--success-gradient);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
            }

            .status-item.checked-out .status-value {
                background: var(--warning-gradient);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
            }

            .attendance-form {
                margin-bottom: 30px;
            }

            .form-row {
                display: flex;
                gap: 16px;
                margin-bottom: 20px;
            }

            .notes-input {
                width: 100%;
                padding: 16px 20px;
                border: 1px solid var(--glass-border);
                border-radius: 12px;
                background: var(--glass-bg);
                backdrop-filter: blur(10px);
                color: var(--text-primary);
                font-size: 16px;
                font-family: 'Inter', sans-serif;
                transition: all .3s cubic-bezier(0.4,0,0.2,1);
                margin-bottom: 20px;
            }

            .notes-input::placeholder {
                color: var(--text-secondary);
                opacity: 0.7;
            }

            .notes-input:focus {
                outline: none;
                border-color: rgba(79,172,254,.5);
                box-shadow: 0 0 0 3px rgba(79,172,254,.1);
            }

            .action-buttons {
                display: flex;
                gap: 16px;
            }

            .action-btn {
                flex: 1;
                padding: 18px 24px;
                border: none;
                border-radius: 12px;
                font-size: 16px;
                font-weight: 600;
                cursor: pointer;
                transition: all .3s cubic-bezier(0.4,0,0.2,1);
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 10px;
                box-shadow: var(--shadow-soft);
                position: relative;
                overflow: hidden;
            }

            .action-btn::before {
                content: '';
                position: absolute;
                top: 0;
                left: -100%;
                width: 100%;
                height: 100%;
                background: linear-gradient(90deg, transparent, rgba(255,255,255,.2), transparent);
                transition: left .5s cubic-bezier(0.4,0,0.2,1);
            }

            .action-btn:hover::before {
                left: 100%;
            }

            .checkin-btn {
                background: var(--checkin-gradient);
                color: var(--text-light);
            }

            .checkout-btn {
                background: var(--checkout-gradient);
                color: var(--text-light);
            }

            .action-btn:hover {
                transform: translateY(-3px);
                box-shadow: var(--shadow-hover);
            }

            .action-btn:active {
                transform: translateY(-1px);
            }

            .action-btn:disabled {
                opacity: 0.5;
                cursor: not-allowed;
                transform: none !important;
                box-shadow: var(--shadow-soft) !important;
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

            .message.success {
                background: rgba(67, 233, 123, 0.15);
                color: #059669;
                border-color: rgba(67, 233, 123, 0.3);
            }

            .message.error {
                background: rgba(239, 68, 68, 0.15);
                color: #dc2626;
                border-color: rgba(239, 68, 68, 0.3);
            }

            @media (max-width: 640px) {
                .main-container {
                    padding: 30px 20px;
                    margin: 10px;
                    margin-top: 80px;
                }

                .page-header h2 {
                    font-size: 28px;
                }

                .clock-icon {
                    width: 70px;
                    height: 70px;
                }

                .clock-icon i {
                    font-size: 28px;
                }

                .current-time .time-display {
                    font-size: 24px;
                }

                .action-buttons {
                    flex-direction: column;
                }

                .form-row {
                    flex-direction: column;
                }

                .status-grid {
                    grid-template-columns: 1fr;
                }

                .back-button {
                    top: 15px;
                    left: 15px;
                    padding: 10px 16px;
                    font-size: 13px;
                }
            }

            .working-hours {
                background: var(--glass-bg);
                border: 1px solid var(--glass-border);
                backdrop-filter: blur(10px);
                padding: 20px;
                border-radius: 16px;
                box-shadow: var(--shadow-soft);
                text-align: center;
            }

            .working-hours .hours-title {
                font-size: 16px;
                font-weight: 600;
                color: var(--text-primary);
                margin-bottom: 12px;
            }

            .working-hours .hours-value {
                font-size: 24px;
                font-weight: 700;
                background: var(--primary-gradient);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
            }
        </style>
        <script>
            function updateTime() {
                const now = new Date();
                const timeString = now.toLocaleTimeString('vi-VN', {
                    hour12: false,
                    hour: '2-digit',
                    minute: '2-digit',
                    second: '2-digit'
                });
                const dateString = now.toLocaleDateString('vi-VN', {
                    weekday: 'long',
                    year: 'numeric',
                    month: 'long',
                    day: 'numeric'
                });

                document.getElementById('current-time').textContent = timeString;
                document.getElementById('current-date').textContent = dateString;
            }

            // Update time every second
            setInterval(updateTime, 1000);

            // Initialize on page load
            document.addEventListener('DOMContentLoaded', updateTime);
        </script>
    </head>
    <body>
        <a href="${pageContext.request.contextPath}/Employee.jsp" class="back-button">
            <i class="fas fa-arrow-left"></i> Quay lại
        </a>

        <div class="main-container">
            <div class="page-header">
                <div class="clock-icon">
                    <i class="fas fa-clock"></i>
                </div>
                <h2>Điểm Danh</h2>
                <p class="subtitle">Check-in/Check-out và theo dõi thời gian làm việc</p>
            </div>

            <div class="current-time">
                <div class="time-display" id="current-time">--:--:--</div>
                <div class="date-display" id="current-date">Loading...</div>
            </div>

            <!-- Display messages -->
            <c:if test="${not empty msg}">
                <div class="message success">
                    <i class="fas fa-check-circle"></i>
                    ${msg}
                </div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="message error">
                    <i class="fas fa-exclamation-circle"></i>
                    ${error}
                </div>
            </c:if>

            <!-- Today's Status -->
            <div class="status-card">
                <div class="status-title">
                    <i class="fas fa-calendar-day"></i>
                    Trạng thái hôm nay
                </div>
                <div class="status-grid">
                    <div class="status-item ${not empty checkinTime ? 'checked-in' : ''}">
                        <div class="status-label">Check-in</div>
                        <div class="status-value">
                            <c:choose>
                                <c:when test="${not empty checkinTime}">
                                    <fmt:formatDate value="${checkinTime}" pattern="HH:mm" />
                                </c:when>
                                <c:otherwise>--:--</c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    <div class="status-item ${not empty checkoutTime ? 'checked-out' : ''}">
                        <div class="status-label">Check-out</div>
                        <div class="status-value">
                            <c:choose>
                                <c:when test="${not empty checkoutTime}">
                                    <fmt:formatDate value="${checkoutTime}" pattern="HH:mm" />
                                </c:when>
                                <c:otherwise>--:--</c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Attendance Form -->
            <form method="post" action="attendance" class="attendance-form">
                <input type="text" name="notes" class="notes-input" placeholder="Ghi chú (tùy chọn)" />

                <div class="action-buttons">
                    <button type="submit" name="action" value="in" class="action-btn checkin-btn" 
                            ${not empty checkinTime ? 'disabled' : ''}>
                        <i class="fas fa-sign-in-alt"></i>
                        Check-in
                    </button>
                    <button type="submit" name="action" value="out" class="action-btn checkout-btn"
                            ${empty checkinTime or not empty checkoutTime ? 'disabled' : ''}>
                        <i class="fas fa-sign-out-alt"></i>
                        Check-out
                    </button>
                </div>
            </form>

            <!-- Working Hours Display -->
            <c:if test="${not empty workingHours}">
                <div class="working-hours">
                    <div class="hours-title">Tổng giờ làm việc hôm nay</div>
                    <div class="hours-value">${workingHours}</div>
                </div>
            </c:if>
        </div>
    </body>
</html>