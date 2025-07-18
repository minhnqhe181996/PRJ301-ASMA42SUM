<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Đăng Nhập</title>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    </head>
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
            --error-red: #dc3545;
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
            overflow: hidden;
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
            padding: 40px;
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
        .login-header {
            text-align: center;
            margin-bottom: 36px;
            position: relative;
        }
        .login-header::before {
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
        .login-header h2 {
            font-size: 30px;
            font-weight: 700;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 8px;
            letter-spacing: -0.5px;
        }
        .login-header .subtitle {
            color: var(--text-secondary);
            font-size: 15px;
            font-weight: 400;
            opacity: 0.8;
        }
        .error-box {
            display: flex;
            align-items: center;
            gap: 8px;
            background: rgba(220,53,69,0.08);
            border: 1px solid #dc3545;
            color: #dc3545;
            border-radius: 8px;
            padding: 8px 12px;
            margin-bottom: 18px;
            font-size: 15px;
            font-weight: 500;
            box-shadow: 0 2px 8px rgba(220,53,69,0.07);
            justify-content: center;
        }
        .login-form {
            display: flex;
            flex-direction: column;
            gap: 22px;
        }
        .input-group {
            position: relative;
            display: flex;
            align-items: center;
        }
        .input-group input {
            width: 100%;
            padding: 18px 18px 18px 48px;
            border: 1.5px solid var(--glass-border);
            border-radius: 12px;
            background: rgba(255,255,255,0.7);
            color: var(--text-primary);
            font-size: 17px;
            font-weight: 500;
            box-sizing: border-box;
            transition: all 0.3s cubic-bezier(.4,1.4,.6,1);
            box-shadow: 0 2px 8px rgba(0,0,0,0.07);
        }
        .input-group label {
            position: absolute;
            left: 48px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-secondary);
            font-size: 15px;
            font-weight: 500;
            pointer-events: none;
            background: transparent;
            transition: 0.2s cubic-bezier(.4,1.4,.6,1);
            z-index: 2;
        }
        .input-group input:focus + label,
        .input-group input:not(:placeholder-shown) + label {
            top: 6px;
            left: 46px;
            font-size: 12px;
            color: #667eea;
            background: transparent;
        }
        .input-icon {
            position: absolute;
            left: 16px;
            top: 50%;
            transform: translateY(-50%);
            pointer-events: none;
            opacity: 0.7;
            font-size: 20px;
            color: #667eea;
        }
        .btn-login {
            width: 100%;
            padding: 18px;
            background: var(--primary-gradient);
            color: var(--text-light);
            border: none;
            cursor: pointer;
            border-radius: 12px;
            font-size: 19px;
            font-weight: 700;
            letter-spacing: 1px;
            box-shadow: 0 6px 18px rgba(102, 126, 234, 0.18);
            transition: all 0.25s cubic-bezier(.4,1.4,.6,1);
            position: relative;
            overflow: hidden;
            opacity: 0.5;
            filter: grayscale(0.2);
            pointer-events: none;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }
        .btn-login.active {
            opacity: 1;
            filter: none;
            pointer-events: auto;
        }
        .btn-login:before {
            content: '';
            position: absolute;
            left: -75%;
            top: 0;
            width: 50%;
            height: 100%;
            background: rgba(255,255,255,0.18);
            transform: skewX(-20deg);
            transition: left 0.4s cubic-bezier(.4,1.4,.6,1);
        }
        .btn-login.active:hover:before {
            left: 120%;
        }
        .btn-login.active:hover {
            background: var(--secondary-gradient);
            transform: translateY(-2px) scale(1.03);
            box-shadow: var(--shadow-hover);
        }
        .btn-login.active:active {
            transform: scale(0.98);
            box-shadow: var(--shadow-soft);
        }
        @media (max-width: 600px) {
            .main-container {
                padding: 30px 12px;
            }
            .login-header h2 {
                font-size: 22px;
            }
            .input-group input {
                padding: 14px 12px 14px 38px;
                font-size: 15px;
            }
            .input-group label {
                left: 38px;
                font-size: 14px;
            }
            .input-group input:focus + label,
            .input-group input:not(:placeholder-shown) + label {
                left: 36px;
                font-size: 11px;
            }
            .btn-login {
                padding: 14px;
                font-size: 16px;
            }
        }
    </style>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const username = document.getElementById('username');
            const password = document.getElementById('password');
            const btn = document.getElementById('login-btn');
            function checkInput() {
                if (username.value.trim() && password.value.trim()) {
                    btn.classList.add('active');
                } else {
                    btn.classList.remove('active');
                }
            }
            username.addEventListener('input', checkInput);
            password.addEventListener('input', checkInput);
            checkInput();
        });
    </script>
    <body>
        <div class="main-container">
            <div class="login-header">
                <h2>Đăng Nhập</h2>
                <div class="subtitle">Vui lòng nhập thông tin để tiếp tục</div>
            </div>
            <% String error = request.getParameter("error"); %>
            <% if (error != null) { %>
            <div class="error-box">
                <svg width="20" height="20" fill="none" viewBox="0 0 24 24"><circle cx="12" cy="12" r="10" fill="#dc3545" fill-opacity="0.15"/><path d="M12 8v4m0 4h.01" stroke="#dc3545" stroke-width="2" stroke-linecap="round"/></svg>
                <span>Sai thông tin đăng nhập. Vui lòng thử lại.</span>
            </div>
            <% } %>
            <form action="login" method="POST" autocomplete="off" class="login-form">
                <div class="input-group">
                    <span class="input-icon"><i class="fas fa-user"></i></span>
                    <input type="text" id="username" name="username" required autocomplete="username" placeholder=" " />
                    <label for="username">Tên đăng nhập</label>
                </div>
                <div class="input-group">
                    <span class="input-icon"><i class="fas fa-lock"></i></span>
                    <input type="password" id="password" name="password" required autocomplete="current-password" placeholder=" " />
                    <label for="password">Mật khẩu</label>
                </div>
                <button type="submit" class="btn-login" id="login-btn">
                    <i class="fas fa-sign-in-alt"></i> Đăng Nhập
                </button>
            </form>
        </div>
    </body>
</html>