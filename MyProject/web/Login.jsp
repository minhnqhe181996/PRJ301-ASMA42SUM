<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Đăng Nhập</title>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;700&display=swap" rel="stylesheet">
    </head>
    <style>
        body {
            font-family: 'Inter', sans-serif; /* Sử dụng font Inter */
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #f0f2f5; /* Nền màu xám nhạt hiện đại */
            background-image: url('https://displays.riotgames.com/static/content-original-runeterra-ionia-3af5494dd645cb673dc4cedc2d3458b1.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            position: relative; /* Quan trọng để overlay hoạt động */
        }

        /* Lớp phủ (overlay) để làm mờ và tối hình nền, giúp form nổi bật */
        body::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.4); /* Màu đen trong suốt */
            backdrop-filter: blur(6px); /* Làm mờ hình nền */
            z-index: 1;
        }

        .login-container {
            background: rgba(255, 255, 255, 0.98); /* Nền trắng gần như đục, hơi trong suốt */
            padding: 40px;
            border-radius: 16px; /* Bo tròn góc mạnh hơn */
            box-shadow: 0 12px 25px rgba(0, 0, 0, 0.1); /* Đổ bóng mềm mại, sâu hơn */
            width: 340px; /* Chiều rộng lớn hơn một chút */
            text-align: center;
            z-index: 2; /* Đảm bảo container nằm trên lớp overlay */
            transition: all 0.3s ease-in-out; /* Hiệu ứng chuyển động nhẹ */
        }

        .login-container:hover {
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.15); /* Đổ bóng sâu hơn khi hover */
        }

        .login-container h2 {
            color: #333d47; /* Màu chữ tiêu đề xanh xám đậm */
            margin-bottom: 25px;
            font-size: 30px; /* Kích thước tiêu đề lớn hơn */
            font-weight: 700; /* Tiêu đề đậm */
        }

        input {
            width: 100%;
            padding: 14px; /* Tăng padding */
            margin: 10px 0; /* Giảm margin dọc để form gọn hơn */
            border: 1px solid #e0e0e0; /* Viền mỏng, màu nhẹ */
            border-radius: 10px; /* Bo tròn góc input nhiều hơn */
            font-size: 16px; /* Kích thước chữ input lớn hơn */
            box-sizing: border-box; /* Rất quan trọng để không bị lệch khi padding */
            transition: border-color 0.3s ease, box-shadow 0.3s ease; /* Hiệu ứng chuyển động mượt */
        }

        input:focus {
            border-color: #007bff; /* Viền xanh dương khi focus */
            box-shadow: 0 0 0 4px rgba(0, 123, 255, 0.2); /* Đổ bóng nhẹ khi focus */
            outline: none; /* Bỏ viền outline mặc định */
        }

        .login-container form {
            display: flex;
            flex-direction: column;
            gap: 15px; /* Tăng khoảng cách đều giữa các trường */
        }

        .btn {
            width: 100%;
            padding: 16px; /* Tăng padding nút */
            background-color: #28a745; /* Màu xanh lá cây tươi mới cho nút đăng nhập */
            color: white;
            border: none;
            cursor: pointer;
            border-radius: 10px; /* Bo tròn góc nút nhiều hơn */
            font-size: 18px; /* Kích thước chữ nút lớn hơn */
            font-weight: bold; /* Chữ nút đậm */
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1); /* Đổ bóng nhẹ cho nút */
            transition: background-color 0.3s ease, transform 0.2s ease, box-shadow 0.3s ease;
        }

        .btn:hover {
            background-color: #218838; /* Màu xanh đậm hơn khi hover */
            transform: translateY(-2px); /* Hiệu ứng nhấc nhẹ nút */
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15); /* Đổ bóng sâu hơn khi hover */
        }

        .error {
            color: #dc3545; /* Màu đỏ cảnh báo rõ ràng */
            font-size: 14px;
            margin-top: 10px; /* Khoảng cách trên lỗi */
            font-weight: 500;
        }
    </style>
    <body>
        <div class="login-container">
            <h2>Đăng Nhập</h2>
            <% String error = request.getParameter("error"); %>
            <% if (error != null) { %>
            <p class="error">Sai thông tin đăng nhập. Vui lòng thử lại.</p>
            <% } %>
            <form action="login" method="POST">
                <input type="text" name="username" placeholder="Tên đăng nhập" required>
                <input type="password" name="password" placeholder="Mật khẩu" required>
                <button type="submit" class="btn">Đăng Nhập</button>
            </form>
        </div>
    </body>
</html>