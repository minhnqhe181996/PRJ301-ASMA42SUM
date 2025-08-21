<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Trang Manager</title>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    </head>
    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --secondary-gradient: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%);
            --accent-gradient: linear-gradient(135deg, #fa709a 0%, #fee140 100%);
            --manager-gradient: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            --logout-gradient: linear-gradient(135deg, #ff7043 0%, #e64a19 100%);
            --glass-bg: rgba(255, 255, 255, 0.15);
            --glass-border: rgba(255, 255, 255, 0.25);
            --text-primary: #1a1a1a;
            --text-secondary: #64748b;
            --text-light: #ffffff;
            --shadow-soft: 0 8px 32px rgba(0, 0, 0, 0.1);
            --shadow-hover: 0 12px 48px rgba(0, 0, 0, 0.15);
            --blur-amount: 20px;
        }
        *{
            margin:0;
            padding:0;
            box-sizing:border-box
        }
        body{
            font-family:'Inter',sans-serif;
            min-height:100vh;
            background:linear-gradient(135deg,#667eea 0%,#764ba2 50%,#f093fb 100%);
            background-size:400% 400%;
            animation:gradientShift 15s ease infinite;
            display:flex;
            justify-content:center;
            align-items:center;
            padding:20px;
            position:relative;
            overflow:hidden;
        }
        @keyframes gradientShift{
            0%{
                background-position:0% 50%
            }
            50%{
                background-position:100% 50%
            }
            100%{
                background-position:0% 50%
            }
        }
        body::before{
            content:'';
            position:absolute;
            inset:0;
            background: radial-gradient(circle at 20% 20%, rgba(255,255,255,0.1) 0%, transparent 50%),
                radial-gradient(circle at 80% 80%, rgba(255,255,255,0.1) 0%, transparent 50%),
                radial-gradient(circle at 40% 60%, rgba(255,255,255,0.05) 0%, transparent 50%);
            animation:floatingOrbs 20s linear infinite;
            z-index:0;
        }
        @keyframes floatingOrbs{
            0%{
                transform:translateY(0) rotate(0)
            }
            50%{
                transform:translateY(-20px) rotate(180deg)
            }
            100%{
                transform:translateY(0) rotate(360deg)
            }
        }
        .container{
            background:var(--glass-bg);
            border:1px solid var(--glass-border);
            backdrop-filter:blur(var(--blur-amount));
            border-radius:24px;
            box-shadow:var(--shadow-soft);
            padding:40px;
            width:100%;
            max-width:480px;
            position:relative;
            z-index:1;
            animation:containerFadeIn 1s cubic-bezier(0.4,0,0.2,1);
            text-align:center;
        }
        @keyframes containerFadeIn{
            from{
                opacity:0;
                transform:translateY(40px) scale(0.95);
                filter:blur(10px)
            }
            to{
                opacity:1;
                transform:translateY(0) scale(1);
                filter:blur(0)
            }
        }
        .logout-button{
            position:absolute;
            top:20px;
            left:20px;
            background:var(--logout-gradient);
            color:var(--text-light);
            border:none;
            padding:12px 20px;
            font-size:14px;
            font-weight:600;
            border-radius:12px;
            cursor:pointer;
            box-shadow:var(--shadow-soft);
            transition:all .3s cubic-bezier(0.4,0,0.2,1);
            display:flex;
            align-items:center;
            gap:8px;
            z-index:2;
        }
        .logout-button:hover{
            transform:translateY(-2px);
            box-shadow:var(--shadow-hover)
        }
        .logout-button:active{
            transform:translateY(0);
            box-shadow:var(--shadow-soft)
        }
        .custom-button{
            display:flex;
            align-items:center;
            justify-content:space-between;
            background:var(--glass-bg);
            border:1px solid var(--glass-border);
            backdrop-filter:blur(10px);
            padding:24px;
            border-radius:16px;
            cursor:pointer;
            width:100%;
            box-shadow:var(--shadow-soft);
            transition:all .3s cubic-bezier(0.4,0,0.2,1);
            position:relative;
            overflow:hidden;
            margin:15px 0;
        }
        .custom-button::before{
            content:'';
            position:absolute;
            top:0;
            left:-100%;
            width:100%;
            height:100%;
            background:linear-gradient(90deg, transparent, rgba(255,255,255,.1), transparent);
            transition:left .5s cubic-bezier(0.4,0,0.2,1)
        }
        .custom-button:hover::before{
            left:100%
        }
        .custom-button:hover{
            transform:translateY(-4px);
            box-shadow:var(--shadow-hover);
            border-color:rgba(255,255,255,.4)
        }
        .custom-button:active{
            transform:translateY(-2px)
        }
        .custom-button:first-child .button-content .button-icon{
            background:var(--secondary-gradient)
        }
        .custom-button:nth-child(2) .button-content .button-icon{
            background:var(--accent-gradient)
        }
        .custom-button:last-child .button-content .button-icon{
            background:var(--manager-gradient)
        }
        .button-content{
            display:flex;
            align-items:center;
            gap:16px;
            width:100%
        }
        .button-icon{
            width:48px;
            height:48px;
            border-radius:12px;
            background:var(--primary-gradient);
            display:flex;
            align-items:center;
            justify-content:center;
            font-size:20px;
            color:var(--text-light);
            box-shadow:0 4px 12px rgba(0,0,0,.15);
            transition:all .3s cubic-bezier(0.4,0,0.2,1);
        }
        .custom-button:hover .button-icon{
            transform:scale(1.1) rotate(5deg)
        }
        .button-text{
            flex:1;
            text-align:left
        }
        .button-title{
            font-size:18px;
            font-weight:600;
            color:var(--text-primary);
            margin-bottom:4px
        }
        .button-description{
            font-size:14px;
            color:var(--text-secondary);
            opacity:.8
        }
        .button-arrow{
            font-size:20px;
            color:var(--text-secondary);
            transition:all .3s cubic-bezier(0.4,0,0.2,1)
        }
        .custom-button:hover .button-arrow{
            transform:translateX(8px);
            color:var(--text-primary)
        }
        @media (max-width:600px){
            .container{
                padding:30px 20px;
                margin:10px
            }
            .custom-button{
                padding:20px
            }
            .button-title{
                font-size:16px
            }
            .button-description{
                font-size:13px
            }
            .logout-button{
                top:15px;
                left:15px;
                padding:10px 16px;
                font-size:13px
            }
        }
        .custom-button::after{
            content:'';
            position:absolute;
            bottom:0;
            left:0;
            width:0;
            height:2px;
            background:var(--primary-gradient);
            transition:width .3s cubic-bezier(0.4,0,0.2,1)
        }
        .custom-button:hover::after{
            width:100%
        }
    </style>
    <body>
        <button class="logout-button" onclick="window.location.href = '${pageContext.request.contextPath}/logout'">
            <i class="fas fa-sign-out-alt"></i> Logout
        </button>
        <div class="container">
            <!-- Tạo đơn -->
            <button class="custom-button" onclick="window.location.href = 'Form.jsp'">
                <div class="button-content">
                    <div class="button-icon"><i class="fas fa-file-circle-plus"></i></div>
                    <div class="button-text">
                        <div class="button-title">Tạo Đơn Xin Nghỉ Phép</div>
                        <div class="button-description">Tạo đơn xin nghỉ phép mới</div>
                    </div>
                    <div class="button-arrow"><i class="fas fa-arrow-right"></i></div>
                </div>
            </button>

            <!-- Xem đơn của tôi -->
            <button class="custom-button" onclick="window.location.href = '${pageContext.request.contextPath}/View'">
                <div class="button-content">
                    <div class="button-icon"><i class="fas fa-file-alt"></i></div>
                    <div class="button-text">
                        <div class="button-title">Xem đơn của tôi</div>
                        <div class="button-description">Theo dõi trạng thái đơn đã gửi</div>
                    </div>
                    <div class="button-arrow"><i class="fas fa-arrow-right"></i></div>
                </div>
            </button>

            <!-- Xét duyệt đơn -->
            <button class="custom-button" onclick="window.location.href = '${pageContext.request.contextPath}/Management'">
                <div class="button-content">
                    <div class="button-icon"><i class="fas fa-users-cog"></i></div>
                    <div class="button-text">
                        <div class="button-title">Xét Duyệt đơn Employee</div>
                        <div class="button-description">Quản lý đơn xin nghỉ phép của nhóm</div>
                    </div>
                    <div class="button-arrow"><i class="fas fa-arrow-right"></i></div>
                </div>
            </button>

            <!-- MỤC MỚI: Xem điểm danh nhân viên -->
            <button class="custom-button" onclick="window.location.href = '${pageContext.request.contextPath}/attendance/manage'">
                <div class="button-content">
                    <div class="button-icon"><i class="fas fa-clipboard-list"></i></div>
                    <div class="button-text">
                        <div class="button-title">Điểm danh nhân viên</div>
                        <div class="button-description">Xem check‑in / check‑out của nhân viên trong nhóm</div>
                    </div>
                    <div class="button-arrow"><i class="fas fa-arrow-right"></i></div>
                </div>
            </button>
        </div>
    </body>
</html>
