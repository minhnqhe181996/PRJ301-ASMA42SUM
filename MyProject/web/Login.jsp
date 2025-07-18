<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Đăng Nhập</title>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
    </head>
    <style>
        :root {
            --primary-blue: #007bff;
            --light-bg: #e0e5ec;
            --dark-text: #222;
            --light-text: #f0f2f5;
            --glass-bg: rgba(255, 255, 255, 0.25);
            --glass-border: rgba(255, 255, 255, 0.45);
            --input-bg: rgba(255, 255, 255, 0.7);
            --input-border-focus: rgba(0, 123, 255, 0.7);
            --button-primary: linear-gradient(90deg, #007bff 0%, #00c6ff 100%);
            --button-hover: linear-gradient(90deg, #00c6ff 0%, #007bff 100%);
            --error-red: #dc3545;
            --label-color: #888;
        }

        body {
            font-family: 'Roboto', sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            background: linear-gradient(135deg, #4CAF50, #2196F3); /* Nền gradient xanh lá sang xanh dương */
            /* Hoặc dùng hình nền khác: */
            /* background-image: url('https://source.unsplash.com/random/1920x1080?abstract'); */
            /* background-size: cover; */
            /* background-position: center; */
            position: relative;
            overflow: hidden; /* Ngăn cuộn */
        }

        /* Hiệu ứng hạt (Particle effect - tùy chọn, có thể bỏ nếu không cần) */
        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: radial-gradient(circle at top left, rgba(255,255,255,0.1) 0%, transparent 50%),
                        radial-gradient(circle at bottom right, rgba(255,255,255,0.1) 0%, transparent 50%);
            z-index: 0;
            animation: moveParticles 20s linear infinite;
        }

        @keyframes moveParticles {
            0% { background-position: 0% 0%; }
            100% { background-position: 100% 100%; }
        }

        .login-container {
            background: var(--glass-bg);
            border: 1.5px solid var(--glass-border);
            backdrop-filter: blur(18px) saturate(1.2);
            border-radius: 28px;
            box-shadow: 0 10px 40px 0 rgba(31, 38, 135, 0.25);
            padding: 48px 38px 38px 38px;
            width: 100%;
            max-width: 410px;
            text-align: center;
            z-index: 1;
            animation: fadeInSlideUp 0.8s cubic-bezier(.4,1.4,.6,1) forwards;
            margin: 0 auto;
        }
        .login-header {
            margin-bottom: 30px;
        }
        .login-header h2 {
            color: var(--primary-blue);
            font-size: 30px;
            font-weight: 800;
            margin: 12px 0 2px 0;
            letter-spacing: 1px;
        }
        .login-header .subtitle {
            color: #555;
            font-size: 16px;
            margin-bottom: 0;
            font-weight: 400;
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
        .login-container form {
            display: flex;
            flex-direction: column;
            gap: 22px;
        }
        .input-group {
            position: relative;
            display: flex;
            align-items: center;
            margin-bottom: 8px;
        }
        .input-group input {
            width: 100%;
            padding: 18px 18px 18px 46px;
            border: 1.5px solid transparent;
            border-radius: 12px;
            background: var(--input-bg);
            color: var(--dark-text);
            font-size: 17px;
            font-weight: 500;
            box-sizing: border-box;
            transition: all 0.3s cubic-bezier(.4,1.4,.6,1);
            box-shadow: 0 2px 8px rgba(0,0,0,0.07);
        }
        .input-group label {
            position: absolute;
            left: 46px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--label-color);
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
            left: 44px;
            font-size: 12px;
            color: var(--primary-blue);
            background: transparent;
        }
        .input-group input::placeholder {
            color: #888;
            font-weight: 400;
        }
        .input-group input:focus {
            border-color: var(--input-border-focus);
            background: #fff;
            box-shadow: 0 0 0 4px rgba(0, 123, 255, 0.13);
            outline: none;
        }
        .input-icon {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            pointer-events: none;
            opacity: 0.7;
        }
        .btn {
            width: 100%;
            padding: 16px;
            background: var(--button-primary);
            color: var(--light-text);
            border: none;
            cursor: pointer;
            border-radius: 12px;
            font-size: 19px;
            font-weight: 700;
            letter-spacing: 1px;
            box-shadow: 0 6px 18px rgba(0, 123, 255, 0.18);
            transition: all 0.25s cubic-bezier(.4,1.4,.6,1);
            position: relative;
            overflow: hidden;
            opacity: 0.5;
            filter: grayscale(0.2);
            pointer-events: none;
        }
        .btn.active {
            opacity: 1;
            filter: none;
            pointer-events: auto;
        }
        .btn:before {
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
        .btn.active:hover:before {
            left: 120%;
        }
        .btn.active:hover {
            background: var(--button-hover);
            transform: translateY(-2px) scale(1.03);
            box-shadow: 0 10px 28px rgba(0, 123, 255, 0.22);
        }
        .btn.active:active {
            transform: scale(0.98);
            box-shadow: 0 4px 10px rgba(0, 123, 255, 0.13);
        }
        @media (max-width: 500px) {
            .login-container {
                margin: 18px;
                padding: 32px 10px 24px 10px;
            }
            .login-header h2 {
                font-size: 23px;
            }
            .input-group input {
                padding: 13px 14px 13px 38px;
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
            .btn {
                padding: 13px;
                font-size: 16px;
            }
        }
    </style>
    <script>
        // Floating label và enable nút đăng nhập khi đủ dữ liệu
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
        <div class="login-container">
            <div class="login-header">
                <svg width="60" height="60" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                  <circle cx="12" cy="12" r="12" fill="#007bff" fill-opacity="0.15"/>
                  <path d="M12 12c1.933 0 3.5-1.567 3.5-3.5S13.933 5 12 5s-3.5 1.567-3.5 3.5S10.067 12 12 12zm0 2c-2.33 0-7 1.167-7 3.5V20h14v-2.5c0-2.333-4.67-3.5-7-3.5z" fill="#007bff"/>
                </svg>
                <h2>Chào mừng trở lại!</h2>
                <p class="subtitle">Đăng nhập để tiếp tục</p>
            </div>
            <% String error = request.getParameter("error"); %>
            <% if (error != null) { %>
            <div class="error-box">
                <svg width="20" height="20" fill="none" viewBox="0 0 24 24"><circle cx="12" cy="12" r="10" fill="#dc3545" fill-opacity="0.15"/><path d="M12 8v4m0 4h.01" stroke="#dc3545" stroke-width="2" stroke-linecap="round"/></svg>
                <span>Sai thông tin đăng nhập. Vui lòng thử lại.</span>
            </div>
            <% } %>
            <form action="login" method="POST" autocomplete="off">
                <div class="input-group">
                    <span class="input-icon">
                        <svg width="22" height="22" fill="none" viewBox="0 0 24 24"><path d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z" fill="#007bff"/></svg>
                    </span>
                    <input type="text" id="username" name="username" required autocomplete="username" placeholder=" " />
                    <label for="username">Tên người dùng</label>
                </div>
                <div class="input-group">
                    <span class="input-icon">
                        <svg width="22" height="22" fill="none" viewBox="0 0 24 24"><path d="M12 17a2 2 0 100-4 2 2 0 000 4zm6-7V7a6 6 0 10-12 0v3a2 2 0 00-2 2v7a2 2 0 002 2h12a2 2 0 002-2v-7a2 2 0 00-2-2zm-8-3a4 4 0 118 0v3H6V7z" fill="#007bff"/></svg>
                    </span>
                    <input type="password" id="password" name="password" required autocomplete="current-password" placeholder=" " />
                    <label for="password">Mật khẩu</label>
                </div>
                <button type="submit" class="btn" id="login-btn">Đăng Nhập</button>
            </form>
        </div>
    </body>
</html>