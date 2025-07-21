<%-- 
    Document   : dk_thuong_tru
    Created on : Mar 5, 2025, 8:33:12 PM
    Author     : LENOVO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Users" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Quản lý hệ thống cư trú</title>
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <meta content="" name="keywords">
        <meta content="" name="description">
        <link href="img/hero-img-1.png" rel="icon">
        <!-- Google Web Fonts -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link
            href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@500;600;700&family=Rubik:wght@400;500&display=swap"
            rel="stylesheet">

        <!-- Icon Font Stylesheet -->
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">


        <link href="lib/animate/animate.min.css" rel="stylesheet">
        <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
        <link href="lib/lightbox/css/lightbox.min.css" rel="stylesheet">



        <link href="css/bootstrap.min.css" rel="stylesheet">


        <link href="css/style.css" rel="stylesheet">

    </head>
    <body>

        <jsp:include page="header_user.jsp" />
        <!-- Navbar & Hero End -->


        <!-- Header Start -->
        <div class="container-fluid bg-breadcrumb">
            <ul class="breadcrumb-animation">
                <li></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
            </ul>
            <div class="container text-center py-5" style="max-width: 900px;">
                <h3 class="display-3 mb-4 wow fadeInDown" data-wow-delay="0.1s">Đăng Ký Tạm Trú</h3>
                <ol class="breadcrumb justify-content-center mb-0 wow fadeInDown" data-wow-delay="0.3s">
                    <li class="breadcrumb-item"><a href="User">Trang chủ</a></li>
                    <li class="breadcrumb-item"><a href="#">Dịch vụ công</a></li>
                    <li class="breadcrumb-item active text-primary">Đăng ký thường trú</li>
                </ol>
            </div>
        </div>
        <!-- Header End -->


        <!-- Hướng dẫn đăng ký thường trú -->
        <div class="container py-5">
            <h2 class="text-center mb-4">Hướng dẫn đăng ký tạm trú chi tiết</h2>
            <p>Việc đăng ký tạm trú là một thủ tục quan trọng giúp đảm bảo quyền lợi của bạn khi sinh sống tại địa phương. Dưới đây là hướng dẫn chi tiết từng bước:</p>
            <ul class="list-group">
                <li class="list-group-item"><b>Bước 1:</b> <b>Chuẩn bị hồ sơ</b>
                    <ul>
                        <li>CMND/CCCD hoặc hộ chiếu (bản gốc và bản sao).</li>
                        <li>Giấy tờ chứng minh chỗ ở hợp pháp (hợp đồng thuê nhà, giấy xác nhận của chủ nhà hoặc sổ đỏ).</li>
                        <li>Phiếu báo thay đổi hộ khẩu, nhân khẩu (theo mẫu).</li>
                        <li>Ảnh chân dung 3x4 (nền trắng).</li>
                    </ul>
                </li>
                <li class="list-group-item"><b>Bước 2:</b> <b>Truy cập hệ thống và đăng nhập</b>
                    <ul>
                        <li>Truy cập vào cổng dịch vụ công trực tuyến.</li>
                        <li>Đăng nhập bằng tài khoản cá nhân hoặc tạo tài khoản mới.</li>
                    </ul>
                </li>
                <li class="list-group-item"><b>Bước 3:</b> <b>Điền thông tin đăng ký</b>
                    <ul>
                        <li>Họ và tên, ngày tháng năm sinh, số CMND/CCCD.</li>
                        <li>Địa chỉ tạm trú cụ thể (số nhà, đường, phường/xã, quận/huyện, tỉnh/thành phố).</li>
                        <li>Thời gian dự kiến tạm trú (từ ngày, đến ngày).</li>
                        <li>Thông tin liên hệ: số điện thoại, email.</li>
                    </ul>
                </li>
                <li class="list-group-item"><b>Bước 4:</b> <b>Tải lên hồ sơ đính kèm</b>
                    <ul>
                        <li>Chọn và tải lên bản scan/ảnh chụp các giấy tờ cần thiết.</li>
                        <li>Đảm bảo các tài liệu rõ nét, đầy đủ thông tin.</li>
                    </ul>
                </li>
                <li class="list-group-item"><b>Bước 5:</b> <b>Kiểm tra và xác nhận thông tin</b>
                    <ul>
                        <li>Xem lại toàn bộ thông tin đã nhập.</li>
                        <li>Chỉnh sửa nếu cần thiết để đảm bảo chính xác.</li>
                        <li>Nhấn nút "Gửi hồ sơ" để hoàn tất.</li>
                    </ul>
                </li>
                <li class="list-group-item"><b>Bước 6:</b> <b>Theo dõi kết quả và nhận giấy xác nhận</b>
                    <ul>
                        <li>Theo dõi trạng thái hồ sơ trực tuyến.</li>
                        <li>Nhận thông báo qua email hoặc tin nhắn khi hồ sơ được duyệt.</li>
                        <li>Đến cơ quan công an để nhận giấy xác nhận tạm trú (hoặc nhận bản mềm qua email nếu được hỗ trợ).</li>
                    </ul>
                </li>
            </ul>
            <p class="mt-4">Lưu ý: Thời gian xử lý hồ sơ thường từ 3-5 ngày làm việc. Nếu có bất kỳ vướng mắc nào, bạn có thể liên hệ tổng đài hỗ trợ hoặc trực tiếp đến cơ quan công an gần nhất để được giải đáp.</p>
        </div>

        <!-- Đăng ký thường trú trực tuyến -->
        <div class="container text-center py-5">
            <h2 class="mb-4">Đăng ký thường trú trực tuyến</h2>
            <p class="mb-4">Hãy sử dụng dịch vụ đăng ký thường trú trực tuyến để tiết kiệm thời gian và đơn giản hóa thủ tục. Hệ thống sẽ hướng dẫn bạn từng bước và thông báo ngay khi hồ sơ được xử lý thành công. Vui lòng nhấn vào nút bên dưới để bắt đầu quá trình đăng ký.</p>
            <a href="Registration?action=formtr" class="btn btn-primary d-inline rounded-pill px-5 py-3">Đăng ký ngay</a>
            <a href="User" class="btn btn-secondary d-inline rounded-pill px-5 py-3 ms-3">Quay lại trang chủ</a>
        </div>



        <!-- Footer Start -->
        <jsp:include page="footer_user.jsp" />
        <!-- Footer End -->





        <!-- Back to Top -->
        <a href="#" class="btn btn-primary btn-lg-square back-to-top"><i class="fa fa-arrow-up"></i></a>   


        <!-- JavaScript Libraries -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="lib/wow/wow.min.js"></script>
        <script src="lib/easing/easing.min.js"></script>
        <script src="lib/waypoints/waypoints.min.js"></script>
        <script src="lib/counterup/counterup.min.js"></script>
        <script src="lib/owlcarousel/owl.carousel.min.js"></script>
        <script src="lib/lightbox/js/lightbox.min.js"></script>


        <!-- Template Javascript -->
        <script src="js/main.js"></script>
    </body>
</html>
